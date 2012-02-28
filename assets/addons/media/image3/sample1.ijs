NB. Sample 1; Image 3 addon 
NB. Cliff Reiter, reiter@lafayette.edu
NB. November, 2002
NB. modified for J6.01, Sept 2006
NB. 
NB. Basic example script of usual steps used to create
NB. an image gallery from a set of images from a digital camera
NB. modify and run (ctrl-r) the steps suited to your situation
NB. Standard advice: work on copies of your files

NB. load prevare.ijs
load 'media/image3/prevare.ijs'

NB. define the path to point to your images 
path=:'\i\2002\03_hike\'

NB. make image names all lower case (if desired)
dir_to_lc path

NB. preview and rotate images if desired 
NB. and create the html gallery via buttons and menus
prevare images_in path

