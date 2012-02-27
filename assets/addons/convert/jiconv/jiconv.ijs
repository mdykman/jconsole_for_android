NB. auto-detect and convert between different character encodings.

NB. =========================================================
NB.*jiconv v convert between encodings with auto-detecting
NB. (from_encodings;to_encoding) jiconv text
NB.   from_encodings: space delimited of source encodings
NB.   to_encodings:   target encoding
NB.   text:           array of bytes (never wide characters) 
NB.
NB.   from_encodings = '' :  'UTF-8-BOM UCS-2-BOM UTF-8 GBK BIG5 LATIN1'
NB.   target_encoding = '' : 'UTF-8'
NB.
NB.   return:   encodng_detected ; array of bytes in target encoding (never wide characters)
NB.
NB. jiconv_win      window implementation
NB. jiconv_lnx      linux/darwin implementation
NB. jiconv          cross-platform cover verb
NB.   expect some differences between jiconv_win and jiconv_lnx
NB.   always put latin1 (iso-8859-1,iso-8859-15) at the end for auto-detection

cocurrent 'z'

NB. =========================================================
jiconv_win=: 4 : 0
'encs to'=. x [ y=. ,y
if. 0=#encs=. toupper deb encs do. encs=. 'UTF-8-BOM UCS-2-BOM UTF-8 GBK BIG5 LATIN1' end.
if. 0=#to=. toupper to do. to=. 'UTF-8' end.
encs=. <;._1 ' ', toupper deb encs
CP_UTF7=. 65000
CP_UTF8=. 65001
MB_ERR_INVALID_CHARS=. 8
enc=. r=. ''
if. 0=#y do. enc;r return. end.
for_fm. encs do.
  y1=. y
  cp=. 0
  if. (0=2|#y1) *. fm e. 'UCS-2';'UCS2';'UTF-16';'UTF16' do. enc=. ,>fm [ r=. 6 u: y1 break.
  elseif. (0=4|#y1) *. fm e. 'UCS-4';'UCS4';'UTF-32';'UTF32' do. enc=. ,>fm [ r=. 6 u: , 2}.("1)_4]\y1 break.
  elseif. (0=2|#y1) *. ((255 254 { a.) -: 2 {. y1) *. fm e. 'UCS-2-BOM';'UCS2-BOM' do. enc=. _4}. ,>fm [ r=. 6 u: 2}.y1 break.
  elseif. ((239 187 191 { a.) -: 3 {. y1) *. fm e. 'UTF-8-BOM';'UTF8-BOM' do. cp=. CP_UTF8 [ y1=. 3}.y1
  elseif. fm e. 'UTF-8';'UTF8' do. cp=. CP_UTF8
  elseif. fm e. 'UTF-7';'UTF7' do. cp=. CP_UTF7
  elseif. fm e. 'LATIN1';'ISO-8859-1';'ISO-8859-15' do. cp=. 1252
  elseif. fm e. 'BIG5';'BIG5-HKSCS';'BIG5HKSCS' do. cp=. 950
  elseif. fm e. 'GBK';'GB18030' do. cp=. 936
  elseif. fm e. 'SJIS';'SJIS-WIN' do. cp=. 932
  elseif. 'CP'-:2{.>fm do. cp=. 0&". 2}.>fm
  end.
  if. 0~:cp do.
    if. (0=#y1) *. '-BOM'-: _4{. ,>fm do.
      enc=. _4}. ,>fm [ r=. '' break.
    end.
    if. 0<z=. 'kernel32 MultiByteToWideChar > i i i *c i *w i'&cd cp ; MB_ERR_INVALID_CHARS ; y1 ;(#y1) ; (<0) ; 0 do.
      r=. (0{::rc) {. _2{:: rc=. 'kernel32 MultiByteToWideChar i i i *c i *w i'&cd cp ; 0 ; y1 ; (#y1) ; ((1+z)#u:0) ; 1+z
      if. '-BOM'-: _4{. ,>fm do.
        enc=. _4}. ,>fm
      else.
        enc=. ,>fm
      end.
      break.
    end.
  end.
end.
if. ''-:enc do. enc;_1 return. end.
cp=. 0 [ z=. _1
if. (<to) e. 'UCS-2';'UCS2';'UTF-16';'UTF16' do. z=. 1 (3!:4) 3 u: r
elseif. (<to) e. 'UCS-4';'UCS4';'UTF-32';'UTF32' do. z=. 2 (3!:4) 3 u: r
elseif. (<to) e. 'UTF-8';'UTF8' do. cp=. CP_UTF8
elseif. (<to) e. 'UTF-7';'UTF7' do. cp=. CP_UTF7
elseif. (<to) e. 'LATIN1';'ISO-8859-1';'ISO-8859-15' do. cp=. 1252
elseif. (<to) e. 'BIG5';'BIG5-HKSCS';'BIG5HKSCS' do. cp=. 950
elseif. (<to) e. 'GBK';'GB18030' do. cp=. 936
elseif. (<to) e. 'SJIS';'SJIS-WIN' do. cp=. 932
elseif. 'CP'-:2{.to do. cp=. 0&". 2}.>to
end.
if. (_1-:z) *. 0~:cp do.
  if. 0<z=. 'kernel32 WideCharToMultiByte > i i i *w i *c i i i'&cd cp ; 0 ; r ; (#r) ; (<0) ; 0 ; 0 ; 0 do.
    z=. (0{::rc) {. _4{:: rc=. 'kernel32 WideCharToMultiByte i i i *w i *c i i i'&cd cp ; 0 ; r ; (#r) ; ((1+z)#{.a.) ; (1+z) ; 0 ; 0
  end.
end.
enc;z
)

NB. =========================================================
jiconv_lnx=: 4 : 0
'encs to'=. x [ y=. ,y
if. 0=#encs=. toupper deb encs do. encs=. 'UTF-8-BOM UCS-2-BOM UTF-8 GBK BIG5 LATIN1' end.
if. 0=#to=. toupper to do. to=. 'UTF-8' end.

encs=. <;._1 ' ', toupper deb encs
enc=. r=. ''
if. 0=#y do. enc;r return. end.

NB. iconv return _1 if failed
NB. android logic added by md
lib=. 'libc.so'"_^:IFANDROID 'libc.so.6'
libiconv=. ('Darwin'-:UNAME){::lib;'libc.dylib'

iconv_open=. (libiconv, ' iconv_open > x *c *c')&cd        NB. tocode fromcode
iconv_iconv=. (libiconv, ' iconv x x *x *x *x *x')&cd      NB. des **inbuf *inbytesleft **outbuf *outbytesleft
iconv_close=. (libiconv, ' iconv_close > i x')&cd          NB. des

ct=. (n3=. 4*#y)#{.a.
ple=. 15!:6 <'ct'             NB. pointer to local entry
pa=. memr ple,(IF64{4 8),1 4  NB. ptr to array
ict=. ''$pa+memr pa,0 1 4     NB. plus offset to data
for_fm. encs do.
  y1=. y
  enc=. ,>fm
  if. (0=2|#y1) *. ((255 254 { a.) -: 2 {. y1) *. fm e. 'UCS-2-BOM';'UCS2-BOM' do. enc=. _4}.enc [ y1=. 2}.y1
  elseif. ((239 187 191 { a.) -: 3 {. y1) *. fm e. 'UTF-8-BOM';'UTF8-BOM' do. enc=. _4}.enc [ y1=. 3}.y1
  end.
  ple=. 15!:6 <'y1'             NB. pointer to local entry
  pa=. memr ple,(IF64{4 8),1 4  NB. ptr to array
  iy1=. ''$pa+memr pa,0 1 4     NB. plus offset to data
  if. _1~: uconv=. iconv_open to;enc do.
    if. _1~: 0{:: urc=. iconv_iconv uconv;(,iy1);(,#y1);(,ict);(,n3) do.
      enc; (n3-{._1{::urc){.ct [ iconv_close <uconv return.
    end.
    iconv_close <uconv
  end.
end.
'';_1
)

NB. =========================================================
jiconv=: jiconv_win`jiconv_lnx@.IFUNIX
