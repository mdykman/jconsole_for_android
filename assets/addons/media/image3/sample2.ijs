NB. A simple script for the image 3 addon meant to facilitate the
NB. maintain image galleries that evolve
NB. Cliff Reiter, November 2002

NB. load prevare.ijs
load 'media/image3/prevare.ijs'

NB. target path
path=:'\w\dept\gallery\2002_spring\'

NB. source path
spath=:path,'source\'

NB. use source to create web size versions of images in target
NB. exisiting target files of the corrct size are not replaced 
_1024 _1024 cond_mk_th_image (,.path&d_w_nm) images_in spath

NB. create or update an html gallery; attempts to preserve annotations
NB. on images and uses material from before and after the first table
3 update_html_gallery _360 _320 images_in path
