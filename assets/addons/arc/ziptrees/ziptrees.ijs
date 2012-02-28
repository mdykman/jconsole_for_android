NB. arc/ziptrees
NB. Zip and extract directory trees using the arc/zip addon

require 'arc/zip/zfiles general/dirutils'

coclass 'rgsztrees'

3 :0''  NB. hack to retain J6 compatibility
if. 7 > 0". 1{ 9!:14'' 
 do.   SEP=: PATHSEP_j_   NB. J6
 else. SEP=: '/'          NB. J7
end.
)

termsep=: termsep_rgsdirutils_

NB.*unziptree v Unzips zipfile y into directory x
NB. form: ToDir unziptree FromZip
NB. returns: 2-item numeric list
NB.       0{ number of directories created
NB.       1{ number of files successfully extracted
NB. Any existing files with the same filename will be written over.
unziptree=: 4 : 0
  'todir fromzip'=. x;y
  todir=. termsep todir
  if. -.fexist fromzip do. 0 0 return. end.      NB. exit if fromzip not found
  fromall=. /:~{."1 zdir fromzip
  dirmsk=. '/'={:@> fromall
  fromfiles=. (-.dirmsk)#fromall
  repps=. (<'/',SEP) charsub&.> ]                NB. replaces '/' with SEP
  aprf=. ] ,&.>~ [: < [                          NB. catenates x to start of each y
  tofiles=. repps fromfiles
  tofiles=. todir aprf tofiles
  fromfiles=. fromfiles,.<fromzip
  todirs=. repps dirmsk#fromall
  todirs=. ~.;(,each /\)@(<;.2) each todirs      NB. add names of any missing subdirectories
  todirs=. todir aprf todirs
  resdir=. pathcreate todir                      NB. create dirs in todir path if necessary
  resdir=. resdir, dircreate todirs              NB. create dirs from zip
  resfile=. 0&<@>tofiles zextract"0 1 fromfiles  NB. write files
  (+/resdir),+/resfile
)

NB.*ziptree v Zips directory tree y into zipfile x
NB. form: ToZip ziptree FromDir
NB. returns: 2-item numeric list
NB.       0{ number of directories written to zipfile
NB.       1{ number of files written to zipfile
ziptree=: 4 : 0
  'tozip fromdir'=. x;y
  if. -.direxist fromdir do. 0 0 return. end. NB. exit if fromdir not found
  repps=. (<SEP,'/') charsub&.> ]             NB. replaces SEP with '/'
  dprf=. ] }.&.>~ [: # [                      NB. drops #x chars from beginning of each y
  fromdir=. termsep fromdir
  fromdirs=. termsep each }.dirpath fromdir
  todirs=. repps fromdir dprf fromdirs
  todirs=. todirs,.<tozip
  fromfiles=. {."1 dirtree fromdir
  tofiles=. repps fromdir dprf fromfiles
  tofiles=. tofiles,.<tozip
  zipdir=. SEP dropto&.|. tozip
  resdir=. pathcreate zipdir                  NB. create dirs in tozip path if necessary
  resdir=. resdir, 0= (((#todirs),0)$'') zwrite"1 todirs NB. create dirs in tozip
  resfile=. 0&<@>tofiles zcompress"1 0 fromfiles
  (+/resdir),+/resfile
)

NB.*zipfiles v Adds/Appends one or more files to a zip file
NB. form: (ToZip[;DirInf]) zipfiles FileNames
NB. returns: 2-item numeric list
NB.       0{ number of directories written to zipfile
NB.       1{ number of files written to zipfile
NB. y is: boxed list of file names to zip
NB. x is: 1 or 2-item boxed list
NB.       0{ is name of zip file
NB.       1{ is optional info on what directory info to include in zip
NB.               (0) don't include any directory information
NB.               (1) include full directory paths
NB.              ('') (i.e. empty) (default) Base directory is highest directory common to all files.
NB.   (BaseDirPrefix) explicitly specify directory name to prefix base directory with
NB. eg:     tozip zipfiles fname1;fname2;fname3
NB. eg: (tozip;0) zipfiles fname1;fname2;fname3
NB. eg: (tozip;'testing/here') zipfiles fname1;fname2;fname3
NB. Adding a file that already exists in the zipfile will result in 2 copies in the zipfile.
zipfiles=: 4 : 0
  fromfiles=. boxopen y
  'tozip dirinf'=. 2{. boxopen x
  if. *./-.fexist @> fromfiles do. 0 return. end.      NB. stop if no fromfiles found
  repps=. (<SEP,'/') charsub&.> ]                      NB. replaces SEP with '/'
  dprf=. ] }.&.>~ [: # [                               NB. drops #x chars from beginning of each y
  aprf=. ] ,&.>~ [: < [                                NB. catenates x to start of each y
  if. (0-:dirinf) +. (''-:dirinf) *. 1=#fromfiles do.  NB. no dirs or only one file to zip
    tofiles=. '/' taketo&.|. each repps fromfiles
    tofiles=. tofiles,.<tozip
    todirs=. ''
  else.
    basedir=. (0 i. ~ *./ 2=/\>fromfiles){."1 >{.fromfiles NB. find base directory of files
    basedir=. SEP dropto&.|. basedir
    if. 1-:dirinf do.
      dirinf=. basedir                                 NB. prefix to add is basedir if dirinf is 1
    else.
      dirinf=. (, ('/' -. {:))^:(*@#) > repps <dirinf  NB. ensure trailing / if not empty
    end.
    tofiles=. repps dirinf aprf basedir dprf fromfiles NB. drop base directory & prefix dirinf from each fromfile
    todirs=. '/' dropto&.|. each tofiles               NB. dirs in tofiles
    todirs=. todirs #~ (a:~:todirs) *. ~: tolower each todirs NB. unique not empty dirs
    todirs=. todirs,.<tozip
    tofiles=. tofiles,.<tozip
  end.
  zipdir=. SEP dropto&.|. tozip
  resdir=. pathcreate zipdir                              NB. create dirs in tozip path if necessary
  resdir=. resdir, 0= (((#todirs),0)$'') zwrite"1 todirs  NB. create dirs in tozip
  resfile=. 0&<@>tofiles zcompress"1 0 fromfiles
  (+/resdir),+/resfile
)

NB.*ztypes v Gets file types for contents of zip file
NB. form: ztypes ZipFileName
NB. returns: Numeric list of types, file (1) dir (2)
NB. eg:   ztypes jpath '~addons/arc/zip/test.zip'
ztypes=: [: >: '/' = [: {:@> [: {."1 zdir

zextract=: fwrite~ zread
zcompress=: zwrite~ fread

NB. =========================================================
NB. Export to z locale

unziptree_z_=: unziptree_rgsztrees_
zipfiles_z_=: zipfiles_rgsztrees_
ziptree_z_=: ziptree_rgsztrees_
ztypes_z_=: ztypes_rgsztrees_
