coclass'jni'
JNIInvalidRefType=: 0
JNILocalRefType=: 1
JNIGlobalRefType=: 2
JNIWeakGlobalRefType=: 3
JNI_FALSE=: 0
JNI_TRUE=: 1
JNI_OK=: 0
JNI_ERR=: _1
JNI_EDETACHED=: _2
JNI_EVERSION=: _3
JNI_ENOMEM=: _4
JNI_EEXIST=: _5
JNI_EINVAL=: _6
JNI_COMMIT=: 1
JNI_ABORT=: 2

JNI_VERSION_1_1=: 16b00010001
JNI_VERSION_1_2=: 16b00010002
JNI_VERSION_1_4=: 16b00010004
JNI_VERSION_1_6=: 16b00010006
JNI_FUNCTION=: <;._2 ] 0 : 0
NULL
NULL
NULL
NULL
GetVersion                    i x
DefineClass                   x x *c x *c i
FindClass                     x x *c
FromReflectedMethod           x x x
FromReflectedField            x x x
ToReflectedMethod             x x x x c
GetSuperclass                 x x x
IsAssignableFrom              c x x x
ToReflectedField              x x x x c
Throw                         i x x
ThrowNew                      i x x *c
ExceptionOccurred             x x
ExceptionDescribe             n x
ExceptionClear                n x
FatalError                    n x *c
PushLocalFrame                i x i
PopLocalFrame                 x x x
NewGlobalRef                  x x x
DeleteGlobalRef               n x x
DeleteLocalRef                n x x
IsSameObject                  c x x x
NewLocalRef                   x x x
EnsureLocalCapacity           i x i
AllocObject                   x x x
NewObject                     x x x x
NewObjectV                    x x x x x
NewObjectA                    x x x x *x
GetObjectClass                x x x
IsInstanceOf                  c x x x
GetMethodID                   x x x *c *c
CallObjectMethod              x x x x
CallObjectMethodV             x x x x x
CallObjectMethodA             x x x x *x
CallBooleanMethod             c x x x
CallBooleanMethodV            c x x x x
CallBooleanMethodA            c x x x *x
CallByteMethod                c x x x
CallByteMethodV               c x x x x
CallByteMethodA               c x x x *x
CallCharMethod                w x x x
CallCharMethodV               w x x x x
CallCharMethodA               w x x x *x
CallShortMethod               s x x x
CallShortMethodV              s x x x x
CallShortMethodA              s x x x *x
CallIntMethod                 i x x x
CallIntMethodV                i x x x x
CallIntMethodA                i x x x *x
CallLongMethod                l x x x
CallLongMethodV               l x x x x
CallLongMethodA               l x x x *x
CallFloatMethod               f x x x
CallFloatMethodV              f x x x x
CallFloatMethodA              f x x x *x
CallDoubleMethod              d x x x
CallDoubleMethodV             d x x x x
CallDoubleMethodA             d x x x *x
CallVoidMethod                n x x x
CallVoidMethodV               n x x x x
CallVoidMethodA               n x x x *x
CallNonvirtualObjectMethod    x x x x x
CallNonvirtualObjectMethodV   x x x x x x
CallNonvirtualObjectMethodA   x x x x x *x
CallNonvirtualBooleanMethod   c x x x x
CallNonvirtualBooleanMethodV  c x x x x x
CallNonvirtualBooleanMethodA  c x x x x *x
CallNonvirtualByteMethod      c x x x x
CallNonvirtualByteMethodV     c x x x x x
CallNonvirtualByteMethodA     c x x x x *x
CallNonvirtualCharMethod      w x x x x
CallNonvirtualCharMethodV     w x x x x x
CallNonvirtualCharMethodA     w x x x x *x
CallNonvirtualShortMethod     s x x x x
CallNonvirtualShortMethodV    s x x x x x
CallNonvirtualShortMethodA    s x x x x *x
CallNonvirtualIntMethod       i x x x x
CallNonvirtualIntMethodV      i x x x x x
CallNonvirtualIntMethodA      i x x x x *x
CallNonvirtualLongMethod      l x x x x
CallNonvirtualLongMethodV     l x x x x x
CallNonvirtualLongMethodA     l x x x x *x
CallNonvirtualFloatMethod     f x x x x
CallNonvirtualFloatMethodV    f x x x x x
CallNonvirtualFloatMethodA    f x x x x *x
CallNonvirtualDoubleMethod    d x x x x
CallNonvirtualDoubleMethodV   d x x x x x
CallNonvirtualDoubleMethodA   d x x x x *x
CallNonvirtualVoidMethod      n x x x x
CallNonvirtualVoidMethodV     n x x x x x
CallNonvirtualVoidMethodA     n x x x x *x
GetFieldID                    x x x *c *c
GetObjectField                x x x x
GetBooleanField               c x x x
GetByteField                  c x x x
GetCharField                  w x x x
GetShortField                 s x x x
GetIntField                   i x x x
GetLongField                  l x x x
GetFloatField                 f x x x
GetDoubleField                d x x x
SetObjectField                n x x x x
SetBooleanField               n x x x c
SetByteField                  n x x x c
SetCharField                  n x x x w
SetShortField                 n x x x s
SetIntField                   n x x x i
SetLongField                  n x x x l
SetFloatField                 n x x x f
SetDoubleField                n x x x d
GetStaticMethodID             x x x *c *c
CallStaticObjectMethod        x x x x
CallStaticObjectMethodV       x x x x x
CallStaticObjectMethodA       x x x x *x
CallStaticBooleanMethod       c x x x
CallStaticBooleanMethodV      c x x x x
CallStaticBooleanMethodA      c x x x *x
CallStaticByteMethod          c x x x
CallStaticByteMethodV         c x x x x
CallStaticByteMethodA         c x x x *x
CallStaticCharMethod          w x x x
CallStaticCharMethodV         w x x x x
CallStaticCharMethodA         w x x x *x
CallStaticShortMethod         s x x x
CallStaticShortMethodV        s x x x x
CallStaticShortMethodA        s x x x *x
CallStaticIntMethod           i x x x
CallStaticIntMethodV          i x x x x
CallStaticIntMethodA          i x x x *x
CallStaticLongMethod          l x x x
CallStaticLongMethodV         x x x x
CallStaticLongMethodA         l x x x *x
CallStaticFloatMethod         f x x x
CallStaticFloatMethodV        f x x x x
CallStaticFloatMethodA        f x x x *x
CallStaticDoubleMethod        d x x x
CallStaticDoubleMethodV       d x x x x
CallStaticDoubleMethodA       d x x x *x
CallStaticVoidMethod          n x x x
CallStaticVoidMethodV         n x x x x
CallStaticVoidMethodA         n x x x *x
GetStaticFieldID              x x x *c *c
GetStaticObjectField          x x x x
GetStaticBooleanField         c x x x
GetStaticByteField            c x x x
GetStaticCharField            w x x x
GetStaticShortField           s x x x
GetStaticIntField             i x x x
GetStaticLongField            l x x x
GetStaticFloatField           f x x x
GetStaticDoubleField          d x x x
SetStaticObjectField          n x x x x
SetStaticBooleanField         n x x x c
SetStaticByteField            n x x x c
SetStaticCharField            n x x x w
SetStaticShortField           n x x x s
SetStaticIntField             n x x x i
SetStaticLongField            n x x x l
SetStaticFloatField           n x x x f
SetStaticDoubleField          n x x x d
NewString                     x x *w i
GetStringLength               i x x
GetStringChars                x x x *c
ReleaseStringChars            n x x *w
NewStringUTF                  x x *c
GetStringUTFLength            i x x
GetStringUTFChars             x x x *c
ReleaseStringUTFChars         n x x *c
GetArrayLength                i x x
NewObjectArray                x x i x x
GetObjectArrayElement         x x x i
SetObjectArrayElement         n x x i x
NewBooleanArray               x x i
NewByteArray                  x x i
NewCharArray                  x x i
NewShortArray                 x x i
NewIntArray                   x x i
NewLongArray                  x x i
NewFloatArray                 x x i
NewDoubleArray                x x i
GetBooleanArrayElements       x x x *c
GetByteArrayElements          x x x *c
GetCharArrayElements          x x x *c
GetShortArrayElements         x x x *c
GetIntArrayElements           x x x *c
GetLongArrayElements          x x x *c
GetFloatArrayElements         x x x *c
GetDoubleArrayElements        x x x *c
ReleaseBooleanArrayElements   n x x *c i
ReleaseByteArrayElements      n x x *c i
ReleaseCharArrayElements      n x x *w i
ReleaseShortArrayElements     n x x *s i
ReleaseIntArrayElements       n x x *i i
ReleaseLongArrayElements      n x x *l i
ReleaseFloatArrayElements     n x x *f i
ReleaseDoubleArrayElements    n x x *d i
GetBooleanArrayRegion         n x x i i *c
GetByteArrayRegion            n x x i i *c
GetCharArrayRegion            n x x i i *w
GetShortArrayRegion           n x x i i *s
GetIntArrayRegion             n x x i i *i
GetLongArrayRegion            n x x i i *l
GetFloatArrayRegion           n x x i i *f
GetDoubleArrayRegion          n x x i i *d
SetBooleanArrayRegion         n x x i i *c
SetByteArrayRegion            n x x i i *c
SetCharArrayRegion            n x x i i *w
SetShortArrayRegion           n x x i i *s
SetIntArrayRegion             n x x i i *i
SetLongArrayRegion            n x x i i *l
SetFloatArrayRegion           n x x i i *f
SetDoubleArrayRegion          n x x i i *d
RegisterNatives               i x x x i
UnregisterNatives             i x x
MonitorEnter                  i x x
MonitorExit                   i x x
GetJavaVM                     i x *x
GetStringRegion               n x x i i *w
GetStringUTFRegion            n x x i i *c
GetPrimitiveArrayCritical     x x x *c
ReleasePrimitiveArrayCritical n x x x i
GetStringCritical             x x x *c
ReleaseStringCritical         n x x *w
NewWeakGlobalRef              x x x
DeleteWeakGlobalRef           n x x
ExceptionCheck                c x
NewDirectByteBuffer           x x x l
GetDirectBufferAddress        x x x
GetDirectBufferCapacity       l x x
GetObjectRefType              x x x
)

