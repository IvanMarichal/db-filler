initializer(){
    echo -e "\n--$parameter--\n-----------------------------------------------------------------------------------------\n\n\n-----------------------------------------------------------------------------------------\n\n\n" >> sql_script.txt
    number_table_start=$(cat sql_script.txt | grep -n ^--$parameter--$ | cut -d ":" -f1 | head -1)
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
        type="Basic"
        if [[ $(shuf -i 1-2 -n 1) -eq 2 ]]
        then
        type="Premium"
        fi
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id, type) VALUES ($h, '$type')" sql_script.txt
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

client () {
    
    #Checks where the table section starts and ends
    parameter="client"
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
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id, name, surname, birth_date, is_admin, password, id_subscription, id_country) VALUES ($h, '$name', '$surname', '$year-$month-$day', FALSE, '$password', $h, $random_country_id)" sql_script.txt
    done

}


client_avatar_link () {
    
    #Checks where the table section starts and ends
    parameter="client_avatar_link"
    initializer
    
    client_table_start=$(cat sql_script.txt | grep -n client | cut -d ":" -f1 | head -1)
    client_table_end=$(($client_table_start + $rows2 + 4))
    total_lines=$(wc -l sql_script.txt | cut -d " " -f1)
    cat sql_script.txt | tail -n $(($total_lines-$client_table_start-2)) | head -n $(($client_table_end-$client_table_start-4)) > temp_client.txt
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        name=$(awk "NR==$h" temp_client.txt | cut -d " " -f14)
        name=${name:1:-2}
        surname=$(awk "NR==$h" temp_client.txt | cut -d " " -f15)
        surname=${surname:1:-2}
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_client, avatar_link) VALUES ($h, 'img/avatars/$name-$surname.jpg')" sql_script.txt
    done
    rm temp_client.txt
}


client_user () {
    
    #Checks where the table section starts and ends
    parameter="client_user"
    initializer
    
    client_table_start=$(cat sql_script.txt | grep -n client | cut -d ":" -f1 | head -1)
    client_table_end=$(($client_table_start + $rows2 + 4))
    total_lines=$(wc -l sql_script.txt | cut -d " " -f1)
    cat sql_script.txt | tail -n $(($total_lines-$client_table_start-2)) | head -n $(($client_table_end-$client_table_start-4)) > temp_client.txt
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        domain="gmail.com"

        #insert data
        name=$(awk "NR==$h" temp_client.txt | cut -d " " -f14)
        name=${name:1:-2}
        surname=$(awk "NR==$h" temp_client.txt | cut -d " " -f15)
        surname=${surname:1:-2}
        if [[ $h%3 -eq  0 ]] #to randomize but not rlly
        then
        domain="hotmail.com"
        fi
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_client, email) VALUES ($h, '$name$surname@$domain')" sql_script.txt
    done
    rm temp_client.txt
}


card () {
    
    #Checks where the table section starts and ends
    parameter="card"
    initializer
    

    client_table_start=$(cat sql_script.txt | grep -n client | cut -d ":" -f1 | head -1)
    client_table_end=$(($client_table_start + $rows2 + 4))
    total_lines=$(wc -l sql_script.txt | cut -d " " -f1)
    cat sql_script.txt | tail -n $(($total_lines-$client_table_start-2)) | head -n $(($client_table_end-$client_table_start-4)) > temp_client.txt
    
    aux=0
    payment_system=" "

    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))


        #insert data

        name=$(awk "NR==$h" temp_client.txt | cut -d " " -f14)
        name=${name:1:-2}
        surname=$(awk "NR==$h" temp_client.txt | cut -d " " -f15)
        surname=${surname:1:-2}
        
        year=$(shuf -i 23-33 -n 1) 
        month=$(shuf -i 1-12 -n 1)
        security_code=$(shuf -i 100-999 -n 1)
        aux=$(shuf -i 1-2 -n 1)
        aux2=$(shuf -i 1-2 -n 1)
        debit_or_credit="Debit card"
        payment_system="Visa"

        if [[ $aux -eq 2 ]]
        then
        debit_or_credit="Credit card"
        fi

        if [[ $aux2 -eq 2 ]]
        then
        payment_system="MasterCard"
        fi
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id, expiration_date, security_code, cardholder, payment_system, debit_or_credit) VALUES ($h, '$year-$month', $security_code, '$name $surname', '$payment_system', '$debit_or_credit')" sql_script.txt
    done
    rm temp_client.txt
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


