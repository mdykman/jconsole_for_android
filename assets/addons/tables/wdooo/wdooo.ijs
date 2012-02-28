'require'~'dll'
symdat_z_=: 3 : 0   
had=. {.memr y,(IF64{4 8),1,JPTR
had+{.memr had,0,1,JINT
)
coclass 'olegpcall'
acall=: 2 : '(''0 '',(":m),'' > '',n)&(15!:0)'
icall=: 2 : '(''1 '',(":m),'' > '',n)&(15!:0)'
idef=: 4 : '((x&,)&.>y)=: i.#y'

coclass 'olegpole32'
coinsert 'olegpcall'

CoInitializeEx=: 'ole32 CoInitializeEx   > i x i'&cd
CLSIDFromProgID=: 'ole32 CLSIDFromProgID  > i *w *c'&cd
CLSIDFromString=: 'ole32 CLSIDFromString  > i *w *c'&cd
CoCreateInstance=: 'ole32 CoCreateInstance > i *c i i *c *x'&cd
CoGetObject=: 'ole32 CoGetObject      > i *w i *c *x'&cd

VariantClear=: 'oleaut32 VariantClear > i *x'&cd
VariantChangeType=: 'oleaut32 VariantChangeType > i *x *x s s'&cd
SysFreeString=: 'oleaut32 SysFreeString > i x'&cd
SysAllocStringLen=: 'oleaut32 SysAllocStringLen > i *w i'&cd
CoGetActiveObject=: 'oleaut32 GetActiveObject     > i *c x *x'&cd

GUID=: 'WWWWXXYYZZZZZZZZ'
GUID_NULL=: (#GUID) # 0{a.
VAR1=: 'VtR1R2R3Valu'
VAR2=: 'VtR1R2R3Val1Val2'
DISPPARAMS=: 'ArgsNamdCArgCNmd'
TYPEATTR=: GUID,'LcidReseCtorDtorScheSinsTpknCfCvCtSvBaTfMjMnAliaIdld'
TYPEDESC=: 'LptdVt00'
PARAMDESC=: 'LppdPf00'
ELEMDESC=: TYPEDESC,PARAMDESC
FUNCDESC=: 'MbidScodParmFunkInvkCalcCpCoOvCs',ELEMDESC,'Ff00'
IID_IUnknown=: '{00000000-0000-0000-C000-000000000046}'
IID_IDispatch=: '{00020400-0000-0000-C000-000000000046}'

'CLSCTX_INPROC_SERVER CLSCTX_LOCAL_SERVER'=: 16b0001 16b0004
CTX=: CLSCTX_INPROC_SERVER+CLSCTX_LOCAL_SERVER

'COINIT_APARTMENTTHREADED COINIT_MULTITHREADED'=: 2 0

'VT_EMPTY VT_NULL VT_I2 VT_I4  VT_R4 VT_R8 VT_CY VT_DATE'=: i.8
'VT_BSTR VT_DISPATCH VT_ERROR VT_BOOL'=: 8+i.4
'VT_VARIANT VT_UNKNOWN VT_DECIMAL'=: 12+i.3
'VT_PTR VT_SAFEARRAY VT_CARRAY VT_USERDEFINED'=: 26+i.4
'VT_VECTOR VT_ARRAY VT_BYREF VT_TYPEMASK'=: 16b1000 16b2000 16b4000 16b0fff

'DISP_METH DISP_GET DISP_PUT DISP_SET'=: 1 2 4 8

'IU_'idef IUnknown=: ;:'QueryInterface AddRef Release'
'ID_'idef IDispatch=: IUnknown,;:;<;._2(0 : 0)
  GetTypeInfoCount GetTypeInfo GetIDsOfNames Invoke
)
'IT_'idef ITypeInfo=: IUnknown,;:;<;._2(0 : 0)
  GetTypeAttr GetTypeComp GetFuncDesc GetVarDesc GetNames
  GetRefTypeOfImplType GetImplTypeFlags GetIDsOfNames Invoke
  GetDocumentation GetDllEntry GetRefTypeInfo AddressOfMember
  CreateInstance GetMops GetContainingTypeLib ReleaseTypeAttr
  ReleaseFuncDesc ReleaseVarDesc
)

iuQueryInterface=: IU_QueryInterface icall 'i x *c *x' @ ;
iuAddRef=: IU_AddRef icall 'i x' @ [
iuRelease=: IU_Release icall 'i x' @ [
idGetIDsOfNames=: ID_GetIDsOfNames icall 'i x *c *x x x *x' @ ;
idGetTypeInfo=: ID_GetTypeInfo icall 'i x x x *x' @ ;
idInvoke=: ID_Invoke icall 'i x x *c x s *x *x x x' @ ;
itGetTypeAttr=: IT_GetTypeAttr icall 'i x *x' @ ;
itReleaseTypeAttr=: IT_ReleaseTypeAttr icall 'i x x' @ ;
itGetFuncDesc=: IT_GetFuncDesc icall 'i x x *x' @ ;
itReleaseFuncDesc=: IT_ReleaseFuncDesc icall 'i x x' @ ;
itGetNames=: IT_GetNames icall 'i x x *x x *x' @ ;
itGetDocumentation=: IT_GetDocumentation icall 'i x x *x *x x x' @ ;
itGetRefTypeInfo=: IT_GetRefTypeInfo icall 'i x x *x' @ ;

hex8=: ,~ '00000000' }.~ #
hfd8=: '0x' , hex8@hfd
herr=: hfd8 assert 0 <: ]

CreateObject=: 3 : 0
IID_IDispatch CreateObject y
:
herr CoCreateInstance (GetGuid y) ; 0 ; CTX ; (GetGuid x) ; p=. ,_2
{.p
)

GetObject=: 3 : 0
IID_IDispatch GetObject y
:
herr CoGetObject y ; 0 ; (GetGuid x) ; p=. ,_2
{.p
)

GetActiveObject=: 3 : 0
IID_IDispatch GetActiveObject y
:
herr CoGetActiveObject (GetGuid y) ; 0 ; p=. ,_2
{.p
)

GetGuid=: 3 : 0
f=. CLSIDFromProgID`CLSIDFromString@.('{'={.y)
herr f y ; guid=. 1#GUID
guid
)

h=: ([: ;:^:_1"1 [: <"1 hfd)@(([: , _4 (_2&(3!:4))@|.\ ])^:(2=3!:0))
si=: I.@E.~   
us=: 0&(3!:4)
mi=: [: {.@memr ,&(0 1,JINT)
mc=: ,&0@] memr@, ,&JCHAR@[
mI=: 4 : '{.memr y,x,1,JINT'
mS=: 4 : '{.us memr y,x,2,JCHAR'
and=: 17 b.

GetStr=: 3 : 0
if. 0=y do. ''return. end.
len=. mi _4+y    
val=. len mc y   
8 u: 6 u: val
)

GetStrSafeFree=: 3 : 0
if. 0=y=. {.y do. '' return. end.
r=. GetStr y
SysFreeString y
r
)

AllocStr=: 3 : 0
SysAllocStringLen y;#y
)
VariantAlloc=: 3 : '(2-2)#~4%~#VAR2'
VariantStr=: GetStr@(2&{)

BoolVar=: 3 : 'VT_BOOL,0,(_1 0{~0-:{.y),0'
IntVar=: 3 : 'VT_I4,0,({.y),0'
PtrVar=: 3 : 'VT_UNKNOWN,0,({.y),0'
FloatVar=: 3 : 'VT_R8,0,_2(3!:4)2(3!:5){.y'
StrVar=: 3 : 'VT_BSTR,0,(AllocStr y),0'
EmptyVar=: 3 : '({.y,VT_EMPTY),0,0,_1'

JVar=: 3 : 0
if. y-:a: do. EmptyVar'' return. end.
if. y-:<0 do. EmptyVar VT_NULL return. end.
if. 0<L.y do. PtrVar >y return. end.
select. 3!:0 y
case. 1;4 do. IntVar y
case. 8 do. FloatVar y
case. do. StrVar ,":,y
end.
)

VarJ=: 3 : 0
select. VT_TYPEMASK and {.y
case. VT_EMPTY do. a:
case. VT_NULL do. <0
case. VT_I2 do. _1(3!:4)1(3!:4) 2{y
case. VT_I4 do. 2{y
case. VT_DISPATCH;VT_UNKNOWN do. <2{y
case. VT_R4 do. _1(3!:5)2(3!:4) 2{y
case. VT_R8 do. _2(3!:4)2(3!:4) 2 3{y
case. VT_BSTR do. VariantStr y
case. VT_BOOL do. 0~:2{y
case. do. VariantStr y [ VariantChangeType y;y;0;VT_BSTR
end.
)
cut=: ' '&$: :([: -.&a: <;._2@,~)

VTSTR=: ; <@cut;._2 (0 : 0)
void null short long float double CURRENCY DATE
BSTR IDispatch* SCODE boolean VARIANT IUnknown* WCHAR .
char BYTE WORD DWORD int64 uint64 int UINT
void HRESULT PTR SAFEARRAY CARRAY USERDEFINED LPSTR LPWSTR
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
FILETIME BLOB STREAM STORAGE STREAMED_OBJECT STORED_OBJECT BLOB_OBJECT
CF CLSID BAD_TYPE
)

VtStr=: 3 : 'VTSTR >@{~ (<:#VTSTR) <. y and 16bfff'

TypeDesc=: 0&$: : (4 : 0)"0
if. 0=y do. 'void' return. end.
select. vt=. 16bfff and 4 mS y
case. VT_PTR do. '*',~x TypeDesc 0 mI y return.
case. VT_USERDEFINED do. x RefDesc 0 mI y return.
case. do. VtStr vt
end.
)

RefDesc=: 4 : 0
herr x itGetRefTypeInfo y ; rt=. ,_2
rt=. {.rt
r=. >@{. rt GetDoc _1
rt iuRelease ''
r
)

FuncDesc=: 4 : 0"0
herr x itGetFuncDesc y ; pfd=. ,_2
mid=. 0 mI pfd
if. c=. (FUNCDESC si 'Cp') mS pfd do.    
  p=. (FUNCDESC si 'Parm') mI pfd        
  r=. x <@TypeDesc p+(#ELEMDESC)*i.c
else. r=. '' end.
r=. r,~<x TypeDesc {.(FUNCDESC si 'Lptd') + pfd  
herr x itReleaseFuncDesc {.pfd

res=. (c+1)#_1
herr x itGetNames mid ; res ; (#res) ; ,_1
res=. 0 (I.res=_1)}res
r (, ' '&,)&.> <@GetStrSafeFree"0 res    
)

GetDoc=: 4 : 0"0
herr x itGetDocumentation y ; (name=. ,_2) ; (doc=. ,_2) ; 0 ; 0
<@GetStrSafeFree"0 name,doc           
)

FuncDoc=: 4 : 0"0
herr x itGetFuncDesc y ; pfd=. ,_2
mid=. 0 mI pfd
herr x itReleaseFuncDesc {.pfd
x GetDoc mid
)

CLSID_StdGlobalInterfaceTable=: '{00000323-0000-0000-C000-000000000046}'
IID_IGlobalInterfaceTable=: '{00000146-0000-0000-C000-000000000046}'

'GIT_'idef IGlobalInterfaceTable=: IUnknown,;:;<;._2(0 : 0)
  RegisterInterfaceInGlobal RevokeInterfaceFromGlobal GetInterfaceFromGlobal
)

gitRegisterInterfaceInGlobal=: GIT_RegisterInterfaceInGlobal icall 'i x x *c *x' @ ;
gitRevokeInterfaceFromGlobal=: GIT_RevokeInterfaceFromGlobal icall 'i x x' @ ;
gitGetInterfaceFromGlobal=: GIT_GetInterfaceFromGlobal icall 'i x x *c *x' @ ;

gitGet=: 3 : 0
IID_IDispatch gitGet y
:
git=. IID_IGlobalInterfaceTable CreateObject CLSID_StdGlobalInterfaceTable
herr CLSIDFromString x ; iid=. 1#GUID
herr git gitGetInterfaceFromGlobal y;iid;p=. ,2-2
git iuRelease ''
{.p
)

CoInitializeEx 0;COINIT_APARTMENTTHREADED
coclass 'olecomerrorh'

DFH=: 3 : 0
if. '0x'-:2{.y=. }:^:('L'={:y) y do.
  d=. 0
  for_nib. ('0123456789abcdef'&i.) tolower 2}.y do.
    d=. nib (23 b.) 4 (33 b.) d
  end.
else.
  d=. 0&". y
end.
if. IF64 *. d > <:2^31 do. d=. <. d - 2^32 end.
)

cheaderconst=: ''&$: : (4 : 0)
if. #x do.
  ({.x)=: {.("1) y
  ({:x)=: DFH&> {:("1) y
end.
,(>{.("1) y),("1) ' =: ',("1) (":@DFH&> {:("1) y) ,("1) LF
)

olecomerrmsg=: 3 : 0
if. y e. OLECOMERRVAL do. ; (,&' ')&.> OLECOMERRCODE #~ OLECOMERRVAL = y else. 'Other error: ', ":y end.
)

(0!:100) ('OLECOMERRCODE' ; 'OLECOMERRVAL') cheaderconst (<;._2)@(,&' ') ;._2 (0 : 0)
S_OK 0
CO_E_ALREADYINITIALIZED 0x800401F1
CO_E_APPDIDNTREG 0x800401FE
CO_E_APPNOTFOUND 0x800401F5
CO_E_APPSINGLEUSE 0x800401F6
CO_E_BAD_PATH 0x80080004
CO_E_CANTDETERMINECLASS 0x800401F2
CO_E_CLASSSTRING 0x800401F3
CO_E_CLASS_CREATE_FAILED 0x80080001
CO_E_DLLNOTFOUND 0x800401F8
CO_E_ERRORINAPP 0x800401F7
CO_E_ERRORINDLL 0x800401F9
CO_E_IIDSTRING 0x800401F4
CO_E_NOTINITIALIZED 0x800401F0
CO_E_OBJISREG 0x800401FC
CO_E_OBJNOTCONNECTED 0x800401FD
CO_E_OBJNOTREG 0x800401FB
CO_E_OBJSRV_RPC_FAILURE 0x80080006
CO_E_RELEASED 0x800401FF
CO_E_SERVER_EXEC_FAILURE 0x80080005
CO_E_SERVER_STOPPING 0x80080008
CO_E_WRONGOSFORAPP 0x800401FA
DISP_E_ARRAYISLOCKED 0x8002000D
DISP_E_BADCALLEE 0x80020010
DISP_E_BADINDEX 0x8002000B
DISP_E_BADPARAMCOUNT 0x8002000E
DISP_E_BADVARTYPE 0x80020008
DISP_E_DIVBYZERO 0x80020012
DISP_E_EXCEPTION 0x80020009
DISP_E_MEMBERNOTFOUND 0x80020003
DISP_E_NONAMEDARGS 0x80020007
DISP_E_NOTACOLLECTION 0x80020011
DISP_E_OVERFLOW 0x8002000A
DISP_E_PARAMNOTFOUND 0x80020004
DISP_E_PARAMNOTOPTIONAL 0x8002000F
DISP_E_TYPEMISMATCH 0x80020005
DISP_E_UNKNOWNINTERFACE 0x80020001
DISP_E_UNKNOWNLCID 0x8002000C
DISP_E_UNKNOWNNAME 0x80020006
E_ABORT 0x80004004
E_ACCESSDENIED 0x80070005
E_FAIL 0x80004005
E_HANDLE 0x80070006
E_INVALIDARG 0x80070057
E_NOINTERFACE 0x80004002
E_NOTIMPL 0x80004001
E_OUTOFMEMORY 0x8007000E
E_PENDING 0x8000000A
E_POINTER 0x80004003
E_UNEXPECTED 0x8000FFFF
TYPE_E_AMBIGUOUSNAME 0x8002802C
TYPE_E_BADMODULEKIND 0x800288BD
TYPE_E_BUFFERTOOSMALL 0x80028016
TYPE_E_CANTCREATETMPFILE 0x80028CA3
TYPE_E_CANTLOADLIBRARY 0x80029C4A
TYPE_E_CIRCULARTYPE 0x80029C84
TYPE_E_DLLFUNCTIONNOTFOUND 0x8002802F
TYPE_E_DUPLICATEID 0x800288C6
TYPE_E_ELEMENTNOTFOUND 0x8002802B
TYPE_E_INCONSISTENTPROPFUNCS 0x80029C83
TYPE_E_INVALIDID 0x800288CF
TYPE_E_INVALIDSTATE 0x80028029
TYPE_E_INVDATAREAD 0x80028018
TYPE_E_IOERROR 0x80028CA2
TYPE_E_LIBNOTREGISTERED 0x8002801D
TYPE_E_NAMECONFLICT 0x8002802D
TYPE_E_OUTOFBOUNDS 0x80028CA1
TYPE_E_QUALIFIEDNAMEDISALLOWED 0x80028028
TYPE_E_REGISTRYACCESS 0x8002801C
TYPE_E_SIZETOOBIG 0x800288C5
TYPE_E_TYPEMISMATCH 0x80028CA0
TYPE_E_UNDEFINEDTYPE 0x80028027
TYPE_E_UNKNOWNLCID 0x8002802E
TYPE_E_UNSUPFORMAT 0x80028019
TYPE_E_WRONGTYPEKIND 0x8002802A
)
coclass 'oleutil'
coinsert 'olecomerrorh'
coinsert 'olegpcall'
coinsert 'olegpole32'

3 : 0''
a=. ;:'VT_EMPTY VT_NULL VT_I2 VT_I4  VT_R4 VT_R8 VT_CY VT_DATE'
a=. a, ;:'VT_BSTR VT_DISPATCH VT_ERROR VT_BOOL'
a=. a, ;:'VT_VARIANT VT_UNKNOWN VT_DECIMAL'
a=. a, ;:'VT_PTR VT_SAFEARRAY VT_CARRAY VT_USERDEFINED'
a=. a, ;:'VT_VECTOR VT_ARRAY VT_BYREF VT_TYPEMASK'
for_ai. a do. ((>ai),'_z_')=: ".>ai end.
i. 0 0
)
VariantInit=: 'oleaut32 VariantInit > n *'&cd
SafeArrayCreate=: 'oleaut32 SafeArrayCreate > x s i *i'&cd
SafeArrayAccessData=: 'oleaut32 SafeArrayAccessData > s x *x'&cd
SafeArrayUnaccessData=: 'oleaut32 SafeArrayUnaccessData > s x'&cd
SafeArrayDestroy=: 'oleaut32 SafeArrayDestroy > s x'&cd
SafeArrayCreateVector=: 'oleaut32 SafeArrayCreateVector > x s i i'&cd
SafeArrayPutElement=: 'oleaut32 SafeArrayPutElement > i x *i *'&cd
S_OK=: 0
SZI=: IF64{4 8

DISPID_PROPERTYPUT=: _3
dispidNamed=: 2&ic DISPID_PROPERTYPUT
pdispidNamed=: symdat@symget < 'dispidNamed'
iid_idisp=: 0 4 2 0 0 0 0 0 192 0 0 0 0 0 0 70{a.  
DISPATCH_METHOD=: 1
DISPATCH_PROPERTYGET=: 2
DISPATCH_PROPERTYPUT=: 4
DISPATCH_PROPERTYPUTREF=: 8

dispid=: 4 : 0
assert. x~:0
y=. uucp y
nm=. ,symdat symget <,'y'
hr=. x idGetIDsOfNames GUID_NULL;nm;1;0;r=. ,_1
hr, r
)

makevariant=: 4 : 0
assert. x =&# y
if. 0=#y do. 0 return. end.
vargs=. mema 16 * #y
((16 * #y)#{.a.) memw vargs, 0, (16 * #y), 2
for_i. i.#y do.
  s=. >i{y [ vt=. >i{x
  if. 32 = 3!:0 s do.
    arr=. vargs + 16 * i
    (memr (>s), 0 16 2) memw arr, 0 16 2
  else.
    VariantInit <<arr=. vargs + 16 * i
    (1 ic vt) memw arr, 0, 2, 2
    select. 16bfff (17 b.) vt
    case. VT_BOOL do.
      ((s=0){_1 0) memw arr, 8, 1, 4
    case. VT_BSTR do.
      bstr=. SysAllocStringLen (];#) uucp ,s
      bstr memw arr, 8, 1, 4
    case. VT_I4 do.
      s memw arr, 8, 1, 4
    case. VT_R8 do.
      s memw arr, 8, 1, 8
    case. VT_UNKNOWN;VT_DISPATCH do.
      if. 0=#s do.
        0 memw arr, 8, 1, 4
      else.
        s memw arr, 8, 1, 4
      end.
    case. VT_EMPTY do.
      0 memw arr, 8, 1, 4
    case. do.
      assert. 0
    end.
  end.
end.
vargs
)

makedispparms=: 4 : 0
dispparams=. mema SZI+SZI+4+4
((IF64{4 3)#0) memw dispparams, 0, (IF64{4 3), 4
(x makevariant&|. y) memw dispparams, 0, 1, 4       
(#y) memw dispparams, (2*SZI), 1, 4                 
dispparams
)

freedispparms=: 4 : 0
msk=. |.x
if. IF64 do.
  'a b c1'=. memr y, 0, 3, 4
  c=. c1 (17 b.) 16bffffffff
else.
  'a b c d'=. memr y, 0, 4, 4
end.
if. a do.
  assert. c = #msk
  if. 1 e. msk do.
    VariantClear@<@<"0 a+msk#16*i.-c     
  end.
  memf a
end.
memf y
)
olevaralloc=: 3 : 0
f=. mema 16
(16#{.a.) memw f, 0 16 2
VariantInit <<f
f
)
olevarfree=: 3 : 0
if. y do.
  memf y [ VariantClear <<y
end.
)
coclass 'oleooo'
coinsert 'oleutil'
((<'OOoNumberFormat_') ,&.> ;:'DEFINED DATE TIME CURRENCY NUMBER SCIENTIFIC FRACTION PERCENT TEXT DATETIME LOGICAL UNDEFINED')=: <. 2^i.12
OOoNumberFormat_DATETIME=: OOoNumberFormat_DATE + OOoNumberFormat_TIME
OOoNumberFormat_ALL=: 0
((<'OOoCharWeight_') ,&.> ;:'DONTKNOW THIN ULTRALIGHT LIGHT SEMILIGHT NORMAL SEMIBOLD BOLD ULTRABOLD BLACK')=: 0 50 60 75 90 100 110 150 175 200
((<'OOoHoriJustify_') ,&.> ;:'STANDARD LEFT CENTER RIGHT BLOCK REPEAT')=: i.6
((<'OOoFontUnderline_') ,&.> ;:'NONE SINGLE DOUBLE DOTTED DONTKNOW DASH LONGDASH DASHDOT DASHDOTDOT SMALLWAVE WAVE DOUBLEWAVE BOLD BOLDDOTTED BOLDDASH BOLDLONGDASH BOLDDASHDOT BOLDDASHDOTDOT BOLDWAVE')=: i.19
((<'OOoCellFlags_') ,&.> ;:'VALUE DATETIME STRING ANNOTATION FORMULA HARDATTR STYLES OBJECTS EDITATTR FORMATTED')=: <.2^i.10
OOoinvoke=: 1 : 0
'' (m OOoinvoke) y
:
'disp name temp'=. 3{. y
args=. 3}.y
oleerrno=: S_OK
if. 0=#x do. x=. (VT_BSTR, VT_BSTR, VT_I4, VT_I4, VT_R8, VT_UNKNOWN) {~ 2 131072 1 4 8 i. (3!:0&> args) end.
if. S_OK~: 0{:: 'hr id'=. disp dispid name do. hr return. end.
if. temp do. VariantClear <<temp end.
msk=. 32&~:@(3!:0)&> args
dispparams=. x makedispparms args
if. m=DISPATCH_PROPERTYPUT do.
  pdispidNamed memw dispparams, SZI, 1, 4
  (1 0 0 0{a.) memw dispparams, (IF64{12 20), 4, 2  
end.
hr=. disp idInvoke id ; GUID_NULL ; 0 ; m ; (<dispparams) ; (<temp) ; 0 ; 0
msk freedispparms dispparams
hr
)
OOoRGB=: 3 : 0
(2{y) (23 b.) 8 (33 b.) (1{y) (23 b.) 8 (33 b.) (0{y)
)
filetoURL=: 3 : 0
path=. y
if. (':' -.@e. path) *. ('/\'-.@e.~{.path) do. path=. (1!:43 ''), '/', path end.
path=. ('/'&,)^:('/'~:{.path) path=. '\/' charsub path
path=. 'file://', path stringreplace~ ' ' ; '%20' ; '#' ; '%23' ; '%' ; '%25' ; '&' ; '%26' ; ';' ; '%3B' ; '<' ; '%3C' ; '=' ; '%3D' ; '>' ; '%3E' ; '?' ; '%3F' ; '~' ; '%7E'
)
OOoCreateStruct=: 4 : 0
disp=. y
name=. x
ostru=. 0
cotmp=. olevaralloc ''
if. S_OK&= hr=. (DISPATCH_METHOD OOoinvoke) disp ; 'Bridge_GetStruct' ; cotmp ; name do.
  '' iuAddRef~ ostru=. olevalue cotmp
end.
olevarfree cotmp
ostru
)
OOoPutStruct=: 4 : 0
disp=. y
'slot val vts'=. x
({.vts) (DISPATCH_PROPERTYPUT OOoinvoke) disp ; slot ; 0 ; val
)
OOoGetStruct=: 4 : 0
disp=. y
slot=. >x
cotmp=. olevaralloc ''
hr=. (DISPATCH_PROPERTYGET OOoinvoke) disp ; slot ; cotmp
hr ;< cotmp
)
OOoPropertyValue=: 4 : 0
disp=. y
'name value vts'=. 3{.x, a:
if. 0=#vts do.
  vts=. (VT_BSTR, VT_BSTR, VT_I4, VT_I4, VT_R8, VT_UNKNOWN) {~ 2 131072 1 4 8 i. (3!:0&> value=. boxopen value)
end.
if. 0~: obj=. 'com.sun.star.beans.PropertyValue' OOoCreateStruct disp do.
  failure=. 1
  whilst. 0 do.
    if. S_OK&~: hr=. ('Name' ; name ; VT_BSTR) OOoPutStruct obj do. break. end.
    if. S_OK&~: hr=. ('Value' ; value ; vts) OOoPutStruct obj do. break. end.
    failure=. 0
  end.
  if. 0=failure do.
    obj
  else.
    0 [ obj iuRelease ''
  end.
else.
  0
end.
)
OOoMakeCellBorderLine=: 4 : 0
disp=. y
'nColor WidthDistance'=. x
if. 0~: obj=. 'com.sun.star.table.BorderLine' OOoCreateStruct disp do.
  failure=. 1
  whilst. 0 do.
    if. S_OK&~: hr=. ('Color' ; nColor ; VT_I4) OOoPutStruct obj do. break. end.
    if. S_OK&~: hr=. ('InnerLineWidth' ; (0{WidthDistance) ; VT_I2) OOoPutStruct obj do. break. end.
    if. S_OK&~: hr=. ('OuterLineWidth' ; (1{WidthDistance) ; VT_I2) OOoPutStruct obj do. break. end.
    if. S_OK&~: hr=. ('LineDistance' ; (2{WidthDistance) ; VT_I2) OOoPutStruct obj do. break. end.
    failure=. 0
  end.
  if. 0=failure do.
    obj
  else.
    0 [ obj iuRelease ''
  end.
else.
  0
end.
)
OOoGetNumberFormat=: 4 : 0
disp=. y
'fmt lang country'=. 3{.(boxopen x), '' ; ''
if. 0~: obj=. 'com.sun.star.lang.Locale' OOoCreateStruct disp do.
  failure=. 1
  cotmp=. olevaralloc ''
  whilst. 0 do.
    if. ''-.@-:lang do.
      if. S_OK&~: hr=. ('Language' ; lang ; VT_BSTR) OOoPutStruct obj do. break. end.
    end.
    if. ''-.@-:country do.
      if. S_OK&~: hr=. ('Country' ; country ; VT_BSTR) OOoPutStruct obj do. break. end.
    end.
    if. S_OK&~: hr=. '' (DISPATCH_METHOD OOoinvoke) disp ; 'getNumberFormats' ; cotmp do. break. end.
    coAddRef nf=. olevalue cotmp
    if. 1 4 e.~ 3!:0 fmt do.
      whilst. 0 do.
        if. S_OK&~: hr=. (VT_I4, VT_UNKNOWN) (DISPATCH_METHOD OOoinvoke) nf ; 'getStandardFormat' ; cotmp ; fmt ; obj do. break. end.
        fmtid=. olevalue cotmp
        failure=. 0
      end.
    else.
      whilst. 0 do.
        coAddRef obj   
        if. S_OK&~: hr=. (VT_BSTR, VT_UNKNOWN, VT_BOOL) (DISPATCH_METHOD OOoinvoke) nf ; 'queryKey' ; cotmp ; fmt ; obj ; 1 do. break. end.
        fmtid=. olevalue cotmp
        if. _1=fmtid do.
          if. S_OK&~: hr=. (VT_BSTR, VT_UNKNOWN) (DISPATCH_METHOD OOoinvoke) nf ; 'addNew' ; cotmp ; fmt ; obj do. break. end.
          fmtid=. olevalue cotmp
          failure=. 0
        else.
          failure=. 0
        end.
      end.
    end.
    nf iuRelease ''
  end.
  olevarfree cotmp
  obj iuRelease ''
  if. 0=failure do.
    fmtid
  else.
    _1
  end.
else.
  _1
end.
)
coclass 'wdooo'
coinsert 'oleutil'
coinsert 'oleooo'

oleerrno=: S_OK
init=: 0

create=: 3 : 0
oleerrno=: S_OK
init=: 0
)

destroy=: 3 : 0
if. init do.
  VariantClear <<temp
  memf temp
  base iuRelease ''
end.
codestroy''
)
oleinvoke=: 1 : 0
'' (m oleinvoke) y
:
'disp name'=. 2{. y
args=. 2}.y
oleerrno=: S_OK
if. 0=#x do. x=. (VT_BSTR, VT_BSTR, VT_I4, VT_I4, VT_R8, VT_UNKNOWN) {~ 2 131072 1 4 8 i. (3!:0&> args) end.
newdisp=. 0
if. disp=temp do.  
  if. (VT_UNKNOWN, VT_DISPATCH) -.@e.~ {.oletype temp do. 13!:8[3 [ oleerrno=: DISP_E_TYPEMISMATCH end.
  newdisp=. 1
  '' iuAddRef~ disp=. {. memr temp, 8, 1, 4
end.
if. S_OK~: 0{:: 'hr id'=. disp dispid name do. 13!:8[3 [ oleerrno=: hr end.
VariantClear <<temp
msk=. 32&~:@(3!:0)&> args
dispparams=. x makedispparms args
if. m=DISPATCH_PROPERTYPUT do.
  pdispidNamed memw dispparams, SZI, 1, 4
  (1 0 0 0{a.) memw dispparams, (IF64{12 20), 4, 2  
end.
if. S_OK~: hr=. disp idInvoke id ; GUID_NULL ; 0 ; m ; (<dispparams) ; (<temp) ; 0 ; 0 do. 13!:8[3 [ oleerrno=: hr end.
msk freedispparms dispparams
if. newdisp do. disp iuRelease '' end.
temp
)
olecreate=: 3 : 0
oleerrno=: S_OK
if. S_OK= hr=. CLSIDFromProgID`CLSIDFromString@.('{'={.@>@{.) y ; guid=. 1#GUID do.
  if. S_OK= hr=. CoCreateInstance guid ; 0 ; CTX ; iid_idisp ; p=. ,_2 do.
    base=: {.p
    init=: 1
    temp=: olevaralloc ''
    rz=. base, temp
  end.
end.
if. S_OK~: hr do. 13!:8[3 [ oleerrno=: hr end.
rz
)
olemethod=: DISPATCH_METHOD oleinvoke
oleget=: DISPATCH_PROPERTYGET oleinvoke
oleput=: oleset=: DISPATCH_PROPERTYPUT oleinvoke
oleputref=: olesetref=: DISPATCH_PROPERTYPUTREF oleinvoke
oleid=: 3 : 0
oleerrno=: S_OK
if. (VT_UNKNOWN, VT_DISPATCH) -.@e.~ {.oletype y do. 13!:8[3 [ oleerrno=: DISP_E_TYPEMISMATCH end.
'' iuAddRef~ d=. {. memr y, 8, 1, 4
d
)
olerelease=: 3 : 0
y iuRelease ''
)
oleqer=: 3 : 0
olecomerrmsg oleerrno
)
oletype=: 3 : 0
vt=. {. _1&ic memr y, 0, 2, 2
vt0=. vt ((17 b.) (26 b.)) VT_VECTOR (23 b.) VT_ARRAY (23 b.) VT_BYREF
vt0, 0~: vt (17 b.) VT_VECTOR, VT_ARRAY, VT_BYREF
)
olevalue=: 3 : 0
'vt vector array byref'=. oletype y
if. byref do. y=. {. memr y, 8, 1, 4 end.
select. vt
case. VT_I4 do. {. _2&ic memr y, 8, 4, 2
case. VT_R4 do. {. _1&fc memr y, 8, 4, 2
case. VT_R8 do. {. memr y, 8, 1, 8
case. VT_BSTR do. 6 u: memr b, 0, (_2&ic memr b, _4 4 2), 2 [ b=. {.memr y, 8 1 4
case. do. {. memr y, 8, 1, 4
end.
)

olevector=: [ olesafearray ,@]
olesafearray=: 4 : 0
if. 0=#$y do. y=. ,y end.
if. 0=#x do. x=. (VT_BSTR, VT_BSTR, VT_I4, VT_I4, VT_R8, _1, VT_UNKNOWN) {~ 2 131072 1 4 8 32 i. 3!:0 y end.
if. (0~:#,y) *. (VT_UNKNOWN=x) *. 1 4 -.@e.~ 3!:0 y do. 0 return. end.
if. _1=x do.
  if. *./ 2 131072 e.~ t=. , 3!:0 &> y do. x=. VT_BSTR
  elseif. *./ 1 4 e.~ t do. x=. VT_I4 [ y=. ($y) $ ,>y
  elseif. *./ 1 4 8 e.~ t do. x=. VT_R8 [ y=. ($y) $ ,>y
  elseif. *./ 2 131072 1 4 8 32 e.~ t do. x=. VT_VARIANT
  elseif. do. 0 return.
  end.
end.
if. VT_BSTR=x do.
  if. 32= 3!:0 y do.
    y=. SysAllocStringLen@:(];#)@:uucp&> y
  else.
    y=. SysAllocStringLen@:(];#)@:uucp("1) y
  end.
elseif. VT_VARIANT~:x do.
  if. 32= 3!:0 y do.
    try.
      y=. {.&> y
    catch.
      0 return.
    end.
    if. 32= 3!:0 y do. 0 return. end.
  end.
end.
if. 0=#$y do. y=. ,y end.
if. 0= sa=. SafeArrayCreate x ; (#$y) ; , ($y),.0 do.
  0 return.
end.
if. 0~: #,y do.
  p=. ,2-2    
  if. S_OK~: hr=. SafeArrayAccessData sa ; p do.
    SafeArrayDestroy sa
    0 return.
  end.
  if. VT_I4 = x do.
    if. IF64 do.
      (2 ic (2-2) + ,|:y) memw p, 0, (4*#,y), 2
    else.
      ((2-2) + ,|:y) memw p, 0, (#,y), 4
    end.
  elseif. VT_R8 = x do.
    (,|: _&<. y) memw p, 0, (#,y), 8
  elseif. VT_BSTR = x do.
    (,|:y) memw p, 0, (#,y), 4
  elseif. VT_VARIANT = x do.
    if. 2>#@$y do. y=. ,:y end.
    n1=. {.@$y                       
    for_i. i.{.@$ y do.
      for_j. i.{:@$ y do.
        if. 2 131072 e.~ te=. 3!:0 elm=. (<i,j){::y do.
          (1 ic VT_BSTR) memw p, (16*i+n1*j), 2 2
          (SysAllocStringLen@:(];#)@:uucp elm) memw p, (8+16*i+n1*j), 1 4
        elseif. 1 4 e.~ te do.
          (1 ic VT_I4) memw p, (16*i+n1*j), 2 2
          if. IF64 do.
            (2 ic (2-2)+ elm) memw p, (8+16*i+n1*j), 4 2
          else.
            ((2-2)+ elm) memw p, (8+16*i+n1*j), 1 4
          end.
        elseif. 32 = te do.
          if. 1 4 e.~ 3!:0 >elm do.
            (1 ic VT_UNKNOWN) memw p, (16*i+n1*j), 2 2
            if. IF64 do.
              (2 ic (2-2)+ >elm) memw p, (8+16*i+n1*j), 4 2
            else.
              ((2-2)+ >elm) memw p, (8+16*i+n1*j), 1 4
            end.
          else.
            SafeArrayUnaccessData sa
            SafeArrayDestroy sa
            0 return.
          end.
        elseif. 8 = te do.
          (1 ic VT_R8) memw p, (16*i+n1*j), 2 2
          elm memw p, (8+16*i+n1*j), 1 8
        elseif. do.
          SafeArrayUnaccessData sa
          SafeArrayDestroy sa
          0 return.
        end.
      end.
    end.
  elseif. VT_UNKNOWN = x do.
    (,|:y) memw p, 0, (#,y), 4
  elseif. do.
    assert. 0   
  end.
  if. S_OK~: hr=. SafeArrayUnaccessData sa do.
    SafeArrayDestroy sa
    0 return.
  end.
end.
arr=. olevaralloc ''
(1 ic VT_ARRAY+x) memw arr, 0, 2, 2
sa memw arr, 8, 1, 4
arr
)
coclass 'oleutil'
coinsert 'olecomerrorh'
coinsert 'olegpcall'
coinsert 'olegpole32'

VT_EMPTY=: 0
VT_NULL=: 1
VT_I2=: 2
VT_I4=: 3
VT_R4=: 4
VT_R8=: 5
VT_CY=: 6
VT_DATE=: 7
VT_BSTR=: 8
VT_DISPATCH=: 9
VT_ERROR=: 10
VT_BOOL=: 11
VT_VARIANT=: 12
VT_UNKNOWN=: 13
VT_DECIMAL=: 14
VT_I1=: 16
VT_UI1=: 17
VT_UI2=: 18
VT_UI4=: 19
VT_I8=: 20
VT_UI8=: 21
VT_INT=: 22
VT_UINT=: 23
VT_VOID=: 24
VT_HRESULT=: 25
VT_PTR=: 26
VT_SAFEARRAY=: 27
VT_CARRAY=: 28
VT_USERDEFINED=: 29
VT_LPSTR=: 30
VT_LPWSTR=: 31
VT_RECORD=: 36
VT_FILETIME=: 64
VT_BLOB=: 65
VT_STREAM=: 66
VT_STORAGE=: 67
VT_STREAMED_OBJECT=: 68
VT_STORED_OBJECT=: 69
VT_BLOB_OBJECT=: 70
VT_CF=: 71
VT_CLSID=: 72
VT_BSTR_BLOB=: 16bfff
VT_VECTOR=: 16b1000
VT_ARRAY=: 16b2000
VT_BYREF=: 16b4000
VT_RESERVED=: 16b8000
VT_ILLEGAL=: 16bffff
VT_ILLEGALMASKED=: 16bfff
VT_TYPEMASK=: 16bfff

3 : 0''
a=. ;:'VT_EMPTY VT_NULL VT_I2 VT_I4 VT_R4 VT_R8 VT_CY VT_DATE VT_BSTR'
a=. a, ;:'VT_DISPATCH VT_ERROR VT_BOOL VT_VARIANT VT_UNKNOWN VT_DECIMAL'
a=. a, ;:'VT_I1 VT_UI1 VT_UI2 VT_UI4 VT_I8 VT_UI8 VT_INT VT_UINT VT_VOID'
a=. a, ;:'VT_HRESULT VT_PTR VT_SAFEARRAY VT_CARRAY VT_USERDEFINED VT_LPSTR'
a=. a, ;:'VT_LPWSTR VT_RECORD VT_FILETIME VT_BLOB VT_STREAM VT_STORAGE'
a=. a, ;:'VT_STREAMED_OBJECT VT_STORED_OBJECT VT_BLOB_OBJECT VT_CF VT_CLSID'
a=. a, ;:'VT_BSTR_BLOB VT_VECTOR VT_ARRAY VT_BYREF VT_RESERVED VT_ILLEGAL'
a=. a, ;:'VT_ILLEGALMASKED VT_TYPEMASK'
for_ai. a do. ((>ai),'_z_')=: ".>ai end.
i. 0 0
)
VariantInit=: 'oleaut32 VariantInit > n *'&cd
SafeArrayCreate=: 'oleaut32 SafeArrayCreate > x s i *i'&cd
SafeArrayAccessData=: 'oleaut32 SafeArrayAccessData > s x *x'&cd
SafeArrayUnaccessData=: 'oleaut32 SafeArrayUnaccessData > s x'&cd
SafeArrayDestroy=: 'oleaut32 SafeArrayDestroy > s x'&cd
SafeArrayCreateVector=: 'oleaut32 SafeArrayCreateVector > x s i i'&cd
SafeArrayPutElement=: 'oleaut32 SafeArrayPutElement > i x *i *'&cd
SafeArrayGetDim=: 'oleaut32 SafeArrayGetDim > i x'&cd
SafeArrayGetLBound=: 'oleaut32 SafeArrayGetLBound > i x i *i'&cd
SafeArrayGetUBound=: 'oleaut32 SafeArrayGetUBound > i x i *i'&cd
SafeArrayGetVartype=: 'oleaut32 SafeArrayGetVartype > i x *s'&cd
S_OK=: 0
SZI=: IF64{4 8

DISPID_PROPERTYPUT=: _3
dispidNamed=: 2&ic DISPID_PROPERTYPUT
pdispidNamed=: symdat@symget < 'dispidNamed'
iid_idisp=: 0 4 2 0 0 0 0 0 192 0 0 0 0 0 0 70{a.  
DISPATCH_METHOD=: 1
DISPATCH_PROPERTYGET=: 2
DISPATCH_PROPERTYPUT=: 4
DISPATCH_PROPERTYPUTREF=: 8

dispid=: 4 : 0
assert. x~:0
y=. uucp y
nm=. ,symdat symget <,'y'
hr=. x idGetIDsOfNames GUID_NULL;nm;1;0;r=. ,_1
hr, r
)

makevariant=: 4 : 0
assert. x =&# y
if. 0=#y do. 0 return. end.
vargs=. mema 16 * #y
((16 * #y)#{.a.) memw vargs, 0, (16 * #y), 2
for_i. i.#y do.
  s=. >i{y [ vt=. >i{x
  if. 32 = 3!:0 s do.
    arr=. vargs + 16 * i
    (memr (>s), 0 16 2) memw arr, 0 16 2
  else.
    VariantInit <<arr=. vargs + 16 * i
    (1 ic vt) memw arr, 0 2 2
    byref=. vt (17 b.) VT_BYREF
    if. byref do. s memw arr, 8 1 4 continue. end.
    select. 16bfff (17 b.) vt
    case. VT_BOOL do.
      (1 ic (s~:0){0 _1) memw arr, 8 2 2
    case. VT_BSTR do.
      bstr=. SysAllocStringLen (];#) uucp ,s
      bstr memw arr, 8 1 4
    case. VT_UI1;VT_I1 do.
      (s{a.) memw arr, 8 1 2
    case. VT_UI2;VT_I2 do.
      (1 ic s) memw arr, 8 2 2
    case. VT_UI4;VT_I4;VT_ERROR do.
      if. IF64 do.
        (2 ic s) memw arr, 8 4 2
      else.
        s memw arr, 8 1 4
      end.
    case. VT_UI8;VT_I8 do.
      if. IF64 do.
        s memw arr, 8 1 4
      else.
        s memw arr, 8 1 4
        ((s<0){0 _1) memw arr, 12 1 4   
      end.
    case. VT_R4 do.
      (1 fc s) memw arr, 8 4 2
    case. VT_R8 do.
      s memw arr, 8 1 8
    case. VT_UNKNOWN;VT_DISPATCH do.
      if. 0=#s do.
        0 memw arr, 8 1 4
      else.
        s memw arr, 8 1 4
      end.
    case. VT_EMPTY do.
      0 memw arr, 8 1 4
    case. do.
      assert. 0
    end.
  end.
end.
vargs
)

makedispparms=: 4 : 0
dispparams=. mema SZI+SZI+4+4
((IF64{4 3)#0) memw dispparams, 0, (IF64{4 3), 4
(x makevariant&|. y) memw dispparams, 0 1 4        
(#y) memw dispparams, (2*SZI), 1 4                 
dispparams
)

freedispparms=: 4 : 0
msk=. |.x
if. IF64 do.
  'a b c1'=. memr y, 0 3 4
  c=. c1 (17 b.) 16bffffffff
else.
  'a b c d'=. memr y, 0 4 4
end.
if. a do.
  assert. c = #msk
  if. 1 e. msk do.
    VariantClear@<@<"0 a+msk#16*i.-c     
  end.
  memf a
end.
memf y
)
olevaralloc=: 3 : 0
f=. mema 16
(16#{.a.) memw f, 0 16 2
VariantInit <<f
f
)
olevarfree=: 3 : 0
if. y do.
  memf y [ VariantClear <<y
end.
)
coclass 'oleooo'
coinsert 'oleutil'
((<'OOoNumberFormat_') ,&.> ;:'DEFINED DATE TIME CURRENCY NUMBER SCIENTIFIC FRACTION PERCENT TEXT DATETIME LOGICAL UNDEFINED')=: <. 2^i.12
OOoNumberFormat_DATETIME=: OOoNumberFormat_DATE + OOoNumberFormat_TIME
OOoNumberFormat_ALL=: 0
((<'OOoCharWeight_') ,&.> ;:'DONTKNOW THIN ULTRALIGHT LIGHT SEMILIGHT NORMAL SEMIBOLD BOLD ULTRABOLD BLACK')=: 0 50 60 75 90 100 110 150 175 200
((<'OOoHoriJustify_') ,&.> ;:'STANDARD LEFT CENTER RIGHT BLOCK REPEAT')=: i.6
((<'OOoFontUnderline_') ,&.> ;:'NONE SINGLE DOUBLE DOTTED DONTKNOW DASH LONGDASH DASHDOT DASHDOTDOT SMALLWAVE WAVE DOUBLEWAVE BOLD BOLDDOTTED BOLDDASH BOLDLONGDASH BOLDDASHDOT BOLDDASHDOTDOT BOLDWAVE')=: i.19
((<'OOoCellFlags_') ,&.> ;:'VALUE DATETIME STRING ANNOTATION FORMULA HARDATTR STYLES OBJECTS EDITATTR FORMATTED')=: <.2^i.10
OOoinvoke=: 1 : 0
'' (m OOoinvoke) y
:
'disp name temp'=. 3{. y
args=. 3}.y
oleerrno=: S_OK
if. 0=#x do. x=. (VT_BSTR, VT_BSTR, VT_I4, VT_I4, VT_R8, VT_UNKNOWN) {~ 2 131072 1 4 8 i. (3!:0&> args) end.
if. S_OK~: 0{:: 'hr id'=. disp dispid name do. hr return. end.
if. temp do. VariantClear <<temp end.
msk=. 32&~:@(3!:0)&> args
dispparams=. x makedispparms args
if. m=DISPATCH_PROPERTYPUT do.
  pdispidNamed memw dispparams, SZI, 1, 4
  (1 0 0 0{a.) memw dispparams, (IF64{12 20), 4, 2  
end.
hr=. disp idInvoke id ; GUID_NULL ; 0 ; m ; (<dispparams) ; (<temp) ; 0 ; 0
msk freedispparms dispparams
hr
)
OOoRGB=: 3 : 0
(2{y) (23 b.) 8 (33 b.) (1{y) (23 b.) 8 (33 b.) (0{y)
)
filetoURL=: 3 : 0
path=. y
if. (':' -.@e. path) *. ('/\'-.@e.~{.path) do. path=. (1!:43 ''), '/', path end.
path=. ('/'&,)^:('/'~:{.path) path=. '\/' charsub path
path=. 'file://', path stringreplace~ ' ' ; '%20' ; '#' ; '%23' ; '%' ; '%25' ; '&' ; '%26' ; ';' ; '%3B' ; '<' ; '%3C' ; '=' ; '%3D' ; '>' ; '%3E' ; '?' ; '%3F' ; '~' ; '%7E'
)
OOoCreateStruct=: 4 : 0
disp=. y
name=. x
ostru=. 0
cotmp=. olevaralloc ''
if. S_OK&= hr=. (DISPATCH_METHOD OOoinvoke) disp ; 'Bridge_GetStruct' ; cotmp ; name do.
  '' iuAddRef~ ostru=. olevalue cotmp
end.
olevarfree cotmp
ostru
)
OOoPutStruct=: 4 : 0
disp=. y
'slot val vts'=. x
({.vts) (DISPATCH_PROPERTYPUT OOoinvoke) disp ; slot ; 0 ; val
)
OOoGetStruct=: 4 : 0
disp=. y
slot=. >x
cotmp=. olevaralloc ''
hr=. (DISPATCH_PROPERTYGET OOoinvoke) disp ; slot ; cotmp
hr ;< cotmp
)
OOoPropertyValue=: 4 : 0
disp=. y
'name value vts'=. 3{.x, a:
if. 0=#vts do.
  vts=. (VT_BSTR, VT_BSTR, VT_I4, VT_I4, VT_R8, VT_UNKNOWN) {~ 2 131072 1 4 8 i. (3!:0&> value=. boxopen value)
end.
if. 0~: obj=. 'com.sun.star.beans.PropertyValue' OOoCreateStruct disp do.
  failure=. 1
  whilst. 0 do.
    if. S_OK&~: hr=. ('Name' ; name ; VT_BSTR) OOoPutStruct obj do. break. end.
    if. S_OK&~: hr=. ('Value' ; value ; vts) OOoPutStruct obj do. break. end.
    failure=. 0
  end.
  if. 0=failure do.
    obj
  else.
    0 [ obj iuRelease ''
  end.
else.
  0
end.
)
OOoMakeCellBorderLine=: 4 : 0
disp=. y
'nColor WidthDistance'=. x
if. 0~: obj=. 'com.sun.star.table.BorderLine' OOoCreateStruct disp do.
  failure=. 1
  whilst. 0 do.
    if. S_OK&~: hr=. ('Color' ; nColor ; VT_I4) OOoPutStruct obj do. break. end.
    if. S_OK&~: hr=. ('InnerLineWidth' ; (0{WidthDistance) ; VT_I2) OOoPutStruct obj do. break. end.
    if. S_OK&~: hr=. ('OuterLineWidth' ; (1{WidthDistance) ; VT_I2) OOoPutStruct obj do. break. end.
    if. S_OK&~: hr=. ('LineDistance' ; (2{WidthDistance) ; VT_I2) OOoPutStruct obj do. break. end.
    failure=. 0
  end.
  if. 0=failure do.
    obj
  else.
    0 [ obj iuRelease ''
  end.
else.
  0
end.
)
OOoGetNumberFormat=: 4 : 0
disp=. y
'fmt lang country'=. 3{.(boxopen x), '' ; ''
if. 0~: obj=. 'com.sun.star.lang.Locale' OOoCreateStruct disp do.
  failure=. 1
  cotmp=. olevaralloc ''
  whilst. 0 do.
    if. ''-.@-:lang do.
      if. S_OK&~: hr=. ('Language' ; lang ; VT_BSTR) OOoPutStruct obj do. break. end.
    end.
    if. ''-.@-:country do.
      if. S_OK&~: hr=. ('Country' ; country ; VT_BSTR) OOoPutStruct obj do. break. end.
    end.
    if. S_OK&~: hr=. '' (DISPATCH_METHOD OOoinvoke) disp ; 'getNumberFormats' ; cotmp do. break. end.
    coAddRef nf=. olevalue cotmp
    if. 1 4 e.~ 3!:0 fmt do.
      whilst. 0 do.
        if. S_OK&~: hr=. (VT_I4, VT_UNKNOWN) (DISPATCH_METHOD OOoinvoke) nf ; 'getStandardFormat' ; cotmp ; fmt ; obj do. break. end.
        fmtid=. olevalue cotmp
        failure=. 0
      end.
    else.
      whilst. 0 do.
        coAddRef obj   
        if. S_OK&~: hr=. (VT_BSTR, VT_UNKNOWN, VT_BOOL) (DISPATCH_METHOD OOoinvoke) nf ; 'queryKey' ; cotmp ; fmt ; obj ; 1 do. break. end.
        fmtid=. olevalue cotmp
        if. _1=fmtid do.
          if. S_OK&~: hr=. (VT_BSTR, VT_UNKNOWN) (DISPATCH_METHOD OOoinvoke) nf ; 'addNew' ; cotmp ; fmt ; obj do. break. end.
          fmtid=. olevalue cotmp
          failure=. 0
        else.
          failure=. 0
        end.
      end.
    end.
    nf iuRelease ''
  end.
  olevarfree cotmp
  obj iuRelease ''
  if. 0=failure do.
    fmtid
  else.
    _1
  end.
else.
  _1
end.
)
coclass 'wdooo'
coinsert 'oleutil'
coinsert 'oleooo'

oleerrno=: S_OK
init=: 0

create=: 3 : 0
oleerrno=: S_OK
init=: 0
)

destroy=: 3 : 0
if. init do.
  VariantClear <<temp
  memf temp
  base iuRelease ''
end.
codestroy''
)
oleinvoke=: 1 : 0
'' (m oleinvoke) y
:
'disp name'=. 2{. y
args=. 2}.y
oleerrno=: S_OK
if. 0=#x do. x=. (VT_BSTR, VT_BSTR, VT_I4, VT_I4, VT_R8, VT_UNKNOWN) {~ 2 131072 1 4 8 i. (3!:0&> args) end.
newdisp=. 0
if. disp=temp do.  
  if. (VT_UNKNOWN, VT_DISPATCH) -.@e.~ {.oletype temp do. 13!:8[3 [ oleerrno=: DISP_E_TYPEMISMATCH end.
  newdisp=. 1
  '' iuAddRef~ disp=. {. memr temp, 8 1 4
end.
if. S_OK~: 0{:: 'hr id'=. disp dispid name do. 13!:8[3 [ oleerrno=: hr end.
VariantClear <<temp
msk=. 32&~:@(3!:0)&> args
dispparams=. x makedispparms args
if. m=DISPATCH_PROPERTYPUT do.
  pdispidNamed memw dispparams, SZI, 1 4
  (1 0 0 0{a.) memw dispparams, (IF64{12 20), 4 2  
end.
if. S_OK~: hr=. disp idInvoke id ; GUID_NULL ; 0 ; m ; (<dispparams) ; (<temp) ; 0 ; 0 do. 13!:8[3 [ oleerrno=: hr end.
msk freedispparms dispparams
if. newdisp do. disp iuRelease '' end.
temp
)
olecreate=: 3 : 0
oleerrno=: S_OK
if. S_OK= hr=. CLSIDFromProgID`CLSIDFromString@.('{'={.@>@{.) y ; guid=. 1#GUID do.
  if. S_OK= hr=. CoCreateInstance guid ; 0 ; CTX ; iid_idisp ; p=. ,_2 do.
    base=: {.p
    init=: 1
    temp=: olevaralloc ''
    rz=. base, temp
  end.
end.
if. S_OK~: hr do. 13!:8[3 [ oleerrno=: hr end.
rz
)
olemethod=: DISPATCH_METHOD oleinvoke
oleget=: DISPATCH_PROPERTYGET oleinvoke
oleput=: oleset=: DISPATCH_PROPERTYPUT oleinvoke
oleputref=: olesetref=: DISPATCH_PROPERTYPUTREF oleinvoke
oleid=: 3 : 0
oleerrno=: S_OK
if. (VT_UNKNOWN, VT_DISPATCH) -.@e.~ {.oletype y do. 13!:8[3 [ oleerrno=: DISP_E_TYPEMISMATCH end.
'' iuAddRef~ d=. {. memr y, 8 1 4
d
)
olerelease=: 3 : 0
y iuRelease ''
)
oleqer=: 3 : 0
olecomerrmsg oleerrno
)
oletype=: 3 : 0
vt=. {. _1&ic memr y, 0 2 2
vt0=. vt ((17 b.) (26 b.)) VT_VECTOR (23 b.) VT_ARRAY (23 b.) VT_BYREF
vt0, 0~: vt (17 b.) VT_VECTOR, VT_ARRAY, VT_BYREF
)

olebstr=: 3 : 0
6 u: memr y, 0, (_2&ic memr y, _4 4 2), 2
)
olevalue=: 3 : 0
'vt vector array byref'=. oletype y
assert. 0=vector                         
if. byref do. y=. {. memr y, 8 1 4 end.
if. array do.
  shape=. 0$0
  sa=. {. memr y, 8 1 4
  if. 0= nd=. SafeArrayGetDim sa do. 0$0 return. end.
  for_i. >:i.nd do.    
    u=. ,2-2  
    b=. ,2-2
    if. S_OK ~: hr=. SafeArrayGetLBound sa ; i ; b do. shape=. 0 break. end.
    if. S_OK ~: hr=. SafeArrayGetUBound sa ; i ; u do. shape=. 0 break. end.
    shape=. shape, >:u-b
  end.
  if. (0=#shape) +. 0 e. shape do. shape $ 0 return. end.
  vt1=. ,2-2
  if. S_OK ~: hr=. SafeArrayGetVartype sa ; vt1 do. shape $ 0 return. end.
  vt0=. ({.vt1) ((17 b.) (26 b.)) VT_VECTOR (23 b.) VT_ARRAY (23 b.) VT_BYREF
  assert. vt0=vt
  p=. ,2-2    
  if. S_OK= hr=. SafeArrayAccessData sa ; p do.
    select. vt0
    case. VT_UI1;VT_I1 do. |: (|.shape) $ a.i. memr p, 0, (*/shape), 2
    case. VT_BOOL do. |: (|.shape) $ 0 ~: _1&ic memr p, 0, (2**/shape), 2
    case. VT_UI2;VT_I2 do. |: (|.shape) $ _1&ic memr p, 0, (2**/shape), 2
    case. VT_UI4;VT_I4;VT_EMPTY do.
      if. IF64 do.
        |: (|.shape) $ _2&ic memr p, 0, (4**/shape), 2
      else.
        |: (|.shape) $ memr p, 0, (*/shape), 4
      end.
    case. VT_UI8;VT_I8 do.
      if. IF64 do.
        |: (|.shape) $ memr p, 0, (*/shape), 4
      else.
        |: (|.shape) $ , {.("1) _2\] _2&ic memr p, 0, (8**/shape), 2
      end.
    case. VT_R4 do. |: (|.shape) $ _1&fc memr p, 0, (4**/shape), 2
    case. VT_R8 do. |: (|.shape) $ memr p, 0, (*/shape), 8
    case. VT_BSTR do. |: (|.shape) $ <@olestr"0 memr p, 0, (*/shape), 4
    case. VT_VARIANT do. |: (|.shape) $ <@olevalue"0 ({.p)+16*i.(*/shape)
    case. do. |: (|.shape) $ memr p, 0, (*/shape), 4
    end.
    if. S_OK~: hr=. SafeArrayUnaccessData sa do. end.
  else.
    shape $ 0
  end.
else.
  select. vt
  case. VT_UI1;VT_I1 do. {. a.i. memr y, 8 1 2
  case. VT_BOOL do. {. 0 ~: _1&ic memr y, 8 2 2
  case. VT_UI2;VT_I2 do. {. _1&ic memr y, 8 2 2
  case. VT_UI4;VT_I4;VT_EMPTY do.
    if. IF64 do.
      {. _2&ic memr y, 8 4 2
    else.
      {. memr y, 8 1 4
    end.
  case. VT_UI8;VT_I8 do.
    if. IF64 do.
      {. memr y, 8 1 4
    else.
      {. _2&ic memr y, 8 4 2
    end.
  case. VT_R4 do. {. _1&fc memr y, 8 4 2
  case. VT_R8 do. {. memr y, 8 1 8
  case. VT_BSTR do. olebstr {. memr y, 8 1 4
  case. VT_VARIANT do. olevalue {. memr y, 8 1 4
  case. do. {. memr y, 8 1 4
  end.
end.
)

olevector=: [ olesafearray ,@]
olesafearray=: 4 : 0
if. 0=#$y do. y=. ,y end.
if. 0=#x do. x=. (VT_BSTR, VT_BSTR, VT_I4, VT_I4, VT_R8, _1, VT_UNKNOWN) {~ 2 131072 1 4 8 32 i. 3!:0 y end.
if. (0~:#,y) *. (VT_UNKNOWN=x) *. 1 4 -.@e.~ 3!:0 y do. 0 return. end.
if. _1=x do.
  if. *./ 2 131072 e.~ t=. , 3!:0 &> y do. x=. VT_BSTR
  elseif. *./ 1 4 e.~ t do. x=. VT_I4 [ y=. ($y) $ ,>y
  elseif. *./ 1 4 8 e.~ t do. x=. VT_R8 [ y=. ($y) $ ,>y
  elseif. *./ 2 131072 1 4 8 32 e.~ t do. x=. VT_VARIANT
  elseif. do. 0 return.
  end.
end.
if. VT_BSTR=x do.
  if. 32= 3!:0 y do.
    y=. SysAllocStringLen@:(];#)@:uucp&> y
  else.
    y=. SysAllocStringLen@:(];#)@:uucp("1) y
  end.
elseif. VT_VARIANT~:x do.
  if. 32= 3!:0 y do.
    try.
      y=. {.&> y
    catch.
      0 return.
    end.
    if. 32= 3!:0 y do. 0 return. end.
  end.
end.
if. 0=#$y do. y=. ,y end.
if. 0= sa=. SafeArrayCreate x ; (#$y) ; , ($y),.0 do.
  0 return.
end.
if. 0~: #,y do.
  p=. ,2-2    
  if. S_OK~: hr=. SafeArrayAccessData sa ; p do.
    SafeArrayDestroy sa
    0 return.
  end.
  if. (VT_UI1,VT_I1) e.~ x do.
    (a.{~ <. ,|:y) memw p, 0, (#,y), 2
  elseif. VT_BOOL = x do.
    (1 ic 0 _1{~ 0~: <. ,|:y) memw p, 0, (2*#,y), 2
  elseif. (VT_UI2,VT_I2) e.~ x do.
    (1 ic <. ,|:y) memw p, 0, (2*#,y), 2
  elseif. (VT_UI4,VT_I4,VT_EMPTY) e.~ x do.
    if. IF64 do.
      (2 ic <. ,|:y) memw p, 0, (4*#,y), 2
    else.
      ((2-2) + <. ,|:y) memw p, 0, (#,y), 4
    end.
  elseif. (VT_UI8,VT_I8) e.~ x do.
    if. IF64 do.
      ((2-2) + <. ,|:y) memw p, 0, (#,y), 4
    else.
      (2 ic , (] , (0 _1 {~ 0&>))"0 <. ,|:y) memw p, 0, (8*#,y), 2   
    end.
  elseif. VT_R4 = x do.
    (1 fc ,|: _&<. y) memw p, 0, (4*#,y), 2
  elseif. VT_R8 = x do.
    (,|: _&<. y) memw p, 0, (#,y), 8
  elseif. VT_BSTR = x do.
    (,|:y) memw p, 0, (#,y), 4
  elseif. VT_VARIANT = x do.
    if. 2>#@$y do. y=. ,:y end.
    n1=. {.@$y                       
    for_i. i.{.@$ y do.
      for_j. i.{:@$ y do.
        if. 2 131072 e.~ te=. 3!:0 elm=. (<i,j){::y do.
          (1 ic VT_BSTR) memw p, (16*i+n1*j), 2 2
          (SysAllocStringLen@:(];#)@:uucp elm) memw p, (8+16*i+n1*j), 1 4
        elseif. 1 4 e.~ te do.
          (1 ic VT_I4) memw p, (16*i+n1*j), 2 2
          if. IF64 do.
            (2 ic (2-2)+ elm) memw p, (8+16*i+n1*j), 4 2
          else.
            ((2-2)+ elm) memw p, (8+16*i+n1*j), 1 4
          end.
        elseif. 32 = te do.
          if. 1 4 e.~ 3!:0 >elm do.
            (1 ic VT_UNKNOWN) memw p, (16*i+n1*j), 2 2
            if. IF64 do.
              (2 ic (2-2)+ >elm) memw p, (8+16*i+n1*j), 4 2
            else.
              ((2-2)+ >elm) memw p, (8+16*i+n1*j), 1 4
            end.
          else.
            SafeArrayUnaccessData sa
            SafeArrayDestroy sa
            0 return.
          end.
        elseif. 8 = te do.
          (1 ic VT_R8) memw p, (16*i+n1*j), 2 2
          elm memw p, (8+16*i+n1*j), 1 8
        elseif. do.
          SafeArrayUnaccessData sa
          SafeArrayDestroy sa
          0 return.
        end.
      end.
    end.
  elseif. VT_UNKNOWN = x do.
    (,|:y) memw p, 0, (#,y), 4
  elseif. do.
    assert. 0   
  end.
  if. S_OK~: hr=. SafeArrayUnaccessData sa do.
    SafeArrayDestroy sa
    0 return.
  end.
end.
arr=. olevaralloc ''
(1 ic VT_ARRAY+x) memw arr, 0 2 2
sa memw arr, 8 1 4
arr
)

