require 'gtk gl3'
3 : 0''
if. IFUNIX do.
  require '~addons/api/glx/glx.ijs'
  require '~addons/api/x11/x11.ijs'
end.
''
)

coclass 'jzopengl'

OsMesa=: IFWIN>IFWINE

3 : 0''
coinsert 'jgl3'
if. IFUNIX do.
  coinsert 'glx x11'
else.
  OBJ_BITMAP=: 7
  SRCCOPY=: 16bcc0020
  SIZEBITMAP=: 24
  DIB_RGB_COLORS=: 0

  BitBlt=: 'gdi32 BitBlt i x i i i i x i i i'&(15!:0)
  ChoosePixelFormat=: 'gdi32 ChoosePixelFormat > i x *c'&(15!:0)
  CreateCompatibleBitmap=: 'gdi32 CreateCompatibleBitmap > x x i i'&(15!:0)
  CreateCompatibleDC=: 'gdi32 CreateCompatibleDC > x x'&(15!:0)
  CreateDIBSection=: 'gdi32 CreateDIBSection x x *c i *x x i'&(15!:0)
  CreateFont=: 'gdi32 CreateFontA x i i i i i i i i i i i i i *c'&(15!:0)
  DeleteDC=: 'gdi32 DeleteDC > i x'&(15!:0)
  ResetDC=: 'gdi32 ResetDC > i x'&(15!:0)
  DeleteObject=: 'gdi32 DeleteObject > i x'&(15!:0)
  GetCurrentObject=: 'gdi32 GetCurrentObject > x x i'&(15!:0)
  GetObject=: 'gdi32 GetObjectW > i x i x'&(15!:0)
  GetDC=: 'user32 GetDC > x x'&(15!:0)
  ReleaseDC=: 'user32 ReleaseDC > i x x'&(15!:0)
  SelectObject=: 'gdi32 SelectObject > x x x'&(15!:0)
  SetPixelFormat=: 'gdi32 SetPixelFormat > i x i *c'&(15!:0)
  SwapBuffers=: 'gdi32 SwapBuffers > i x'&(15!:0)

  wglCreateContext=: 'opengl32.dll wglCreateContext > x x'&(15!:0)
  wglDeleteContext=: 'opengl32.dll wglDeleteContext > i x'&(15!:0)
  wglGetCurrentContext=: 'opengl32.dll wglGetCurrentContext > x'&(15!:0)
  wglGetCurrentDC=: 'opengl32.dll wglGetCurrentDC > x'&(15!:0)
  wglMakeCurrent=: 'opengl32.dll wglMakeCurrent > i x x'&(15!:0)
  wglSwapBuffers=: 'opengl32.dll wglSwapBuffers > i x'&(15!:0)
  wglUseFontBitmapsA=: 'opengl32.dll wglUseFontBitmapsA i x i i i'&(15!:0)
  wglUseFontOutlinesA=: 'opengl32.dll wglUseFontOutlinesA i x i i i f f i *f'&(15!:0)
end.
''
)

create=: 3 : 0
ctxlist=: i.0 3
''
)

destroy=: 3 : 0
if. #ctxlist do. free"0 {."1 ctxlist end.
codestroy''
)
current=: 3 : 0
assert. ''-:$y
if. 0=y do.
  if. IFUNIX do.
    xdisplay=. gdk_x11_get_default_xdisplay_jgtk_ ''
    glXMakeCurrent xdisplay, 0 0
  else.
    wglMakeCurrent 0 0
  end.
  0 return.
end.
if. 0= ctx=. getglctx y do. ctx return. end.
window=. getGtkWidgetWindow_jgtk_ y
if. IFUNIX do.
  if. 3=GTKVER_j_ do.
    xdisplay=. gdk_x11_get_default_xdisplay_jgtk_ ''
    xid=. gdk_x11_window_get_xid_jgtk_ window
  else.
    xdisplay=. gdk_x11_drawable_get_xdisplay_jgtk_ window
    xid=. gdk_x11_drawable_get_xid_jgtk_ window
  end.
  res=. glXMakeCurrent xdisplay, xid, ctx
else.
  hdc=. getglhdc y
  res=. wglMakeCurrent hdc, ctx
end.
(0~:res){0,ctx
)
alloc=: 3 : 0
assert. ''-:$y
assert. 0~:y
if. 0~: ctx=. getglctx y do. ctx return. end.

