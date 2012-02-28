NB. This movie3.ijs script provides functions for working with
NB. simple *.mov annimation files from J. They are designed
NB. to be used with the image3 addonNB. The core utilities use
NB. libraries (*.dll *.so) calls which were
NB. created by Zachary Reiter based upon open sources.
NB. For information regarding the copyrights of the software used,
NB. please see the included file COPYRIGHTS in the help directory
NB. This script was written by
NB.   Zachary X. Reiter and Clifford A. Reiter
NB.   November 2002
NB. modified for J6.01, Sept 2006
NB.
NB. The script begins with the core quicktime calls. Higher level
NB. utilities and faciltities makig *.mov compatible with image3 tools
NB. appear toward the end of this script.

NB. locale for image3 addon
coinsert 'ima3'
coclass 'ima3'

NB. Boot section:

NB. display error if not 32-bit linux/PC
3 : 0''
if. IF64 +. IFUNIX +: IFWIN do.
  if. IFJ6 do.
    wd 'mb "" "Unsupported Platform" '
  else.
    sminfo '';'Unsupported Platform'
  end.
end.
if. IFJ6 do.
  dir_sep=:PATHSEP_j_
else.
  dir_sep=:'/'
end.
''
)

NB. path to the addon library (dll, so) needs to be correct.
addon_path=: jpath '~addons/media/image3/'

NB. require the image3 script
require addon_path,'image3.ijs'

NB. **** Begin video section ****

NB. Get track counts
NB. 'audio video'=.qt_track_count 'filename.mov'
qt_track_count=: 3 : ', > 2 3 { ''quicktime_file_info + i *c *i *i'' zjm y;(,0);(,0)'

