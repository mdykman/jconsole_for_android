NB. init

18!:4 <'z'

IFWIN=: 6=9!:12''

jpathsep_z_=: '/'&(('\' I.@:= ])})

NB. GTKPATH required for Win and Mac
GTKPATH=: '/gtk/' ,~ ({.~ i:&'/') jpathsep BINPATH

PreserveAspect=: 1

NB. =========================================================
run=: 3 : 0
gtkinit_z_''
File=: y
Dat=: fread File
if. Dat-:_1 do. return. end.
Pwh=: Twh=: 0
Resize=: (<(1+File i:'.')}.File) e. ;: 'svg'
make_win ''
make_timer 200
gtk_main''
2!:55[0
)
