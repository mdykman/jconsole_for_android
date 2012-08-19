NB. xterm 256 colors

cocurrent 'z'

a=. ,/128 255 */ |."1 #:i.8
a=. 192 (7)} 128 (8) }a
b=. >,{3#<0,95+40*i.5
c=. 3#&>8 + 10 * i.24

COLORX256=: ('p<color>q<=: >' 8!:2 ,. i.256) ,"1 ":a,b,c
