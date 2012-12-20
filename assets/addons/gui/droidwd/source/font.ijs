NB. name size [italic] [bold] [underline] [angle]
wdfontdef=: 3 : 0
NB. f=. getfontspec args=. shiftargs''
NB. if. 0=WDERRN do. cFontdef=: f end.
if. 0= #args=. shiftargs'' do. seterr 'bad font name : ' return. end.
cFontdef=: '"' -.~ }. ;' ',&.> args
)

NB. id name size [italic] [bold] [underline] [angle]
wdsetfont=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
f=. getfontspec }.args
if. 0=WDERRN do.
  win=. getchildwin window
  'face asize style angle'=. f
  'Bold Italic Underline Strikeout'=. 4{. |. #: style
  jniCheck ft=. 'android.graphics.Typeface' ('create (LString;I)LTypeface;' jniStaticMethod)~ face;(Bold + 2*Italic)
  try.
    jniCheck win ('setTypeface (LTypeface;)V' jniMethod)~ ft
    jniCheck win ('setTextSize (F)V' jniMethod)~ pt2sp asize
  catch.
    ExceptionClear''
  end.
  jniCheck DeleteLocalRef"0 win;ft
end.
)

NB. name size [italic] [bold] [underline] [angle]
getfontspec=: 3 : 0
if. 0= #args=. y do. seterr 'bad font name : ' return.
elseif. 2> #args do. seterr 'bad number : ' return.
elseif. 7< #args do. seterr 'extra parameter : ' return.
end.
font=. >@{.args
if. -.@isnum asize=. 1{::args do. seterr 'bad number : ' return. end.
'style angle'=. 0 0
for_s1. 2}.args do.
  s=. >s1
  if. s1 e. <'default' do. continue.
  elseif. s1 e. 'italic' ; 'bold' ; 'underline' do. style=. style (23 b.) <. 2 ^ (<s) i.~ 'italic' ; 'bold' ; 'underline'
  elseif. 'angle'-:5{.s do. if. isnum 5}.s do. angle=. <. {.@(0&".) 5}.s else. seterr 'bad style : ' return. end.
  elseif. do. seterr 'bad style : ' return.
  end.
end.
font ; ({. 0&". asize) ; style ; angle  NB. style: bitwise or: 1 italic 2 bold 4 underline
)

NB. name size [italic] [bold] [underline] [angle]
wdmbfont=: 3 : 0
f=. ''
if. 0< #args=. shiftargs'' do.
  f=. getfontspec args
  if. 0~:WDERRN do. return. end.
end.
'' return. NB. not implemented
if. #f do.
  fontdialog ''; (>@{.f),' ', (": >1{f)
else.
  fontdialog '';''
end.
)

