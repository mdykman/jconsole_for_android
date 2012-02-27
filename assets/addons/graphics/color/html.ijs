NB. make html color table from colortab
NB.
NB. this html table is included with the color addon
NB. customize this for other color tables

NB. =========================================================
makehtml=: 3 : 0
load '~addons/graphics/color/colortab.ijs'
tab=. makehtmlcell each <"1 COLORTABLE
r=. '<html><head><style>table{border:1px solid black;}'
r=. r,'td{text-align:center;}</style></head><body><table>',LF
for_t. _6 [\ tab do. r=. r,'<tr>',(;t),'</tr>',LF end.
r=. r,'</table><p><table>',LF
tab=. tab \: +/"1 [ 0 ". COLORTABLE
for_t. _6 [\ tab do. r=. r,'<tr>',(;t),'</tr>',LF end.
r=. r,'</table></body></html'
r fwrites jpath '~Addons/graphics/color/colortab.html'
)

NB. =========================================================
makehtmlcell=: 3 : 0
x=. y i. '='
id=. x {. y
val=. 0 ". (x+2) }. y
hex=. '0123456789abcdef' {~ ,16 16 #: val
r=. '<td style="background-color:#',hex
if. 300 >: +/val do. r=. r,';color:#ffffff' end.
r,'">',id,'<br/>',(":val),', #',hex,'</td>'
)

NB. =========================================================
makehtml''
