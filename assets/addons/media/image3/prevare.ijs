NB. Prevare.ijs defines a form that allows the
NB. previewing and preparation (rotation etc) of
NB. collections of images
NB. Based upon the J Image3 addon
NB. Cliff & Zach Reiter
NB. November 2002
NB. modified for J6.01, Sept 2006
NB.

NB. locale for image3 addon
coinsert 'ima3'
coinsert 'jgl2'
coclass  'ima3'

NB. path to the image3 addon library needs to be correct.
dir_sep=: PATHSEP_j_             NB. directory separator
addon_path=: jpath '~addons/media/image3/'
require addon_path,'html_gallery8.ijs'
require 'gl2'

tp_size=:400          NB. (temp_picture) view size
temp_thsz=: _400 _350 NB. thumbnail creation size
num_cols=: 3          NB. default number of columns in html_gallery
web_size=:1024 1024   NB. default web window resize
cd_label_size=:1600   NB. default cd label size

PVFORM0=: 0 : 0
pc pvform;
pn "Prevare: Preview and Prepare";
menupop "&Lists";
menu lmenu0 "&Add File to List" "" "" "";
menu lmenu1 "Add &Directory to List" "" "" "";
menusep;
menu lmenu2 "Add &File to Group" "" "" "";
menu lmenu3 "Full &List to Group" "" "" "";
menu lmenu4 "&Clear Group" "" "" "";
menupopz;
menupop "&Rotate/Flip";
menu pvmenu0 "&Rotate  90" "Ctrl+r" "" "";
menu pvmenu1 "R&otate 180" "" "" "";
menu pvmenu2 "Rotate 270" "Ctrl+&l" "" "";
menusep;
menu pvmenu3 "Flip &Vertical" "" "" "";
menu pvmenu4 "Flip &Horizontal" "" "" "";
menu pvmenu5 "&Transpose" "" "" "";
menupopz;
menupop "&Size";
menu omenu0 "View Size 300" "" "" "";
menu omenu1 "View Size 360" "" "" "";
menu omenu2 "View Size 400" "" "" "";
menu omenu3 "Set &View Size ..." "" "" "";
menusep;
menu omenu4 "Thumbnail Size 0" "" "" "";
menu omenu4a "Thumbnail Size _320 _280" "" "" "";
menu omenu5 "Thumbnail Size _400 _350" "" "" "";
menu omenu6 "Set &Thumbnail Size ..." "" "" "";
menupopz;
menupop "&Web";
menu omenu7 "Web Size &800 800" "" "" "";
menu omenu8 "Web Size &1024 1024" "" "" "";
menu omenu9 "Set &Web Size ..." "" "" "";
menusep;
menu omenu10 "&2 Columns in Gallery" "" "" "";
menu omenu11 "&3 Columns in Gallery" "" "" "";
menu omenu12 "&4 Columns in Gallery" "" "" "";
menu omenu13 "Set # &Columns in Gallery..." "" "" "";
menupopz;
menupop "&CD";
menu cdmenu0 "&1200 CD label size" "" "" "";
menu cdmenu1 "1&600 CD label size" "" "" "";
menu cdmenu2 "&2000 CD label size" "" "" "";
menu cdmenu3 "&Set CD label size..." "" "" "";
menusep;
menu cdmenu4 "Make Bitmap of &Text" "" "" "";
menu cdmenu5 "&Preview CD Label" "" "" "";
menu cdmenu6 "&Make CD Label" "" "" "";
menupopz;
menupop "&Help";
menu hmenu0 "Help" "" "" "";
menupopz;
)

MKPVFORM=: 3 : 0
le=.,&';'               NB. wd line end
bo=.80>.>. 3%~y-40     NB. button offset
bw=.bo<.150             NB. button width
lw=.200>.y<.360
z=.< 'cc temppic isigraph; setxywhx temppic 4 4 ',":2#y
z=.z,<'cc ims listbox ws_vscroll ws_hscroll; setxywhx ims ',": (8+y),4,lw,y
z=.z,<'cc sims listbox ws_vscroll ws_hscroll; setxywhx sims ',": (8+y),(10+y),lw,196

