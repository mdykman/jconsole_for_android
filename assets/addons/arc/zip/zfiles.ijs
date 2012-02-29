NB. zfiles - zip file utilities
NB.
NB. file argument is a boxed pair:
NB.    (folders always use and end with forward '/')
NB.    'path/internal.file';'path/zip.file'
NB.
NB. results correspond to 'files' package
NB.
NB. ZERR_zfiles_ is the last error code. 
NB.    See values with edit'ZERR_zfiles_'
NB.
NB. Copyright 2006 (C) Oleg Kobchenko
NB. Provided AS IS. No warrantiles or liabilities extended.
NB. For zlib and minizip see README files
NB. 
NB. 03/20/06 Created
NB. 06/12/06 Added zwrite; j601
NB. 06/14/06 libs for Mac OS X and Linux
NB. 11/27/06 Moved to arc folder
NB. 03/26/07 CRC in info; global comments; > DLL call
NB. 05/12/09 64-bit support for Linux
NB. 06/07/10 j701 support

3 :0''      NB.! Temporary hack to maintain j602 support
  if. 7 > 0". 1{ 9!:14'' do. IFWIN_z_=: IFWIN32 end.
)

require 'dll files strings regex'

coclass 'zfiles'

TEMPFILE=: 'graphview'
TEMPDIR=: jpath '~temp'
ADDONDIR=: jpath '~addons/arc/zip/'

