NB. cd replacement for wd'clippaste'
NB.
NB. wd'clippaste 1' -> getcliptext''
NB. wd'clippaste 2' -> getclipfiles''
NB. wd'clipcopy'    -> setcliptext text
NB.
NB. getclip - gets text or file names from clipboard.
NB. setclipfiles - puts one or more file names on clipboard.
NB. 

coclass 'wdclip'
require '~addons/general/misc/format.ijs'

getcliptext_z_=: getcliptext_wdclip_
getclipfiles_z_=: getclipfiles_wdclip_
getclip_z_=: getclip_wdclip_
setcliptext_z_=: setcliptext_wdclip_
setclipfiles_z_=: setclipfiles_wdclip_

OpenClipboard=: >@{.@:('user32 OpenClipboard i x'&cd)
EmptyClipboard=: >@{.@:('user32 EmptyClipboard i'&cd)
SetClipboardData=: >@{.@:('user32 SetClipboardData x i x'&cd)
CloseClipboard=: >@{.@:('user32 CloseClipboard i'&cd)
EnumClipboardFormats=: 0 1&{('user32 EnumClipboardFormats i i'&cd)
CountClipboardFormats=: >@{.@:('user32 CountClipboardFormats i'&cd)
GetClipboardData=: 0 1&{('user32 GetClipboardData x i'&cd)
GetClipboardFormatName=: >@{.@:('user32 GetClipboardFormatNameA i i *c i'&cd)
GetClipboardSequenceNumber=: >@{.@:('user32 GetClipboardSequenceNumber i'&cd)
GlobalLock=: >@{.@:('kernel32 GlobalLock x x'&cd)
GlobalUnlock=: >@{.@:('kernel32 GlobalUnlock i x'&cd)
GlobalAlloc=: >@{.@:('kernel32 GlobalAlloc x i i'&cd)
GlobalFree=: >@{.@:('kernel32 GlobalFree x x'&cd)
GlobalReAlloc=: >@{.@:('kernel32 GlobalReAlloc x x i i'&cd)

CF_HDROP=: 15
CF_TEXT=: 2-1
CF_OEMTEXT=: 7
CF_UNICODETEXT=: 13

GHND=: dfh'0042'
GMEM_MODIFY=: dfh'0080'
GMEM_MOVEABLE=: 2

NULL=: 0{a.
UNULL=: 0 0{a.

ic=:3!:4
memwic=: 4 : 0
x=.2 ic x
x memw y,(#x),2
)

NB. typedef struct _DROPFILES {
NB. 4     DWORD pFiles; (12)
NB. 8     POINT pt;
NB. 4     BOOL fNC;
NB. 4     BOOL fWide; } DROPFILES, *LPDROPFILES; 
NB. 20+len(files)+(#files(NULL))+2(NULL)


NB. =========================================================
NB.*getclipformatname v get registered clip format name from format number
NB. form: getclipformatname n
getclipformatname=: 3 : 0
if. y<#ClipFormats do.
 y{ClipFormats
 return.
end.
buf=.200$' '
c=.GetClipboardFormatName y;buf;200
if. 0=c do.
 'Not a registered Clip Format Name: ',":y
 else.
 c{.buf
end.
)

NB. =========================================================
NB.*setcliptext v set clipboard to text string
NB. form: setcliptext t
setcliptext=: 3 : 0
y=.clipfmt y
drop=.GlobalAlloc  GHND;1+#y
if. 0=drop do. '' return. end.
r=.GlobalLock drop
(y,NULL) memw r,0,(1+#y),2
GlobalUnlock drop
if. 0=OpenClipboard 0 do. 
 GlobalFree drop
 '' 
 return. 
end.
EmptyClipboard'' 
r=.SetClipboardData CF_TEXT;drop 
CloseClipboard ''
if. 0=r do.
 GlobalFree drop
 '' 
 return. 
end.
r
)

NB. =========================================================
NB.*setclipfiles v set clipboard to list of one or more file names, boxed
NB. form: setclipfiles f0[;fn]
setclipfiles=: 3 : 0
NB. 20 fixed header
NB. Unicode bytes for text+UNULL
NB. Unicode NULLS, 2 at end.
NB. Pad to 8 or 16 byte boundary
mk=.IF64{8 16
n=.((mk&-@(mk&|))+])20+(2*+/;(>:@#)&.>y)+4
drop=.GlobalAlloc GHND;n
if. 0=drop do. '' return. end.
r=.GlobalLock drop
20 memwic r,0
0 0 memwic r,4
0 1 memwic r,12
i=.20
for_s. y do.
 s=.(a.{~,|."1]256 256#:3 u: >s),UNULL
 s memw r,i,(#s),2
 i=.i+#s
end.
(2#UNULL) memw r,i,4,2
GlobalUnlock drop
if. 0=OpenClipboard 0 do. 
 GlobalFree drop
 '' 
 return. 
end.
EmptyClipboard''
r=.SetClipboardData CF_HDROP;drop 
CloseClipboard ''
if. 0=r do.
 GlobalFree drop
 '' 
 return. 
end.
r
)

tst=: 3 : 0
setclipfiles'c:\this';'c:\is';'c:\a';'c:\tst'
)

NB. =========================================================
NB.*listclipformatnames v list clipboard formats by name
NB. form: listclipformatnames ''
listclipformatnames=: 3 : 0
getclipformatname"0 listclipformats ''
)

NB. =========================================================
NB.*listclipformats v list clipboard formats
NB. form: listclipformats ''
listclipformats=: 3 : 0
if. 0=OpenClipboard 0 do. 0 return. end.
r=.''
f=.0
while. 1 do.
'f q'=.EnumClipboardFormats f
if. 0=f do. break. end.
r=.r,f
end.
CloseClipboard ''
r
)

NB. =========================================================
NB.*unicopy v make unicode noun from ptr,disp
NB. form: unicopy ptr,disp
unicopy=: 3 : 0
r=.''
while. 1 do.
q=.memr y,2,2
if. q-: UNULL do. 
 y;6 u: r 
 return. 
end.
r=.r,q
y=.y+0 2 
end.
)

NB. =========================================================
NB.*droplist v return boxed list of names from drop list
NB. form: droplist ptr
droplist=: 3 : 0
r=.''
d=.y,256 256#. |.a.i. memr y,0,2,2
while. 1 do.
 'd t'=.unicopy d
 if. 0=#t do. r return. end.
 r=.r,<t
 d=.d+0 2
end.
)

NB. =========================================================
NB.*getclipdropinfo v display drop info
NB. form: getclipdropinfo ''
getclipdropinfo=: 3 : 0
if. 0=OpenClipboard 0 do. 0 return. end.
'm t'=.GetClipboardData CF_HDROP
if. m=0 do.
 CloseClipboard ''
 0
 return.
end.
p=.GlobalLock m
if. p do.
 r=.droplist p
 GlobalUnlock m
end.
CloseClipboard ''
r
)

NB. =========================================================
NB.*getclipfiles v get copied file names as enclosed vector
NB. form: getclipfiles ''
getclipfiles=: 3 : 0
q=.getclipdropinfo ''
if. q=0 do. return. end.
q
)

NB. =========================================================
NB.*getcliptext v display text
NB. form: getcliptext ''
getcliptext=: 3 : 0
CF_TEXT getcliptext y
:
if. 0=OpenClipboard 0 do. 0 return. end.
'm t'=.GetClipboardData x
if. m=0 do.
 CloseClipboard ''
 0
 return.
end.
r=.''
p=.GlobalLock m
if. p do.
 if. x=CF_UNICODETEXT do.
  r=.>1{unicopy p,0
 else.
  r=.memr p,0,_1,2
 end.
 GlobalUnlock m
end.
CloseClipboard ''
r
)

NB. =========================================================
NB.*getclip v get text or files
NB. form: getclip ''
getclip=: 3 : 0
q=.listclipformats''
if. 1 e. q do. getcliptext'' return. end.
if. 15 e. q do. getclipfiles'' return. end.
''
)

ClipFormats=: >}:&.><;.2 ]0 : 0
Null
CF_TEXT
CF_BITMAP
CF_METAFILEPICT
CF_SYLK        
CF_DIF         
CF_TIFF        
CF_OEMTEXT     
CF_DIB         
CF_PALETTE     
CF_PENDATA     
CF_RIFF        
CF_WAVE        
CF_UNICODETEXT 
CF_ENHMETAFILE 
CF_HDROP       
CF_LOCALE      
CF_DIBV5       
)

NB. /*
NB.  * Predefined Clipboard Formats
NB.  */
NB. #define CF_TEXT             1
NB. #define CF_BITMAP           2
NB. #define CF_METAFILEPICT     3
NB. #define CF_SYLK             4
NB. #define CF_DIF              5
NB. #define CF_TIFF             6
NB. #define CF_OEMTEXT          7
NB. #define CF_DIB              8
NB. #define CF_PALETTE          9
NB. #define CF_PENDATA          10
NB. #define CF_RIFF             11
NB. #define CF_WAVE             12
NB. #define CF_UNICODETEXT      13
NB. #define CF_ENHMETAFILE      14
NB. #if(WINVER >= 0x0400)
NB. #define CF_HDROP            15
NB. #define CF_LOCALE           16
NB. #endif /* WINVER >= 0x0400 */
NB. #if(WINVER >= 0x0500)
NB. #define CF_DIBV5            17
NB. #endif /* WINVER >= 0x0500 */
NB.
NB. #if(WINVER >= 0x0500)
NB. #define CF_MAX              18
NB. #elif(WINVER >= 0x0400)
NB. #define CF_MAX              17
NB. #else
NB. #define CF_MAX              15
NB. #endif
NB.
NB. #define CF_OWNERDISPLAY     0x0080
NB. #define CF_DSPTEXT          0x0081
NB. #define CF_DSPBITMAP        0x0082
NB. #define CF_DSPMETAFILEPICT  0x0083
NB. #define CF_DSPENHMETAFILE   0x008E
NB.

NB. DataObject                            
NB. Shell IDList Array                    
NB. DataObjectAttributes                  
NB. DataObjectAttributesRequiringElevation
NB. Shell Object Offsets                  
NB. Preferred DropEffect                  
NB. AsyncFlag                             
NB. CF_HDROP                              
NB. FileName                              
NB. FileNameW                             
NB. Ole Private Data