z=.z,<'cc rot0 button; cn "Rotate 90"; setxywhx rot0 ', ": 10, (10+y), bw, 40
z=.z,<'cc rot1 button; cn "Rotate 180"; setxywhx rot1 ',": 10, (60+y), bw, 40
z=.z,<'cc del  button; cn "Delete"; setxywhx del ',": 10, (110+y), bw, 40
z=.z,<'cc mktext button; cn "Make Text Image"; setxywhx mktext ', ": 10, (160+y), bw, 40

z=.z,<'cc rot2 button; cn "Rotate 270"; setxywhx rot2 ',": (20+bo),(10+y), bw, 40
z=.z,<'cc htmla button; cn "Html for All"; setxywhx htmla ', ": (20+bo),(60+y), bw, 40
z=.z,<'cc htmlw button; cn "Web html Group"; setxywhx htmlw ', ": (20+bo),(110+y), bw, 40
z=.z,<'cc precd  button; cn "Preview CD label"; setxywhx precd ', ": (20+bo),(160+y), bw, 40

z=.z,<'cc addto button; cn "Add to Group"; setxywhx addto ', ": (30+2*bo),(10+y), bw, 40
z=.z,<'cc rmfrom button; cn "Remove from Group"; setxywhx rmfrom ', ": (30+2*bo),(60+y), bw, 40
z=.z,<'cc htmlg button; cn "Html for Group"; setxywhx htmlg ', ": (30+2*bo),(110+y), bw, 40
z=.z,<'cc mkcd   button; cn "Make CD label"; setxywhx mkcd ', ": (30+2*bo),(160+y), bw, 40
PVFORM1=:PVFORM0,;,&(';',LF)&.> z
y
)

pvform_run=: 3 : 0
im_list_ima3_=:y
if. 0<#y do.
  im_sel_ima3_=:0
  ims=:>im_sel{im_list_ima3_
  else.
  im_sel_ima3_=:_
  ims=:''
  end.
sim_sel_ima3_=:_
sel_list_ima3_=:i.0
MKPVFORM tp_size
pvform_ims_select ''
)

