NB. util

LF=: 10{a.
IF64=: 16={:$3!:3[2

boxxopen=: <^:(L. < *@#)
cd=: 15!:0
cocurrent=: 18!:4@boxxopen
dtb=: #~ ([: +./\. ' '&~:)
each=: &.>
exit=: 2!:55
fread=: 1!:1 @ < :: _1:
ic=: 3!:4
memr=: 15!:1
pick=: >@{
smoutput=: 0 0 $ 1!:2&2

NB. =========================================================
rescale=: 3 : 0
p=. gdk_pixbuf_new_from_file_at_scale File;;/y,PreserveAspect,0
gtk_image_set_from_pixbuf image,p
)
