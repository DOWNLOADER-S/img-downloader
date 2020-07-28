@echo off

set /p FOLDER="What is the storage folder address (e.g. C:/Users/username/desktop/) "
set /p URL="What is the url of the og:image? ==> "
set /p PAGES="What is the number of pages of the document? ==> "

cd %FOLDER%
mkdir IMG-DOWNLOADER
cd IMG-DOWNLOADER
mkdir DOWNLOAD
cd DOWNLOAD

REM download all images by obtain the ID of the storage folder with the cut of the url
for /f "tokens=1,2,3,4 delims=/" %%a in ("%URL%") do (
  set ID=%%c
  )

curl -o "#1.jpg" https://p.calameoassets.com/%ID%/p[1-%PAGES%].jpg

echo ================================================================
echo The script is finished! If you have not had an error, everything has worked fine!
echo Thanks for use of IMG-downloader!
echo To sump up :
echo All images have been downloaded and are located here: %FOLDER%\IMG-DOWNLOADER\DOWNLOAD\
echo All you have to do now is print all the images with a PDF printer so that you can read the document offline.
echo _
echo Enjoy it!
echo A-d-r-i
echo _
echo Press a key to close the script and open the folder.
echo ================================================================
pause
%SystemRoot%\explorer.exe "%FOLDER%\IMG-DOWNLOADER\"