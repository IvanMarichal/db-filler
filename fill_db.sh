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
        sed -i "$(($number_table_end - 1)) i INSERT INTO subscription (id, type) VALUES ($h, 'Lorem ipsum dolor sit amet')" sql_script.txt
        fi



    done

}


echo "1- Fill the whole database"
echo "0- Exit"
read -p "Choose an option: " option
    case $option in
            1)read -p "How many rows: " rows
            touch sql_script.txt
            rows2=$(($rows + 1))
            subscription
            subscription_type
            sleep 2
            clear
            exit;;
            0)exit;;



    esac



