NB. date formatters
NB.
NB. This script contains examples of formatting dates [+times]
NB. in a variety of styles.
NB.
NB. You should copy verbs from here into your application,
NB. modifying and changing the names as required. Do not
NB. rely on the names in this script, which may change
NB. in future!
NB.
NB. verbs "dfx"  format dates with fixed spacing
NB.       "dsx"  format dates with spacing as required.
NB.       "mxx"  format dates with month first
NB.       "..t." names include times
NB.
NB. y is: yyyy mm dd, or an array of same.
NB.    or: yyyy mm dd hh mm ss

NB. Examples of verb / result for: 2001 1 3
NB.
NB.*df0 v    03Jan01
NB.*df1 v    03Jan2001
NB.*df2 v    03 Jan 01
NB.*df3 v    03 Jan 2001
NB.*ds0 v    3Jan01
NB.*ds1 v    3Jan2001
NB.*ds2 v    3 Jan 01
NB.*ds3 v    3 Jan 2001
NB.*ds4 v    3 January 01
NB.*ds5 v    3 January 2001
NB.*ms0 v    January 3, 2001
NB.
NB.*dft1 v   03Jan2001 13:23:06
NB.*dft3 v   03-Jan-2001 13:23:06

NB. =========================================================
NB. fixed width 7
NB. 23Jan98
NB. 03Jan01

df0=: 3 : 0 "1
'y m d'=. 100 | y
mth=. _3[\'   JanFebMarAprMayJunJulAugSepOctNovDec'
(_2 {. '0' , ":d) , (m{mth) , _2 {. '0',":y
)

NB. =========================================================
NB. fixed width 9
NB. 23Jan1998
NB. 03Jan2001

df1=: 3 : 0 "1
'y m d'=. y
mth=. _3[\'   JanFebMarAprMayJunJulAugSepOctNovDec'
(_2 {. '0' , ":d) , (m{mth) , ":y
)

NB. =========================================================
NB. fixed width 9
NB. 23 Jan 98
NB. 03 Jan 01
NB.
NB. x=separator character (default ' ')
NB.
NB.   '-' df2 19980123 20010103
NB. 23-Jan-98
NB. 03-Jan-01

df2=: (' '&$:) : (4 : 0 "1)
'y m d'=. 100 | y
mth=. _3[\'   JanFebMarAprMayJunJulAugSepOctNovDec'
(_2 {. '0' , ":d) , x, (m{mth) , x, _2 {. '0',":y
)

NB. =========================================================
NB. fixed width 11
NB. 23 Jan 1998
NB. 03 Jan 2001
NB.
NB. x=separator character (default ' ')
NB.
NB.    '-' df3 19980123 20010103
NB. 23-Jan-1998
NB. 03-Jan-2001

df3=: (' '&$:) : (4 : 0 "1)
'y m d'=. y
mth=. _3[\'   JanFebMarAprMayJunJulAugSepOctNovDec'
(_2 {. '0' , ":d) , x, (m{mth) , x, ":y
)

NB. =========================================================
NB. spelled
NB. 23Jan98
NB. 3Jan01

ds0=: 3 : 0 "1
'y m d'=. 100 | y
mth=. _3[\'   JanFebMarAprMayJunJulAugSepOctNovDec'
(":d), (m{mth) , _2 {. '0',":y
)

NB. =========================================================
NB. spelled
NB. 23Jan1998
NB. 3Jan2001

ds1=: 3 : 0 "1
'y m d'=. y
mth=. _3[\'   JanFebMarAprMayJunJulAugSepOctNovDec'
(":d), (m{mth) , ":y
)

NB. =========================================================
NB. spelled
NB. 23 Jan 98
NB. 3 Jan 01

ds2=: 3 : 0 "1
'y m d'=. 100 | y
mth=. _3[\'   JanFebMarAprMayJunJulAugSepOctNovDec'
(":d),' ',(m{mth) ,' ', _2 {. '0',":y
)

NB. =========================================================
NB. spelled
NB. 23 Jan 1998
NB. 3 Jan 2001

ds3=: 3 : 0 "1
'y m d'=. y
mth=. _3[\'   JanFebMarAprMayJunJulAugSepOctNovDec'
(":d),' ',(m{mth) ,5 ": y
)

NB. =========================================================
NB. spelled
NB. 23 January 98
NB. 3 January 01

ds4=: 3 : 0 "1
'y m d'=. 100 | y
mth=. '';;:'January February March April May June July August September October November December'
(":d),' ',(>m{mth) ,' ', _2 {. '0',":y
)

NB. =========================================================
NB. spelled
NB. 23 January 1998
NB. 3 January 2001

ds5=: 3 : 0 "1
'y m d'=. y
mth=. '';;:'January February March April May June July August September October November December'
(":d),' ',(>m{mth) ,5 ": y
)

NB. =========================================================
NB. month first
NB. January 23, 1998
NB. January 3, 2001

ms0=: 3 : 0 "1
'y m d'=. y
mth=. '';;:'January February March April May June July August September October November December'
(>m{mth) ,' ',(":d), ', ', ": y
)

NB. ---------------------------------------------------------
NB. include timestamps

NB. =========================================================
NB. fixed width 18
NB. 23Jan1998 01:02:03
NB. 03Jan2001 13:23:06

dft1=: 3 : 0
f=. ([: _2&{. [: '0'&, ":) &>
mth=. _3[\'   JanFebMarAprMayJunJulAugSepOctNovDec'
v=. ,. |: <. y
y=. ":,.{.v
m=. (1{v) { mth
'd h n s'=. f 2 }.v
d,.m,.y,.' ',.h,.':',.n,.':',.s
)

NB. =========================================================
NB. fixed width 20
NB. 23-Jan-1998 01:02:03
NB. 03-Jan-2001 13:23:06

dft3=: 3 : 0
f=. ([: _2&{. [: '0'&, ":) &>
mth=. _3[\'   JanFebMarAprMayJunJulAugSepOctNovDec'
v=. ,. |: <. y
y=. ":,.{.v
m=. (1{v) { '-',.mth,.'-'
'd h n s'=. f 2 }.v
d,.m,.y,.' ',.h,.':',.n,.':',.s
)
