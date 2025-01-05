#!/bin/bash

# nombre de la red virtual a la que pertenecen las maquinas virtuales que se quieren parar o arrancar
RED_VIRTUAL="nombre de red virtual "

list_vm(){
        echo ""
        echo " $RED_VIRTUAL"
        echo "----------------"
        sudo virsh list --all | grep -i "$RED_VIRTUAL"  | awk '{print $2, $3}'| column -t
}

start_all_vm(){
        echo 
        echo " Arrancando todas maquinas virtuales de $RED_VIRTUAL "
        echo "---------------------------------------------------------"
        for vm in $(sudo virsh list --all| grep lab.example.com)
        do
          sudo virsh start "$vm" >/dev/null 2>&1
        done
        sleep 4
        list_vm
}

stop_all_vm(){
        echo
        echo " Parando todas las maquinas virtuales de  $RED_VIRTUAL "
        echo "--------------------------------------------------------"
        for vm in $(sudo virsh list --all| grep lab.example.com)
        do
            sudo virsh shutdown "$vm" >/dev/null 2>&1
        done
        sleep 4
        list_vm
}

menu_vm(){
        echo ""
        echo ""
        echo "Selecciona una opción:";echo
        echo "1) Listar máquinas virtuales de '$RED_VIRTUAL'"
        echo "2) Arrancar máquinas virtuales de '$RED_VIRTUAL'"
        echo "3) Parar máquinas virtuales red '$RED_VIRTUAL'"
        echo "4) Salir"
        read -p "Opción: " opcion
        case $opcion in
                1)
                        list_vm
                        menu_vm
                        ;;
                2)
                        start_all_vm
                        menu_vm
                        ;;
                3)
                        stop_all_vm
                        menu_vm
                        ;;
                4)
                        exit 0
                        ;;
                *)
                        echo "opcion no valida"
                        sleep 3
                        menu_vm
                        ;;
        esac
}

menu_vm
