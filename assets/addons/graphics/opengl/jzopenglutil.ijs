require 'gtk bmp colortab gl3 numeric trig'

coclass 'jzopenglutil'
coinsert 'jgl3'
gsarctanr=: {.@+.@(_3&o.)
gscheckers=: ]{.[$~]+2&|@>:@]
gschgsign=: * _1&^
gscile=: $@] $ ((* <.@:% #@]) /:@/:@,)
gscleanz=: * | >: 1e_10"_
gscross=: +/ .* (3 3 3$0 0 0 0 0 _1 0 1 0 0 0 1 0 0 0 _1 0 0 0 _1 0 1 0 0 0 0 0)&(+/ .*)
gscutxyz=: <"2@(0 1&|:)
gsdeal=: (? #) { ]
gsdealf=: (?. #) { ]
gsdealone=: (?@#) { ]
gsdet=: -/ .*
gsdist=: +/&.(*:"_)
gsdrange=: {:-{.
gsfitin=: {.@[ + ({: - {.)@[ * ((- <./@,) % (>./ - <./)@,)@]
gsfit01=: (- <./@,) % (>./ - <./)@,
gsfit11=: (- <./@,) <:@% ([: -: >./ - <./)@,
gsfix=: _1&".
gsfmtint=: ":@:<.@(0.5&+)
gsindex=: [ ((#@[ = ]) { ] , _1:) i.
gsint01=: i.@>: % ]
gsint012=: gsint01@{. ,."0 1 |.@gsint01@{:
gsmid11=: - ([: -: >./ + <./)@,
gsmp=: +/ . *
gspfmt=: gstominus@":
gspm=: +/ . * ~
gstomatrix=: (_2 {. 1 1 , $) $ ,
gsnthword=: +/\@(> 0: , }:)@(~:&' ')@] i. >:@[
gspartition=: 1: , [: -. }: -:"_1 }.
gsranges=: (<./,>./) @ ,
gsrand01=: ?@$ 0:
gssignal=: 13!:8&12
gstonum=: 0&". ;. _2
gstominus=: '-'&(I. @(e.&'_')@]})
gsunitnormal=: (% +/&.(*:"_))@(+/)@(_3&(]\))"1
gsunitvec=: % gsdist f.
gswraptext=: DEL&,@(,&DEL) L:0
gscol3=: 3 : 0
if. 1=#$y do. y=. _3 [\ y end.
if. 3 < {:$y do. y=. ,/"3 [ _3 [\"1 y end.
3 {."1 y
)
gshue=: 4 : 0
y=. y*<:#x
b=. x {~ <.y
t=. x {~ >.y
k=. y-<.y
(t*k)+b*-.k
)
gsncile=: 4 : 0
min=. <./,y
max=. >./,y
step=. }: min+(max-min)*(i.>:x)%x
<: +/ step <:/ y
)
gsnormalize=: 3 : 0
v=. (-"1 +/ % #) y
gscleanz v % >./ gsdist"1 v
)
gspack=: [: /:~ [: (, ,&< ".) &> ;: ::]
gspdef=: 3 : 0
if. 0 e. $y do. empty'' return. end.
names=. {."1 y
if. #names do. (names)=: {:"1 y end.
names
:
names=. {."1 y
nl=. ;: ::] x
gspdef (names e. nl)#y
)
gsrgba=: 3 : 0
0 gsrgba y
:
if. x do.
  y=. (2^32) | y
  255 %~ |."1[ 256 256 256 256 #: y
else.
  y=. gscolor4 y
  y=. ,_2(3!:4)"1 a.{~ >. 255 * y
  <. y - (y >: 2^31) * 2^32
end.
)
gsshownouns=: 3 : 0
round=. <.@:+&0.5&.(%&0.0001)
cat=. ,&,.&.|:
x=. (>:>./# &> y) {. each y
f=. ]`round @. (e.&8 @ (3!:0))
y=. ":@f@". each y
r=. x cat each y
> ,&.>/ r
)
gssphere2rect=: 3 : 0
'r t p'=. y
r * (1 1 2 o. t) * (2 1 o. p), 1
)
gssurfacerev=: 10&$: : (4 : 0)
'r z'=. |: y
ix=. i. x+2
'x y'=. 0 1 |: r */ +. r. ix * 2p1%x
x,"0 1 y,"0 z
)
c=. (}: ,:"1 }.)"2
d=. (}. ,:"1 }:)"2
gstiles=: (c@}: ,"2 d@}.) f.
GS_ID3=: = i.3
GS_ID4=: = i.4
gsnewlist=: 3 : 0
if. 0=#y do.
  y=. {. > gsgenlist ''
end.
glNewList y,GL_COMPILE
y
)

gsendlist=: glEndList
gsdefknot=: 3 : 0
if. y <: 7 do.
  0 1 #~ (<.,>.) -: y
else.
  0 0 0, (, 3: # {:) i. y-6
end.
)
gsgenlist=: 3 : 0
r=. 5001 while. glIsList r do. r=. >:r end.
)
gsgeterror=: 3 : 0
if. #j=. glGetError$0 do. wdinfo 'OpenGL';memr 0 _1,~0{::gluErrorString j end.
)
gswritebmp=: 3 : 0
f=. y, (0=#y)#'~temp/opengl'
f=. jpath f, (-.'.bmp'-:_4 {.f) # '.bmp'
p=. pixels__ogl ''
s=. |. wh__ogl
(s$p) writebmp f
)
gssnap=: 3 : 0
j=. 'GS_ROTNDX GS_ROTXYZ GS_SPEED GS_TRNXYZ GS_VIEWUP GS_VIEWXYZ'
j=. gspack j,' GS_UNITROT GS_UNITSTEP GS_UNITSCALE'
GS_STATE1=: j
if. y=0 do. GS_STATE0=: j end.
empty''
)
gstate=: 3 : 0

if. 1{.y do.
  nms=. <;._2 GS_STATEALL
else.
  nms=. <;._2 GS_STATEPOS
end.

j=. GLU_FILL,GLU_OUTLINE_PATCH,GLU_OUTLINE_POLYGON
k=. 'FILL';'OUTLINE_PATCH';'OUTLINE_POLYGON';GS_DISPLAYMODE
GS_DISPLAYMODE=. (j i. GS_DISPLAYMODE) pick k

j=. GL_NEAREST, GL_LINEAR
k=. 'NEAREST';'LINEAR';GS_TEXFILTER
GS_TEXFILTER=. (j i. GS_TEXFILTER) pick k

j=. GL_DECAL,GL_BLEND,GL_MODULATE
k=. 'DECAL';'BLEND';'MODULATE';GS_TEXMODE
GS_TEXMODE=. (j i. GS_TEXMODE) pick k

j=. GL_CLAMP,GL_REPEAT
k=. 'CLAMP';'REPEAT';GS_TEXWRAP
GS_TEXWRAP=. (j i. GS_TEXWRAP) pick k
if. 2 ~: {:GS_ROTNDX do.
  f=. 'gsflipd',1.0":2,{:GS_ROTNDX
  INIXYZ=. f~ GS_ROTXYZ
else.
  INIXYZ=. GS_ROTXYZ
end.
INIXYZ=. 360 | roundint INIXYZ
GS_ROTXYZ=. 360 | roundint GS_ROTXYZ
GS_VIEWLINE=. 0.01 round GS_VIEWLINE
GS_VIEWUP=. 0.01 round GS_VIEWUP
GS_VIEWXYZ=. 0.01 round GS_VIEWXYZ

round=. <.@:+&0.5&.(%&0.0001)
cat=. ,&,.&.|:
x=. (2 + >./# &> nms) {. each nms
f=. ]`round @. (e.&8 @ (3!:0))
y=. ":@f@". each nms
r=. x cat each y
> ,&.>/ r
)
gsfontbmpw=: 3 : 0
y glaUseFontBitmaps__ogl 32 95 32
)
gsfontoutw=: 3 : 0
y glaUseFontOutlines__ogl 32 95 32
)
makelist=: 2 : 0
glNewList n,GL_COMPILE
u y
glEndList''
:
glNewList n,GL_COMPILE
x u y
glEndList''
)
gsmaketube=: 3 : 0
h=. {:"1 y
x=. 0 1{"1 y
y=. 2 3{"1 y
xy=. -: x+y
r=. (x,.0) , (xy,.h) , (y,.0) ,: xy,.-h
r=. r , 2{.r
0 2 1{"1 [ 1 0 2 |: r
)
gsmakexyz=: 3 : 0
error=. 'error in gsmakexyz' & (13!:8) bind 12
t=. y
if. 0 = L. t do.
  t=. (i. each $t),<t
end.
'x y z'=. t
shp=. $ each t
if2=. 2 = # &> shp
mat=. +/if2
if. 1=mat do.
  rxy=. ;(-.if2)#shp
  rmat=. ;if2#shp
  if. rxy -: |.rmat do.
    nm=. if2#'xyz'
    ".nm,'=.|:',nm
  elseif. -. rxy -: rmat do.
    error''
  end.
elseif. 2=mat do.
  rz=. ;(-.if2)#shp
  rs=. if2#shp
  rxy=. 0 pick rs
  if. (-:/rs) *: (rz e. rxy) do.
    error''
  end.
elseif. 3=mat do.
  if. -. shp -: 3${.shp do.
    error''
  end.
  rxy=. 0 pick shp
elseif. 1 do.
  error''

end.
'r c'=. rxy
if. 2>#$x do.
  x=. c#"1,.x
end.
if. 2>#$y do.
  y=. rxy$y
end.
if. 2>#$z do.
  z=. rxy$z
end.
x ,"0 1 y ,"0 z
)
c=. toupper COLORTABLE
val=. ". c

k=. +/"1 val
msk=. (255<:k) *. k<:255*2

GS_STDCLR=: 255 %~ msk#val
GS_STDCLR=: (#GS_STDCLR) gsdeal GS_STDCLR

gscolor01=: ]`(%&255) @. (1 e. 1 < ,)
gscolor4=: ((3 $ gscolor01) , [: {. (3 }. ]) , 1:) "1
alpha4=: 4 {. ] , 1:

gscolor=: glColor @ gscolor4
gsclearcolor=: glClearColor @ gscolor4
GS_STATE0=: GS_STATE1=: ''
gsetdefaults=: 3 : 0
GS_AMBIENT=: 0.15 0.15 0.15 1
GS_AXISCOLOR=: WHITE
GS_BITMAPSIZE=: ''
GS_CLEARCOLOR=: BLACK
GS_COLOR=: RED
GS_COLORMATERIAL=: 1
GS_DIFFUSE=: 0.7 0.7 0.7 1
GS_DISPLAYMODE=: GLU_FILL
GS_MATSPECULAR=: 1 1 1 1
GS_ORTHO=: 6 $ 10 * _1 1
GS_PAINTER=: 'paint'
GS_PERSPECTIVE=: 30 1 1 15
GS_POSITION=: ''
GS_QWH=: ''
GS_ROTNDX=: 0 1 2
GS_ROTXYZ=: 0 0 0
GS_SAMPLINGTOL=: 20
GS_SHININESS=: 100 0 0 1
GS_SHOWAXES=: 0
GS_SHOWPOINTS=: 0
GS_SPECULAR=: 0.7 0.7 0.7 1
GS_SPEED=: 1
GS_SPEEDS=: (%16 8 4 2),1 2 4 8 16
GS_SPOTXYZ=: 0 0 _1
GS_SPOTEXPONENT=: 0
GS_SPOTCUTOFF=: 180
GS_TEXCOLOR=: WHITE
GS_TEXFILTER=: GL_NEAREST
GS_TEXMODE=: GL_MODULATE
GS_TEXWRAP=: GL_CLAMP
GS_TRNXYZ=: 0 0 0
GS_UNITROT=: 3
GS_UNITSTEP=: 0.025
GS_UNITSCALE=: 0.02
GS_VIEWLINE=: 0 0 0
GS_VIEWUP=: 0 1 0
GS_VIEWXYZ=: 0 0 6
GS_UORDER=: 0
GS_VORDER=: 0
)
GS_STATEALL=: 0 : 0
GS_AMBIENT
GS_AXISCOLOR
GS_BITMAPSIZE
GS_CLEARCOLOR
GS_COLOR
GS_COLORMATERIAL
GS_DIFFUSE
GS_DISPLAYMODE
GS_MATSPECULAR
GS_ORTHO
GS_PAINTER
GS_PERSPECTIVE
GS_POSITION
GS_QWH
GS_ROTNDX
GS_ROTXYZ
GS_SHININESS
GS_SHOWAXES
GS_SHOWPOINTS
GS_SPECULAR
GS_SPEED
GS_SPEEDS
GS_SPOTXYZ
GS_SPOTEXPONENT
GS_SPOTCUTOFF
GS_TEXCOLOR
GS_TEXFILTER
GS_TEXMODE
GS_TEXWRAP
GS_TRNXYZ
GS_UNITROT
GS_UNITSTEP
GS_UNITSCALE
GS_VIEWLINE
GS_VIEWUP
GS_VIEWXYZ
GS_UORDER
GS_VORDER
)
GS_STATEPOS=: 0 : 0
GS_ROTNDX
GS_SPEED
GS_TRNXYZ
GS_UNITROT
GS_UNITSTEP
GS_UNITSCALE
GS_VIEWUP
GS_VIEWXYZ
)

gsetdefaults''
gsdrawaxes=: 1&$: : (4 : 0)
dat=. _1 0 0, 1 0 0, 0 _1 0, 0 1 0, 0 0 _1, 0 0 1
dat=. dat * ($dat)$x
gsdrawlines dat;'';y
)
gsdrawpaxes=: 1&$: : (4 : 0)
dat=. 0 0 0, 0 0 1, 0 0 0, 0 1 0, 0 0 0, 1 0 0
dat=. dat * ($dat)$x
gsdrawlines dat;'';y
)
gsdrawlines=: 3 : 0
'v s c'=. y
v=. gscol3 v
if. #s do. glLineWidth s end.
if. #c do. gscolor c end.
glBegin GL_LINES
glVertex v
glEnd''
)
gsdrawlinestrip=: 3 : 0
'v s c'=. y
v=. gscol3 v
if. #s do. glLineWidth s end.
if. #c do. gscolor c end.
glBegin GL_LINE_STRIP
glVertex v
glEnd''
)
gsdrawpoints=: 3 : 0
'v s c'=. y
v=. gscol3 v
if. #s do. glPointSize s end.
if. #c do. gscolor c end.
glBegin GL_POINTS
glVertex v
glEnd''
)
gsdrawpolygon=: 3 : 0 "2
'v n c'=. y
v=. gscol3 v
if. #n do. glNormal n end.
if. #c do. gscolor c end.
glBegin GL_POLYGON
glVertex v
glEnd''
)
gsdrawsolid=: 3 : 0
'v n c'=. y
ndx=. #n
if. 0 e. #c do. c=. ndx gsdealf GS_STDCLR end.
c=. ndx $ gstomatrix c
while. ndx do.
  ndx=. <:ndx
  gscolor ndx{c
  glBegin GL_POLYGON
  glNormal ndx{n
  glVertex _3 [\ ndx{v
  glEnd''
end.
)
gsdrawsphere=: 3 : 0
obj=. {:QUADS
gluQuadricDrawStyle obj,GLU_FILL
gluQuadricNormals obj,GLU_SMOOTH
gluQuadricTexture obj,1
gluSphere obj,y
)
gsdrawtubes=: 3 : 0
'v s c'=. y
v=. gscol3 v
s=. 2$s,(0=#s)#0.03
if. 0=#QUADS do. QUADS=: gluNewQuadric'' end.
if. #c do. gscolor c end.
s gsdrawtube1 _2 <\ v
)
gsdrawtubestrip=: 3 : 0
'v s c'=. y
v=. gscol3 v
v=. ,}: v ,. 1|.v
gsdrawtubes v;s;c
)
gsdrawtube1=: 4 : 0 "1 0
size=. x
glPushMatrix''
v=. -/ 'f t'=. >y
len=. gsdist v
glTranslate f
'x y z'=. 1 1 _1 * v % len
angle=. dfr arccos 1 <. z
axis=. y,-x,0
glRotate angle,axis
gluCylinder ({:QUADS),size,len,10 1
glPopMatrix''
)
gsdrawviewbox=: 1&$: : (4 : 0)
dat=. _3[\ ,(%{.@,) 1 pick gscube''
dat=. x *"1 dat
glPushAttrib GL_LIGHTING_BIT
glDisable GL_LIGHTING
gsdrawlines dat;'';y
glEnable GL_LIGHTING
glPopAttrib''
)
Jin=: (16 17 20 22 21 23 { a.), '123456789iojklxyz',a.
Jout=: 33 34 37 39 38 40, a.i.'123456789IOJKLXYZ',a.
gschar=: 3 : 0
try.
  key=. Jout {~ Jin i. {. sysdata
catch.
  key=. {. sysdata
end.
('1' = {.sysmodifiers) gskey key
gspaint''
)
gschar_gtk=: 3 : 0
'widget event data'=. y
'state key'=. _2 ic memr event, GdkEventKey, 8 ,JCHAR
'shift lock control mod1 mod2 mod3 mod4 mod5 button1 button2 button3 button4 button5'=. 13{. state=. |.(32#2) #: GDK_MODIFIER_MASK (17 b.) state
'super hyper meta'=. 26 27 28{state
z=. 0  
if. key e. GDK_F1 + <:i.12 do.
  if. 0 0 0-:shift,control,meta do.
    select. >: key - GDK_F1
    case. 3 do. z=. 1 [ gssnap 1
    case. 4 do. z=. 1 [ gspaint gspdef GS_STATE1
    case. 5 do. z=. 1 [ 0 gsrotone 45 0 0
    case. 6 do. z=. 1 [ 1 gsrotone 0 45 0
    case. 7 do. z=. 1 [ 2 gsrotone 0 0 45
    end.
  elseif. 1 0 0-:shift,control,meta do.
    select. >: key - GDK_F1
    case. 4 do. z=. 1 [ gspaint gspdef GS_STATE0
    case. 5 do. z=. 1 [ 0 gsrotone _45 0 0
    case. 6 do. z=. 1 [ 1 gsrotone 0 _45 0
    case. 7 do. z=. 1 [ 2 gsrotone 0 0 _45
    end.
  elseif. 0 1 0-:shift,control,meta do.
    select. >: key - GDK_F1
    case. 5 do. z=. 1 [ 0 gsrotone 180 0 0
    case. 6 do. z=. 1 [ 1 gsrotone 0 180 0
    case. 7 do. z=. 1 [ 2 gsrotone 0 0 180
    end.
  end.
else.
  if. 0 0 -: control, meta do.
    z=. shift gskey key
  end.
end.
if. z do.
  gspaint''
  1 return. 
end.
0
)
gskey=: 4 : 0
z=. 0  
select. y
case. 33;34 do.
  z=. 1 [ ((x { 1 5) * GS_SPEED*GS_UNITROT gschgsign y=34) gsfly GS_VIEWXYZ
case. 37;39 do.
  z=. 1 [ ((x { 1 5) * GS_SPEED*GS_UNITROT gschgsign y=37) gsfly GS_VIEWUP
case. 38;40 do.
  z=. 1 [ ((x { 1 5) * GS_SPEED*GS_UNITROT gschgsign y=40) gsfly GS_VIEWXYZ gscross GS_VIEWUP
case. 88;89;90 do.
  b=. y=88 89 90
  z=. 1 [ (b i. 1) gsrotate GS_SPEED*GS_UNITROT * b gschgsign x
case. 73;79 do. z=. 1 [ gszoom (>:GS_SPEED*GS_UNITSCALE) ^ {. (x { 1 5) gschgsign y=73
case. 74;75;76 do.
  z=. 1 [ gstranslate GS_SPEED*GS_UNITSTEP * (y=74 75 76) gschgsign x
case. <@>49+i.10 do.
  z=. 1 [ GS_SPEED=: GS_SPEEDS {~ y-49
end.
z
)
gsmakefknot=: 1 : 0
't p r w'=. 4{. y,<0
rn=. (0.3*r)*gsknotring p
dat=. u gsmakefloop t;rn;w
dat=. dat ,"2 [ 0 |. 1 2 {"2 dat
)
gsknotring=: 3 : 0
gscleanz (sin ,. -@cos) (,1 2&{) 2p1 * gsint01 y
)
gsmakefloop=: 1 : 0
't p w l'=. y,(#y)}.0;0;0;1 1 1
m=. gscleanz u"0 t
n=. gscleanz gsunitvec"1 u"0 D. 1 t
x=. l gsrotateloop n
y=. n gscross"1 x
a=. (o. +: w) + arccos 1 <. gsmp/ 0 _1 { x
f=. ((cos,sin),:-@sin,cos)"0
s=. f a * gsint01 <:#t
q=. s gsmp"2 x ,:"1 y
q=. 0 2 |: q
0.5 * m +"2 p gsmp q
)
gsrotateloop=: 4 : 0
g=. gsunitvec x
r=. i.0 0
t=. y
while. #t do.
  g=. gsunitvec g - (g gsmp {.t) * {.t
  r=. r,g
  t=. }.t
end.
r
)
GS_LIGHT=: 1
GS_BLEND=: 2
gsinit=: 3 : 0

g=. canvas__l [[ l=. locGL2_jgl2_
res=. openglut_newsize
openglut_newsize=: 0
if. res do.
  ctx=. current__ogl g

  glEnable GL_DEPTH_TEST
  glViewport 0 0,wh__ogl
  glMatrixMode GL_PROJECTION
  glLoadIdentity''
  gluPerspective (%/wh__ogl) 1 } GS_PERSPECTIVE
  if. GS_LIGHT e. y do.
    id=. GL_LIGHT0
    glaLight id, GL_AMBIENT, gscolor4 GS_AMBIENT
    glaLight id, GL_DIFFUSE, gscolor4 GS_DIFFUSE
    glaLight id, GL_SPECULAR, gscolor4 GS_SPECULAR
    glEnable GL_LIGHTING
    glEnable id
    if. GS_COLORMATERIAL do.
      glEnable GL_COLOR_MATERIAL
      glColorMaterial GL_FRONT_AND_BACK,GL_AMBIENT_AND_DIFFUSE
      glaMaterial GL_FRONT_AND_BACK,GL_SPECULAR, alpha4 GS_MATSPECULAR
      glaMaterial GL_FRONT_AND_BACK,GL_SHININESS, alpha4 GS_SHININESS
    end.
    if. #GS_POSITION do.
      glaLight id,GL_POSITION, alpha4 GS_POSITION end.
  end.
  if. GS_BLEND e. y do.
    glEnable GL_BLEND
    glBlendFunc GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA
  end.

else.
  current__ogl g
end.
gsclearcolor GS_CLEARCOLOR
glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT
gscolor GS_COLOR

glMatrixMode GL_MODELVIEW
glLoadIdentity''
gluLookAt GS_VIEWXYZ,GS_VIEWLINE,GS_VIEWUP
glTranslate GS_TRNXYZ
glRotate GS_ROTNDX { GS_ROTXYZ ,. GS_ID3

res
)
gsfini=: 3 : 0
EMPTY
)
gspaint=: 3 : 0
gtk_widget_queue_draw_jgtk_ canvas__l [[ l=. locGL2_jgl2_
EMPTY
)
gsflip=: 3 : 0
f=. 'gsflipd',1.0":y,{:GS_ROTNDX
GS_ROTXYZ=: f~ GS_ROTXYZ
GS_ROTNDX=: y pick 2 1 0;0 2 1;0 1 2
)
gsrotate=: 3 : 0
GS_ROTXYZ=: 360 | GS_ROTXYZ + y
:
if. x ~: {:GS_ROTNDX do. gsflip x end.
gsrotate y
)
gsfly=: 4 : 0
rot=. (rfd x) gsrotxyz y
GS_VIEWXYZ=: rot gsmp GS_VIEWXYZ
GS_VIEWUP=: rot gsmp GS_VIEWUP
)
gstranslate=: 3 : 'GS_TRNXYZ=: GS_TRNXYZ + y'
gszoom=: 3 : 'GS_VIEWXYZ=: GS_VIEWXYZ * y'
gsrotone=: gspaint @ gsrotate
gscube=: 1&$: : (4 : 0)
v=. gsnormalize _1 ^ #: i.8
n=. _2 [\ 0 1 0 2 0 4 1 3 1 5 2 3 2 6 3 7 4 5 4 6 5 7 6 7
e=. ,"2 n { v
n=. 4 6 7 5, 2 3 7 6, 0 2 6 4, 0 4 5 1, 0 1 3 2,: 1 5 7 3
f=. ,"2 n { v
x *each v;e;f
)
gsdodecahedron=: 1&$: : (4 : 0)
x=. 2 o. 1r5p1
y=. % <: +: x
a=. |: 2 1 o./ o. (+:i.5)%5
b=. |: 2 1 o./ o. (>:+:i.5)%5
v=. gsnormalize (a,.0),((+:a*x),.1),((+:b*x),.y),b,.>:y
n=. 0 1 0 4 0 5 1 2 1 6 2 3 2 7 3 4 3 8 4 9 5 10 5 14 6 10 6 11
n=. n, 7 11 7 12 8 12 8 13 9 13 9 14 10 15 11 16 12 17 13 18
n=. _2 [\ n,14 19 15 16 15 19 16 17 17 18 18 19
e=. ,"2 n { v
n=. 0 4 3 2 1, 0 1 6 10 5, 1 2 7 11 6, 2 3 8 12 7, 3 4 9 13 8
n=. n, 4 0 5 14 9, 5 10 15 19 14, 6 11 16 15 10, 7 12 17 16 11
n=. _5 [\ n, 8 13 18 17 12, 9 14 19 18 13, 15 16 17 18 19
f=. ,"2 n { v
x *each v;e;f
)
gsicosahedron=: 1&$: : (4 : 0)
's c'=. 1 2 o. 1r5p1
x=. %: -. % 4 * *: s
y=. %: (1++:c) % 2++:c
a=. |: (2 1 o./ o. (+:i.5)%5) % +:s
b=. - 3 |. a
v=. gsnormalize 0,(a,.x),(b,.x+y),0 0,y++:x
n=. 0 1 0 2 0 3 0 4 0 5 1 2 1 5 1 6 1 10 2 3 2 6 2
n=. n, 7 3 4 3 7 3 8 4 5 4 8 4 9 5 9 5 10 6 7 6 10 6 11
n=. _2 [\ n, 7 8 7 11 8 9 8 11 9 10 9 11 10 11
e=. ,"2 n { v
n=. 0 2 1, 0 3 2, 0 4 3, 0 5 4, 0 1 5, 1 2 6, 2 3 7, 3 4 8
n=. n, 4 5 9, 5 1 10, 1 6 10, 2 7 6, 3 8 7, 4 9 8, 5 10 9
n=. _3[\n, 11 6 7, 11 7 8, 11 8 9, 11 9 10, 11 10 6
f=. ,"2 n { v
x *each v;e;f
)
gsoctahedron=: 1&$: : (4 : 0)
v=. gsnormalize 0 0 1, 1 0 0, 0 1 0, _1 0 0, 0 _1 0 ,: 0 0 _1
n=. _2 [\ 0 1 0 2 0 3 0 4 1 2 1 4 1 5 2 3 2 5 3 4 3 5 4 5
e=. ,"2 n { v
n=. 0 1 2, 0 2 3, 0 3 4, 0 4 1, 5 2 1, 5 3 2, 5 4 3,: 5 1 4
f=. ,"2 n { v
x *each v;e;f
)
gstetrahedron=: 1&$: : (4 : 0)
r3=. -%%:3
r2=. %:2
r23=. %:2r3
v=. gsnormalize (0,0,%:3), (0, (+:r23),r3), ((-r2),(-r23),r3),: r2,(-r23),r3
n=. _2 [\ 0 1 0 2 0 3 1 2 1 3 2 3
e=. ,"2 n { v
n=. 0 1 2, 0 2 3, 0 3 1,: 1 3 2
f=. ,"2 n { v
x *each v;e;f
)
gscubeface=: [: > 2: { gscube
gsdodecahedronface=: [: > 2: { gsdodecahedron
gsicosahedronface=: [: > 2: { gsicosahedron
gsoctahedronface=: [: > 2: { gsoctahedron
gstetrahedronface=: [: > 2: { gstetrahedron

d=. 1 : 'gsdrawsolid @ ((;gsunitnormal)@x , <@])'
gsdrawcube=: gscubeface d
gsdrawdodecahedron=: gsdodecahedronface d
gsdrawicosahedron=: gsicosahedronface d
gsdrawoctahedron=: gsoctahedronface d
gsdrawtetrahedron=: gstetrahedronface d
gsdrawknot=: 3 : '3 gsdrawsurface y'
gsdrawsurface=: 3 : 0
4 gsdrawsurface y
:
'uorder vorder'=. 2 $ x
'dat clr txt'=. 3 {. boxopen y
nurb=. {. gluNewNurbsRenderer ''
gluNurbsProperty nurb;GLU_DISPLAY_MODE;GS_DISPLAYMODE
gluNurbsProperty nurb;GLU_SAMPLING_TOLERANCE;GS_SAMPLINGTOL
glEnable GL_AUTO_NORMAL
glEnable GL_NORMALIZE
clr=. gsdrawsurfcolor clr
txt=. gsdrawsurftexture txt
gscolor GS_COLOR
gsclearcolor GS_CLEARCOLOR
'ru rv j'=. $dat
dat=. |. |."2 dat
du=. ru+uorder
dv=. rv+vorder
if. 3=uorder do. ku=. i. du else. ku=. gsdefknot du end.
if. 3=vorder do. kv=. i. dv else. kv=. gsdefknot dv end.
gluBeginSurface <nurb
if. 1<#$clr do.
  gluNurbsSurface nurb;du;ku;dv;kv;(rv*4);4;(,clr);uorder;vorder;GL_MAP2_COLOR_4
end.
if. 1<#$txt do.
  gluNurbsSurface nurb;du;ku;dv;kv;(rv*2);2;(,txt);uorder;vorder;GL_MAP2_TEXTURE_COORD_2
end.
gluNurbsSurface nurb;du;ku;dv;kv;(rv*3);3;(,dat);uorder;vorder;GL_MAP2_VERTEX_3
gluEndSurface <nurb
if. GS_SHOWPOINTS do. gsdrawpoints (,dat);3;0 0 0 end.
if. GS_SHOWAXES do. stdaxes 6$_1 1 end.
gluDeleteNurbsRenderer <nurb
)
gsdrawsurface2=: 3 : 0
4 gsdrawsurface2 y
:
glLightModeli GL_LIGHT_MODEL_TWO_SIDE, 1
x gsdrawsurface y
)
gsdrawsurfcolor=: 3 : 0
clr=. y
if. 0 ~: #clr do.
  if. 3 = {:$clr do.
    ifblend=. 0
    clr=. clr ,"1 [ 1
  else.
    ifblend=. 1 +./ . ~: ,3{"1 clr
  end.
else.
  clr=. 4{.GS_COLOR,1
  ifblend=. 1 ~: 3{clr
end.
if. ifblend do.
  glEnable GL_BLEND
  glBlendFunc GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA
end.
clr
)
gsdrawsurftexture=: 3 : 0
txt=. y
if. 0 e. $txt do. return. end.
if. 1=#$txt do.
  glEnable GL_TEXTURE_1D
else.
  glEnable GL_TEXTURE_2D
end.
glTexEnvi GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GS_TEXMODE
glTexEnviv GL_TEXTURE_ENV; GL_TEXTURE_ENV_COLOR;<gscolor4 GS_TEXCOLOR
txt
)
gsgentexture=: 3 : 0
if. 1=#$y do. gsgentexture1D y else. gsgentexture2D y end.
)
gsgentexture2D=: 3 : 0
b=. <. -: (#y) - 2 ^ <. 2 ^. #y
if. 4=3!:0 y do. t=. 2 (3!:4) ,y else. t=. y end.
glEnable GL_TEXTURE_2D
glPixelStorei GL_UNPACK_ALIGNMENT, 1
glTexImage2D (;/GL_TEXTURE_2D, 0 4, ($y), b, GL_RGBA, GL_UNSIGNED_BYTE),<t
glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GS_TEXWRAP
glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GS_TEXWRAP
glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GS_TEXFILTER
glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GS_TEXFILTER
)
gsgentexture1D=: 3 : 0
b=. <. -: (#y) - 2 ^ <. 2 ^. #y
glEnable GL_TEXTURE_1D
glPixelStorei GL_UNPACK_ALIGNMENT, 1
glTexImage1D (;/GL_TEXTURE_1D, 0 4, ($y), b, GL_RGBA, GL_UNSIGNED_BYTE),<y
glTexParameteri GL_TEXTURE_1D, GL_TEXTURE_WRAP_S, GS_TEXWRAP
glTexParameteri GL_TEXTURE_1D, GL_TEXTURE_MAG_FILTER, GS_TEXFILTER
glTexParameteri GL_TEXTURE_1D, GL_TEXTURE_MIN_FILTER, GS_TEXFILTER
)
gsrotx=: 3 : 0
's c'=. 1 2 o. y
3 3$1 0 0 0,c,(-s),0,s,c,0 0
)
gsroty=: 3 : 0
's c'=: 1 2 o. y
3 3$c,0,s,0 1 0,(-s),0,c
)
gsrotz=: 3 : 0
's c'=. 1 2 o. y
3 3$c,(-s),0,s,c,0 0 0 1
)
gsrotxyz=: 4 : 0
'rx ry rz'=. a=. gsunitvec y
s=. 3 3$0 _1 1 1 0 _1 _1 1 0 * 0,rz,ry,rz,0,rx,ry,rx,0
b=. (,.a) gsmp ,:a
gscleanz b + ((cos x)*GS_ID3-b) + s * sin x
)
gsflipxz=: 3 : 0
if. 1 < +/ y = 0 do. y return. end.
'sx sy sz cx cy cz'=. , 1 2 o./ y
CX=. cos X=. gsarctanr ((sx*cz) - cx*sy*sz) % cx*cy
CY=. cos Y=. gsarctanr ((cx*sy*cz) + sx*sz) * CX % cx*cy
CY=. cos Y=. Y + o. 0 > */ * cx,cy,CX,CY
CZ=. cos Z=. gsarctanr ((cx*sz) - sx*sy*cz) % cy*cz
Z=. Z + o. 0 > */ * cy,cz,CY,CZ
gscleanz X,Y,Z
)
gsflipzx=: 3 : 0
if. 1 < +/ y = 0 do. y return. end.
'sx sy sz cx cy cz'=. , 1 2 o./ y
CZ=. cos Z=. gsarctanr ((cx*sz) + sx*sy*cz) % cy*cz
CY=. cos Y=. gsarctanr ((cx*sy*cz) - sx*sz) * CZ % cy*cz
CY=. cos Y=. Y + o. 0 > */ * cy,cz,CY,CZ
CX=. cos X=. gsarctanr ((sx*cz) + cx*sy*sz) % cx*cy
X=. X + o. 0 > */ * cx,cy,CX,CY
gscleanz X,Y,Z
)
gsflipxy=: 3 : 0
if. 1 < +/ y = 0 do. y return. end.
'sx sy sz cx cy cz'=. , 1 2 o./ y
CY=. cos Y=. gsarctanr ((cx*sy*cz) + sx*sz) % cy*cz
CZ=. cos Z=. gsarctanr ((cx*sz) - sx*sy*cz) * CY % cy*cz
CZ=. cos Z=. Z + o. 0 > */ * cy,cz,CY,CZ
CX=. cos X=. gsarctanr (sx*cy) % j=. (cx*cz) + sx*sy*sz
X=. X + o. 0 > */ * CX,CZ,j
gscleanz X,Y,Z
)
gsflipyx=: 3 : 0
if. 1 < +/ y = 0 do. y return. end.
'sx sy sz cx cy cz'=. , 1 2 o./ y
CZ=. cos Z=. gsarctanr ((cx*cy*sz) + sx*sy) % cy*cz
CY=. cos Y=. gsarctanr ((cx*sy) - sx*cy*sz) * CZ % cy*cz
CY=. cos Y=. Y + o. 0 > */ * cy,cz,CY,CZ
CX=. cos X=. gsarctanr (sx*cz) % j=. (cx*cy) + sx*sy*sz
X=. X + o. 0 > */ * CX,CY,j
gscleanz X,Y,Z
)

gsflipyz=: gsflipxz @ gsflipyx
gsflipzy=: gsflipxy @ gsflipzx
gsrfdmin=: gscleanz @ rfd @ (+ 0.0001 * 0 = 90&|)
gsflipd10=: dfr @ gsflipxy @ gsrfdmin
gsflipd01=: dfr @ gsflipyx @ gsrfdmin
gsflipd20=: dfr @ gsflipxz @ gsrfdmin
gsflipd02=: dfr @ gsflipzx @ gsrfdmin
gsflipd21=: dfr @ gsflipyz @ gsrfdmin
gsflipd12=: dfr @ gsflipzy @ gsrfdmin
