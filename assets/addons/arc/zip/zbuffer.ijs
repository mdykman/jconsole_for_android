NB. zbuffer - in-memory buffer compression
NB.
NB. Copyright 2008 (C) Oleg Kobchenko
NB. Provided AS IS. No warrantiles or liabilities extended.
NB. For zlib and minizip see README files
NB. 
NB. See http://www.zlib.net/manual.html
NB.
NB. 10/10/08 Created
NB. 06/07/10 j701 support

3 :0''        NB. hack to maintain j602 support
  if. 7 > 0". 1{ 9!:14'' do. IFWIN_z_=: IFWIN32 end.
)

require 'dll files'

coclass 'zbuffer'

load 'convert/misc/ascii85'    NB. define in _zbuffer_

ADDONDIR=: jpath '~addons/arc/zip/'

libp=. #.IFWIN,'Darwin'-:UNAME
libf=. libp{:: 'zlibapi'; 'libzlib'; 'zlibwapi';''
libe=. libp{:: 'so'     ; 'dylib'  ; 'dll'     ;''
LIB=: jpath ADDONDIR,'lib/',libf,'.',libe

cdecl=: ' ' ,~ IFWIN{'  '
xcdm=: 1 : '(''"'',LIB,''" '',cdecl,m)&(15!:0)'

compress2=:    'compress2    > i  *c *i *c i i ' xcdm
uncompress=:   'uncompress   > i  *c *i *c i   ' xcdm

NB. =========================================================
NB.*zput v compress byte list
NB.   y: input  x: compression 0-none,1-9 ranging speed-size
NB. returns string or int error if failed
zput=: 3 : 0
  9 zput y
:
  r=. (12+>.1.2*#y)$' '
  if.e=.compress2 r;(n=.,#r);y;(#y);x do.e return.end.
  n{.r
)

NB. =========================================================
NB.*zget v uncompress byte list
NB.   y: input  x: uncompressed size (required)
NB. returns string or int error if failed
zget=: 4 : 0
  r=. x$' '
  if.e=.uncompress r;(n=.,x);y;(#y) do.e return.end.
  r
)

zput_z_=: zput_zbuffer_
zget_z_=: zget_zbuffer_

zput85_z_=: toascii85_zbuffer_@zput_zbuffer_
zget85_z_=: zget_zbuffer_ fromascii85_zbuffer_

NB. =========================================================
Note 'test'
  zput85 200$a.
  (-: # zget85 zput85) 10000$a.
  (-: # zget   zput  ) 10000$a.
)
