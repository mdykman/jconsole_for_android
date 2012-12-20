coclass 'jamkview'
coinsert 'jni jaresu'

jniImport ::0: (0 : 0)
android.content.Context
android.graphics.Bitmap
android.graphics.BitmapFactory
android.graphics.Typeface
android.graphics.drawable.BitmapDrawable
android.graphics.drawable.Drawable
android.view.View
android.view.View$OnClickListener
android.view.ViewGroup
android.view.WindowManager
android.widget.AbsListView
android.widget.AbsoluteLayout
android.widget.AdapterView$OnItemClickListener
android.widget.AdapterView$OnItemSelectedListener
android.widget.AnalogClock
android.widget.ArrayAdapter
android.widget.Button
android.widget.CheckBox
android.widget.DatePicker
android.widget.DigitalClock
android.widget.EditText
android.widget.FrameLayout
android.widget.Gallery
android.widget.HorizontalScrollView
android.widget.ImageButton
android.widget.ImageView
android.widget.LinearLayout
android.widget.ListAdapter
android.widget.ListView
android.widget.ProgressBar
android.widget.RadioButton
android.widget.RadioGroup
android.widget.RelativeLayout
android.widget.ScrollView
android.widget.Spinner
android.widget.SpinnerAdapter
android.widget.TableLayout
android.widget.TableRow
android.widget.TextView
android.widget.TimePicker
)

inputTypes=: (;:@deb);._2 (0 : 0)
none                16b00000000
text                16b00000001
textCapCharacters   16b00001001
textCapWords        16b00002001
textCapSentences    16b00004001
textAutoCorrect     16b00008001
textAutoComplete    16b00010001
textMultiLine       16b00020001
textImeMultiLine    16b00040001
textNoSuggestions   16b00080001
textUri             16b00000011
textEmailAddress    16b00000021
textEmailSubject    16b00000031
textShortMessage    16b00000041
textLongMessage     16b00000051
textPersonName      16b00000061
textPostalAddress   16b00000071
textPassword        16b00000081
textVisiblePassword 16b00000091
textWebEditText     16b000000a1
textFilter          16b000000b1
textPhonetic        16b000000c1
textWebEmailAddress 16b000000d1
textWebPassword     16b000000e1
number              16b00000002
numberSigned        16b00001002
numberDecimal       16b00002002
numberPassword      16b00000012
phone               16b00000003
datetime            16b00000004
date                16b00000014
time                16b00000024
)

inputType0=: {."1 inputTypes
inputType1=: 0". >1{"1 inputTypes
