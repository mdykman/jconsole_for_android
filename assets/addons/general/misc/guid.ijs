NB. general/misc/guid.ijs
NB. Create guids in various formats
NB. version: 1.0.0
NB.
NB. All guid verbs take the shape of guids to return, eg
NB.
NB.   $guids $0   ==>  16     (create guid as a 16-byte character string)
NB.   $guids 2 3  ==>  2 3 16 (create 2x3 array of 16-byte strings)
NB.
NB.  guids  - return guids as 16-byte strings
NB.  guidsn - return guids as 24-character file names
NB.  guidsr - return guids as 36-character strings, without braces
NB.  guidss - return guids as 38-character strings, with braces
NB.  guidsx - return guids as extended precision integers

cocurrent 'z'

NB. =========================================================
guids=: 3 : 0
if. IFWIN do.
  cmd=. 'ole32 CoCreateGuid i *c'
else.
  cmd=. ((UNAME-:'Darwin'){::'libuuid.so.1';'libSystem.B.dylib'),' uuid_generate n *c'
end.
>{:"1 cmd 15!:0"1 0 <"1 (y,16)$' '
)

NB. =========================================================
guidsn=: 3 : 0
g=. (24 # 41) #: guidsx y
g { '+-0123456789=ABCDEFGHIJKLMNOPQRSTUVWXYZ^_'
)

NB. =========================================================
guidsr=: 3 : 0
g=. ,"2 '0123456789ABCDEF' {~ 16 16 #: a. i. guids */y
y $ }."1 > ,.&.>/ '-',.&.> ('';0 8 12 16 20 e.~ i.32) <;.1 g
)

NB. =========================================================
guidss=: 3 : 0
'{',"1 (guidsr y) ,"1 '}'
)

NB. =========================================================
guidsx=: 3 : 0
256 #. x: a. i. guids y
)
