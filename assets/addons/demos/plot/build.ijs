NB. build

3 : 0''
T=. jpath '~addons/demos/plot/'
S=. jpath '~Addons/demos/plot/'

mkdir_j_ T
f=. {."1 dirtree S
t=. T&, each (#S) }.each f
empty t fcopynew each f
)

