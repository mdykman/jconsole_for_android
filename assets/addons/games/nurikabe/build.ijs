NB. build

writesource_jp_ '~Addons/games/nurikabe';'~Addons/games/nurikabe/nurikabe.ijs'

f=. 3 : 0
(jpath '~addons/games/nurikabe/',y) fcopynew jpath '~Addons/games/nurikabe/',y
)

mkdir_j_ jpath '~addons/games/nurikabe'

f 'nurikabe.ijs'