paint_form=:3 : 0
form_xywh_ima3_=:wd :: ((16$'100 ')"_) 'psel pvform;qformx;'
wd :: 0: 'pclose;'
NB. wd MKPVFORM tp_size
z=.PVFORM1,'set ims ', ,&';' ; '"'&,@(,&'" ')&.> im_list_ima3_
wd z,'set sims ', ,&';' ; '"'&,@(,&'" ')&.> sel_list
if. sim_sel=_ do.
  if. im_sel<_ do.
    z=.'setselect sims _1;'
    z=.z,'setfocus ims;'
    wd z,'setselect ims ',(":im_sel),';'
    end.
  else.
  z=.'setselect ims _1;'
  z=.z,'setfocus sims;'
  wd z,'setselect sims ',(":sim_sel),';'
  ims=:>sim_sel{sel_list
  end.
NB. glmap MM_RAW
NB. glwindowext  2#tp_size
glsel 'temppic'
xywh=.0 0,1 0{$tpic
bm=.256 256 256&#.@:(a.&i.)"2 tpic
bm=.,bm
glpixels xywh,bm
NB. glshow ''
try. wd 'pmovex ',(":form_xywh_ima3_),';pas 0 0;pshow;'
  catch. wd 'pas 0 0;pshow;' end.
)

pvform_close=: 3 : 0
wd 'pclose;'
)

pvform_done_button=: 3 : 0
pvform_close''
)

to_tp=:3 : '(_1 1*tp_size){.!.(255{a.)(2#tp_size) resize_image y'

pvform_ims_select=: 3 : 0
if. (im_list_ima3_ e.~ <ims) *. fexist ims do.
  im_sel_ima3_=:im_list_ima3_ i. <ims
  tp_b_ima3_=:raw_read_image ims
  sim_sel_ima3_=:_
  else.
  im_sel_ima3_=:_
  tp_b_ima3_=:40 40 3${:a.
  end.
save_tp *{.temp_thsz
paint_form ''
)

pvform_sims_select=: 3 : 0
try.
  sim_sel_ima3_=:sel_list i. <sims
  tp_b_ima3_=:raw_read_image sims
  im_sel_ima3_=:_
catch. tp_b_ima3_=:40 40 3${:a. end.
save_tp 0
paint_form ''
)

save_tp=:3 : 0
if. 1={:$tp_b_ima3_ do. tp_b_ima3_=:3#"1 tp_b_ima3_ end.
tpic_ima3_=:to_tp tp_b_ima3_
if. -.(_=im_sel)*._=sim_sel
  do. 
  select. y
    case. 1 do.
    c=.temp_thsz resize_image tp_b_ima3_
    c write_image d_th_nm ims
    case. _1 do.
    whi=.|.2{.$ tp_b_ima3_
    who=.<.whi*<./(|temp_thsz)%whi
    if. try. -.who-:image_wh d_th_nm ims catch. 1 end.
         do.
          c=.(|temp_thsz) resize_image tp_b_ima3_
          c write_image d_th_nm ims
          end.
  end.
end.
)

NB. uses view_m to view selected image in separate window
pvform_temppic_mbldbl=:3 : 0
require addon_path,'view_m.ijs'
try. ims viewimage_run tp_b_ima3_ catch. 0 end.
)

NB. Lists menu functions

pvform_lmenu0_button=: 3 : 0
try. dir=.path_nm >{:im_list_ima3_ catch. dir=.'' end.
anm=.wd 'mbopen  "Add File to List" "',dir,'"  ""  "Bmp(*.bmp);Jpeg(*.jpg);Png(*.png)|*.bmp;*.jpg;*.png|All Files(*.*)|*.*"'
if. try. -.(<anm) e. im_list_ima3_ catch. 0 end.
  do.
  im_list_ima3_=:im_list_ima3_,<anm
  paint_form ''
  end.
)

pvform_lmenu1_button=:3 : 0
try. dir=.path_nm >{:im_list_ima3_ catch. dir=.'' end.
z=.'pc L3 closeok;pn "";xywh 2 2 175 11;cc ss static;cn "Add images in path to list:";'
z=.z,'xywh 185 8 22 12;cc add button;cn "Add";'
z=.z,'xywh 2 13 175 15;cc ed edit ws_border es_autohscroll;'
z=.z,'set ed "',dir,'";setfocus ed;setselect ed 0 _1;'
wd z,'pas 6 2;pshow;'
)

L3_add_button=:3 : 0
if. 0<#ed do.
  aa=.images_in ed
  im_list_ima3_=:im_list_ima3_,(-.aa e. im_list_ima3_)#aa
  wd 'pclose;'
  paint_form ''
  end.
)

pvform_lmenu2_button=: 3 : 0
try. dir=.path_nm >{:im_list_ima3_ catch. dir=.'' end.
anm=.wd 'mbopen  "Add File to Group" "',dir,'"  ""  "Bmp(*.bmp);Jpeg(*.jpg);Png(*.png)|*.bmp;*.jpg;*.png|All Files(*.*)|*.*"'
if. try. -.(<anm) e. im_list_ima3_ catch. 0 end.
  do.
  im_list_ima3_=:im_list_ima3_,<anm
  if. try. -.(<anm) e. sel_list catch. 0 end.
    do.
    sel_list_ima3_=:sel_list,<anm
    end.
  paint_form ''
  end.
)

pvform_lmenu3_button=: 3 : 0
sel_list_ima3_=:im_list_ima3_
paint_form ''
)

pvform_lmenu4_button=: 3 : 0
sel_list_ima3_=:i.0
paint_form ''
)


NB. Rotate/Flip menu functions
pvform_rot0_button=: 3 : 0
rot_cw_90 and_th ims
pvform_ims_select ''
)

