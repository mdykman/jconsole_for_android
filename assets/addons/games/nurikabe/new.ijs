NB. newboard

NB. =========================================================
NEW=: 0 : 0
pc new;pn "New Board";
xywh 10 12 31 12;cc s1 static;cn "Rows:";
xywh 45 11 20 13;cc erows edit;
xywh 10 28 31 12;cc s2 static;cn "Cols:";
xywh 45 28 20 13;cc ecols edit;
xywh 10 46 65 12;cc s0 static;cn "Name (optional):";
xywh 76 45 120 13;cc ename edit rightmove;
xywh 156 8 44 12;cc ok button leftmove rightmove;cn "OK";
xywh 156 23 44 12;cc cancel button leftmove rightmove;cn "Cancel";
pas 6 6;pcenter;
rem form end;
)

NB. =========================================================
new_run=: 3 : 0
wd NEW
wd 'pshow'
)

NB. =========================================================
new_close=: 3 : 0
wd 'pclose'
wd 'psel ',":HWNDP
)

NB. =========================================================
new_ok_button=: 3 : 0
rws=. {. 0 ". erows
cls=. {. 0 ". ecols
name=. deb ename
if. 0 e. ((-:<.) rws,cls), 5 <: rws,cls do.
  info 'Rows and Cols should be 5 or more'
  return.
end.
OLDBOARD=: BOARD;SHAPE;NAME;FILE
CARET=: ''
SHAPE=: rws,cls
BOARD=: (rws*cls)$0
NAME=: name
FILE=: ''
new_close''
nk_run 1
)

NB. =========================================================
newboardcancel=: 3 : 0
if. 2 query 'OK to cancel edit?' do. return. end.
'BOARD SHAPE NAME FILE'=: OLDBOARD
nk_run 0
)

NB. =========================================================
newboardok=: 3 : 0
if. 2 query 'OK to accept board?' do. return. end.
BOARD=: init BOARD
nk_run 0
)

NB. =========================================================
new_cancel_button=: new_close
newboard=: new_run