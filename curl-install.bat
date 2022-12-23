@echo off

rem Download the curl executable from the website
powershell -Command "& {Invoke-WebRequest 'https://curl.haxx.se/download/curl-7.74.0-win64-mingw.zip' -OutFile 'curl.zip'}"

rem Extract the downloaded file
7z.exe x curl.zip -oc:\curl

rem Add the curl executable to the PATH environment variable
setx PATH "%PATH%;C:\curl"

rem Test the installation by printing the curl version
curl --version