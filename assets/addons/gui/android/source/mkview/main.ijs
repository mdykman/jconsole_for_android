NB. use layou menu values acti

mkview=: 4 : 0
'context locale'=. x
locale=. >locale
'elements idnames res draws'=: y

objs=. 0$2-2
onClicks=. 0 0$<''

for_i. i.#elements do.
  'cparent elm id attval data'=. i{elements
  if. (*#attval) +. (<elm) e. <;._1 ' AbsoluteLayout AnalogClock Button CheckBox DatePicker DigitalClock EditText FrameLayout Gallery ImageButton ImageView LinearLayout ListView ProgressBar RadioButton RadioGroup RelativeLayout ScrollView Spinner TableLayout TableRow TextView TimePicker' do.
    natt=. #att=. {."1 attval [ val=. {:"1 attval

NB. defaults
    wh=. 2#WRAP_CONTENT
    gravity=. 0
    weight=. 1.1-1.1
    column=. _1
    span=. 1
    rule=. rule2=. 0$<''
    typeface=. textStyle=. inputType=. ''
    style=. '' [ stylen=. 0
    attr=. '' [ attrn=. 0

NB. list of implemented attributes
    att0=. <;._1 ' android:paddingLeft android:paddingTop android:paddingRight android:paddingBottom android:padding android:background android:textColor android:text android:textSize android:textAppearance android:maxWith android:maxHeight android:scaleType android:adjustViewBounds android:orientation android:gravity android:stretchColumns android:layout_gravity android:layout_weight android:layout_column android:layout_span android:layout_marginLeft android:layout_marginTop android:layout_marginRight android:layout_marginBottom android:layout_width android:layout_height'
    att0=. att0, <;._1 ' android:layout_toLefTOf android:layout_toRightOf android:layout_above android:layout_below android:layout_alignBaseline android:layout_alignLeft android:layout_alignTop android:layout_alignRight android:layout_alignBottom android:layout_alignParentLeft android:layout_alignParentTop android:layout_alignParentRight android:layout_alignParentBottom android:layout_centerInParent android:layout_centerHorizontal android:layout_centerVertical android:onClick'
    att0=. att0, <;._1 ' android:checked android:drawSelectorOnTop android:typeface android:textStyle android:password android:phoneNumber android:inputType android:src android:style'

NB. style may affect chosing constructor
    if. natt > j=. att i. <'android:style' do. style=. (res stringres) j{::val end.

    if. #style do.
      if. elm-:'ProgressBar' do.
        if. '@android:style/'-:15{.style do.
          stylen=. {. 0,~ ". 'R_attr_', ('Widget.ProgressBar.';'progressBarStyle') stringreplace 15}.style, '_jaresu_'
        end.
      end.
    end.

    if. *./ 0=attrn,stylen do.
      objs=. objs, e=. jniCheck (elm,' LContext;') jniNewObject~ context
    else.
      objs=. objs, e=. jniCheck (elm, ' LContext;Landroid/util/AttributeSet;I') jniNewObject~ context;attrn;stylen
    end.

NB. general
    margin=. padding=. 4#0
NB. Id default to _1
    if. _1~:id do. jniCheck e ('setId (I)V' jniMethod)~ id end.
NB. padding
    if. natt > j=. att i. <'android:paddingLeft' do. padding=. (<.@(res numberres idnames) j{::val) 0 }padding end.
    if. natt > j=. att i. <'android:paddingTop' do. padding=. (<.@(res numberres idnames) j{::val) 1 }padding end.
    if. natt > j=. att i. <'android:paddingRight' do. padding=. (<.@(res numberres idnames) j{::val) 2 }padding end.
    if. natt > j=. att i. <'android:paddingBottom' do. padding=. (<.@(res numberres idnames) j{::val) 3 }padding end.
    if. natt > j=. att i. <'android:padding' do. padding=. 4# <.@(res numberres idnames) j{::val end.
    if. 0 e. 0=padding do. jniCheck e ('setPadding (IIII)V' jniMethod)~ <"0 padding end.
NB. graphics
    if. natt > j=. att i. <'android:background' do.
      if. L. a=. (draws drawres) j{::val do.
        jniCheck e ('setBackgroundColor (I)V' jniMethod)~ >a
      else.
        f=. (APILEVEL_ja_<16){::'setBackground';'setBackgroundDrawable'
        if. ''-:a do.
          jniCheck e ((f,' (LDrawable;)V') jniMethod)~ 0
        else.
          jniCheck e ((f,' (LDrawable;)V') jniMethod)~ bd=. jniCheck 'BitmapDrawable LBitmap;' jniNewObject~ a
          jniCheck DeleteLocalRef <bd
        end.
      end.
    end.
    if. natt > j=. att i. <'android:src' do.
      if. L. a=. (draws drawres) j{::val do.
        jniCheck e ('setBackgroundColor (I)V' jniMethod)~ >a
      else.
        if. ''-:a do.
          jniCheck e ('setImageBitmap (LBitmap;)V' jniMethod)~ 0
        else.
          jniCheck e ('setImageBitmap (LBitmap;)V' jniMethod)~ a
        end.
      end.
    end.
NB. text
    if. natt > j=. att i. <'android:text' do. jniCheck e ('setText (LCharSequence;)V' jniMethod)~ <(res stringres) j{::val end.
    if. natt > j=. att i. <'android:textSize' do. jniCheck e ('setTextSize (I)V' jniMethod)~ <.@(res numberres idnames) j{::val end.
    if. natt > j=. att i. <'android:textColor' do. jniCheck e ('setTextColor (I)V' jniMethod)~ (res colorres) j{::val end.
    if. natt > j=. att i. <'android:textAppearance' do. jniCheck e ('setTextAppearance (LContext;I)V' jniMethod)~ context;<.@(res numberres idnames) j{::val end.
    if. natt > j=. att i. <'android:typeface' do. typeface=. (res stringres) j{::val end.
    if. natt > j=. att i. <'android:textStyle' do. textStyle=. (res stringres) j{::val end.
    if. #typeface,textStyle do.
      ff=. fonts {::~ 5|(fonts=. ;:'default default_bold monospace san_serif serif') i. <typeface
      tf=. jniCheck (((toupper ff),' LTypeface;') jniStaticField) 'android.graphics.Typeface'
      st=. 4|(;:'normal bold italic bold_italic') i. <textStyle
      jniCheck e ('setTypeface (LTypeface;I)V' jniMethod)~ tf;st
    end.
NB. inputtype
    if. natt > j=. att i. <'android:inputType' do. inputType=. '|', (res stringres) j{::val end.
    if. natt > j=. att i. <'android:password' do. inputType=. inputType, '|', 'textPassword' end.
    if. natt > j=. att i. <'android:phoneNumber' do. inputType=. inputType, '|', 'phone' end.
    if. #inputType do.
      jniCheck e ('setInputType (I)V' jniMethod)~ (23 b.)/ inputType1 {~ inputType0 i. ~. <;._1 inputType
    end.
NB. checkbox
    if. natt > j=. att i. <'android:checked' do. jniCheck e ('setChecked (Z)V' jniMethod)~ <.@(res numberres idnames) j{::val end.
NB. spinner not yet worked
NB.     if. natt > j=. att i. <'android:drawSelectorOnTop' do. jniCheck e ('setDrawSelectorOnTop (Z)V' jniMethod)~ <.@(res numberres idnames) j{::val end.
NB. image
    if. natt > j=. att i. <'android:maxWith' do. jniCheck e ('setMaxWith (I)V' jniMethod)~ <.@(res numberres idnames) j{::val end.
    if. natt > j=. att i. <'android:maxHeight' do. jniCheck e ('setMaxHeight (I)V' jniMethod)~ <.@(res numberres idnames) j{::val end.
    if. natt > j=. att i. <'android:scaleType' do. jniCheck e ('setScaleType (I)V' jniMethod)~ scaletyperes j{::val end.
    if. natt > j=. att i. <'android:adjustViewBounds' do. jniCheck e ('setadjustViewBounds (Z)V' jniMethod)~ <.@(res numberres idnames) j{::val end.
NB. onClick event
    if. natt > j=. att i. <'android:onClick' do.
      onClick=. j{::val
      if. (<onClick) -.@e. {."1 onClicks do.
NB. concrete object for abstract interface
NB. this method takes precedence over the standard callback to onOptionsItemSelected
        jniCheck listener=. '' jniOverride 'org.dykman.jn.android.view.View$OnClickListener2' ; locale ; onClick
        onClicks=. onClicks, onClick;listener
      else.
        listener=. 1{:: (({."1 onClicks) i. <onClick){onClicks
      end.
      jniCheck e ('setOnClickListener (LView$OnClickListener;)V' jniMethod)~ listener
    end.
NB. layout .......
    if. natt > j=. att i. <'android:orientation' do. jniCheck e ('setOrientation (I)V' jniMethod)~ 'vertical'-:j{::val end.
    if. natt > j=. att i. <'android:gravity' do. jniCheck e ('setGravity (I)V' jniMethod)~ gravityres j{::val end.
    if. natt > j=. att i. <'android:stretchColumns' do. stretchcolumns j{::val end.
NB. attributes below will need layoutparams
NB. gravity
    if. natt > j=. att i. <'android:layout_gravity' do. gravity=. gravityres j{::val end.
NB. wieght
    if. natt > j=. att i. <'android:layout_weight' do. weight=. (res numberres idnames) j{::val end.
NB. tablelayout
    if. natt > j=. att i. <'android:layout_column' do. column=. <.@(res numberres idnames) j{::val end.
    if. natt > j=. att i. <'android:layout_span' do. span=. <.@(res numberres idnames) j{::val end.
NB. margin
    if. natt > j=. att i. <'android:layout_marginLeft' do. margin=. (<.@(res numberres idnames) j{::val) 0 }margin end.
    if. natt > j=. att i. <'android:layout_marginTop' do. margin=. (<.@(res numberres idnames) j{::val) 1 }margin end.
    if. natt > j=. att i. <'android:layout_marginRight' do. margin=. (<.@(res numberres idnames) j{::val) 2 }margin end.
    if. natt > j=. att i. <'android:layout_marginBottom' do. margin=. (<.@(res numberres idnames) j{::val) 3 }margin end.
NB. width,height
    if. natt > j=. att i. <'android:layout_width' do. wh=. (<.@(res numberres idnames) j{::val) 0 }wh end.
    if. natt > j=. att i. <'android:layout_height' do. wh=. (<.@(res numberres idnames) j{::val) 1 }wh end.
NB. relativelayout
    if. #r=. att ([-.-.) addrule do. rule=. j{att [ rulenum=. (j=. att i. r){val end.
    if. #r=. att ([-.-.) addrule2 do. rule2=. j{att [ anchor=. (j=. att i. r){val end.
NB. fill layoutparams
    if. (*#rule,rule2) +. (0 e. 0=margin) +. (0 e. WRAP_CONTENT=wh) +. (0~:gravity) +. (0~:weight) +. (_1~:column) +. (1~:span) do.
      lpclass=. 'android.view.ViewGroup$LayoutParams'
NB. get layoutparams class of parent
      if. _1~:cparent do.
        cl=. '$LayoutParams',~ 1{::cparent{elements
        if. #r=. I. (1&e.)@(cl&E.)&> layoutparams do.
          lpclass=. ({.r){::layoutparams
        end.
      end.
      jniCheck lp=. (lpclass, ' II') jniNewObject~ <"0 wh
NB. gravity
      if. 0~:gravity do. jniCheck lp ('gravity I' jniField)~ gravity end.
NB. weight
      if. 0~:weight do. jniCheck lp ('weight F' jniField)~ <weight end.
NB. span
      if. 1~:span do. jniCheck lp ('span I' jniField)~ <span end.
NB. column
      if. _1~:column do. jniCheck lp ('column I' jniField)~ <column end.
NB. margin
      if. 0 e. 0=margin do. jniCheck lp ('setMargins (IIII)V' jniMethod)~ <"0 margin end.
NB. relativelayout
      for_j. i.#rule do.
        if. 1= r=. <.@(res numberres idnames) j{::rulenum do.
          jniCheck lp ('addRule (I)V' jniMethod)~ ralativelayoutrule i. 15&}.&.> j{rule
        end.
      end.
      for_j. i.#rule2 do.
        r=. <.@(res numberres idnames) j{::anchor
        jniCheck lp ('addRule (II)V' jniMethod)~ r;~ ralativelayoutrule i. 15&}.&.> j{rule2
      end.
NB. setlayoutparams must before addview
      jniCheck e ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
      jniCheck DeleteLocalRef <lp
    end.
    if. _1~:cparent do.
NB. add view to parent
      jniCheck (cparent{objs) ('addView (LView;)V' jniMethod)~ e
    end.
NB. debug
    att1=. (att-.'id';'android:id';'xmlns:android') -. att0
    if. #att1 do.
      smoutput 'unknown attributes:', ; (<' ') ,&.> att1
    end.
  else.
    objs=. objs, 0
    if. 'requestFocus'-:elm do. jniCheck ({:objs) ('requestFocus ()Z' jniMethod)~ ''
    else.
      smoutput 'unknown element: ', elm
    end.
  end.
end.
NB. cleanup
if. #ob=. }. objs-.0 do. jniCheck DeleteLocalRef"0 <"0 ob end.
if. #onClicks do. jniCheck DeleteLocalRef"0 {:"1 onClicks end.
{.objs
)
