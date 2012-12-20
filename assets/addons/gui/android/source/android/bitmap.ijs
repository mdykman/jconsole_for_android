
NB. =========================================================
OR=: 23 b./
NOTALPHA=: 16bffffff
ALPHA=: 0 (26 b.) NOTALPHA

NB. =========================================================
NB. pixbuf utilities
NB. =========================================================
NB. new verb for reading file images to argb matrix using android
readimg=: 3 : 0

jniCheck bm=. 'android.graphics.BitmapFactory' ('decodeFile (LString;)LBitmap;' jniStaticMethod)~ <y
if. 0=bm do. 0 0$0 return. end.
jniCheck w=. bm ('getWidth ()I' jniMethod)~ ''
jniCheck h=. bm ('getHeight ()I' jniMethod)~ ''
d=. (w*h)#2-2

jniCheck colors=. NewIntArray <#d
NB. public void getPixels (int[] pixels, int offset, int stride, int x, int y, int width, int height)
jniCheck bm ('getPixels ([IIIIIII)V' jniMethod)~ colors;0;w;0;0;w;h
jniCheck GetIntArrayRegion colors;0;(#d);d

NB. cleanup
jniCheck DeleteLocalRef"0 colors;bm

d=. fliprgb^:(-.RGBSEQ_j_) d (17 b.) NOTALPHA
(h,w)$d
)

NB. =========================================================
NB. new verb for reading file images from memory to argb matrix using android
getimg=: 3 : 0
ba=. jniCheck NewByteArray <#y
jniCheck SetByteArrayRegion ba;0;(#y);y
bm=. jniCheck 'android.graphics.BitmapFactory' ('decodeByteArray ([BII)LBitmap;' jniStaticMethod)~ ba;0;#y
jniCheck DeleteLocalRef <ba
if. 0=bm do. 0 0$0 return. end.

jniCheck bm=. 'android.graphics.BitmapFactory' ('decodeFile (LString;)LBitmap;' jniStaticMethod)~ <y
if. 0=bm do. 0 0$0 return. end.
jniCheck w=. bm ('getWidth ()I' jniMethod)~ ''
jniCheck h=. bm ('getHeight ()I' jniMethod)~ ''
d=. (w*h)#2-2

jniCheck colors=. NewIntArray <#d
NB. public void getPixels (int[] pixels, int offset, int stride, int x, int y, int width, int height)
jniCheck bm ('getPixels ([IIIIIII)V' jniMethod)~ colors;0;w;0;0;w;h
jniCheck GetIntArrayRegion colors;0;(#d);d

NB. cleanup
jniCheck DeleteLocalRef"0 colors;bm

d=. fliprgb^:(-.RGBSEQ_j_) d (17 b.) NOTALPHA
(h,w)$d
)

CompressFormat_JPEG=: 0
CompressFormat_PNG=: 1
CompressFormat_WEBP=: 2

NB. =========================================================
NB. write image data to file
NB. x rgb matrix
NB. y filename [ ; 'jpeg|png|ico|bmp' [ ; 'quality|compression' ; '[0,100]|[0,9]' ]]
writeimg=: 4 : 0
'h w'=. $x
d=. ,x
if. 2> #y=. boxopen y do.
  f=. >@{.y
  type=. tolower }. (}.~ i:&'.') f
  opt=. ''
