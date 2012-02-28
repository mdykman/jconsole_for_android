NB. Script to create
NB. raster images of text
NB. used by Prevare.ijs
NB. Cliff Reiter
NB. July 2002
NB. modified for J6.01, Sept 2006

NB. locale for image3 addon
coinsert 'ima3'
coinsert 'jgl2'
coclass 'ima3'

NB. Load required addon/media scripts
require 'gl2'

NB. path to the addon library (dll, so) needs to be correct.
dir_sep=:PATHSEP_j_
addon_path=: jpath '~addons/media/image3/'

NB. require the image3 script
require addon_path,'image3.ijs'

NB. set global parameters for the form
ti_size=:1024 768 NB. 1600 1200
ti_font=:'"Times New Roman"'
ti_color=:,:3#0

TEXTIMAGE0=: 0 : 0
pc textimage;
menupop "&File";
menu new "&New" "" "" "";
menu save "&Save" "" "" "";
menusep;
menu exit "&Exit" "" "" "";
menupopz;
menupop "&Size";
menu smenu0 "Image Width/Height 1&024 768" "" "" "";
menu smenu1 "Image Width/Height &1600 1200" "" "" "";
menu smenu2 "Image Width/Height &2048 1536" "" "" "";
menu smenu3 "&Set Image Width/Height" "" "" "";
menupopz;
menupop "F&ont";
menu fmenu0 "&Times New Roman" "" "" "";
menu fmenu1 "&Courier New" "" "" "";
menu fmenu2 "Set &Font" "" "" "";
menusep;
menu fmenu3 "&Set Line Color List" "" "" "";
menupopz;
cc im isigraph;
;setxywhx im 130 1  
)
TEXTIMAGE1=:0 : 0
;
xywh 8 58 42 31;cc tx editm ws_border es_autovscroll;
xywh 13 4 34 11;cc new button;cn "New";
xywh 13 21 34 11;cc save button;cn "Save";
xywh 13 38 34 11;cc draw button;cn "Draw Text";
pas 1 1;pcenter;
rem form end;
)

textimage_run=: 3 : 0
if. _1=(4!:0)<'ti_save_fn' do.
  try. ti_save_fn=: (path_nm >{:im_list),'text.png'
  catch. ti_save_fn=: 'text.png' end.
  end.
ti_paint ''
)


ti_paint=:3 : 0
wd :: 0: 'psel textimage;pclose;'
wd TEXTIMAGE0,(":<.ti_size),TEXTIMAGE1
NB. initialize form here
try. 0<#tx catch. tx=:'' end.
wd 'set tx "',tx,'";'
wd 'pshow;'
)

textimage_close=: 3 : 0
wd'pclose;'
)

textimage_exit_button=: 3 : 0
textimage_close''
)

textimage_draw_button=: 3 : 0
n0=.#tx_lines=:<;._2 tx,LF
glclear ''
glsel im
glfont ti_font,": 100
wh100=. glqextent 'Tsing'
fs=.<.(100*{:ti_size)%n0*{:wh100
glfont ti_font,":fs
((n0$ti_color);"1]10,.(i.n0)*n0%~{:ti_size) drawline"1 0 tx_lines
glpaint ''
)

drawline=:4 : 0
glrgb >{.x
gltextcolor ''
gltextxy >{:x
gltext >y
)

textimage_save_button=: 3 : 0
nm=:wd 'mbsave  "Save Text as PNG, BMP, or JPG" "',(path_nm ti_save_fn),'"  "',(nx_fn short_fn ti_save_fn),'"  "Images(*.png;*.bmp;*.jpg)|*.png;*.bmp;*.jpg;*.jpeg|*.png|*.png|*.bmp|*.bmp|*.jpg|*.jpg;*.jpeg"'
wd 'psel textimage'
glsel 'im'
pd=.glqpixels 0 0,ti_size
(256 256 256#:(|.ti_size)$pd)write_image nm
if. 0<#nm do. 
  if. try. -.(<nm) e. im_list catch. 0 end.
    do.
    im_list_ima3_=:im_list,<nm
    paint_form ''
  end.
  ti_save_fn=:nm
end.
)

textimage_new_button=: 3 : 0
tx=:''
wd 'set tx "',tx,'";'
tx_lines=:i.0
glclear''
)

textimage_smenu0_button=:3 : 'ti_paint ti_size=:1024 768'
textimage_smenu1_button=:3 : 'ti_paint ti_size=:1600 1200'
textimage_smenu2_button=:3 : 'ti_paint ti_size=:2048 1536'

textimage_smenu3_button=:3 : 0
wd 'pc sm3 closeok;pn "";xywh 2 2 75 11;cc ss static;cn "Set width/height of image:";'
wd 'xywh 85 8 22 12;cc set button;cn "Set";'
wd 'xywh 2 13 75 15;cc sm3ed edit ws_border es_autohscroll;'
wd 'set sm3ed "',(":ti_size),'";setfocus sm3ed;setselect sm3ed 0 10'
wd 'pas 6 2;pshow;'
)

sm3_set_button=:3 : 0
if. 0<#sm3ed do.
  ti_size=:". sm3ed
  wd 'pclose;'
  wd 'psel textimage;'
  wd 'pclose;'
  ti_paint ''
  end.
)

textimage_fmenu0_button=:3 : 0
ti_font=:'"Times New Roman"'
)
textimage_fmenu1_button=:3 : 0
ti_font=:'"Courier New"'
)
textimage_fmenu2_button=:3 : 0
ti_font=:'"',~>{.<;.1 wd 'mbfont'
)
textimage_fmenu3_button=:3 : 0
wd 'pc fm3 closeok;pn "";xywh 2 2 75 11;cc ss static;cn "Set text line color list:";'
wd 'xywh 47 18 22 12;cc set button;cn "Set";'
wd 'xywh 2 13 40 30;cc fm3ed editm ws_border es_autovscroll;'
wd 'set fm3ed "',(}:,LF,"1~":ti_color),'";setfocus fm3ed;setselect fm3ed 0 10'
wd 'pas 6 2;pshow;'
)

fm3_set_button=:3 : 0
if. 0<#fm3ed do.
  ti_color=:".;._2 fm3ed,LF
  wd 'pclose;'
  wd 'psel textimage;'
  wd 'pclose;'
  ti_paint ''
  end.
)
