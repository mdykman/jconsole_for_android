NB. tbar filename [count style]
wdtbar=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs '' do. seterr 'bad filename : ' return.
elseif. 3< #args do. seterr 'extra parameter : ' return.
end.
fn=. >@{.args
count=. _1
if. 1< #args do.
  s=. 1{::args
  if. -.@isnum s do. seterr 'bad number : ' return. end.
  count=. {.@(0&".) s
end.
style=. ''
if. 2< #args do.
  style=. 2{::args
  if. 'tbstyle_flat' -.@-: style do. seterr 'bad style : ' return. end.
end.
idx=. windowlistidx cWindow
if. _1=idx do. seterr 'parent deleted : ' return. end.
idn0=. idn=. (<idx,4){::windowList
'tbaridn visi cnt height'=. (<idx,WindowListToolbar){::windowList
assert. 0~:tbaridn
mn=. WindowListMenubar{:: idx{windowList
if. 0~: tbimg=. (<idx, WindowListTbimg) {:: windowList do. seterr 'command failed : ' return. end.
if. #pix=. readimg_ja_ fn do.
  'h w'=. $pix
NB. allow $isitbar8.bmp which is 15 144
  if. -. (15 144-:$pix) +. 0=h|w do. seterr 'picture width not 16x : ' return. end.
  tbimg=. pix
  assert. 0~:#tbimg
  cnt=. w%h
  if. (15 144-:$pix) do. cnt=. 9 end.
NB. need it until window destroy
else.
  seterr 'wrong file type : ' return.
end.
tbar=. getchildwin tbaridn
jniCheck tbar ('setVisibility (I)V' jniMethod)~ 0   NB. visible
windowList=: (<tbimg) (<idx, WindowListTbimg) } windowList
windowList=: (<tbaridn,1,cnt,height) (<idx, WindowListToolbar) } windowList
)

NB. tbarset id index image statushelp tooltip
wdtbarset=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 3> #args do. seterr 'bad number : ' return.
elseif. 5< #args do. seterr 'extra parameter : ' return.
end.
idx=. windowlistidx cWindow
if. _1~: idx=. windowlistidx cWindow do.
  if. 0= 1{ 'tbaridn visi count height'=. (<idx, WindowListToolbar){::windowList do. seterr 'no control bar : ' return. end.
else.
  seterr 'command3 failed : ' return.
end.
idn=. (<idx,4){::windowList
id=. >@{.args NB. id empty for separator
if. 0 e. isnum&> 2{. }.args do. seterr 'bad number : ' return. end.
'index image'=. {.@(0&".)&> 2{. }.args
'statushelp tooltip'=. 2{. 3}.args
if. 0=#id do.
  jniCheck win=. cWindow jniNewObject 'View LContext;'
  jniCheck win ('setVisibility (I)V' jniMethod)~ 4
  'w h'=. 1,~ <. dpw2px barsheight%4
else.
  if. count<:image do. seterr 'bad number : ' return. end.
  jniCheck win=. cWindow jniNewObject 'ImageButton LContext;'
  if. 0~:#tbimg=. (<idx, WindowListTbimg){:: windowList do.
    'h0 w0'=. $tbimg
    if. 15 144-:$tbimg do.
      w=. h=. 16
    else.
      w=. h=. h0
    end.
    d=. w{."1 (image*w)}."1 tbimg  NB. allow overtake to avoid index error
    if. 15 144-:$tbimg do.
      d=. 16{.d
    end.
    d=. fliprgb^:(-.RGBSEQ_j_) , d
    d=. ALPHA_ja_ (23 b.) d

NB. public static Bitmap createBitmap (int[] colors, int offset, int stride, int width, int height, Bitmap.Config config)
    jniCheck colors=. NewIntArray <#d
    jniCheck SetIntArrayRegion colors;0;(#d);d
    jniCheck bm=. 'android.graphics.Bitmap' ('createBitmap ([IIIIILBitmap$Config;)LBitmap;' jniStaticMethod)~ colors;0;w;w;h;ARGB_8888
    if. (h1=. <.dpw2px barsheight)>h do.
NB. public static Bitmap createScaledBitmap (Bitmap src, int dstWidth, int dstHeight, boolean filter)
      jniCheck bm1=. 'android.graphics.Bitmap' ('createScaledBitmap (LBitmap;IIZ)LBitmap;' jniStaticMethod)~ bm;h1;h1;0
      jniCheck DeleteLocalRef <bm
      bm=. bm1
      w=. h=. h1
    end.
    jniCheck win ('setImageBitmap (LBitmap;)V' jniMethod)~ bm
    jniCheck DeleteLocalRef"0 colors;bm
  else.
    win seterr 'command failed : ' return.
  end.
  jniCheck win ('setId (I)V' jniMethod)~ idn=. >:idn
  jniCheck win ('setOnClickListener (LView$OnClickListener;)V' jniMethod)~ button_click_listener
end.
jniCheck lp=. ('LinearLayout$LayoutParams II') jniNewObject~ <"0 w,h
jniCheck win ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
jniCheck win ('setFocusable (Z)V' jniMethod)~ 0
tbar=. getchildwin tbaridn
assert. 0~:tbar
jniCheck tbar ('addView (LView;)V' jniMethod)~ win
if. 0~:#id do.
  toolbarList=: toolbarList, cWindow ; idn ; id ; index ; image
  windowList=: (<idn) (<idx, 4) } windowList
  windowList=: (<tbaridn,visi,count,h>.height) (<idx, WindowListToolbar) } windowList
end.
jniCheck DeleteLocalRef"0 win;lp;tbar
)

NB. tbarshow flag
wdtbarshow=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. s=. ,'1'
elseif. 1= #args do. s=. >@{.args
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. -.@isnum s do. seterr 'bad number : ' return. end.
if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
idx=. windowlistidx cWindow
if. _1=idx do. seterr 'parent deleted : ' return. end.
'tbaridn visi cnt height'=. (<idx,WindowListToolbar){::windowList
assert. 0~:tbaridn
tbar=. getchildwin tbaridn
assert. 0~:tbar
jniCheck tbar ('setVisibility (I)V' jniMethod)~ flag{8 0
jniCheck DeleteLocalRef <tbar
windowList=: (<tbaridn,flag,cnt,height) (<idx, WindowListToolbar) } windowList
)
