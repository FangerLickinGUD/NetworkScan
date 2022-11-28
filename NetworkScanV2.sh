#!/usr/bin/bash

#Proper use Example : sudo ./NetworkScan.sh 172.31.200.0/24

#empty text file used to stored hosts that are up on network
> addresses.txt

#Sweep address range to find live hosts and output to addresses.txt file
nmap -n -sn $1 -oG - | awk '/Up$/{print $2}' >> addresses.txt

#Sort address list so displayed information will be in order
sort -t . -k 4,4n addresses.txt > sorted_addresses.txt

#Grab date to append to 
DATE=$(date +"%m_%d_%Y")

#Run nmap on list of addresses, -F flag for top 100 well known ports (for speed), -sV to attempt to find the operating system of the device, --script=banner for banner grabbing, -iL to provide input as a text list
nmap -Pn -F -O -sC -sV --script=banner --script vuln -iL sorted_addresses.txt > NMAP_SCAN_$DATE


exit