NB. This image Addon script provides functions for converting,
NB. reading, and writing, image files from J. They are designed
NB. for work with 24-bit image formats, but some are useful for
NB. 8-bit image formats as-is. See fvj2\raster4 and fvj2\ped8
NB. for more 8-bit functions. This script was written by
NB.   Zachary X. Reiter and Clifford A. Reiter
NB.   last updated November, 2002
NB. modified for J6.01, Sept 2006
NB.
NB. The core JPEG and PNG utilities use library (*.dll *.so)
NB. calls. The libraries were created by Zachary Reiter.
NB. For information regarding the copyrights of the software used,
NB. please see the included file COPYRIGHTS in the help directory
NB.
NB. Formats included: BMP, JPEG, PNG, TGA, PGM, PPM & simple *.MOV
NB. See image3.ijt laboratory & script below for options & more details
NB. However, the main read/write functions may typically be used as follows.
NB.    I=:read_image 'filename'        NB. gives h by w by 3 array of RGB triples
NB.    I=:raw_read_image 'filename'    NB. gives h by w by 3 array of character RGB triples
NB.    I write_image 'filename'        NB. writes array (integer or raw) to file
NB.    conv_image 'image.bmp';'image.jpg'   NB. converts image.bmp into image.jpg using default jpeg options
NB. Note that grayscale jpeg images correspond to h by w by 1 arrays.
NB. Images in the paletted (p;b) form (p is palette, b the matrix of indices) may be written

NB. load required system scripts
require 'dll files strings'

NB. locale for image3 addon
coinsert 'ima3'
coclass 'ima3'

NB. indentify system
systems=.5 6  NB. linux/PC
system=. systems i. 9!:12 ''  NB. linux is 0; PC is 1

NB. display error if not 32-bit linux/PC
3 : 0''
if. IF64 +. IFUNIX +: IFWIN do.
  if. IFJ6 do.
    wd 'mb "" "Unsupported Platform" '
  else.
    sminfo '';'Unsupported Platform'
  end.
end.
''
)

