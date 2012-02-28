NB. Script html_gallery8.ijs contains functions which can
NB. create an image gallery in the form of an html page.
NB. Utilities useful for creating thumbnails and rotating images
NB. and dealing with many image files are included
NB. Cliff Reiter and Zach Reiter, November 2002
NB. modified for J6.01, Sept 2006
NB.

NB. locale for image3 addon
coinsert 'ima3'
coclass 'ima3'

NB. path to the image3 addon library needs to be correct.
dir_sep=: PATHSEP_j_             NB. directory separator
addon_path=: jpath '~addons/media/image3/'
require addon_path,'movie3.ijs'
require jpath '~system',dir_sep,'extras',dir_sep,'util',dir_sep,'browser.ijs'

dir_pred=:'../'                  NB. directory predecessor

NB. ***************************
NB. ***  General functions  ***
NB. ***************************

NB. all files in directory specified by y have name changed to lower case
dir_to_lc=: 3 : 0
fn=.fdir y,'*.*'
fn=.{."1 ('d'~:4{"1>{:"1 fn)# fn
fn=.(fn -.@-:"0 to_lc&.> fn)#fn
if. 0<#fn do.
  > {."1 Fmove"1 y&,&.> fn,.to_lc&.> fn
  else. '' end.
)

NB. open_html 'filename'  to launch the j configured browser
open_html=: launch_jbrowser_

NB. default thumbnail name
d_th_nm=:(path_nm,'th_'"_,short_fn)@((]`('jpg'&ch_ext))@.(ext_type e. 8 9"_))"1

NB. default archive name
d_archive_nm =: (3 : '(path_nm y),''archive'',dir_sep,short_fn y')"1

NB. finds non-thumbnail images of specified type in pathname (use trailing "\" in pathname)
im_in=:1 : 0
m=.boxopen m
(<,&.> /:~@:( -.@:('th_'&-:@(3&{.)&> )#])@:(e.&m@:(to_lc@fn_ext&.>)# ])@:({."1)@:fdir@:(,&'*.*')) f.
)

NB. finds all nonthumbnail bmp images in the path (use trailing "\" in pathname)
bmps_in=:   'bmp' im_in
jpegs_in=:  ('jpg';'jpeg') im_in
pngs_in=:   'png' im_in
tgas_in=:   'tga' im_in
pgms_in=:   'pgm' im_in
ppms_in=:   'ppm' im_in
pnms_in=:   'pnm' im_in
movs_in=:   'mov' im_in
avis_in=:   'avi' im_in

NB. finds all nonthumbnail bmp, jpeg, png, and tga in path (use trailing "\" in pathname)
images_in=: ('bmp';'jpg';'jpeg';'png';'tga';'pgm';'ppm';'pnm';'mov';'avi') im_in

NB. make thumbnail from image
NB. 320 240 mk_th_image ;'infile';'outfile'
NB. In above, 320 240 gives the width & height into
NB. which the thumbnail will be fit.
NB. Note: image write defaults are used when creating
NB. jpeg and png thumbnails so,
NB. be especially sure to think about jpeg_quality.
NB. Default thumbnail size is 150 150
mk_th_image=: 3 : 0
150 150 mk_th_image y
:
'infile outfile'=.d_th_nm d_fn_ck y
b=.read_image infile
b=. x resize_image b
b write_image outfile
)

NB. rotate clockwise 90, 180 or 270 degrees clockwise
NB. note, current jpeg_quality is used for jpegs so additional
NB. loss is expected; suggest archiving original images first
NB. see "and_archive" below
rot_cw_90=: 3 : 0"1
if. 1 2 e.~ ext_type y do. jpeg_rot_90 ;~y
  else.
  z=.raw_read_image y
  z=.(1 0&((0 1)})@i.@$@$ |: ]) |. z
  z write_image y
end.
)

rot_cw_180=: 3 : 0"1
if. 1 2 e.~ ext_type y do. jpeg_rot_180 ;~y
  else.
  z=.raw_read_image y
  z=.|."_1|.z
  z write_image y
end.
)

rot_cw_270=: 3 : 0"1
if. 1 2 e.~ ext_type y do. jpeg_rot_270 ;~y
  else.
  z=.raw_read_image y
  z=.|.(1 0&((0 1)})@i.@$@$ |: ])z
  z write_image y
