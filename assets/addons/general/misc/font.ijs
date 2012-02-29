NB. font.ijs     utilities for fonts
NB.
NB. Fonts are specified as: fontname size [bold] [italic]
NB. The fontname should have "" delimiters if it contains blanks.
NB.
NB. Example:
NB.   "MS Sans Serif" 14 bold eom
NB.
NB. verbs:
NB.    getfont         - returns font spec as boxed list
NB.                      fontname;size;[bold;italic]
NB.
NB.    getfontsize     - get size of a font spec
NB.    setfontsize     - set size into a font spec
NB.
NB.    changefont      - change various elements of a font spec

cocurrent 'z'

NB. =========================================================
NB.*changefont v optlist changefont fontspec
NB.
NB. optlist may contain:  bold    nobold
NB.                       italic  noitalic
NB.                       size    fontsize
NB.
NB. font should be: fontname size [bold] [italic]
NB.
NB. e.g. ('bold';20) changefont '"Lucida Console" 20'
changefont=: 4 : 0
font=. getfont y
opt=. x
if. 0=L. opt do. opt=. cutopen ":opt end.
opt=. a: -.~ (-.&' ' @ ":) each opt
num=. _1 ~: _1 ". &> opt
if. 1 e. num do.
  font=. ({.num#opt) 1} font
  opt=. (-.num)#opt
end.
ayes=. ;:'bold italic'
noes=. ;:'nobold noitalic'
font=. font , opt -. noes
font=. font -. (noes e. opt)#ayes
}: ; ,&' ' each ~. font
)

NB. =========================================================
NB.*getfont v getfont fontspec
getfont=: 3 : 0
font=. ' ',y
b=. (font=' ') > ~:/\font='"'
a: -.~ b <;._1 font
)

NB. =========================================================
NB.*getfontsize v getfontsize fontspec
getfontsize=: 13 : '{.1{._1 -.~ _1 ". y'

NB. =========================================================
NB.*setfontsize v size setfontsize fontspec
setfontsize=: 4 : 0
b=. ~: /\ y='"'
nam=. b#y
txt=. ;:(-.b)#y
ndx=. 1 i.~ ([: *./ e.&'0123456789.') &> txt
nam, }: ; ,&' ' &.> (<": x) ndx } txt
)
