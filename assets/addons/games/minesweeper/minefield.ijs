NB. Generic minesweeper engine
NB. Used by the various User Interface (ui*.ijs) scripts

NB. When loaded the script should randomly set the random seed otherwise 
NB. the same sequence of minefields will result in each fresh J session.
3 : 0 ''
 try.
   require 'guid'
   tmp=. _2 (3!:4) , guids 1
 catch.             NB. general/misc/guid.ijs not available
   tmp=. >:<.0.8*0 60 60 24 31#.0 0 0 0 _1+|.<.}.6!:0 ''
 end.
 ([ 9!:1) tmp       NB. set random initial random seed
)

coclass 'mineswp'

newMinefield=: 3 : 0
  if. 0=#y do. y=. 9 9 end.
  Marked=: Cleared=: y$0
  NMines=: <. */(0.01*10+?20),y            NB. 10..20% of tiles are mines
  mines=. (i. e. NMines ? */) y            NB. place mines
  Map=: (9*mines) >. y{. (1,:3 3) +/@,;.3 (-1+y){.mines
)

markTiles=: 3 : 0
  Marked=: (<"1 <:y) (-.@{)`[`]} Marked    NB. toggle marked state of cell(s)
)

clearTiles=: clearcell@:<:                      NB. decrement coords - J arrays are 0-based

clearcell=: verb define
  if. #y do.
    free=. (#~ (Cleared < 0 = Map) {~ <"1) y 
    Cleared=: 1 (<"1 y)} Cleared           NB. set cell(s) as cleared
    if. #free do.
      clearcell (#~ Cleared -.@{~ <"1) ~. (<:$Map) (<."1) 0 >. getNbrs free
    end.
  end.
)

getNbrs=: [: ,/^:(3=#@$) +"1/&(<: 3 3#: i.9)

eval=: verb define
  if. isend=. 9 e. Cleared #&, Map do.            NB. cleared mine(s)?
    msg=. 'KABOOM!!'
  elseif. isend=. *./ 9 = (-.Cleared) #&, Map do. NB. all cleared except mines?
    msg=. 'Minefield cleared.'
  elseif. do.                                      NB. else...
    msg=. (": +/, Marked>Cleared),' of ',(":NMines),' mines marked.'
  end.
  isend;msg
)

showField=: 3 : 0
  ' 12345678**.?' showField y
  :
  idx=. y{ (2 <. Marked + +:Cleared) ,: 2
  |: idx} (11&{ , 12&{ ,: Map&{) x  NB. transpose result - J arrays are row,column
)