end.
)

flip_v=: 3 : 0"1
if. 1 2 e.~ ext_type y do. jpeg_flip_v ;~y
  else.
  z=.raw_read_image y
  z=.|.z
  z write_image y
end.
)

flip_h=: 3 : 0"1
if. 1 2 e.~ ext_type y do. jpeg_flip_h ;~y
  else.
  z=.raw_read_image y
  z=.|."_1 z
  z write_image y
end.
)

transpose=: 3 : 0"1
if. 1 2 e.~ ext_type y do. jpeg_transpose ;~y
  else.
  z=.raw_read_image y
  z=.(1 0{i.#$z)|:z
  z write_image y
end.
)

NB. applies function to images and their thumbnails, if any.
NB. rot_cw_90 and_th 'path\in.jpg'
and_th=:1 : 0
z=.u y
if. fexist nt=.d_th_nm y do.
  u nt
  end.
z
)

NB. Various head/tail text blocks needed for default html files
NB. You may want to edit ht_table_prolog and ht_table_postlog to
NB. suit your gallery format.

ht_head0=:'<HTML><HEAD>',CRLF,'<TITLE>',CRLF

ht_head1=:'</TITLE></HEAD>',CRLF,'<BODY bgcolor="#ffffff">'

ht_table_prolog=:'<font size = 4><B><center>Image Gallery</center></B>',CRLF,'<center>',CRLF

ht_table_postlog=:'</center>',CRLF

ht_tail=:'</BODY>',CRLF,'</HTML>'

NB. Surround by html tags.
ht_tags=: 4 : 0
'<',x,'>',y,'</',x,'>'
)

