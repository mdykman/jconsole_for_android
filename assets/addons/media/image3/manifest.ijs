NB. image3 manifest

CAPTION=: 'Utilities for accessing 24-bit jpeg, png, bmp, tga and portable anymaps in J.'

DESCRIPTION=: 0 : 0
The Image 3 package provides utilities for accessing 24-bit jpeg, png, bmp, tga and portable anymaps in J. The core functions allow reading and writing image files as 3-dimensional J arrays. The core jpeg and png utilities are accomplished using calls to the included dll. These external libraries are based on open source code.

The addon includes several scripts. The main script, image3.ijs, provides J functions for the basic image reading, writing,and image size either through library calls or directly defined J functions. Another script, html_gallery8.ijs, provides J functions that create thumbnails and image galleries under J program control. Sample scripts and a rotation form script are also included.

Only supported in 32-bit platforms and partially supported in J701.
)

VERSION=: '1.0.4'

RELEASE=: 'j601 j602 j701'

LABCATEGORY=: 'Media'

PLATFORMS=: 'win linux darwin'

FILES=: 0 : 0
help/
anins2.ijs
atkiln.jpg
color_space.ijs
filter1.ijs
html_gallery8.ijs
hy_fly_di.png
image3.ijs
image3.ijt
image3_unix_ini.ijs
image3_win_ini.ijs
image3html.ijt
image3movie.ijt
manifest.ijs
movie3.ijs
prevare.ijs
sample1.ijs
sample2.ijs
text_image.ijs
transform_m.ijs
view_m.ijs
)

FILESWIN=: 0 : 0
image3.dll
pthreadgc.dll
)

FILESLINUX=: 0 : 0
libimage3.so
)

FILESDARWIN=: 0 : 0
libimage3.dylib
)
