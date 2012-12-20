NB. use layou menu values acti

gravityres=: 3 : 0
a=. <;._1 '|', y-.' '
+/ gravityconst #~ gravityattr e. a
)

scaletyperes=: 3 : 0
(<;._1 ' matrix fitXY fitStart fitCenter fitEnd center centerCrop centerInside') e. <y
)

androidcolorattr=: <;._1 ' black blue cyan darkgray gray green lightgray magenta red transparent white yellow'
colorres=: 1 : 0
res=. m
if. '@android:color/'-:15{.y do. androidcolorconst {~ androidcolorattr i. <tolower 15}.y return. end.
z=. y
if. '@color/'-:7{.y do.
  f0=. ({."1 res) = <'color'
  f1=. (1{"1 res) = <7}.y
  if. #f=. I. f0*.f1 do.
    z=. (2,~{.f){::res
  else.
    z=. 7}.y
  end.
end.
NB. May be a color value, in the form of "#rgb", "#argb", "#rrggbb", or "#aarrggbb"
if. '#'={.z do.
  z=. tolower }.z
  if. 8=#z do.
    if. (({.z) e. '89abcdef') do.
      <. 4294967296 -~ {. 0". '16b', z
    else.
      <. {. 0". '16b', z
    end.
  elseif. 6=#z do.
    <. 4294967296 -~ {. 0". '16bff', z
  elseif. 4=#z do.
    if. (({.z) e. '89abcdef') do.
      <. 4294967296 -~ {. 0". '16b', 2#z
    else.
      <. {. 0". '16b', 2#z
    end.
  elseif. 3=#z do.
    <. 4294967296 -~ {. 0". '16bff', 2#z
  elseif. do. 0
  end.
else.
  <. {. 0". z
end.
)

stringres=: 1 : 0
res=. m
z=. y
if. '@string/'-:8{.y do.
  f0=. ({."1 res) = <'string'
  f1=. (1{"1 res) = <8}.y
  if. #f=. I. f0*.f1 do.
    z=. (2,~{.f){::res
  else.
    z=. 8}.y
  end.
end.
z
)

numberres=: 2 : 0
res=. m
idnames=. n
if. y-:'true' do.
  1
elseif. y-:'false' do.
  0
elseif. ('?android:attr/'-:14{.y) +. '@android:attr/'-:14{.y do.
  {. 0+". 'R_attr_',(14}.y)
elseif. ('?android:id/'-:12{.y) +. '@android:id/'-:12{.y do.
  {. 0+". 'R_id_',(12}.y)
elseif. '@attr/'-:6{.y do.
  f0=. ({."1 res) = <'attr'
  f1=. (1{"1 res) = <6}.y
  if. #f=. I. f0*.f1 do.
    {. 0 ". z=. (2,~{.f){::res
  else.
    {. 0 ". 6}.y
  end.
elseif. ('@id/'-:4{.y) +. '@+id/'-:5{.y do.
  (0,1+i) {~ (#idnames) > i=. idnames i. < }.@(}.~ i.&'/')y
elseif. do.
  unit=. y-.'-.0123456789'
  num=. {. 0". y-.unit
  if. (<unit) e. 'fill_parent';'match_parent' do.
    num=. MATCH_PARENT
  elseif. unit-:'wrap_content' do.
    num=. WRAP_CONTENT
  end.
  if. #unit do.
    select. <unit
    case. 'px' do.  NB. do nothing
    case. 'dp';'dip' do. num=. <. 0.5+num*DM_density_ja_
    case. 'sp' do. num=. <. 0.5+num*DM_scaledDensity_ja_
    end.
  end.
  num
end.
)

NB. return <int for color
NB.        int for drawable
NB.        '' (not found, will erase background or image)
drawres=: 1 : 0
res=. m
if. ('#'={.y) +. ('@color/'-:7{.y) +. '@android:color/'-:15{.y do. < (res colorres) y return. end.
if. '@drawable/' -.@-: 10{.y do. '' return. end.
if. (#res) = i=. ({."1 res) i. < 10}.y do. '' return. end.
i{::{:"1 res
)

NB. id for name
id4name=: 4 : 0
idnames=. x
(0,1+i) {~ (#idnames) > i=. idnames i. < y
)

NB. id to name
id2name=: 4 : 0
idnames=. x
(<:y){::idnames
)

NB. convert point szie to scaled pixel
pt2sp=: 3 : 0"0
y*160%72
)

NB. convert point szie to pixel
pt2px=: 3 : 0"0
y*DM_scaledDensity_ja_*160%72
)

NB. convert dip to pixel
dp2px=: 3 : 0"0
if. y>0 do.
  <. 0.5+y*DM_density_ja_
else.
  y
end.
)

NB. convert pixel to dip
px2dp=: 3 : 0"0
if. y>0 do.
  <. 0.5+y%DM_density_ja_
else.
  y
end.
)

NB. convert wd unit to pixel
dpw2px=: 3 : 0"0
if. y>0 do.
  <. 0.5+y*DM_density_ja_*4
else.
  y
end.
)

NB. convert pixel to wd unit
px2dpw=: 3 : 0"0
if. y>0 do.
  <. 0.5+y%DM_density_ja_*4
else.
  y
end.
)
