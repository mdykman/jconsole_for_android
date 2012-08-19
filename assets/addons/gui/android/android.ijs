load 'jni'

coclass 'ja'
coinsert 'jni'
jnhandler_z_=: 4 : 0
if. 3=4!:0<'jnhandler_debug' do.
  try. x jnhandler_debug y catch. end.
end.
jn_fn=. x
log_d_ja_ 'JJNI';'jnhandler ',jn_fn
if. 13!:17'' do.
  z=. jn_fn~ y
else.
  try. z=. jn_fn~ y
  catch.
    if. 0~:exc=. ExceptionOccurred_jni_'' do.
      if. ''-:jn_err=. ExceptionMessage_jni_ exc do.
        jn_err=. 'JNI exception'
      end.
      jn_err=. '|', jn_err, LF
    else.
      jn_err=. 13!:12''
    end.
    if. 0=4!:0 <'ERM_j_' do.
      jn_erm=. ERM_j_
      ERM_j_=: ''
      if. jn_erm -: jn_err do. 0 return. end.
    end.
    jn_err=. LF,,LF,.}.;._2 jn_err
    smoutput 'jnhandler error in: ',jn_fn,jn_err
    log_d_ja_ 'JJNI';'jnhandler error in: ',,jn_fn,jn_err
    0
  end.
end.
)
getenv=: 3 : 0
'JNIVM_z_ JNIENV_z_'=: , > }. 'libj.so GetJavaVM i *x *x'&cd (,_1);,_1
JNIENV_z_
)
StartActivity=: 4 : 0
'act ctx jcls'=. x
'jargx jargy'=. 2{.boxopen y
app=. ('theApp Lorg/dykman/j/android/JConsoleApp;' jniStaticField) 'org/dykman/j/android/JConsoleApp'
if. 0= act do.
  cact=. ('activity Lorg/dykman/j/android/AbstractActivity;' jniField) app
else.
  cact=. act
end.
if. 0=ctx do. cctx=. app ('getApplicationContext ()Landroid/content/Context;' jniMethod)~ '' else. cctx=. ctx end.
l=. conew jcls
intent=. 'android.content.Intent' jniNewObject~ ''
jnicheck jnact=. FindClass <'org/dykman/jn/android/app/Activity'
intent ('setClass (Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;' jniMethod)~ cctx;jnact
intent ('putExtra (Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;' jniMethod)~ 'locale';>l
intent ('putExtra (Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;' jniMethod)~ 'jargx';jargx
intent ('putExtra (Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;' jniMethod)~ 'jargy';jargy
cact ('startActivity (Landroid/content/Intent;)V' jniMethod)~ intent
if. 0=act do. jnicheck DeleteLocalRef <cact end.
if. 0=ctx do. jnicheck DeleteLocalRef <cctx end.
jnicheck DeleteLocalRef <app
jnicheck DeleteLocalRef <jnact
l
)
StartActivity=: 4 : 0
'act ctx jcls'=. x
'jargx jargy'=. 2{.boxopen y
'JNIVM_z_ JNIENV_z_'=: , > }. 'libj.so GetJavaVM i *x *x'&cd (,_1);,_1
try.
  app=. ('theApp Lorg/dykman/j/android/JConsoleApp;' jniStaticField) 'org/dykman/j/android/JConsoleApp'
  handler=. ('handler Landroid/os/Handler;' jniField) app
  l=. conew jcls
  msg=. 'android.os.Message' jniNewObject~ ''
  b=. 'android.os.Bundle' jniNewObject~ ''
  b ('putString (Ljava/lang/String;Ljava/lang/String;)V' jniMethod)~ 'class';'org.dykman.jn.android.app.Activity'
  b ('putString (Ljava/lang/String;Ljava/lang/String;)V' jniMethod)~ 'locale';>l
  b ('putString (Ljava/lang/String;Ljava/lang/String;)V' jniMethod)~ 'jargx';jargx
  b ('putString (Ljava/lang/String;Ljava/lang/String;)V' jniMethod)~ 'jargy';jargy
  msg ('setData (Landroid/os/Bundle;)V' jniMethod)~ b
  handler ('sendMessage (Landroid/os/Message;)Z' jniMethod)~ msg
  l
