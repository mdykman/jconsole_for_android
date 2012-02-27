NB. hues

cocurrent 'z'

NB. =========================================================
NB.*hue v generate select color
NB. x is color set
NB. y is values from 0 to 1, selecting color
hue=: 4 : 0
y=. y*<:#x
b=. x {~ <.y
t=. x {~ >.y
k=. y-<.y
(t*k)+b*-.k
)

NB. ------------------------------------------------
NB.* hue v function to create hues as 0-255 RGB triples
NB. exmaple:
NB.    hue 5r6*(i.%<:)100
NB. creates a palette with 100 pure color entries
hues=: 3 : 0
h=. 255 * |."1 #: 7 | 3^i.7
y=. y * <: #h
b=. h {~ <. y
t=. h {~ >. y
k=. y - <.y
(t*k)+b*-.k
)

NB. showcolor hues 5r6 * (i.%<:) 12
NB. H=: (_2 }. 255 * |."1 #: 7 | 3^i.7)
NB. H hue (i.%<:) 12