NB. System directory separator
dir_sep=: IFJ6{::'/';system{'/\'             NB. directory separator

NB. path to the addon library (dll, so) needs to be correct.
addon_path=: jpath '~addons/media/image3/'

NB. load system specific functions
load addon_path,>system{'image3_unix_ini.ijs';'image3_win_ini.ijs'

NB. ***************************
NB. ***  General functions  ***
NB. ***************************

NB. change text to lower case
to_lc=:(+32&*@:(e.&(65+i.26)))&.(a.&i.)

NB. get file name extension
fn_ext=: }.~ 1: + i:&'.'

NB. change extension
ch_ext=: ({.~ 1: + i:&'.')@] , [

NB. checks function names are boxed with last axis length two;
NB. otherwise, boxes and/or adjoins default names to trailing axis.
d_fn_ck=:1 : '(;u)&>^:(2: ~: {:@(1:,$))@:(<@deb"1^:(L.=0:))'

NB. gives short file x is levels of path to keep (default x=.0)
NB. drive letter, if any, is stripped
short_fn=:3 : 0                 NB. gives short file names
0 short_fn y
:
Y=.(,~ -.@(e.&'/\')@{. # dir_sep"_)@:(}.~(i:&':')@:(':'&,))y
}.;(->:x){.(e.&'/\' <;.1 ])Y
)

NB. gives pathname of file
path_nm=: [: , ((i.@#)= i:&dir_sep)];.2 ]

NB. n nfmt nums
NB. gives n-digit formatted interger representation of nums with
NB. leading 0s as necessary. Useful for fileame sequences.
NB. Default it 3-digits
nfmt=: 3&$: : ({&'0123456789'@:(([#10"_)#:]))

NB. "next" file name (when suffix is a number)
NB. nx_fn 'abc001.bmp' is 'abc002.bmp'
NB. nx_fn 'abc999.bmp' is 'abc1000.bmp'
nx_fn=:3 : 0
m0=.i:&'.' y
pre=.m0 {. y
n0=._1+(#-i:&0) e.&'0123456789' pre
fnum=.(-n0){.pre
((-n0)}.pre),(,(n0+0=#fnum-.'9')nfmt >: ". fnum),m0}.y
)

NB. new filename sequence
NB. num new_fn_seq oldfilenameseq is a sequence of length
NB. #oldfilenamesequ with names similar to {.oldfilenameseq
NB. except the numeric suffix is replaced by num and its successors
new_fn_seq=:4 : 0
ffn=.>{.y
m0=.i:&'.' ffn
pre=.m0 {. ffn
n0=._1+(#-i:&0) e.&'0123456789' pre
z=.<"1 ((-n0)}.pre),"1 ((n0 >.#":<:x+#y)nfmt x+i.#y),"1 m0}.ffn
if. +./z e. y do. if. IFJ6 do. wd 'mb "Error" "Result sequence overlaps with input sequence"' else. sminfo 'Error';'Result sequence overlaps with input sequence' end.
  else. z end.
)

NB. gives the numeric suffix, if any, of the given filename
fn_num_suffix=:".@(>:@(i:&0-#)@( e.&'0123456789'){.])@:(i:&'.'{.])

NB. file_selector fseq_adjoin path1;path2[...]
fseq_adjoin=:1 : 0
path1=.>{.y
nn=.1+>./;fn_num_suffix&.> u path1
for_dir. }. y do.
  fseq=.u > dir
  Fmove fseq,. nn&new_fn_seq@:(path1&,@short_fn&.>) fseq
  nn=.nn+#fseq
end.
<:nn
)

NB. finds files of given form in folder given by pathname
NB. (use trailing directory separator in pathname)
NB. e.g.  '*.bmp' files_in '\my_images\'
files_in=:1 : 0
y&,&.>/:~{."1 fdir y,m
)

NB. ***********************
NB. ***  BMP functions  ***
NB. ***********************

NB. little endian integer conversions for bmp's
lic=: 4 : 0"0 1
select. x
case. _1 do. _2 (256&#.@:(a.&i.)@:|.)\ y
case. _2 do. _4 (256&#.@:(a.&i.)@:|.)\ y
case. 1 do.  ,|.@:({&a.)@:(256 256&#:)"0 y
case. 2 do.  ,|.@:({&a.)@:(256 256 256 256&#:)"0 y
end.
)

NB. write h by w by 3 ascii array (x) to bmp file specified by y
NB. (pal;b) write_bmp fn creates an 8-bit image file
write_bmp=:4 : 0
if. 32=(3!:0) x do. NB. (pal;b) paletted input
   bpp=.8
   pal=.(0,"1~|."1 >{.x){a.
   x=.>{:x
   else.
   if. (3=$$x) *. 1={:$x do. x=.,"2 x end. NB. grayscale 3-d array
   if. 2=$$x do. NB. grayscale matrix
     bpp=.8
     pal=.(3#"0 a.),.{.a.
     else.        NB. ordinary 24-bit
     bpp=.24
     pal=.''
     end.
   end.
if. 4=(3!:0) x do. x=.x{a. end.
Bpp=.1,<.bpp%8
xsbmp=.(0 1*4|-sbmp*Bpp)+Bpp*sbmp=.2{.$x
szpal=.4*#pal
hdr=.'BM',2 lic (54+szpal+*/xsbmp),0,(54+szpal),40,|.sbmp
hdr=.hdr,(1 lic 1,bpp),2 lic 0,(*/xsbmp),0 0,(#pal),0
if. bpp=24 do. x=.,"2 |."1 x end.
bmp=.,|. xsbmp{.x
(hdr,(,pal),bmp)fwrite y
)

NB. read h by w by 3 ascii array from bmp file
raw_read_bmp=: 3 : 0
NB.ic=.3!:4"0 1
NB.ic=.(256&#.@:(a.&i.)@:|.)"1 : ($:@:])

if. _1-:x0=.fread y do. 'file not found' return. end.
biCompression=._2 lic (30+i.4){x0
  if. biCompression ~: 0 do. 'compressed bmp files are not supported' return. end.
biBitCount=: {._1 lic (28+i.2){x0
sbmp=.|.,_2 lic (18+i.2 4){x0
select. biBitCount 
  case. 32 do.
  x0=.(sbmp,4)$54}.x0
  x0=.(sbmp,3){.x0
  x0=.|.|."1 x0
  case. 24 do.
  xsbmp=.(0 1*4|-sbmp* 1 3)+1 3*sbmp
  x0=.xsbmp$54}.x0
  x0=.(sbmp*1 3){.x0
  x0=.(sbmp,3)$,x0
  x0=.|.|."1 x0
  case. 8 do.
    'rpal bmp'=.de_pal_bmp_data x0
    bmp{rpal
  case. do.  'unsupported number of bits per pixel'
end.
)

NB. internal utility for converting bmp file data
NB. into raw palette/index array
de_pal_bmp_data=: 3 : 0
NB.ic=.3!:4"0 1
x0=.y
sbmp=.|.,_2 lic (18+i.2 4){x0
xsbmp=.sbmp+(i.2)*4|-sbmp
biClrUsed=._2 lic (46+i.4){x0   NB. change from image2
if. biClrUsed = 0 do. biClrUsed =. <. 0.25*(#x0)-54+*/xsbmp end.
biOffBits=._2 lic (10+i.4){x0
rpal=. 2 1 0{"1 (biClrUsed,4)$ 54}.(54+4*biClrUsed){.x0
bmp=. a.i.|.sbmp{.xsbmp$biOffBits}.x0
rpal;bmp
)

NB. read *.bmp as a paletted image if possible
pal_read_bmp=:3 : 0
NB.ic=.3!:4"0 1
if. _1-:x=.fread y do. 'file not found' return. end.
biCompression=._2 lic (30+i.4){x
  if. biCompression ~: 0 do. 'compressed bmp files are not supported' return. end.
biBitCount=. _1 lic (28+i.2){x
if. biBitCount = 8 do.
  'rpal bmp'=.de_pal_bmp_data x
  else. 'not a paletted image' return. end.
(a.i. rpal);bmp
)

NB. read *.bmp as integers
read_bmp=:a.&i.@raw_read_bmp

NB. BMP image width & height
bmp_wh=:3 : 0
NB.ic=.3!:4"0 1
,_2 lic 2 4$1!:11 (;y);18 8
)

NB. bmp_color_depth
bmp_cd=: 3 : '_1 lic 1!:11 y;28 2'

NB. ************************
NB. ***  JPEG functions  ***
NB. ************************
NB. Global defaults are provided for jpeg writes

jpeg_quality=: 75  NB. default quality
progressive=:   0  NB. default is 0 (false)
gray_scaling=:  0  NB.  _1 never (promote to rgb)
                   NB.   0 preserve;ie, use trailing axis; (default)
                   NB.   1 always (make gray)
                   NB.   2 when possible (make gray if possible)

NB. x zjm y calls the image3 library function x with argument y
zjm=: 1 : '(''"'',addon_path,library_name,''" '',m)&cd'

NB. integer conversion
raw_to_int=:_2&(3!:4)
int_to_raw=: 2&(3!:4)

jpeg_get_info=: 3 : 0
NB. returns width, height, components, & precision guess.
a=.'jpeg_get_info + i *c *i *i *i *i' zjm (<y),(,&.> ;/ 4#0)
if. _2=>{.a do. 'error this is bit depth',":>5{a return. end.
if. _1=>{.a do. 'error getting info....' return. end.
,>2}.a
)

NB. gives width and height info for a jpeg file
jpeg_wh=: 2&{.@jpeg_get_info

NB. gives width, height and color depth (1 for gray, 3 for RGB)
jpeg_whd=: 3&{.@jpeg_get_info

NB. raw_read_jpeg 'in_file'
raw_read_jpeg=: 3 : 0
  whd=.; jpeg_whd y
  sz=. */whd
  addr=.mema sz
  a=.>{.'jpeg_to_mem + i *c i' zjm y;addr
  if. _1=a do.
    memf addr
    'error reading...........' return.
  end.
  data=.memr addr,0,sz
  memf addr
  (1 0 2{whd)$data
)

NB. z=.read_jpeg 'input.jpg'
NB. z is h by w by 3 integer array of RGB triples
read_jpeg=:a.&i.@raw_read_jpeg

NB.	data mem_to_jpeg (file_name; JPEG_RGB; qaulity_default)
NB. [jpeg_quality] data write_jpeg filename
NB. data may be raw or integer matrices of
NB. rgb-triples (color) or single items (grayscale)
write_jpeg=: 1 : 0
(jpeg_quality,progressive,gray_scaling) m write_jpeg y
:
'jq pr gs'=.x,(#x)}.jpeg_quality,progressive,gray_scaling
if. 32=(3!:0) m do. m=.{~&>/m end.
if. 2 = $$m do. m=.,"0 m end.    NB. make rank 3
if. 4=(3!:0) m do. m=.m{a. end.  NB. make it raw
select. gs
  case. _1 do. if. 1={:$m do. m=.3#"1 m end.
  case.  0 do. ''
  case.  1 do. if. 3={:$m do. m=.,@<.@(+/%#)"1&.(a.&i.) m end.
  case.  2 do. if. 3={:$m do.
                 if. (-:1&|."1)m do. m=.,@{."1 m end. end.
  end.
if. -. 1 3 e.~ {:$m do. 'unsupported 3rd axis length' return. end.
sz=. */$m
addr=.mema sz
(,m) memw addr,0,sz	
a=.>{.'mem_to_jpeg + i *c i i i i i i' zjm (y;addr),(;/ 1 0 2 {$m),(jq;pr)
memf addr
if. _1=a do. 'error writing inside dll...' return. end.
fsize y
)

NB. [jpeg_quality [progressive [gray_scaling]]] bmp_to_jpeg 'in_file' [;'outfile']
NB. call is one file at a time; use rank on file lists

NB. defaut grayscale name
d_gs_nm=:  ;@(}:,(<'gs_' )"_,{:)@:(((i.@#)e. <:@# , i:&dir_sep)<;.2 ])"1

NB. used to convert to grayscale if currently rgb that is grayscale
jpeg_cond_gs=: 3 : 0
jpeg_quality jpeg_cond_gs y
:
'in out'=.d_gs_nm d_fn_ck y
m0=.read_jpeg in
if. (-: 1&|."1) m0 do. x (,@{."1 m0) write_jpeg out else. 0 end.
)

NB. provides connections to lossless transformations when
NB. image size is a multiple of blocksize (16)
jpeg_xform=: 4 : 0
a=.>{.('lossless_xform + i *c *c i' zjm y,(<x))
if. _1=a do. _1 return. end.
fsize {:y
)

NB. defaut transform name
d_xf_nm=:  ;@(}:,(<'xf_' )"_,{:)@:(((i.@#)e. <:@# , i:&dir_sep)<;.2 ])"1

NB. specific left arguments give various lossless transforms
NB. but image blocks may be extended
jpeg_ll_flip_h=: 1: jpeg_xform d_xf_nm d_fn_ck
jpeg_ll_flip_v=: 2: jpeg_xform d_xf_nm d_fn_ck
jpeg_ll_transpose=:  3: jpeg_xform d_xf_nm d_fn_ck
jpeg_ll_transverse=: 4: jpeg_xform d_xf_nm d_fn_ck
jpeg_ll_rot_90=:  5: jpeg_xform d_xf_nm d_fn_ck
jpeg_ll_rot_180=: 6: jpeg_xform d_xf_nm d_fn_ck
jpeg_ll_rot_270=: 7: jpeg_xform d_xf_nm d_fn_ck

NB. trimming allowed gives lossless tranforms when
NB. no extension is needed and otherwise is slightly lossy
jpeg_flip_h=: 65"_ jpeg_xform d_xf_nm d_fn_ck
jpeg_flip_v=: 66"_ jpeg_xform d_xf_nm d_fn_ck
jpeg_transpose=:  67"_ jpeg_xform d_xf_nm d_fn_ck
jpeg_transverse=: 68"_ jpeg_xform d_xf_nm d_fn_ck
jpeg_rot_90=:  69"_ jpeg_xform d_xf_nm d_fn_ck
jpeg_rot_180=: 70"_ jpeg_xform d_xf_nm d_fn_ck
jpeg_rot_270=: 71"_ jpeg_xform d_xf_nm d_fn_ck

NB. exif_info 'filename'
NB. gives information from jpeg exif tag
exif_info=: 3 : 0
r=:'exif_info + i *c *i *i *i *i' zjm (boxopen y),(4#<,0)
if. _1={.>{.r do. 
	'error' return.
end.
c=:{.>2{r
flags=:memr (>3{r),0,c,JINT
names=:(3 : '<memr y,0,_1,JCHAR')"0 memr (>4{r),0,c,JINT
datap=:memr (>5{r),0,c,JINT
data=:(((3 : '< (y{datap)')`(3 : '<memr (y{datap),0,_1,JCHAR'))@.({&(1{"1 #:flags)))"0 i.c
4!:55<'datap'
'exif_free + n i i i i' zjm {.&.> 2 3 4 5{r
(<"0 #.2}."1 #: flags),.names,.data
)

NB. ***********************
NB. ***  PNG functions  ***
NB. ***********************

png_compression=: _1  NB. default
                      NB. 0 best speed
                      NB. 9 best compression

NB. returns width, height, components, bit depth, PNG color type, max. # of pal entries
png_get_info=: 3 : 0
a=.'png_get_info + i *c *i *i *i *i *i *i' zjm (<y),(,&.> ;/ 6$0)
if. _1=>{.a do. _1 return. end.
,>2}.a
)

NB. png_wh 'filename' gets the width and height of the image
png_wh=: 2&{.@png_get_info

NB. png_whd 'filename' gets the width and height and bit depth of the image
png_whd=: 3&{.@png_get_info

NB. raw_read_png 'filename' results in a h by w by 3 array of bytes
NB. giving the RGB values of the corresponding pixels
raw_read_png=: 3 : 0
sz=.*/ whd=.png_whd y
addr=.mema sz
a=.>{.'png_to_mem + i *c i i *i' zjm y;addr;0;,0
if. _1=a do. _1 return. end.
data=.memr addr,0,sz
memf addr
(1 0 2{whd)$data
)

NB. read_png 'filename' results in a h by w by 3 array of integers 
NB. giving the RGB values of the corresponding pixels
read_png=: a.&i.@raw_read_png

NB. 'p b'=:pal_read_png 'filename' results in a palette p and 
NB. a matrix b of indices
pal_read_png=: 3 : 0
sz=.*/ whd=.3{. pi=.png_get_info y
pc=.{:pi
if. 0=pc do. 'not a paletted image' return. end.
pa=.mema 3*pc
addr=.mema sz
a=.'png_to_mem + i *c i i *i' zjm y;addr;pa;(,0)
if. _1=>{.a do.
	memf&.> pa;addr
	_1 return. end.
pc=.{.>{:a
pal=.memr pa,0,(3*pc)
data=.memr addr,0,sz
memf&.> addr;pa
((pc,3)$a.i.pal);((1 0{whd)$a.i.data)
)

NB. [png_compression] array write_png filename
write_png=: 1 : 0
png_compression m write_png y
:
if. 32=(3!:0) m do.
	'p b'=.m
	p=.,p{a.
	m=.b{a.
	paddr=.mema #p
	p memw paddr,0,#p
else. paddr=.0 end.
if. 4=(3!:0) m do. m=.m{a. end.
sz=.*/$m
addr=.mema sz
(,m) memw addr,0,sz
'mem_to_png + i *c i i i i i i i' zjm (y;addr),(;/ 1 0 2{($m),1),((>:x);paddr;((#@(p"_))^:* paddr))
memf addr
(memf)^:(*) paddr
fsize y
)

NB. ***********************
NB. ***  TGA functions  ***
NB. ***********************

NB. z=.raw_read_tga 'filename'  results in binary array z
raw_read_tga=:3 : 0
s=.|.3,_1 lic _4{.16{.z=.fread y
|."1 s$18}.z
)

NB. read image as an integer array
read_tga=:a.&i.@raw_read_tga

NB. B write_tga 'outfile'   ; write array to tga
write_tga =: 4 : 0
if. 32=(3!:0) x do. x=.{~&>/x end. NB. promote paletted
if. 4=(3!:0) x do. x=.x{a. end.    NB. make raw
headtga=.a.{~(2 1 9#0 2 0),(,|."1 (2#256)#:1 0{$x),24 32
(headtga,,|."1 x) fwrite y
)

NB. width and height of a tga image
tga_wh=:_1&lic@:(1!:11)@:(];12 4"_)

NB. *************************************************
NB. *** PGM & PPM (PNM Portable aNyMap functions) ***
NB. *************************************************

NB. pgm are grayscale images

raw_read_pgm=: 3 : 0
a=.fread y
if. -.'P5'-:2{.a do. 'not a rawbits pgm' return. end.
hl=. i:&3 (#@". ::4:)\  hd=.(LF,' ') charsub 2}.40{.a
'w h d'=.".hl{.hd
if. d>255 do. 'max color > 255 not supported' return. end.
(h,w,1)$(3+hl)}.a
)

read_pgm=:a.&i.@raw_read_pgm

write_pgm=: 4 : 0
if. 32=(3!:0) x do. x=.{~&>/x end. NB. promote paletted
if. 3={:$x do.
  if. 2=(3!:0)x do. x=.a.i.x end.
  x=.,@<.@(+/ %#)"1 x
  end.
if. 4=(3!:0) x do. x=.x{a. end.
h=.'P5 ',(":|.2{.$x),' 255',LF
(h,,x) fwrite y
)

NB. ppm 24-bit rgb
write_ppm=: 4 : 0
if. 32=(3!:0) x do. x=.{~&>/x end. NB. promote paletted
if. 4=(3!:0) x do. x=.x{a. end.
h=.'P6 ',(":|.2{.$x),' 255',LF
(h,,x) fwrite y
)

raw_read_ppm=: 3 : 0
a=.fread y
if. -.'P6'-:2{.a do. 'not a rawbits ppm' return. end.
hl=. i:&3 (#@". ::4:)\  hd=.(LF,' ') charsub 2}.40{.a
'w h d'=.".hl{.hd
if. d>255 do. 'max color > 255 not supported' return. end.
(h,w,3)$(3+hl)}.a
)

read_ppm=:a.&i.@raw_read_ppm

NB. pnm Portable AnyMap; here combining supported pgm ppm types

raw_read_pnm=: 3 : 0
a=.1!:11 y;0 2
if. 'P' ~: 0{a do. 'not a pnm' return. end.
select. 1{a
  case. '1' do. 'no read plain images / no read pbm, period.'
  case. '2' do. 'no_read_plain_images'
  case. '3' do. 'no_read_plain_images'
  case. '4' do. 'no_read_pbm. sorry. these are 24bit tools.'
  case. '5' do. raw_read_pgm y
  case. '6' do. raw_read_ppm y
  case. do. 'not a pnm type supported.'
end.
)

read_pnm=:a.&i.@raw_read_pnm

err_axis=:'image cannot be written -- trailing axis size unsupported.'"_
err_alpha=:'image cannot be written -- pnm does not support alpha channels.'"_

write_pnm=: 4 : 'x (err_axis`write_pgm`err_alpha`write_ppm`err_alpha`err_axis@.(5<.1:`{:@.(#=3:) $x)) y'

NB. pnm_wh filename gives w h for PGM PPM PNM files with 15 byte headers
pnm_wh=: 3 : 0
a=.1!:11 y;0 40
if. -.('P'-:0{a) do. 'not a pnm' return. end.
hl=. i:&3 (#@". ::4:)\  hd=.(LF,' ') charsub 2}.a
2{.".hl{.hd
)

NB. **********************************
NB. ***  Combined image functions  ***
NB. **********************************

NB. number the supported filename extensions
NB.ext_type=:('bmp';'jpg';'jpeg';'png';'tga')&i.@<@to_lc@fn_ext
ext_type=:('bmp';'jpg';'jpeg';'png';'tga';'pgm';'ppm';'pnm';'mov';'avi')&i.@<@to_lc@fn_ext

NB. error message for when unsupported extensions are encountered
ext_err=:'unsupported file extension'"_

NB. Read a binary h by w by 3 array if filename extension is supported
NB. z=.raw_read_image 'filename'
NB.raw_read_image=:raw_read_bmp`raw_read_jpeg`raw_read_jpeg`raw_read_png`raw_read_tga`ext_err@.ext_type
raw_read_image=:raw_read_bmp`raw_read_jpeg`raw_read_jpeg`raw_read_png`raw_read_tga`raw_read_pgm`raw_read_ppm`raw_read_pnm`raw_read_mov`raw_read_avi`ext_err@.ext_type`_1:@.(-.@fexist)

NB. read array as integers
NB.read_image=:read_bmp`read_jpeg`read_jpeg`read_png`read_tga`ext_err@.ext_type
read_image=:read_bmp`read_jpeg`read_jpeg`read_png`read_tga`read_pgm`read_ppm`read_pnm`read_mov`read_avi`ext_err@.ext_type`_1:@.(-.@fexist)

NB. write array to file
NB. [options] B write_image filename
NB. writes the data in array B to the file "filename" using
NB. the filename extension for type
write_image=:1 : 0
select. to_lc fn_ext y
  case. 'bmp'  do. m write_bmp y
  case. 'jpg'  do. m write_jpeg y
  case. 'jpeg' do. m write_jpeg y
  case. 'png'  do. m write_png y
  case. 'tga'  do. m write_tga y
  case. 'pgm'  do. m write_pgm y
  case. 'ppm'  do. m write_ppm y
  case. 'pnm'  do. m write_pnm y
  case.  do.       m ext_err y
end.
:
select. to_lc fn_ext y
  case. 'jpg'  do. x m write_jpeg y
  case. 'jpeg' do. x m write_jpeg y
  case. 'png'  do. x m write_png y
  case.  do.       'unsupported extension or options'
end.
)

NB. [options] conv_image infile ; outfile
NB. converts the source file (infile) to the target format based
NB. upon filename extensions. Boxed arrays of names are required.
conv_image=: 3 : 0"1
(read_image >{.y) write_image >{:y
:
if. -. fexist >{.y do. _1 return. end.
x (read_image >{.y) write_image >{:y
)

NB. get image width and height for supported filename extensions
NB.image_wh=:bmp_wh`jpeg_wh`jpeg_wh`png_wh`tga_wh`ext_err@.ext_type
image_wh=:bmp_wh`jpeg_wh`jpeg_wh`png_wh`tga_wh`pnm_wh`pnm_wh`pnm_wh`mov_wh`avi_wh`ext_err@.ext_type`_1:@.(-.@fexist)

NB. A couple image manipulation tools
NB. used to resize or for paletted images

NB. Hue y
NB. gives a pure hue running through red-yellow-green-cyan-blue-magenta-red
NB. as y runs from 0 to 1
NB. A function with similar facilities is named "hue" in raster5.ijs
NB. and is renamed "Hue" here to avoid name conflicts.
Hue=:<.@(255.9999&*)@((-.,])@(1&|)+/ . *{&(#:7|3^10-i.8)@(0 1&+)@<.)@(6&*)"0

NB. (width_bdd,height_bdd) resize_image image_array
NB. resizes a 2 or 3 dimensional array, preserving
NB. aspect ratio so that it fits in new bounds.
resize_image=: 4 : 0
szi=.2{.$y
szo=.<.szi*<./(|.x)%szi
ind=.(<"0 szi%szo) <.@*&.> <@i."0 szo
(<ind){y
)

NB. [pal_size] quantize_image imagearrary
NB. uses octree paletting
quantize_image=: 3 : 0
256 quantize_image y
:
if. 4=(3!:0) y do. y=.y{a. end.
'h w d'=.$y
sz=.{.*/$y
addr=.mema sz
add2=.mema w*h
add3=.mema 3*x
(,y) memw addr,0,sz
a=.>{: 'octree_quantize + i i i i i i i *i' zjm w;h;addr;add2;add3;x;(,0)
p=.(a,3)$a.i.(memr add3,0,(3*a))
b=.(2{.$y)$a.i.(memr add2,0,(w*h))
memf add3
memf add2
memf addr
p;b
)

NB. [pal_size[,sampling]] quantize_image imagearray
NB. quantization function
NB. uses neural net paletting
quantize_image_nn=: 3 : 0
256 12 quantize_image_nn y
:
'entries sampling'=.x,(#x)}.256 12
if. 4=(3!:0) y do. y=.y{a. end.
sz=.{.*/$y
addr=.mema sz
add2=.mema (<. sz % 3)
add3=.mema 3*entries
(,y) memw addr,0,sz
'quantize + n i i i i i i' zjm addr;sz;sampling;add2;add3;entries
p=.(entries,3)$a.i.(memr add3,0,(3*entries))
b=.(2{.$y)$a.i.(memr add2,0,(<. sz % 3))
memf addr
memf add2
memf add3
p;b
)

NB. dll versioning
image_version=: 3 : '((2 3"_ { ]) , ([: {. a."_) cut [: > 4: { ]) ''image_version + n i *i *i *c i'' zjm 4;(,1);(,1);(128${.a.);127'
