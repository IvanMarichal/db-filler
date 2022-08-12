initializer(){
    echo -e "\n--$parameter\n-----------------------------------------------------------------------------------------\n\n\n-----------------------------------------------------------------------------------------\n\n\n" >> sql_script2.txt
    number_table_start=$(cat sql_script2.txt | grep -n $parameter | cut -d ":" -f1 | head -1)
    number_table_end=$(($number_table_start + 4))
}

subscription () {

    #Checks where the table section starts and ends
    parameter="subscription"
    initializer
    
    
    for ((h = 0 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        sed -i "$(($number_table_end - 1)) i INSERT INTO $parameter (id, description) VALUES ($(($h+1)), 'Lorem ipsum dolor sit amet')" sql_script2.txt
    done

}

subscription_type () {

    #Checks where the table section starts and ends
    parameter="subscription_type"
    initializer
    
    
    for ((h = 0 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        sed -i "$(($number_table_end - 1)) i INSERT INTO $parameter (id, type) VALUES ($(($h+1)), 'Lorem ipsum dolor sit amet')" sql_script2.txt
    done

}

country () {
    
    #Checks where the table section starts and ends
    parameter="country"
    initializer
    
    
    for ((h = 0 ; h < 197; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        country=$(awk "NR==$h" countries.txt)
        sed -i "$(($number_table_end - 1)) i INSERT INTO $parameter(id, country, country_flag_link) VALUES ($(($h+1)), '$country', 'img/flags/$country.jpg')" sql_script2.txt
    done

}

user () {
    
    #Checks where the table section starts and ends
    parameter="user"
    initializer
    
    
    for ((h = 0 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
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
        sed -i "$(($number_table_end - 1)) i INSERT INTO $parameter (id, name, surname, birth_date, is_admin, password, id_suscription, id_country) VALUES ($(($h+1)), '$name', '$surname', '$year-$month-$day', FALSE, '$password', $h, $random_country_id)" sql_script2.txt
    done

}


clear
echo "1- Fill the whole database"
echo "0- Exit"
read -p "Choose an option: " option
    case $option in
            1)read -p "How many rows: " rows
            touch sql_script2.txt
            rows2=$(($rows + 1))
            subscription
            subscription_type
            country
            user
            sleep 2
            clear
            exit;;
            0)exit;;

    esac