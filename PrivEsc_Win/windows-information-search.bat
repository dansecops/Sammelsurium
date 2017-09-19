:: Information gathering tool for windows - searches - take long
@ECHO ON

cd C:\

type C:\sysprep.inf
type C:\sysprep\sysprep.xml
dir C:\Windows\Panther\
dir C:\Windows\Panther\Unattend\
dir C:\Windows\System32\
dir C:\Windows\System32\sysprep\

dir /s *pass* == *cred* == *vnc* == *.config*

findstr /si password *.xml *.ini *.txt

reg query HKLM /f password /t REG_SZ /s

reg query HKCU /f password /t REG_SZ /s