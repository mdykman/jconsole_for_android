NB.*joduserconfigbak s-- example JOD user configuration script.
NB.
NB. This  script is  executed before JOD objects  are created. It
NB. can be used to redefine and customize various class nouns. To
NB. make  this script  active  rename it to joduserconfig.ijs and
NB. copy it, with your edits, to the main jod directory:
NB.
NB. ~addons\general\jod
NB.
NB. The nouns listed below are good candidates for redefinition.

NB. smoutput 'joduserconfig.ijs executing ...'

NB. PDF reader in jodutil class - current setting is the default installation directory
NB. for the Windows version of Adobe Reader.  Reset for new versions or other PDF readers
NB. PDFREADER_ajodutil_=:'C:\Program Files\Adobe\Reader 8.0\Reader\acrord32.exe'

NB. alternative Ghostscript compatible reader
NB. PDFREADER_ajodutil_=:'C:\Program Files\Ghostgum\gsview\gsview32.exe'

NB. Preferred web browser in jodutil class - default Windows FireFox installation directory
NB. WWW0_ajodutil_=:'c:\Program Files\Mozilla Firefox\firefox.exe'

NB. Secondary web browser in jodutil class - default Windows installation directory
NB. WWW1_ajodutil_=:'C:\Program Files\Internet Explorer\IEXPLORE.EXE'
