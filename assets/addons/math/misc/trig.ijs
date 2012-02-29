NB. math/misc/trig
NB. Trigonometric functions
NB. version: 1.0.0

NB.*sin v sin
NB.*cos v cos
NB.*tan v tan
NB.*sinh v sinh
NB.*cosh v cosh
NB.*tanh v tanh
NB.*arcsin v arcsin
NB.*arccos v arccos
NB.*arctan v arctan
NB.*arcsinh v arcsinh
NB.*arccosh v arccosh
NB.*arctanh v arctanh

NB.*pi n pi

NB.*dfr v degrees from radians
NB.*rfd v radians from degrees

NB.*indegrees a convert function to use degrees:
NB.*sind v sin in degrees
NB.*cosd v cos in degrees
NB.*tand v tan in degrees

cocurrent 'z'

NB. =========================================================
sin=: 1&o.
cos=: 2&o.
tan=: 3&o.

sinh=: 5&o.
cosh=: 6&o.
tanh=: 7&o.

arcsin=: _1&o.
arccos=: _2&o.
arctan=: _3&o.

arcsinh=: _5&o.
arccosh=: _6&o.
arctanh=: _7&o.

pi=: 1p1

dfr=: *&(180%pi)
rfd=: *&(pi%180)

NB. corresponding basic functions
sind=: sin @ rfd
cosd=: cos @ rfd
tand=: tan @ rfd
