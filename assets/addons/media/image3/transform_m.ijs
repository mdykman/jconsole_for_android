NB. Transform Images with distortion correction and
NB. mouse operations using the image3 addon
NB. Cliff Reiter, March 2003
NB. modified for J6.01, Sept 2006
NB. 
NB. One can load an image via:
NB. transform_image d
NB. where d is an image filename, or an array representing an image
NB. see transform_m.html for help

NB. locale for image3 addon
coinsert 'ima3'
coinsert 'jgl2'
coclass 'ima3'

NB. default margin wh in pixels
bor_wh=:15 110

NB. path to the image3 addon library needs to be correct.
dir_sep=: PATHSEP_j_             NB. directory separator
addon_path=: jpath '~addons/media/image3/'
require addon_path,'image3.ijs'
require 'gl2'

TRANSFORMIMAGE=: 0 : 0
pc transformimage;
menupop "&File";
menu open "&Open" "Ctrl+o" "" "";
menu save "&Save..." "Ctrl+s" "" "";
menusep;
menu close "&Close" "" "" "";
menupopz;
menupop "&Transform";
menu rotateh "Rotate to &Horizontal" "" "" "";
menu rotatev "Rotate to &Vertical" "" "" "";
menu rotated "Rotate by &Degrees..." "" "" "";
menusep;
menu unbarrel "Remove &Barrel Distortion" "" "" "";
menu unbarrelc "Remove Barrel Distortion by &Coef..." "" "" "";
menu tiltr "Ti&lt to Rectangle" "" "" "";
menu balanceh "Balance Horizontal" "" "" "";
menu balancev "Balance Vertical" "" "" "";
menusep;
menu trim "&Trim" "" "" "";
menu resize "Resi&ze..." "" "" "";
menu rescale "Rescale..." "" "" "";
menupopz;
menupop "&View";
menu vselpts "&Selected Points" "" "" "";
menu vrotated "&Rotate Degrees" "" "" "";
menu vunbarrelc "&Unbarrel Coefficient" "" "" "";
menusep;
menu refresh "Re&fresh Selected Points" "" "" "";
menu clearpts "&Clear Selection" "" "" "";
menupopz;
menupop "&History";
menu back "&Back" "Ctrl+b" "" "";
menu forward "&Forward" "Ctrl+f" "" "";
menusep;
menu clearhist "&Clear History" "" "" "";
menupopz;
menupop "Hel&p";
menu help "Hel&p" "F1" "" "";
menusep;
menu about "&About" "" "" "";
menupopz;
cc win isigraph;
setxywhx win
)

to_raw_image=: 3 : 0
if. 0=#y do. y=.25 250 3${:a. end.
ty=.3!:0 y
sh=.$y
if. (ty=2)*.1=$sh do. y=. raw_read_image y end.
ty=.3!:0 y
sh=.$y
if. (ty = 4)*. 3=$sh do.  y=.y{a.
  elseif. (ty = 32)*. 2=sh do.
    'p b'=.y
    if. 4=3!:0 p do. p=.p{a. end.
    y=. b{p
  end.
if. 1={:$y do. y=.3#"1 y end.  NB. grayscale
y
)

transformimage_run=: 3 : 0
'transform_image' transformimage_run y
:
y=.to_raw_image y
tr_image_list_ima3_=:i.0
image_to_hist y
tr_draw_image y
)

tr_draw_image=: 3 : 0
SEL_pts_ima3_=:i.0 2
mouserect=:i.0
wh=.1 0{$y
winm=.".wd 'qm;'
whav=.(0 1{winm)-bor_wh
if. wh *./ . <: whav
  do. WH=.wh
  else. WH=.<.wh*<./whav%wh end.
y=.WH resize_image y
xywh=.0 0,1 0{$y
y=.256 256 256&#.@:(a.&i.)"2 y
y=.,y
wd :: 0: 'psel transformimage;'
wd :: 0: 'pclose;'
wd TRANSFORMIMAGE,(":xywh),';'
wd 'pn "Transform Image wh: ',(":wh),'";'
NB. glmap MM_RAW
NB. glwindowext wh
glsel 'win'
glpixels xywh,y
glcursor IDC_CROSS
NB. glshow ''
glpaint ''
wd 'pas 0 0;'
wd 'pshow;'
wh
)

tr_refresh_image=:3 : 0
t=.SEL_pts_ima3_
wh=._2{.". wd 'qchildxywhx win'
glclear ''
tr_draw_image image_from_hist ''
for_xy. t do.
  SEL_pts_ima3_=:SEL_pts_ima3_,xy
  draw_sel_cross xy,wh
end.
NB. glshow ''
glpaint ''
)

transformimage_refresh_button=:tr_refresh_image

transformimage_clearpts_button=:3 : 0
SEL_pts_ima3_=:i.0 2
tr_refresh_image''
)

transformimage_open_button=:3 : 0
fi=.wd 'mbopen "Open Image" "" ""  "Bmp(*.bmp);Jpeg(*.jpg);Png(*.png)|*.bmp;*.jpg;*.png|All Files(*.*)|*.*"'
b=.raw_read_image fi
if. -. _1 -: b do. 
  image_to_hist b
  tr_draw_image b
  end.
)

transformimage_octrl_fkey=:transformimage_open_button

transformimage_vselpts_button=:3 : 0
wd 'mb "Selected Points" "',(,LF,.~ ": SEL_pts_ima3_ ),'"'
)

image_to_hist=: 3 : 0
tr_image_list_ima3_=:(<y),tr_image_list_ima3_
)

image_from_hist=:3 : 0
>{.tr_image_list_ima3_
)

NB. Back button
transformimage_back_button=:3 : 0
tr_image_list_ima3_=:1|.tr_image_list_ima3_
tr_draw_image image_from_hist ''
)
transformimage_bctrl_fkey=:transformimage_back_button

NB. Forward buttons
transformimage_forward_button=:3 : 0
tr_image_list_ima3_=:_1|.tr_image_list_ima3_
tr_draw_image image_from_hist ''
)

transformimage_fctrl_fkey=:transformimage_forward_button

NB. save button
transformimage_save_button=:3 : 0
fo=.wd 'mbsave "Save Image" "" ""  "Bmp(*.bmp);Jpeg(*.jpg);Png(*.png)|*.bmp;*.jpg;*.png|All Files(*.*)|*.*"'
(image_from_hist '') write_image fo
)

