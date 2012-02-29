NB. sines
NB.
NB. try changing size, e.g. 20 13

SIZE=. 9 7
X=. steps 0 1000 3334
w=. 2 3 {GSIZE%1000

fn=. glellipse@[ gbrush
pos=. (w *"1 X ,. gscale sin X) ,"1 SIZE
clr=. 255 <. 128 * 1 + (sin ,. cos,. sin @ -:) X%10
gback 255 255 255
pos fn"1 clr
