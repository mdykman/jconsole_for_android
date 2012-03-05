

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
NB.  <= _100 negation of unsuccessful http response code (!=200), ie. _500 "Server Error"

anddf_z_=: 4 : '>{. ''libj.so android_download_file i *c *c'' 15!:0 x;y'
andurl_z_ =:'http://www.jsoftware.com/moin_static180/common/jwlogo.png'
