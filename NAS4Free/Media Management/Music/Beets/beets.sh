#!/bin/sh
pkg install -y py36-beets
pip-3.6 install beets[fetchart,lyrics,lastgenre,embyupdate]
pip-3.6 install flask
pip-3.6 install requests
pip-3.6 install discogs-client pyacoustid 
pip-3.6 install beautifulsoup4 langdetect


discogs:
    user_token: ZNjtumHVbeqTWihthJbewIcjPOOtKgALtlRIOTWv