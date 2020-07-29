@echo off

set /p FOLDER="What is the storage folder address (e.g. C:/Users/username/desktop) "
set /p URL="What is the url of the document? ==> "
set /p PAGES="What is the number of pages of the document? ==> "
set /p NAME="What do you want to call the final PDF? ==> "
set /p FTP="Do you want to receive the final PDF by email (in a download link)? (Y for yes and N for no) ==> "

if %FTP% == Y (
set /p EMAIL="What is your email address? ==> "
 )

cd %FOLDER%
mkdir IMG-DOWNLOADER
cd IMG-DOWNLOADER
mkdir DOWNLOAD
cd DOWNLOAD

REM Obtain the ID of the images by use a python script
curl -o "TMP-URL-IMG-DOWNLOADER.txt" %URL%
curl -o "IMG-DOWNLOADER.py" https://framagit.org/downloader-s/img-downloader/-/raw/master/IMG-DOWNLOADER.py
python IMG-DOWNLOADER.py TMP-URL-IMG-DOWNLOADER.txt > TMP-ID-IMG-DOWNLOADER.txt
set /p ID=<TMP-ID-IMG-DOWNLOADER.txt
del TMP-URL-IMG-DOWNLOADER.txt
del TMP-ID-IMG-DOWNLOADER.txt
del IMG-DOWNLOADER.py

REM Download the images
curl -o "#1.jpg" https://p.calameoassets.com/%ID%/p[1-%PAGES%].jpg

REM Merge all images in a PDF
set fiNAME=%NAME%.pdf

python -m pip install --upgrade pip
python -m pip install --upgrade img2pdf
img2pdf *.jpg -o ../%fiNAME% REM DON'T WORK (the search of all files with .jpg)

if %FTP% == Y (
curl -q -T "%FOLDER%\IMG-DOWNLOADER\%fiNAME%" -u %EMAIL%:'test' ftp://dl.free.fr
 )

echo ================================================================
echo The script is finished! If you have not had an error, everything has worked fine!
echo Thanks for use of IMG-downloader!
echo To sump up :
echo All images have been downloaded and are located here: %FOLDER%\IMG-DOWNLOADER\DOWNLOAD\
if %FTP% == Y (
echo The final PDF file %fiNAME% has been uploaded to the server, you will receive an email to download it to this address: %EMAIL%
 )
echo _
echo Enjoy it!
echo A-d-r-i
echo _
echo Press a key to close the script and open the folder.
echo ================================================================
pause
%SystemRoot%\explorer.exe "%FOLDER%\IMG-DOWNLOADER\"