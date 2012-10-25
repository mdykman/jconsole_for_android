NB. big file utilities
NB.
NB. Use Windows API for common file access verbs.
NB. These handle files (and drives) with sizes greater than 2^31 bytes.
NB.
NB. They represent 64 bit integers as 2 element integer vectors.
NB.
NB. Indexed read and write have an optional flag indicating the use of the index.
NB. If the flag is non-negative, the index is from the start of the file.
NB. If the flag is negative, the index is from the end of the file.
NB.
NB. f can be either a text file name or a file handle (from bopen).
NB.
NB.     bytes written=.data bappend f                           append to end
NB.     data=.bixread f;start0,start1[,len[,dirflag]]           indexed read
NB.     bytes written=.data bixwrite f;start0,start1[,dirflag]  indexed write
NB.     free space=.bdiskfreespaceex dir                        get disk free space
NB.     free space=.bdiskfreespace drive root                   get disk free space (device units)
NB.     size=.bfsize f                                          get file size
NB.     fh=.[mode] bopen filename                               open file input or inout
NB.     success=.bclose fh                                      close open file
NB.     sys_drives=.getdrives ''                                return vector of windows drive letters
NB.     sys_drive_free_space=.getdrivespace ''                  return matrix of drive letters
NB.     are_same=.f1 bfcomp f2                                  compare 2 files
NB.
NB. Contributed by David Mitchell in J Forum posting April 2003.

require 'dll'

coclass 'jbf'

jsystemdefs 'hostdefs'

coinsert 'jdefs'

NB. jbf api

NULLPTR=: <0
NULL=: <<0
K32=: 2^32
K31=: 2^31

CREATE_ALWAYS=: 2
CREATE_NEW=: 1
FALSE=: 0
FILE_BEGIN=: 0
FILE_END=: 2
GENERIC_READ=: _2147483648
GENERIC_WRITE=: 1073741824
OPEN_ALWAYS=: 4
OPEN_EXISTING=: 3
TRUNCATE_EXISTING=: 5

