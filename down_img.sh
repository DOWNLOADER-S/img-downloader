#!/bin/bash

# Check if we are root
uid=$(id -u)
if [ $uid -ne 0 ]
then 
    echo "Please run as root"
    exit 1
fi

#apt get img2pdf
apt install -y img2pdf
apt install -y rename

#ask informations
read -p 'What do you want to call the download folder? ==> ' DOWNLOAD
read -p 'What is the url of the document? ==> ' URL
#read -p 'What is the url ID of the og:image? ==> ' ID
read -p 'What is the number of pages of the document? ==> ' PAGES
read -p 'What do you want to call the final PDF? ==> ' NAME
read -p 'Do you want to receive the final PDF by email (in a download link)? (Y for yes and N for no) ==>' FTP

if [ FTP=Y ]
then 
read -p 'What is your email address? ==>' EMAIL
fi

#create directory to download
mkdir -m 777 ../$DOWNLOAD
cd ../$DOWNLOAD

#cut url
adress=$(wget -O- -q $URL | awk '/meta property="og:image" content=/{ gsub(/.*meta property="og:image" content=\042|\042.*/,"");print }')
sep=$(echo $adress | sed 's~^https://p.calameoassets.com/~~')
ID=$(echo $sep | sed 's~/p1.jpg~~')

#download
curl -o "#1.jpg" https://p.calameoassets.com/$ID/p[1-$PAGES].jpg

#change permissions of the folder and files
cd ../
chmod -R 777 $DOWNLOAD
cd $DOWNLOAD

#rename and merge files
rename -e 's/\d+/sprintf("%02d",$&)/e' -- *.jpg
fiNAME="$NAME.pdf"
img2pdf *.jpg -o $fiNAME

#send by ftp (always the same password)
if [ FTP=Y ]
then
#tar -zcvf $NAME.tar.gz $DOWNLOAD
curl -q -T $fiNAME -u "$EMAIL":'test' ftp://dl.free.fr/

if [ $? -eq 0 ]
then
    echo "$fiNAME successfully transferred to the server! the download link was sent to $EMAIL."
else
    echo "Error during transfer! check your configuration or try again later."
fi

fi

#Final message for user
echo "================================================================"
echo "Thanks for use of IMG-downloader!"
echo "To sump up :"
echo -e " - All uploaded images are in $DOWNLOAD"

if [ FTP=Y ]
then echo -e " - The final compressed file $fiNAME has been uploaded to the server, you will receive an email to download it to this address: $EMAIL"
fi

echo "Enjoy it!"
echo "A-d-r-i"
echo "================================================================"