NB. clear history button
transformimage_clearhist_button=:3 : 0
tr_image_list_ima3_=:{.tr_image_list_ima3_
)

transformimage_sctrl_fkey=:transformimage_save_button

transformimage_win_mbldown=: 3 : 0
sd=.".sysdata
xy=.2{.sd
if. 1=7{sd do.
  wh=.2 3{sd  
  XY=.(0{sd),-/3 1{sd  NB.
  wh add_sel_pt XY     NB. had been xy
  mousetype=:0
  else.
  glcapture 3
  mousetype=:1,xy
  end.
)

transformimage_win_mblup=: 3 : 0
sd=.".sysdata
if. 1={.mousetype do.
  mouserect=: (}.mousetype),4{.sd
  glrgb tr_sel_color
  glpen 2 1
  fl=.(_1+{:mouserect)&-
  gllines (0 1,0 3,2 3,2 1,0 1){(0&{,fl@(1&{),2&{,fl@(3&{))mouserect
  glcapture 0
NB.   glshow ''
  glpaint ''
  end.
)

mouse_to_dij=:4 : 0
'W H M N'=.x
'x0 y0'=.y
y0=.H-y0+1
sw=. N%W
sh=. M%H
(sh*y0),sw*x0
)

transformimage_trim_button=: 3 : 0
if. 6=#mouserect do.
  'xy XY WH'=:3 2$mouserect  
  b=.image_from_hist ''  
  whmn=.WH,2{.$b
  dxy=.whmn mouse_to_dij"1  xy,:XY
  b=.(>.(>./-<./) dxy){.(<.<./dxy)}.b
  image_to_hist b
  tr_draw_image b
  mouserect=:i.0
end.
)

NB. processes resize input request
input_result_resize=:3 : 0
sz=.". y
b=.sz resize_image image_from_hist ''
image_to_hist b
tr_draw_image b
)

transformimage_resize_button=:3 : 0
load 'jinput'
a=.conew 'jinput'
input_result=:input_result_resize
a_run__a 'Enter Resize Bounds:';'512 512';'Resize'
)

NB. processes rescale input request
input_result_rescale=:3 : 0
'sw sh'=.". y
b=.image_from_hist ''
'H W'=.2{.$b
smoutput sw,sh
if. 1 ~: sw do.
  i=.<.0.5+sw%~i.<.0.5+sw*W
  b=.i{"1 2 b
  end.
if. 1 ~: sh do.
  i=.<.0.5+sh%~i.<.0.5+sh*H
  b=.i{b
  end.
image_to_hist b
tr_draw_image b
)

transformimage_rescale_button=:3 : 0
load 'jinput'
a=.conew 'jinput'
input_result=:input_result_rescale
a_run__a 'Enter WH Rescaling Factors:';'1.0 1.0';'Rescale'
)

NB. selection styles
tr_sel_color=:255 0 255
tr_sel_len=:10
tr_sel_pen=:2 1

NB. marks on image a selected point
draw_sel_cross=: 3 : 0
'x y w h'=.y
glrgb tr_sel_color
glpen tr_sel_pen
if. tr_sel_len <<./x,y,(w-x),h-y  do.
  gllines (,+&(2 0*tr_sel_len))(x-tr_sel_len),h-y
  gllines (,+&(0 2*tr_sel_len))x,(-tr_sel_len)+h-y
NB.   glshow ''
  glpaint ''
  end.
)

add_sel_pt=:4 : 0
d=. >./"1 | y-"1 SEL_pts_ima3_
if. *./ d>tr_sel_len do. 
  SEL_pts_ima3_=:SEL_pts_ima3_,y
  draw_sel_cross y,x
  else.
  i=.d i. <./d
  m0=.i~:i.#d
  oldpt=:(i{SEL_pts_ima3_),x
  SEL_pts_ima3_=:m0#SEL_pts_ima3_
tr_refresh_image ''
end.  
)

NB. process Remove Barrel Distortion request
transformimage_unbarrel_button=:3 : 0
n0=.#SEL_pts_ima3_
if. n0=3 do.
  c=.get_c ''
  z=. c barrel_undistort image_from_hist ''
  image_to_hist z
  tr_draw_image z
  else. wd 'mb "Unbarrel Error" "Unbarrel Requires 3 Selected Points"'
  end.
)

NB. view unbarrel coefficient 
transformimage_vunbarrelc_button=:3 : 0
if. 3=#SEL_pts_ima3_ do.
  c=.get_c ''
  wd 'mb "Unbarrel Coefficient" "Coef is: ',(":c),'"'
  else.
  wd 'mb "Unbarrel Error" "Unbarrel Requires 3 Selected Points"'
  end.
)

NB. close function
transformimage_close=: 3 : 0
wd'pclose'
)

transformimage_close_button=:transformimage_close

NB. launches help file if html browser is configured
NB. and help file is in the expected directory
transformimage_help_button=:3 : 0
require addon_path,'html_gallery8.ijs'
open_html addon_path,'help',dir_sep,'transform_m.html'
)

NB. set F1 to lauch help
transformimage_f1_fkey=:transformimage_help_button

NB. The about button
transformimage_about_button=:3 : 0
z=.'Transform_m.ijs is a J script'
z=.z,:'for use with the Image3 Addon'
z=.z,'It is used to transform images in a few ways.'
z=.z,'by Cliff Reiter'
z=.z,'Lafayette College'
z=.z,'March 2003'
wd 'mb "About Transform_m" "',(,z,"1 CRLF),'"'
)

NB. transform_image d
NB. where d is an image filename, or an array representing an image
transform_image =: transformimage_run

NB. ***********************
NB. Utilities for rotations
NB. ***********************

NB. apply rotation to seminormal coordinates 
sn_rot=: 4 : 0
'r t'=.10 12 o./ j./"1 y
t=. t+x
+. r r. t
)

NB. get angle from two points in range _1r2p1 to 1r2p1 
get_sel_pts_angle=:3 : '12 o. j./(**@{.)-/SEL_pts_ima3_'

NB. radians rotate_raw_image image
rotate_raw_image=: 4 : 0
wh=.|.hw=.2{.$y
y=.(y,{:a.),"_1 {:a.
cor=.,/>{;/0 0,.<:wh
x=.2p1&|&.(+&1p1) x
if. 1r2p1>:|x do. t=.|x else. t=.|1p1-|x end.
tcor=.wh sn_to_pix t sn_rot wh pix_to_sn cor
'dw dh'=.2 1{,cor-tcor
z=.((hw+2*dh,dw),3)${:a.
for_k. (-dh)+i.({.hw)+2*dh do.
  w=.j./"1 hw pix_to_sn k,.(-dw)+i. (2*dw)+{:hw
  t=.x+12 o. w
  r=.10 o. w
  in=.;/_1 >. hw <."1 hw sn_to_pix +.r r. t 
  z=.(in{y)(dh+k)}z
  end.
z
)

NB. process rotate to horizontal request
transformimage_rotateh_button=:3 : 0
if. 2~:#SEL_pts_ima3_ do. rotateh_err ''
  else.
  t=.get_sel_pts_angle ''
  z=.t rotate_raw_image image_from_hist ''
  image_to_hist z
  tr_draw_image z
  end.
)

NB. process rotate to vertical request
transformimage_rotatev_button=:3 : 0
if. 2~:#SEL_pts_ima3_ do. rotate_err ''
  else.
  t=.get_sel_pts_angle ''
  t=.t-1r2p1**t
  z=.t rotate_raw_image image_from_hist ''
  image_to_hist z
  tr_draw_image z
  end.
)

NB. process Request to view line angle
transformimage_vrotated_button=:3 : 0
if. 2=#SEL_pts_ima3_ do.
  a=.get_sel_pts_angle ''
  wd 'mb "Rotation Angle" "Rotation Angle is: ',( ":<.0.5+a*360%2p1),' degrees"'
  else.
  rotate_err ''
  end.
)

rotate_err=:3 : 0
wd 'mb "Rotate Error" "Two Points Should be Selected for Rotation to Vertical/Horizontal"'
)

NB. processes rotate by degrees request
input_result_rotated=:3 : 0
sz=.1r180p1* ". y
b=.sz rotate_raw_image image_from_hist ''
image_to_hist b
tr_draw_image b
)

transformimage_rotated_button=:3 : 0
load 'jinput'
a=.conew 'jinput'
input_result=:input_result_rotated
a_run__a 'Enter Degrees to Rotate Clockwise:';'45';'Degrees to Rotate'
)


NB. ******************************************
NB. Utilities for correcting barrel distortion
NB. ******************************************

NB. radius to barrel distorted radius RD
NB. c R_to_RD y
R_to_RD=: ] + [ * ^&3@]

NB. distorted radius to radius
NB. c RD_to_R y
p1_temp=.1 11 39 51 16&p.
p2_temp=.1 12 48 75 36&p.
RD_to_R=: ]* (p1_temp % p2_temp)@:([**:@]) f.

NB. pixel coordinates to seminormal _1 to 1 coordinates 
NB. preserving aspect ratio
NB. wh pix_to_sn ij
pix_to_sn=: 1 : 0
(y-"1-:m-1)%-:>./m-1
)

NB. seminormal to pixel coordinates
NB. wh sn_to_pix xy
sn_to_pix=: 1 : 0
<.0.5+(-:m-1)+"1 y*"1 -:>./m-1
)
NB. sn_to_pix=: 1 : 0
NB. [:<.@(0.5&+)(-:m-1)"_ +"1 (-:>./m-1)&*"1
NB. )

