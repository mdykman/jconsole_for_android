require '~addons/net/clientserver/jsss.ijs'
cocurrent 'jsss'
cmd_calljdb=: 3 : 0
try.
  'cmd loc prm'=. y
  if. 0=#loc do. loc=. locDBF end.
  0;<(cmd,'__loc')~prm
catch.
  1;'JDB command failed:',LF,LF,13!:12''
end.
)
cocurrent 'base'
jdbinit=: 3 : 0
locDBF_z_=: Open_jdb_ 0 pick y
init }.y
)

