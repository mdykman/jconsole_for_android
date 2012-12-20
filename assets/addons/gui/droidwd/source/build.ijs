NB. build

writesourcex_jp_ '~Public/gui/droidwd/source';'~Addons/gui/droidwd/droidwd.ijs'

(jpath '~addons/gui/droidwd/droidwd.ijs') fcopynew jpath '~Addons/gui/droidwd/droidwd.ijs'

f=. 3 : 0
(jpath '~Addons/gui/droidwd/',y) fcopynew jpath '~Public/gui/droidwd/',y
(jpath '~addons/gui/droidwd/',y) fcopynew jpath '~Public/gui/droidwd/',y
)

f 'manifest.ijs'
f 'history.txt'

