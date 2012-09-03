require 'jni'

coclass 'ja'
coinsert 'jni'
GetJNIENV''

jniImport (0 : 0)
android.app.Activity
android.content.Context
android.content.Intent
org.dykman.j.android.AbstractActivity
org.dykman.j.android.JConsoleApp
org.dykman.jn.android.app.Activity'
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
StartActivity=: 4 : 0
'act ctx locale japparg override'=. 5{.y
app=. ('theApp LJConsoleApp;' jniStaticField) 'JConsoleApp'
if. 0= act do.
  cact=. ('activity LAbstractActivity;' jniField) app
else.
  cact=. act
end.
if. 0=ctx do. cctx=. app ('getApplicationContext ()LContext;' jniMethod)~ '' else. cctx=. ctx end.
if. 0=x do.
  intent=. 'android.content.Intent' jniNewObject~ ''
  jniCheck jnact=. FindClass <'org/dykman/jn/android/app/Activity'
  intent ('setClass (LContext;LClass;)LIntent;' jniMethod)~ cctx;jnact
  intent ('putExtra (LString;LString;)LIntent;' jniMethod)~ 'locale';locale
  intent ('putExtra (LString;LString;)LIntent;' jniMethod)~ 'override';override
  intent ('putExtra (LString;LString;)LIntent;' jniMethod)~ 'japparg';japparg
  cact ('startActivity (LIntent;)V' jniMethod)~ intent
  jniCheck DeleteLocalRef <intent
  jniCheck DeleteLocalRef <jnact
else.
  cact ('startActivity (LIntent;)V' jniMethod)~ x
end.
if. 0=act do. jniCheck DeleteLocalRef <cact end.
if. 0=ctx do. jniCheck DeleteLocalRef <cctx end.
jniCheck DeleteLocalRef <app
0
)
android_constants=: 4 : 0
if. 'Android'-:UNAME do.
  l=. <;._2 y
  class=. './' charsub >@{.l
  p=. '_',~ '$_' charsub }. (}.~ i:&'/') class
  if. 4=x do.
    "."1 p,"1 (>}.l),"1 '=: (''',"1 (>}.l),"1 ' I'' jniStaticField) ''',"1 class,"1 ''''
  else.
    "."1 p,"1 (>}.l),"1 '=: (''',"1 (>}.l),"1 ' F'' jniStaticField) ''',"1 class,"1 ''''
  end.
end.
EMPTY
)

4 android_constants (0 : 0)
android.view.Window
FEATURE_ACTION_BAR
FEATURE_ACTION_BAR_OVERLAY
FEATURE_ACTION_MODE_OVERLAY
FEATURE_CONTEXT_MENU
FEATURE_CUSTOM_TITLE
FEATURE_INDETERMINATE_PROGRESS
FEATURE_LEFT_ICON
FEATURE_NO_TITLE
FEATURE_OPTIONS_PANEL
FEATURE_PROGRESS
FEATURE_RIGHT_ICON
)

4 android_constants (0 : 0)
android.view.WindowManager$LayoutParams
FLAG_ALLOW_LOCK_WHILE_SCREEN_ON
FLAG_ALT_FOCUSABLE_IM
FLAG_BLUR_BEHIND
FLAG_DIM_BEHIND
FLAG_DISMISS_KEYGUARD
FLAG_DITHER
FLAG_FORCE_NOT_FULLSCREEN
FLAG_FULLSCREEN
FLAG_HARDWARE_ACCELERATED
FLAG_IGNORE_CHEEK_PRESSES
FLAG_KEEP_SCREEN_ON
FLAG_LAYOUT_INSET_DECOR
FLAG_LAYOUT_IN_SCREEN
FLAG_LAYOUT_NO_LIMITS
FLAG_NOT_FOCUSABLE
FLAG_NOT_TOUCHABLE
FLAG_NOT_TOUCH_MODAL
FLAG_SCALED
FLAG_SECURE
FLAG_SHOW_WALLPAPER
FLAG_SHOW_WHEN_LOCKED
FLAG_SPLIT_TOUCH
FLAG_TOUCHABLE_WHEN_WAKING
FLAG_TURN_SCREEN_ON
FLAG_WATCH_OUTSIDE_TOUCH
)

4 android_constants (0 : 0)
android.widget.LinearLayout
HORIZONTAL
SHOW_DIVIDER_BEGINNING
SHOW_DIVIDER_END
SHOW_DIVIDER_MIDDLE
SHOW_DIVIDER_NONE
VERTICAL
)

4 android_constants (0 : 0)
android.widget.RelativeLayout
ABOVE
ALIGN_BASELINE
ALIGN_BOTTOM
ALIGN_LEFT
ALIGN_PARENT_BOTTOM
ALIGN_PARENT_LEFT
ALIGN_PARENT_RIGHT
ALIGN_PARENT_TOP
ALIGN_RIGHT
ALIGN_TOP
BELOW
CENTER_HORIZONTAL
CENTER_IN_PARENT
CENTER_VERTICAL
LEFT_OF
RIGHT_OF
TRUE
)
