NB. Utilites for converting between some standard color space:
NB. RGB and YUV, YIQ, HSV, HLS, HSI & creating frequency histograms
NB. Cliff Reiter, January 2003
NB. modified for J6.01, Sept 2006
NB. This script assumes the image3 addon is available
NB. See the end for some examples
NB.
NB. David Vincent Jones, Bill Lam and Zach Reiter provided 
NB. helpful functions and references. 
NB. See also:
NB. movie3.ijs which is primarily the work of Zach Reiter
NB. Gonzalez & Woods, Dig. Im. Proc., 1992
NB. Foley, vanDam, et al, Comp. Gr., Princ & Prac, 2nd ed, 1990
NB. Jacks, Video Demystified, 3rd ed, 2001
NB. Harrington, Comp. Gr., 2nd, 1987

NB. We generally use the following conventions for convertion 
NB. functions: If the target letters are lower case, then 
NB. the result is floating type numbers, usually in the range [0,1].
NB. If the target letters are upper case, they correspond to 
NB. an integer range, usually [0,255]. Thus, RGB_to_yuv results 
NB. in floating point numbers in the range [0,1] while RGB_to_YUV 
NB. yields integers in the range [0,255]. Integer hues are in
NB. the range [0,359] (nearest degree). In addition to conversion
NB. functions, functions for creating histograms and other utilities
NB. are included. See the examples at the end of the script

NB. locale for image3 addon
coinsert 'ima3'
coclass 'ima3'

NB. Boot section:
dir_sep=:PATHSEP_j_

NB. path to the addon library (dll, so) needs to be correct.
addon_path=: jpath '~addons/media/image3/'

NB. require the image3 script (this is for convience, and is not essential)
require addon_path,'image3.ijs'
require 'plot'

NB. general utilities
to01=:%&255
to255=: <.@:(255.999&*)
to_int_in=: 1 : '<.@:((m+0.999)&*"1)'

NB. force into range [0,255]
clamp255=: 255&<.@(>.&0)
clamp01=: 0.9999999&<.@(>.&0)

NB. YUV conversions also are provided in movie3.ijs
NB. yuv is close to YCbCr which is given here
rgbyuv1=.0.257 0.504  0.098,. _0.148 _0.291 0.439,. 0.439 _0.368 _0.071
rgbyuv2=.16 128 128%255

