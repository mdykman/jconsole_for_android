NB. build

writesourcex_jp_ '~Addons/games/pousse';'~Addons/games/pousse/pousse.ijs'

f=. 3 : 0
(jpath '~addons/games/pousse/',y) fcopynew jpath '~Addons/games/pousse/',y
)

mkdir_j_ jpath '~addons/games/pousse'

f 'pousse.ijs'