gtk_widget_set_double_buffered_jgtk_ y, 0
window=. getGtkWidgetWindow_jgtk_ y
if. 0= window do. 0 return. end.
hdc=. 0
if. IFUNIX do.
  attributes=. GLX_RGBA, GLX_RED_SIZE, 1, GLX_GREEN_SIZE, 1, GLX_BLUE_SIZE, 1, GLX_DOUBLEBUFFER, 1, GLX_DEPTH_SIZE, 12, GLX_NONE

  xdisplay=. gdk_x11_get_default_xdisplay_jgtk_ ''
  if. 0=xdisplay do. 0 return. end.
  xscreen=. XDefaultScreen xdisplay    
  xvisual=. glXChooseVisual xdisplay; xscreen; attributes
  if. 0= xvisual do. 0 return. end.

  if. 0= #ctxlist do.
    ctx=. glXCreateContext xdisplay; xvisual; 0; 1
  else.
    ctx=. glXCreateContext xdisplay; xvisual; (1{{.ctxlist); 1
  end.

  XFree xvisual
else.
  hwnd=. gdk_win32_drawable_get_handle_jgtk_ window
  if. 0= hwnd do. 0 return. end.
  if. OsMesa do.
    wh=. _2{. getGtkWidgetAllocation_jgtk_ y
    hdc0=. GetDC hwnd
    if. 0= hdc0 do. 0 return. end.
    hdc=. CreateCompatibleDC hdc0
    hbm=. CreateCompatibleBitmap hdc0, wh
    ReleaseDC hwnd, hdc0
    bminfo=. mema SIZEBITMAP
    GetObject hbm, SIZEBITMAP, bminfo
    bits=. _1 ic memr bminfo,18,2,2
    memf bminfo
    if. 0~: old=. SelectObject hdc, hbm do. DeleteObject old end.
    if. -.IFWINE do. wglMakeCurrent hdc, 0 end.    
    if. res=. ChooseSetPixelFormat hdc,bits do.
      ctx=. wglCreateContext hdc
    else.
      DeleteObject hbm
      DeleteDC hdc
      ctx=. 0
    end.
  else.
    hdc=. GetDC hwnd
    if. 0= hdc do. 0 return. end.
    if. -.IFWINE do. wglMakeCurrent hdc, 0 end.    
    if. res=. ChooseSetPixelFormat hdc,24 do.
      ctx=. wglCreateContext hdc
    else.
      ReleaseDC hwnd, hdc
      ctx=. 0
    end.
  end.
end.

if. 0~:ctx do.
  ctxlist=: ctxlist, y, ctx, hdc
end.
ctx
)
free=: 3 : 0
i=. _1 [ ctx=. area=. 0
if. ''-:y do.
  if. IFUNIX do.
    ctx=. glXGetCurrentContext''
  else.
    ctx=. wglGetCurrentContext''
  end.
  area=. getglarea ctx
else.
  assert. ''-:$y
  ctx=. getglctx area=. y
end.
if. ctx *. area do.
  window=. getGtkWidgetWindow_jgtk_ area
  if. IFUNIX do.
    if. 3=GTKVER_j_ do.
      xdisplay=. gdk_x11_get_default_xdisplay_jgtk_ ''
    else.
      xdisplay=. gdk_x11_drawable_get_xdisplay_jgtk_ window
    end.
    glXDestroyContext xdisplay, ctx
    glXMakeCurrent xdisplay, 0 0
  else.
    hwnd=. gdk_win32_drawable_get_handle_jgtk_ window
    hdc=. getglhdc area
    if. OsMesa do.
      wglDeleteContext ctx
      if. 0~: hbm=. GetCurrentObject hdc, OBJ_BITMAP do. DeleteObject hbm end.
      DeleteDC hdc
    else.
      if. -.IFWINE do. wglMakeCurrent 0 0 end.    
      wglDeleteContext ctx
      ReleaseDC hwnd, hdc
    end.
  end.
  i=. area i.~ {."1 ctxlist
  ctxlist=: (<<<i){ctxlist
  assert. 0=getglctx area
  1
else.
  0
end.
)
removectx=: 3 : 0
ctx=. getglctx area=. y
if. ctx *. area do.
  i=. area i.~ {."1 ctxlist
  ctxlist=: (<<<i){ctxlist
  assert. 0=getglctx area
end.
EMPTY
)
show=: 3 : 0
res=. 0
if. ''-:y do.
  if. IFUNIX do.
    ctx=. glXGetCurrentContext''
  else.
    ctx=. wglGetCurrentContext''
  end.
  if. 0~: area=. getglarea ctx do.
    window=. getGtkWidgetWindow_jgtk_ area
    if. IFUNIX do.
      xdisplay=. gdk_x11_get_default_xdisplay_jgtk_ ''
      xid=. glXGetCurrentDrawable''
      res=. glXSwapBuffers xdisplay, xid
    else.
      hdc=. getglhdc area
      xywh=. getGtkWidgetAllocation_jgtk_ area
      if. OsMesa do.
        window=. getGtkWidgetWindow_jgtk_ area
        hwnd=. gdk_win32_drawable_get_handle_jgtk_ window
        hdc0=. GetDC hwnd
        BitBlt hdc0, xywh, hdc, 0, 0, SRCCOPY
        ReleaseDC hwnd, hdc0
      else.
        res=. SwapBuffers hdc
      end.
    end.
  end.
else.
  if. 0~: ctx=. getglctx area=. y do.
    window=. getGtkWidgetWindow_jgtk_ area
    if. IFUNIX do.
      if. 3=GTKVER_j_ do.
        xdisplay=. gdk_x11_get_default_xdisplay_jgtk_ ''
        xid=. gdk_x11_window_get_xid_jgtk_ window
      else.
        xdisplay=. gdk_x11_drawable_get_xdisplay_jgtk_ window
        xid=. gdk_x11_drawable_get_xid_jgtk_ window
      end.
      res=. glXSwapBuffers xdisplay, xid
    else.
      hdc=. getglhdc area
      xywh=. getGtkWidgetAllocation_jgtk_ area
      if. OsMesa do.
        window=. getGtkWidgetWindow_jgtk_ area
        hwnd=. gdk_win32_drawable_get_handle_jgtk_ window
        hdc0=. GetDC hwnd
        BitBlt hdc0, xywh, hdc, 0, 0, SRCCOPY
        ReleaseDC hwnd, hdc0
      else.
        res=. SwapBuffers hdc
      end.
    end.
  end.
end.
if. 0~:res do. ctx else. 0 end.
)
getglarea=: 3 : 0
assert. ''-:$y
if. (0~: #ctxlist) *. y e. 1&{"1 ctxlist do.
  area=. 0{ctxlist{~ i=. y i.~ 1&{"1 ctxlist
else.
  0
end.
)
getglctx=: 3 : 0
assert. ''-:$y
if. (0~: #ctxlist) *. y e. {."1 ctxlist do.
  ctx=. 1{ctxlist{~ i=. y i.~ {."1 ctxlist
else.
  0
end.
)
getglhdc=: 3 : 0
assert. ''-:$y
if. (0~: #ctxlist) *. y e. {."1 ctxlist do.
  hdc=. 2{ctxlist{~ i=. y i.~ {."1 ctxlist
else.
  0
end.
)

3 : 0''
if. IF64 do.
  ALPHA=: 0{_3 ic 0 0 0 255 255 255 255 255{a.
else.
  ALPHA=: 0{_2 ic 0 0 0 255{a.
end.
''
)
NOTALPHA=: 0{_2 ic 255 255 255 0{a.
AND=: 17 b.
getpixel=: 3 : 0
area=. y
z=. 0$0
if. ''-:y do.
  if. IFUNIX do.
    ctx=. glXGetCurrentContext''
  else.
    ctx=. wglGetCurrentContext''
  end.
  area=. getglarea ctx
end.
if. 0~:area do.
  window=. getGtkWidgetWindow_jgtk_ area
  if. 0~:window do.
    'w h'=. _2{. getGtkWidgetAllocation_jgtk_ area
    if. 3=GTKVER_j_ do.
      pixbuf=. gdk_pixbuf_get_from_window_jgtk_ pixbuf,window,0,0,w,h
      if. 0= pixbuf do. z return. end.
    else.
      pixbuf=. gdk_pixbuf_new_jgtk_ GDK_COLORSPACE_RGB_jgtk_,1,8,w,h
      gdk_pixbuf_get_from_drawable_jgtk_ pixbuf,window,GDK_COLORSPACE_RGB_jgtk_,0,0,0,0,w,h
    end.
    ad=. gdk_pixbuf_get_pixels_jgtk_ pixbuf
    if. IF64 do.
      r=. _2 ic memr ad,0,(w*h*4),JCHAR
    else.
      r=. memr ad,0,(w*h),JINT
    end.
    g_object_unref_jgtk_ pixbuf
    z=. r AND NOTALPHA
  end.
end.
z
)
saveimg=: 4 : 0
'type fl q'=. 3{.y,a:
if. 'jpg'-:type=. tolower type do. type=. 'jpeg' end.
type=. type, (type-:'tif')#'f'
res=. 0
area=. y
z=. 0$0
if. ''-:y do.
  if. IFUNIX do.
    ctx=. glXGetCurrentContext''
  else.
    ctx=. wglGetCurrentContext''
  end.
  area=. getglarea ctx
end.
if. 0~:area do.
  window=. getGtkWidgetWindow_jgtk_ area
  if. 0~:window do.
    'w h'=. _2{. getGtkWidgetAllocation_jgtk_ area
    if. 3=GTKVER_j_ do.
      pixbuf=. gdk_pixbuf_get_from_window_jgtk_ pixbuf,window,0,0,w,h
      if. 0= pixbuf do. res return. end.
    else.
      pixbuf=. gdk_pixbuf_new_jgtk_ GDK_COLORSPACE_RGB_jgtk_,1,8,w,h
      gdk_pixbuf_get_from_drawable_jgtk_ pixbuf,window,GDK_COLORSPACE_RGB_jgtk_,0,0,0,0,w,h
    end.
    if. 'png'-:type do.
      if. 2=#y do.
        res=. gdk_pixbuf_save_jgtk_ pixbuf;fl;type;0;0
      else.
        q=. <. 9 <. 0 >. q
        res=. gdk_pixbuf_save_2_jgtk_ pixbuf;fl;type;0;'compression';(":q);0
      end.
    elseif. 'jpeg'-:type do.
      if. 2=#y do.
        res=. gdk_pixbuf_save_jgtk_ pixbuf;fl;type;0;0
      else.
        q=. <. 100 <. 0 >. q
        res=. gdk_pixbuf_save_2_jgtk_ pixbuf;fl;type;0;'quality';(":q);0
      end.
    elseif. do.
      res=. gdk_pixbuf_save_jgtk_ pixbuf;fl;type;0;0
    end.
    g_object_unref_jgtk_ pixbuf
  end.
end.
res
)
glpixels=: 0:
glaUseFontBitmaps=: 4 : 0
if. IFUNIX do.
else.
  'name size weight italic'=. 4 {. x,0;0
  hdc=. wglGetCurrentDC''
  if. 0~:hdc do.
    att=. ;/(weight,italic) 3 4 } 12 # 0
    font=. >{.CreateFont (<size),att,<name 
    if. 0~:font do.
      oldfont=. >{.SelectObject hdc;font
      r=. >{.wglUseFontBitmapsA hdc;<"0 y
      SelectObject hdc;oldfont
      DeleteObject font
      r return.
    end.
  end.
end.
0
)

glaUseFontOutlines=: 4 : 0
if. IFUNIX do.
else.
  'name size weight italic'=. 4 {. x,0;0
  hdc=. wglGetCurrentDC''
  if. 0~:hdc do.
    att=. ;/(weight,italic) 3 4 } 12 # 0
    font=. >{.CreateFont (<size),att,<name 
    if. 0~:font do.
      oldfont=. >{.SelectObject hdc;font
      r=. >{.z=. wglUseFontOutlinesA hdc;(<"0 y),<(6*1{y)$1.1
      SelectObject hdc;oldfont
      DeleteObject font
      if. 1=r do. >{:z return. end.
    end.
  end.
end.
0
)
ChooseSetPixelFormat=: 3 : 0
'hdc color'=. y
PFD_DOUBLEBUFFER=: 1
PFD_DRAW_TO_WINDOW=: 4
PFD_DRAW_TO_BITMAP=: 8
PFD_SUPPORT_OPENGL=: 32
PFD_TYPE_RGBA=: 0
PFD_MAIN_PLANE=: 0
a=. 40{.40 00 01 00, ((OsMesa{PFD_DOUBLEBUFFER,0)+PFD_SUPPORT_OPENGL+OsMesa{PFD_DRAW_TO_WINDOW,PFD_DRAW_TO_BITMAP), 00 00 00 00, color
a=. 32 (23})a 
pfd=. 40{.a{a.
if. 0= iPixelFormat=. ChoosePixelFormat hdc; pfd do.
  smoutput 'ChoosePixelFormat Failed'
  0 return.
end.
if. 0= SetPixelFormat hdc; iPixelFormat; pfd do.
  smoutput 'SetPixelFormat Failed'
  0 return.
end.
1
)

