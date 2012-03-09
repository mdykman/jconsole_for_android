NB. convert between color triples and RGB values

cocurrent 'z'

NB. =========================================================
NB. form:  opt RGB dat
NB.   opt = 0 integers to RGB   (default)
NB.   dat = red, green, blue values or 3-col matrix of same
NB.
NB.   opt = 1 RGB to integers
NB.   dat = one or more RGB values
NB.
NB. RGB format is a 4 byte integer: unused blue green red
NB.
NB. e.g.  RGB 255 255 0   =  RGB value for bright yellow
NB.*RGB v convert between color triples and RGB values
RGB=: 3 : 0
0 RGB y
:
if. x do. |."1 [256 256 256 #: y
else. y +/ .* 1 256 65536
end.
)

NB. =========================================================
NB. form:  opt BGR dat
NB.   opt = 0 integers to BGR   (default)
NB.   dat = red, green, blue values or 3-col matrix of same
NB.
NB.   opt = 1 BGR to integers
NB.   dat = one or more BGR values
NB.
NB. BGR format is a 4 byte integer: unused red green blue
NB.
NB. e.g.  BGR 255 255 0   =  BGR value for bright yellow
NB.*BGR v convert between color triples and BGR values
BGR=: 3 : 0
0 BGR y
:
if. x do. 256 256 256 #: y
else. (|."1 y) +/ .* 1 256 65536
end.
)
