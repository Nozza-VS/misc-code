#------------------------------------------------------------------------------#
### ABOUT: MYSQL

while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} About: MySQL${nc}"
        echo " "
        echo -e "${msg} MySQL is an open-source relational database management system (RDBMS). The SQL${nc}"
        echo -e "${msg} abbreviation stands for Structured Query Language. The MySQL development${nc}"
        echo -e "${msg} project has made its source code available under the terms of the GNU General${nc}"
        echo -e "${msg} Public License, as well as under a variety of proprietary agreements.${nc}"
        echo " "
        echo -e "${msg} MySQL is a popular choice of database for use in web applications, and is a${nc}"
        echo -e "${msg} central component of the widely used LAMP open-source web application software${nc}"
        echo -e "${msg} stack (and other 'AMP' stacks).${nc}"
        echo -e "${sep}"
        echo " "

        echo -e "${msep}"
        echo -e "${emp}   Press Enter To Go Back To The Menu${nc}"
        echo -e "${msep}"

        read choice

        case $choice in
            *)
                 return
                 ;;
        esac
done
