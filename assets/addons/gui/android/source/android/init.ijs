NB. init

require 'jni api/expat'

coclass 'ja'
coinsert 'jni jaresu'

NB. get JNIENV
GetJNIENV''

jniImport (0 : 0)
android.app.Activity
android.app.AlertDialog
android.app.AlertDialog$Builder
android.content.Context
android.content.DialogInterface$OnClickListener
android.content.Intent
android.graphics.Bitmap
android.graphics.Bitmap$CompressFormat
android.graphics.BitmapFactory
android.graphics.Typeface
android.graphics.drawable.BitmapDrawable
android.graphics.drawable.Drawable
android.util.DisplayMetrics
android.view.Display
android.view.WindowManager
android.widget.Toast
java.io.ByteArrayOutputStream
java.io.FileOutputStream
java.io.OutputStream
org.dykman.j.android.AbstractActivity
org.dykman.j.android.JConsoleApp
org.dykman.jn.android.app.Activity
)

NB.      Platform Version      API Level      VERSION_CODE
NB. Android 4.1, 4.1.1         16        JELLY_BEAN
NB. Android 4.0.3, 4.0.4       15        ICE_CREAM_SANDWICH_MR1
NB. Android 4.0, 4.0.1, 4.0.2  14        ICE_CREAM_SANDWICH
NB. Android 3.2                13        HONEYCOMB_MR2
NB. Android 3.1.x              12        HONEYCOMB_MR1
NB. Android 3.0.x              11        HONEYCOMB
NB. Android 2.3.4              10        GINGERBREAD_MR1
NB. Android 2.3.3
NB. Android 2.3.2
NB. Android 2.3.1              9         GINGERBREAD
NB. Android 2.3
NB. Android 2.2.x              8         FROYO
NB. Android 2.1.x              7         ECLAIR_MR1
NB. Android 2.0.1              6         ECLAIR_0_1
NB. Android 2.0                5         ECLAIR
NB. Android 1.6                4         DONUT
NB. Android 1.5                3         CUPCAKE
NB. Android 1.1                2         BASE_1_1
NB. Android 1.0                1         BASE

3 : 0''
APILEVEL=: 3
if. 'Android'-:UNAME do.
  try.
    jniCheck APILEVEL=: ('SDK_INT I' jniStaticField) 'android.os.Build$VERSION'
  catch.
    ExceptionClear''
  end.
end.
)

