NB. graph package
NB.
NB.   gdopen''       opens a graphics window
NB.   gd...          set state
NB.   gd...          draw graphics
NB.   gdshow''       show graphics
NB.   glclose win|'' close window|active window
NB.   glcloseall ''  close all graphics windows
NB.   glselect win   select graphics window
NB.
NB. points are plotted in a box with _1 _1 at bottom left
NB. and 1 1 at top right.
NB.
NB. verbs whose names end in '01' plot in a box with
NB. 0 0 at bottom left to 1 1 at top right. Conversion
NB. to the standard box is done automatically.
NB.
NB. colors should be given as 3 numbers in range (0,255),
NB. or as a single RGB number.
NB.
NB. state-setting functions:
NB.
NB.   gdcolor      set color
NB.   gdfont       set pen size and style
NB.   gdpen        set pen size and style
NB.   gdpencolor   set pen color
NB.   gdtextcolor  set text color
NB.
NB. drawing functions (each has a matching verb ending in '01'
NB. e.g. gdarc01):
NB.
NB.   gdarc        draw arc
NB.   gdchord      draw chord
NB.   gdellipse    draw ellipse
NB.   gdlines      draw lines
NB.   gdpie        draw pie-shaped wedge
NB.   gdpixel      draw pixel
NB.   gdpolygon    draw polygon
NB.   gdrect       draw rectangle
NB.   gdroundr     draw rounded rectangle
NB.   gdtext       draw text
NB.
NB. other definitions:
NB.   gdadd        add wrapper
NB.   gdbmp        write graph to bmp file
NB.   gddraw       draw wrapper
NB.   gdopen       open/clear graphics window
NB.   gdselect     select graphics window
NB.   gdshow       show graph

NB.*gdarc v draw arc
NB.*gdarc01 v draw arc in 0 0 1 1
NB.*gdbmp v write graph to bmp file
NB.*gdchord v draw chord
NB.*gdchord01 v draw chord in 0 0 1 1
NB.*gdclose v close graphics window
NB.*gdcloseall v close all graphics windows
NB.*gdcolor v set color
NB.*gddraw v wrapper for draw methods
NB.*gdellipse v draw ellipse
NB.*gdellipse01 v draw ellipse in 0 0 1 1
NB.*gdlines v draw lines
NB.*gdlines01 v draw lines in 0 0 1 1
NB.*gdopen v open/clear graphics window
NB.*gdpen v set pen size and style
NB.*gdpencolor v set pen color
NB.*gdpie v draw pie-shaped wedge
NB.*gdpie01 v draw pie-shaped wedge in 0 0 1 1
NB.*gdpixel v draw pixel
NB.*gdpixel01 v draw pixel in 0 0 1 1
NB.*gdpolygon v draw
NB.*gdpolygon01 v draw  in 0 0 1 1
NB.*gdrect v draw rectangle
NB.*gdrect01 v draw rectangle in 0 0 1 1
NB.*gdroundr v rounded rectangle
NB.*gdroundr01 v rounded rectangle in 0 0 1 1
NB.*gdselect v select graphics window
NB.*gdshow v show graphics

cocurrent 'z'

require 'color16 jzgraph'

NB. =========================================================
NB. define cover verbs:
f=. (,&'=:') , (,&'_jzgraph_')
f01=. (,&'01=:') , (,&'01_jzgraph_')

j=. 'add bmp close closeall color draw font open'
j=. j,' pen pencolor reset select selopen show textcolor'
nms=. 'gd'&, each ;: j
do f &> nms

j=. 'arc chord ellipse lines pie pixel polygon rect roundr text'
nms=. 'gd'&, each ;: j
do f &> nms
do f01 &> nms

NB. =========================================================
NB. define colors:
do toupper COLOR16
