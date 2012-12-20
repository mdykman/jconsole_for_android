3 : 0''
if. 'Android'-:UNAME do.
  jniCheck FILL=: ('FILL Landroid/graphics/Paint$Style;' jniStaticField) 'android/graphics/Paint$Style'
  jniCheck FILL_AND_STROKE=: ('FILL_AND_STROKE Landroid/graphics/Paint$Style;' jniStaticField) 'android/graphics/Paint$Style'
  jniCheck STROKE=: ('STROKE Landroid/graphics/Paint$Style;' jniStaticField) 'android/graphics/Paint$Style'

  jniCheck Typeface_DEFAULT=: ('DEFAULT Landroid/graphics/Typeface;' jniStaticField) 'android/graphics/Typeface'
  jniCheck Typeface_DEFAULT_BOLD=: ('DEFAULT_BOLD Landroid/graphics/Typeface;' jniStaticField) 'android/graphics/Typeface'
  jniCheck Typeface_MONOSPACE=: ('MONOSPACE Landroid/graphics/Typeface;' jniStaticField) 'android/graphics/Typeface'
  jniCheck Typeface_SANS_SERIF=: ('SANS_SERIF Landroid/graphics/Typeface;' jniStaticField) 'android/graphics/Typeface'
  jniCheck Typeface_SERIF=: ('SERIF Landroid/graphics/Typeface;' jniStaticField) 'android/graphics/Typeface'

NB. object
  jniCheck ARGB_8888=: NewGlobalRef < a1=. ('ARGB_8888 Landroid/graphics/Bitmap$Config;' jniStaticField) 'android/graphics/Bitmap$Config'
  jniCheck DeleteLocalRef <a1
end.
''
)

Typeface_BOLD=: 1
Typeface_BOLD_ITALIC=: 3
Typeface_ITALIC=: 2
Typeface_NORMAL=: 0

FILL_PARENT=: _1
MATCH_PARENT=: _1
WRAP_CONTENT=: _2

BUTTON_NEGATIVE=: _2
BUTTON_NEUTRAL=: _3
BUTTON_POSITIVE=: _1
