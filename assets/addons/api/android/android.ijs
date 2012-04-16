cocurrent 'droid'

SystemFolders_j_ =: SystemFolders_j_ ,'external';'/sdcard/'


NB. anddf_z_ usage: x anddf y
NB. download a file via android's embedded http client creating or overwriting target file. ie:
NB.    'http://www.jsoftware.com/moin_static180/common/jwlogo.png' anddf jpath'~temp/jwlogo.png'
NB.
NB. returns
NB.  >=0 success, number of bytes in file
NB.  _1 unknown error
NB.  _2 target file exists and is not writable
NB.  _3 parent directory is not writable
NB.  _5 malformed url
NB.  _6 i/o exception during transport
NB.  _99 web request returns invalid '0' status code
NB.  <= _100 negation of unsuccessful http response code (!=200), ie. _404 "Not Found"



anddf=: 4 : '''libj.so android_download_file > i *c *c'' 15!:0 x;y'

NB. andunzip_z_ usage: andunzip y ; x andunzip y
NB. monadically, it unzips the file at y into the same directory
NB. x may specify an alternate output directory
NB. returns
NB.  0 success
NB.  _1 generic i/o error
NB.  _2 zipfile not found
NB.  _3 output directory not writable
NB.  _4 zip format exception

andunzip =: 3 : 0
 '' andunzip y
:
 'libj.so java_unzip_file > i *c *c' 15!:0 y;x
)

copy=: 4 : '(1!:1<jpath x)1!:2<jpath y'

safeupgrade=: 3 : 0
'~addons/api/android/pacman.ijs'copy'~system/util/pacman.ijs'
load'pacman'
'update'jpkg_z_''
'upgrade'jpkg_z_''
'~addons/api/android/pacman.ijs'copy'~system/util/pacman.ijs'
)

NB. 2!:1 under android invokes android apps.
NB. return 0 when an activity is found matching your request, otherise _1

NB. 2!:1 action; uri; type [; flags]
NB. ie. 2!:1 ACTION_VIEW; 'http://www.jsoftware.com'; 'text/html'
NB. ie. 2!:1 ACTION_VIEW; ('file://',jpath'~temp/plot.pdf') ; 'application/pdf'

NB. describing the full scope of android intents 
NB. is beyond the scope of the present document.
NB. more information can be found at
NB. http://developer.android.com/reference/android/content/Intent.html

ACTION_VIEW=:'android.intent.action.VIEW'
ACTION_EDIT=:'android.intent.action.EDIT'
ACTION_DIAL=:'android.intent.action.DIAL'

NB. 2!:1 ACTION_DIAL; 'tel:4165551234'
NB. 2!:1 ACTION_VIEW; 'content://contacts/people'
NB. 2!:1 ACTION_EDIT; 'content://contacts/people/1'
NB. 2!:1 ACTION_VIEW; 'http://www.jsoftware.com';'text/html';16b00040000

view=: 4 : 0
if. 2!:1 ACTION_VIEW;y;x do.
  smoutput 'no viewer found for type=', x,', uri=',y
end.
0 0$0
)

NB. type viewers

NB. browse 'http://www.google.com'
browse=:'text/html'&view

viewpdf=:'application/pdf'&view

NB. viewlocalpdf jpath '~temp/plot.pdf'
viewlocalpdf=: 3 : 0
'application/pdf' view 'file://', y
)
NB. viewlocalbitmap jpath '~temp/viewmat.bmp'
viewlocalbitmap=: 3 : 0
'image/bitmap' view 'file://', y
)