NB. RGB in [0,255], yuv in [0,1]
RGB_to_yuv =: (rgbyuv2"_ +"1 (+/ . *)&(rgbyuv1%255)) :. yuv_to_RGB
yuv_to_RGB =: clamp255@:<.@:((+/ . *)&(255.999*%.rgbyuv1))@:(-&rgbyuv2"1) :. RGB_to_yuv

NB. Versions with YUV in [0,255]
RGB_to_YUV=:to255@:RGB_to_yuv :. YUV_to_RGB
YUV_to_RGB=:yuv_to_RGB@:to01 :. RGB_to_YUV

NB. YIQ (NTSC colour TV where Y is BW signal
NB. RGB in [0,255], yiq in [-0.6,0.6] (approx)
rgbyiq0=.0.299  0.587  0.114,. 0.596 _0.274 _0.322 ,. 0.212 _0.523  0.311
RGB_to_yiq =: (+/ . *)&(rgbyiq0%255) :. yiq_to_RGB
yiq_to_RGB =: clamp255@:<.@:((+/ . *)&(255.999*%.rgbyiq0)) :. RGB_to_yiq

NB. RGB in [0,255], hsv in [0,1], H in [0,359], SV in [0,255]
NB. RGB_hsv y where y is an array of HSV triples
RGB_to_hsv=:3 : 0"2 :. hsv_to_RGB
y=.y%255
v0=. >./"1 y
min=.<./"1 y
delta=.v0-min
s=.(v0-min)%v0
m0=.(v0=y)(i."1)1
h=.1|6%~(+:m0)+ delta %~ +/"1 y * m0{0 1 _1,_1 0 1,:1 _1 0
h,"0 1 s,"0 v0
)

hsv_to_RGB=: 3 : 0"2 :. RGB_to_hsv
'h s v0'=.|:y
h=.6*clamp01 h 
i=.<.h
f=.h-i
p=.to255 v0*(1-s)
q=.to255 v0*(1-(s*f))
t=.to255 v0*(1-(s*(1-f)))
v0=.to255 v0
clamp255 (i{3 2 0,1 3 0,0 3 2,0 1 3,2 0 3,:3 0 1 ){"1 p,"0 1 q,"0 1 t,"0 v0
)

NB. H in [0,359], SV in [0,255]
RGB_to_HSV=:359 255 255 to_int_in @:RGB_to_hsv :. HSV_to_RGB
HSV_to_RGB=:hsv_to_RGB@:(%&359.999 255.999 255.999"1) :. RGB_to_HSV

NB. RGB in [0,255], hls in [0,1]
RGB_to_hls=: 3 : 0"2 :. hls_to_RGB
y=.y%255
max=.>./"1 y
min=.<./"1 y
L=.-:min+max
delta=.max-min
t=.L>0.5
s=.delta%(2*t)+(t{1 _1)*max+min
m0=.(max=y)(i."1)1
h=.1|6%~(+:m0)+ delta %~ +/"1 y * m0{0 1 _1,_1 0 1,:1 _1 0
h,"0 1 L,"0 s
)

NB. n1n2 n1n2_to_val h (hls utility function)
n1n2h_to_val=:4 : 0
c=.i.&1@:(<&(1 3 4 6%6))"0 y
z=.+/"1 x * c{1 0,0 1,_3 4,:1 0
to255 z+(-/"1 x)*y*c{_6 0 6 0
)

NB. hls in [0,1], RGB in [0,255]
hls_to_RGB=:3 : 0"2 :. RGB_to_hls
'h L s'=.|:y
t=.L>0.5
t=.L+s*t+L*t{1 _1  NB. m2
t=.((+:L)-t),.t    NB. m1m2
r=.t n1n2h_to_val 1|h+%3
g=.t n1n2h_to_val h
b=.t n1n2h_to_val 1|h-%3
clamp255 r,.g,.b
)

NB. H in [0,359], SV in [0,255]
RGB_to_HLS=:359 255 255 to_int_in @:RGB_to_hls :. HLS_to_RGB
HLS_to_RGB=:hls_to_RGB@:(%&359 255 255"1) :. RGB_to_HLS

NB. RGB in [0,255], hsi in [0,1]
NB. This doesn't follow any reference, but it is based upon
NB. Harrington's description with hue rotated and si rescaled
NB. to fit my expectations and nicely fill the [0,1] cube
RGB_to_hsi=:3 : 0"2 :. hsi_to_RGB
i=.(+/"1 y) %3*255
m2jm1=.j./"1 y +/ . * ((2 _1 _1%%:6),.~0 1 _1%%:2)%255
h=.2p1%~2p1|1r2p1-{.@+. 12 o. m2jm1
h,. (|(%:1.5)*m2jm1),. i  
)

NB. hsi in [0,1], RGB in [0,255]
hsi_to_RGB=:3 : 0"2 :. RGB_to_hsi
'h s i'=.|:y
m1=. (s%%:1.5)* 1 o. h=. 3r2p1-2p1|1p1+2p1*h
m2=. (s%%:1.5)* 2 o. h
clamp255 <.(m1,.m2,.i)+/ . * 255.999*(2 _1 _1%%:6),(0 1 _1%%:2),:1
)

NB. H in [0,359], SV in [0,255]
RGB_to_HSI=:359 255 255 to_int_in @:RGB_to_hsi :. HSI_to_RGB
HSI_to_RGB=:hsi_to_RGB@:(%&359 255 255"1) :. RGB_to_HSI

NB. create a frequency table 
NB. [upper bound] freq_tab data
freq_tab=: 3 : 0
256 freq_tab y
:
<:#/.~(i.x),,y
)

NB. [range cutoff] (discretization levels [saturation position])cs_hist (labels(3),colors(3) as a boxed array)
NB. color space histogram builder conjunction
cs_hist=:2 : 0
_ _ _ m cs_hist n y
:
labels=.3{.n
colors=.3}.n
Y=.,"_1 (i.<:#$y)|:y
pd 'reset'
pd 'multi 0 0 1024 768; sub 1 3'
for_k. i. 3 do.
  pd 'use '
  pd 'type line;'
  pd 'color ',":>k{colors 
  pd 'xrange 0 ',":N=.k{m
  pd 'xticpos ',":N*(i.%<:)5
  pd 'title ',>k{labels
  if. (k=0) *. 3<#m do.
     data=.(0~:(3{m){Y)#k{Y
     else.
     data=.k{Y
     end.
  fdata=.(k{m) freq_tab data
  if. _>k{x do. fdata=.fdata <. k{x end.
  pd fdata
end.
pd 'show'
)

NB. all histogram functions take RGB [0,255] arrays
NB. as their right argument
NB. optional left argument is 3 bounds on the output frequency table heights

rgb_hist=:256 256 256 cs_hist ('Red';'Green';'Blue';255 0 0;0 255 0;0 0 255)

yuv_hist=:_ _ _&$: : ([ 256 256 256 cs_hist ('Y';'U';'V';0 0 0;0 0 255;255 0 0) RGB_to_YUV@]) 

hsi_hist=:_ _ _&$: : ([ 360 256 256 1 cs_hist ('Hue';'Saturation';'Intensity';255 0 255;128 128 128;0 0 0) RGB_to_HSI@])

hsv_hist=:_ _ _&$: : ([ 360 256 256 1 cs_hist ('Hue';'Saturation';'Value';255 0 255;128 128 128;0 0 0) RGB_to_HSV@])

hls_hist=:_ _ _&$: : ([ 360 256 256 2 cs_hist ('Hue';'Lightness';'Saturation';255 0 255;128 128 128;0 0 0) RGB_to_HLS@])

NB. contrast expansion
NB. using optimal contrast
con_exp=:3 : 0
'y0 u0 v0'=.0 1|:RGB_to_yuv y
cft=.+/\(%+/) freq_tab to255 y0
x0=.(i.%])256
y0=.(x0;cft)pw_lin y0
yuv_to_RGB 0|:y0,u0,:v0
)

NB. (x;y) pw_lin y
NB. adverb gives the piecewise linear function based on (x;y) 
NB. x assumed to be ordered, but duplicate x's allowed!
pw_lin=:1 : 0
'X Y'=.m
m0=.(2 ]\ Y)(%. :: (_ _"_))"(1 2) 2]\1,.X
t=.-. _ _ -:"1 m0
X=.t#}.X
m0=.t#m0
{&m0@:((#X)&|)@:((>&X i. 0:)"0) p. ]
)

NB. m tw_fct    NB. a twisted function
NB. is a cubic function through (0,0), (0.5,0.5) (1,1)
NB. with slope m at 0.5
tw_fct=:1 : '(0.5,m,0,4*-.m)&p.@(-&0.5)'

NB. maximum likelihood filter for triples
maxlike3=:3 : 0
ic=.,0 5 10+/6 7 8
i9=.,/3 3 ,;._3 i.5 5
dist=.+/&.:*:@:-
lfilt=.({~ [: {&ic@:{.@:/: [:(+/)@:*:"1 i9&{ dist"1"_1 ic&{)@:(,/)
,/"2]5 5 lfilt;._3 y
)

NB. An example. Run this script, then run the lines
NB. inside the following
an_example_to_try=:0 : 0
load addon_path,'view_m.ijs'     NB. load viewer
fn=:addon_path,'atkiln.jpg'
$b=:read_image fn
view_image b
b-:yuv_to_RGB RGB_to_yuv b       NB. convert to yuv and return matches
gray_b=: 3&#@{."1 RGB_to_YUV b   NB. use the Y component for grayscale
view_image gray_b                NB. view grayscale

hsi_hist b                       NB. note the saturations are low
'h s i'=:0 1|: RGB_to_hsi b      NB. obtain hue/sat/intensity color planes
s2=:s^0.7                        NB. raise saturation
c=:hsi_to_RGB 0|:h,s2,:i         NB. return to RGB
view_image c                     NB. view change
)
 