NB. ignore xml file

NB. crunch image files under drawable... folders
NB. retrun a table with rows of (icon id);drawable
NB. y : full path name of the res folder
crunch=: 3 : 0
path=. }:^:('/'={:) y
rs=. 0 0$<''
for_dw. 1!:0 path, '/drawable*' do.
  dpi=. 8}. d=. 0{::dw
  dw1=. path, '/', d
  for_fn. 1!:0 dw1, '/*' do.
    dw2=. dw1, '/', d=. 0{::fn
    if. '.xml'-: (}.~ i:&'.') d do. continue. end.
    id=. dpi,~ ({.~ i:&'.') d
    try.
      jniCheck bm=. 'android.graphics.BitmapFactory' ('decodeFile (LString;)LBitmap;' jniStaticMethod)~ <dw2
      rs=. rs, id;NewGlobalRef <bm
      jniCheck DeleteLocalRef <bm
    catch.
      ExceptionClear''
    end.
  end.
end.
rs
)

NB. example to get bitmap from data
NB. pic=. 1!:1 <file
NB. ba=. jniCheck NewByteArray <#pic
NB. jniCheck SetByteArrayRegion ba;0;(#pic);pic
NB. bm=. jniCheck 'android.graphics.BitmapFactory' ('decodeByteArray ([BII)LBitmap;' jniStaticMethod)~ ba;0;#pic
NB. jniCheck DeleteLocalRef <ba
