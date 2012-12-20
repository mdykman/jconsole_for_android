coclass 'wdbase'
coinsert 'jni jaresu'

Activity=: 0

NB. =========================================================
NB. android activity callback
onCreate=: 3 : 0
if. Activity do. DeleteGlobalRef <Activity end.
jniCheck Activity_droidwd_=: Activity=: NewGlobalRef <2{y   NB. context
jniCheck Activity ('requestWindowFeature (I)Z' jniMethod)~ FEATURE_LEFT_ICON
droidwd_run''
0
)

onStart=: 0:
onRestart=: 0:
onResume=: 0:
onPause=: 0:
onStop=: 0:

onDestroy=: 3 : 0
DeleteGlobalRef@< 0: wddestroy_droidwd_ Activity
)

NB. =========================================================
NB. menu callback

onCreateOptionsMenu=: 3 : 0
jniCheck menu=. GetObjectArrayElement (3{y);0
wd_menu_droidwd_ menu
jniCheck DeleteLocalRef <menu
1
)

onOptionsItemSelected=: 3 : 0
jniCheck item=. GetObjectArrayElement (3{y);0
jniCheck widget=. item ('getItemId ()I' jniMethod)~ ''
z=. 0
if. widget>0 do. z=. 1 [ menu_onItemSelected_droidwd_ item,widget end.
jniCheck DeleteLocalRef <item
z
)

NB. =========================================================
NB. start activity with defaults
NB. x intent,activity,context  (optional)
NB. y [locale [; override [; args]]]
start_droidwd=: 0&$: : (4 : 0)
if. ''-:y do.
  y=. (>18!:5'');'onStart onRestart onPause onResume onStop onDestroy onCreateOptionsMenu onOptionsItemSelected'
elseif. 1=# y=. boxopen y do.
  y=. (>y); 'onStart onRestart onPause onResume onStop onDestroy onCreateOptionsMenu onOptionsItemSelected'
end.
x StartActivity_ja_ y
)

NB. =========================================================
NB. droidwd applications should override this verb
droidwd_run=: 0:
