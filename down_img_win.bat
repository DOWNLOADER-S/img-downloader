@echo off

set /p FOLDER="What is the storage folder address (e.g. C:/Users/username/desktop/) "
REM set /p URL="What is the url of the document? ==> "
set /p URL="What is the url of the og:image? ==> "
set /p PAGES="What is the number of pages of the document? ==> "
REM set /p NAME="What do you want to call the final PDF? ==> "

REM set /p FTP="Do you want to receive the final file by email (in a download link)? (Y for yes and N for no) ==> "
REM if %FTP% == Y (
REM set /p EMAIL="What is your email address? ==> "
REM )

cd %FOLDER%
mkdir IMG-DOWNLOADER
cd IMG-DOWNLOADER
mkdir DOWNLOAD
cd DOWNLOAD

REM download all images
for /f "tokens=1,2,3,4 delims=/" %%a in ("%URL%") do (
  set ID=%%c
  )

curl -o "#1.jpg" https://p.calameoassets.com/%ID%/p[1-%PAGES%].jpg

REM if %FTP% == Y (
REM curl -q -T %FOLDER%\IMG-DOWNLOADER\%fiNAME%.mp4 -u %EMAIL%:'test' ftp://dl.free.fr
REM )

echo ================================================================
echo The script is finished! If you have not had an error, everything has worked fine!
echo Thanks for use of IMG-downloader!
echo To sump up :
echo All images have been downloaded and are located here: %FOLDER%\IMG-DOWNLOADER\DOWNLOAD\
REM if %FTP% == Y (
REM echo The final file has been uploaded to the server, you will receive an email to download it to this address: %EMAIL%
REM )
echo All you have to do now is print all the images with a PDF printer so that you can read the document offline.
echo _
echo Enjoy it!
echo A-d-r-i
echo _
echo Press a key to close the script and open the folder.
echo ================================================================
pause
%SystemRoot%\explorer.exe "%FOLDER%\IMG-DOWNLOADER\"