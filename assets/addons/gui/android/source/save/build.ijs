NB. build

mkdir_j_ jpath '~Addons/gui/android'
mkdir_j_ jpath '~addons/gui/android'

F=: <;._2 (0 : 0)
android
drawable
layout
menu
values
resu
mkview
mkmenu
)

3 : 0''
z=. ''
for_l. F do.
  load '~Public/gui/android/source/',(>l),'/build.ijs'
  z=. z, fread jpath '~Public/gui/android/release/',(>l),'.ijs'
end.
z fwrite jpath '~Addons/gui/android/android.ijs'
)

(jpath '~addons/gui/android/android.ijs') fcopynew jpath '~Addons/gui/android/android.ijs'

f=. 3 : 0
(jpath '~Addons/gui/android/',y) fcopynew jpath '~Public/gui/android/',y
(jpath '~addons/gui/android/',y) fcopynew jpath '~Public/gui/android/',y
)

f 'manifest.ijs'
f 'history.txt'
