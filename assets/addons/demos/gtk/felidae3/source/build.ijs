NB. build

mkdir_j_ jpath '~Demos/gtk/felidae3/release/'
writesourcex_jp_ '~Demos/gtk/felidae3/source';'~Demos/gtk/felidae3/release/felidae3.ijs'

NB. standalone script

f0=: 0 : 0
~system/main/stdlib.ijs
)

f1=: 0 : 0
~system/util/scripts.ijs
~system/main/regex.ijs
~system/main/task.ijs
~addons/data/jmf/jmf.ijs
~addons/data/jdb/jdb.ijs
~addons/gui/gtk/gtk.ijs
~Demos/gtk/felidae3/release/felidae3.ijs
)

dat1=. 0 : 0
load_z_=: 0:
require_z_=: 0:
jsystemdefs_z_=: 3 : '0!:0 ". y,''_'',(tolower UNAME),(IF64#''_64''),''_jdefs_'''
cocurrent 'base'
)

dat2=. 0 : 0
StandAlone_j_=: 1
jpathsep_z_=: '/'&(('\' I.@:= ])})
3 : 0''
if. _1= 4!:0 <'Public_j_' do. Public_j_=: i.0 2 end.
if. _1= 4!:0 <'SystemFolders_j_' do. SystemFolders_j_=: i.0 2 end.
if. _1= 4!:0 <'UserFolders_j_' do. UserFolders_j_=: i.0 2 end.
if. (<'bin') -.@e. {."1 SystemFolders_j_ do.
  SystemFolders_j_=: SystemFolders_j_, 'bin';jpathsep BINPATH_z_
end.
if. (<'install') -.@e. {."1 SystemFolders_j_ do.
  SystemFolders_j_=: SystemFolders_j_, 'install';({.~ i:&'/') jpathsep BINPATH_z_
end.
if. (<'addons') -.@e. {."1 SystemFolders_j_ do.
  SystemFolders_j_=: SystemFolders_j_, 'addons';'/addons',~ ({.~ i:&'/') jpathsep BINPATH_z_
end.
if. (<'tools') -.@e. {."1 SystemFolders_j_ do.
  SystemFolders_j_=: SystemFolders_j_, 'tools';'/tools',~ ({.~ i:&'/') jpathsep BINPATH_z_
end.
if. (<'temp') -.@e. {."1 SystemFolders_j_ do.
  SystemFolders_j_=: SystemFolders_j_, 'temp';(6=9!:12''){::'/tmp';jpathsep (2!:5'WINDIR'), ::(''"_) '/temp'
end.
''
)

systemdefs=: 3 : 0
z=. ''
for_f. {."1 (1!:0 <jpath '~system/defs/hostdefs*.ijs'), 1!:0 <jpath '~system/defs/netdefs*.ijs' do.
  z=. z, (_4}.>f), '_jdefs_=: 0 : 0',LF, (freads <jpath '~system/defs/',>f), ')', LF
end.
z
)

target=. jpath '~Demos/gtk/felidae3/release/felidae.ijs'
(<target) 1!:2~ (''''' conew ''felidae3''',LF) ,~ dat2, ')', LF, (; freads@jpath&.> <;._2 f0), (systemdefs ''), dat1, ; freads@jpath&.> <;._2 f1

NB. run standalone script by
NB.    $ /path1/to/jconsole -profile /path2/to/felidae.ijs'
NB. or
NB.    $ cd /path1/to/
NB.    $ ./jconsole -profile /path2/to/felidae.ijs
NB. or
NB.    $ cd /path2/to/
NB.    $ /path1/to/jconsole -profile felidae.ijs
NB.
NB. replacing /path1/to and /path2/to with your actual paths, and
NB. ensure correct ../data directory relative to the felidae.ijs script
