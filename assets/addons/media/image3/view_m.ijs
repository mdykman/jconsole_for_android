NB. Image viewer using the image3 addon
NB. Cliff & Zach Reiter, September 2002
NB. modified for J6.01, Sept 2006
NB. 
NB. One can view an image via:
NB. view_image d
NB. where d is an image filename, or an array representing an image
NB. and 
NB. view_data m where m is a matrix of data
NB.
NB. see help\index.html for 
NB. Examples appear at the end of the script.

NB. locale for image3 addon
coinsert 'ima3'
coinsert 'jgl2'
coclass 'ima3'

NB. default margin wh in pixels
bor_wh=:15 75

NB. path to the image3 addon library needs to be correct.
dir_sep=: PATHSEP_j_             NB. directory separator
addon_path=: jpath '~addons/media/image3/'
require addon_path,'image3.ijs'
require 'gl2'

VIEWIMAGE=: 0 : 0
pc viewimage;
cc win isigraph;
setxywhx win
)

viewimage_run=: 3 : 0
'view_image' viewimage_run y
:
wh=.1 0{$y
winm=.".wd 'qm;'
whav=.(0 1{winm)-bor_wh
if. wh *./ . <: whav
  do. WH=.wh
  else. WH=.<.wh*<./whav%wh end.
y=.WH resize_image y
if. 1={:$y do. y=.3#"1 y end.
xywh=.0 0,1 0{$y
if. 2=3!:0 y do. y=.256 256 256&#.@:(a.&i.)"2 y
              else. y=.256 256 256&#. y end.
y=.,y
wd VIEWIMAGE,(":xywh),';'
wd 'pn "',x,' wh: ',(":wh),'";'
NB. glmap MM_RAW
NB. glwindowext wh
glsel 'win'
glpixels xywh,y
NB. glshow ''
wd 'pas 0 0;'
wd 'pshow;'
wh
)

viewimage_close=: 3 : 0
wd'pclose'
)


NB. view_image d
NB. where d is an image filename, or an array representing an image
view_image =: 3 : 0
ty=.3!:0 y
sh=.$y
if. (ty=2)*.1=$sh do. (2&short_fn viewimage_run raw_read_image) y
  elseif. (ty e. 2 4)*. 3=$sh do. viewimage_run y
  elseif. (ty =32)*. 2=sh do.
    'p b'=.y
    if. 4=3!:0 p do. p=.p{a. end.
    viewimage_run b{p
  end.
)

NB. Three favorite palettes
NB. default for view_data is P254 which
NB. is white, 254 colors given by hue and black
P254=:255,0,~Hue 5r6*(i.%<:)254

NB. P256 is 256 hues
P256=:Hue 5r6*(i.%<:)256

NB. BW256 is 256 grayscales
BW256=:3#"0 i. 256

NB. num cile v 
NB. Utility for making contour levels with optimal contrast;
NB. num is the number of contour levels to distinguish and v is a matrix
NB. of real data
cile=:$@] $ ((/:@/:@] <.@:* (%#)),)

NB. pal view_data matrix
NB. results in an image of the data given in the matrix
NB. default palette: white is low, hues in between, black is high
NB. use P256 view_data 256 cile data to show the data with
NB. just hues (red low, magenta high) and equal area contours.
view_data =: 3 : 0
P254 view_data y
:
min=.<./,y
max=.>./,y
if. -. (min e. 0 1) *. max e. 254 255 do.
  y=.(255.9999%max-min)*y-min
  end.
view_image x;<.y
)

NB. some examples to try
some_examples_to_try=:0 : 0
view_image addon_path,'atkiln.jpg'     NB. load a medium size image
NB. view_image '\temp\02\dscn5700.jpg' NB. load a large image; you provide the name
view_image 500#,:3#"0 i.256            NB. grayscale as integers
view_image a.{~500#,:3#"0 i.256        NB. grayscale as raw
view_image (Hue (i.%<:)256);500#,:i.256  NB. Hues

view_data (+./ . * |:) #:i.2^8       NB. Sierpinski triangle
view_data (+./ . *. |:) 3 3 3 3 3#:i.3^5  NB. Sierpinski carpet
sin3data=:|.(+&(1&o.) + 1&o.@(+&.*:))"0/~ 14*(i:%]) 200
view_data sin3data                   NB. linear scale; b/w peak/valley
P256 view_data sin3data              NB. linear scale
view_data 256 cile sin3data          NB. optimal contrast; b/w peak/valley
P256 view_data 256 cile sin3data     NB. optimal contrast
(P256;256 cile sin3data) write_image 'temp\temp.png'

)
