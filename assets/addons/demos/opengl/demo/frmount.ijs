NB. fractal mountain

randunif=: (? % ])@($&1e9gsfini''
)
cos=: 2&o.
randsn=: (cos@+:@o.@randunif) * (%:@-@+:@^.@randunifgsfini''
)
interp=: (}:@((2&#@i.)+ +: $ 0&,)@#) { (, }. -:@+ }:gsfini''
)
randadd=: ] + [ * randsn@$@]
ira=: [ randadd interp@(interp"1@]gsfini''
)
irfa=: (%@<:@#@] ^ [)ira ]
Z=: -: 0.85&irfa^:5 ]2 2$0

X=: Y=: _1+2*(i.%<:) 33

0 : 0

   require 'plot'
   'boxed 0' plot X;Y;Z
gsfini''
)

require 'gl2 opengl'
DAT=: (X ,"0/ Y),"1 0 Z

demo6=: 3 : 0

glinit GS_LIGHT
GS_ROTXYZ=: _55 0 _25
GS_COLOR=: PALEGREEN
GS_CLEARCOLOR=: SKYBLUE
gsdrawsurface2 DAT
gsfini''
)

wdreset''
glreset''
demo6''