NB. get track info
NB. 'width height components frames'=.qt_track_info 'filename.mov'
qt_track_info=: 3 : 0
0 qt_track_info y
:
, > 3 4 5 6 { 'quicktime_video_track_info + i *c i *i *i *i *i' zjm y;x;(4#<,0)
)

NB. Get frame size
NB. Track Frame qt_frame_sz FileName
qt_frame_sz=: 3 : 0
0 0 qt_frame_sz y
:
> {. 'quicktime_video_frame_size + i *c i i' zjm y; ;/x
)

NB. read one frame
NB. B=.qt_read_one_frame 'filename'
qt_read_one_frame=: 3 : 0
0 0 qt_read_one_frame y
:
dims=.y qt_track_info~ {.x
sz=. */ }: dims
addr=.mema sz
ret=.>{. 'quicktime_read_single_frame + i *c i i i' zjm y;(;/x),<addr
dat=.memr addr,0,sz
memf addr
(1 0 2{dims)$dat
)

NB. Low level utilities
qt_read_open_file=: 3 : '>{.''quicktime_open + i *c i i'' zjm y;1;0'
qt_close_file=: 3 : 'empty (''quicktime_close + n i'' zjm <y)'
qt_video_seek=: 4 : 'empty (''quicktime_set_video_position + i i i i'' zjm y; ;/x)'
qt_track_info2=: 3 : 0
0 qt_track_info2 y
:
w=.>{.'quicktime_video_width + i i i' zjm y;x
h=.>{.'quicktime_video_height + i i i' zjm y;x
d=.<. 8 %~ >{.'quicktime_video_depth + i i i' zjm y;x
f=.>{.'quicktime_video_length + i i i' zjm y;x
w,h,d,f
)

qt_next_frame=: 3 : 0
0 qt_next_frame y
:
dims=.x qt_track_info2 y
sz=.*/ }: dims
addr=.mema sz
ret=.>{.'quicktime_read_next_frame + i i i i' zjm y;x;addr
dat=.memr addr,0,sz
memf addr
(1,(1 0 2{dims))$dat
)

qt_read_all_frames=:] (] , (qt_next_frame@[))^:({:@qt_track_info2@[) i.@(4: # 0:)
qt_get_all_frames=:(qt_close_file ] qt_read_all_frames)@qt_read_open_file

NB. more information functions. take a *HANDLE*
qt_frame_rate=:>@{.@('quicktime_frame_rate + f i i' zjm)@(] ; [)
qt_compressor_name=:memr@,&0 4@>@{.@('quicktime_video_compressor + *c i i' zjm)@(] ; [)


NB. Writing functions
qt_write_open_file=:>@{.@('quicktime_open + i *c i i' zjm)@(] ; 0: ; 1:)
NB. FrameRate;Compressor Width,Height,TRACKS qt_write_setup Handle
qt_write_setup=: 1 : 0
NB. MUST be called b4 write frame || SegFault!
((1%~15);'jpeg') m qt_write_setup y
:
'quicktime_set_video + n i i i i f *c' zjm y;(;/2 0 1{m),x
empty''
)

qt_codec_ok=:>@{.@('quicktime_supported_video + i i i' zjm)@(] ; [)
qt_write_one_frame=: 1 : 0
0 m qt_write_one_frame y
:
addr=.mema */$m
(,m) memw addr,0,(*/$m)
'quicktime_write_single_frame + i i i i' zjm y;x;addr
memf addr
empty''
)
qt_all_int=: 4 : '0 x qt_write_one_frame y'
qt_write_all_frames=:empty@(] ((}.@] [ ({.@] qt_all_int [))^:({.@$@])) [)

NB.
NB. Just use compose, says dad.
movie_image_dir=:raw_read_image&>@images_in

NB. qt_png_set_opts qt_handle png_compression
qt_png_set_opts=:'quicktime_set_png + n i i' zjm
NB. qt_jpeg_set_opts qt_handle jpeg_quality jpeg_usefloat
qt_jpeg_set_opts=:'quicktime_set_jpeg + n i i i' zjm

qtjpeg_xform=: 4 : '''quicktime_f2f_jpeg_transform + i *c *c i i'' zjm y,(0;x)'

qtjpeg_ll_flip_h=:	1: qtjpeg_xform d_xf_nm d_fn_ck
qtjpeg_ll_flip_v=:	2: qtjpeg_xform d_xf_nm d_fn_ck
qtjpeg_ll_transpose=:	3: qtjpeg_xform d_xf_nm d_fn_ck
qtjpeg_ll_transverse=:	4: qtjpeg_xform d_xf_nm d_fn_ck
qtjpeg_ll_rot_90=:	5: qtjpeg_xform d_xf_nm d_fn_ck
qtjpeg_ll_rot_180=:	6: qtjpeg_xform d_xf_nm d_fn_ck
qtjpeg_ll_rot_270=:	7: qtjpeg_xform d_xf_nm d_fn_ck
qtjpeg_flip_h=:		65"_ qtjpeg_xform d_xf_nm d_fn_ck
qtjpeg_flip_v=:		66"_ qtjpeg_xform d_xf_nm d_fn_ck
qtjpeg_transpose=:	67"_ qtjpeg_xform d_xf_nm d_fn_ck
qtjpeg_transverse=:	68"_ qtjpeg_xform d_xf_nm d_fn_ck
qtjpeg_rot_90=:		69"_ qtjpeg_xform d_xf_nm d_fn_ck
qtjpeg_rot_180=:	70"_ qtjpeg_xform d_xf_nm d_fn_ck
qtjpeg_rot_270=:	71"_ qtjpeg_xform d_xf_nm d_fn_ck

NB. quantize an image multiple times & converts it back to rgb
NB. Ex: (raw_read_image addon_path,'atkiln.jpg') mk_pal_seq 32*>:i.8
mk_pal_seq=:>@({&a.@{~&.>/"1@((] quantize_image [)"_ 0))

NB. most important additions for movie3:
NB. consider rot_mov/mk_zoom above too
mov_wh=:0 1&{@:qt_track_info
mov_l=:3&{@:qt_track_info
raw_read_mov=:qt_read_one_frame"1 _
read_mov=:a.&i.@:raw_read_mov

NB. Sample code....
NB. all_frames=.qt_get_all_frames 'dscn2785.mov'	NB. reads all frames from dscn2785.mov into a Frames*Height*Width*3 raw character array
NB. out_handle=.qt_write_open_file 'copy.mov'		NB. opens copy.mov for quicktime writing
NB. ((15%1);'png ') 320 240 1 qt_write_setup out_handle	NB. sets writing parameters for out_hanlde: (15fps (%1 used to make it floating);
							NB. 'png ' codec (one of: 'raw ' 'DIVX' 'jpeg' 'mjpa' 'yuv2' 'yuv4' 'v308' 'v410')
							NB. 320x240 width*height images will be supplied for a total of 1 tracks.
NB. all_frames qt_write_all_frames out_handle		NB. write all the frames from all_frames to out_handle
NB. qt_close_file out_handle				NB. closes the handle.  must to called to ensure header is valid!
nofile_error=:3 : 0
if. IFJ6 do.
  wd 'mb "File Read Error" "File does not exist"'
else.
  sminfo 'File Read Error';'File does not exist'
end.
)

on_frames=:1 : 0
0 u on_frames y
:
'fi fo'=.y
if. -. fexist fi do. nofile_error ''
   return. end.
'w h d n'=.qt_track_info fi
who=.1 0{$u 0 0 qt_read_one_frame fi
fih=.qt_read_open_file fi
ct=.x qt_compressor_name fih
fr=.x qt_frame_rate fih
qt_close_file fh
fh=.qt_write_open_file fo
(fr;ct) (who,1) qt_write_setup fh
for_k. i.n do.
  (u (x,k)qt_read_one_frame fi) qt_all_int fh
end.
qt_close_file fh
)

NB. Creates a movie giving a zoom into an image
NB. [endxy_pixels vid_wh num_frames framerate] mk_zoom fn_image_in;fn_movie_out
mk_zoom=:3 : 0
0 0 320 240 30 15 mk_zoom y
:
'fi fo'=.y
'x y w h n fr'=.x
b=.raw_read_image fi
d=.<.(x,y)*"1 0(i.%<:)n
wh0=.1 0{$b
wh=.<.0.5+wh0-"1(wh0-w,h)*"1 0 (i.%<:)n
fh=.qt_write_open_file fo
((fr%1);'jpeg') (w,h,1) qt_write_setup fh
for_k. i.n do.
  ((h,w){.!.({.a.)(w,h) resize_image (|.k{wh){.(|.k{d)}.b) qt_all_int fh
end.
qt_close_file fh
)

NB. framerate 'type' fseq_to_mov (boxed_list_of_in_files);'output.mov'
NB. where 'type' is 'jpeg' or 'png ' (note space).
fseq_to_mov=:1 : 0
15 m fseq_to_mov y
:
'fi fo'=.y
'w h'=.image_wh >{.fi
fh=.qt_write_open_file fo
((x%1);m) (w,h,1) qt_write_setup fh
for_k. i. #fi do.
  (raw_read_image >k{fi) qt_all_int fh
end.
qt_close_file fh
)

NB. framerate fseq_to_png_mov (boxed_list_of_in_files);'output.mov'
fseq_to_png_mov=: 'png ' fseq_to_mov
fseq_to_jpeg_mov=: 'jpeg' fseq_to_mov

NB. 'infile' mov_to_fseq extension outfileprefix
NB. writes the frames of the movie to the indicated file sequence
mov_to_fseq=:2 : 0
len=.mov_l m
dig=.>.10^.len
for_k. i. len do.
  ((0,k) read_mov m)write_image y,(dig nfmt k),'.',n
end.
)

NB. [frame_num] read_avi 'filename'
read_avi=: a.&i.@:raw_read_avi

NB. avi_to_fseq 'infile';'first_outfile000.jpg'
avi_to_fseq=: 3 : 0
'fn_in fn_out'=.y
k=.0   NB. frame counter
n0=.avi_l fn_in
while. k<n0 do.
  b=.k raw_read_avi fn_in 
  b write_image fn_out
  k=.>:k
  fn_out=.nx_fn fn_out
end.
k
)

NB. new stuff.  feel free to organize it.
0 : 0
lav_file_t *lav_open_output_file(char *filename, char format,
                    int width, int height, int interlaced, double fps,
                    int asize, int achans, long arate);
int  lav_close(lav_file_t *lav_file);
int  lav_write_frame(lav_file_t *lav_file, uint8_t *buff, long size, long
count);
int  lav_write_audio(lav_file_t *lav_file, uint8_t *buff, long samps);
long lav_video_frames(lav_file_t *lav_file);
int  lav_video_width(lav_file_t *lav_file);
int  lav_video_height(lav_file_t *lav_file);
double lav_frame_rate(lav_file_t *lav_file);
int  lav_video_interlacing(lav_file_t *lav_file);
void lav_video_sampleaspect(lav_file_t *lav_file, int *sar_w, int *sar_h);
int  lav_video_is_MJPG(lav_file_t *lav_file);
int  lav_video_MJPG_chroma(lav_file_t *lav_file);
const char *lav_video_compressor(lav_file_t *lav_file);
int  lav_audio_channels(lav_file_t *lav_file);
int  lav_audio_bits(lav_file_t *lav_file);
long lav_audio_rate(lav_file_t *lav_file);
long lav_audio_samples(lav_file_t *lav_file);
long lav_frame_size(lav_file_t *lav_file, long frame);
int  lav_seek_start(lav_file_t *lav_file);
int  lav_set_video_position(lav_file_t *lav_file, long frame);
int  lav_read_frame(lav_file_t *lav_file, uint8_t *vidbuf);
int  lav_set_audio_position(lav_file_t *lav_file, long sample);
long lav_read_audio(lav_file_t *lav_file, uint8_t *audbuf, long samps);
int  lav_filetype(lav_file_t *lav_file);
lav_file_t *lav_open_input_file(char *filename);
int  lav_get_field_size(uint8_t * jpegdata, long jpeglen);
const char *lav_strerror(void);
int  lav_fileno( lav_file_t *lav_file );
)

md=.magic_define=: 2 : '(x)=:((x,'' + '',y) zjm)'
'lav_open_output_file' md 'i *c c i i i d i i i'
'lav_close' md 'i i'
'lav_write_frame' md 'i i i i i'
'lav_write_audio' md 'i i i i'
'lav_video_frames' md 'i i'
'lav_video_width' md 'i i'
'lav_video_height' md 'i i'
'lav_frame_rate' md 'd i'


'lav_video_is_MJPG' md 'i i'

'lav_video_compressor' md '*c i'
'lav_audio_channels' md 'i i'
'lav_audio_bits' md 'i i'
'lav_audio_rate' md 'i i'
'lav_audio_samples' md 'i i'
'lav_frame_size' md 'i i i'
'lav_seek_start' md 'i i'
'lav_set_video_position' md 'i i i'
'lav_read_frame' md 'i i i'
'lav_set_audio_position' md 'i i i'
'lav_read_audio' md 'i i i i'
'lav_filetype' md 'i i'
'lav_open_input_file' md 'i *c'

'lav_strerror' md '*c'
'lav_fileno' md 'i i'

lav_wh=:lav_video_width,&(>@:{.)lav_video_height

lav_whd=:lav_wh,3:

0 : 0
 /*
 * jpeg_data:       buffer with input / output jpeg
 * len:             Length of jpeg buffer
 * itype:           LAV_INTER_NONE: Not interlaced
 *                  LAV_INTER_TOP_FIRST: Interlaced, top-field-first
 *                  LAV_INTER_BOTTOM_FIRST: Interlaced, bottom-field-first
 * ctype            Chroma format for decompression.
 *                  Currently always 420 and hence ignored.
 * raw0             buffer with input / output raw Y channel
 * raw1             buffer with input / output raw U/Cb channel
 * raw2             buffer with input / output raw V/Cr channel
 * width            width of Y channel (width of U/V is width/2)
 * height           height of Y channel (height of U/V is height/2)
 */

int decode_jpeg_raw (unsigned char *jpeg_data, int len,
                     int itype, int ctype, int width, int height,
                     unsigned char *raw0, unsigned char *raw1,
                     unsigned char *raw2);

int encode_jpeg_raw (unsigned char *jpeg_data, int len, int quality,
                     int itype, int ctype, int width, int height,
                     unsigned char *raw0, unsigned char *raw1,
                     unsigned char *raw2);
)

'decode_jpeg_raw' md 'i i i i i i i i i i'
'encode_jpeg_raw' md 'i i i i i i i i *c *c *c'

NB. Always thought these would come in handy !
NB.yuv_from_rgb_matrix=:(3 3 $ 65.738 129.057 25.064 _37.945 _74.494 112.439 112.439 _94.154 _18.825)%256
yuv_from_rgb_matrix=:3 3 $ (219r255 * 0.299 0.587 0.114) , ((112%(255*0.886))* _0.299 _0.587 0.886) , ((112%(255*0.701))* 0.701 _0.587 _0.114)
rgb_from_yuv_matrix=:%.yuv_from_rgb_matrix
base_rgb_to_yuv=.((16.5 128.5 128.5&+)@:(yuv_from_rgb_matrix"_ (+/ . * ) ]))"1
base_yuv_to_rgb=.((rgb_from_yuv_matrix"_ (+/ . *) ])@:(-&16.5 128.5 128.5))"1
convert_rgb_to_yuv=:<.@:base_rgb_to_yuv f.
convert_yuv_to_rgb=:255&<.@:(0&>.)@:<.@:base_yuv_to_rgb	f.	NB.(base_rgb_to_yuv^:_1)
rgb2yuv=:convert_rgb_to_yuv :. convert_yuv_to_rgb

subsample=:(2 2$2)"_ (([: <. +/ % #)@:,);._3 ]
upsample=:2&#"1@:(2&#)

NB. takes handle
lav_get_frame=: 4 : 0
sz=.>{.lav_frame_size y;x
addr=.mema sz
lav_set_video_position y;x
lav_read_frame y;addr
raw0=.mema sz0=.*/lav_wh y
raw1=.mema sz1=.>.0.25*sz0
raw2=.mema sz2=.sz1
'w h'=.lav_wh y
decode_jpeg_raw addr;sz;0;0;w;h;raw0;raw1;raw2
memf addr
w1=.>.0.5*w
h1=.>.0.5*h
ra0=.(,$~$,1:) (h,w)$memr raw0,0,sz0
ra1=.(,$~$,1:) upsample (h1,w1)$memr raw1,0,sz1
ra2=.(,$~$,1:) upsample (h1,w1)$memr raw2,0,sz2
memf&.> raw0;raw1;raw2
convert_yuv_to_rgb&.(a.&i.) (ra0 ,"1 ra1 ,"1 ra2)
)

lav_put_frame=: 4 : 0
if. 2=(3!:0) x do. x=.a.i.x end.
'h w d'=.$x
x=.convert_rgb_to_yuv x
Y=.a.{~ ,0{ "1 x
U=.a.{~ ,subsample 1{ "1 x
V=.a.{~ ,subsample 2{ "1 x
x=.0
addr=.mema obsz=.65536>.2*w*h
r=.>{. encode_jpeg_raw addr;obsz;jpeg_quality;0;0;w;h;Y;U;V
if. r < 0 do. 'encode_jpeg_raw failed' 13!:8]200 end.
if. 4|r do.
NB.	smoutput 'rounding from ',(":r),' to ',(":r+4-4|r)
	((4-4|r)#{:a.) memw addr,r,4-4|r
	r=.r+4-4|r
end.
lav_write_frame y;addr;r;1
memf addr
r
)

NB. [frame_num] raw_read_avi 'filename'
raw_read_avi=:3 : 0
0 raw_read_avi y
:
if. fexist y do.
  hnd=.>{.lav_open_input_file <y
  z=. x lav_get_frame hnd
  lav_close hnd
  else.
  z=._1
  end.
z
)

NB. avi_wh 'filename'
avi_wh=:3 : 0
if. fexist y do.
  hnd=.>{.lav_open_input_file <y
  z=. lav_wh hnd
  lav_close hnd
  else.
  z=._1
  end.
z
)

NB. avi_l 'filename'
NB. give the number of frames in the avi
avi_l=:3 : 0
if. fexist y do.
  hnd=.>{.lav_open_input_file <y
  z=. >{.lav_video_frames hnd
  lav_close hnd
  else.
  z=._1
  end.
z
)

NB. [fps] fseq_to_avi (boxed_list_of_in_files);'output.avi'
NB. using this to write avi's does not appear to be fully robust 
fseq_to_avi=: 3 : 0
25 fseq_to_avi y
:
'fn_in fn_out'=.y
k=.0   NB. frame counter
n0=.#fn_in
wh=.;/image_wh >{.fn_in
h=.>{.lav_open_output_file fn_out;'a';wh,0;(x%1.0);0;0;0
while. k<n0 do.
  b=.raw_read_image >k{fn_in 
  b lav_put_frame h
  k=.>:k
end.
lav_close h
k
)

copy_avi=: 3 : 0
'fi fo'=.y
hi=.>{.lav_open_input_file <fi
k=.0
NB. szs=:i.0
n0=.>{.lav_video_frames hi
ho=.>{.lav_open_output_file fo;'a';(>@{.@lav_video_width;>@{.@lav_video_height;0:;>@{.@lav_frame_rate;0:;0:;0:) hi
while. k<n0 do.
	addr=.mema sz=.>{.lav_frame_size hi;k
	lav_read_frame hi;addr
	lav_write_frame ho;addr;sz;1
	memf addr
	k=.>:k
NB.	szs=:szs,sz
end.
lav_close hi
lav_close ho
k
)

NB. set quiet output to standard error
'mjpeg_default_handler_verbosity + i i' zjm 0		NB. 0 = quiet, 1 = info, 2 = debug