elseif. 2= #y do.
  f=. >@{.y
  type=. >1{y
  opt=. ''
elseif. do.
  f=. utf8 >@{.y
  type=. >1{y
  opt=. 2{.2}.y
  opt=. (":&.>1{opt) 1}opt
end.
qaulity=. 75
if. ('jpeg'-:type)+.('jpg'-:type) do. type=. CompressFormat_JPEG
elseif. 'png'-:type do. type=. CompressFormat_PNG
elseif. 'webp'-:type do. type=. CompressFormat_WEBP
elseif. do. EMPTY return.
end.
d=. fliprgb^:(RGBSEQ_j_) d
d=. d OR ALPHA
if. IF64 do. d=. 2 ic d end.
NB. create new pixbuf from data
NB. public static Bitmap createBitmap (int[] colors, int offset, int stride, int width, int height, Bitmap.Config config)
jniCheck colors=. NewIntArray <#d
jniCheck SetIntArrayRegion colors;0;(#d);d
jniCheck bm=. ('createBitmap ([IIIIILBitmap$Config;)LBitmap;' jniStaticMethod)~ colors;0;w;w;h;0
jniCheck DeleteLocalRef <ba
if. bm do.
  jniCheck bos=. '' jniNewObject 'ByteArrayOutputStream'
  jniCheck bm ('compress (IILOutputStream;)Z' jniMethod)~ type;quality;bos
  jniCheck bmc=. bos ('toByteArray ()[B' jniMethod)~ ''
  jniCheck fos=. (<f) jniNewObject 'FileOutputStream LString;'
  jniCheck fos ('write ([B)V' jniMethod)~ bmc
  jniCheck fos ('flush ()V' jniMethod)~ ''
  jniCheck fos ('close ()V' jniMethod)~ ''
  jniCheck DeleteLocalRef"0 bos;bmc;fos
end.
jniCheck DeleteLocalRef <bm
EMPTY
)

NB. =========================================================
NB. write image data to memory
NB. x rgb matrix
NB. y 'jpeg|png|ico|bmp' [ ; 'quality|compression' ; '[0,100]|[0,9]' ]
putimg=: 4 : 0
'h w'=. $x
d=. ,x
if. 2> #y=. boxopen y do.
  type=. >@{.y
  opt=. ''
elseif. do.
  type=. >@{.y
  opt=. 2{.}.y
  opt=. (":&.>1{opt) 1}opt
end.
if. 'jpg'-:type do. type=. 'jpeg'
elseif. 'tif'-:type do. type=. 'tiff'
end.
d=. fliprgb^:(RGBSEQ_j_) d
d=. d OR ALPHA
if. IF64 do. d=. 2 ic d end.
NB. create new pixbuf from data
NB. ad,cmap,alpha,bits,w,h,rowstride,destroyfn,fndata
buf=. gdk_pixbuf_new_from_data (15!:14<'d'),GDK_COLORSPACE_RGB,1,8,w,h,(4*w),0,0
NB. bufreport buf
rc=. 0
if. buf do.
  if. ''-:opt do.
NB. return 0 if fail
    rc=. gdk_pixbuf_save_to_buffer buf;(m=. ,_1);(s=. ,_1);type;0;0
  else.
    rc=. gdk_pixbuf_save_to_buffer_2 buf;(m=. ,_1);(s=. ,_1);type;0;opt,<0
  end.
  g_object_unref buf
end.
if. rc do.
  assert. 0~:m
  z=. memr m,0,s,2
  z [ g_free {.m
else.
  ''
end.
)
NB. =========================================================
clipreadimg=: 3 : 0
cb=. gtk_clipboard_get gdk_atom_intern 'CLIPBOARD';0
if. 0= buf=. gtk_clipboard_wait_for_image cb do. 0 0$0 return. end.
img=. gdk_pixbuf_add_alpha buf;0;0;0;0
assert. 0~:img
g_object_unref buf
ad=. gdk_pixbuf_get_pixels img
w=. gdk_pixbuf_get_width img
h=. gdk_pixbuf_get_height img
s=. gdk_pixbuf_get_rowstride img
assert. s=4*w
assert. 0~:ad
if. IF64 do.
  r=. _2 ic memr ad,0,(w*h*4),JCHAR
else.
  r=. memr ad,0,(w*h),JINT
end.
g_object_unref img
r=. fliprgb^:(RGBSEQ_j_) r (17 b.) NOTALPHA
(h,w)$r
)

NB. =========================================================
NB. TODO crashed on reading
clipwriteimg=: 3 : 0
'h w'=. $y
d=. ,y
d=. fliprgb^:(RGBSEQ_j_) d
d=. d OR ALPHA
if. IF64 do. d=. 2 ic d end.
NB. create new pixbuf from data
NB. ad,cmap,alpha,bits,w,h,rowstride,destroyfn,fndata
buf=. gdk_pixbuf_new_from_data (15!:14<'d'),GDK_COLORSPACE_RGB,1,8,w,h,(4*w),0,0
NB. bufreport buf

cb=. gtk_clipboard_get gdk_atom_intern 'CLIPBOARD';0
gtk_clipboard_set_image cb,buf
gtk_clipboard_store cb
g_object_unref buf
h,w
)


NB. =========================================================
NB. x pixmap
pixbufpx_setpixels=: 4 : 0
gtkpx=. x
'a b w h'=. 4{.y
d=. 4}.y
d=. fliprgb^:(RGBSEQ_j_) d
d=. d OR ALPHA
if. IF64 do. d=. 2 ic d end.
NB. create new pixbuf from data
NB. ad,cmap,alpha,bits,w,h,rowstride,destroyfn,fndata
buf=. gdk_pixbuf_new_from_data (15!:14<'d'),GDK_COLORSPACE_RGB,1,8,w,h,(4*w),0,0
NB. bufreport buf
if. buf do.
  gdk_draw_pixbuf gtkpx,0,buf,0,0,a,b,w,h,0,0,0
end.
g_object_unref buf
EMPTY
)

NB. =========================================================
NB. x cairo context
pixbufcr_setpixels=: 4 : 0
cr=. x
'a b w h'=. 4{.y
d=. 4}.y
d=. fliprgb^:(RGBSEQ_j_) d
d=. d OR ALPHA
if. IF64 do. d=. 2 ic d end.
NB. create new pixbuf from data
NB. ad,cmap,alpha,bits,w,h,rowstride,destroyfn,fndata
buf=. gdk_pixbuf_new_from_data (15!:14<'d'),GDK_COLORSPACE_RGB,1,8,w,h,(4*w),0,0
NB. bufreport buf
if. buf do.
  gdk_cairo_set_source_pixbuf cr; buf; a; b  NB. coord is double
  cairo_paint cr
end.
g_object_unref buf
EMPTY
)
