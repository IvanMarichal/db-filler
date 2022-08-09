


number_lines=0

subscription () {
    number_table_start=$(cat sql_script.txt | grep -n subscription | cut -c1)
    number_table_end=0
    i=2
    while [[ $aux != "-" ]]
    do
    aux=$(awk "NR==$(($number_table_start + $i))" sql_script.txt | cut -c1)
    i=$(( $i + 1 ))
    number_lines=$(( $number_lines + 1 ))
    done
    echo "la cantidad de lineas es: $number_lines"
    sleep 4
}


echo "1- Fill the whole database"
echo "2- Fill certain tables"
echo "0- Exit"
read -p "Choose an option: " option
    case $option in
            1)read -p "How many rows: " rows
            touch sql_script.txt
            subscription
            sleep 2
            clear
            sh fill_db.sh;;
            2)read -p "Ingrese el numero del contacto: " tel
            grep $tel usuarios.txt
            sleep 7
            clear
            sh agenda.sh;;
            0)exit;;



    esac



