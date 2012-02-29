NB. viewmat init

require 'graphics/bmp gui/gtkwd'

coclass 'jviewmat'


coinsert 'jgl2'

MINWH=: 200 200 NB. minimum initial child pixel size
VMH=: '' NB. viewmat handles
GID=: 'g' NB. isigraph control id
ifRGB=: 0
SHOW=: 0 NB. set to 1 after first show

NB. =========================================================
create=: vmrun

NB. =========================================================
destroy=: 3 : 0
hremove''
wd 'pclose'
codestroy''
)

NB. viewmat util

finite=: x: ^: _1
intersect=: e. # [
citemize=: ,: ^: (2: > #@$)
rndint=: <.@:+&0.5
tomatrix=: (_2 {. 1 1 , $) $ ,

NB. =========================================================
fitvm=: 4 : 0
'w h'=. x
mat=. y
'r c'=. $ mat
exp=. (- 0: , }:) <. 0.5 + +/\ r $ h % r
mat=. exp # mat
exp=. (- 0: , }:) <. 0.5 + +/\ c $ w % c
exp #"1 mat
)

NB. =========================================================
delinf=: 3 : 0
if. +:/ _ __ e. ,y do. y return. end.
sc=. 0.1
a=. (,y) -. _ __
max=. >./a
min=. <./a
ext=. sc * max - min
(min-ext) >. y <. max+ext
)

