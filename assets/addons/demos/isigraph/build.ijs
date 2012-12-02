cocurrent 'base'

TO=: jpath '~addons/demos/isigraph/'
FM=: jpath '~Addons/demos/isigraph/'

mkdir_j_ TO

f=. 3 : 0
fl=. y,(-. '.' e. y) # '.ijs'
to=. TO,fl
fm=. FM,fl
to fcopynew fm
)

f each cutopen (0 : 0)
evolute1
evolute2
frieze1
ifs1
ifs2
iscolor
isdemo
isedit
isigraph.txt
isview
koch
paint
plasma1
polygon
polyhedr
power
siercar1
siercar2
siertri1
siertri2
siertri3
siertri4
sines
solid
smesser
spinner
spirals
title
)