client_card () {
    
    #Checks where the table section starts and ends
    parameter="client_card"
    initializer
    

    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
    
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_card, id_client) VALUES ($h, $h)" sql_script.txt
    done
    
}


player () {
    
    #Checks where the table section starts and ends
    parameter="player"
    initializer
    
    
    for ((h = 1 ; h < $players_amount ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        name=$(awk "NR==$(shuf -i 1-18239 -n 1)" names.txt)
        surname=$(awk "NR==$(shuf -i 1-88799 -n 1)" surnames.txt)
        year=$(shuf -i 1980-2000 -n 1) 
        month=$(shuf -i 1-12 -n 1)
        day=$(shuf -i 1-31 -n 1)
        height=$(shuf -i 165-220 -n 1) #cm
        weight=$(shuf -i 60-100 -n 1) #kilos
        random_country_id=$(shuf -i 1-191 -n 1)
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id, name, surname, birth_date, height, weight, id_country) VALUES ($h, '$name', '$surname', '$year-$month-$day', $height, $weight, $random_country_id)" sql_script.txt
    done

}


player_avatar_link () {
    
    #Checks where the table section starts and ends
    parameter="player_avatar_link"
    initializer
    
    client_table_start=$(cat sql_script.txt | grep -n player | cut -d ":" -f1 | head -1)
    client_table_end=$(($client_table_start + $players_amount + 4))
    total_lines=$(wc -l sql_script.txt | cut -d " " -f1)
    cat sql_script.txt | tail -n $(($total_lines-$client_table_start-2)) | head -n $(($client_table_end-$client_table_start-4)) > temp_client.txt
    
    for ((h = 1 ; h < $players_amount ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        name=$(awk "NR==$h" temp_client.txt | cut -d " " -f14)
        name=${name:1:-2}
        surname=$(awk "NR==$h" temp_client.txt | cut -d " " -f15)
        surname=${surname:1:-2}
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_player, avatar_link) VALUES ($h, 'img/avatars/$name-$surname.jpg')" sql_script.txt
    done
    rm temp_client.txt
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
    
    client_table_start=$(cat sql_script.txt | grep -n referee | cut -d ":" -f1 | head -1)
    client_table_end=$(($client_table_start + $rows2 + 4))
    total_lines=$(wc -l sql_script.txt | cut -d " " -f1)
    cat sql_script.txt | tail -n $(($total_lines-$client_table_start-2)) | head -n $(($client_table_end-$client_table_start-4)) > temp_client.txt
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        name=$(awk "NR==$h" temp_client.txt | cut -d " " -f12)
        name=${name:1:-2}
        surname=$(awk "NR==$h" temp_client.txt | cut -d " " -f13)
        surname=${surname:1:-2}
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_referee, avatar_link) VALUES ($h, 'img/avatars/$name-$surname.jpg')" sql_script.txt
    done
    rm temp_client.txt
}


manager () {
    
    #Checks where the table section starts and ends
    parameter="manager"
    initializer
    
    
    for ((h = 1 ; h < $teams ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        name=$(awk "NR==$(shuf -i 1-18239 -n 1)" names.txt)
        surname=$(awk "NR==$(shuf -i 1-88799 -n 1)" surnames.txt)
        year=$(shuf -i 1960-1990 -n 1) 
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
    
    client_table_start=$(cat sql_script.txt | grep -n manager | cut -d ":" -f1 | head -1)
    client_table_end=$(($client_table_start + $teams + 4))
    total_lines=$(wc -l sql_script.txt | cut -d " " -f1)
    cat sql_script.txt | tail -n $(($total_lines-$client_table_start-2)) | head -n $(($client_table_end-$client_table_start-4)) > temp_client.txt
    
    for ((h = 1 ; h < $teams ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        name=$(awk "NR==$h" temp_client.txt | cut -d " " -f12)
        name=${name:1:-2}
        surname=$(awk "NR==$h" temp_client.txt | cut -d " " -f13)
        surname=${surname:1:-2}
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_manager, avatar_link) VALUES ($h, 'img/avatars/$name-$surname.jpg')" sql_script.txt
    done
    rm temp_client.txt
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


client_fav_league () {
    
    #Checks where the table section starts and ends
    parameter="client_fav_league"
    initializer
    
    total_lines_client=$rows
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

        id_client=$(shuf -i 1-$total_lines_client -n 1)
        id_league=$(shuf -i 1-$total_lines_league -n 1)
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_league, id_client, receive_browser_notifs, receive_mail_notifs) VALUES ($id_league, $id_client, $receive_browser_notifs, $receive_mail_notifs)" sql_script.txt
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


client_fav_events () {
    
    #Checks where the table section starts and ends
    parameter="client_fav_events"
    initializer
    
    
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
        id_event=$(shuf -i 1-$rows -n 1)
        id_client=$(shuf -i 1-$rows -n 1)
        
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_event, id_client, receive_browser_notifs, receive_mail_notifs) VALUES ($id_event, $id_client, $receive_browser_notifs, $receive_mail_notifs)" sql_script.txt
    done
    
}


team () {
    
    #Checks where the table section starts and ends
    parameter="team"
    initializer
    
    i=1
    aux=0
    
    
    
    for ((h = 1 ; h < $teams ; h++)) #repeat procces as many times as indicated
    do

        id_league=$(shuf -i 1-7 -n 1)

        if [[ $i -gt $teams_for_player_count ]]
        then
        aux=$(($aux+1))
        i=1
        fi

        if [[ $aux -eq 0 ]]
        then
        id_league=$(shuf -i 1-7 -n 1)
        fi

        if [[ $aux -eq 1 ]]
        then
        id_league=8
        fi

        if [[ $aux -eq 2 ]]
        then
        id_league=9
        fi

        if [[ $aux -eq 3 ]]
        then
        id_league=10
        fi

        if [[ $aux -eq 4 ]]
        then
        id_league=11
        fi
        
        if [[ $aux -eq 5 ]]
        then
        id_league=12
        fi

        if [[ $aux -eq 6 ]]
        then
        id_league=13
        fi

        if [[ $aux -eq 7 ]]
        then
        id_league=14
        fi

        if [[ $aux -eq 8 ]]
        then
        id_league=15
        fi

        if [[ $aux -eq 9 ]]
        then
        id_league=16
        fi
        


        

        




        #insert data
        number_table_end=$(($number_table_end + 1))

        id_country=$(shuf -i 1-$(wc -l countries.txt | cut -d " " -f1) -n 1)
        
        
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id, name, id_country, id_league) VALUES ($h, 'Team name', $id_country, $id_league)" sql_script.txt
        i=$(($i+1))
    done
    
}


team_logo_link () {
    
    #Checks where the table section starts and ends
    parameter="team_logo_link"
    initializer
    
    client_table_start=$(cat sql_script.txt | grep -n team- | cut -d ":" -f1 | head -1)
    client_table_end=$(($client_table_start + $teams + 4))
    total_lines=$(wc -l sql_script.txt | cut -d " " -f1)
    cat sql_script.txt | tail -n $(($total_lines-$client_table_start-2)) | head -n $(($client_table_end-$client_table_start-4)) > temp_client.txt
    

    for ((h = 1 ; h < $teams ; h++)) #repeat procces as many times as indicated
    do  
        #insert data
        number_table_end=$(($number_table_end + 1))

        team_logo=$(awk "NR==$h" temp_client.txt | cut -d "," -f5)
        team_logo=${team_logo:2:-1}
        
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_team, logo_link) VALUES ($h, 'img/logos/${team_logo// /_}_$h')" sql_script.txt
    done
    rm temp_client.txt
}


team_visitor () {
    
    #Checks where the table section starts and ends
    parameter="team_visitor"
    initializer
    
    id_team=1

    for ((h = 1 ; h < $(($teams/2)) ; h++)) #repeat procces as many times as indicated
    do
        #insert data
        number_table_end=$(($number_table_end + 1))
        id_event=$h
        id_team=$(($h*2 - 1 ))

        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_event, id_team) VALUES ($id_event, $id_team)" sql_script.txt
    done
    
}


team_local () {
    
    #Checks where the table section starts and ends
    parameter="team_local"
    initializer
    
    id_team=1

    for ((h = 1 ; h < $(($teams/2)) ; h++)) #repeat procces as many times as indicated
    do
        #insert data
        number_table_end=$(($number_table_end + 1))
        id_event=$h
        id_team=$(($h*2))

        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_event, id_team) VALUES ($id_event, $id_team)" sql_script.txt
    done
    
}


