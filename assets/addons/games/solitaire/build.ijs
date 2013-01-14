NB. build

writesourcex_jp_ '~Addons/games/solitaire';'~Addons/games/solitaire/solitaire.ijs'

f=. 3 : 0
(jpath '~addons/games/solitaire/',y) fcopynew jpath '~Addons/games/solitaire/',y
)

mkdir_j_ jpath '~addons/games/solitaire'

f 'solitaire.ijs'
f 'about.ijs'
f 'cards.j31'
f 'init.ijs'
f 'main.ijs'
f 'options.ijs'
f 'record.txt'
f 'used.ijs'
f 'win.ijs'
