@echo off

set /p FOLDER="What is the storage folder address (e.g. C:/Users/username/desktop/) "
REM set /p URL="What is the url of the document? ==> "
set /p URL="What is the url of the og:image? ==> "
set /p PAGES="What is the number of pages of the document? ==> "
set /p NAME="What do you want to call the final zip file? ==> "
set /p FTP="Do you want to receive the final file by email (in a download link)? (Y for yes and N for no) ==> "

if %FTP% == Y (
set /p EMAIL="What is your email address? ==> "
 )

cd %FOLDER%
mkdir IMG-DOWNLOADER
cd IMG-DOWNLOADER
mkdir DOWNLOAD
cd DOWNLOAD

REM Obtain the ID of the storage folder with the cut of the url
for /f "tokens=1,2,3,4 delims=/" %%a in ("%URL%") do (
  set ID=%%c
  )

REM Download the images
curl -o "#1.jpg" https://p.calameoassets.com/%ID%/p[1-%PAGES%].jpg

REM Compress all images
set fiNAME=%NAME%.zip
tar -acf ../%fiNAME% *.jpg

if %FTP% == Y (
curl -q -T "%FOLDER%\IMG-DOWNLOADER\%fiNAME%" -u %EMAIL%:'test' ftp://dl.free.fr
 )

echo ================================================================
echo The script is finished! If you have not had an error, everything has worked fine!
echo Thanks for use of IMG-downloader!
echo To sump up :
echo All images have been downloaded and are located here: %FOLDER%\IMG-DOWNLOADER\DOWNLOAD\
if %FTP% == Y (
echo The final zip file %fiNAME% has been uploaded to the server, you will receive an email to download it to this address: %EMAIL%
 )
echo All you have to do now is print all the images with a PDF printer so that you can read the document offline.
echo _
echo Enjoy it!
echo A-d-r-i
echo _
echo Press a key to close the script and open the folder.
echo ================================================================
pause
%SystemRoot%\explorer.exe "%FOLDER%\IMG-DOWNLOADER\"