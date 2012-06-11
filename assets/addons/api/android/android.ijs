cocurrent 'droid'

SystemFolders_j_ =: SystemFolders_j_ ,'external';'/sdcard/'

safeupgrade=: 3 : 0
require'pacman'
'update'jpkg_z_''
'upgrade'jpkg_z_''
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
