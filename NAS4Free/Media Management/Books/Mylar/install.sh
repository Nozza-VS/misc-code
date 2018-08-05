#------------------------------------------------------------------------------#
### MYLAR INSTALL

install.mylar ()
{

echo -e "${sep}"
echo -e "${sep}     Welcome to the Mylar installer!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${sep} Let's get started with some packages${nc}"
echo -e "${sep}"
echo " "

pkg install -y python27 git py27-cherrypy

cd /usr/local/
git clone https://github.com/evilhero/mylar.git

echo " "
echo -e "${sep}"
echo -e "${msg} Run Mylar${nc}"
echo -e "${sep}"
echo " "

python mylar/mylar.py -d

echo " "
echo -e "${sep}"
echo -e "${msg} Open your browser and go to: ${url}http://${jailip}:8090${nc}"
echo -e "${sep}"
echo " "

}