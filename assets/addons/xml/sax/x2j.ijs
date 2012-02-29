NB. x2j -- declarative XML to J transformer
NB.    uses XPath match patterns; based on SAX
NB.
NB. 09/04/09 Oleg Kobchenko

require 'xml/sax'

saxclass 'px2j'

NB. =========================================================
NB. utility

x2jElmLoc=: ''
x2jElmDef=: ''

x2jCharLoc=: ''
x2jCharDef=: ''

x2jElm=: 2 : 0
  x2jElmLoc=: x2jElmLoc,<,m
  x2jElmDef=: x2jElmDef`(v f.)
)

x2jChar=: 2 : 0
  x2jCharLoc=: x2jCharLoc,<,m
  x2jCharDef=: x2jCharDef`(v f.)
)

findLoc=: 4 : 0
  for_p. x do.
    pp=. >p
    qq=. (-#pp){.y
    if. pp -: qq do. p_index return. end.
  end.
  _1
)

NB. can be single, boxed or space-separated
atr=: 3 : 'ATR&getAttribute`($:@;:)@.('' ''&e.)`($:&.>)@.(0<L.) y'

NB. =========================================================
NB. compact definition
NB. http://www.jsoftware.com/jwiki/Phrases/Definitions

dltb=: #~ ([: (+./\ *. +./\.) ' '&~:)
splitstring=: #@[ }.each [ (E. <;.1 ]) ,

x2jDefn=: 1 : 0
  for_i. <;._2 (0 : 0) do.
    'nm df'=. ':=' splitstring >{.'NB.' splitstring >i
    'mn dy'=. dltb each 2 {. ' : ' splitstring df
    nm=. dltb nm
        if. 0=#dy do. nm x2jChar (3 : mn)
    elseif. 0=#mn do. nm x2jElm  (4 : dy)
    elseif.       do. nm x2jElm  (3 : (mn;':';dy)) end.
  end.
  i.0 0
)


NB. =========================================================
NB. sax interface

startDocument=: 3 : 0
  P=: '/'
  if. 0<:i=. x2jElmLoc findLoc ,'/' do. 
    '' x2jElmDef@.i y
  end.
)

endDocument=: 3 : 0
  if. 0<:i=. x2jElmLoc findLoc ,'/' do. 
    x2jElmDef@.i y
  end.
)

startElement=: 4 : 0
  P=: P,'/',y
  ATR=: x
  if. 0<:i=. x2jElmLoc findLoc P do. 
    x x2jElmDef@.i y
  end.
)

endElement=: 3 : 0
  if. 0<:i=. x2jElmLoc findLoc P do. 
    x2jElmDef@.i y
  end.
  P=: ({.~ i:&'/') P
)

characters=: 3 : 0
  if. 0<:i=. x2jCharLoc findLoc P do. 
    x2jCharDef@.i y
  end.
)

x2jclass_z_=: cocurrent@(3 : 0) f.
  coerase boxopen y
  coclass y
  coinsert 'px2j'
  process=: process_psax_ f.
  y
)

NB. =========================================================
Note 'Ideas'
#doc {             root=: 0 0$0
  row {              row=: ''
     item {
       name/#text        { name=:  y }
       value/#text       { value=: y }
                       row=: row,<('name';name),:'value';value
     }               root=: root,row
  }                root
}

+----------------+----------------+
|+-----+--------+|+-----+--------+|
||name |Item 1.1|||name |Item 1.2||
|+-----+--------+|+-----+--------+|
||value|12.3    |||value|45.6    ||
|+-----+--------+|+-----+--------+|
+----------------+----------------+
|+-----+--------+|+-----+--------+|
||name |Item 2.1|||name |Item 2.2||
|+-----+--------+|+-----+--------+|
||value|78.9    |||value|67.8    ||
|+-----+--------+|+-----+--------+|
+----------------+----------------+
)