NB. sn_to_pix =: [: <.@(0.5&+) (-:@<:@[)+"1 ] *"1 -:@(>./)@:<:@[

NB. apply distortion to seminormal coordinates 
sn_dist=: 1 : 0
'r t'=.10 12 o./ j./"1 y
r=.m R_to_RD r
+. r r. t
)

NB. apply undistortion to seminormal coordinates 
sn_undist=: 1 : 0
'r t'=.10 12 o./ j./"1 y
r=.m RD_to_R r
+. r r. t
)

NB. c barrel_undistort raw_image
barrel_undistort=: 4 : 0
wh=.|.hw=.2{.$y
und=.wh sn_to_pix@(x sn_undist)@(wh pix_to_sn)
y=.(y,{:a.),"_1 {:a.
if. x<0 do.
'dw dh'=.|und 0 0
else.
'dw dh'=.-<./und -:wh*=i.2
end.
z=.((hw+2*dh,dw),3)${:a.
dsn=. -{.-/hw pix_to_sn 0 0,:1 1
w=.j./"1 hw pix_to_sn (-dh),.(-dw)+i. (2*dw)+{:hw
for_k. (-dh)+i.({.hw)+2*dh do.
  t=.12 o. w
  r=.|10 o. w
  r=.x R_to_RD r
  in=.;/_1 >. hw <."1 hw sn_to_pix +.r r. t 
  z=.(in{y)(dh+k)}z
  w=.w+dsn
  end.
NB. 'one'+1
z
)

NB. tries various coefficient for undistrotion and
NB. returns a signed measure of linearity
try_c=: 3 : 0"0
wh=.m_wh ''
-/ . * (}.-"1{.)y sn_undist"1 wh pix_to_sn SEL_pts_ima3_
)

NB. use mouse points to get c
get_c=:3 : 0
c=._0.5
h=.0.1
while. 0.0001<h do.
  t=.c+h*i.11
  i=.1 i:~0>(*{:)try_c t
  c=.i{t
  h=.0.1*h
  end.
c
)

NB. processes remove barrel distrotion request
input_result_unbarrelc=:3 : 0
s=.". y
b=.s barrel_undistort image_from_hist ''
image_to_hist b
tr_draw_image b
)

transformimage_unbarrelc_button=:3 : 0
load 'jinput'
a=.conew 'jinput'
input_result=:input_result_unbarrelc
t=.'Enter Unbarrel Coefficient',CRLF
t=.t,'Typical Value 0.1, Interesting Range _0.3 to 0.3'
if. 3=#SEL_pts_ima3_ do. c=.": get_c '' else. c=.'_0.08' end.
a_run__a t;c;'Unbarrel by Coefficient'
)

NB. ***********************************************
NB. Utilities for moving four points to a rectangle
NB. ***********************************************
bal_4=:3 : 0
s=.y /: 2p1|12 o. j./"1 y-"1(+/%#)y
xa=._1|.2#_2 (+/%#)\ {."1 ]1|.s
ya=.2#_2 (+/%#)\ {:"1 s
s,:xa,.ya
)

transformimage_tiltr_button=: 3 : 0
if. 4=#SEL_pts_ima3_ do.
  a=.get_tilt_a |."1 get_tilt_pts ''
  b=.a trans_tilt image_from_hist ''
  image_to_hist b
  tr_draw_image b
else. wd 'mb "Error on Tilt" "Tilt to Rectangle needs 4 selected points"' 
end.
)

m_wh=: 3 : 0   NB. mouse wh
wd 'psel transformimage'
_2{.". wd 'qchildxywhx win'
)

sn_flip1=:1 _1&*"1

get_tilt_pts=:3 : 0
wh=.m_wh ''
bal_4 sn_flip1 wh pix_to_sn SEL_pts_ima3_
)

get_tilt_a=:3 : 0
({.y) %. (1:,],*/)"1 {: y
)