libp=. #.IFWIN,'Darwin'-:UNAME
libf=. libp{:: 'zlibapi'; 'libzlib'; 'zlibwapi';''
libe=. libp{:: 'so'     ; 'dylib'  ; 'dll'     ;''
libf=. libf,IF64#'64'
LIB=: jpath ADDONDIR,'lib/',libf,'.',libe

cdecl=: ' ' ,~ IFWIN{'  '
xcdm=: 1 : '(''"'',LIB,''" '',cdecl,m)&(15!:0)'

NB. minizip/unzip.h
unzOpen=:                'unzOpen               > x  *c     ' xcdm
unzClose=:               'unzClose              > i  x      ' xcdm
unzLocateFile=:          'unzLocateFile         > i  x *c i ' xcdm

unzOpenCurrentFile=:     'unzOpenCurrentFile    > i  x      ' xcdm
unzCloseCurrentFile=:    'unzCloseCurrentFile   > i  x      ' xcdm
unzReadCurrentFile=:     'unzReadCurrentFile    > i  x *c i ' xcdm

unzGoToFirstFile=:       'unzGoToFirstFile      > i  x      ' xcdm
unzGoToNextFile=:        'unzGoToNextFile       > i  x      ' xcdm
unzGetCurrentFileInfo=:  'unzGetCurrentFileInfo > i  x *c *c i  x i  x i ' xcdm
unzGetGlobalComment=:    'unzGetGlobalComment   > i  x *c i ' xcdm

NB. minizip/zip.h
zipOpen=:                'zipOpen               > x  *c i   ' xcdm
zipClose=:               'zipClose              > i  x x    ' xcdm
zipClose2=:              'zipClose              > i  x *c   ' xcdm
zipOpenNewFileInZip=:    'zipOpenNewFileInZip   > i  x *c *c  x i x i x  i i' xcdm
zipCloseFileInZip=:      'zipCloseFileInZip     > i  x      ' xcdm
zipWriteInFileInZip=:    'zipWriteInFileInZip   > i  x *c i ' xcdm


NB. Return codes for the compression/decompression functions. Negative
NB. values are errors, positive values are used for special but normal events.
ZERR=: 0
'Z_OK Z_STREAM_END Z_NEED_DICT'=: 0 1 2
'Z_ERRNO Z_STREAM_ERROR Z_DATA_ERROR'=: -1 2 3
'Z_MEM_ERROR Z_BUF_ERROR Z_VERSION_ERROR'=: -4 5 6

NB. compression levels
'Z_NO_COMPRESSION Z_BEST_SPEED Z_BEST_COMPRESSION Z_DEFAULT_COMPRESSION'=: 0 1 9 _1

NB. Return codes for the unzip
'UNZ_OK UNZ_END_OF_LIST_OF_FILE UNZ_ERRNO UNZ_EOF'=: 0 _100 _1 0
'UNZ_PARAMERROR UNZ_BADZIPFILE UNZ_INTERNALERROR UNZ_CRCERROR'=: -102 103 104 105

Z_DEFLATED=: 8   NB. method or 0=no compresion

t=.  'VerMade VerNeed Flag Method DosDate Crc ComSize Size '
t=.t,'cbFileName cbFileEx cbFileCom DiskNum InAttr ExAttr '
FileInfo=: t,'Sec Min Hour Day Mon Year'

and=: 17 b.

NB. =========================================================
NB.*zexist v test if a file exists
NB. Returns 1 if the file exists, otherwise 0.
zexist=: 3 : 0
  'FN ZN'=. y
  ZERR=: Z_ERRNO
  if. 0=Z=. unzOpen ,<ZN do. 0 return. end.
  ZERR=: unzLocateFile Z;FN;0
  unzClose Z
  ZERR=Z_OK
)

NB. =========================================================
NB.*zdir v zip directory: boxed matrix
NB. examples:
NB.   zdir jpath'~addons\zip\test.zip'
NB.   zdir '*.txt';jpath'~addons\zip\test.zip'
zdir=: 3 : 0
  'FN ZN'=. _2{.boxopen y
  if. 0=#FN do. FP=. rxcomp '.*' else.
    FP=. rxcomp FN rplc '?';'.';'*';'.*';'.';'\.' end.
  ZERR=: Z_ERRNO
  if. 0=Z=. unzOpen ,<ZN do. 
    rxfree FP
    empty'' return. end.
  r=. empty''
  ZERR=: unzGoToFirstFile Z
  while. ZERR=Z_OK do.
    if. 0 = #r1=. zgetinfo Z do. break. end.
    if. FP rxeq 0{::r1 do. r=. r,r1 end.
    ZERR=: unzGoToNextFile Z
  end.
  unzClose Z
  rxfree FP
  r
)

NB. =========================================================
NB.*zinfo v single file info
NB. format same as zdir result item
zinfo=: 3 : 0
  'FN ZN'=. y
  ZERR=: Z_ERRNO
  if. 0=Z=. unzOpen ,<ZN do. 0 return. end.
  if. Z_OK~:ZERR=: unzLocateFile Z;FN;0 do.
    unzClose Z
    empty'' return. end.
  r=. zgetinfo Z
  unzCloseCurrentFile Z
  unzClose Z
  r
)

zgetinfo=: 3 : 0
  FI_Longs=. 14*IF64{4 8
  FI=. (FI_Longs+4*6)#'Z'
  FN=. 128#' '
  if. Z_OK~:ZERR=: unzGetCurrentFileInfo y;FI;FN;(#FN);0;0;0;0 do.
    empty'' return. end.
  (FileInfo)=. ((IF64{_2 _3)(3!:4) FI_Longs{.FI) , _2(3!:4)FI_Longs}.FI
  A=. '------'
  A=. ('a-'{~0=ExAttr and 32)5}A
  A=. ('d-'{~0=ExAttr and 16)4}A
  (cbFileName{.FN);(Year,Mon,Day,Hour,Min,Sec);Size;'rw-';A;Crc
)

NB. =========================================================
NB.*zread v read file
NB. returns _1 if failed
zread=: 3 : 0
  'FN ZN'=. y
  ZERR=: Z_ERRNO
  if. 0=Z=. unzOpen ,<ZN do. _1 return. end.
  if. Z_OK~:ZERR=: unzLocateFile Z;FN;0 do.
    unzClose Z
    _1 return. end.
  if. Z_OK~:ZERR=: unzOpenCurrentFile Z do.
    unzClose Z
    _1 return. end.
  r=. ''
  t=. 16384$' '
  while. 1 do.
    ZERR=: unzReadCurrentFile Z;t;#t
    if. ZERR<:0 do. break. end.
    if. ZERR=#t do. r=. r,t else. r=.r, ZERR{.t end.
  end.
  if. ZERR<0 do. r=. _1 end.
  unzCloseCurrentFile Z
  unzClose Z
  r
)

NB. =========================================================
NB.*CL n compress level 0..9
CL=: 9

NB. =========================================================
NB.*zwrite v write file
NB. returns _1 if failed
zwrite=: 4 : 0
  'FN ZN'=. y
  ZERR=: Z_ERRNO
  AP=. 2*fexist <ZN
  if. 0=Z=. zipOpen ZN;AP do. _1 return. end.
  FN=. '/'&(I.@(e.&'/\')@]}) FN
  ZI=. (|.<.6!:0''),0,0,(32+16*'/'={:FN),0       NB. zip_fileinfo
  ZI=. 2 (3!:4) ZI
  if. Z_OK~:ZERR=: zipOpenNewFileInZip Z;FN;ZI;0;0;0;0;0;(Z_DEFLATED**CL);CL do.
    zipClose Z;<0
    _1 return. end.
  ZERR=: zipWriteInFileInZip Z;x;#x
  zipCloseFileInZip Z
  zipClose Z;0
  (ZERR=Z_OK) { _1,#x
)

NB. =========================================================
NB.*zsize v return file size
NB. returns file size or _1 if error
zsize=: 3 : 0
  if. 0=#t=. zinfo y do. _1 return. end.
  2{:: t
)

NB. =========================================================
NB.*ztype v file type
NB. return 0 = not exist
NB.        1 = file
NB.        2 = directory (optionally ending in path separator)
ztype=: 3 : 0
  if. 0=#t=. zinfo y do. 0 return. end.
  1+'/'=_1{0{:: t
)

NB. =========================================================
NB.*zgetcomment v file
NB. returns comment or ''
zgetcomment=: 3 : 0
  ZERR=: Z_ERRNO
  if. 0=Z=. unzOpen ,< y do. _1 return. end.
  c=. 1024#' '
  sz=: unzGetGlobalComment Z;c;#c
  unzClose Z
  if. sz<0 do. return. sz end.
  sz{.c
)

NB. =========================================================
NB.*zsetcomment v file
NB.   comment zsetcomment file
zsetcomment=: 4 : 0
  ZERR=: Z_ERRNO
  AP=. 2*fexist <y
  if. 0=Z=. zipOpen y;AP do. _1 return. end.
  if. Z_OK~:ZERR=: zipClose2 Z;x do. _1 return. end.
  empty''
)

NB. =========================================================
NB.*zscript v load script from zip, cover for 0!:0
zscript_z_=: [: 3 : '0!:0 zread y' ]

zexist_z_=: zexist_zfiles_
zread_z_=: zread_zfiles_
zwrite_z_=: zwrite_zfiles_
zinfo_z_=: zinfo_zfiles_
zdir_z_=: zdir_zfiles_
zsize_z_=: zsize_zfiles_
ztype_z_=: ztype_zfiles_
zgetcomment_z_=: zgetcomment_zfiles_
zsetcomment_z_=: zsetcomment_zfiles_