catch.
  if. 0~:exc=. ExceptionOccurred_jni_'' do.
    if. ''-:jn_err=. ExceptionMessage_jni_ exc do.
      jn_err=. 'JNI exception'
    end.
    jn_err=. '|', jn_err, LF
  else.
    jn_err=. 13!:12''
  end.
  smoutput jn_err
end.
)

toast=: 3 : 0
y=. uucp y
ExceptionClear''
try.
  app=. ('theApp Lorg/dykman/j/android/JConsoleApp;' jniStaticField) 'org/dykman/j/android/JConsoleApp'
  ctx=. app ('getApplicationContext ()Landroid/content/Context;' jniMethod)~ ''
  cls=. FindClass <'android/widget/Toast'
  cs=. NewCharArray <#y
  SetCharArrayRegion cs;0;(#y);y
  toast=. cls ('makeText (Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;' jniStaticMethod)~ ctx;cs;1
  toast ('show ()V' jniMethod) ''
  jnicheck DeleteLocalRef <toast
  jnicheck DeleteLocalRef <cs
  jnicheck DeleteLocalRef <cls
  jnicheck DeleteLocalRef <ctx
  jnicheck DeleteLocalRef <app
catch.
  if. 0~:exc=. ExceptionOccurred'' do.
    smoutput (ExceptionMessage exc)
  else.
    smoutput (13!:12'')
  end.
end.
)

ANDROID_LOG_UNKNOWN=: 0
ANDROID_LOG_DEFAULT=: 1
ANDROID_LOG_VERBOSE=: 2
ANDROID_LOG_DEBUG=: 3
ANDROID_LOG_INFO=: 4
ANDROID_LOG_WARN=: 5
ANDROID_LOG_ERROR=: 6
ANDROID_LOG_FATAL=: 7
ANDROID_LOG_SILENT=: 8

log_v=: 'liblog.so __android_log_print > i i *c *c'&(15!:0) @: (ANDROID_LOG_VERBOSE&;)
log_d=: 'liblog.so __android_log_print > i i *c *c'&(15!:0) @: (ANDROID_LOG_DEBUG&;)
log_i=: 'liblog.so __android_log_print > i i *c *c'&(15!:0) @: (ANDROID_LOG_INFO&;)
log_w=: 'liblog.so __android_log_print > i i *c *c'&(15!:0) @: (ANDROID_LOG_WARN&;)
log_e=: 'liblog.so __android_log_print > i i *c *c'&(15!:0) @: (ANDROID_LOG_ERROR&;)
log_f=: 'liblog.so __android_log_print > i i *c *c'&(15!:0) @: (ANDROID_LOG_FATAL&;)
getenv''
coclass 'jnobject'
coinsert 'jni'

ClassName=: ''
create=: 4 : 0
assert. ''-.@-:ClassName [ 'jnobject is an abstract class'
x=. boxxopen x
if. 0=#x do.
  y=. 'Ljava/lang/String;'
else.
  if. ')' e. y do.
    y=. '(' -.~ ({.~ i.&')') y
  end.
  y=. y, 'Ljava/lang/String;'
end.
obj=. ((<str=. NewStringUTF 18!:5''),~ x) jniNewObject ClassName, ' ', y
jnicheck DeleteLocalRef <str
obj
)

jcreate=: 0:

destroy=: 3 : 'codestroy $0 [ ExceptionClear $0'
addOverride=: 4 : 0
if. ' ' e. x do. x=. <;._1 ' ', deb x end.
x=. boxxopen x
for_m. x do.
  y ('setjnOverride (Ljava/lang/String;)V' jniMethod)~ m
end.
EMPTY
)
