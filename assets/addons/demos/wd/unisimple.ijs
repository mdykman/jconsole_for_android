NB. unisimple

require 'droidwd gtkwd wdclass'

coclass 'judmeo'
coinsert 'wdbase'
droidwd_run=: abc_run

ABC=: 0 : 0
pc abc;pn "Unicode";
xywh 7 8 156 24;cc b button rightmove;
xywh 8 39 156 52;cc em editm rightmove bottomscale;
xywh 165 100 70 12;cc viewsource button leftmove rightmove;cn "View Source";
pas 6 6;pcenter;
rem form end;
)

font=: IFUNIX pick '"Fixedsys" 14' ; ('Android'-:UNAME) pick '"Kochi Mincho" 14' ; 'sans 14'

c_name=: '漢語'
c_problem=: '沒有問題'
c_weather=: '今日は良い天気です'
c_nice=: '这首歌很好听'
c_all=: c_problem,LF,c_weather,LF,c_nice

e_name=: 'English'
e_problem=: 'No problem.'
e_weather=: 'Good weather today.'
e_nice=: 'Nice song!'
e_all=: e_problem,LF,e_weather,LF,e_nice

i_name=: 'Íslenzka'
i_problem=: 'Það er ekkert vandamál'
i_weather=: 'Frábært veður í dag'
i_nice=: 'Þetta er fallegur söngur!'
i_all=: i_problem,LF,i_weather,LF,i_nice


s_name=: 'Svenska'
s_problem=: 'Det är inte något problem'
s_weather=: 'Godt väder i dag'
s_nice=: 'Sången är bra!'
s_all=: s_problem,LF,s_weather,LF,s_nice

t_name=: 'Deutch'
t_problem=: 'Daß ist kein problem'
t_weather=: 'Gutes wätter heute'
t_nice=: 'Die gesang ist gut!'
t_all=: t_problem,LF,t_weather,LF,t_nice

NB. =========================================================
abc_run=: 3 : 0
wd ABC
wd'setfont b ',font
wd'setfont em ',font
btext=: c_name
wd'setcaption b *',btext
wd'set em *',c_all
wd 'pshow;'
evtloop^:(-.IFJ6)''
)

NB. =========================================================
abc_b_button=: 3 : 0
select. btext
case. e_name do.
  btext=: i_name
  t=. i_all
case. i_name do.
  btext=: s_name
  t=. s_all
case. s_name do.
  btext=: t_name
  t=. t_all
case. t_name do.
  btext=: c_name
  t=. c_all
case. c_name do.
  btext=: e_name
  t=. e_all
end.
wd'set em *',t
wd'setcaption b *',btext
)

NB. =========================================================
abc_viewsource_button=: 3 : 0
fview jpath '~addons/demos/wd/unisimple.ijs'
)

abc_close=: 3 : 0
wd'pclose'
)

abc_run`start_droidwd@.(('Android'-:UNAME)>IFQT) coname''
