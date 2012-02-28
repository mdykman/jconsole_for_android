NB. gldemo.ijs

cocurrent 'jgldemo'

require 'gl2 jzopenglutil'
coinsert 'jgtk jzopenglutil'

3 : 0''
if. -.IFGTK do. gtkinit_jgtk_'' end.
)

GLDEMOPATH_z_=: jpath '~addons/demos/opengl/demo/'
load GLDEMOPATH,'glview.ijs'
load GLDEMOPATH,'gledit.ijs'

opengldemo''

