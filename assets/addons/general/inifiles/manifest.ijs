NB. inifiles manifest

CAPTION=: 'Platform neutral interface for INI files'

DESCRIPTION=: 0 : 0
Reads/writes one (or more) keys from/to files in INI format.
The INI files source can be files stored on disk, or a string read from a database or zip file.
Uses regex funtionality built into J to parse INI formats and is therefore not dependent on Windows API.

Copyright 2008 (C) Ric Sherlock
)

LABCATEGORY=: 'General'

VERSION=: '1.0.7'

RELEASE=: 'j602 j701'

PLATFORMS=: 'win linux darwin'

FILES=: 0 : 0
history.txt
manifest.ijs
inifiles.ijs
test/test_inifiles.ijs
test/test.ini
)
