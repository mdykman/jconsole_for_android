NB. x intent,activity,context (locale,japparg,override will be ignored if 0~:intent)
NB. y locale;override;japparg
StartActivity=: 0&$: : (4 : 0)
'intent act ctx'=. 3{.x
'locale override japparg'=. 3{. boxopen y
locale=. >^:_ locale
assert. (0~:intent) +. *#locale
app=. ('theApp LJConsoleApp;' jniStaticField) 'JConsoleApp'
if. 0= act do.
  cact=. ('activity LAbstractActivity;' jniField) app
else.
  cact=. act
end.
if. 0=ctx do. cctx=. app ('getApplicationContext ()LContext;' jniMethod)~ '' else. cctx=. ctx end.
if. 0=intent do.
  cintent=. 'android.content.Intent' jniNewObject~ ''
  jniCheck jnact=. FindClass <'org/dykman/jn/android/app/Activity'
  cintent ('setClass (LContext;LClass;)LIntent;' jniMethod)~ cctx;jnact
  cintent ('putExtra (LString;LString;)LIntent;' jniMethod)~ 'locale';locale
  cintent ('putExtra (LString;LString;)LIntent;' jniMethod)~ 'override';override
  cintent ('putExtra (LString;LString;)LIntent;' jniMethod)~ 'japparg';japparg
  cact ('startActivity (LIntent;)V' jniMethod)~ cintent
  jniCheck DeleteLocalRef"0 cintent;jnact
else.
  cact ('startActivity (LIntent;)V' jniMethod)~ intent
end.
if. 0=act do. jniCheck DeleteLocalRef <cact end.
if. 0=ctx do. jniCheck DeleteLocalRef <cctx end.
jniCheck DeleteLocalRef <app
0
)
