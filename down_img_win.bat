@echo off
setlocal EnableDelayedExpansion
echo #___________________________________________________________________________________
echo #
echo                This script need to run with administrator privileges            
echo #___________________________________________________________________________________
echo #
set /p FOLDER="What is the storage folder address (e.g. C:\Users\username\desktop) ==> "
echo #
set /p URL="What is the url of the document? ==> "
echo #
set /p PAGES="What is the number of pages of the document? ==> "
echo #
set /p NAME="What do you want to call the final PDF? ==> "
echo #
set /p KEEP="Would you like to keep the images in a folder after merging to pdf? (Y for yes and N for no) ==> "
echo #
set /p FTP="Do you want to receive the final PDF by email (in a download link)? (Y for yes and N for no) ==> "
echo #

if %FTP% == Y (
set /p EMAIL="What is your email address? ==> "
 )

cd "%FOLDER%"
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

REM Download the images and correct name them
if %PAGES% lss 10 (
curl -o "#1.jpg" https://p.calameoassets.com/%ID%/p[1-%PAGES%].jpg
) else (
curl -o "0#1.jpg" https://p.calameoassets.com/%ID%/p[1-9].jpg
curl -o "#1.jpg" https://p.calameoassets.com/%ID%/p[10-%PAGES%].jpg
)

REM Merge all images in a PDF
set fiNAME=%NAME%.pdf

REM use pip, img2pdf and pillow
python -m ensurepip
python -m pip install --upgrade pip
python -m pip install --upgrade img2pdf
set "LSJPG=" & for %%I in ("*.jpg") do set "LSJPG=!LSJPG! "%%I""
img2pdf !LSJPG! -o "../%fiNAME%"

REM save images in library
if %KEEP% == Y (
cd "%FOLDER%\IMG-DOWNLOADER"
md LIBRARY\%NAME%
move /y DOWNLOAD\*.jpg LIBRARY\%NAME% > NUL
rmdir /s /q DOWNLOAD > NUL
) else (
cd "%FOLDER%\IMG-DOWNLOADER"
rmdir /s /q DOWNLOAD > NUL
)

if %FTP% == Y (
curl -q -T "%FOLDER%\IMG-DOWNLOADER\%fiNAME%" -u %EMAIL%:'test' ftp://dl.free.fr
 )


echo #___________________________________________________________________________________
echo The script is finished! If you have not had an error, everything has worked fine!
echo Thanks for use of IMG-downloader!
echo #
echo To sump up :
echo The final PDF file is called %fiNAME% and is located here %FOLDER%\IMG-DOWNLOADER\
if %KEEP% == Y (
echo All downloaded images are saved in this folder: %FOLDER%\IMG-DOWNLOADER\LIBRARY\%NAME%
 )
if %FTP% == Y (
echo The final PDF file %fiNAME% has been uploaded to the server, you will receive an email to download it to this address: %EMAIL%
 )
echo #
echo Enjoy it!
echo A-d-r-i
echo #
echo Answer the question to finish the script and open the folder.
echo #___________________________________________________________________________________
set /p OTHER="Would you like to download another magazine? (Y for yes and N for no) ==>"
if %OTHER% == Y (
start "IMG-DOWNLOADER" "%~f0"
%SystemRoot%\explorer.exe "%FOLDER%\IMG-DOWNLOADER\"
exit
) else (
%SystemRoot%\explorer.exe "%FOLDER%\IMG-DOWNLOADER\"
exit
)