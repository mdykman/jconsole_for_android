NB. build

writesource_jp_ '~Addons/graphics/treemap';'~Addons/graphics/treemap/treemap.ijs'

3 : 0''
T=. jpath '~addons/graphics/treemap/'
S=. jpath '~Addons/graphics/treemap/'

f=. {."1 dirtree S
t=. T&, each (#S) }.each f
empty t fcopynew each f
)