pvform_rot1_button=: 3 : 0
rot_cw_180 and_th ims
pvform_ims_select ''
)

pvform_rot2_button=: 3 : 0
rot_cw_270 and_th ims
pvform_ims_select ''
)

pvform_pvmenu0_button=:pvform_rot0_button
pvform_rctrl_fkey=:    pvform_rot0_button

pvform_pvmenu1_button=:pvform_rot1_button

pvform_pvmenu2_button=:pvform_rot2_button
pvform_lctrl_fkey=:    pvform_rot2_button

pvform_pvmenu3_button=:3 : 0
flip_v and_th ims
pvform_ims_select ''
)
pvform_pvmenu4_button=:3 : 0
flip_h and_th ims
pvform_ims_select ''
)

pvform_pvmenu5_button=:3 : 0
transpose and_th ims
pvform_ims_select ''
)

NB. View and Thumbnail Size Menus
pvform_omenu0_button=:3 : 'paint_form MKPVFORM tp_size=: 300'
pvform_omenu1_button=:3 : 'paint_form MKPVFORM tp_size=: 360'
pvform_omenu2_button=:3 : 'paint_form MKPVFORM tp_size=: 400'
pvform_omenu3_button=:3 : 0
z=.'pc o3 closeok;pn "";xywh 2 2 75 11;cc ss static;cn "Set new image size:";'
z=.z,'xywh 85 8 22 12;cc set button;cn "Set";'
z=.z,'xywh 2 13 75 15;cc ed edit ws_border es_autohscroll;'
z=.z,'set ed "',(":tp_size),'";setfocus ed;setselect ed 0 1;'
wd z,'pas 6 2;pshow;'
)
o3_set_button=:3 : 0
if. 0<#ed do.
  tp_size=:". ed
  wd 'pclose;'
  save_tp 0
  MKPVFORM tp_size
  paint_form ''
  end.
)
pvform_omenu4_button=:3 : 'temp_thsz=:0'
pvform_omenu4a_button=:3 : 'temp_thsz=:_320 _280'
pvform_omenu5_button=:3 : 'temp_thsz=:_400 _350'
pvform_omenu6_button=:3 : 0
z=.'pc o6 closeok;pn "";xywh 2 2 75 11;cc ss static;cn "Set thumbnail window size:";'
z=.z,'xywh 85 8 22 12;cc set button;cn "Set";'
z=.z,'xywh 2 13 75 15;cc ed6 edit ws_border es_autohscroll;'
z=.z,'set ed6 "',(":temp_thsz),'";setfocus ed6;setselect ed6 0 1;'
wd z,'pas 6 2;pshow;'
)
o6_set_button=:3 : 0
if. 0<#ed6 do.
  temp_thsz=:". ed6
  wd 'pclose;'
  end.
)

NB. Web image and Gallery Menus
pvform_omenu7_button=:3 : 'web_size=:800 800'
pvform_omenu8_button=:3 : 'web_size=:1024 1024'
pvform_omenu9_button=:3 : 0
z=.'pc o9 closeok;pn "";xywh 2 2 75 11;cc ss static;cn "Set web image window size:";'
z=.z,'xywh 85 8 22 12;cc set button;cn "Set";'
z=.z,'xywh 2 13 75 15;cc ed9 edit ws_border es_autohscroll;'
z=.z,'set ed9 "',(":web_size),'";setfocus ed9;setselect ed9 0 1;'
wd z,'pas 6 2;pshow;'
)
o9_set_button=:3 : 0
if. 0<#ed9 do.
  web_size=:". ed9
  wd 'pclose;'
  end.
)
pvform_omenu10_button=:3 : 'num_cols=:2'
pvform_omenu11_button=:3 : 'num_cols=:3'
pvform_omenu12_button=:3 : 'num_cols=:4'
pvform_omenu13_button=:3 : 0
z=.'pc o13 closeok;pn "";xywh 2 2 75 11;cc ss static;cn "Set number of columns in gallery:";'
z=.z,'xywh 85 8 22 12;cc set button;cn "Set";'
z=.z,'xywh 2 13 75 15;cc ed13 edit ws_border es_autohscroll;'
z=.z,'set ed13 "',(":num_cols),'";setfocus ed13;setselect ed13 0 1'
wd z,'pas 6 2;pshow;'
)
o13_set_button=:3 : 0
if. 0<#ed13 do.
  num_cols=:". ed13
  wd 'pclose;'
  end.
)

