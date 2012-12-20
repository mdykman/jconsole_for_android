NB. color
NB.
NB. code uses short names:
NB.  TEXT     COLOR_BTNTEXT
NB.  FACE     COLOR_BTNFACE
NB.  SHADOW   COLOR_BTNSHADOW
NB.  HIGH     COLOR_BTNHIGHLIGHT
NB.  DKSHADOW COLOR_3DDKSHADOW
NB.  LIGHT    COLOR_3DLIGHT

BLACK=: 0 0 0
RED=: 255 0 0
BLUE=: 0 0 255

NB. =========================================================
3 : 0 ''
if. IFJAVA do.
  TEXT=: 0 0 0
  FACE=: 236 233 216
  SHADOW=: 172 168 153
  HIGH=: 255 255 255
  DKSHADOW=: 113 111 100
  LIGHT=: 241 239 226
else.
  nms=. 'FACE SHADOW TEXT HIGH DKSHADOW LIGHT'
  (nms)=: 0 ". wd 'qcolor ',"1 ": ,.15 16 18 20 21 22
end.
)
