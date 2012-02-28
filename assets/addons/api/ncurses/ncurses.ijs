cocurrent 'ncurses'

NB. IFNUX ncurses or ncursesw
NB. IFWIN pdcurses compilation options WIDE=Y UTF8=N
NCURSES_WIDE=: IFWIN
NCURSES_UTF8=: IFUNIX

3 : 0''
select. UNAME
case. 'Linux' do.
  libncurses=: NCURSES_WIDE{'libncurses.so.5';'libncursesw.so.5'
  libpanel=: NCURSES_WIDE{'libpanel.so.5';'libpanelw.so.5'
case. 'Darwin' do.
  libncurses=: NCURSES_WIDE{'libncurses.dylib';'libncursesw.dylib'
  libpanel=: NCURSES_WIDE{'libpanel.dylib';'libpanelw.dylib'
case. 'Win' do.
  libncurses=: <'pdcurses.dll'
  libpanel=: <'pdcurses.dll'
end.
EMPTY
)

NB. cd defines

NB. =========================================================
cddef=: 4 : 0
y=. dtb (y i. ':'){.y
if. 0=#y do. '' return. end.
n=. y i. ' '
f=. n {. y
d=. (_2 * (<_2{.f) e. '_1';'_2';'_3') }. f
if. IFUNIX do.
  p=. n }. y
else.
  p=. (n+1) }. y
  if. '>' = {.p do.
    p=. ' >+', }.p
  else.
    p=. ' +', p
  end.
end.
(f)=: (x,' ',d,p)&(15!:0)
''
)

NB. =========================================================
libncurses cddef each <;._2 [ 0 : 0
baudrate > i
beep > i
can_change_color > c
cbreak > i
clearok > i x c
color_content > i s *s *s *s
copywin > i x x i i i i i i i
curs_set > i i
def_prog_mode > i
def_shell_mode > i
delay_output > i i
delscreen > n x
delwin > i x
derwin > x x i i i i
doupdate > i
dupwin > x x
echo > i
endwin > i
erasechar > c
filter > n
flash > i
flushinp > i
getwin > x x
halfdelay > i i
has_colors > c
has_ic > c
has_il > c
idcok > n x c
idlok > i x c
immedok > n x c
initscr > x
init_color > i s s s s
init_pair > i s s s
intrflush > i x c
isendwin > c
is_linetouched > c x i
is_wintouched > c x
keyname > x i
keypad > i x c
killchar > c
leaveok > i x c
longname > x
meta > i x c
mvcur > i i i i i
mvderwin > i x i i
mvprintw_1 > i i i *c
mvscanw_1 > i i i *c
mvwin > i x i i
mvwprintw_1 > i x i i *c
mvwscanw_1 > i x i i *c
napms > i i
newpad > x i i
newterm > x *c x x
newwin > x i i i i
nl > i
nocbreak > i
nodelay > i x c
noecho > i
nonl > i
noqiflush > n
noraw > i
notimeout > i x c
overlay > i x x
overwrite > i x x
pair_content > i s *s *s
pechochar > i x x
pnoutrefresh > i x i i i i i i
prefresh > i x i i i i i i
printw_1 > i *c
putwin > i x x
qiflush > n
raw > i
resetty > i
reset_prog_mode > i
reset_shell_mode > i
ripoffline > i i x
savetty > i
scanw_1 > i *c
scr_dump > i *c
scr_init > i *c
scrollok > i x c
scr_restore > i *c
scr_set > i *c
set_term > x x
slk_attroff > i x
slk_attron > i x
slk_attrset > i x
slk_attr > x
slk_attr_set > i x s *c
slk_clear > i
slk_color > i s
slk_init > i i
slk_label > x i
slk_noutrefresh > i
slk_refresh > i
slk_restore > i
slk_set > i i *c i
slk_touch > i
start_color > i
subpad > x x i i i i
subwin > x x i i i i
syncok > i x c
termattrs > x
termname > x
typeahead > i i
ungetch > i i
use_env > n c
vidattr > i x
vidputs > i x x
vwprintw > i x *c *
vwscanw > i x *c *
waddch > i x x
waddchnstr > i x *x i
waddnstr > i x *c i
wattr_on > i x x x
wattr_off > i x x x
wbkgd > i x x
wbkgdset > n x x
wborder > i x x x x x x x x x
wchgat > i x i x s *c
wclear > i x
wclrtobot > i x
wclrtoeol > i x
wcolor_set > i x s *c
wcursyncup > n x
wdelch > i x
wechochar > i x x
werase > i x
wgetch > i x
wgetnstr > i x *c i
whline > i x x i
winch > x x
winchnstr > i x *x i
winnstr > i x *c i
winsch > i x x
winsdelln > i x i
winsnstr > i x *c i
wmove > i x i i
wnoutrefresh > i x
wprintw_1 > i x *c
wredrawln > i x i i
wrefresh > i x
wscanw_1 > i x *c
wscrl > i x i
wsetscrreg > i x i i
wsyncdown > n x
wsyncup > n x
wtimeout > n x i
wtouchln > i x i i i
wvline > i x x i
)

NB. =========================================================
NB. macros

addch=: 3 : 'waddch stdscr;y'
addchnstr=: 3 : 'waddchnstr stdscr;y'
addchstr=: 3 : 'waddchstr stdscr;y'
addnstr=: 3 : 'waddnstr stdscr;y'
addstr=: 3 : 'waddnstr stdscr;(>y);#>y'
attroff=: 3 : 'wattroff stdscr,y'
attron=: 3 : 'wattron stdscr,y'
attrset=: 3 : 'wattrset stdscr,y'
attr_get=: 3 : 'wattr_get stdscr,y'
attr_off=: 3 : 'wattr_off stdscr,y,0'
attr_on=: 3 : 'wattr_on stdscr,y,0'
attr_set=: 3 : 'wattr_set stdscr,y'
bkgd=: 3 : 'wbkgd stdscr,y'
bkgdset=: 3 : 'wbkgdset stdscr;y'
chgat=: 3 : 'wchgat stdscr;y'
clear=: 3 : 'wclear stdscr'
clrtobot=: 3 : 'wclrtobot stdscr'
clrtoeol=: 3 : 'wclrtoeol stdscr'
color_set=: 3 : 'wcolor_set stdscr;y'
delch=: 3 : 'wdelch stdscr'
deleteln=: 3 : 'winsdelln stdscr,_1'
echochar=: 3 : 'wechochar stdscr,y'
erase=: 3 : 'werase stdscr'
getch=: 3 : 'wgetch stdscr'
getstr=: 3 : 'wgetstr stdscr;y'
inch=: 3 : 'winch stdscr'
inchnstr=: 3 : 'winchnstr stdscr;y'
inchstr=: 3 : 'winchstr stdscr;y'
innstr=: 3 : 'winnstr stdscr;y'
insch=: 3 : 'winsch stdscr;y'
insdelln=: 3 : 'winsdelln stdscr,y'
insertln=: 3 : 'winsdelln stdscr;1'
insnstr=: 3 : 'winsnstr stdscr;y'
insstr=: 3 : 'winsstr stdscr;y'
instr=: 3 : 'winstr stdscr;y'
move=: 3 : 'wmove stdscr,y'
refresh=: 3 : 'wrefresh stdscr'
scrl=: 3 : 'wscrl stdscr,y'
setscrreg=: 3 : 'wsetscrreg stdscr,y'
standend=: 3 : 'wstandend stdscr'
standout=: 3 : 'wstandout stdscr'
timeout=: 3 : 'wtimeout stdscr,y'
wattroff=: 3 : 'wattr_off y,0'
wattron=: 3 : 'wattr_on y,0'

NB. =========================================================
NB. constants

NC_ERR=: _1
NC_OK=: 0

NB. colors

COLOR_BLACK=: 0
COLOR_RED=: 1
COLOR_GREEN=: 2
COLOR_YELLOW=: 3
COLOR_BLUE=: 4
COLOR_MAGENTA=: 5
COLOR_CYAN=: 6
COLOR_WHITE=: 7

NB. attributes

NCURSES_ATTR_SHIFT=: 8
NCURSES_BITS=: 3 : '(({:y) + NCURSES_ATTR_SHIFT) (33 b.) {.y'
COLOR_PAIR=: NCURSES_BITS@(,&0)

A_NORMAL=: 0
A_ATTRIBUTES=: NCURSES_BITS _1 0
A_CHARTEXT=: (NCURSES_BITS 1 0) - 1
A_COLOR=: NCURSES_BITS ((8(33 b.)1) - 1),0
A_STANDOUT=: NCURSES_BITS 1 8
A_UNDERLINE=: NCURSES_BITS 1 9
A_REVERSE=: NCURSES_BITS 1 10
A_BLINK=: NCURSES_BITS 1 11
A_DIM=: NCURSES_BITS 1 12
A_BOLD=: NCURSES_BITS 1 13
A_ALTCHARSET=: NCURSES_BITS 1 14
A_INVIS=: NCURSES_BITS 1 15
A_PROTECT=: NCURSES_BITS 1 16
A_HORIZONTAL=: NCURSES_BITS 1 17
A_LEFT=: NCURSES_BITS 1 18
A_LOW=: NCURSES_BITS 1 19
A_RIGHT=: NCURSES_BITS 1 20
A_TOP=: NCURSES_BITS 1 21
A_VERTICAL=: NCURSES_BITS 1 22

KEY_CODE_YES=: 8b400      NB. A wchar_t contains a key code
KEY_MIN=: 8b401      NB. Minimum curses key
KEY_BREAK=: 8b401      NB. Break key (unreliable)
KEY_SRESET=: 8b530      NB. Soft (partial) reset (unreliable)
KEY_RESET=: 8b531      NB. Reset or hard reset (unreliable)
KEY_DOWN=: 8b402      NB. down-arrow key
KEY_UP=: 8b403      NB. up-arrow key
KEY_LEFT=: 8b404      NB. left-arrow key
KEY_RIGHT=: 8b405      NB. right-arrow key
KEY_HOME=: 8b406      NB. home key
KEY_BACKSPACE=: 8b407      NB. backspace key
KEY_F0=: 8b410      NB. Function keys.  Space for 64
KEY_F=: KEY_F0&+     NB. Value of function key n
KEY_DL=: 8b510      NB. delete-line key
KEY_IL=: 8b511      NB. insert-line key
KEY_DC=: 8b512      NB. delete-character key
KEY_IC=: 8b513      NB. insert-character key
KEY_EIC=: 8b514      NB. sent by rmir or smir in insert mode
KEY_CLEAR=: 8b515      NB. clear-screen or erase key
KEY_EOS=: 8b516      NB. clear-to-end-of-screen key
KEY_EOL=: 8b517      NB. clear-to-end-of-line key
KEY_SF=: 8b520      NB. scroll-forward key
KEY_SR=: 8b521      NB. scroll-backward key
KEY_NPAGE=: 8b522      NB. next-page key
KEY_PPAGE=: 8b523      NB. previous-page key
KEY_STAB=: 8b524      NB. set-tab key
KEY_CTAB=: 8b525      NB. clear-tab key
KEY_CATAB=: 8b526      NB. clear-all-tabs key
KEY_ENTER=: 8b527      NB. enter/send key
KEY_PRINT=: 8b532      NB. print key
KEY_LL=: 8b533      NB. lower-left key (home down)
KEY_A1=: 8b534      NB. upper left of keypad
KEY_A3=: 8b535      NB. upper right of keypad
KEY_B2=: 8b536      NB. center of keypad
KEY_C1=: 8b537      NB. lower left of keypad
KEY_C3=: 8b540      NB. lower right of keypad
KEY_BTAB=: 8b541      NB. back-tab key
KEY_BEG=: 8b542      NB. begin key
KEY_CANCEL=: 8b543      NB. cancel key
KEY_CLOSE=: 8b544      NB. close key
KEY_COMMAND=: 8b545      NB. command key
KEY_COPY=: 8b546      NB. copy key
KEY_CREATE=: 8b547      NB. create key
KEY_END=: 8b550      NB. end key
KEY_EXIT=: 8b551      NB. exit key
KEY_FIND=: 8b552      NB. find key
KEY_HELP=: 8b553      NB. help key
KEY_MARK=: 8b554      NB. mark key
KEY_MESSAGE=: 8b555      NB. message key
KEY_MOVE=: 8b556      NB. move key
KEY_NEXT=: 8b557      NB. next key
KEY_OPEN=: 8b560      NB. open key
KEY_OPTIONS=: 8b561      NB. options key
KEY_PREVIOUS=: 8b562      NB. previous key
KEY_REDO=: 8b563      NB. redo key
KEY_REFERENCE=: 8b564      NB. reference key
KEY_REFRESH=: 8b565      NB. refresh key
KEY_REPLACE=: 8b566      NB. replace key
KEY_RESTART=: 8b567      NB. restart key
KEY_RESUME=: 8b570      NB. resume key
KEY_SAVE=: 8b571      NB. save key
KEY_SBEG=: 8b572      NB. shifted begin key
KEY_SCANCEL=: 8b573      NB. shifted cancel key
KEY_SCOMMAND=: 8b574      NB. shifted command key
KEY_SCOPY=: 8b575      NB. shifted copy key
KEY_SCREATE=: 8b576      NB. shifted create key
KEY_SDC=: 8b577      NB. shifted delete-character key
KEY_SDL=: 8b600      NB. shifted delete-line key
KEY_SELECT=: 8b601      NB. select key
KEY_SEND=: 8b602      NB. shifted end key
KEY_SEOL=: 8b603      NB. shifted clear-to-end-of-line key
KEY_SEXIT=: 8b604      NB. shifted exit key
KEY_SFIND=: 8b605      NB. shifted find key
KEY_SHELP=: 8b606      NB. shifted help key
KEY_SHOME=: 8b607      NB. shifted home key
KEY_SIC=: 8b610      NB. shifted insert-character key
KEY_SLEFT=: 8b611      NB. shifted left-arrow key
KEY_SMESSAGE=: 8b612      NB. shifted message key
KEY_SMOVE=: 8b613      NB. shifted move key
KEY_SNEXT=: 8b614      NB. shifted next key
KEY_SOPTIONS=: 8b615      NB. shifted options key
KEY_SPREVIOUS=: 8b616      NB. shifted previous key
KEY_SPRINT=: 8b617      NB. shifted print key
KEY_SREDO=: 8b620      NB. shifted redo key
KEY_SREPLACE=: 8b621      NB. shifted replace key
KEY_SRIGHT=: 8b622      NB. shifted right-arrow key
KEY_SRSUME=: 8b623      NB. shifted resume key
KEY_SSAVE=: 8b624      NB. shifted save key
KEY_SSUSPEND=: 8b625      NB. shifted suspend key
KEY_SUNDO=: 8b626      NB. shifted undo key
KEY_SUSPEND=: 8b627      NB. suspend key
KEY_UNDO=: 8b630      NB. undo key
KEY_MOUSE=: 8b631      NB. Mouse event has occurred
KEY_RESIZE=: 8b632      NB. Terminal resize event
KEY_EVENT=: 8b633      NB. We were interrupted by an event
KEY_MAX=: 8b777      NB. Maximum key value is 0633

NB. =========================================================
NB. NCURSES_WIDECHAR

NB. /*
NB.  * cchar_t stores an array of CCHARW_MAX wide characters.  The first is
NB.  * normally a spacing character.  The others are non-spacing.  If those
NB.  * (spacing and nonspacing) do not fill the array, a null L'\0' follows.
NB.  * Otherwise, a null is assumed to follow when extracting via getcchar().
NB.  */
NB. #define CCHARW_MAX  5
NB. typedef struct
NB. {
NB.     attr_t  attr;
NB.     wchar_t chars[CCHARW_MAX];
NB. #if 0
NB. #undef NCURSES_EXT_COLORS
NB. #define NCURSES_EXT_COLORS 20110404
NB.     int   ext_color;  /* color pair, must be more than 16-bits */
NB. #endif
NB. }
NB. cchar_t;

3 : 0''
if. IFUNIX do.
  if. IF64 do.
NB. sizeof ( chtype ) = 8
NB. sizeof ( attr_t ) = 8
NB. sizeof ( wchar_t ) = 4
NB. cchar_t
    sz_cchar_t=: 32
    cchar_t_attr=: 0
    cchar_t_chars=: 8
  else.
NB. sizeof ( chtype ) = 4
NB. sizeof ( attr_t ) = 4
NB. sizeof ( wchar_t ) = 4
NB. cchar_t
    sz_cchar_t=: 24
    cchar_t_attr=: 0
    cchar_t_chars=: 4
  end.
else.
NB. sizeof ( chtype ) = 4
NB. sizeof ( attr_t ) = 4
NB. sizeof ( wchar_t ) = 2
NB. sizeof ( cchar_t ) = 4
  sz_cchar_t=: 4
end.
EMPTY
)

NB. =========================================================
libncurses cddef each <;._2 [ 0 : 0
erasewchar > i *i
getcchar > i *c *i *x *s x
key_name > x i
killwchar > i *i
pecho_wchar > i x *x
setcchar > i *c *i x s x
slk_wset > i i *i i
term_attrs > x
unget_wch > i i
vid_attr > i x s x
vid_puts > i x s x x
wadd_wch > i x *c
wadd_wchnstr > i x *x i
waddnwstr > i x *i i
wbkgrnd > i x *c
wbkgrndset > n x *c
wborder_set > i x *c *c *c *c *c *c *c *c
wecho_wchar > i x *c
wget_wch > i x *i
wgetn_wstr > i x *i i
whline_set > i x *x i
win_wch > i x *c
win_wchnstr > i x *x i
winnwstr > i x *i i
wins_nwstr > i x *i i
wins_wch > i x *c
winwstr > i x *i
wunctrl > x *c
wvline_set > i x *x i
)

NB. =========================================================
NB. macros

add_wch=: 3 : 'wadd_wch stdscr;y'
add_wchnstr=: 3 : 'wadd_wchnstr stdscr;y'
add_wchstr=: 3 : 'wadd_wchstr stdscr;y'
addnwstr=: 3 : 'waddnwstr stdscr;y'
addwstr=: 3 : 'waddnwstr stdscr;t;#t [[ t=. 3 u: 7 u: y'
bkgrnd=: 3 : 'wbkgrnd stdscr;y'
bkgrndset=: 3 : 'wbkgrndset stdscr;y'
border_set=: 3 : 'wborder_set stdscr;y'
box_set=: 3 : 'wborder_set (1 2 2#y),4#0'
echo_wchar=: 3 : 'wecho_wchar stdscr;y'
get_wch=: 3 : 'wget_wch stdscr;y'
get_wstr=: 3 : 'wget_wstr stdscr;y'
getbkgrnd=: 3 : 'wgetbkgrnd stdscr;y'
getn_wstr=: 3 : 'wgetn_wstr stdscr;y'
hline_set=: 3 : 'whline_set stdscr;y'
in_wch=: 3 : 'win_wch stdscr;y'
in_wchnstr=: 3 : 'win_wchnstr stdscr;y'
in_wchstr=: 3 : 'win_wchstr stdscr;y'
innwstr=: 3 : 'winnwstr stdscr;y'
ins_nwstr=: 3 : 'wins_nwstr stdscr;y'
ins_wch=: 3 : 'wins_wch stdscr;y'
ins_wstr=: 3 : 'wins_wstr stdscr;y'
inwstr=: 3 : 'winwstr stdscr;y'
vline_set=: 3 : 'wvline_set stdscr;y'
wadd_wchstr=: 3 : 'wadd_wchnstr y,<_1'
waddwstr=: 3 : 'waddnwstr w;t;#t [[ t=. 3 u: 7 u: 1{::y [[ w=. >@{.y'
wget_wstr=: 3 : 'wgetn_wstr y,<_1'
win_wchstr=: 3 : 'win_wchnstr y,<_1'
wins_wstr=: 3 : 'wins_nwstr y,<_1'
mvadd_wch=: 3 : 'mvwadd_wch stdscr;y'
mvadd_wchnstr=: 3 : 'mvwadd_wchnstr stdscr;y'
mvadd_wchstr=: 3 : 'mvwadd_wchstr stdscr;y'
mvaddnwstr=: 3 : 'mvwaddnwstr stdscr;y'
mvaddwstr=: 3 : 'mvwaddwstr stdscr;y'
mvget_wch=: 3 : 'mvwget_wch stdscr;y'
mvget_wstr=: 3 : 'mvwget_wstr stdscr;y'
mvgetn_wstr=: 3 : 'mvwgetn_wstr stdscr;y'
mvhline_set=: 3 : 'mvwhline_set stdscr;y'
mvin_wch=: 3 : 'mvwin_wch stdscr;y'
mvin_wchnstr=: 3 : 'mvwin_wchnstr stdscr;y'
mvin_wchstr=: 3 : 'mvwin_wchstr stdscr;y'
mvinnwstr=: 3 : 'mvwinnwstr stdscr;y'
mvins_nwstr=: 3 : 'mvwins_nwstr stdscr;y'
mvins_wch=: 3 : 'mvwins_wch stdscr;y'
mvins_wstr=: 3 : 'mvwins_wstr stdscr;y'
mvinwstr=: 3 : 'mvwinwstr stdscr;y'
mvvline_set=: 3 : 'mvwvline_set stdscr;y'

NB. =========================================================
NB. constants

CCHARW_MAX=: 5

NB. =========================================================
NB. PDCURSES

pdc_verb=: 0 : 0
erasewchar > i *w
getcchar > i *c *w *i *s x
killwchar > i *w
setcchar > i *c *w i s x
slk_wset > i i *w i
waddnwstr > i x *w i
wgetn_wstr > i x *s i
wget_wch > i x *s
winnwstr > i x *w i
wins_nwstr > i x *w i
winwstr > i x *w
)

3 : 0''
if. IFWIN *. NCURSES_WIDE *. -.NCURSES_UTF8 do.
  libncurses cddef each <;._2 pdc_verb
  addwstr=: 3 : 'waddnwstr stdscr;t;#t [[ t=. u: 7 u: y'
  waddwstr=: 3 : 'waddnwstr w;t;#t [[ t=. u: 7 u: 1{::y [[ w=. >@{.y'
end.
EMPTY
)
