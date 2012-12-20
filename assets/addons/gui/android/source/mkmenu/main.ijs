
mkmenu=: 4 : 0
'context rootmenu locale'=. x     NB. context
locale=. >locale
'elements idnames res'=. y

objs=. 0$0
groups=. 0$0
onClicks=. 0 0$<''

for_i. i.#elements do.
  'cparent elm id cmenu cgroup attval data'=. i{elements
  natt=. #att=. {."1 attval [ val=. {:"1 attval
  if. (<elm) e. <;._1 ' menu submenu item' do.

NB. defaults
    title=. titleCondensed=. menuCategory=. onClick=. '' [ alphabeticShortcutcut=. numericShortcut=. ' '
    orderInCategory=. checkable=. checked=. 0 [ enabled=. visible=. 1
    e=. 0

NB. list of implemented attributes
    att0=. <;._1 ' android:title android:titleCondensed android:alphabeticShortcut android:numericShortcut android:checkable android:checked android:visible android:enabled android:orderInCategory android:menuCategory android:onClick'

NB. Id 0=NONE
    id=. id>.0
    if. natt > j=. att i. <'android:title' do. title=. (res stringres) j{::val end.
    if. natt > j=. att i. <'android:titleCondensed' do. titleCondensed=. (res stringres) j{::val end.
    if. natt > j=. att i. <'android:alphabeticShortcut' do. alphabeticShortcutcut=. {.(res stringres) j{::val end.
    if. natt > j=. att i. <'android:numericShortcut' do. numericShortcut=. {.(res stringres) j{::val end.
    if. natt > j=. att i. <'android:checkable' do. checkable=. <.@(res numberres idnames) j{::val end.
    if. natt > j=. att i. <'android:checked' do. checked=. <.@(res numberres idnames) j{::val end.
    if. natt > j=. att i. <'android:enabled' do. enabled=. <.@(res numberres idnames) j{::val end.
    if. natt > j=. att i. <'android:visible' do. visible=. <.@(res numberres idnames) j{::val end.
    if. natt > j=. att i. <'android:orderInCategory' do. orderInCategory=. <.@(res numberres idnames) j{::val end.
    if. natt > j=. att i. <'android:menuCategory' do. menuCategory=. j{::val end.
    if. natt > j=. att i. <'android:onClick' do. onClick=. j{::val end.
    select. <elm
    case. 'menu' do.
      objs=. objs, rootmenu
    case. 'submenu' do.
      objs=. objs, e=. jniCheck (cmenu{objs) ('addSubMenu (IIILCharSequence;)LSubMenu;' jniMethod)~ cgroup;id;orderInCategory;title
    case. 'item' do.
      objs=. objs, e=. jniCheck (cmenu{objs) ('add (IIILCharSequence;)LMenuItem;' jniMethod)~ cgroup;id;orderInCategory;title
    end.
    if. e do.
      if. #titleCondensed do. jniCheck e ('setTitleCondensed (LCharSequence;)LMenuItem;' jniMethod)~ <titleCondensed end.
      if. 0 e. ' '= alphabeticShortcutcut,numericShortcut do. jniCheck e ('setShortcut (CC)LMenuItem;' jniMethod)~ numericShortcut;alphabeticShortcutcut end.
      if. checkable do. jniCheck e ('setCheckable (Z)LMenuItem;' jniMethod)~ checkable end.
      if. checked do. jniCheck e ('setChecked (Z)LMenuItem;' jniMethod)~ checked end.
      if. 0=enabled do. jniCheck e ('setEnabled (Z)LMenuItem;' jniMethod)~ enabled end.
      if. 0=visible do. jniCheck e ('setVisible (Z)LMenuItem;' jniMethod)~ visible end.
      if. #onClick do.
        if. (<onClick) -.@e. {."1 onClicks do.
NB. concrete object for abstract interface
NB. this method takes precedence over the standard callback to onOptionsItemSelected
          jniCheck listener=. '' jniOverride 'org.dykman.jn.android.view.MenuItem$OnMenuItemClickListener2' ; locale ; onClick
          onClicks=. onClicks, onClick;listener
        else.
          listener=. 1{:: (({."1 onClicks) i. <onClick){onClicks
        end.
        jniCheck e ('setOnMenuItemClickListener (LMenuItem$OnMenuItemClickListener;)LMenuItem;' jniMethod)~ listener
      end.
    end.
NB. debug
    att1=. (att-.'id';'android:id';'xmlns:android') -. att0
    if. #att1 do.
      smoutput 'unknown attributes:', ; (<' ') ,&.> att1
    end.
  else.
    objs=. objs, 0
    if. elm-.@-:'group' do.
      smoutput 'unknown element: ', elm
    end.
  end.
end.
NB. cleanup
if. #ob=. }. objs-.0 do. jniCheck DeleteLocalRef"0 <"0 ob end.
if. #onClicks do. jniCheck DeleteLocalRef"0 {:"1 onClicks end.
0
)