3 : 0''
(('ID_'&,)@:(-.&' ')@:(30&{.)&.> JNI_FUNCTION)=: i.#JNI_FUNCTION
func=: (-.&' ')@:(30&{.)&.> JNI_FUNCTION
func_sig=: dtb@:(30&}.)&.> JNI_FUNCTION
opt=. IFUNIX{::' > + ';' > '
". 4}. (>func),"1 ('=: 3 : (''''''1 ',"1 (":,.i.#JNI_FUNCTION),"1 opt,"1 (>func_sig),"1 '''''&(15!:0) (<JNIENV), y''',"1 ';'':'';',"1 '''''''1 ',"1 (":,.i.#JNI_FUNCTION),"1 opt,"1 (>func_sig),"1 '''''&(15!:0) (<x), y'')')
EMPTY
)
JNIVM_FUNCTION=: <;._2 ] 0 : 0
NULL
NULL
NULL
DestroyJavaVM                 i x
AttachCurrentThread           i x *x x
DetachCurrentThread           i x
GetEnv                        i x *x i
AttachCurrentThreadAsDaemon   i x *x x
)

3 : 0''
(('ID_'&,)@:(-.&' ')@:(30&{.)&.> JNIVM_FUNCTION)=: i.#JNIVM_FUNCTION
func=: (-.&' ')@:(30&{.)&.> JNIVM_FUNCTION
func_sig=: dtb@:(30&}.)&.> JNIVM_FUNCTION
opt=. IFUNIX{::' > + ';' > '
". 3}. (>func),"1 ('=: 3 : (''''''1 ',"1 (":,.i.#JNIVM_FUNCTION),"1 opt,"1 (>func_sig),"1 '''''&(15!:0) (<JNIVM), y''',"1 ';'':'';',"1 '''''''1 ',"1 (":,.i.#JNIVM_FUNCTION),"1 opt,"1 (>func_sig),"1 '''''&(15!:0) (<x), y'')')
EMPTY
)
jnivararg=: 1 : 0
:
opt=. IFUNIX{::' > + ';' > '
((":1,m), opt, x)&(15!:0) (<JNIENV), y
)
jnivarargs=: 2 : 0
:
opt=. IFUNIX{::' > + ';' > '
((":1,m), opt, x)&(15!:0) (<n), y
)
jnicheck=: 3 : 0
]`('JNI exception' (13!:8) 3:)@.(0 ~: a. i. ExceptionCheck_jni_@(''"_)) y
:
]`('JNI exception' (13!:8) 3:)@.(0 ~: a. i. x&ExceptionCheck_jni_@(''"_)) y
)
jniproxy=: 4 : 0
cls=. GetObjectClass <x
mid=. GetMethodID cls;'CreateProxy';'(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;'
s1=. NewStringUTF {.y
s2=. NewStringUTF {:y
s=. 'x x x x x x' (ID_CallObjectMethod jnivararg) x;mid;s1;s2
s
)
3 : 0''
if. 0 -: jvm=. 2!:5 'LIBJVM_PATH' do. jvm=. '' end.
if. #jvm do. jvm=. jvm, (-.({:jvm)e.'/\')#'/' end.
if. 0 -: jlib=. 2!:5 'JAVALD_PATH' do. jlib=. '' end.
if. #jlib do.
  if. IFUNIX do.
    ((unxlib 'c'),' setenv > i *c *c i')&(15!:0) (('Darwin'-:UNAME){::'LD_LIBRARY_PATH';'DYLD_LIBRARY_PATH');jlib;1
  else.
    'kernel32 SetDllDirectoryW > x *w'cd <uucp jlib
  end.
end.
libjvm=. '"', '"',~ jvm, (('Darwin'-:UNAME) + IFUNIX){::'libjvm.dll';'libjvm.so';'libjvm.dylib'
opt=. IFUNIX{::' > + ';' > '
JNI_GetDefaultJavaVMInitArgs=: (libjvm, ' JNI_GetDefaultJavaVMInitArgs', opt, 'i x')&(15!:0)
JNI_CreateJavaVM=: (libjvm, ' JNI_CreateJavaVM', opt, 'i *x *x x')&(15!:0)
JNI_GetCreatedJavaVMs=: (libjvm, ' JNI_GetCreatedJavaVMs', opt, 'i *x i *i')&(15!:0)
JNI_OnLoad=: (libjvm, ' JNI_OnLoad', opt, 'i x x')&(15!:0)
JNI_OnUnload=: (libjvm, ' JNI_OnUnload', opt, 'n x x')&(15!:0)
EMPTY
)
CreateJavaVM=: 3 : 0
if. 0= #y=. boxxopen y do.
  args=. '' [ version=. 4
else.
  version=. >{.y [ args=. }.y
end.
assert. version e. 1 2 4 6
noptions=. #args
version=. ". 'JNI_VERSION_1_', ":version
SZI=. IF64{4 8
initargs=. mema IF64{16 24
if. noptions do.
  options=. mema noptions * IF64{8 16
  pargs=. 15!:14 <'args'
  for_p. memr pargs,0,noptions,4 do.
    (p+memr p,0 1 4) memw (options + p_index*IF64{8 16),0 1 4
  end.
end.
(2 ic version) memw initargs,0 4 2
(2 ic noptions) memw initargs,4 4 2
if. noptions do. options memw initargs,8 1 4 end.
(0{a.) memw initargs,(IF64{12 16),1,2
vm=. ,2-2
env=. ,2-2
rc=. JNI_CreateJavaVM vm;env;initargs
if. noptions do. memf options end.
memf initargs
(0>rc){::(vm,env);0 0
)
va_list_jni_=: 3 : 0
(3!:0 &> y) va_list y
:
assert. (#x)=#y [ 'va_list_jni'
z=. ''
for_i. i.#x do.
  select. i{x
  case. 1 do. z=. z, (IF64{2 3)&ic i{::y
  case. 2 do. z=. z, i{::y
  case. 4 do. z=. z, (IF64{2 3)&ic i{::y
  case. 8 do. z=. z, 2&fc i{::y
  case. 16 do. z=. z, 2&fc +. i{::y
  case. do. assert. 0 [ 'va_list_jni'
  end.
end.
z
)

ExceptionMessage=: 3 : 0
try.
  ExceptionClear''
  jnicheck cls=. GetObjectClass <y
  jnicheck mid=. GetMethodID cls;'getMessage';'()Ljava/lang/String;'
  jnicheck DeleteLocalRef <cls
  jnicheck jstr=. 'x x x x' (ID_CallObjectMethod jnivararg) y ; mid
  jnicheck cstr=. GetStringUTFChars jstr;<<0
  assert. 0~:cstr [ 'ExceptionMessage'
  z=. memr cstr,0,_1
  ReleaseStringUTFChars jstr;<<cstr
  DeleteLocalRef <y
  z
catch.
  DeleteLocalRef <y
  ExceptionClear''
  '' return.
end.
)

GetClassName=: 0&$: : (4 : 0)
try.
  jnicheck ccls=. FindClass <'java/lang/Class'
  jnicheck mid=. GetMethodID ccls;'getName';'()Ljava/lang/String;'
  jnicheck DeleteLocalRef <ccls
  if. 0=x do.
    jnicheck ecls=. GetObjectClass <y
  else.
    ecls=. y
  end.
  jnicheck jstr=. 'x x x x' (ID_CallObjectMethod jnivararg) ecls ; mid
  if. 0=x do.
    jnicheck DeleteLocalRef <ecls
  end.
  jnicheck cstr=. GetStringUTFChars jstr;<<0
  assert. 0~:cstr [ 'GetClassName'
  z=. memr cstr,0,_1
  ReleaseStringUTFChars jstr;<<cstr
  z
catch.
  ExceptionClear''
  '' return.
end.
)
jnisig_idx=: 4 : 0
sig=. jnisig_addsep x
'attr class member'=. y
if. 1 4 e.~ 3!:0 class do.
  class=. 1&GetClassName cls
end.
class=. './' charsub class
m1=. ({."1 jitfcattr) = +/ '#'=sig
m2=. ((jitfc_class,jitfc_member){"1 jitfc) -:"1 class;member
if. 0= nm=. +/m=. m1*.m2 do. _1 return.
elseif. 1= nm do. {.I. m return.
elseif. do.
  m3=. ((1+#attr){."1 jitfcattr) -:"1 attr,~ +/ '#'=sig
  m4=. (jitfc_paramtype{"1 jitfc) = <,x
  if. # idx=. I. m*.m3*.m4 do. {.idx else. _1 end.
end.
)

jnisig_addsep=: 3 : 0
if. '#' e. y do. y return. end.
z=. ''
i=. 0 [ ar=. 0
while. i<#y do.
  if. '[' = (tp=. i{y) do.
    i=. >:i [ ar=. 1 continue.
  else.
    if. tp e. 'BSIJFDZC' do.
      z=. z, '#', (ar#'['), i{y
      i=. >:i [ ar=. 0
    elseif. tp='W' do.
      z=. z, '#', (ar#'['), 'Ljava/lang/String;'
      i=. >:i [ ar=. 0
    elseif. tp='O' do.
      z=. z, '#', (ar#'['), 'Ljava/lang/Object;'
      i=. >:i [ ar=. 0
    elseif. do.
      assert. 'L'=tp [ 'jnisig_addsep'
      if. (#k) = j=. ';' i.~ k=. i}.y do.
        z=. z, '#', (ar#'['), k, ';' break.
      else.
        z=. z, '#', (ar#'['), (j{.k), ';'
        i=. i + j + 1 [ ar=. 0
      end.
    end.
  end.
end.
z
)
jnisig_x15=: 1&$: : (4 : 0)
z=. ''
for_t. <;._1 y do.
  t1=. >t
  if. ar=. '['={.t1 do.
    t1=. }.t1
    if. (t2=. {.t1) e. 'BSIJFDZC' do.
      z=. z, ' x'
    else.
      z=. z, ' x'
    end.
  else.
    if. (t2=. {.t1) e. 'BSIJFDZC' do.
      z=. z, ' ', ('BSIJFDZC' i. t2){ x{::'csilfdic';'ciilddic'
    else.
      z=. z, ' x'
    end.
  end.
end.
}.z
)

jnisig_arg=: 4 : 0
y=. boxxopen y
assert. (#y) = +/ '#'=x [ 'jnisig_arg'
z=. 0$<''
for_t. <;._1 x do.
  a1=. t_index{::y
  t1=. >t
  if. ar=. '['={.t1 do.
    assert. 1 4 e.~ 3!:0 a1 [ 'jnisig_arg array not object'
    z=. z, < a1
  else.
    a1=. {.a1
    if. (t2=. {.t1) e. 'BZ' do.
      if. 2=3!:0 a1 do.
        z=. z, < a.i.a1
      else.
        assert. 1 4 e.~ 3!:0 a1 [ 'jnisig_arg'
        z=. z, < a1
      end.
    elseif. t2 e. 'C' do.
      assert. 2 131072 e.~ 3!:0 a1 [ 'jnisig_arg'
      z=. z, <{. uucp a1
    elseif. t2 e. 'SIJFD' do.
      assert. 1 4 8 e.~ 3!:0 a1 [ 'jnisig_arg'
      z=. z, <a1
    elseif. t2 e. 'L' do.
      assert. 1 4 32 e.~ 3!:0 a1 [ 'jnisig_arg'
      z=. z, <>a1
    elseif. do.
      assert. 0 [ 'jnisig_arg'
    end.
  end.
end.
z
)

jnisig_guesstype=: 3 : 0
z=. ''
for_t. y do.
  t1=. >t
  ar=. 0~: $$t1
  if. (tp=. 3!:0 t1) = 1 do.
    z=. z, (ar#'['), 'Z'
  elseif. tp = 2 do.
    if. ar do.
      z=. z, 'Ljava/lang/String;'
    else.
      z=. z, 'C'
    end.
  elseif. tp = 4 do.
    z=. z, (ar#'['), 'I'
  elseif. tp = 8 do.
    z=. z, (ar#'['), 'F'
  elseif. tp = 32 do.
    z=. z, (ar#'['), 'Ljava/lang/Object;'
  end.
end.
z
)
jniCallMethod=: 3 : 0
'' jniCallMethod y
:
y=. boxxopen y
if. 4>#y do.
  sig=. ''
else.
  if. ''-:x do.
    sig=. jnisig_guesstype boxopen 3}.y
  else.
    sig=. x
  end.
end.
sig=. jnisig_addsep sig
assert. (+/'#'=sig) = _3 + #y [ 'jniCallMethod'
y=. 3}.y [ 'obj class method'=. 3{.y
assert. 1 4 e.~ 3!:0 obj [ 'jniCallMethod'
assert. 1 2 4 e.~ 3!:0 obj ['jniCallMethod'
assert. 2 e.~ 3!:0 method [ 'jniCallMethod'
str=. stri=. 0$0
if. '<init>'-:method do.
  assert. 0= obj
  assert. 1 2 4 e.~ 3!:0 class [ 'jniCallMethod'
  assert. '' -.@-: class [ 'jniCallMethod'
  assert. 0 -.@-: class [ 'jniCallMethod'
end.
cls=. 0
newcls=. 1
if. (0-.@-:class) *. 1 4 e.~ 3!:0 class do.
  newcls=. 0
  cls=. class
  class=. 1&GetClassName cls
else.
  if. '<init>'-:method do.
    if. 0=obj do.
      assert. ''-.@-:class ['jniCallMethod'
      assert. 0-.@-:class [ 'jniCallMethod'
      class=. './' charsub ('L'={.class) }. class -. ';'
      jnicheck cls=. FindClass <class
    else.
      newcls=. 0
      cls=. obj
    end.
  else.
    if. (0-:class) +. ''-:class do.
      assert. 0~:obj [ 'jniCallMethod'
      jnicheck cls=. GetObjectClass <obj
      class=. GetClassName obj
    else.
      class=. './' charsub ('L'={.class) }. class -. ';'
      jnicheck cls=. FindClass <class
    end.
  end.
end.
assert. 0~:cls [ 'jniCallMethod'
assert. ''-.@-:class [ 'jniCallMethod'
attr=. 2 1{~ '<init>'-:method
if. _1= idx=. sig jnisig_idx attr;class;method do.
  'java class/member not found in jitfc' (13!:8) 3
end.
pty=. '(', ('#'-.~(<idx, jitfc_paramtype){::jitfc), ')', rt=. (<idx, jitfc_rettype){::jitfc
attr=. }. idx{jitfcattr
static=. 1{attr
if. static *. 0=obj do. obj=. cls end.
jnicheck mid=. GetMethodID`GetStaticMethodID@.static cls;method;pty
if. 1 e. s1=. (<'Ljava/lang/String;') = <;._1 sig do.
  for_i. I. s1 do.
    if. 2 131072 e.~ 3!:0 y1=. i{::y do.
      str=. str, <NewStringUTF < 8&u: y1
      stri=. stri, i
    end.
  end.
  if. #stri do. y=. str stri}y end.
end.
if. '<init>'-:method do.
  jnicheck rc=. ('x x x x ', jnisig_x15 sig) (ID_NewObject jnivararg) (cls ; mid), sig jnisig_arg y
else.
  if. '[' e. rt do.
    jnicheck rc=. ('x x x x ', jnisig_x15 sig) ((static{ID_CallObjectMethod,ID_CallStaticObjectMethod) jnivararg) (obj ; mid), sig jnisig_arg y
  else.
    select. {.rt
    case. 'V' do. jnicheck rc=. ('x x x x ', jnisig_x15 sig) ((static{ID_CallVoidMethod,ID_CallStaticVoidMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'L' do. jnicheck rc=. ('x x x x ', jnisig_x15 sig) ((static{ID_CallObjectMethod,ID_CallStaticObjectMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'B' do. jnicheck rc=. ('c x x x ', jnisig_x15 sig) ((static{ID_CallByteMethod,ID_CallStaticByteMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'Z' do. jnicheck rc=. ('i x x x ', jnisig_x15 sig) ((static{ID_CallBooleanMethod,ID_CallStaticBooleanMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'I' do. jnicheck rc=. ('i x x x ', jnisig_x15 sig) ((static{ID_CallIntMethod,ID_CallStaticIntMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'J' do. jnicheck rc=. ('l x x x ', jnisig_x15 sig) ((static{ID_CallLongMethod,ID_CallStaticLongMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'S' do. jnicheck rc=. ('s x x x ', jnisig_x15 sig) ((static{ID_CallShortMethod,ID_CallStaticShortMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'F' do. jnicheck rc=. ('f x x x ', jnisig_x15 sig) ((static{ID_CallFloatMethod,ID_CallStaticFloatMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'D' do. jnicheck rc=. ('d x x x ', jnisig_x15 sig) ((static{ID_CallDoubleMethod,ID_CallStaticDoubleMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'C' do. jnicheck rc=. ('w x x x ', jnisig_x15 sig) ((static{ID_CallCharMethod,ID_CallStaticCharMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. do. assert. 0 [ 'jniCallMethod'
    end.
  end.
end.
if. newcls do. DeleteLocalRef <cls end.
rc
)

jniField=: 1 : 0
rt=. m
assert. 1 4 e.~ 3!:0 y [ 'jniField'
assert. 0-.@-:y [ 'jniField'
jnicheck cls=. GetObjectClass_jni_ <y
z=. rt jniCallField_jni_ 0;y;cls
DeleteLocalRef_jni_ <cls
z
:
rt=. m
assert. 1 4 e.~ 3!:0 y [ 'jniField'
assert. 0-.@-:y [ 'jniField'
jnicheck cls=. GetObjectClass_jni_ <y
rt jniCallField_jni_ (0;y;cls), boxxopen x
DeleteLocalRef_jni_ <cls
EMPTY
)
jniStaticField=: 1 : 0
rt=. m
if. 1 4 e.~ 3!:0 y do.
  assert. 0-.@-:y [ 'jniStaticField'
  jnicheck cls=. GetObjectClass_jni_ <y
else.
  assert. ''-.@-:y [ 'jniStaticField'
  class=. './' charsub }.^:('L'={.) y -. ';'
  jnicheck cls=. FindClass_jni_ <class
end.
z=. rt jniCallField_jni_ 1;y;cls
DeleteLocalRef_jni_ <cls
z
:
rt=. m
if. 1 4 e.~ 3!:0 y do.
  assert. 0-.@-:y [ 'jniStaticField'
  jnicheck cls=. GetObjectClass_jni_ <y
else.
  assert. ''-.@-:y [ 'jniStaticField'
  class=. './' charsub }.^:('L'={.) y -. ';'
  jnicheck cls=. FindClass_jni_ <class
end.
rt jniCallField_jni_ (1;y;cls), boxxopen x
DeleteLocalRef_jni_ <cls
EMPTY
)

jniCallField=: 4 : 0
'field sig'=. <;._1 ' ', deb x
sig=. jnisig_addsep sig
'attr obj cls'=. 3{.y
static=. {.attr
y=. 3}.y
assert. 1=+/'#'=sig [ 'jniCallField'
rt=. sig-.'#'
jnicheck mid=. GetFieldID`GetStaticFieldID@.static cls;field;rt
if. static do. obj=. cls end.
if. 0=#y do.
  if. '[' e. rt do.
    jnicheck rc=. ('x x x x ') ((static{ID_GetObjectField,ID_GetStaticObjectField) jnivararg) (obj ; mid)
  else.
    select. {.rt
    case. 'V' do. jnicheck rc=. ('x x x x ') ((static{ID_GetVoidField,ID_GetStaticVoidField) jnivararg) (obj ; mid)
    case. 'L' do. jnicheck rc=. ('x x x x ') ((static{ID_GetObjectField,ID_GetStaticObjectField) jnivararg) (obj ; mid)
    case. 'B' do. jnicheck rc=. ('c x x x ') ((static{ID_GetByteField,ID_GetStaticByteField) jnivararg) (obj ; mid)
    case. 'Z' do. jnicheck rc=. ('i x x x ') ((static{ID_GetBooleanField,ID_GetStaticBooleanField) jnivararg) (obj ; mid)
    case. 'I' do. jnicheck rc=. ('i x x x ') ((static{ID_GetIntField,ID_GetStaticIntField) jnivararg) (obj ; mid)
    case. 'J' do. jnicheck rc=. ('l x x x ') ((static{ID_GetLongField,ID_GetStaticLongField) jnivararg) (obj ; mid)
    case. 'S' do. jnicheck rc=. ('s x x x ') ((static{ID_GetShortField,ID_GetStaticShortField) jnivararg) (obj ; mid)
    case. 'F' do. jnicheck rc=. ('f x x x ') ((static{ID_GetFloatField,ID_GetStaticFloatField) jnivararg) (obj ; mid)
    case. 'D' do. jnicheck rc=. ('d x x x ') ((static{ID_GetDoubleField,ID_GetStaticDoubleField) jnivararg) (obj ; mid)
    case. 'C' do. jnicheck rc=. ('w x x x ') ((static{ID_GetCharField,ID_GetStaticCharField) jnivararg) (obj ; mid)
    case. do. assert. 0 [ 'jniCallField'
    end.
  end.
else.
  if. '[' e. rt do.
    jnicheck rc=. ('x x x x ', jnisig_x15 sig) ((static{ID_SetObjectField,ID_SetStaticObjectField) jnivararg) (obj ; mid), sig jnisig_arg y
  else.
    select. {.rt
    case. 'V' do. jnicheck rc=. ('x x x x ', jnisig_x15 sig) ((static{ID_SetVoidField,ID_SetStaticVoidField) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'L' do. jnicheck rc=. ('x x x x ', jnisig_x15 sig) ((static{ID_SetObjectField,ID_SetStaticObjectField) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'B' do. jnicheck rc=. ('c x x x ', jnisig_x15 sig) ((static{ID_SetByteField,ID_SetStaticByteField) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'Z' do. jnicheck rc=. ('i x x x ', jnisig_x15 sig) ((static{ID_SetBooleanField,ID_SetStaticBooleanField) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'I' do. jnicheck rc=. ('i x x x ', jnisig_x15 sig) ((static{ID_SetIntField,ID_SetStaticIntField) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'J' do. jnicheck rc=. ('l x x x ', jnisig_x15 sig) ((static{ID_SetLongField,ID_SetStaticLongField) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'S' do. jnicheck rc=. ('s x x x ', jnisig_x15 sig) ((static{ID_SetShortField,ID_SetStaticShortField) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'F' do. jnicheck rc=. ('f x x x ', jnisig_x15 sig) ((static{ID_SetFloatField,ID_SetStaticFloatField) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'D' do. jnicheck rc=. ('d x x x ', jnisig_x15 sig) ((static{ID_SetDoubleField,ID_SetStaticDoubleField) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'C' do. jnicheck rc=. ('w x x x ', jnisig_x15 sig) ((static{ID_SetCharField,ID_SetStaticCharField) jnivararg) (obj ; mid), sig jnisig_arg y
    case. do. assert. 0 [ 'jniCallField'
    end.
  end.
end.
rc
)
jniNewObject=: 4 : 0
if. ' ' e. y do.
  'class sig'=. <;._1 ' ', deb y
else.
  class=. y [ sig=. '()V'
end.
if. ')' -.@e. sig do. sig=. '(',sig,')V' end.
class=. './' charsub }.^:('L'={.) class -. ';'
jnicheck cls=. FindClass_jni_ <class
assert. 0~:cls [ 'jniNewObjet'
rc=. ('<init> ',sig) jniCall_jni_ (boxxopen x),~ 1 0 0;0;cls
DeleteLocalRef_jni_ <cls
rc
)
jniMethod=: 1 : 0
:
assert. 0 4 e.~ 3!:0 y [ 'jniMethod'
assert. 0-.@-:y [ 'jniMethod'
jnicheck cls=. GetObjectClass_jni_ <y
assert. 0~:cls [ 'jniMethod'
rc=. m jniCall_jni_ (boxxopen x),~ 2 0 0;y;cls
DeleteLocalRef_jni_ <cls
rc
)

jniStaticMethod=: 1 : 0
:
if. 1 4 e.~ 3!:0 y do.
  assert. 0-.@-:y [ 'jniStaticMethod'
  jnicheck cls=. GetObjectClass_jni_ <y
else.
  assert. ''-.@-:y [ 'jniStaticMethod'
  class=. './' charsub }.^:('L'={.) y -. ';'
  jnicheck cls=. FindClass_jni_ <class
end.
assert. 0~:cls [ 'jniStaticMethod'
rc=. m jniCall_jni_ (boxxopen x),~ 2 1 0;y;cls
DeleteLocalRef_jni_ <cls
rc
)
jniCall=: 4 : 0

'method proto'=. <;._1 ' ', deb x
sig=. jnisig_addsep }. ({.~ i.&')') proto
rt=. }. (}.~ i.&')') proto

'attr obj cls'=. 3{.y
'member static nonvirtual'=. attr
y=. 3}.y
assert. (+/'#'=sig) = #y [ 'jniCall'

str=. stri=. 0$0
jnicheck mid=. GetMethodID`GetStaticMethodID@.static cls;method;proto-.'#'
if. 1 e. s1=. (<'Ljava/lang/String;') = <;._1 sig do.
  for_i. I. s1 do.
    if. 2 131072 e.~ 3!:0 y1=. i{::y do.
      str=. str, <NewStringUTF < 8&u: y1
      stri=. stri, i
    end.
  end.
  if. #stri do. y=. str stri}y end.
end.
if. '<init>'-:method do.
  jnicheck rc=. ('x x x x ', jnisig_x15 sig) (ID_NewObject jnivararg) (cls ; mid), sig jnisig_arg y
else.
  if. static do. obj=. cls end.
  if. '[' e. rt do.
    jnicheck rc=. ('x x x x ', jnisig_x15 sig) ((static{ID_CallObjectMethod,ID_CallStaticObjectMethod) jnivararg) (obj ; mid), sig jnisig_arg y
  else.
    select. {.rt
    case. 'V' do. jnicheck rc=. ('x x x x ', jnisig_x15 sig) ((static{ID_CallVoidMethod,ID_CallStaticVoidMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'L' do. jnicheck rc=. ('x x x x ', jnisig_x15 sig) ((static{ID_CallObjectMethod,ID_CallStaticObjectMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'B' do. jnicheck rc=. ('c x x x ', jnisig_x15 sig) ((static{ID_CallByteMethod,ID_CallStaticByteMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'Z' do. jnicheck rc=. ('i x x x ', jnisig_x15 sig) ((static{ID_CallBooleanMethod,ID_CallStaticBooleanMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'I' do. jnicheck rc=. ('i x x x ', jnisig_x15 sig) ((static{ID_CallIntMethod,ID_CallStaticIntMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'J' do. jnicheck rc=. ('l x x x ', jnisig_x15 sig) ((static{ID_CallLongMethod,ID_CallStaticLongMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'S' do. jnicheck rc=. ('s x x x ', jnisig_x15 sig) ((static{ID_CallShortMethod,ID_CallStaticShortMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'F' do. jnicheck rc=. ('f x x x ', jnisig_x15 sig) ((static{ID_CallFloatMethod,ID_CallStaticFloatMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'D' do. jnicheck rc=. ('d x x x ', jnisig_x15 sig) ((static{ID_CallDoubleMethod,ID_CallStaticDoubleMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. 'C' do. jnicheck rc=. ('w x x x ', jnisig_x15 sig) ((static{ID_CallCharMethod,ID_CallStaticCharMethod) jnivararg) (obj ; mid), sig jnisig_arg y
    case. do. assert. 0 [ 'jniCall'
    end.
  end.
end.
for_js. str do. DeleteLocalRef js end.
rc
)
