subscription () {
    
    for ((h = 0 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        #Checks where the table section starts
        number_lines=0
        number_table_start=$(cat sql_script.txt | grep -n subscription | cut -d ":" -f1 | head -1)
        if [ -z "$number_table_start" ]
        then
        aux="-"
        else
        aux=" "
        fi

        #checks where the table section ends
        i=3
        while [[ $aux != "-" ]]
        do
        check_lines=$(( $number_table_start + $i ))
        aux=$(awk "NR==$check_lines" sql_script.txt | cut -c1)
        i=$(( $i + 1 ))
        number_lines=$(( $number_lines + 1 ))
        done


        #insert data
        number_table_end=$(($number_table_start + $number_lines + 2))
        if [ $number_lines -eq 0 ]
        then
        echo -e "\n--subscription\n-----------------------------------------------------------------------------------------\n\n\n-----------------------------------------------------------------------------------------\n" >> sql_script.txt
        else
        sed -i "$(($number_table_end - 1)) i INSERT INTO subscription (id, description) VALUES ($h, 'Lorem ipsum dolor sit amet')" sql_script.txt
        fi



    done

}

subscription_type () {
    
    for ((h = 0 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        #Checks where the table section starts
        number_lines=0
        number_table_start=$(cat sql_script.txt | grep -n subscription_type | cut -d ":" -f1 | head -1)
        if [ -z "$number_table_start" ]
        then
        aux="-"
        else
        aux=" "
        fi

        #checks where the table section ends
        i=3
        while [[ $aux != "-" ]]
        do
        check_lines=$(( $number_table_start + $i ))
        aux=$(awk "NR==$check_lines" sql_script.txt | cut -c1)
        i=$(( $i + 1 ))
        number_lines=$(( $number_lines + 1 ))
        done


        #insert data
        number_table_end=$(($number_table_start + $number_lines + 2))
        if [ $number_lines -eq 0 ]
        then
        echo -e "\n--subscription_type\n-----------------------------------------------------------------------------------------\n\n\n-----------------------------------------------------------------------------------------\n" >> sql_script.txt
        else
        sed -i "$(($number_table_end - 1)) i INSERT INTO subscription_type (id, type) VALUES ($h, 'Lorem ipsum dolor sit amet')" sql_script.txt
        fi



    done

}

country () {
    
    for ((h = 0 ; h < 197 ; h++)) #repeat procces as many times as indicated
    do
        #Checks where the table section starts
        number_lines=0
        number_table_start=$(cat sql_script.txt | grep -n country | cut -d ":" -f1 | head -1)
        if [ -z "$number_table_start" ]
        then
        aux="-"
        else
        aux=" "
        fi

        #checks where the table section ends
        i=3
        while [[ $aux != "-" ]]
        do
        check_lines=$(( $number_table_start + $i ))
        aux=$(awk "NR==$check_lines" sql_script.txt | cut -c1)
        i=$(( $i + 1 ))
        number_lines=$(( $number_lines + 1 ))
        done


        #insert data
        number_table_end=$(($number_table_start + $number_lines + 2))
        if [ $number_lines -eq 0 ]
        then
        echo -e "\n--country\n-----------------------------------------------------------------------------------------\n\n\n-----------------------------------------------------------------------------------------\n" >> sql_script.txt
        else
        country=$(awk "NR==$h" countries.txt)
        sed -i "$(($number_table_end - 1)) i INSERT INTO country (id, country, country_flag_link) VALUES ($h, '$country', 'img/flags/$country.jpg')" sql_script.txt
        fi



    done

}

user () {
    
    for ((h = 0 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        #Checks where the table section starts
        number_lines=0
        number_table_start=$(cat sql_script.txt | grep -n user | cut -d ":" -f1 | head -1)
        if [ -z "$number_table_start" ]
        then
        aux="-"
        else
        aux=" "
        fi

        #checks where the table section ends
        i=3
        while [[ $aux != "-" ]]
        do
        check_lines=$(( $number_table_start + $i ))
        aux=$(awk "NR==$check_lines" sql_script.txt | cut -c1)
        i=$(( $i + 1 ))
        number_lines=$(( $number_lines + 1 ))
        done


        #insert data
        number_table_end=$(($number_table_start + $number_lines + 2))
        if [ $number_lines -eq 0 ]
        then
        echo -e "\n--user\n-----------------------------------------------------------------------------------------\n\n\n-----------------------------------------------------------------------------------------\n" >> sql_script.txt
        else
        name=$(awk "NR==$(($RANDOM%18240))" names.txt)
        surname=$(awk "NR==$(($(($RANDOM%88800-2))+1))" surnames.txt) #expression to define limits of random number
        year=$(($(($RANDOM%121))+1900)) #working vs is wrong
        month=$(($(($RANDOM%10))+1))
        day=$(($(($RANDOM%29))+1))
        password=$(openssl rand -base64 10)
        random_country_id=$(($(($RANDOM%194))+1))
        sed -i "$(($number_table_end - 1)) i INSERT INTO user (id, name, surname, birth_date, is_admin, password, id_suscription, id_country) VALUES ($h, '$name', '$surname', '$year-$month-$day', FALSE, '$password', $h, $random_country_id)" sql_script.txt
        fi



    done

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
            sleep 2
            clear
            exit;;
            0)exit;;



    esac



