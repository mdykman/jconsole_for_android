cocurrent 'droid'

NB. anddf_z_ usage: x anddf y
NB. download a file via android's embedded http client overwriting target file. ie:
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

anddf=: 4 : '>{. ''libj.so android_download_file i *c *c'' 15!:0 x;y'
NB. url for test image
andurl =:'http://www.jsoftware.com/moin_static180/common/jwlogo.png'

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
 >{. 'libj.so java_unzip_file i *c *c' 15!:0 y;x
)

safeupgrade=: 3 : 0
require'pacman'
'update'jpkg_z_''
'upgrade'jpkg_z_''
NB. copy pacman back in place
(1!:1<jpath'~addons/api/android/pacman.ijs')1!:2<jpath'~system/util/pacman.ijs'
)


NB. 2!:1 under android invokes android apps.
NB. return 0 when an activity is found matching your request, otherise _1

NB. 2!:1 action; uri; type
NB. ie. 2!:1 ACTION_VIEW; 'http://www.jsoftware.com'; 'text/html'
NB. ie. 2!:1 ACTION_VIEW; (jpath'~temp/plot.pdf') ; 'application/pdf'

NB. describing the full scope of android intents 
NB. is beyond the scope of the present document.
NB. more information can be found at
NB. http://developer.android.com/reference/android/content/Intent.html

ACTION_VIEW=: 'android.intent.action.VIEW'

NB. the default built-in browser does not view local files
NB. browse 'http://www.jsoftware.com'
browse =: 3 : 0"1
2!:1 ACTION_VIEW;y;'text/html'
''
)

NB. viewpdf jpath '~temp/plot.pdf'
viewpdf =: 3 : 0"1
2!:1 ACTION_VIEW;y;'application/pdf'
''
)
