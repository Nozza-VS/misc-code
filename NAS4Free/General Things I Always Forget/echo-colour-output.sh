#!/bin/sh
# Colours:
#       Black         0;30        Dark Grey     1;30
#       Red           0;31        Light Red     1;31
#       Green         0;32        Light Green   1;32
#       Brown/Orange  0;33        Yellow        1;33
#       Blue          0;34        Light Blue    1;34
#       Purple        0;35        Light Purple  1;35
#       Cyan          0;36        Light Cyan    1;36
#       Light Grey    0;37        White         1;37



BK='\033[0;30m' # Black
DG='\033[1;30m' # Dark Grey
R='\033[0;31m'  # Red
LR='\033[1;31m' # Light Red
G='\033[0;32m'  # Green
LG='\033[1;32m' # Light Green
O='\033[0;33m'  # Orange/Brown
Y='\033[1;33m'  # Yellow
B='\033[0;34m'  # Blue
LB='\033[1;34m' # Light Blue
P='\033[0;35m'  # Purple
LP='\033[1;35m' # Light Purple
C='\033[0;36m'  # Cyan
LC='\033[1;36m' # Light Cyan
LG='\033[0;37m' # Light Grey
W='\033[1;37m'  # White
NC='\033[0m'  # No Colour/Default Colour



echo -e "${BK}This is some Black text"
echo -e "${DG}This is some Dark Gray text"
echo -e "${R}This is some Red text"
echo -e "${LR}This is some Light Red text"
echo -e "${G}This is some Green text"
echo -e "${LG}This is some Light Green text"
echo -e "${O}This is some Orange text"
echo -e "${Y}This is some Yellow text"
echo -e "${B}This is some Blue text"
echo -e "${LB}This is some Light Blue text"
echo -e "${P}This is some Purple text"
echo -e "${LP}This is some Light Purple text"
echo -e "${C}This is some Cyan text"
echo -e "${LC}This is some Light Cyan text"
echo -e "${LG}This is some Light Gray text"
echo -e "${W}This is some White text"
echo -e "${NC}This is the default coloured text"

printf "Example message with ${RD}red color${NC} for print output\n"
echo -e "Example message with ${RD}red color${NC} for echo output"