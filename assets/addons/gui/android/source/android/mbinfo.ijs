
NB. x context
NB. y [title;]text
mbinfo=: 0&$: : (4 : 0)
ctx=. x
'title text'=. 2{.(boxopen y), <''
if. 0=#text do. title=. '' [ text=. title end.
cctx=. getjactivity ctx
jniCheck builder=. cctx jniNewObject 'AlertDialog$Builder LContext;'
jniCheck builder ('setTitle (LCharSequence;)LAlertDialog$Builder;' jniMethod)~ <title
jniCheck builder ('setMessage (LCharSequence;)LAlertDialog$Builder;' jniMethod)~ <text
jniCheck builder ('setNeutralButton (LCharSequence;LDialogInterface$OnClickListener;)LAlertDialog$Builder;' jniMethod)~ 'Ok' ; 0
jniCheck builder ('show ()LAlertDialog;' jniMethod)~ ''
if. 0=ctx do. jniCheck DeleteLocalRef <cctx end.
EMPTY
)
