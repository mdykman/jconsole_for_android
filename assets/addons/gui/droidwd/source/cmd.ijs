NB. misc cmd

qcolor=: ".;._2 [ 0 : 0
212 208 200
58 110 165
10 36 106
128 128 128
212 208 200
255 255 255
0 0 0
0 0 0
0 0 0
255 255 255
212 208 200
212 208 200
128 128 128
10 36 106
255 255 255
212 208 200
128 128 128
128 128 128
0 0 0
212 208 200
255 255 255
64 64 64
212 208 200
0 0 0
255 255 225
181 181 181
0 0 200
166 202 240
192 192 192
10 36 106
212 208 200
)

wdbeep=: 3 : 0
if. 0= #args=. shiftargs'' do. s=. ,'1'
elseif. 1= #args do. s=. >@{.args
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. -.@isnum s do. seterr 'bad number : ' return. end.
jniCheck tg=. 'ToneGenerator II' jniNewObject~ (STREAM_NOTIFICATION=. 5);100
tg ('startTone (I)Z' jniMethod)~ TONE_PROP_BEEP=. 24
jniCheck DeleteLocalRef <tg
)

wdmsgs=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
EMPTY
)

wdq=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
if. wdqdata-: 0 0$0 do. seterr 'invalid command(wdq) : ' return. end.
t=. wdqdata
smoutput^:(1<Debugwd) t
t [ wdqdata=: 0 0$0
)

