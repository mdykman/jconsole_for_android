NB. build

3 : 0''
T=. jpath '~addons/demos/wd/'
S=. jpath '~Addons/demos/wd/'

f=. {."1 dirtree S
t=. T&, each (#S) }.each f
empty t fcopynew each f
)

