NB. general/dirutils
NB. Verbs for extending the dir.ijs system library

require 'dir'

coclass 'rgsdirutils'

3 :0''  NB. hack to maintain J6 compatibility
if. 7 > 0". 1{ 9!:14'' 
 do.   SEP=: PATHSEP_j_   NB. J6
 else. SEP=: '/'          NB. J7
end.
)

NB. termsep v Terminates non-empty path with path separator
termsep=: , ((0 < #) # '/' -. {:)
NB. remsep v Removes trailing path separator if present
remsep=: }:^:(SEP={:)

NB.*dircreate v Create directory(s)
NB. form: dircreate DirectoryNames
NB. returns: boolean list of whether directory path was created
NB. y is: literal or boxed list of directory pathname(s) to create
NB. eg:   dircreate 'c:\temp\newdir1';'c:\temp\newdir1\child'
NB. parent-directories must be created before their children
NB. if user account calling createdir doesn't have
NB. read permission for already existing parent directories.
NB. looks like they don't exist and interface error when try to create
dircreate=: 3 : 0
  y=. boxxopen y
  msk=. -.direxist y
  if. ''-:$msk do. msk=. (#y)#msk end.
  res=. 1!:5 msk#y
  msk #inv ,res
)

NB.*direxist v Checks directory(s) exists
NB. form: direxist DirectoryPathnames
NB. returns: boolean list of whether directory path exists
NB. y is: literal or boxed list of directory pathname(s)
direxist=: 2 = ftype&>@: boxopen

NB. ftype v Returns file type of path y
NB. returns: 0 = not exist or empty UNC share
NB.          1 = file
NB.          2 = directory/folder
NB. This verb is an extended version of ftype from the files script
NB. It contains a workaround to handle the fact that 1!:0 does not 
NB. return a result for a bare UNC share 
NB. i.e. 0 = # 1!:0 '\\server\share'
ftype=: 3 : 0
'ftype does not support wildcards' assert y -.@e. '?*'
d=. (}: ^: (SEP={:)) ucp y
if. *./ ((1 = SEP +/@:= 2&}.) , SEP = 2&{.) d do. NB. UNC share
  d=. 1!:0 fboxname d,SEP,'*'
  (0 < #d) { 0 2                                  NB. non-empty?
else.
  d=. 1!:0 fboxname d
  if. #d do.
    >: 'd' = 4 { > 4 { ,d
  else.
    0
  end.
end.
)

NB.*pathcreate v Create non-existing directories in a path
NB. form: pathcreate DirectoryPathname
NB. returns: numeric list of 1s for each directory created.
NB. y is: literal directory path to create (no filename at end).
NB. eg:   pathcreate 'c:\temp\newdir1\child'
pathcreate=: 3 : 0
  todir=. termsep jpathsep y
  todirs=. }. ,each /\ <;.2 todir NB. base dirs
  msk=. -.direxist todirs NB. 1 for each non-existing dir
  NB. zero any 1s before last 0 because the dir must
  NB. exist so user probably just has no read permissions
  NB. for high level parent dirs.
  msk=. 0 (i. msk i: 0)}msk
  dircreate msk#todirs NB. create non-existing base dirs
)

NB. =========================================================
NB. Verbs to be created in z locale

dircreate_z_=: dircreate_rgsdirutils_
direxist_z_=: direxist_rgsdirutils_
pathcreate_z_=: pathcreate_rgsdirutils_