NB. coef trans_tilt image
trans_tilt=:4 : 0
to_tilt=:((+/ . * )&x)@:(1:,],*/)"1 
wh=.|.hw=.2{.$y
y=.(y,{:a.),"_1 {:a.  NB. pad white edge
dh=.dw=.0
z=.((hw+2*dh,dw),3)${:a.
for_k. (-dh)+i.({.hw)+2*dh do.
  in=.;/_1 >. hw <."1 hw sn_to_pix to_tilt hw pix_to_sn k,.(-dw)+i. (2*dw)+{:hw
  z=.(in{y)(dh+k)}z
  end.
z
)

NB. ***********************************************
NB. Utilities for nonlinear stretching in horz/vert
NB. ***********************************************
bal_horz=:3 : 0
yy=.image_from_hist ''
WH=:1 0{$yy
W=:{.WH
xx=./:~{."1 WH sn_to_pix (m_wh'') pix_to_sn SEL_pts_ima3_
h=.xx +/ . * -:_1 1 _1 1
'x0 x1 x2 x3'=.xx
p=.(xx %.(x0,(x0+h),x2,x2+h)^/i.4)&p.
i=.<.0.5+p (--:W)+i.+:W
i=.((i>:0)*.i<W)#i
i{"1 2 yy
)

transformimage_balanceh_button=: 3 : 0
if. 4=#SEL_pts_ima3_ do.
  b=.bal_horz ''
  image_to_hist b
  tr_draw_image b
else. wd 'mb "Error on Tilt" "Balance Horizontal uses 4 selected points on a horizontal line"' 
end.
)

bal_vert=:3 : 0
yy=.image_from_hist ''
WH=:1 0{$yy
H=:{:WH
xx=.(H-1)-/:~{:"1 WH sn_to_pix (m_wh'') pix_to_sn SEL_pts_ima3_
h=.xx +/ . * -:_1 1 _1 1
'x0 x1 x2 x3'=.xx
p=.((h+x0,x2)%.1,.x1,x3)&p.
p=.((x0,(h+x0),x2,h+x2)%.1,.xx,.xx^2)&p.
p=.(xx %.(x0,(x0+h),x2,x2+h)^/i.4)&p.
i=.<.0.5+p (--:H)+i.+:H
i=.((i>:0)*.i<H)#i
i{yy
)

transformimage_balancev_button=: 3 : 0
if. 4=#SEL_pts_ima3_ do.
  b=.bal_vert ''
  image_to_hist b
  tr_draw_image b
else. wd 'mb "Error on Tilt" "Balance Vertical uses 4 selected points on a vertical line"' 
end.
)

