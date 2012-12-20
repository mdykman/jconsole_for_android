NB. drawable
load 'gui/android'

drawres=. crunch_jadrawable_ jpath '~Public/gui/android/test/res'
smoutput drawres
jniCheck DeleteLocalRef_jni_"0 {:"1 drawres
