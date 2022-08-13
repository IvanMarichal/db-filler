initializer(){
    echo -e "\n--$parameter\n-----------------------------------------------------------------------------------------\n\n\n-----------------------------------------------------------------------------------------\n\n\n" >> sql_script.txt
    number_table_start=$(cat sql_script.txt | grep -n $parameter | cut -d ":" -f1 | head -1)
    number_table_end=$(($number_table_start + 4))
}

subscription () {

    #Checks where the table section starts and ends
    parameter="subscription"
    initializer
    
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id, description) VALUES ($h, 'Lorem ipsum dolor sit amet')" sql_script.txt
    done

}

subscription_type () {

    #Checks where the table section starts and ends
    parameter="subscription_type"
    initializer
    
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id, type) VALUES ($h, 'Lorem ipsum dolor sit amet')" sql_script.txt
    done

}

country () {
    
    #Checks where the table section starts and ends
    parameter="country"
    initializer
    
    
    for ((h = 1 ; h < 197; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        country=$(awk "NR==$h" countries.txt)
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter(id, country, country_flag_link) VALUES ($h, '$country', 'img/flags/$country.jpg')" sql_script.txt
    done

}

user () {
    
    #Checks where the table section starts and ends
    parameter="user"
    initializer
    
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        name=$(awk "NR==$(($RANDOM%18240))" names.txt)
        surname=$(awk "NR==$(($(($RANDOM%88800-2))+1))" surnames.txt) #expression to define limits of random number
        year=$(($(($RANDOM%121))+1900)) #working vs is wrong
        month=$(($(($RANDOM%10))+1))
        day=$(($(($RANDOM%29))+1))
        password=$(openssl rand -base64 10)
        random_country_id=$(($(($RANDOM%194))+1))
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id, name, surname, birth_date, is_admin, password, id_suscription, id_country) VALUES ($h, '$name', '$surname', '$year-$month-$day', FALSE, '$password', $h, $random_country_id)" sql_script.txt
    done

}


user_avatar_link () {
    
    #Checks where the table section starts and ends
    parameter="user_avatar_link"
    initializer
    
    user_table_start=$(cat sql_script.txt | grep -n user | cut -d ":" -f1 | head -1)
    user_table_end=$(($user_table_start + $rows2 + 4))
    total_lines=$(wc -l sql_script.txt | cut -d " " -f1)
    cat sql_script.txt | tail -n $(($total_lines-$user_table_start-2)) | head -n $(($user_table_end-$user_table_start-4)) > temp_user.txt
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        name=$(awk "NR==$h" temp_user.txt | cut -d " " -f14)
        name=${name:1:-2}
        surname=$(awk "NR==$h" temp_user.txt | cut -d " " -f15)
        surname=${surname:1:-2}
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_user, avatar_link) VALUES ($h, 'img/avatars/$name-$surname.jpg')" sql_script.txt
    done
    rm temp_user.txt
}


user_email () {
    
    #Checks where the table section starts and ends
    parameter="user_email"
    initializer
    
    user_table_start=$(cat sql_script.txt | grep -n user | cut -d ":" -f1 | head -1)
    user_table_end=$(($user_table_start + $rows2 + 4))
    total_lines=$(wc -l sql_script.txt | cut -d " " -f1)
    cat sql_script.txt | tail -n $(($total_lines-$user_table_start-2)) | head -n $(($user_table_end-$user_table_start-4)) > temp_user.txt
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        domain="gmail.com"

        #insert data
        name=$(awk "NR==$h" temp_user.txt | cut -d " " -f14)
        name=${name:1:-2}
        surname=$(awk "NR==$h" temp_user.txt | cut -d " " -f15)
        surname=${surname:1:-2}
        if [[ $h%3 -eq  0 ]] #to randomize but not rlly
        then
        domain="hotmail.com"
        fi
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_user, email) VALUES ($h, '$name$surname@$domain')" sql_script.txt
    done
    rm temp_user.txt
}


card () {
    
    #Checks where the table section starts and ends
    parameter="card"
    initializer
    

    user_table_start=$(cat sql_script.txt | grep -n user | cut -d ":" -f1 | head -1)
    user_table_end=$(($user_table_start + $rows2 + 4))
    total_lines=$(wc -l sql_script.txt | cut -d " " -f1)
    cat sql_script.txt | tail -n $(($total_lines-$user_table_start-2)) | head -n $(($user_table_end-$user_table_start-4)) > temp_user.txt
    
    aux=0
    payment_system=" "

    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))


        #insert data

        name=$(awk "NR==$h" temp_user.txt | cut -d " " -f14)
        name=${name:1:-2}
        surname=$(awk "NR==$h" temp_user.txt | cut -d " " -f15)
        surname=${surname:1:-2}
        
        year=$(shuf -i 23-33 -n 1) #random doesn't work here idk why, i've tried everything
        month=$(($RANDOM%12 + 1))
        security_code=$(($RANDOM%900+100))
        aux=$(($RANDOM%3+1))
        if [[ $aux -eq 1 ]]
        then
        payment_system="Credit card"
        elif [[ $aux -eq 2 ]]
        then
        payment_system="Debit card"
        elif [[ $aux -eq 3 ]]
        then
        payment_system="Prepaid card"
        fi
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id, expiration_date, security_code, cardholder, payment_system) VALUES ($h, '$year-$month', $security_code, '$name $surname', '$payment_system')" sql_script.txt
    done
    rm temp_user.txt
}


clear
echo "1- Fill the whole database"
echo "0- Exit"
read -p "Choose an option: " option
    case $option in
            1)read -p "How many rows: " rows
            touch sql_script.txt
            rows2=$(($rows + 1))
            subscription
            subscription_type
            country
            user
            user_avatar_link
            user_email
            card
            sleep 2
            clear
            exit;;
            0)exit;;

    esac