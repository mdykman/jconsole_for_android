NB. general/dirtrees
NB. Copy and delete directory trees

require 'general/dirutils'

coclass 'rgsdirtrees'

NB.*copytree v Copies directory tree from directory y to directory x
NB. form: ToDir copytree FromDir
NB. returns: 2-item numeric list
NB.       0{ number of directories created
NB.       1{ number of files successfully copied
NB. Any existing files of the same name will be written over.
copytree=: 4 : 0
  'todir fromdir'=. termsep_rgsdirutils_ each x;y
  if. -.direxist fromdir do. 0 0 return. end. NB. exit if fromdir not found
  dprf=. ] }.&.>~ [: # [                      NB. drops #x chars from beginning of each y
  aprf=. ] ,&.>~ [: < [                       NB. catenates x to start of each y
  fromdirs=. }. dirpath fromdir
  todirs=. todir aprf fromdir dprf fromdirs
  fromfiles=. {."1 dirtree fromdir
  tofiles=. todir aprf fromdir dprf fromfiles
  resdir=. pathcreate todir
  resdir=. resdir, dircreate todirs
  resfile=. 0&< @>tofiles fcopy"0 fromfiles
  (+/resdir),+/resfile
)

NB.*deltree v Delete directory tree
NB. form: deltree DirectoryName
NB. returns: boolean
NB.       (1) if all files and folders in tree are deleted
NB.       (0) on error or if some cannot be deleted
NB. y is: literal filename of directory to delete
deltree=: 3 : 0
  try.
    res=. 0< ferase {."1 dirtree y
    *./ res,0<ferase |.dirpath y
  catch. 0 end.
)
NB. =========================================================
NB. Verbs local to rgstrees locale

NB.*fcopy v Copies file from one filename to another
NB. form: ToFile fcopy FromFile
fcopy=: fwrite~ fread

NB. =========================================================
NB. Declarations in z locale
copytree_z_=: copytree_rgsdirtrees_
deltree_z_=: deltree_rgsdirtrees_