no_del_message=:0 : 0
Delete files via the main file list.
Use the Remove from group button
to removal files from the group list.
)

pvform_del_button=:3 : 0
if. im_sel < _
do.
  if.'YES'-: wd 'mb delquery "Delete the file?" mb_yesno'
  do. ferase (;d_th_nm)ims
      im_list_ima3_=:im_list_ima3_-.<ims
      sel_list_ima3_=:sel_list-.<ims
      if. 0<#im_list_ima3_ do.
        im_sel_ima3_=:im_sel <. <:#im_list_ima3_
        ims=:>im_sel{im_list_ima3_
        tp_b_ima3_=:raw_read_image ims
      else.
        im_sel_ima3_=:_
        ims=:''
        tp_b_ima3_=:40 40 3${:a.
      end.
      save_tp *{.temp_thsz
      paint_form ''
  end.
else.
wd 'mb "Deletion Not Done" "',no_del_message,'" mb_ok'
end.
)

pvform_htmla_button=:3 : 0
NB. if. temp_thsz=0 do. t=.320 240 else. t=.temp_thsz end.
dir=.path_nm >{.im_list_ima3_
nm=.wd 'mbsave  "Create Html Gallery" "',dir,'"  "index.html"  "Html(*.html)|*.html|*.htm"'
if. 0<#nm do. nm num_cols mk_html_gallery temp_thsz im_list_ima3_ end.
)

empty_sel_error=:3 : 0
wd 'mb "Error Message" "Empty Group"'
)

NB. default web name
d_w_nm0=:1 : 0
(u,'w_'"_,]`(4&}.)@.('dscn'&-:@(4&{.))@short_fn)&.>
)

d_w_nm=: 3 : 0
path_nm d_w_nm0 y
:
x"_ d_w_nm0 y
)

