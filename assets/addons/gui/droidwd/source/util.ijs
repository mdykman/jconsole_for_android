NB. util

isnum=: 3 : 0
if. '-_0123456789' e.~ {.y do.  NB. avoid ". on name
  try.
    if. 0~:$$a=. ".y do.
      0
    else.
      1 4 8 e.~ (3!:0) a
    end.
  catch. 0 end.
else.
  0
end.
)

ismenucreated=: 3 : 0
if. _1 = icx=. windowlistidx y do. 0 return. end.
(<icx, WindowListMenuCreated){::windowList
)

NB. get window index inside windowList, return _1 is not found
windowlistidx=: 3 : 0
window=. y
z=. _1
if. 0= #windowList do. z return. end.
if. window e. ls=. >WindowListHandle{"1 windowList do.
  z=. ls i. window
end.
z
)

NB. delete leading white spaces
dlws=: 3 : 0
y }.~ +/ *./\ (y e. ' ')+.(y e. LF)+.(y e. TAB)
)

NB. count leading white spaces
clws=: 3 : 0
+/ *./\ (y e. ' ')+.(y e. LF)+.(y e. TAB)
)

NB. get first argument and remove enclosing dquotes or DEL
NB. update global noun wdptr on exit
shiftarg=: 3 : 0
if. (#wdstr) = wdptr=: wdptr + clws wdptr}. wdstr do. '' return. end.
y=. wdptr}.wdstr
b=. y e. ' '
a=. y e. '*'
q=. 2| +/\ y e. '"'
d=. 2| +/\ y e. DEL
b=. b *. -.q+.d
a=. a *. -.q+.d
if. 1={.a do.     NB. *argument
  z=. }.y
  wdptr=: #wdstr
