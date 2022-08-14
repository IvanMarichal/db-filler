initializer(){
    echo -e "\n--$parameter--\n-----------------------------------------------------------------------------------------\n\n\n-----------------------------------------------------------------------------------------\n\n\n" >> sql_script.txt
    number_table_start=$(cat sql_script.txt | grep -n $parameter-- | cut -d ":" -f1 | head -1)
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
    
    
    for ((h = 1 ; h < 192; h++)) #repeat procces as many times as indicated
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
        name=$(awk "NR==$(shuf -i 1-18239 -n 1)" names.txt)
        surname=$(awk "NR==$(shuf -i 1-88799 -n 1)" surnames.txt) 
        year=$(shuf -i 1950-2012 -n 1) 
        month=$(shuf -i 1-12 -n 1)
        day=$(shuf -i 1-31 -n 1)
        password=$(openssl rand -base64 10)
        random_country_id=$(shuf -i 1-191 -n 1)
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
        
        year=$(shuf -i 23-33 -n 1) 
        month=$(shuf -i 1-12 -n 1)
        security_code=$(shuf -i 100-999 -n 1)
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


card_number_card () {
    
    #Checks where the table section starts and ends
    parameter="card_number_card"
    initializer
    

    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        card_number=$(shuf -i 1000000000000000-9999999999999999 -n 1) 
        
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_card, card_number) VALUES ($h, $card_number)" sql_script.txt
    done
    
}


user_card () {
    
    #Checks where the table section starts and ends
    parameter="user_card"
    initializer
    

    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
    
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_card, id_user) VALUES ($h, $h)" sql_script.txt
    done
    
}


player () {
    
    #Checks where the table section starts and ends
    parameter="player"
    initializer
    
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        name=$(awk "NR==$(shuf -i 1-18239 -n 1)" names.txt)
        surname=$(awk "NR==$(shuf -i 1-88799 -n 1)" surnames.txt)
        year=$(shuf -i 1980-2012 -n 1) 
        month=$(shuf -i 1-12 -n 1)
        day=$(shuf -i 1-31 -n 1)
        height=$(shuf -i 165-220 -n 1) #cm
        weight=$(shuf -i 60-100 -n 1) #kilos
        random_country_id=$(shuf -i 1-191 -n 1)
        nationality=$(awk "NR==$random_country_id" nationalities.txt)
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id, name, surname, birth_date, height, weight, id_country, nationality) VALUES ($h, '$name', '$surname', '$year-$month-$day', $height, $weight, $random_country_id, '$nationality')" sql_script.txt
    done

}


player_avatar_link () {
    
    #Checks where the table section starts and ends
    parameter="player_avatar_link"
    initializer
    
    user_table_start=$(cat sql_script.txt | grep -n player | cut -d ":" -f1 | head -1)
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
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_player, avatar_link) VALUES ($h, 'img/avatars/$name-$surname.jpg')" sql_script.txt
    done
    rm temp_user.txt
}


referee () {
    
    #Checks where the table section starts and ends
    parameter="referee"
    initializer
    
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        name=$(awk "NR==$(shuf -i 1-18239 -n 1)" names.txt)
        surname=$(awk "NR==$(shuf -i 1-88799 -n 1)" surnames.txt)
        year=$(shuf -i 1960-2000 -n 1) 
        month=$(shuf -i 1-12 -n 1)
        day=$(shuf -i 1-31 -n 1)
        random_country_id=$(shuf -i 1-191 -n 1)
        nationality=$(awk "NR==$random_country_id" nationalities.txt)
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id, name, surname, birth_date, id_country, nationality) VALUES ($h, '$name', '$surname', '$year-$month-$day', $random_country_id, '$nationality')" sql_script.txt
    done

}


referee_avatar_link () {
    
    #Checks where the table section starts and ends
    parameter="referee_avatar_link"
    initializer
    
    user_table_start=$(cat sql_script.txt | grep -n referee | cut -d ":" -f1 | head -1)
    user_table_end=$(($user_table_start + $rows2 + 4))
    total_lines=$(wc -l sql_script.txt | cut -d " " -f1)
    cat sql_script.txt | tail -n $(($total_lines-$user_table_start-2)) | head -n $(($user_table_end-$user_table_start-4)) > temp_user.txt
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        name=$(awk "NR==$h" temp_user.txt | cut -d " " -f12)
        name=${name:1:-2}
        surname=$(awk "NR==$h" temp_user.txt | cut -d " " -f13)
        surname=${surname:1:-2}
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_referee, avatar_link) VALUES ($h, 'img/avatars/$name-$surname.jpg')" sql_script.txt
    done
    rm temp_user.txt
}


manager () {
    
    #Checks where the table section starts and ends
    parameter="manager"
    initializer
    
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        name=$(awk "NR==$(shuf -i 1-18239 -n 1)" names.txt)
        surname=$(awk "NR==$(shuf -i 1-88799 -n 1)" surnames.txt)
        year=$(shuf -i 1960-2000 -n 1) 
        month=$(shuf -i 1-12 -n 1)
        day=$(shuf -i 1-31 -n 1)
        random_country_id=$(shuf -i 1-191 -n 1)
        nationality=$(awk "NR==$random_country_id" nationalities.txt)
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id, name, surname, id_country, birth_date, nationality) VALUES ($h, '$name', '$surname', $random_country_id, '$year-$month-$day', '$nationality')" sql_script.txt
    done

}