pvform_htmlw_button=:3 : 0
if. 0=#sel_list do. empty_sel_error '' return. end.
if. temp_thsz=0 do. t=.320 240 else. t=.temp_thsz end.
dir=.path_nm >{.im_list_ima3_
pathw=.dir,'www',dir_sep
(1!:5 :: 0:) <pathw
nm=.wd 'mbsave  "Create Html Gallery" "',pathw,'"  "index.html"  "Html(*.html)|*.html|*.htm" '
if. 0<#nm do.
  pathw=.path_nm nm
  wim=.(pathw,'w')&,&.> ]`(4&}.)@.('dscn'&-:@(4&{.))&.> short_fn&.> sel_list
  web_size mk_th_image"1 sel_list ,. wim
  nm num_cols mk_html_gallery t wim
end.
)

pvform_addto_button=:3 : 0
sel_list_ima3_=:sel_list,<ims
paint_form ''
)

pvform_rmfrom_button=:3 : 0
sel_list_ima3_=:sel_list{~(i.#sel_list) -. sel_list i: <sims
if. 0<#sel_list
  do.
  sim_sel_ima3_=: sim_sel <. <:#sel_list
  sims=:>sim_sel{sel_list
  tp_b_ima3_=:raw_read_image sims
  else.
  sim_sel_ima3_=:_
  tp_b_ima3_=:40 40 3${:a.
  end.
save_tp 0
paint_form ''
)

pvform_htmlg_button=:3 : 0
if. 0=#sel_list do. empty_sel_error '' return. end.
if. temp_thsz=0 do. t=.320 240 else. t=.temp_thsz end.
dir=.path_nm >{.im_list_ima3_
nm=.wd 'mbsave  "Create Html Gallery" "',dir,'"  "index.html"  "Html(*.html)|*.html|*.htm" '
if. 0<#nm do. nm num_cols mk_html_gallery t sel_list end.
)

NB. CD menu and buttons
pvform_cdmenu0_button=: 3 : 0
cd_label_size=:1200
)
pvform_cdmenu1_button=: 3 : 0
cd_label_size=:1600
)
pvform_cdmenu2_button=: 3 : 0
cd_label_size=:2000
)

pvform_cdmenu3_button=:3 : 0
z=.'pc cdm3 closeok;pn "";xywh 2 2 75 11;cc ss static;cn "Set size of CD label image:";'
z=.z,'xywh 85 8 22 12;cc set button;cn "Set";'
z=.z,'xywh 2 13 75 15;cc ed13 edit ws_border es_autohscroll;'
z=.z,'set ed13 "',(":cd_label_size),'";setfocus ed13;setselect ed13 0 2'
wd z,'pas 6 2;pshow;'
)
cdm3_set_button=:3 : 0
if. 0<#ed13 do.
  cd_label_size=:". ed13
  wd 'pclose;'
  end.
)

mk_cd_I=:3 : 0
if. try. -. cd_I_list -: sel_list catch. 1 end. do.
  blk=.(3,~<.cd_label_size*1 0.1)${:a.
  cd_I=:i.cd_label_size,0 3
  for_si. sel_list do.
    cd_I=:cd_I,.blk,.~(100 1*cd_label_size) resize_image raw_read_image >si
  end.
  require addon_path,'anins2.ijs'
  cd_I_list=:sel_list
end.
)

pvform_mktext_button=:3 : 0
require addon_path,'text_image.ijs'
textimage_run ''
)

pvform_precd_button=: 3 : 0
if. 0=#sel_list do. empty_sel_error '' return. end.
mk_cd_I ''
tp_b_ima3_=:((3,~2#tp_size)${:a.) 0.361111 1 AnIns (1p1 _1p1) cd_I
save_tp 0
paint_form ''
)

pvform_mkcd_button=: 3 : 0
if. 0=#sel_list do. empty_sel_error '' return. end.
mk_cd_I ''
tp_b_ima3_=:((3,~2#cd_label_size)${:a.) 0.361111 1 AnIns (1p1 _1p1) cd_I
save_tp 0
paint_form ''
if. _1=(4!:0)<'cd_save_fn' do.
  try. cd_save_fn=: (path_nm >{:im_list_ima3_),'cd_label.jpg'
  catch. cd_save_fn=: 'cd_label.bmp' end.
  end.
cd_save_fn=:wd 'mbsave  "Save CD label" "',(path_nm cd_save_fn),'"  "',(nx_fn short_fn cd_save_fn),'"  "Jpeg(*.jpg)|*.jpg|*.jpg"'
tp_b_ima3_ write_image cd_save_fn
if. try. -.(<cd_save_fn) e. im_list_ima3_ catch. 0 end.
  do.
  im_list_ima3_=:im_list_ima3_,<cd_save_fn
  paint_form ''
  end.
)

pvform_cdmenu4_button=:pvform_mktext_button
pvform_cdmenu5_button=:pvform_precd_button
pvform_cdmenu6_button=:pvform_mkcd_button

NB. Help Menu
pvform_hmenu0_button=:3 : 0
open_html addon_path,'help\prevare.html'
)

NB. Main Function
prevare=: 3 : 0
pvform_run y
:
temp_thsz=:x
pvform_run y
)

typical_use=:0 : 0
wd 'reset;'
path=: '\temp\01\'                   NB. select a directory
prevare images_in path       NB. make necessary rotations and thumbnails
)
