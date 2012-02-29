NB. =========================================================
NB. tables/dsv
NB. Read/write delimiter-separated value strings and files
NB. Supports user-specified delimiters (General case of CSV).

require 'files strings'
coclass 'pdsv'
NB. =========================================================
NB. utils for dsv

ischar=: ] e. 2 131072"_     NB. is datatype a character

isreal=: ] e. 1 4 8 64 128"_ NB. is datatype numeric real

NB. ---------------------------------------------------------
NB.*enclose v Encloses string in quotes
NB. form: [sd0[,sd1]] enclose strng(s)
NB. returns: quoted string
NB.      Internal quotes are doubled if present.
NB. y is: string or boxed strings to enclose with quotes
NB. x is: optional quote type. Default is '""'
NB.       0{ is (start) string delimiter (sd0)
NB.       1{ is end string delimiter (sd1)
enclose=: 3 : 0
  '""' enclose y
  :
  if. 0<L. y do. x&enclose &.> y return. end.
  if. -.(#x)e. 0 2 do. x=. 2$x end.
  (}:x),((>: (y e. x) *. =/x)#y),}.x
)

NB. ---------------------------------------------------------
NB.*enclosestrings v Array cells to strings with literal quoted
NB. form: [sd0[,sd1]] enclosestrings strng(s)
NB. returns: array of boxed strings with literals quoted
NB.         Only contents of literal boxes in y are quoted.
NB.         Internal quotes are doubled if present.
NB.         Numeric boxes are converted to strings
NB. y is: boxed array of mixed type
NB. x is: optional quote chars. Default is '""'
NB.       0{ is (start) string delimiter (sd0)
NB.       1{ is end string delimiter (sd1)
enclosestrings=: 3 : 0
  '""' enclosestrings y
  :
  if. 1=#sd=. x do. sd=. 2#sd end.
  dat=. ,y
  t=. #. ((0<#@$) , (isreal,.ischar)@:(3!:0)) &> dat        NB. cell data type
  dat=. ((#idx)$sd enclose idx{dat)(idx=. I. t e. 1 5)}dat  NB. quote char cells
  dat=. (8!:0 idx{dat) (idx=. I. 2=t)}dat                   NB. format numeric cells
  dat=. (":@:,@:> &.> idx{dat)(idx=. I. t e. 0 4 6)}dat     NB. handle complex, boxed, numeric rank>0
  ($y)$dat
)

NB. ---------------------------------------------------------
NB.*makenum v Converts cells in array of boxed literals to numeric where possible
NB. form: [err] makenum array
NB. returns: numeric array or array of boxed literals and numbers
NB. y is: an array of boxed literals
NB. x is: optional numeric error code. Default is _9999
makenum=: 3 : 0
  _9999 makenum y
  :
  dat=. , x&". &.> y=. boxopen y
  idx=. I. x&e.@> dat
  if. #idx do.
    dat=. (idx{,y) idx}dat  NB. amend non-numeric cells
  else.
    dat=. >dat              NB. unbox to list if all numeric
  end.
  ($y)$dat
)

NB. ---------------------------------------------------------
NB.*makenumcol v Converts columns in table of boxed literals to numeric where possible
NB. form: [err] makenumcol array
NB. returns: numeric array or array of boxed literal and numeric columns
NB. y is: an array of boxed literals
NB. x is: optional numeric error code. Default is _9999
NB. Only converts column to numeric if conversion is possible for whole column
makenumcol=: 3 : 0
  _9999 makenumcol y
  :
  dat=. x&". &.> y=. boxopen y
  notnum=. x&e.@> dat               NB. mask of boxes containing error code
  idx=. I. +./notnum                NB. index of non-numeric columns
  if. #idx do.
    dat=. (idx{"1 y) (<a:;idx)}dat  NB. amend non-numeric columns
  else.
    dat=. >dat                      NB. unbox to list if all numeric
  end.
)
NB. =========================================================
NB. Convert from delimited strings to arrays of boxes

NB. ---------------------------------------------------------
NB.*fixdsv v Chop multiline delimited string to array of boxed strings
NB. returns: array of boxed literals
NB. form: [fd[;sd0[,sd1]]] fixdsv dat
NB. eg: ('|';'<>') fixdsv '<hello world>|4|84.3',LF,'<Big dig>|<hello world>|4',LF
NB. y is: multiline delimited string, lines delimited by LF
NB. x is: a literal or 1 or 2-item boxed list of optional delimiters.
NB.       0{:: single literal field delimiter (fd). Defaults to TAB
NB.   (1;0){:: (start) string delimiter (sd0). Defaults to '"'
NB.   (1;1){:: end string delimiter (sd1). Defaults to '"'
fixdsv=: 3 : 0
  (TAB;'""') fixdsv y
  :
  dat=. y
  'fd sd'=. 2{. boxopen x
  if. =/sd do. sd=. (-<:#sd)}.sd     NB. empty, one or two same
  else.
    s=. {.('|'=fd){ '|`'             NB. choose single sd
    dat=. dat rplc ({.sd);s;({:sd);s
    sd=. s
  end.
  b=. dat e. LF
  c=. ~:/\ dat e. sd
  msk=. b > c
  > msk <@(x&chopstring) ;._2 y
)

NB. ---------------------------------------------------------
NB.*readdsv v Reads delimiter-separated value file into a boxed array
NB. form: [fd[;sd0[,sd1]]] readdsv file
NB. returns: array of boxed literals
NB. y is: filename of file to read from
NB. x is: a literal or 1- or 2-item boxed list of optional delimiters.
NB.       0{:: single literal field delimiter (fd). Defaults to TAB
NB.   (1;0){:: (start) string delimiter (sd0). Defaults to '"'
NB.   (1;1){:: end string delimiter (sd1). Defaults to '"'
NB. eg: ('|';'<>') readdsv jpath '~temp/test.csv'
readdsv=: 3 : 0
  (TAB;'""') readdsv y
  :
  x=. 2{. boxopen x
  dat=. freads y
  if. dat -: _1 do. return. end.
  x fixdsv dat
)
NB. =========================================================
NB. Convert from arrays of boxes to delimited strings

NB. ---------------------------------------------------------
NB.*joindsv v Unbox and delimit a list of boxed items y with x
NB. form: Delimiter joindsv BoxedList
NB. eg: '","' joindsv 'item1';'item2'
NB. eg: LF joindsv 'item1';'item2'
NB. eg: 99 joindsv <"0 i.8
NB. based on forum post
NB. http://www.jsoftware.com/pipermail/programming/2007-June/007077.html
joindsv=: ' '&$: : (4 : '(;@(#^:_1!.(<x))~  1 0$~0 >. _1 2 p.#) y')

NB. ---------------------------------------------------------
NB.*delimitarray v Delimits and quotes an array of boxed of mixed type items
NB. makedsv performs better for large arrays
NB. returns: delimited, quoted string
NB.       Only arrays with rank>1 have trailing LF
NB.       Rows of arrays with rank>1 are delimited by LF
NB.       Fields within rows delimited by fd
NB.       Only contents of literal boxes in y are quoted.
NB.       Internal quotes are doubled if present.
NB. form: [fd[;sd0[,sd1]]] delimitarray arrayofboxes
NB. y is: boxed array of mixed type
NB. x is: literal list or 1 or 2-item boxed list of optional delimiters.
NB.       0{:: single literal field delimiter (fd). Defaults to 'TAB'
NB.   (1;0){:: (start) string delimiter (sd0). Defaults to '"'
NB.   (1;1){:: end string delimiter (sd1). Defaults to '""
delimitarray=: 3 : 0
  (TAB;'""') delimitarray y
  :
  'fd sd'=. 2{. boxopen x
  if. (#sd) +. -. *./ ,ischar 3!:0 &>y do. NB. if sd not empty or y not all boxed strings
    y=. sd enclosestrings y                NB. quote strings & non-strings to string
  end.
  dat=. LF joindsv ,<@(fd&joindsv)"1 y
  dat, (1<#$y)#LF                          NB. append LF for arrays rank >1
)

--------------------------------------------------
NB.*appenddsv v Appends an array to a delimiter-separated value file
NB. returns: number of bytes appended or _1 if unsuccessful
NB. form: dat appenddsv file[;fd[;sd0[,sd1]]]
NB. eg: (3 2$'hello world';4;84.3;'Big dig') appenddsv (jpath '~temp/test.csv');'|';'<>'
NB. y is: literal list or a 2 or 3-item list of boxed literals
NB.       0{ filename of file to append dat to
NB.       1{ optional field delimiter. Default is TAB
NB.       2{ optional string delimiters, sd0 & sd1. Defaults are '""'
NB. x is: a J array
appenddsv=: 4 : 0
 args=. boxopen y
  'fln fd sd'=. args,(#args)}.'';TAB;'""'
  dat=. (fd;sd) makedsv x
  dat fappends fln
)

NB. ---------------------------------------------------------
NB.*makedsv v Makes a delimiter-separated value string from an array
NB. returns: DSV string
NB.          Results of all arrays except empty have trailing LF
NB. form: [fd[;sd0[,sd1]]] makedsv array
NB. eg: ('|';'<>') makedsv  3 2$'hello world';4;84.3;'Big dig'
NB. y is: an array
NB. x is: literal(s), or 1 or 2-item boxed list of optional delimiters.
NB.       0{:: literal field delimiter(s) (fd). Defaults to TAB
NB.   (1;0){:: (start) string delimiter (sd0). Defaults to '"'
NB.   (1;1){:: end string delimiter (sd1). Defaults to '"'
NB. Arrays are flattened to a max rank of 2.
makedsv=: 3 : 0
  (TAB;'""') makedsv y
  :
  dat=. y=. ,/^:(0>. _2+ [:#$) y   NB. flatten to max rank 2
  dat=. y=. ,:^:(2<. 2- [:#$) y    NB. raise to min rank 2
  'fd sd'=. 2{. boxopen x
  if. 1=#sd do. sd=. 2#sd end.
  NB. delim=. ',';',"';'",';'","';'';'"';'"'
  delim=. fd ; (fd,}:sd) ; ((}.sd),fd) ; ((}.sd),fd,}:sd) ; '' ; (}:sd) ; }.sd
  
  NB. choose best method for column datatypes
  try. type=. ischar 3!:0@:>"1 |: dat
    if. ({.!.a: sd) e. ;(<a:;I. type){dat do. assert.0 end. NB. sd in field
    if. -. +./ type do.          NB. all columns numeric
      dat=. 8!:0 dat
      delim=. 0{ delim
    else.                        NB. columns either numeric or literal
      idx=. I. -. type
      if. #idx do.               NB. format numeric cols
        dat=. (8!:0 tmp{dat) (tmp=. <a:;idx)}dat
      elseif. 0=L.dat do.        NB. y is literal array
        dat=. ,each 8!:2 each dat
      end.
      dlmidx=. 2#.\ type         NB. type of each column pair
      dlmidx=. _1|.dlmidx, 4&+@(2 1&*) ({:,{.) type
      delim=. (#dat)# ,: dlmidx { delim
    end.
  catch.                         NB. handle mixed-type columns
    dat=. sd enclosestrings dat
    delim=. 0{ delim
  end.
  NB. make an expansion vector to open space between cols
  d=. 0= 4!:0 <'dlmidx'           NB. are there char cols that need quoting
  c=. 0>. (+:d)+ <:+: {:$dat      NB. total num columns incl delims
  b=. c $d=0 1                    NB. insert empty odd cols if d, else even
  dat=. b #^:_1"1 dat             NB. expand dat
  if. #idx=. I.-.b do.
    dat=. delim (<a:;idx)}dat     NB. amend with delims
  end.
  ;,dat,.(1=#$dat){LF;a:          NB. add EOL if dat not empty & vectorise
)

NB. ---------------------------------------------------------
NB.*writedsv v Writes an array to a delimiter-separated value file
NB. returns: number of bytes written (_1 if write error)
NB.          An existing file will be written over.
NB. form: dat writedsv file[;fd[;sd0[,sd1]]]
NB. eg: (i.2 3 4) writedsv (jpath ~temp/test);'|';'{}'
NB. y is: literal list or a 2 or 3-item list of boxed literals
NB.       0{ filename of file to append dat to
NB.       1{ optional field delimiter. Default is TAB
NB.       2{ optional string delimiters, sd0 & sd1. Defaults are '""'
NB. x is: an array
writedsv=: 4 : 0
  args=. boxopen y
  'fln fd sd'=. args,(#args)}.'';TAB;'""'
  dat=. (fd;sd) makedsv x
  dat fwrites fln
)
NB. =========================================================
NB. Verbs exported to z locale

joindsv_z_=: joindsv_pdsv_
delimitarray_z_=: delimitarray_pdsv_
appenddsv_z_=: appenddsv_pdsv_
fixdsv_z_=: fixdsv_pdsv_
makedsv_z_=: makedsv_pdsv_
makenum_z_=: makenum_pdsv_
makenumcol_z_=: makenumcol_pdsv_
readdsv_z_=: readdsv_pdsv_
writedsv_z_=: writedsv_pdsv_
