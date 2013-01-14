NB. files

FTYPES=: '"Nuikabe (*.nkb)|*.nkb|All Files (*.*)|*.*"'

NB. =========================================================
getboard=: 3 : 0
r=. 'BOARD=: ".;._2 (0 : 0)',LF
r=. r,,(":SHAPE$BOARD),.LF
r=. r,')',LF
if. #NAME do.
  r=. r,LF,LF,~'NAME=: ',quote NAME
end.
)

NB. =========================================================
NB. getsaveas v get a save as file name
getsaveas=: 3 : 0
fn=. FILE, (0=#FILE) # jpath '~temp/'
while. 1 do.
  'p f'=. pathname fn
  j=. FTYPES,' ofn_nochangedir'
  fn=. wd 'mbsave "Save As" "',p,'" "',f,'" ',j
  if. 0=#fn do. return. end.
  if. -. '.' e. fn do. fn=. fn,'.nkb' end.
  if. fn -: FILE do. return. end.
  if. 0=fexist fn do. return. end.
  j=. fn,LF,'This file already exists.',LF,LF
  msg=. j,'Replace existing file?'
  if. 0=2 query msg do. fn return. end.
end.
)

NB. =========================================================
openboard=: 3 : 0
if. #FILE do.
  p=. 0 pick pathname FILE
else.
  p=. jpath '~temp'
end.
j=. FTYPES,' ofn_nochangedir'
while. 1 do.
  f=. wd 'mbopen "Open File" "',p,'" "" ',j
  if. 0 = #f do. '' return. end.
  if. -. fexist f do.
    f=. f,(-. '.' e. f)#'.nkb'
    if. -. fexist f do.
      info 'Not found: ',f continue.
    end.
  end.
  break.
end.
NAME=: ''
BOARD=: i.0 0
FILE=: f
0!:100 freads FILE
if. -.1 validate BOARD do.
  info 'Invalid board'
  0 return.
end.
SHAPE=: $BOARD
BOARD=: ,BOARD
nk_run 0
1
)

NB. =========================================================
saveboard=: 3 : 0
if. #FILE do.
  (getboard'') fwrites FILE
  info 'Saved: ',FILE
else.
  saveboardas''
end.
)

NB. =========================================================
saveboardas=: 3 : 0
fn=. getsaveas''
if. #fn do.
  FILE=: fn
  (getboard'') fwrites FILE
  info 'Saved: ',FILE
  wd 'psel ',": HWNDP
  nk_name''
end.
)
