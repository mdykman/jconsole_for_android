NB. convert/misc/vig
NB. Vigenère cipher with optional encoding
NB. version: 1.0.1
NB. ref: http://www.jsoftware.com/jwiki/Addons/convert/misc/vig

NB. defines vig conjunction and related verbs

NB.*vig c Vigenère cipher
NB. cipher=. key 0 vig charset plain
NB. plain=. key 1 vig charset cipher
vig=: 2 : 0
:
  r=. (#y) $ n i.x
  n {~ (#n) | (r*_1^m) + n i.y
)

NB. printable ASCII
vigprn=: vig (TAB,CRLF,(32,:95) ];.0 a.)

NB. alphabetic
vigalpha=: vig ( (97,:26) ];.0 a. )

NB. acsii
vigascii=: vig a.

NB. base64 encoded
vig64=: 1 : 0
:
  require 'convert\misc\base64'
  mv=. m vigascii
  x (_64 ]\ tobase64@mv)`(mv frombase64@(, -. CRLF,' '"_))@.m y
)

NB. ascii85 encoded
vig85=: 1 : 0
:
  require 'convert\misc\ascii85'
  mv=. m vigascii
  x (toascii85@mv)`(mv fromascii85)@.m y
)

Note 'Examples'
   (97,:26) ];.0 a.   NB. alpha
abcdefghijklmnopqrstuvwxyz
   'lemon' 0 vigalpha 'attackatdawn'
lxfopvefrnhr
   'lemon' 1 vigalpha 'lemon' 0 vigalpha 'attackatdawn'
attackatdawn

   'lemon' 1 vigalpha 'attackatdawn'
pphmpzwhpnlj
   'lemon' 0 vigalpha 'lemon' 1 vigalpha 'attackatdawn'
attackatdawn

   'lemon' 0 vig85 a.
Ch@U+EcGl:GB\4...
   a. -: 'lemon' 1 vig85 'lemon' 0 vig85 a.
1

   'lemon' 0 vig64 a.
bGZvcnJxa3R3d3...
   a. -: 'lemon' 1 vig64 'lemon' 0 vig64 a.
1
)
