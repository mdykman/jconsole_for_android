NB. mb title text [style...]
wdmb=: 3 : 0
if. 0= cWindow do. '' [ seterr 'no parent selected : ' return. end.
args=. shiftargs''
title=. >@{.args
txt=. >@{.}.args
NB. sdef=. <;._1 ' mb_defbutton2 mb_defbutton3'
NB. sicon=. <;._1 ' mb_iconasterisk mb_iconexclamation mb_iconhand mb_iconinformation mb_iconquestion mb_iconstop'
NB. sbtn=. <;._1 ' mb_ok mb_okcancel mb_retrycancel mb_yesno mb_yesnocancel mb_abortretryignore'
if. 2< #args do.
  styles=. 2}.args
else.
  styles=. 0$<''
end.

NB. 1 2 3 response abort retry ignore
if. (<'mb_yesno') e. styles do.
  'pos neg neu'=. 'Yes' ; 'No' ; ''
elseif. (<'mb_yesnocancel') e. styles do.
  'pos neg neu'=. 'Yes' ; 'No' ; 'Cancel'
elseif. (<'mb_okcancel') e. styles do.
  'pos neg neu'=. 'Ok' ; '' ; 'Cancel'
elseif. (<'mb_retrycancel') e. styles do.
  'pos neg neu'=. 'Retry' ; '' ; 'Cancel'
elseif. (<'mb_abortretryignore') e. styles do.
  'pos neg neu'=. 'Retry' ; 'Abort' ; 'Ignore'
elseif. do.
  'pos neg neu'=. '' ; '' ; ''
end.

jniCheck builder=. cWindow jniNewObject 'AlertDialog$Builder LContext;'
jniCheck builder ('setTitle (LCharSequence;)LAlertDialog$Builder;' jniMethod)~ <title
jniCheck builder ('setMessage (LCharSequence;)LAlertDialog$Builder;' jniMethod)~ <txt
if. 0= # pos,neg,neu do.
  jniCheck builder ('setNeutralButton (LCharSequence;LDialogInterface$OnClickListener;)LAlertDialog$Builder;' jniMethod)~ 'Ok' ; alertdialog0_listener
else.
  if. #pos do.
    jniCheck builder ('setPositiveButton (LCharSequence;LDialogInterface$OnClickListener;)LAlertDialog$Builder;' jniMethod)~ pos ; alertdialog_listener
  end.
  if. #neg do.
    jniCheck builder ('setNegativeButton (LCharSequence;LDialogInterface$OnClickListener;)LAlertDialog$Builder;' jniMethod)~ neg ; alertdialog_listener
  end.
  if. #neu do.
    jniCheck builder ('setNeutralButton (LCharSequence;LDialogInterface$OnClickListener;)LAlertDialog$Builder;' jniMethod)~ neu ; alertdialog_listener
  end.
end.
jniCheck builder ('show ()LAlertDialog;' jniMethod)~ ''
''
)

wdmbopen=: mbopensave bind 0
wdmbsave=: mbopensave bind 2

NB. mbopen title directory filename filterpairs [style...]
NB. Filterpairs are delimited by |
NB. Styles are from the set (ofn_createprompt, ofn_filemustexist, ofn_nochangedir, ofn_overwriteprompt, ofn_pathmustexist).
NB. wd 'mbopen'
NB. wd 'mbopen  mytitle  ""  ""  "Write(*.wri)|*.wri|Word(*.doc)|*.doc" ofn_filemustexist'
mbopensave=: 3 : 0
args=. shiftargs''
title=. >@{.args
dir=. dltb >@{.}.args
fil=. dltb >@{.2}.args
filter=. dltb >@{.3}.args
ofn_style=. <;._1 ' ofn_createprompt ofn_filemustexist ofn_nochangedir ofn_overwriteprompt ofn_pathmustexist'
if. 4 <#args do.
  for_a. 4}.args do.
    if. a -.@e. ofn_style do. seterr 'bad style : ' return. end.
  end.
end.
path=. dir, ('/'#~(0<#dir)*.0<#fil), fil
if. #filter do.
  if. 0=2| +/ '|'=filter do. seterr 'bad filter : ' return. end.
  pattern=. |. L: 1 [ _2<\ <;._1 '|',filter
else.
  pattern=. ''
end.
'' return.  NB. not implemented
cWindow filechooser_jgtk_ y ; title ; pattern ; path
)