manager_avatar_link () {
    
    #Checks where the table section starts and ends
    parameter="manager_avatar_link"
    initializer
    
    user_table_start=$(cat sql_script.txt | grep -n manager | cut -d ":" -f1 | head -1)
    user_table_end=$(($user_table_start + $rows2 + 4))
    total_lines=$(wc -l sql_script.txt | cut -d " " -f1)
    cat sql_script.txt | tail -n $(($total_lines-$user_table_start-2)) | head -n $(($user_table_end-$user_table_start-4)) > temp_user.txt
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        name=$(awk "NR==$h" temp_user.txt | cut -d " " -f12)
        name=${name:1:-2}
        surname=$(awk "NR==$h" temp_user.txt | cut -d " " -f13)
        surname=${surname:1:-2}
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_manager, avatar_link) VALUES ($h, 'img/avatars/$name-$surname.jpg')" sql_script.txt
    done
    rm temp_user.txt
}


sport () {
    
    #Checks where the table section starts and ends
    parameter="sport"
    initializer
    

    
    for ((h = 1 ; h < $(($(wc -l sports.txt | cut -d " " -f1)+1)) ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        referees_by_event=$(awk "NR==$h" sports.txt | cut -d ":" -f2)
        players_by_team=$(awk "NR==$h" sports.txt | cut -d ":" -f3)
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id, referees_by_event, players_by_team) VALUES ($h, $referees_by_event, $players_by_team)" sql_script.txt
    done
   
}


sport_name () {
    
    #Checks where the table section starts and ends
    parameter="sport_name"
    initializer
    

    
    for ((h = 1 ; h < $(($(wc -l sports.txt | cut -d " " -f1)+1)) ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        sport=$(awk "NR==$h" sports.txt | cut -d ":" -f1)
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id, name) VALUES ($h, '$sport')" sql_script.txt
    done
   
}


league () {
    
    #Checks where the table section starts and ends
    parameter="league"
    initializer
    

    
    for ((h = 1 ; h < $(($(wc -l leagues.txt | cut -d " " -f1)+1)) ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        league=$(awk "NR==$h" leagues.txt | cut -d ":" -f1)
        id_country=$(awk "NR==$h" leagues.txt | cut -d ":" -f2)
        id_sport=$(awk "NR==$h" leagues.txt | cut -d ":" -f3)
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id, name, id_country, id_sport) VALUES ($h, '$league', $id_country, $id_sport)" sql_script.txt
    done
   
}


league_logo_link () {
    
    #Checks where the table section starts and ends
    parameter="league_logo_link"
    initializer
    

    
    for ((h = 1 ; h < $(($(wc -l leagues.txt | cut -d " " -f1)+1)) ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        league=$(awk "NR==$h" leagues.txt | cut -d ":" -f1)
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_league, logo_link) VALUES ($h, 'img/logos/${league// /_}.jpg')" sql_script.txt #${league// /_} is to replace the spaces in the name for _
    done
   
}


user_fav_league () {
    
    #Checks where the table section starts and ends
    parameter="user_fav_league"
    initializer
    
    total_lines_user=$rows
    total_lines_league=$(wc -l leagues.txt | cut -d " " -f1)
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        receive_browser_notifs="FALSE"
        receive_mail_notifs="FALSE"
        if [[ $(shuf -i 1-2 -n 1) -eq 2 ]]
        then
        receive_browser_notifs="TRUE"
        fi
        if [[ $(shuf -i 1-2 -n 1) -eq 2 ]]
        then
        receive_mail_notifs="TRUE"
        fi

        id_user=$(shuf -i 1-$total_lines_user -n 1)
        id_league=$(shuf -i 1-$total_lines_league -n 1)
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_league, id_user, receive_browser_notifs, receive_mail_notifs) VALUES ($id_league, $id_user, $receive_browser_notifs, $receive_mail_notifs)" sql_script.txt
    done
    
}


event () {
    
    #Checks where the table section starts and ends
    parameter="event"
    initializer
    
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        random=$(shuf -i 1-2 -n 1) 
        year=$(shuf -i 2022-2023 -n 1) 
        month=$(shuf -i 1-12 -n 1)
        day=$(shuf -i 1-31 -n 1)
        hour=$(shuf -i 1-12 -n 1)
        minute=$(shuf -i 10-59 -n 1)
        time_="AM"
        if [[ $random -eq 2 ]]
        then
        time_="PM"
        fi
        start_date="$year$month$day $hour:$minute:00 $time_" #i'm not sure if it works in this format
        location=$(awk "NR==$(shuf -i 2-$(wc -l cities.csv | cut -d " " -f1) -n 1)" cities.csv | cut -d "," -f1,2)
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id, start_date, location, venue) VALUES ($h, '$start_date', '$location', 'Lorem ipsum')" sql_script.txt
    done
    
}

rm sql_script.txt
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
            card_number_card
            user_card
            player
            player_avatar_link
            referee
            referee_avatar_link
            manager
            manager_avatar_link
            sport
            sport_name
            league
            league_logo_link
            user_fav_league
            event

            sleep 2
            clear
            exit;;
            0)exit;;

    esac