NB. defs

NB. =========================================================
NB. parent:
PID=: ''     NB. id
PST=: ''     NB. style
PCN=: ''     NB. caption
PAS=: 6 6    NB. spacing
POP=: ''     NB. options (pcenter,ptop)
PMV=: ''     NB. pmove
PFE=: ''     NB. form end

NB. controls:
CCS=: 0 4$0  NB. control positions (units)
CCX=: 0 4$0  NB. CCS reduced height for combos
CLS=: ''     NB. classes
CPS=: ''     NB. captions
IDS=: ''     NB. ids
STY=: ''     NB. styles

NB. misc:
BUF=: ''     NB. form definition buffer
MNU=: ''     NB. menu definition
RFE=: 'rem form end;'
SBR=: ''     NB. status bar definition
TBR=: ''     NB. tool bar definition
TBFN=: jpath '~addons/gui/wdclass/isitbar8.bmp'

NB. =========================================================
NB. other form definitions:

MOUSEIGNORE=: 0
MOUSETIME=: sessiontime''

GWH=: 0 0 NB. screen size in pixels
XYWH=: '' NB. corresponding xywh
MINWH=: 160 20
HWNDP=: ''  NB. main form handle
LOCK=: 0
BOX=: '' NB. boundary box (pixels)
CURSOR=: 0
DOWN=: '' NB. down mouse position
UP=: ''   NB. up mouse position
ORDER=: 0 NB. if control order mode
PDF=: ''  NB. definition id (typically upper case PID)
SELECT=: $0 NB. current control selection
STEP=: 1  NB. movement step
TESTLOC=: ''  NB. test locale
TESTHWNDP=: '' NB. test form handle
WINDIR=: 0 NB. windows "direction" 0 = horizontal
GFONT=: PROFONT
OLEOCX=: ''   NB. defined when new ocx requested

NB. for debugging, ensure these are defined:
sysevent=: ''
sysmodifiers=: ,'0'

NB. =========================================================
NB. capture state
CAPNONE=: 0
CAPMOVE=: 7
CAPSIZE=: 8
CAPSELECT=: 3
CAPTURE=: CAPNONE

NB. =========================================================
NB. isigraph window:
FWH=: _1 NB. isigraph size
GSCALE=: 0 NB. ratio pixels to coordinates
GRID=: 16 NB. grid size

NB. =========================================================
NB. file name and corresponding data:
FNAME=: '' NB. script file name
PID=: '' NB. short file name

NB. =========================================================
NB. WDNAMES n reserved wd names
WDNAMES=: <;._2 (0 : 0)
wd
wdhandler
sminfo
wdq
)
