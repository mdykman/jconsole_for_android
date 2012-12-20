NB. sbar n
wdsbar=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
idx=. windowlistidx cWindow
if. _1=idx do. seterr 'parent deleted : ' return. end.
idn0=. idn=. (<idx,4){::windowList
'sbaridn id0 cnt nxt'=. (<idx,WindowListStatusbar){::windowList
assert. 0~:sbaridn
if. 0~:cnt do. seterr 'nounce error : ' return. end.
if. -.@isnum s=. >@{.args do. seterr 'bad number : ' return. end.
if. 0>: count=. {.@(0&".) s do. seterr 'bad number : ' return. end.
sbar=. getchildwin sbaridn
assert. 0~:sbar
jniCheck sbar ('setVisibility (I)V' jniMethod)~ 0
jniCheck DeleteLocalRef <sbar
windowList=: (<idn0+count) (<idx, 4) } windowList
windowList=: (<sbaridn, idn0, count, 0) (<idx, WindowListStatusbar) } windowList
)

NB. sbarset id width text
wdsbarset=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1= #args do. seterr 'bad number : ' return.
elseif. 3< #args do. seterr 'extra parameter : ' return.
end.
idx=. windowlistidx cWindow
if. _1=idx do. seterr 'parent deleted : ' return. end.
'sbaridn idn0 count next'=. (<idx,WindowListStatusbar){::windowList
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. -.@isnum awidth=. 1{::args do. seterr 'bad number : ' return. end.
width=. {.@(0&".) awidth
txt=. >@{.2}.args
sbar=. getchildwin sbaridn
assert. 0~:sbar
if. _1~: ix=. cWindow getstatusbaridx id do.
  window=. (<ix,1){::statusbarList
  win=. getchildwin window
else.
  if. count<:next do. sbar seterr 'bad number : ' return. end.
  jniCheck win=. cWindow jniNewObject 'TextView LContext;'
  jniCheck win ('setId (I)V' jniMethod)~ window=. idn0+next+1
  jniCheck lp=. ('LinearLayout$LayoutParams II') jniNewObject~ WRAP_CONTENT;WRAP_CONTENT
  jniCheck win ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
  jniCheck sbar ('addView (LView;)V' jniMethod)~ win
  jniCheck DeleteLocalRef <lp
end.
jniCheck win ('setText (LCharSequence;)V' jniMethod)~ <txt
if. width>0 do.
  lp=. win ('getLayoutParams ()Landroid/view/ViewGroup$LayoutParams;' jniMethod)~ ''
  lp ('width I' jniField)~ dpw2px width
  jniCheck DeleteLocalRef <lp
end.
jniCheck DeleteLocalRef"0 win;sbar
if. _1=ix do.
  windowList=: (<sbaridn, idn0, count, >:next) (<idx, WindowListStatusbar) } windowList
  statusbarList=: statusbarList, cWindow ; window ; id
end.
)

NB. sbarshow flag
wdsbarshow=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. s=. ,'1'
elseif. 1< #args do. seterr 'extra parameter : ' return.
elseif. do. s=. >@{.args
end.
if. -.@isnum s do. seterr 'bad number : ' return. end.
if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
idx=. windowlistidx cWindow
if. _1=idx do. seterr 'parent deleted : ' return. end.
'sbaridn idn0 cnt nxt'=. (<idx,WindowListStatusbar){::windowList
assert. 0~:sbaridn
sbar=. getchildwin sbaridn
assert. 0~:sbar
jniCheck sbar ('setVisibility (I)V' jniMethod)~ flag{8 0
jniCheck DeleteLocalRef <sbar
)