elseif. (1={.d)+.(1={.q) do.   NB. enclosed between DEL or "
  p2=. 1+ (}.y) i. {.y
  z=. }.p2{.y
  wdptr=: wdptr+ p2+1
elseif. 1 e. b do. NB. space delimited
  p2=. {.I.b
  z=. p2{.y
  wdptr=: wdptr+ 1+p2
elseif. do.
  z=. y
  wdptr=: #wdstr
end.
<z
)

NB. get all arguments by repeating calling shiftarg
shiftargs=: 3 : 0
z=. 0$<''
while. wdptr < #wdstr do. z=. z, shiftarg'' end.
z
)

seterr=: ''&$: : (4 : 0)
if. *#x do. jniCheck DeleteLocalRef@boxopen"0 x end.
WDERR=: y [ WDERRN=: 3
smoutput^:(0<Debugwd) '**ERROR: ', y
smoutput^:(0<Debugwd) wdstr
if. 2<Debugwd do. 13!:8[3 end.   NB. preserve stack for debug
EMPTY
)

NB. set and resize image file for owner_drawn button
setbuttonimage=: 3 : 0
'window image s'=. y
if. ''-: s do. return. end.
if. _1&~: {. alloc=. getGtkWidgetAllocation image do.
  wh=. _2{. alloc
  'w h'=. 1 >. wh
else.
  if. _1&~: {. alloc=. getGtkWidgetAllocation window do.
    wh=. _2{. alloc
  else.
    wh=. _2{. getAllocation window
  end.
  'w h'=. 1 >. _12 _3 + wh
end.
if. 0~: pix=. gdk_pixbuf_new_from_file_at_size s ; w ; h ;< 0 do.
  ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd image ; 'pixbuf' ; pix ;< 0
  g_object_unref <pix
end.
)

delcchild=: 4 : 0
parent=. x
widget=. y
if. 0= #childList do. return. end.
childList=: ((parent = >0{"1 childList)*:(widget = >1{"1 childList))#childList
)

NB. get handle for a child from its id name
getcchild=: 4 : 0
parent=. x
id=. <,> y
z=. 0
if. 0= #childList do. z return. end.
if. 1 e. ix=. (parent = >0{"1 childList)*.(id = 2{"1 childList) do. z=. (<({.I.ix),1){::childList end.
z
)

NB. get id for a child from its handle
getcchildid=: 3 : 0
widget=. y
if. _1= ix=. getcchildidx widget do. '' return. end.
(<ix,2 ){::childList
)

getcchildclass=: 3 : 0
widget=. y
if. _1= ix=. getcchildidx widget do. _1 return. end.
(<ix, 3){::childList
)

NB. get child index inside childList, return _1 is not found
getcchildidx=: 3 : 0
assert. 0~:cWindow
widget=. y
z=. _1
if. 0= #childList do. z return. end.
if. 1 e. ix=. (cWindow = >0{"1 childList) *. (widget = >1{"1 childList) do. z=. {.I.ix end.
z
)

NB. return parent
getcparent=: 3 : 0
widget=. y
if. 0= #windowList do. 0 return. end.
if. _1= ix=. getcchildidx widget do. 0 return. end.
(<ix, 0){::childList
)

getccontaineridx=: 3 : 0
assert. 0~:cWindow
widget=. y
z=. _1
if. 0= #containerList do. z return. end.
if. 1 e. ix=. (cWindow = >0{"1 containerList)*.(widget = >1{"1 containerList) do. z=. I.{.ix end.
z
:
getccontaineridx x getcchild y
)

NB. get menu index inside menuList, return _1 is not found
getmenuidx=: 4 : 0
parent=. x
widget=. y
assert. 0~:parent
z=. _1
if. 0= #menuList do. z return. end.
if. 1 e. ix=. (cWindow = >0{"1 menuList)*.(widget = >1{"1 menuList) do. z=. {.I.ix end.
z
)

NB. get handle for a menu from its id
getmenu=: 4 : 0
parent=. x
id=. <,> y
z=. 0
if. 1 e. ix=. (parent = >0{"1 menuList)*.(id = 2{"1 menuList) do. z=. (<({.I.ix),1){::menuList end.
z
)

NB. get toolbar index inside toolbarList, return _1 is not found
NB. return ix from idn
gettoolbaridx=: 4 : 0
parent=. x
widget=. y
assert. 0-:{.0$y
assert. 0~:parent
z=. _1
if. 0= #toolbarList do. z return. end.
if. 1 e. ix=. (parent = >0{"1 toolbarList)*.(widget = >1{"1 toolbarList) do. z=. {.I.ix end.
z
)

NB. return idn from id
gettoolbar=: 4 : 0
parent=. x
assert. ' '-:{.0$>y
assert. 0~:parent
id=. <,> y
if. 1 -.@e. ix=. (parent = >0{"1 toolbarList)*.(id = 2{"1 toolbarList) do. 0 return. end.
(<({.I.ix), 1){::toolbarList
)

NB. get statusbar index inside statusbarList, return _1 is not found
getstatusbaridx=: 4 : 0
parent=. x
id=. <,> y
assert. 0~:parent
z=. _1
if. 0= #statusbarList do. z return. end.
if. 1 e. ix=. (parent = >0{"1 statusbarList)*.(id = 2{"1 statusbarList) do. z=. {.I.ix end.
z
)

getstatusbar=: 4 : 0
parent=. x
id=. <,> y
if. _1= ix=. parent getstatusbaridx id do. 0 return. end.
(<ix, 1){::statusbarList
)

checkbadname=: 3 : 0
rz=. 1
if. ({.y) e. a.{~(65+i.26),(97+i.26) do.
  rz=. 0 e. (}.y) e. '0123456789', a.{~(65+i.26),(97+i.26)
end.
rz
)

getchildwh=: 3 : 0
widget=. y
jniCheck w=. widget ('getWidth ()I' jniMethod)~ ''
jniCheck h=. widget ('getHeight ()I' jniMethod)~ ''
w,h
)

NB. get xy of top left corner relative to toplevel or subform
getchildxy=: 3 : 0
wid=. y
xy=. 0 0
while. wid do.
  jniCheck x=. wid ('getLeft ()I' jniMethod)~ ''
  jniCheck y=. wid ('getTop ()I' jniMethod)~ ''
  xy=. xy + x,y
  jniCheck parent=. wid ('getParent ()Landroid/view/ViewParent;' jniMethod)~ ''
  if. parent do.
    if. fixedidn = jniCheck parent ('getId ()I' jniMethod)~ '' do. break. end.  NB. TODO only relative top-level
    wid=. parent
  else.
    break.
  end.
end.
xy
)

NB. get view form android id
getchildwin=: 3 : 0
assert. 0~:cWindow
assert. 0~:y
jniCheck view=. cWindow ('findViewById (I)LView;' jniMethod)~ y
assert. 0~:view
view
)

NB. return parent
getlocgl2=: 3 : 0
z=. 0$<''
if. 0= #windowList do. z return. end.
if. 0= #childList do. z return. end.
if. ({.y) e. '_0123456789' do.
  widget=. {. 0".y
else.
  widget=. cWindow getcchild y
end.
if. (#canvaslocale_jglcanvas_) > ix=. widget i.~ >{."1 canvaslocale_jglcanvas_ do.
  z=. (<ix,1){canvaslocale_jglcanvas_
end.
z
)

NB. TODO fix resource leak
cleanup=: 3 : 0
wdqdata=: 0 0$0
WDERR=: ''
WDLOC=: 'base'
sysmodifiers=: ,'0'
sysdata=: ''
disable_toggle_event=: 0
listbox_evtdata=: ''
lasterrcmd=: lastcmd=: ''
cWindow=: 0          NB. current window
cChild=: 0           NB. current child (reset after psel pc)
cRadio=: 0           NB. current radio button group (reset after psel pc or radiobutton with group style)
cContainer=: 0       NB. current container: creategroup
cContaineri=: _1     NB. current container: next tab to be fill
cSubform=: ''        NB. current subform id: pc id after creategroup
windowList=: 0 18$<'' NB. window list
containerList=: 0 3$<'' NB. container list
subformList=: 0 4$<'' NB. subform list
childList=: 0 12$<'' NB. child list
menuList=: 0 5$<'' NB. menu list
toolbarList=: 0 5$<'' NB. toolbar list
statusbarList=: 0 3$<'' NB. statusbar list
activeidx=: 0$0        NB. active index
cxywh=: 0 0 100 100
cFontdef=: ''
cSetFont=: ''
tbimg=: 0   NB. toolbar image buffer
systimerid=: timerdelay=: 0
jniCheck JACT ('setjtimer (IILString;)V' jniMethod)~ 10;0;''
)

NB. fill content for listview and spinner
setadapter=: 4 : 0
'activity view isspin multiselect'=. y
ar=. jniToStringarr x
jniCheck adapter=. 'ArrayAdapter LContext;I[LObject;' jniNewObject~ activity ; (isspin{ (multiselect{R_layout_simple_list_item_single_choice,R_layout_simple_list_item_multiple_choice,R_layout_simple_list_item_1), R_layout_simple_spinner_item) ; ar
if. isspin do.
  jniCheck adapter ('setDropDownViewResource (I)V' jniMethod)~ R_layout_simple_dropdown_item_1line
  jniCheck view ('setAdapter (LSpinnerAdapter;)V' jniMethod)~ adapter
else.
  jniCheck view ('setAdapter (LListAdapter;)V' jniMethod)~ adapter
  if. 1=multiselect do.
    jniCheck view ('setChoiceMode (I)V' jniMethod)~ CHOICE_MODE_MULTIPLE=. 2
  elseif. 2=multiselect do.
    jniCheck view ('setChoiceMode (I)V' jniMethod)~ CHOICE_MODE_SINGLE=. 1   NB. CHOICE_MODE_SINGLE (0) may need listbox_evtdata
  elseif. do.
    jniCheck view ('setChoiceMode (I)V' jniMethod)~ CHOICE_MODE_SINGLE=. 1
  end.
end.
jniCheck DeleteLocalRef"0 ar;adapter
EMPTY
)

resizechild=: 4 : 0
'wh wh0'=. 1 >. 2 2$x
NB. ugly kludge
'w h'=. wh
if. (w>h) *. 0.3>h%w do. return. end.
if. (h>w) *. 0.3>w%h do. return. end.
assert. 0~:2{.y
'parent fixed1 offset'=. y
assert. 0~:fixed1
NB. gtk_alignment_get_padding align1 ; (top=. ,_1) ; (bot=. ,_1) ; (lef=. ,_1) ; (rig=. ,_1)
'top bot lef rig'=. 4#0
pad0=. 0
fixed1wh=. wh=. 1 >. wh - (0,offset) + (0,pad0) + 0>. (lef+rig),(top+bot)
NB. avoid endless expansion loop
minpad=. 0

chg=. 0
for_wx. ((0&~: >4{"1 childList) *. (0= >6{"1 childList) *. (parent = >{."1 childList))#childList do.
  'parent window id iclass stylen hide container subform xywh0 dummy1 localec userdata'=. 12{.wx
  'cx cy cw ch'=. 'cx0 cy0 cw0 ch0'=. xywh0
  ex=. ex0=. cx0 + cw0
  ey=. ey0=. cy0 + ch0
  W0=. {.wh0 [ H0=. {:wh0
  W=. {.wh [ H=. {:wh
  (FMSTYLE)=. |. (8#2) #: stylen
  if. leftmove do. cx=. cx0 + (W-W0) end.
  if. leftscale do. cx=. <. cx0 * W%W0 end.
  if. rightmove do. ex=. (W-minpad) <. (cx0+cw0) + (W-W0) end.
  if. rightscale do. ex=. (W-minpad) <. <. W - (W0 - cx0+cw0) * W%W0 end.

  if. topmove do. cy=. cy0 + (H-H0) end.
  if. topscale do. cy=. <. cy0 * H%H0 end.
  if. bottommove do. ey=. (H-minpad) <. (cy0+ch0) + (H-H0) end.
  if. bottomscale do. ey=. (H-minpad) <. <. H - (H0 - cy0+ch0) * H%H0 end.

  cw=. 1 >. ex - cx
  ch=. 1 >. ey - cy
  if. +./ 0 < | xywh0 - cx,cy,cw,ch do.
    if. iclass=wdcl_radiobutton do.
      if. 1=userdata do.
        win=. getchildwin window
        jniCheck parent=. win ('getParent ()Landroid/view/ViewParent;' jniMethod)~ ''
        if. parent do.
          lp=. parent ('getLayoutParams ()Landroid/view/ViewGroup$LayoutParams;' jniMethod)~ ''
          lp ('x I' jniField)~ <cx
          lp ('y I' jniField)~ <cy + offset
          lp ('width I' jniField)~ <WRAP_CONTENT
          lp ('height I' jniField)~ <WRAP_CONTENT
        end.
        jniCheck DeleteLocalRef"0 parent;win;lp
      end.
      continue.
    end.
    win=. getchildwin window
    lp=. win ('getLayoutParams ()Landroid/view/ViewGroup$LayoutParams;' jniMethod)~ ''
    lp ('x I' jniField)~ <cx
    lp ('y I' jniField)~ <cy + offset
    lp ('width I' jniField)~ <cw
    lp ('height I' jniField)~ <ch
NB.   jniCheck win ('invalidate ()V' jniMethod)~ ''
NB.   jniCheck win ('forceLayout ()V' jniMethod)~ ''
NB.   jniCheck win ('requestLayout ()V' jniMethod)~ ''
    jniCheck DeleteLocalRef"0 win;lp
  end.
end.
NB. jniCheck fixed1 ('invalidate ()V' jniMethod)~ ''
NB. jniCheck fixed1 ('forceLayout ()V' jniMethod)~ ''
NB. jniCheck fixed1 ('requestLayout ()V' jniMethod)~ ''

NB. child inside tabs
ct=. 0$0
for_wx. ((0&~: >4{"1 childList) *. (0~: >6{"1 childList) *. (parent = >{."1 childList))#childList do.
  'parent window id iclass stylen hide container subform xywh0 dummy1 localec userdata'=. 12{.wx

  if. _1= ix=. getccontaineridx container do. continue. end.
  if. 1 e. f=. (container = >1{"1 subformList) *. (<subform) = 2{"1 subformList do.
    fixed1=. 3{:: ({.I.f){subformList
  else.
    continue.
  end.
  wh=. 0 >. fixed1wh
  wh0=. (<ix,2){::containerList
  ct=. ct, container
  (FMSTYLE)=. |. (8#2) #: stylen

  'cx cy cw ch'=. 'cx0 cy0 cw0 ch0'=. xywh0
  ex=. ex0=. cx0 + cw0
  ey=. ey0=. cy0 + ch0
  W0=. {.wh0 [ H0=. {:wh0
  W=. {.wh [ H=. {:wh

  if. leftmove do. cx=. cx0 + (W-W0) end.
  if. leftscale do. cx=. <. cx0 * W%W0 end.
  if. rightmove do. ex=. (W-minpad) <. (cx0+cw0) + (W-W0) end.
  if. rightscale do. ex=. (W-minpad) <. <. W - (W0 - cx0+cw0) * W%W0 end.

  if. topmove do. cy=. cy0 + (H-H0) end.
  if. topscale do. cy=. <. cy0 * H%H0 end.
  if. bottommove do. ey=. (H-minpad) <. (cy0+ch0) + (H-H0) end.
  if. bottomscale do. ey=. (H-minpad) <. <. H - (H0 - cy0+ch0) * H%H0 end.

  cw=. 1 >. ex - cx
  ch=. 1 >. ey - cy
  if. +./ 0 < | xywh0 - cx,cy,cw,ch do.
    if. iclass=wdcl_radiobutton do.
      if. 1=userdata do.
        win=. getchildwin window
        jniCheck parent=. win ('getParent ()Landroid/view/ViewParent;' jniMethod)~ ''
        if. parent do.
          lp=. parent ('getLayoutParams ()Landroid/view/ViewGroup$LayoutParams;' jniMethod)~ ''
          lp ('x I' jniField)~ <cx
          lp ('y I' jniField)~ <cy + offset
          lp ('width I' jniField)~ <WRAP_CONTENT
          lp ('height I' jniField)~ <WRAP_CONTENT
        end.
        jniCheck DeleteLocalRef"0 parent;win;lp
      end.
      continue.
    end.
    win=. getchildwin window
    lp=. win ('getLayoutParams ()Landroid/view/ViewGroup$LayoutParams;' jniMethod)~ ''
    lp ('x I' jniField)~ <cx
    lp ('y I' jniField)~ <cy + offset
    lp ('width I' jniField)~ <cw
    lp ('height I' jniField)~ <ch
NB. win ('requestLayout ()V' jniMethod)~ ''
    jniCheck DeleteLocalRef"0 win;lp
  end.
end.
NB. for_cti. ~.ct do.
NB.   jniCheck cti ('invalidate ()V' jniMethod)~ ''
NB. end.
)