NB. =========================================================
NB. getbmp v get graphics window as bitmap
NB.
NB. y is optional child id
getbmp=: 3 : 0
gid=. y, (0=#y) # GID
glsel gid
box=. 0 0,glqwh''
res=. glqpixels box
(3 2 { box) $ res
)

NB. =========================================================
NB.*gethue v generate color from color set
NB. x is color set
NB. y is values from 0 to 1, selecting color
gethue=: 4 : 0
y=. y*<:#x
b=. x {~ <.y
t=. x {~ >.y
k=. y-<.y
(t*k) + b*-.k
)

NB. =========================================================
NB. getvm
NB.
NB. form: hue getvm data [;title]
NB.
NB. hue may be empty, in which case a default is used
NB. hue may be a N by 3 matrix of colors or a vector
NB.     of RGB integers.
NB.
NB. returns:
NB.   original data
NB.   scaled data matrix
NB.   angle (if any)
NB.   title
getvm=: 4 : 0
'dat tit'=. 2 {. boxopen y
tit=. ": tit
tit=. tit, (0=#tit) # 'viewmat'
if. ifRGB do.
  mat=. dat
  ang=. ''
else.
  'mat ang'=. x getvm1 dat
end.
dat ; mat ; ang ; tit
)

NB. =========================================================
getvm1=: 4 : 0
hue=. x
mat=. y
ang=. ''

NB. ---------------------------------------------------------
if. 2 > #$hue do.
  hue=. |."1 [ 256 256 256 #: ,hue
end.

NB. ---------------------------------------------------------
select. 3!:0 mat
case. 2;32 do.
  mat=. (, i. ]) mat
case. 16 do.
  ang=. * mat
  mat=. delinf | mat
case. do.
  mat=. finite mat
end.

NB. ---------------------------------------------------------
select. #$mat
case. 0 do.
  mat=. 1 1$mat
case. 1 do.
  mat=. citemize mat
case. 3 do.
  'mat ang'=. mat
end.

NB. ---------------------------------------------------------
if. */ (,mat) e. 0 1 do.
  if. #hue do.
    h=. <. 0 _1 { hue
  else.
    h=. 0 ,: 255 255 255
  end.
  mat=. mat { h

else.
  if. #hue do.
    h=. hue
  else.
    h=. 255 * #: 7 | 3^i.6
  end.
  val=. ,mat
  max=. >./ val
  min=. <./ val
  mat=. <. h gethue (mat - min) % max - min
end.

mat=. mat +/ .* 65536 256 1

mat ; ang

)

NB. =========================================================
hadd=: 3 : 0
VMH_jviewmat_=: (<HWNDP), 1{"1 hforms''
)

NB. =========================================================
NB. cascade new form
hcascade=: 3 : 0
vmf=. hforms ''
if. #vmf do.
  rec=. (<0 1) pick vmf
  siz=. _2 {. 0 ". wd 'qformx'
  prv=. 2 {. 0 ". wd 'psel ',rec,';qformx'
  txy=. prv + 32
  max=. 2 3 { 0 ". wd 'qscreen'
  txy=. txy * *./ max >: txy + siz
  wd 'psel ',HWNDP
  wd 'pmovex ',":txy,siz
end.
)

NB. =========================================================
NB. hforms
NB.
NB. returns viewmat forms, in order of recent activity
hforms=: 3 : 0
fms=. <;._2 &> <;._2 wd 'qpx'
fms=. fms #~ (1{"1 fms) e. VMH
fms \: 0 ". &> 4{"1 fms
)

NB. =========================================================
hremove=: 3 : 0
VMH_jviewmat_=: (1{"1 hforms'') -. <HWNDP
)


NB. cc

NB. =========================================================
vmcc=: 4 : 0
ifRGB=: x -: 'rgb'
'mat gid'=. y
glsel GID=: gid
'DAT MAT ANG TITLE'=: x getvm mat
mat=. finite MAT
'rws cls'=. $mat
glsel GID
mwh=. glqwh''
if. #ANG do. mwh vf_show mat return. end.
mat=. , mwh fitvm mat
glpixels (0 0, mwh), mat
)


NB. field

NB. =========================================================
NB. fit view field
NB.
NB. the fit linearly interpolates across both dimensions.
NB.
NB. this is crude and can result in border lines being
NB. shown in the final image
NB.
NB. also probably better to interpolate color indices, rather
NB. than colors, to reduce time taken in the float to integer
NB. conversion of the RGB color array

fitvf=: 4 : 0

hw=. |. x

'h w'=. hw

mat=. y
'r c'=. s=. $ mat

mat=. ({."1 mat),.mat,.{:"1 mat
mat=. ({.mat),mat,{:mat

mat=. 256 256 256 #: mat

'r2 c2'=. s + 2
'h2 w2'=. <. hw * (r2,c2) % r,c

x=. (c2-1) * (i.w2+1) % w2
k=. x - <. x
b=. (<.x) {"2 mat
t=. (>.x) {"2 mat
mat=. (t *"2 k) + b *"2 -.k

x=. (r2-1) * (i.h2+1) % h2
k=. x - <. x
b=. (<.x) { mat
t=. (>.x) { mat
mat=. (t * k) + b * -.k

NB. most time is taken by the conversion to integer
NB. this has to be done prior to the 256 #.
mat=. 256 #. >. mat

'xr xc'=. <. -: ($mat) - hw
hw {. xc }."1 xr }. mat
)

NB. =========================================================
NB. vf_show
NB.
NB. show matrix as field
NB.
NB. y is 0 = initial setting
NB.       1 = resize
vf_show=: 4 : 0

mwh=. x
mat=. y
'rws cls'=. $mat
mat=. , mwh fitvf mat

glrgb 0 0 0
glpen 1 0
glbrush''

glpixels (0 0, mwh), mat

NB. len is the number of pixels in the shortest direction
len=. <. <./ 'scls srws'=. mwh % cls,rws

NB. midpoints:
x=. (-:scls) + scls * i. cls
y=. (-:srws) + srws * i. rws
mid=. x j."1 0 y

if. len < 3 do.
elseif. len e. 3 4 do.
  pixel=. _1 + i.len
  glpixel _2 [\ , rndint +."1 mid + + ANG */ pixel
elseif. len < 20 do.
  ext=. -: len * 0.75
  lines=. ext ,. (-ext), ext - ext * 0.7 * 1j0.8
  gllines _4 [\ , rndint +."1 mid + + ANG */ lines
elseif. do.
  ext=. -: len * 0.75
  lines=. ext , -ext
  gllines _4 [\ , rndint +."1 mid + + ANG */ lines
  poly=. ext - 0,(10 <. len*0.2) * 1j0.6,0.6,1j_0.6
  glpolygon _8 [\ , rndint +."1 mid + + ANG */ poly
end.

)



NB. viewmat methods

NB. =========================================================
NB.*closeall v close all viewmat windows
closeall=: 3 : 0
fms=. hforms''
hnd=. 1 {"1 fms
lcs=. 2 {"1 fms
for_h. hnd do.
  wd 'psel ',(>h),';pclose'
end.
coerase lcs
VMH_jviewmat_=: ''
)

NB. =========================================================
NB. getsize
NB.
NB. get pixel size
getsize=: 3 : 0
fms=. hforms''
if. 0=#fms
do. wdinfo 'viewmat';'No viewmat forms.' return.
end.
wd 'psel ',(<0 1) pick fms
_2 {. 0 ". wd 'qchildxywhx ',GID
)

NB. =========================================================
NB.*readmat v read viewmat as bitmap
readmat=: 3 : 0
fms=. hforms''
if. 0=#fms
do. wdinfo 'viewmat';'No viewmat forms.' return.
end.
wd 'psel ',(<0 1) pick fms
getbmp''
)

NB. =========================================================
NB.*savemat v save viewmat to .bmp file
savemat=: 3 : 0
fl=. y
if. 0 = #fl do.
  fl=. jpath '~temp/viewmat.bmp'
end.
fms=. hforms''
if. 0=#fms
do. wdinfo 'viewmat';'No viewmat forms.' return.
end.
wd 'psel ',(<0 1) pick fms
(getbmp'') writebmp fl
)

NB. =========================================================
NB. setsize
NB.
NB. y = new pixel size
setsize=: 3 : 0
fms=. hforms''
if. 0=#fms
do. wdinfo 'viewmat';'No viewmat forms.' return.
end.
loc=. (<0 2) { fms
wd 'psel ',(<0 1) pick fms
form=. 0 ". wd 'qformx'
xywh=. 0 ". wd 'qchildxywhx ',GID
dif=. 0 0, y - _2 {. xywh
wd 'pmovex ',":form + dif
)

NB. =========================================================
NB.*viewbmp v bitmap viewer
NB.
NB. x = [parentid [;parentname]]
NB. y = filename
NB.
NB. e.g.  viewbmp jpath '~system\examples\data\j.bmp'
viewbmp=: 3 : 0
'' viewbmp y
:
dat=. readbmp y
if. 2 = 3!:0 dat do. return. end.
'rgb' viewmat dat;x
)

NB. =========================================================
NB.*viewmat v view matrix in isigraph control
NB.
NB. [hue] viewmat mat [;title]
NB.
NB. mat may be one of:
NB.    boolean         (black/white)
NB.    other numeric   (color scale from 0 upwards)
NB.    other           (converted to numeric)
NB.
NB. hue is: 3 column table of R-G-B triplets
NB.     or: list of RGB values
NB.     or: 'rgb'  - mat is an matrix of RGB values
NB.
NB. if mat is boolean, x defaults to black/white
NB. otherwise hue defaults to red - purple spectrum
NB.
NB. e.g. viewmat (?50 50$2);'Random Boolean'
viewmat=: 3 : 0
'' viewmat y
:
a=. conew 'jviewmat'
empty x vmrun__a y
)

NB. =========================================================
NB.*viewmatcc v view matrix in given child control
NB.
NB. [hue] viewmatcc mat;cc
NB.
NB. hue and mat are as for viewmat
NB.
NB. cc is the id of the isigraph control.
viewmatcc=: 3 : 0
'' viewmatcc y
:
empty x vmcc y
)


NB. viewmat win

NB. =========================================================
vmrun=: 4 : 0
SHOW=: 0
ifRGB=: x -: 'rgb'
'DAT MAT ANG TITLE'=: x getvm y
wd 'pc jvm;pn *',TITLE
NB. if. IFWINCE do.
NB.   a=. 0 ". wd 'qm'
NB.   s=. -: ({.a),-/15 13 { a
NB.   wd 'xywh 0 0 ',":s
NB.   wd 'cc g isigraph;pas 0 0;pcenter'
NB. else.
NB.   wd 'xywh 0 0 180 180;cc g isigraph rightmove bottommove;pas 0 0;pcenter'
NB. end.
wd 'xywh 0 0 180 180;cc g isigraph rightmove bottommove;pas 0 0;pcenter'
HWNDP=: wd 'qhwndp'
hcascade''
hadd''
mat=. finite MAT
'rws cls'=. $mat
gwh=. glqwh''
mwh=. cls,rws
if. -. ifRGB do.
  mwh=. MINWH >. <. mwh * <./ gwh % cls,rws
end.
dif=. mwh - gwh
'fx fy fw fh'=. 0 ". wd 'qformx'
wd 'pmovex ',": 0 >. fx,fy,dif + fw,fh
wd 'pshow'
)

NB. =========================================================
NB. jvm_show
NB. SHOW is 0 = initial setting
NB.         1 = resize
jvm_show=: 3 : 0
glsel GID
mat=. finite MAT
'rws cls'=. $mat
glsel GID
gwh=. glqwh''
if. ifRGB > SHOW do.
  glbrush glrgb 0 0 0
  glrect 0 0,gwh
  mwh=. cls,rws
else.
  mwh=. gwh
end.
if. #ANG do. mwh vf_show mat return. end.
mat=. , mwh fitvm mat
glpixels (0 0, mwh), mat
SHOW=: 1
)

NB. =========================================================
jvm_cancel=: jvm_close=: destroy
jvm_g_paint=: jvm_show


NB. viewmat zdefs

viewmat_z_=: viewmat_jviewmat_
viewbmp_z_=: viewbmp_jviewmat_
viewrgb_z_=: 'rgb' & viewmat_jviewmat_


