NB. session definitions for plot

NB.*pd v plot driver
NB.*pdf v plot function driver
NB.*plot v cover for pd
NB.*plotf v cover for pdf

require 'jzplot'
coclass 'jwplot'
coinsert 'jzplot'

idnx=: 0
cxywh=: 4$0

NB. =========================================================
NB. deferred commands
pdcmdsave=: ''
pdcmdclip=: 0
pdcmdprint=: 0

NB. =========================================================
NB. z locale definitions
pd_z_=: 3 : 0
caller_jwplot_=. coname''
pd_jwplot_ y
)

plot_z_=: 3 : 0
caller_jwplot_=. coname''
'' plot_jwplot_ y
:
caller_jwplot_=. coname''
x plot_jwplot_ y
)

NB. =========================================================
NB. for android

Activity=: 0

onCreate=: 3 : 0
jniCheck PFormhwnd=: Activity=: NewGlobalRef <2{y

NB. hide title and status bar
jniCheck Activity ('requestWindowFeature (I)Z' jniMethod)~ FEATURE_NO_TITLE
jniCheck win=. Activity ('getWindow ()LWindow;' jniMethod)~ ''
jniCheck win ('setFlags (II)V' jniMethod)~ FLAG_FULLSCREEN;FLAG_FULLSCREEN
jniCheck DeleteLocalRef <win
option=. 0
w=. h=. 320
idnx=: (0,Activity) glcanvas_jgl2_ (w,h) ; coname''
PIdhwnd=: ":idnx
l=. glgetloc_jgl2_ idnx
thisview=. view__l
jniCheck Activity ('setContentView (LView;)V' jniMethod)~ thisview
jniCheck thisview ('requestFocus ()Z' jniMethod)~ ''
jniCheck DeleteLocalRef <thisview

0
)

onDestroy=: 3 : 0
if. Activity do.
 jniCheck DeleteGlobalRef <Activity
end.
Activity=: idnx=: 0
0
)
