NB. isdemo.ijs

require 'numeric rgb stats trig general/misc/font'

ISDEMOPATH_z_=: jpath '~addons/demos/isigraph/'
load ISDEMOPATH,'isview.ijs'
load ISDEMOPATH,'isedit.ijs'

isdemo_jigdemo_`start_droidwd_jigdemo_@.('Android'-:UNAME) 'jigdemo'
evtloop^:(-.IFJ6)''
