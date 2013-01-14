NB. demo

require 'gtkwd'

load 'graphics/treemap'
coclass 'pdemo'

COUNT=: 10
COLORSTYLE=: 0

COLORGROUPS=: ". ;._2 (0 : 0)
255 128 128
128 255 128
128 128 255
0   255 255
128 128   0
255 0   255
210 180 140
)

COLORSIGNS=: 32 178 170,:240 128 128
GRIDSHOW=: 1

NB. =========================================================
DEMO=: 0 : 0
pc demo;pn "Treemap";
xywh 0 0 300 200;cc tm isigraph ws_border rightmove bottommove;
xywh 310 7 70 13;cc newrun button leftmove rightmove;cn "New Run";
xywh 312 28 70 54;cc g0 groupbox leftmove rightmove;cn "Approx Count";
xywh 318 40 59 12;cc b10 radiobutton leftmove rightmove;cn "10";
xywh 318 53 59 12;cc b25 radiobutton leftmove rightmove group;cn "25";
xywh 318 66 59 12;cc b100 radiobutton leftmove rightmove group;cn "100";
xywh 312 92 70 42;cc g1 groupbox leftmove rightmove;cn "Color Style";
xywh 318 104 59 12;cc bgroup radiobutton leftmove rightmove;cn "By Group";
xywh 318 116 59 12;cc bsign radiobutton leftmove rightmove group;cn "By Sign";
pas 4 0;pcenter;
rem form end;
)

NB. =========================================================
DEMOQT=: 0 : 0
pc demo qtwd;pn "Treemap";
bin h;
xywh 0 0 300 200;cc tm isigraph ws_border rightmove bottommove;
bin v;
xywh 310 7 70 13;cc newrun button leftmove rightmove;cn "New Run";
bin v;
xywh 312 28 70 54;cc g0 groupbox leftmove rightmove;cn "Approx Count";
xywh 318 40 59 12;cc b10 radiobutton leftmove rightmove;cn "10";
xywh 318 53 59 12;cc b25 radiobutton leftmove rightmove group;cn "25";
xywh 318 66 59 12;cc b100 radiobutton leftmove rightmove group;cn "100";
bin zv;
xywh 312 92 70 42;cc g1 groupbox leftmove rightmove;cn "Color Style";
xywh 318 104 59 12;cc bgroup radiobutton leftmove rightmove;cn "By Group";
xywh 318 116 59 12;cc bsign radiobutton leftmove rightmove group;cn "By Sign";
bin zszz;
pas 4 0;pcenter;
rem form end;
)

NB. =========================================================
demo_b10_button=: 3 : 0
COUNT=: 10
makedata''
)

NB. =========================================================
demo_b25_button=: 3 : 0
COUNT=: 25
makedata''
)

NB. =========================================================
demo_b100_button=: 3 : 0
COUNT=: 100
makedata''
)

NB. =========================================================
demo_bgroup_button=: 3 : 0
COLORSTYLE=: 0
makedata''
)

NB. =========================================================
demo_bsign_button=: 3 : 0
COLORSTYLE=: 1
makedata''
)

NB. =========================================================
demo_run=: 3 : 0
wd IFQT{::DEMO;DEMOQT
wd 'set b10 1'
wd^:(-.IFJ6) 'pshow;pshow sw_hide'
tm=: '' conew 'ptreemap'
makedata''
wd' pshow;'
)

NB. =========================================================
makedata=: 3 : 0
dat=. 0.01 * o. (1 + ?) ^:3 [ (5 + ?+:COUNT) $1e6
LABEL=: ('Item ',":) each i.#dat
if. COLORSTYLE do.
  dat=. dat * _1 ^ 5 < ? (#dat) $ 11
  dat=. dat \: | dat
  NOTE=: LABEL ,each LF ,each 'c2' 8!:0 dat
  COLOR=: dat < 0
  DATA=: | dat
else.
  COLOR=: ? ($dat) $ #COLORGROUPS
  DATA=: dat
  NOTE=: LABEL ,each LF ,each 'c2' 8!:0 dat
end.
COLORS=: COLORSTYLE pick COLORGROUPS;COLORSIGNS
show__tm pack 'DATA COLOR COLORS GRIDSHOW LABEL NOTE'
)

NB. =========================================================
tm_tmaphandler=: 3 : 0
select. y
case. 'click' do.
  ndx=. Index__tm
  msg=. 'Selected index ',(":ndx),' Value: ',":ndx{DATA
  wdinfo 'Treemap';msg
end.
1
)

NB. =========================================================
create=: demo_run

destroy=: 3 : 0
destroy__tm''
wd 'pclose'
codestroy''
)

demo_cancel=: demo_close=: destroy
demo_newrun_button=: makedata
demo_run''


