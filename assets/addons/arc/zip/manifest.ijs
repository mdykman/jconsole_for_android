NB. zip manifest

CAPTION=: 'zip file utilities'

DESCRIPTION=: 0 : 0
Zip file utilities based on zlib 1.2.3 and minizip libraries. 
Interface API is similar to the files package. 
Includes Win32, Linux and Mac OS X universal binaries. 
For details see J Wiki.

Copyright 2006-2007 (C) Oleg Kobchenko
)

LABCATEGORY=: 'Archives'

VERSION=: '1.1.2'

RELEASE=: 'j602 j701'

PLATFORMS=: 'win linux darwin'

DEPENDS=: 0 : 0
convert/misc/ascii85
)

FILES=: 0 : 0
history.txt
manifest.ijs
zfiles.ijs
zbuffer.ijs
doc/README_minizip.txt
doc/README_zlib.txt
lib/zlibapi.zip
test/test.ijs
test/test.zip
)

FILESWIN=: 0 : 0
lib/zlibwapi.dll
)

FILESLINUX=: 0 : 0
lib/zlibapi.so
lib/zlibapi64.so
)

FILESLINUX64=: 0 : 0
lib/zlibapi64.so
)

FILESDARWIN=: 0 : 0
lib/libzlib.dylib
)
