NB. build

mkdir_j_ jpath '~Addons/gui/wdclass/forms'
mkdir_j_ jpath '~addons/gui/wdclass/forms'

F=: <;._2 (0 : 0)
formedit
isigraph
others
)

3 : 0''
z=. ''
for_l. F do.
  load '~Public/gui/wdclass/source/',(>l),'/build.ijs'
  z=. z, fread jpath '~Public/gui/wdclass/release/',(>l),'.ijs'
end.
z fwrite jpath '~Addons/gui/wdclass/wdclass.ijs'
)

(jpath '~addons/gui/wdclass/wdclass.ijs') fcopynew jpath '~Addons/gui/wdclass/wdclass.ijs'

f=. 3 : 0
(jpath '~Addons/gui/wdclass/',y) fcopynew jpath '~Public/gui/wdclass/',y
(jpath '~addons/gui/wdclass/',y) fcopynew jpath '~Public/gui/wdclass/',y
)

f 'manifest.ijs'
f 'history.txt'
f 'isitbar8.bmp'
f 'view2.ijs'
f 'forms/baseform.ijs'
f 'forms/empty.ijs'
f 'forms/wizard.ijs'
