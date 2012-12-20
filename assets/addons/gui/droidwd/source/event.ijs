return0=: 0:
return1=: 1:

form_evt=: 3 : 0
'widget event child data'=. y
if. _1= ix=. windowlistidx widget do. return. end.
if. cWindow~:widget do.
  if. cRadio do. DeleteLocalRef <cRadio end.
  cSubform=: '' [ cSetFont=: '' [ cContainer=: cRadio=: cChild=: 0 [ cWindow=: widget
end.
'parentid locale'=. (WindowListId, WindowListLocale){ix{windowList
syshandler=. parentid, '_handler'
sysevent=. parentid, ((child-.@-:'')#'_', child), '_', event
sysdefault=. parentid, '_default'
sysparent=. parentid
syschild=. child
systype=. event
syslocalep=. locale
syslocalec=. ''
syshwndp=. ":widget
syshwndc=. ":cChild
sysfocus=. ''
NB. if. ''-: sysfocus=. getcchildid ::(''"_) w=. gtk_window_get_focus widget do.
NB.   if. 0~: w do.
NB.     sysfocus=. getcchildid ::(''"_) gtk_widget_get_parent w
NB.   end.
NB. end.
syslastfocus=. ''
sysdata=: data
wdd=. ;: 'syshandler sysevent sysdefault sysparent syschild systype syslocalep syslocalec syshwndp syshwndc sysfocus syslastfocus sysmodifiers', (0<#sysdata)#' sysdata'
wddata=. ".&.>wdd
qdata=. 0 2$<''
for_ls. (widget = >{."1 childList)#childList do.
  qdata=. qdata, childevtdata 1 2 3{ls
end.
NB. sysmodifiers=: ,'0'
wdqdata=: (wdd ,. wddata) , qdata
if. #locale do.
  if. (0: <: 18!:0) <locale do.
    if. 3= 4!:0 <fn=. 'wdhandler_',locale,'_' do.
      fn~ ''
    end.
  end.
end.
)

system_evt=: 3 : 0
'event handler'=. y
parentid=. 'sys'
syshandler=. parentid, '_handler'
sysevent=. parentid, '_', event
sysdefault=. parentid, '_default'
wdd=. ;: 'syshandler sysevent sysdefault'
wddata=. ".&.>wdd
qdata=. 0 2$<''
wdqdata=: (wdd ,. wddata) , qdata
if. 3= 4!:0 <fn=. handler, '_z_' do.
  fn~ ''
elseif. 3= 4!:0 <fn=. handler, '__' do.
  fn~ ''
end.
)

child_evt=: 4 : 0
eventcat=. x
'vie event'=. y
'view widget'=. 2{.vie
childdata=. 0 2$0
if. 0=eventcat do. NB. normal child
  if. _1= ix=. getcchildidx widget do. return. end.
  'pawin childid iclass'=. 0 2 3{ ix{childList
NB.   Activity MakeToast_ja_ 'child event for: ', ":childid
  for_ls. (pawin = >{."1 childList)#childList do.
    childdata=. childdata, childevtdata 1 2 3{ls
  end.
elseif. 1=eventcat do. NB. menu item
  if. _1= ix=. cWindow getmenuidx widget do. return. end.
  'pawin childid'=. 0 2{ ix{menuList
NB.   Activity MakeToast_ja_ 'menu event for: ', ":childid
  for_ls. (pawin = >{."1 childList)#childList do.
    childdata=. childdata, childevtdata 1 2 3{ls
  end.
elseif. 2=eventcat do. NB. toolbar item
  if. _1= ix=. cWindow gettoolbaridx widget do. return. end.
  'pawin childid'=. 0 2{ ix{toolbarList
elseif. do. assert. 0
end.
if. 0&= #pals=. (pawin = >{."1 windowList)#windowList do. return. end.
'parentid locale'=. (WindowListId, WindowListLocale){ {.pals
syslocalec=. ''
if. 0=eventcat do. NB. normal child
  if. _1~: ix=. getcchildidx widget do.
    if. #subform=. (<ix,ChildListSubform){::childList do. parentid=. subform end.
    syslocalec=. (<ix,ChildListLocalec){::childList
  end.
end.
syshandler=. parentid, '_handler'
sysevent=. parentid, '_', childid, '_', event
sysdefault=. parentid, '_default'
sysparent=. parentid
syschild=. childid
systype=. event
syslocalep=. locale
syshwndp=. ":pawin
syshwndc=. ":widget
sysfocus=. ''
NB. if. ''-: sysfocus=. getcchildid ::(''"_) w=. gtk_window_get_focus pawin do.
NB.   if. 0~: w do.
NB.     sysfocus=. getcchildid ::(''"_) gtk_widget_get_parent w
NB.   end.
NB. end.
syslastfocus=. ''
wdd=. ;: 'syshandler sysevent sysdefault sysparent syschild systype syslocalep syslocalec syshwndp syshwndc sysfocus syslastfocus sysmodifiers', (0<#sysdata)#' sysdata'
wdqdata=: (wdd ,. ".&.>wdd) , childdata
NB. sysmodifiers=: ,'0'
sysdata=: ''
locale=. (''-:syslocalec){::syslocalec;syslocalep
if. #locale do.
  if. (0: <: 18!:0) <locale do.
    if. 3= 4!:0 <fn=. 'wdhandler_',locale,'_' do.
      chgparent=. 0
      if. cWindow~:pawin do.
        chgparent=. 1
        oldcSubform=. cSubform [ oldcSetFont=. cSetFont [ oldcContainer=. cContainer [ oldcRadio=. cRadio [ oldcChild=. cChild [ oldcWindow=. cWindow
        cSubform=: '' [ cSetFont=: '' [ cContainer=: cRadio=: cChild=: 0 [ cWindow=: pawin
      end.
      fn~ ''
      if. chgparent do.
        cSubform=: oldcSubform [ cSetFont=: oldcSetFont [ cContainer=: oldcContainer [ cRadio=: oldcRadio [ cChild=: oldcChild [ cWindow=: oldcWindow
      end.
    end.
  end.
end.
)

childevtdata=: 3 : 0
'widget id iclass'=. y
wdd=. wddata=. 0$<''
view=. getchildwin widget
select. iclass
case. wdcl_spin ; wdcl_spinv do.
  wdd=. wdd, <id
  wddata=. wddata, < ": gtk_spin_button_get_value_as_int widget
case. wdcl_trackbar ; wdcl_trackbarv do.
  wdd=. wdd, <id
  wddata=. wddata, < ": view ('getProgress ()I' jniMethod)~ ''
case. wdcl_scrollbar ; wdcl_scrollbarv do.
  wdd=. wdd, <id
  wddata=. wddata, < ": <. gtk_range_get_value widget
case. wdcl_edit do.
  wdd=. wdd, <id
  jniCheck s=. jniToJString ts=. '' ('toString ()LString;' jniMethod) cs=. view ('getText ()LCharSequence;' jniMethod)~ ''
  jniCheck DeleteLocalRef"0 cs;ts
  wddata=. wddata, <s
case. wdcl_editm do.
  wdd=. wdd, <id
  jniCheck s=. jniToJString ts=. '' ('toString ()LString;' jniMethod) cs=. view ('getText ()LCharSequence;' jniMethod)~ ''
  jniCheck DeleteLocalRef"0 cs;ts
  wddata=. wddata, <s
  wdd=. wdd, <id, '_select'
  wddata=. wddata, < ": 0 0
  wdd=. wdd, <id, '_scroll'
  wddata=. wddata, < ": 0 0
case. wdcl_checkbox ; wdcl_radiobutton do.
  wdd=. wdd, <id
  jniCheck ck=. view ('isChecked ()Z' jniMethod)~ ''
  wddata=. wddata, < ": ck
case. wdcl_combobox ; wdcl_combodrop ; wdcl_combolist do.
  jniCheck nsel=. view ('getSelectedItemPosition ()I' jniMethod)~ ''
  jniCheck ncnt=. view ('getCount ()I' jniMethod)~ ''
  if. (0=ncnt) +. _1=nsel do.
    wdd=. wdd, <id
    wddata=. wddata, <''
    wdd=. wdd, <id, '_select'
    wddata=. wddata, < ": _1
  else.
    jniCheck ch=. view ('getSelectedItem ()LObject;' jniMethod)~ ''
    jniCheck s=. jniToJString ch
    jniCheck DeleteLocalRef <ch
    wdd=. wdd, <id
    wddata=. wddata, <s
    wdd=. wdd, <id, '_select'
    wddata=. wddata, < ": nsel
  end.
case. wdcl_listbox do.
  if. widget-:>{.listbox_evtdata do.
    'nsel ssel'=. }.listbox_evtdata
  else.
    nsel=. 0$0 [ ssel=. 0$<''
    jniCheck ncnt=. view ('getCount ()I' jniMethod)~ ''
    if. ncnt do.
      jniCheck sp=. view ('getCheckedItemPositions ()Landroid/util/SparseBooleanArray;' jniMethod)~ ''
      if. sp do.
        jniCheck ncnt=. sp ('size ()I' jniMethod)~ ''
        for_i. i.ncnt do.
          jniCheck pos=. sp ('keyAt (I)I' jniMethod)~ i
          jniCheck sel=. sp ('valueAt (I)Z' jniMethod)~ i
          if. sel do.
            jniCheck ch=. view ('getItemAtPosition (I)LObject;' jniMethod)~ pos
            jniCheck s=. jniToJString ch
            jniCheck DeleteLocalRef <ch
            nsel=. nsel, pos
            ssel=. ssel, <s
          end.
        end.
      end.
    end.
  end.
  if. _0=#nsel do.
    wdd=. wdd, <id
    wddata=. wddata, <''
    wdd=. wdd, <id, '_select'
    wddata=. wddata, < ": _1
  else.
    wdd=. wdd, <id
    wddata=. wddata, < }: ; ssel ,&.> <LF
    wdd=. wdd, <id, '_select'
    wddata=. wddata, < ": nsel
  end.
  jniCheck DeleteLocalRef <sp
case. wdcl_tab do.
  ix=. getcchildidx widget
  assert. _1~: ix
NB. userdata store page
  if. 0<: pagenum=. > (<ix,ChildListUserdata){childList do.
    jniCheck tw=. view ('getTabWidget ()LTabWidget;' jniMethod)~ ''
    jniCheck cw=. tw ('getChildAt (I)LView;' jniMethod)~ pagenum
    jniCheck vw=. cw ('findViewById (I)LView;' jniMethod)~ R_id_title
    jniCheck pagelabel=. jniToJString cs=. vw ('getText ()LCharSequence;' jniMethod)~ ''
    jniCheck DeleteLocalRef"0 tw;cw;vw;cs
  else.
    pagelabel=. ''
  end.
  wdd=. wdd, <id
  wddata=. wddata, < ": pagelabel
  wdd=. wdd, <id,'_select'
  wddata=. wddata, < ": pagenum
end.
assert. 1= (2:=(3!:0))&> wdd
assert. 1= (2:=(3!:0))&> wddata
jniCheck DeleteLocalRef <view
wdd ,. wddata
)

window_configure=: 3 : 0
'widget event data'=. y
if. _1= ix=. windowlistidx widget do. 0 return. end.
wh=. _2{. getGdkEventConfigure_xywh event
wh0=. (<ix, WindowListWh0) {:: windowList
NB. GTK3 bug?, window size can be larger than screen size
if. (2=GTKVER_j_) +. wh -.@-: wh1=. (<ix, WindowListWh1) {:: windowList do.
  windowList=: (<wh) (<ix, WindowListWh1) } windowList
  (wh,wh0) resizechild widget
end.
NB. remove size event bcs move and scale now almost work
NB. form_evt widget ; 'size' ; '' ; ":0 0,wh
0 NB. not cancel
)

window_key_press=: 3 : 0
'widget event data'=. y
if. 0> ix=. windowlistidx widget do. 0 return. end.
'state key'=. gtkeventkey event
'ctrl j shift'=. 2 2 2 #: state
keyevent=. '' [ child=. ''
if. (GDK_Return = key) *. 0 = ctrl do.
  if. _1= getcchildidx w=. gtk_window_get_focus widget do.
    if. _1= getcchildidx w=. gtk_widget_get_parent w do.
      keyevent=. 'enter'
    end.
  end.
elseif. (GDK_Escape = key) *. 0=ctrl do. keyevent=. 'cancel'
elseif. key e. GDK_FKeys do.
  keyevent=. 'fkey'
  child=. ('f',":(>: key - GDK_F1)),(ctrl#'ctrl'),(shift#'shift')
elseif. (key e. GDK_a + i.26) *. 1=ctrl do.
  keyevent=. 'fkey'
  child=. (key{a.),(ctrl#'ctrl')
elseif. (key e. GDK_A + i.26) *. 1=ctrl do.
  keyevent=. 'fkey'
  child=. (((a.i.'a')+(key - GDK_A)){a.),(ctrl#'ctrl'),'shift'
end.
if. #keyevent do.
  sysdata=: key
  sysmodifiers=: ,":shift+2*ctrl
  1 [ form_evt widget ; keyevent ; child ; ''
end.
0
)

window_focus_in=: 3 : 0
'widget event data'=. y
activeidx=: ~. activeidx, widget
0
)

window_delete=: 3 : 0
'widget event data'=. y
if. _1= ix=. windowlistidx widget do. 0 return. end.
if. 0= gtk_widget_get_sensitive widget do. 1 return. end.
if. 1= (<ix, WindowListCloseok) {:: windowList do. 0 return. end.
form_evt widget ; 'close' ; '' ; ''
1
)

wddestroy=: 3 : 0
widget=. y
if. _1~: ix=. windowlistidx widget do.
  windowList=: (<<<ix){windowList
end.
NB. for_i. I. (widget = (>{."1 childList)) do.
NB.   if. (wdcl_isigraph = (<i,3){::childList) do.
NB.     if. (0=(<i,ChildListUserdata){::childList) do.
NB.       l=. glgetloc_jgl2_ (<i,1){::childList
NB.       assert. #>l
NB.       destroy__l ''
NB.     end.
NB.   end.
NB. end.
if. 1 e. ix=. (widget = (>{."1 containerList)) do. containerList=: (-.ix)#containerList end.
if. 1 e. ix=. (widget = (>{."1 subformList)) do. subformList=: (-.ix)#subformList end.
if. 1 e. ix=. (widget = (>{."1 childList)) do. childList=: (-.ix)#childList end.
if. 1 e. ix=. (widget = (>{."1 menuList)) do. menuList=: (-.ix)#menuList end.
if. 1 e. ix=. (widget = (>{."1 toolbarList)) do. toolbarList=: (-.ix)#toolbarList end.
if. 1 e. ix=. (widget = (>{."1 statusbarList)) do. statusbarList=: (-.ix)#statusbarList end.
activeidx=: activeidx -. widget
DeleteGlobalRef <widget
if. 0=#windowList do.
  cleanup''
else.
  if. widget=cWindow do.
    cWindow=: {:activeidx
    if. cRadio do. DeleteGlobalRef <cRadio end.
    cSubform=: '' [ cSetFont=: '' [ cContainer=: cRadio=: cChild=: 0
    if. widget = Activity do. Activity=: 0 end.
  end.
end.
0 NB. not cancel
)

combobox_changed=: 3 : 0
'widget data'=. y
if. disable_toggle_event do. 0 return. end.
if. _1= ix=. getcchildidx widget do. 0 return. end.
0 child_evt widget ; 'select'
0 NB. not cancel
)

listbox_changed=: 3 : 0
'widget data'=. y
if. disable_toggle_event do. 0 return. end.
if. 0= widget=. gtk_tree_selection_get_tree_view widget do. 0 return. end.
if. _1= ix=. getcchildidx widget do. 0 return. end.
0 child_evt widget ; 'select'
0 NB. not cancel
)

listbox_activated=: 3 : 0
'widget path column data'=. y
if. disable_toggle_event do. 0 return. end.
NB. if. 0= widget=. gtk_tree_selection_get_tree_view widget do. 0 return. end.
if. _1= ix=. getcchildidx widget do. 0 return. end.
0 child_evt widget ; 'button'
0 NB. not cancel
)

button_toggled=: 3 : 0
'widget data'=. y
if. disable_toggle_event do. 0 return. end.
if. _1= ix=. getcchildidx widget do. 0 return. end.
0 child_evt widget ; 'button'
0 NB. not cancel
)

spin_change=: 3 : 0
'widget data'=. y
0 child_evt widget ; 'button'
0 NB. not cancel
)

scrollbar_change=: 3 : 0
'widget data'=. y
0 child_evt widget ; 'button'
0 NB. not cancel
)

listbox_onItemClick=: 3 : 0
if. disable_toggle_event do. 0 return. end.
jniCheck parent=. GetObjectArrayElement (3{y);0
jniCheck widget=. parent ('getId ()I' jniMethod)~ ''
if. 1>widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
if. _1= ix=. getcchildidx widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
if. 2= style=. > (<ix,ChildListUserdata){childList do.
  jniCheck pos=. '' ('intValue ()I' jniMethod) opos=. GetObjectArrayElement (3{y);2
  jniCheck ch=. parent ('getItemAtPosition (I)LObject;' jniMethod)~ pos
  jniCheck s=. jniToJString ch
  jniCheck DeleteLocalRef <ch
  listbox_evtdata=: widget;pos;<<s
NB. pending, listbox_evtdata may be decommitted later
  listbox_evtdata=: ''
  jniCheck DeleteLocalRef"0 opos;ch
end.
0 child_evt (parent,widget) ; (2=style){::'select';'button'
listbox_evtdata=: ''
jniCheck DeleteLocalRef <parent
1
)

listbox_onItemLongClick=: 3 : 0
if. disable_toggle_event do. 0 return. end.
jniCheck parent=. GetObjectArrayElement (3{y);0
jniCheck widget=. parent ('getId ()I' jniMethod)~ ''
if. 1>widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
if. _1= ix=. getcchildidx widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
if. 2= style=. > (<ix,ChildListUserdata){childList do.
  jniCheck pos=. '' ('intValue ()I' jniMethod) opos=. GetObjectArrayElement (3{y);2
  jniCheck ch=. parent ('getItemAtPosition (I)LObject;' jniMethod)~ pos
  jniCheck s=. jniToJString ch
  listbox_evtdata=: widget;pos;<<s
NB. pending, listbox_evtdata may be decommitted later
  listbox_evtdata=: ''
  jniCheck DeleteLocalRef"0 opos;ch
end.
0 child_evt (parent,widget) ; 'button'
listbox_evtdata=: ''
jniCheck DeleteLocalRef <parent
1
)

combobox_onItemSelected=: 3 : 0
if. disable_toggle_event do. 0 return. end.
jniCheck parent=. GetObjectArrayElement (3{y);0
jniCheck widget=. parent ('getId ()I' jniMethod)~ ''
if. 1>widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
if. _1= ix=. getcchildidx widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
0 child_evt (parent,widget) ; 'select'
jniCheck DeleteLocalRef <parent
1
)

combobox_onNothingSelected=: 3 : 0
if. disable_toggle_event do. 0 return. end.
jniCheck parent=. GetObjectArrayElement (3{y);0
jniCheck widget=. parent ('getId ()I' jniMethod)~ ''
if. 1>widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
if. _1= ix=. getcchildidx widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
0 child_evt (parent,widget) ; 'select'
jniCheck DeleteLocalRef <parent
1
)

menu_onItemSelected=: 3 : 0
'view widget'=. y
if. _1= ix=. cWindow getmenuidx widget do. 0 return. end.
1 child_evt (view,widget) ; 'button'
1
)

button_onClick=: 3 : 0
jniCheck view=. GetObjectArrayElement (3{y);0
jniCheck widget=. view ('getId ()I' jniMethod)~ ''
if. 1>widget do. 0 [ jniCheck DeleteLocalRef <view return. end.
if. _1~: ix=. getcchildidx widget do.
  0 child_evt (view,widget) ; 'button'
  1 [ jniCheck DeleteLocalRef <view
elseif. _1~: ix=. cWindow gettoolbaridx widget do.
  2 child_evt (view,widget) ; 'button'
  1 [ jniCheck DeleteLocalRef <view
elseif. do.
  0 [ jniCheck DeleteLocalRef <view return.
end.
0
)

NB.           if (event==null) {
NB.               if (actionId==EditorInfo.IME_ACTION_DONE);
NB.               // Capture soft enters in a singleLine EditText that is the last EditText.
NB.               else if (actionId==EditorInfo.IME_ACTION_NEXT);
NB.               // Capture soft enters in other singleLine EditTexts
NB.               else return false;  // Let system handle all other null KeyEvents
NB.             }
NB.             else if (actionId==EditorInfo.IME_NULL) {
NB.             // Capture most soft enters in multi-line EditTexts and all hard enters.
NB.             // They supply a zero actionId and a valid KeyEvent rather than
NB.             // a non-zero actionId and a null event like the previous cases.
NB.               if (event.getAction()==KeyEvent.ACTION_DOWN);
NB.               // We capture the event when key is first pressed.
NB.               else  return true;   // We consume the event when the key is released.
NB.             }
NB.             else  return false;
NB.             // We let the system handle it when the listener
NB.             // is triggered by something that wasn't an enter.
NB.             // ..... useful work here
NB.             return true;   // Consume the event
NB.           }
NB.         };

IME_NULL=: 0
IME_ACTION_DONE=: 6
IME_ACTION_NEXT=: 5
ACTION_DOWN=: 0

NB. public abstract boolean onEditorAction (TextView v, int actionId, KeyEvent event)
edit_onEditorAction=: 3 : 0
jniCheck action=. '' ('intValue ()I' jniMethod) oaction=. GetObjectArrayElement (3{y);1
jniCheck DeleteLocalRef <oaction
jniCheck event=. GetObjectArrayElement (3{y);2
if. 0=event do.
  if. action -.@e. IME_ACTION_DONE,IME_ACTION_NEXT do. 0 [ DeleteLocalRef <event return. end.
elseif. IME_NULL=action do.
  if. ACTION_DOWN ~: jniCheck event ('getAction ()I' jniMethod)~'' do. 1 [ DeleteLocalRef <event return. end.
elseif. do.
  0 [ DeleteLocalRef <event return.
end.
jniCheck DeleteLocalRef <event
jniCheck view=. GetObjectArrayElement (3{y);0
jniCheck widget=. view ('getId ()I' jniMethod)~ ''
if. 1>widget do. 0 [ jniCheck DeleteLocalRef <view return. end.
if. _1~: ix=. getcchildidx widget do.
  0 child_evt (view,widget) ; 'button'
  1 [ jniCheck DeleteLocalRef <view
end.
0
)

NB. onLayout(boolean changed, int left, int top, int right, int bottom)
fixed1_onLayout=: 3 : 0
jniCheck changed=. '' ('booleanValue ()Z' jniMethod) ochanged=. GetObjectArrayElement (3{y);0
jniCheck DeleteLocalRef <ochanged
if. 0=changed do. 0 return. end.
jniCheck h=. (2{y) ('getHeight ()I' jniMethod)~ ''
jniCheck w=. (2{y) ('getWidth ()I' jniMethod)~ ''
wh=. w,h
assert. 0~:cWindow
idx=. windowlistidx cWindow
assert. _1~:idx
fixed1=. 2{y
wh0=. (<idx, WindowListWh0) {:: windowList
'tbvisi tbcnt tbpx'=. 1 2 3{ (<idx, WindowListToolbar){:: windowList
offset=. <. tbvisi *. tbpx
windowList=: (<wh) (<idx, WindowListWh1) } windowList
(wh,wh0) resizechild cWindow, fixed1,offset
jniCheck DeleteLocalRef <fixed1
form_evt cWindow ; 'size' ; '' ; ":0 0,w,h
1
)

tab_createTabContent=: 3 : 0
jniCheck s=. jniToJString cs=. GetObjectArrayElement (3{y);0
assert. 'tag'-:3{.s
idn=. 0 ". 3}.s
assert. 0~:cWindow
jniCheck fixed1=. cWindow jniNewObject 'AbsoluteLayout LContext;'
jniCheck fixed1 ('setId (I)V' jniMethod)~ idn
jniCheck DeleteLocalRef <cs
<fixed1
)

tab_onTabChanged=: 3 : 0
if. disable_toggle_event do. 0 return. end.
assert. 0~:cWindow
widget=. R_id_tabhost
if. _1= ix=. getcchildidx widget do. 0 return. end.
th=. getchildwin widget
jniCheck page=. th ('getCurrentTab ()I' jniMethod)~ ''
jniCheck DeleteLocalRef <th
NB. userdata store page
childList=: (<page) (<ix,ChildListUserdata)}childList
0 child_evt widget ; 'button'
1
)

tab_switch_page=: 3 : 0
'widget page page_num data'=. y
if. disable_toggle_event do. 0 return. end.
if. _1= ix=. getcchildidx widget do. 0 return. end.
NB. userdata store page
childList=: (<page) (<ix,ChildListUserdata)}childList
0 child_evt widget ; 'button'
0 NB. not cancel
)

edit_key_press=: 3 : 0
'widget event data'=. y
if. _1= ix=. getcchildidx widget do. 0 return. end.
'state key'=. gtkeventkey event
'ctrl j shift'=. 2 2 2 #: state
if. (GDK_Return = key) *. 0 = ctrl do.
  sysdata=: key
  sysmodifiers=: ,":shift+2*ctrl
  0 child_evt widget ; 'button'
  1 return.
end.
0
)

toolbar_clicked_event=: 3 : 0
'widget data'=. y
if. _1= ix=. cWindow gettoolbaridx widget do. 0 return. end.
2 child_evt widget ; 'button'
0
)

seekbar_onProgressChanged=: 3 : 0
jniCheck user=. '' ('booleanValue ()Z' jniMethod) ouser=. GetObjectArrayElement (3{y);2
jniCheck DeleteLocalRef <ouser
if. 0=user do. 1 return. end.
jniCheck view=. GetObjectArrayElement (3{y);0
jniCheck widget=. view ('getId ()I' jniMethod)~ ''
if. 1>widget do. 0 [ jniCheck DeleteLocalRef <view return. end.
if. _1= ix=. getcchildidx widget do. 0 [ jniCheck DeleteLocalRef <view return. end.
0 child_evt (view,widget) ; 'button'
jniCheck DeleteLocalRef <view
1
)

seekbar_onStartTrackingTouch=: 0:
seekbar_onStopTrackingTouch=: 0:

NB. void onClick(DialogInterface dialog, int which)
alertdialog0_onClick=: 3 : 0
jniCheck dialog=. GetObjectArrayElement (3{y);0
jniCheck dialog ('dismiss ()V' jniMethod)~ ''
jniCheck DeleteLocalRef <dialog
)

alertdialog_onClick=: 3 : 0
jniCheck dialog=. GetObjectArrayElement (3{y);0
jniCheck pos=. '' ('intValue ()I' jniMethod) opos=. GetObjectArrayElement (3{y);1
jniCheck DeleteLocalRef <opos
form_evt cWindow ; 'alertdialog' ; '' ; ":pos
jniCheck dialog ('dismiss ()V' jniMethod)~ ''
jniCheck DeleteLocalRef <dialog
1
)

androidwidget_event=: 4 : 0
assert. 'jglcanvas' -: >@{.x
l=. 1{x
widget=. canvas__l
view=. 0{2{::x
evt=. >@{.y
if. 1=#y do.
  0 child_evt (view,widget) ; evt
elseif. 2=#y do.
  sysdata=: ": >1{y
  0 child_evt (view,widget) ; evt
elseif. 3=#y do.
  sysdata=: ": >1{y
  sysmodifiers=: ": 0
  0 child_evt (view,widget) ; evt
end.
0
)

timer_event=: 3 : 0
system_evt 'timer';'sys_timer'
0~:systimerid
)

invalideview=: 3 : 0
if. 0= cWindow do. return. end.
jniCheck view=. cWindow ('findViewById (I)LView;' jniMethod)~ viewidn
jniCheck view ('invalidate ()V' jniMethod)~ ''
jniCheck DeleteLocalRef <view
)