wdqcolor=: 3 : 0
if. 0= #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. -.@isnum ax=. >@{.args do. seterr 'bad number : ' return. end.
if. 0 > c=. <. {.@(0&".) ax do.seterr 'bad number : ' return. end.
if. c >: #qcolor do.
  z=. 3$0
else.
  z=. c{qcolor
end.
":z
)

wdqd=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
pa=. {.(cWindow = >{."1 windowList)#windowList
syslocalep=. >WindowListLocale{pa
syslocalec=. ''
syshwndp=. ":cWindow
syshwndc=. ":cChild
NB. sysfocus=. getcchildid gtk_window_get_focus cWindow
sysfocus=. ''
syslastfocus=. ''
sysmodifiers=. ''
wdd=. ;: 'syslocalep syslocalec syshwndp syshwndc sysfocus syslastfocus sysmodifiers'
wddata=. ".&.>wdd
qdata=. 0 2$<''
for_ls. (cWindow = >{."1 childList)#childList do.
  qdata=. qdata, childevtdata 1 2 3{ls
end.
(wdd ,. wddata), qdata
)

wdqiox=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
,'0'
)

wdqer=: 3 : 0
NB. ignore extra parameter
z=. WDERR
if. ''-: z do.
  'no error : 0'
else.
  z, ": wdptr0
end.
)

wdqm=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
NB.   '800 600 8 16 1 1 3 3 4 4 19 19 0 0 800 570'
dm=. getdisplaymetrics_ja_ cWindow
assert. 8=#dm
'w h'=. <. 5 3{dm
": w, h, 8 16, 1 1 3 3 4 4 19 19 0 0, w, h
)

wdqp=: 3 : 0
if. 0= #args=. shiftargs'' do. s=. ''
elseif. 1= #args do. s=. >@{.args
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. 0= #windowList do. '' return. end.
ws=. WindowListPgroup{"1 windowList
;LF ,&.>~ (WindowListId{"1 windowList)#~(<s)=ws
)

NB. id, qhwndp, locale, group, active index, caption
wdqpx=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
if. 0= #windowList do. '' return. end.
act=. /:@\: (|.activeidx) i. WindowListHandle{::"1 windowList
z=. ''
for_i. i.#windowList do.
  'w id loc grp'=. (WindowListHandle, WindowListId, WindowListLocale, WindowListPgroup){i{windowList
  jniCheck cap=. jniToJString ts=. '' ('toString ()LString;' jniMethod) cs=. w ('getTitle ()LCharSequence;' jniMethod)~ ''
  jniCheck DeleteLocalRef"0 ts;cs
  z=. z, id, ({.a.), (":w), ({.a.), loc, ({.a.), grp, ({.a.), (":i{act), ({.a.), (cap), ({.a.), LF
end.
z
)

wdqscreen=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
NB.   '320 240 800 600 96 96 32 1 _1 36 36 51 '
dm=. getdisplaymetrics_ja_ 0
assert. 8=#dm
'w h dpi'=. <. 5 3 2{dm
'wmm hmm'=. 25.4*dpi%~w,h
pxsiz=. <. 0.5 + 36*96%dpi
": wmm, hmm, w, h, dpi, 32 1 _1, pxsiz, <. 0.5 + %: +/ *: pxsiz
)

wdqwd=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
'jandroid'
)

NB. TODO reset all windows
wdreset=: 3 : 0
if. 1< #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
for_pa. |. WindowListHandle{::"1 windowList do.
  jniCheck pa ('finish ()V;' jniMethod)~ ''
end.
cleanup''
)

wdclipcopy=: 3 : 0
if. 0= #args=. shiftargs'' do. txt=. ''
elseif. 1= #args do. txt=. >@{.args
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
jniCheck clipboard=. (ctx=. getjactivity_ja_ cWindow) ('getSystemService (LString;)LObject;' jniMethod)~ <'clipboard'
if. APILEVEL_ja_ < 11 do.
  jniCheck clipboard ('setText (LCharSequence;)V' jniMethod)~ <txt
  jniCheck DeleteLocalRef <clipboard
else.
  jniCheck clip=. 'android.content.ClipData' ('newPlainText (LCharSequence;LCharSequence;)Landroid/content/ClipData;' jniStaticMethod)~ 'text label';txt
  jniCheck clipboard ('setPrimaryClip (Landroid/content/ClipData;)V' jniMethod)~ clip
  jniCheck DeleteLocalRef"0 clipboard;clip
end.
if. 0=cWindow do. jniCheck DeleteLocalRef <ctx end.
)

wdclippaste=: 3 : 0
if. 0= #args=. shiftargs'' do. ax=. ,'0'
elseif. 1= #args do. ax=. >@{.args
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. -.@isnum ax do. seterr 'bad number : ' return. end.
if. -. 0 1 2 e.~ ty=. <. {.@(0&".) ax do. seterr 'bad number : ' return. end.
txt=. ''
jniCheck clipboard=. (ctx=. getjactivity_ja_ cWindow) ('getSystemService (LString;)LObject;' jniMethod)~ <'clipboard'
if. APILEVEL_ja_ < 11 do.
  if. jniCheck clipboard ('hasText ()Z' jniMethod)~ '' do.
    jniCheck txt=. jniToJString ts=. '' ('toString ()LString;' jniMethod) cs=. clipboard ('getText ()LCharSequence;' jniMethod)~ ''
    jniCheck DeleteLocalRef"0 clipboard;ts;cs
  end.
else.
  if. jniCheck clipboard ('hasPrimaryClip ()Z' jniMethod)~ '' do.
    jniCheck txt=. jniToJString ts=. '' ('toString ()LString;' jniMethod) cs=. ctx ('coerceToText (LContext;)LCharSequence;' jniMethod) item=. 0 ('getItemAt (I)Landroid/content/ClipData$Item;' jniMethod) clip=. clipboard ('getPrimaryClip ()Landroid/content/ClipData;' jniMethod)~ ''
    jniCheck DeleteLocalRef"0 clipboard;clip;item;ts;cs
  end.
end.
if. 0=cWindow do. jniCheck DeleteLocalRef <ctx end.
txt
)

wdtimer=: 3 : 0
if. 0= #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. -.@isnum ax=. >@{.args do. seterr 'bad number : ' return. end.
if. 0 > delay=. <. {.@(0&".) ax do.seterr 'bad number : ' return. end.
if. timerdelay ~: delay do.
  timerdelay=: delay
  jniCheck JACT ('setjtimer (IILString;)V' jniMethod)~ 10;timerdelay;''
end.
)