user () {
    
    #Checks where the table section starts and ends
    parameter="user"
    initializer
    
    #gets the client_user table
    client_table_start=$(cat sql_script.txt | grep -n client_user- | cut -d ":" -f1 | head -1)
    client_table_end=$(($client_table_start + $rows2 + 4))
    total_lines=$(wc -l sql_script.txt | cut -d " " -f1)
    cat sql_script.txt | tail -n $(($total_lines-$client_table_start-2)) | head -n $(($client_table_end-$client_table_start-4)) > temp_client.txt

    #gets the client table
    client_table_start=$(cat sql_script.txt | grep -n client- | cut -d ":" -f1 | head -1)
    client_table_end=$(($client_table_start + $rows2 + 4))
    total_lines=$(wc -l sql_script.txt | cut -d " " -f1)
    cat sql_script.txt | tail -n $(($total_lines-$client_table_start-2)) | head -n $(($client_table_end-$client_table_start-4)) > temp_client2.txt

    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        #insert data
        number_table_end=$(($number_table_end + 1))

        
        email=$(awk "NR==$h" temp_client.txt | cut -d "," -f3)
        email=${email:2:-1}

        name=$(awk "NR==$h" temp_client2.txt | cut -d "," -f9)
        name=${name:2:-1}

        surname=$(awk "NR==$h" temp_client2.txt | cut -d "," -f10)
        surname=${surname:2:-1}
        name="$name $surname"

        password=$(awk "NR==$h" temp_client2.txt | cut -d "," -f13)
        password=${password:2:-1}

        #section to create "email_verified_at"
        year=$(shuf -i 2015-2022 -n 1) 
        month=$(shuf -i 1-12 -n 1)
        day=$(shuf -i 1-31 -n 1)
        hour=$(shuf -i 1-23 -n 1)
        minute=$(shuf -i 1-59 -n 1)
        second=$(shuf -i 1-59 -n 1)

        month_e=$month
        day_e=$day
        hour_e=$hour
        minute_e=$minute
        second_e=$second

        if [[ ${#month} -eq 1 ]]
        then
        month_e="0$month"
        fi
        if [[ ${#day} -eq 1 ]]
        then
        day_e="0$day"
        fi
        if [[ ${#hour} -eq 1 ]]
        then
        hour_e="0$hour"
        fi
        if [[ ${#minute} -eq 1 ]]
        then
        minute_e="0$minute"
        fi
        if [[ ${#second} -eq 1 ]]
        then
        second_e="0$second"
        fi
        

        email_verified_at="$year-$month_e-$day_e $hour_e:$minute_e:$second_e" #i'm not sure if it works in this format

        #section to create "remember_token"
        remember_token=$(openssl rand -base64 17)

        #section to create "created_at"
        year2=$(($year - $(shuf -i 0-1 -n 1)))
        month2=$(($month - $(shuf -i 0-$(($month-1)) -n 1)))
        day2=$(($day - $(shuf -i 0-$(($day-1)) -n 1)))
        hour2=$(($hour - $(shuf -i 0-$(($hour-1)) -n 1)))
        minute2=$(($minute - $(shuf -i 0-$(($minute-1)) -n 1)))
        second2=$(($second - $(shuf -i 0-$(($second-1)) -n 1)))

        month2_e=$month2
        day2_e=$day2
        hour2_e=$hour2
        minute2_e=$minute2
        second2_e=$second2

        if [[ ${#month2} -eq 1 ]]
        then
        month2_e="0$month2"
        fi
        if [[ ${#day2} -eq 1 ]]
        then
        day2_e="0$day2"
        fi
        if [[ ${#hour2} -eq 1 ]]
        then
        hour2_e="0$hour2"
        fi
        if [[ ${#minute2} -eq 1 ]]
        then
        minute2_e="0$minute2"
        fi
        if [[ ${#second2} -eq 1 ]]
        then
        second2_e="0$second2"
        fi

        created_at="$year2-$month2_e-$day2_e $hour2_e:$minute2_e:$second2_e"

        #section to create "updated_at"
        month=$(($month + $(shuf -i 0-$((12-$month)) -n 1)))
        day=$(($day + $(shuf -i 0-$((31-$day)) -n 1)))
        hour=$(($hour + $(shuf -i 0-$((23-$hour)) -n 1)))
        minute=$(($minute + $(shuf -i 0-$((59-$minute)) -n 1)))
        second=$(($second + $(shuf -i 0-$((59-$second)) -n 1)))


        if [[ ${#month} -eq 1 ]]
        then
        month="0$month"
        fi
        if [[ ${#day} -eq 1 ]]
        then
        day="0$day"
        fi
        if [[ ${#hour} -eq 1 ]]
        then
        hour="0$hour"
        fi
        if [[ ${#minute} -eq 1 ]]
        then
        minute="0$minute"
        fi
        if [[ ${#second} -eq 1 ]]
        then
        second="0$second"
        fi

        updated_at="$year-$month-$day $hour:$minute:$second"


        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (email, name, password, email_verified_at, remember_token, created_at, updated_at) VALUES ('$email', '$name', '$password', '$email_verified_at', '$remember_token', '$created_at', '$updated_at')" sql_script.txt
    done
    rm temp_client.txt
    rm temp_client2.txt
}


client_fav_teams () {
    
    #Checks where the table section starts and ends
    parameter="client_fav_teams"
    initializer
    
    
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
        id_team=$(shuf -i 1-$(($teams)) -n 1)
        id_client=$(shuf -i 1-$rows -n 1)
        
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_team, id_client, receive_browser_notifs, receive_mail_notifs) VALUES ($id_team, $id_client, $receive_browser_notifs, $receive_mail_notifs)" sql_script.txt
    done
    
}


tournament () {
    
    #Checks where the table section starts and ends
    parameter="tournament"
    initializer
    
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data
        
        
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id, name) VALUES ($h, 'Lorem ipsum')" sql_script.txt
    done
    
}


client_fav_tournament () {
    
    #Checks where the table section starts and ends
    parameter="client_fav_tournament"
    initializer
    
    
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
        id_tournament=$(shuf -i 1-$rows -n 1)
        id_client=$(shuf -i 1-$rows -n 1)
        
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_tournament, id_client, receive_browser_notifs, receive_mail_notifs) VALUES ($id_tournament, $id_client, $receive_browser_notifs, $receive_mail_notifs)" sql_script.txt
    done
    
}


group () {
    
    #Checks where the table section starts and ends
    parameter="group"
    initializer
    
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data

        
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id, id_phase, name) VALUES ($h, $h, 'Lorem ipsum')" sql_script.txt
    done
    
}


group_set () {
    
    #Checks where the table section starts and ends
    parameter="group_set"
    initializer
    
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data

        
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_phase, id_tournament, name) VALUES ($h, $h, 'Lorem ipsum')" sql_script.txt
    done
    
}


direct_elim () {
    
    #Checks where the table section starts and ends
    parameter="direct_elim"
    initializer
    
    
    for ((h = 1 ; h < $rows2 ; h++)) #repeat procces as many times as indicated
    do
        number_table_end=$(($number_table_end + 1))

        #insert data

        
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_phase, id_tournament, name) VALUES ($h, $h, 'Lorem ipsum')" sql_script.txt
    done
    
}


player_team () {
    
    #Checks where the table section starts and ends
    parameter="player_team"
    initializer

    players_sport=11 #soccer
    team_num=1
    i=1


    for ((h = 1 ; h < $players_amount ; h++)) #repeat procces as many times as indicated
    do
        
        
         
        if [[ $i -gt $players_sport ]]
        then
        i=1
        team_num=$(($team_num+1))
        fi

        if [[ $team_num -gt $teams_for_player_count ]]
        then
        players_sport=5
        fi

        if [[ $team_num -gt $(($teams_for_player_count*2)) ]]
        then
        players_sport=1
        fi

        if [[ $team_num -gt $(($teams_for_player_count*3)) ]]
        then
        players_sport=9
        fi

        if [[ $team_num -gt $(($teams_for_player_count*4)) ]]
        then
        players_sport=1
        fi

        if [[ $team_num -gt $(($teams_for_player_count*5)) ]]
        then
        players_sport=6
        fi

        if [[ $team_num -gt $(($teams_for_player_count*6)) ]]
        then
        players_sport=1
        fi

        if [[ $team_num -gt $(($teams_for_player_count*7)) ]]
        then
        players_sport=10
        fi

        if [[ $team_num -gt $(($teams_for_player_count*8)) ]]
        then
        players_sport=1
        fi

        if [[ $team_num -gt $(($teams_for_player_count*9)) ]]
        then
        players_sport=1
        fi
        #it can be done better i just ran out of time

        number_table_end=$(($number_table_end + 1))

        #insert data

        year=$(shuf -i 2019-2021 -n 1) 
        month=$(shuf -i 1-12 -n 1)
        day=$(shuf -i 1-31 -n 1)
        year2=$(shuf -i 2023-2025 -n 1) 
        month2=$(shuf -i 1-12 -n 1)
        day2=$(shuf -i 1-31 -n 1)

        
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_player, id_team, position, contract_start_date, contract_end_date) VALUES ($h, $team_num, 'Lorem ipsum', '$year-$month-$day', '$year2-$month2-$day2')" sql_script.txt
        i=$(($i+1))
    done
    
}


player_team_shirt_number () {
    
    #Checks where the table section starts and ends
    parameter="player_team_shirt_number"
    initializer

    players_sport=11
    team_num=1
    i=1


    for ((h = 1 ; h < $players_amount ; h++)) 
    do
        
        
         
        if [[ $i -gt $players_sport ]]
        then
        i=1
        team_num=$(($team_num+1))
        fi

        if [[ $team_num -gt $teams_for_player_count ]]
        then
        players_sport=5
        fi

        if [[ $team_num -gt $(($teams_for_player_count*2)) ]]
        then
        players_sport=1
        fi

        if [[ $team_num -gt $(($teams_for_player_count*3)) ]]
        then
        players_sport=9
        fi

        if [[ $team_num -gt $(($teams_for_player_count*4)) ]]
        then
        players_sport=1
        fi

        if [[ $team_num -gt $(($teams_for_player_count*5)) ]]
        then
        players_sport=6
        fi

        if [[ $team_num -gt $(($teams_for_player_count*6)) ]]
        then
        players_sport=1
        fi

        if [[ $team_num -gt $(($teams_for_player_count*7)) ]]
        then
        players_sport=10
        fi

        if [[ $team_num -gt $(($teams_for_player_count*8)) ]]
        then
        players_sport=1
        fi

        if [[ $team_num -gt $(($teams_for_player_count*9)) ]]
        then
        players_sport=1
        fi

        number_table_end=$(($number_table_end + 1))

        #insert data

        
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_player, id_team, shirt_number) VALUES ($h, $team_num, '$i')" sql_script.txt
        i=$(($i+1))
    done
    
}


manager_team () {
    
    #Checks where the table section starts and ends
    parameter="manager_team"
    initializer


    for ((h = 1 ; h < $teams ; h++)) #repeat procces as many times as indicated
    do
        
        
        number_table_end=$(($number_table_end + 1))

        #insert data

        year=$(shuf -i 2019-2021 -n 1) 
        month=$(shuf -i 1-12 -n 1)
        day=$(shuf -i 1-31 -n 1)
        year2=$(shuf -i 2023-2025 -n 1) 
        month2=$(shuf -i 1-12 -n 1)
        day2=$(shuf -i 1-31 -n 1)

        
        sed -i "$(($number_table_end - 2)) i INSERT INTO $parameter (id_team, id_manager, contract_start_date, contract_end_date) VALUES ($h, $h, '$year-$month-$day', '$year2-$month2-$day2')" sql_script.txt
    done
    
}


rm sql_script.txt
clear
echo "1- Fill the whole database"
echo "0- Exit"
read -p "Choose an option: " option
    case $option in
            1)read -p "How many rows: " rows
            read -p "How many teams per sport: " teams
            touch sql_script.txt
            teams_for_player_count=$teams
            teams=$((($teams*10)+1))
            rows2=$(($rows + 1))
            players_amount=$((($teams_for_player_count*11)+($teams_for_player_count*5)+($teams_for_player_count)+($teams_for_player_count*9)+($teams_for_player_count)+($teams_for_player_count*6)+($teams_for_player_count)+($teams_for_player_count*10)+($teams_for_player_count)+($teams_for_player_count)+1))
            subscription
            subscription_type
            country
            client
            client_avatar_link
            client_user
            card
            card_number_card
            client_card
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
            client_fav_league
            event
            client_fav_events
            team
            team_logo_link
            team_visitor
            team_local
            user
            client_fav_teams
            tournament
            client_fav_tournament
            group
            group_set
            direct_elim
            player_team
            player_team_shirt_number
            manager_team

            sleep 2
            clear
            exit;;
            0)exit;;

    esac