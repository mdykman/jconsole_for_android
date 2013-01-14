
require 'droidwd gtkwd wdclass'

coclass 'jcitydemo'
coinsert 'wdbase'
droidwd_run=: cities_run

load '~addons/demos/wd/citycalc.ijs'
load '~addons/demos/wd/citywp.ijs'

cities_run`start_droidwd@.(('Android'-:UNAME)>IFQT) coname''
