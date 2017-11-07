#------------------------------------------------------------------------------#
### LAZYLIBRARIAN INSTALL

install.lazylibrarian ()
{

echo -e "${sep}"
echo -e "${sep}     Welcome to the Lazy Librarian installer!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${sep} Let's get started with some packages${nc}"
echo -e "${sep}"
echo " "

pkg update && pkg upgrade
pkg install -y python27 git

cd /usr/local/
git clone https://github.com/DobyTang/LazyLibrarian.git

echo " "
echo -e "${sep}"
echo -e "${msg} Run LazyLibrarian${nc}"
echo -e "${sep}"
echo " "

python LazyLibrarian.py -d

echo " "
echo -e "${sep}"
echo -e "${msg} Open your browser and go to: ${url}http://${jailip}:5299${nc}"
echo -e "${sep}"
echo " "

}