CloseHandleR=: >@{.@('kernel32 CloseHandle i i'&(15!:0))
CreateFileR=: >@{.@('kernel32 CreateFileW i *w i i * i i i'&(15!:0))
GetFileSizeR=: >@{.@('kernel32 GetFileSize i i *i'&(15!:0))
SetEndOfFile=: >@{.@('kernel32 SetEndOfFile i i'&(15!:0))
SetFilePointerR=: >@{.@('kernel32 SetFilePointer i i i *i i'&(15!:0))
WriteFile=: 'kernel32 WriteFile i i * i *i *'&(15!:0)
ReadFile=: 'kernel32 ReadFile i i * i *i *'&(15!:0)
GetDiskFreeSpaceEx=: >@{.@('kernel32 GetDiskFreeSpaceExW i *w * * *'&(15!:0))
GetDiskFreeSpace=: >@{.@('kernel32 GetDiskFreeSpaceW i *w *i *i *i *i'&(15!:0))
GetLogicalDrives=: >@{.@('kernel32 GetLogicalDrives i'&(15!:0))

4!:55 <'t'
t=: 2&=&(3!:0)

NB. =========================================================
NB.*bappend v append to end
NB. form: data bappend f
bappend=: 4 : 0
x=. ,x
'character data only!' assert t x
if. t y do.
  try. fh=. CreateFileR (uucp y,{.a.);(GENERIC_WRITE+GENERIC_READ);0;NULLPTR;OPEN_EXISTING;0;0 catch.
    (13!:11 '');(13!:12 '')
    return.
  end.
  if. fh=_1 do.
    cderx''
    return.
  end.
  F=. 1
else.
  fh=. y
  F=. 0
end.
p0=. ,2-2
try. r=. SetFilePointerR fh;0;p0;FILE_END catch.
  r=. (13!:11 '');(13!:12 '')
  if. F do. CloseHandleR fh end.
  r
  return.
end.
bw=. ,2
try. r=. WriteFile fh;x;(#x);bw;NULL catch.
  r=. (13!:11 '');(13!:12 '')
  if. F do. CloseHandleR fh end.
  r
  return.
end.
if. ({.r)=0 do.
  r=. cderx''
  if. F do. CloseHandleR fh end.
  r
  return.
end.
if. F do. CloseHandleR fh end.
bw
)

NB. =========================================================
NB.*bixread v indexed read
NB. form: bixread f;start0,start1[,len[,dirflag]]
bixread=: 3 : 0
'fn st'=. y
'invalid index' assert (#st)e. 2 3 4
st=. 4{.st
if. t fn do.
  try. fh=. CreateFileR (uucp fn,{.a.);GENERIC_READ;0;NULLPTR;OPEN_EXISTING;0;0 catch.
    (13!:11 '');(13!:12 '')
    return.
  end.
  if. fh=_1 do.
    cderx''
    return.
  end.
  F=. 1
else.
  fh=. fn
  F=. 0
end.
if. (0>3{st) do.
  b=. ,2
  ts=. GetFileSizeR fh;b
  b=. K32#.|:K32&|b,ts
  ts=. K32#.|:K32&|2{.st
  q=. (2$K32)#:b-ts
  q=. <.((q>K31)*-K32)+q
  st=. q 0 1}st
end.
if. (0=2{st) do.
  b=. ,2
  ts=. GetFileSizeR fh;b
  b=. K32#.|:K32&|b,ts
  ts=. K32#.|:K32&|2{.st
  st=. (<.b-ts) 2 }st
end.
p0=. ,{.st
try. r=. SetFilePointerR fh;(1{st);p0;FILE_BEGIN catch.
  r=. (13!:11 '');(13!:12 '')
  if. F do. CloseHandleR fh end.
  r
  return.
end.
br=. ,2
try. r=. ReadFile fh;((2{st)#' ');(2{st);br;NULL catch.
  r=. (13!:11 '');(13!:12 '')
  if. F do. CloseHandleR fh end.
  r
  return.
end.
if. ({.r)=0 do.
  r=. cderx''
  if. F do. CloseHandleR fh end.
  r
  return.
end.
if. F do. CloseHandleR fh end.
br{.>2{r
)

NB. =========================================================
NB.*bixwrite v indexed write
NB. form: data bixwrite f;start0,start1[,dirflag]
NB. returns bytes written
bixwrite=: 4 : 0
x=. ,x
'fn st'=. y
'invalid index' assert (#st)e. 2 3
'character data only!' assert t x
st=. 3{.st
if. t fn do.
  try. fh=. CreateFileR (uucp fn,{.a.);(GENERIC_READ+GENERIC_WRITE);0;NULLPTR;OPEN_EXISTING;0;0 catch.
    (13!:11 '');(13!:12 '')
    return.
  end.
  if. fh=_1 do.
    cderx''
    return.
  end.
  F=. 1
else.
  fh=. fn
  F=. 0
end.
if. (0>2{st) do.
  b=. ,2
  ts=. GetFileSizeR fh;b
  b=. K32#.|:K32&|b,ts
  ts=. K32#.|:K32&|2{.st
  q=. b64to32 b-ts
  st=. q 0 1}st
end.
p0=. ,{.st
try. r=. SetFilePointerR fh;(1{st);p0;FILE_BEGIN catch.
  r=. (13!:11 '');(13!:12 '')
  if. F do. CloseHandleR fh end.
  r
  return.
end.
bw=. ,2
try. r=. WriteFile fh;x;(#x);bw;NULL catch.
  r=. (13!:11 '');(13!:12 '')
  if. F do. CloseHandleR fh end.
  r
  return.
end.
if. ({.r)=0 do.
  r=. cderx''
  if. F do. CloseHandleR fh end.
  r
  return.
end.
if. F do. CloseHandleR fh end.
bw
)

NB. =========================================================
NB.*bdiskfreespaceex v return extended disk free space
NB. form: [flag] bdiskfreespaceex dir
NB. if flag=0 returns 3x2 matrix of integers, representing 3 64 bit values.
NB. if flag=1 returns 3 element vector of floats, representing 64 bit values.
NB. FreeBytesAvailable,TotalNumberOfBytes,TotalNumberOfFreeBytes
NB. See MS SDK for more information.
bdiskfreespaceex=: 3 : 0
0 bdiskfreespaceex y
:
s1=. 2,2
s2=. 2,2
s3=. 2,2
try. r=: GetDiskFreeSpaceEx (uucp y,{.a.);s1;s2;s3 catch.
  (13!:11 '');(13!:12 '')
  return.
end.
if. r=0 do.
  cderx''
  return.
end.
if. x do. K32#.|:K32&||.s1,.s2,.s3 else. |:|.s1,.s2,.s3 end.
)


NB. =========================================================
NB.*bdiskfreespace v return disk free space
NB. form: bdiskfreespace drive root (must be similar to 'c:\')
NB. returns 4 elements: SectorsPerCluster,BytesPerSector,NumberOfFreeClusters,TotalNumberOfClusters
bdiskfreespace=: 3 : 0
s1=. ,2
s2=. ,2
s3=. ,3
s4=. ,2
try. r=: GetDiskFreeSpace (uucp y,{.a.);s1;s2;s3;s4 catch.
  (13!:11 '');(13!:12 '')
  return.
end.
if. r=0 do.
  cderx''
  return.
end.
s1,s2,s3,s4
)

NB. =========================================================
NB.*bfsize v return size of file
NB. form: bfsize f
NB. returns 2 integer vector
bfsize=: 3 : 0
if. t y do.
  try. fh=: CreateFileR (uucp y,{.a.);GENERIC_READ;0;NULLPTR;OPEN_EXISTING;0;0 catch.
    (13!:11 '');(13!:12 '')
    return.
  end.
  if. fh=_1 do.
    cderx''
    return.
  end.
  F=. 1
else.
  fh=. y
  F=. 0
end.
b=. ,2
ts=. GetFileSizeR fh;b
if. F do. CloseHandleR fh end.
NB.  K32#.|:K32&|b,ts
b,ts
)


NB. =========================================================
NB.*bopen v open file read or readwrite
NB. form: [mode] bopen filename
NB. returns file handle
NB. mode is 0 for read, 1 for readwrite, default read
bopen=: 3 : 0
0 bopen y
:
mode=. x{GENERIC_READ,GENERIC_WRITE+GENERIC_READ
try. fh=: CreateFileR (uucp y,{.a.);mode;0;NULLPTR;OPEN_EXISTING;0;0 catch.
  (13!:11 '');(13!:12 '')
  return.
end.
if. fh=_1 do.
  cderx''
  return.
end.
fh
)

NB. =========================================================
NB.*bclose v close open file handle
NB. form: bclose fh
NB. returns 1 if successful, 0 if not
bclose=: 3 : 0
CloseHandleR y
)

NB. =========================================================
NB.*getdrives v get system drive letters
NB. form: getdrives ''
NB. returns drive letter vector if successful, error if not
getdrives=: 3 : 0
x=. GetLogicalDrives''
if. x=0 do.
  cderx''
  return.
end.
|.(_26{.(32$2)#:x)#'zyxwvutsrqponmlkjihgfedcba'
)


NB. =========================================================
NB.*getdrivespace v get system drive letters and free space
NB. form: getdrivespace ''
NB. returns nx2 drive letter, space available if successful, '' if not
getdrivespace=: 3 : 0
x=. getdrives''
if. -.t x do.
  x
  return.
end.
x=. x,"0 1 ':\'
(<"1 x),.<"0 {."1 diskfree"1 x
)


diskfree=: 3 : 0
x=. 1 bdiskfreespaceex y
if. 2=#x do. x=. 0 0 0 end.
x
)

b64to32=: 3 : 0
y=. (2$K32)#:y
<.((y>K31)*-K32)+y
)

NB. =========================================================
NB.*bfcomp v compare 2 big files
NB. form: f1 bfcomp f2
NB. returns 0 if different 1 if same
bfcomp=: 4 : 0
h1=. bopen x
h2=. bopen y
s1=. bfsize h1
s2=. bfsize h2
if. s1~:s2 do.
  bclose h1
  bclose h2
  0
  return.
end.
blk=. 2048000
for_s. i. >.s1%blk do.
  bsize=. <.blk<.s1-(s*blk)
  if. -.(bixread h1;(b64to32(s*blk)),bsize)-:(bixread h2;(b64to32(s*blk)),bsize) do.
    bclose h1
    bclose h2
    0
    return.
  end.
  if. bsize < blk do. break. end.
end.
bclose h1
bclose h2
1
)
