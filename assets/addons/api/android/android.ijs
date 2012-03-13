cocurrent 'droid'

NB. anddf_z_ usage: x anddf y
NB. download a file via android's embedded http client overwriting target file. ie:
NB.    'http://www.jsoftware.com/moin_static180/common/jwlogo.png' anddf jpath'~temp/jwlogo.png'
NB.
NB. returns
NB.  >=0 success, number of bytes in file
NB.  _1 unknown error
NB.  _2 target file exists and is not writable
NB.  _3 parent directory is not writable
NB.  _5 malformed url
NB.  _6 i/o exception during transport
NB.  _99 web request returns invalid '0' status code
NB.  <= _100 negation of unsuccessful http response code (!=200), ie. _404 "Not Found"

anddf=: 4 : '>{. ''libj.so android_download_file i *c *c'' 15!:0 x;y'
NB. url for test image
andurl =:'http://www.jsoftware.com/moin_static180/common/jwlogo.png'

NB. andunzip_z_ usage: andunzip y ; x andunzip y
NB. monadically, it unzips the file at y into the same directory
NB. x may specify an alternate output directory
NB. returns
NB.  0 success
NB.  _1 generic i/o error
NB.  _2 zipfile not found
NB.  _3 output directory not writable
NB.  _4 zip format exception

andunzip =: 3 : 0
 '' andunzip y
:
 >{. 'libj.so java_unzip_file i *c *c' 15!:0 y;x
)
