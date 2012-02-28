NB. parse

wd=: 4 : 0
cmd=. 0{::tk=. ;:y
select. cmd
case. 'cc' do.
  select. child=. 2{::tk
  case. 'edit' do. wdccedit 1{::tk
  case. 'button' do. wdccbutton 1{::tk
  case. do. ('not implemented child ',child) 13!:8[3
  end.
case. 'cn' do. wdcn '"'-.~ 3}.dlb y
case. 'pc' do. wdpc x,1{tk
case. 'pclose' do. wdpclose''
case. 'pn' do. wdpn '"'-.~ 3}.dlb y
case. 'pshow' do. wdpshow''
case. 'xywh' do. wdxywh ". 1{::tk
case. do. ('not implemented ',cmd) 13!:8[3
end.
EMPTY
)
