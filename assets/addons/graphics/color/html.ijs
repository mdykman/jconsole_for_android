NB. make html color table from colortab
NB.
NB. this html table is included with the color addon
NB. customize this for other color tables

NB. =========================================================
makehtml=: 3 : 0
'file clr'=. y
tab=. makehtmlcell each <"1 clr
r=. '<html><head><style>table{border:1px solid black;}'
r=. r,'td{text-align:center;}</style></head><body><table>',LF
for_t. _6 [\ tab do. r=. r,'<tr>',(;t),'</tr>',LF end.
r=. r,'</table><p><table>',LF
tab=. tab \: +/"1 [ 0 ". clr
for_t. _6 [\ tab do. r=. r,'<tr>',(;t),'</tr>',LF end.
r=. r,'</table></body></html'
r fwrites jpath '~Addons/graphics/color/',file,'.html'
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
load '~Addons/graphics/color/colortab.ijs'
makehtml 'colortab';COLORTABLE

load '~Addons/graphics/color/colorx256.ijs'
makehtml 'colorx256';COLORX256
