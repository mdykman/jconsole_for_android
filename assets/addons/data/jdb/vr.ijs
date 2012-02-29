NB. vr - based on lab vehicle registration database
NB.
NB. main definitions:
NB.
NB.   buildvr size;foldername   - build database
NB.   demovr foldername    - demo database
NB.
NB. example:
NB.
NB.   buildvr 1000; jpath'~temp'
NB.   demovr openvr jpath'~temp'

require 'data/jdb'

NB. utilities
toss=: ? @ (# #) { ]              NB. toss x dice with faces y
wordlines=: [: ;: [: ; ,&' ';._2  NB. multiline wf
showx=: smoutput@". [ smoutput@('   '&,)  NB. show and execute
NB. =========================================================
NB. Tables
NB.        makes(makename;)
NB.        |    colors(color;)                     comments(comment;)
NB.        |    |                                  |
NB. vr(lic,make,color,year,fine,firstname,lastname,comment)

NB. table: makes(makename)
MCols=: 0 : 0
  makename varchar;
)

MAKES=: wordlines (0 : 0)
  Ford Dodge Buick Pontiac Hudson Rambler Toyota Honda Accura VW Mercedes
)

NB. table: colors(color)
CCols=: 0 : 0
  color varchar;
)

COLORS=: ;:'Red Green Blue Grey Pink Yellow Mauve Maroon'

NB. table: comments(comment)
TCols=: 0 : 0
  comment varchar;
)

TDATA=: ''; ;:'Due Unpaid Outstanding'

NB. table: vr(lic,make,color,year,fine,firstname,lastname,comment)
VCols=: 0 : 0
  lic int
  make makes
  color colors
  year int
  fine float
  firstname char
  lastname char
  comment comments
)

FIRSTNAME=: wordlines 0 : 0
  Alex Amit Anne Boris Boyd Bruce Carlos Clare Dale Darryn Dianne Graham
  Harlan Harry Helen Jason Jody Johnny Julien Klaus Lewis Linda Lynne Marc
  Margot Milane Munroe Noel Owen Pam Rose Ross Shawn Skip Tom Toshio Troy
  Vin Vince
)

LASTNAME=: wordlines 0 : 0
  Abbott Adams Algar Anctil Andrews Beale Boudreau Brady Briscoe Budd
  Cahill Davis Dilworth Donohoe Downs Fobear Foster Gerow Glancey Gordon
  Green Hill Johnson Keegan Keller Kelly Kerik McBride McKee Miller Mills
  Newton Patrick Patten Power Rogerson Stearn Sullivan Tang Taylor
  Thompson
)

NB. generate y random vr records
VData=: 3 : 0
  lic=. 1e6+?~y
  make=. y toss MAKES
  color=. y toss COLORS
  year=. 1900 + ?y$99
  fine=. (+ 10*0<]) 0.01 * (?y$5000) * (?100)=100|i.y
  firstname=. > y toss FIRSTNAME
  lastname=. > y toss LASTNAME
  comment=. TDATA {~ (0 < fine) * ? y $ #TDATA
  lic;make;color;year;fine;firstname;lastname;<comment
)
NB. =========================================================
NB. create vr database
buildvr=: 3 : 0
  'len path'=. y
  f=. Open_jdb_ path
  Drop__f 'vr'
  d=. Create__f 'vr'
  Create__d 'makes';MCols;,<<MAKES
  Create__d 'colors';CCols;,<<COLORS
  Create__d 'comments';TCols;<<TDATA
  t=. Create__d 'vr';VCols
  blk=. 100000
  cnt=. 0
  while. len > 0 do.
    cnt=. cnt + len <. blk
    Insert__t VData len <. blk
    len=. len - blk
  end.
  d
)

NB. =========================================================
NB. match mapped files database lab
labvr=: (showx;._2) bind (0 : 0)
  require 'dir'
  dv=: GetTable__db 'vr'
  dir Tpath__dv
  Reads__dv i.5
  Readr__dv 'make=Ford and year>1997 and fine>3500'
)

NB. =========================================================
openvr=: 3 : 0
  f=. Open_jdb_ y
  d=: Open__f 'vr'
)

demovr=: (showx;._2) bind (0 : 0)
  Reads__d 'from makes'
  Reads__d 'from colors'
  Reads__d 'from comments'
  Reads__d 'from vr where make=Dodge and year<1990 and fine>0'
)
NB. run

NB. =========================================================
NB. run 1000;jpath'~temp'
run=: 3 : 0
  'size path'=. y
  buildvr size;path
  demovr openvr path
  if. size<1e4 do.
    showx 'Reads__d ''from vr where make=Ford and year>1990'''
  end.
  destroy__d''
)