NB. [x] ht_fmt_image 'image_name'
NB. x lists width, height, kb size, depth of ref, rel depth of image
ht_fmt_image=: 3 : 0
((image_wh y), (fsize y),0 0) ht_fmt_image y
:
z=.'<img src="',(,(4{x)#,:dir_pred),(short_fn y),'" width="'
z=.z , (":{.x), '" height="' , ": 1{ x
if. 0 < 2{x do. z=.z,'" alt= "', (": <.0.001* 2 { x), 'k">'
             else. z=.z,'">'end.
z
)

NB. useful for creating html file associated with a single image;
NB. for example, some browers will not show a direct reference to
NB. a bmp file, but will display the same bmp in a html file.
mk_html_for_image=:3 : 0     NB. Title on left, filename on right
(short_fn y) mk_html_for_image y
:
fn=.'html' ch_ext y
(ht_head0,x,ht_head1) fwrites fn
(ht_fmt_image y) fappends fn
ht_tail fappends fn
fsize fn
)

NB. [th_height th_width im_size] ht_href_fmt_image 'imagefile';'th_imagefile'
NB. thumb image is wrapped in href reference
ht_href_fmt_image=: 3 : 0
y=.<"1^:(0:=L.) y
y=.(, d_th_nm&.>)^:(1:= #)y
((image_wh@>@{:,fsize@>@{.,0:,0:)y) ht_href_fmt_image y
:
z=.'<a href="',((,(4{x)#,:dir_pred),(3{x) short_fn >{.y),'">'
z,(x ht_fmt_image >{:y),'</a>'
)

NB. [th_height th_width im_size] ht_td_fmt_image 'imagefile'[;'th_imagefile']
NB. table data entry with href wrapped image and text field
ht_td_fmt_image=: 3 : 0
y=.<"1^:(0:=L.) y
y=.(, d_th_nm&.>)^:(1:= #)y
((image_wh@>@{:,fsize@>@{.,0:,0:)y) ht_td_fmt_image y
:
'td' ht_tags (td_prolog y),(x ht_href_fmt_image y),td_postlog y
)

NB. td_prolog filename;thumbname gives prolog to data entry
td_prolog=:3 : 0
'<center>'
)

NB. td_postlog filename;thumbname gives postlog to data entry
td_postlog=:3 : 0
'<br>',CRLF,(short_fn >{.y),'</center>'
)

NB. [th_height th_width im_size] ht_tr_fmt_images 'imagefile'[;'th_imagefile']
NB. lists info for image table data entries wrapped into table rows
ht_tr_fmt_images=: 3 : 0
((image_wh@>@{: , fsize@>@{.,0:,0:)"1 y) ht_tr_fmt_images y
:
CRLF,~'tr' ht_tags ,CRLF,x ;@:(<@,&CRLF@ht_td_fmt_image"1)y
)

NB. [th_ht th_w im_sz] cols ht_table_fmt_images 'imagefiles'[;'th_imagefiles']
NB.  ^^^ numeric matrix                           ^^^ boxed list or boxed matrix
NB. lists info for image table data entries wrapped into table rows
ht_table_fmt_images=:1 : 0
(((]`(80 30"_)@.(_1&-:))@:image_wh@>@{: , fsize@>@{.,0:,0:)"1 y) m ht_table_fmt_images y
:
z=.'<table cellspacing="10" cols="',(":m),'">',CRLF
z=.z,((-m) <\ x) ;@:(ht_tr_fmt_images&.>) (-m) <\y
z,'</table>',CRLF
)

NB. [w h sz] cols html_fmt_gallery title 'imagefiles'[;'th_imagefiles']
NB. creates html file whose main element is the table of images.
NB. Note global variables ht_table_prolog and ht_table_postlog
NB. can be used to add default elements to your galleries.
html_fmt_gallery=:2 : 0
(((]`(80 30"_)@.(_1&-:))@:image_wh@>@{: , fsize@>@{.,0:,0:)"1 y) m html_fmt_gallery n y
:
z=.ht_head0,n,ht_head1,ht_table_prolog
z=.z,x m ht_table_fmt_images y
z,ht_table_postlog,ht_tail
)

NB. fn_th_nm image_list
NB. results in a boxed matrix of image filename/thumbnail
NB. names from input image list
fn_th_nm=:3 : 0
if. 0 = L. y do. y=.(;d_th_nm)@deb"1 y end.
if. 1 = $$y  do. y=.y,.d_th_nm&.> y end.
y
)

NB. thumb_bounds cond_mk_th_image boxed_fn_th_nm_list
NB. conditionally creates thumbnails
NB. right argument is a boxed matrix with each row
NB. giving an image/thumbnail pair
cond_mk_th_image=:4 : 0
select. * {. x
  case. 1  do. x mk_th_image"1 y
  case. 0  do. ''
  case. _1 do.
    for_im. y do.
      whi=.2{.image_wh >{. im
      who=.<.whi*<./(|x)%whi
      if.  try. -.who-:image_wh >{: im catch. 1 end.
        do. (|x) mk_th_image im  end.
    end.
end.
)

NB. [html_outfile] cols mk_html_gallery th_wh 'imagefiles'[;'th_imagefiles']
NB. creates html file given the table of image files.
NB. thumbnails are created with width and height bounded by th_wh
NB. unless th_wh is the scalar 0 in which case no thumbnails are created.
mk_html_gallery=:2 : 0
((path_nm >{.y),'index.html') m mk_html_gallery n y
:
y=.fn_th_nm y
n cond_mk_th_image y
(m html_fmt_gallery (}: '' ch_ext short_fn x) y) fwrite x
)

NB. [outfiles] (rows,cols) mk_html_gallery_seq th_size images[&thumbnails]
NB. Creates a sequence of linked "Next Page" image galleries
NB. The number of pages is given by the number of flenames in x for
NB. dyad; for the monad, the number of rows and columns desired on
NB. each page are specified; that determines the number of pages;
NB. row numbers are adjusted for best under fit.
mk_html_gallery_seq=:2 : 0
np=.>.(#y)%*/m
d_fn=.,&'.html'"1 ((path_nm >{.y),'index'),"1] 2 nfmt i.np
d_fn ({:m) mk_html_gallery_seq n y
:
m=.{:m
npp=.m*>.(#y)%m*#x
prologs=. ht_table_prolog ; }. ,&('</center></b>',CRLF,'<center>',CRLF)@('<center><b>'&,)&.> sfn=.short_fn&.> <"1 x
postlogs=.}.(,&'"><center>Next Page</center></a>'@('<a href="'&,)&.> sfn),<ht_table_postlog
k=.0
while. k<#x do.
  fn=.k{x
  ht_table_prolog=: >k{prologs
  ht_table_postlog=:>k{postlogs
  fn m mk_html_gallery n (npp<.#y){.y
  k=.k+1
  y=.npp}.y
  end.
ht_table_prolog =:>{.prologs
ht_table_postlog=:>{:postlogs
#x
)

NB. Utilities for updating html files

NB. white space/ht tag cleanup tools
dbw=:(e.&(' ',CRLF)i. 0:)}.]               NB. delete begining white space
rmpretag=:]`(>:@(i.&'>') }. ])@.('<'&=@{.) NB. remove prefix ht tag
dew=:((e.&(' ',CRLF)i:0:)-#-1:)}.]         NB. delete ending white space
rmposttag=:]`((i:&'<') {. ])@.('>'&=@{:)   NB. remove postfix ht tag

NB. get_gallery_itd filename
NB. get image thumbnail and description for images appearing
NB. before the end of the first table.
get_gallery_itd=:3 : 0
z=.({.~1:i.~'</table>'&E.@tolower) fread y
z=.('<a href="'&E.@tolower <@(9&}.);.1 ]) z
imgs=:(i.&'"'{.])&.> z
z=.((5:+1: i.~ 'src="'&E.@:tolower)}. ])&.> z
ths=:(i.&'"'{.])&.> z
z=.((4:+1: i.~ '</a>'&E.@:tolower)}. ])&.> z
z=.((1:i.~ '</td>'&E.@:tolower){.])&.> z
z=.]`(dbw@rmpretag)@.(*@#)^:_&.> z
z=.]`(dew@rmposttag)@.(*@#)^:_&.> z
imgs,.ths,.z
)

NB. td_postlog used to preserve existing text
desc_td_postlog_txt=:0 : 0
td_postlog=:3 : 0
'<br>',CRLF,({&itd_d@(itd_i&i.)&.< :: ] short_fn >{.y),'</center>'
)

NB. sets td_postlog based upon given index file descriptors
mk_desc_td_postlog=: 3 : 0
itd=. get_gallery_itd y
itd_i=:{."1 itd
itd_d=:{:"1 itd
0!:0 desc_td_postlog_txt,')',LF
)

NB. [outfile] num_cols_plus update_html_gallery th_bounds image_list
NB. attempts to preserve the image descriptions from the exisitng html
NB. file as the gallery is created. The argument
NB. num_cols_plus has the form num_cols [po_text [table_num]]
NB. where po_text is a Boolean flag indicating whether other text should
NB. be preserved (if possible, defaut 1 = yes) and, if so,
NB. which table to replace with the gallery
NB. (default = 0 which is the first table).
update_html_gallery=:2 : 0
((path_nm >{.y),'index.html') m update_html_gallery n y
:
if. -. fexist x do.
  fsz=.x ({.m) mk_html_gallery n y
  else.
  'm po_text tab_num'=.m,(#m)}.3 1 0
  t1=.'td_postlog=:',5!:5 <'td_postlog'
  mk_desc_td_postlog x
  y=.fn_th_nm y
  n cond_mk_th_image y
  if. po_text do.
    table_st=.tab_num{('<table'&E.@to_lc # i.@#) zz=.fread x
    table_end=.tab_num{('</table'&E.@to_lc # i.@#) zz
    z=.table_st{.zz
    z=.z,m ht_table_fmt_images y
    z=.z,dbw rmpretag table_end}.zz
    fsz=.z fwrite x
    else.
    fsz=.x m mk_html_gallery 0 y
    end.
  0!:0 t1
end.
fsz
)
