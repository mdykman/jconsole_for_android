NB. Thu 01 Dec 2011 04:39:47 TABULA scientific calculator topend
NB. based on JWD gui: j7 not supported

require 'gtkwd'	NB. for: J7 wd
require 'strings'	NB. for: rplc
require 'gl2'		NB. load gl2 definitions in jgl2 locale

coclass 'tab'
coinsert'jgl2'		NB. allows use of gl2 verbs unlocalised

XYWH0=: 8 55 527 450		NB. Factory setting: form position
TRACH=: 0
TRACE=: 0
DEAF=: 0	NB. mousemove msg transient suppress
DEAFEN=: 20	NB. adjustable DEAF-setting

	NB. Selection of fonts for content display...
FONT1=: '"APL385 Unicode" 10'
FONT2=: '"Courier New" 10'
FONT3=: '"Courier" 10'
FONT=: FONT1	NB. the one actually used

NB. ========== MORE NOUNS ==========
BS=: '\'

CONSTS=: 0 : 0
pc consts;
xywh 5 6 244 100;cc cons listbox ws_vscroll rightmove bottommove;
xywh 5 107 50 12;cc cappend button topmove bottommove;cn "Append";
xywh 190 108 80 11;cc casec checkbox leftmove rightmove topmove bottommove;cn "case-sensitive";
xywh 60 108 130 12;cc searchc edit rightmove topmove bottommove;
pas 6 6;pcenter;
rem form end;
)

FUNCTS=: 0 : 0
pc functs;
xywh 5 6 244 100;cc func listbox ws_vscroll rightmove bottommove;
xywh 5 107 50 12;cc fappend button topmove bottommove;cn "Append";
xywh 190 108 80 11;cc casef checkbox leftmove rightmove topmove bottommove;cn "case-sensitive";
xywh 60 108 130 12;cc searchf edit rightmove topmove bottommove;
pas 6 6;pcenter;
rem form end;
)

HELP=: 0 : 0
This is a page of info about TABULA.
(...Work In Progress)

++ For CAL-commands, click "query-cog" icon.

++ Typed-in mini-commands:
   (Enter) or: [	move selection down
   ]			move selection up
   .			undo
   ..			redo
   ;			repeat last action
   /text		CAL-command

++ To plot a ttable:
   (a suitable test-ttable sample is "plot_test")
1. Select the item to become the x-axis.
2. Give the item a minimum or maximum value to be plotted
       eg. _10 or 10
3. Click "steps" tool
   or pick menu: File > Plot 0 to (value)
   --The plot window will appear, showing a plot of
     the LAST item in the ttable.
3. Reselect the lines you prefer to plot,
   then click the "replot" icon in the toolbar,
   or pick menu: File > Line Chart [Bar Chart ...]

++ To alter the toolbar buttons, edit: tabtools.ijs
   NB. if an icon is red+blue, it reverses its
       function when Shift is held.
)

INF=: 0 : 0
pc inf;
xywh 5 6 244 100;cc info editm ws_vscroll es_autovscroll rightmove bottommove;
xywh 5 107 50 12;cc updin button topmove bottommove;cn "Update";
pas 6 6;pcenter;
rem form end;
)

NEEDS=: '=:',TAB,TAB,'empty'

TABU=: 0 : 0
pc tab closeok;
menupop "File";
menu newtt "&New" "Ctrl+N" "Start a new ttable" "new";
menu opens "Open Sample" "Ctrl+Shift+O" "Open a sample ttable" "sample";
menu opent "&Open..." "Ctrl+O" "Open a ttable from user library" "open...";
menu appet "&Append..." "" "Append a ttable from user library" "append...";
menu savex "&Save" "Ctrl+S" "Save current ttable under existing name" "savex";
menu saves "Save As Sample" "" "Save current ttable as default sample" "saves";
menu savet "Save As Title" "" "Save current ttable under title shown" "savet";
menu savea "Save As..." "" "Save current ttable under new name" "save as...";
menusep;
menu stept "Plot 0 to (value)" "" "plot values" "plot";
menu plotl "Line Chart" "" "Specify plot: line" "line";
menu plotb "Bar Chart" "" "Specify plot: bar" "bar";
menu plotp "Pie Chart" "" "Specify plot: pie" "pie";
menu plots "Surface Chart" "" "Specify plot: surface" "surface";
menusep;
menu close "Close" "" "Close current ttable" "close ttable";
menusep;
menu print "Print" "" "Print current ttable" "print ttable";
menusep;
menu quit "&Quit" "Ctrl+Shift+Q" "Quit TABULA" "quit";
menupopz;
menupop "Edit";
menu undo "&Undo" "Ctrl+U" "Undo last action" "undo";
menu redo "&Redo" "Ctrl+Shift+U" "Redo last action" "redo";
menusep;
menu copal "&Copy Ttable" "Ctrl+Shift+C" "copyall" "copy-all";
menusep;
menu label "Edit Item Name" "Ctrl+Shift+N" "Edit name" "name";
menu formu "Edit Formula" "Ctrl+Shift+F" "Edit formula" "formula";
menu erasf "Erase Formula" "" "Erase formula..." "no formula";
menu siunt "Convert to SI Units" "Ctrl+Shift+S" "Convert line to SI units..." "SI units";
menusep;
menu movit "Move Line Down" "Ctrl+K" "Move this line down" "movedown";
menu mvitu "Move Line Up" "Ctrl+J" "Move this line up" "moveup";
menusep;
menu newsl "New Line" "Ctrl+L" "Make a new line" "newline";
menu merge "Merge lines" "Ctrl+M" "Merge lines..." "merge";
menu delit "Delete Line" "" "Delete this line" "delete";
menu dupit "Duplicate Line" "Ctrl+D" "Duplicate this line" "dup";
menusep;
menu updex "Update Exchange Rates" "" "Update currency exchange rates for this ttable" "upd-exch";
menu updin "Update Info" "" "Update info for this ttable" "upd-inf";
menusep;
menu stup "Startup with TABULA" "" "Fix startup" "stup";
menupopz;
menupop "Command";
menu repet "Repeat" "Ctrl+Shift+R" "Repeat last action" "repeat";
menusep;
menu tthld "Transient Hold" "Ctrl+Shift+G" "Transient hold" "hold";
menu thold "Toggle Hold" "Ctrl+Shift+H" "Toggle hold" "hold!";
menusep;
menu hidel "Hide Line(s)" "" "Hide selected lines" "hide";
menu unhid "Unhide All Lines" "" "Unhide all hidden lines" "unhide";
menusep;
menu ttabl "Show Ttable" "Ctrl+T" "Show ttable display" "ttable";
menu conss "Show Constants List" "" "Show consts tab" "consts";
menu funcs "Show Functions List" "" "Show functs tab" "functs";
menu infor "Show Ttable Info" "Ctrl+I" "Show info tab" "info";
menusep;
menu trace "Toggle TRACE" "Ctrl+Shift+T" "Toggle trace" "trace";
menu trach "Toggle TRACH" "" "Toggle Handler1 trace" "handler";
menu traci "Toggle cal echo" "" "Toggle echo" "traci";
menupopz;
menupop "Value";
menu Vzero "Zero" "Ctrl+0" "Zero the value" "zero";
menu Vonep "One" "Ctrl+1" "Set the value to 1" "+1";
menu Vonen "Minus One" "" "Set the value to -1" "-1";
menusep;
menu Vabsv "Abs" "" "Absolute Value" "abs";
menu Vdblv "Double" "" "Value doubled" "doubled";
menu Vhlvv "Halve" "" "Value halved" "halved";
menu Vintv "Integer" "" "Value integer" "int";
menu Vinvv "Invert" "" "Value inverted" "inverted";
menu Vnegv "Negate" "" "Value negated" "negated";
menusep;
menu Vsqtv "Sq Root" "" "Value sq-rooted" "sqrt";
menu Vsqrv "Square" "" "Value squared" "squared";
menu Vcbtv "Cube Root" "" "Value cube-rooted" "cubed";
menu Vcubv "Cube" "" "Value cubed" "cubed";
menu Vexpv "Exp" "" "e^value" "exp";
menu Vextv "10^" "" "10^value" "exp";
menu Vetwv "2^" "" "2^value" "exp";
menu Vlnnv "Ln" "" "Value natural-log" "ln";
menu Vltnv "Log10" "" "Value log10" "log10";
menu Vltwv "Log2" "" "Value log2" "log2";
menusep;
menu Vpimv "Times-π" "" "Value times π" "*π";
menu Vptmv "Times-2π" "" "Value times 2π" "*2π";
menu Vpidv "By-π" "" "Value divided by π" "/π";
menu Vptdv "By-2π" "" "Value divided by 2π" "/2π";
menupopz;
menupop "Scale";
menu Vunsc "Unscaled"  "" "Unscaled" "unscaled";
menu Vstpu "Step Up"  "" "Step Up" "stepup";
menu Vstpd "Step Down"  "" "Step Down" "stepdown";
menusep;
menu Vdeci "deci-  [/10]"  "" "Divided by 10" "deci";
menu Vcent "centi- [/100]" "" "Divided by 100" "centi";
menu Vmill "milli- [/1000]" "" "Divided by 10^3" "milli";
menu Vmicr "micro- [/10^6]" "" "Divided by 10^6" "micro";
menu Vnano "nano-  [/10^9]"  "" "Divided by 10^9" "nano";
menu Vpico "pico-  [/10^12]"  "" "Divided by 10^12" "pico";
menu Vfemt "femto- [/10^15]" "" "Divided by 10^15" "femto";
menu Vatto "atto-  [/10^18]"  "" "Divided by 10^18" "atto";
menu Vzept "zepto- [/10^21]" "" "Divided by 10^21" "zepto";
menu Vyoct "yocto- [/10^24]" "" "Divided by 10^24" "yocto";
menusep;
menu Vdeca "deca-  [*10]"  "" "Multiplied by 10" "deca";
menu Vhect "hecto- [*100]" "" "Multiplied by 100" "hecto";
menu Vkilo "kilo-  [*1000]" "" "Multiplied by 10^3" "kilo";
menu Vmega "mega-  [*10^6]" "" "Multiplied by 10^6" "mega";
menu Vgiga "giga-  [*10^9]" "" "Multiplied by 10^9" "giga";
menu Vtera "tera-  [*10^12]" "" "Multiplied by 10^12" "tera";
menu Vpeta "peta-  [*10^15]" "" "Multiplied by 10^15" "peta";
menu Vexaa "exa-   [*10^18]"  "" "Multiplied by 10^18" "exa";
menu Vzett "zetta- [*10^21]" "" "Multiplied by 10^21" "zetta";
menu Vyott "yotta- [*10^24]" "" "Multiplied by 10^24" "yotta";
menupopz;
menupop "Function";
menu additems "Add Lines" "" "Add lines" "add";
menu subitems "Subtract Lines" "" "Subtract lines" "subtract";
menu mulitems "Multiply Lines" "" "Multiply lines" "multiply";
menu divitems "Divide Lines" "" "Divide lines" "divide";
menu powitems "Power Lines" "" "Power lines" "power";
menusep;
menu Lequl "Equal Line" "Ctrl+E" "Append equal line" "equal";
menu Labsl "Abs Line" "" "Append abs-value line" "abs";
menu Ldbll "Doubled Line" "" "Append doubled line" "doubled";
menu Lhlvl "Halved Line" "" "Append halved line" "halved";
menu Lintl "Integer Line" "" "Append integer-value line" "int";
menu Linvl "Inverted Line" "" "Append inverted line" "inverted";
menu Lnegl "Negated Line" "" "Append negated line" "negated";
menusep;
menu Lsqtl "Sq Root Line" "" "Append square-rooted line" "sqrt";
menu Lsqrl "Squared Line" "" "Append squared line" "squared";
menu Lcbtl "Cube Root Line" "" "Append cube-rooted line" "cubert";
menu Lcubl "Cubed Line" "" "Append cubed line" "cubed";
menu Lexpl "Exp Line" "" "Append exponential line" "exp";
menu Lextl "10^ Line" "" "Append 10^ line" "exp";
menu Letwl "2^ Line" "" "Append 2^ line" "exp";
menu Llnnl "Ln Line" "" "Append natural-log line" "ln";
menu Lltnl "Log-10 Line" "" "Append log-10 line" "log";
menu Lltwl "Log-2 Line" "" "Append log-10 line" "log";
menusep;
menu Lpiml "Times-π Line" "" "Append line times π" "*π";
menu Lptml "Times-2π Line" "" "Append line times 2π" "*2π";
menu Lpidl "By-π Line" "" "Append line divided by π" "/π";
menu Lptdl "By-2π Line" "" "Append line divided by 2π" "/2π";
menusep;
menu Lt1ml "Times-10 Line" "" "Append line times 10" "*10";
menu Lt2ml "Times-100 Line" "" "Append line times 100" "*100";
menu Lt3ml "Times-1000 Line" "" "Append line times 1000" "*1000";
menu Lt1dl "By-10 Line" "" "Append line divided by 10" "/10";
menu Lt2dl "By-100 Line" "" "Append line divided by 100" "/100";
menu Lt3dl "By-1000 Line" "" "Append line divided by 1000" "/1000";
menupopz;
menupop "Help";
menu hlpt "Help for TABULA" "" "TABULA help" "help";
menu hlpc "Help for 1-char comands" "" "cmds help" "cmds";
menu hinf "Info for this ttable" "" "ttable info" "info";
menupopz;
sbar 3;
sbarset status 120 "Click a line and perform some operation on it...";
sbarset sinf1 30 "";
sbarset sinf2 30 "";
sbarshow;
xywh 5 35 256 140;cc tabs tab tcs_multiline rightmove bottommove;
xywh 1 0 256 32;cc g isigraph;
pas 6 6;pcenter;
rem form end;
)

TTABLE=: 0 : 0
pc ttable;
xywh 5 4 30 60;cc preci combodrop;
xywh 40 4 150 10;cc calco edit rightmove;
xywh 195 4 55 60;cc xunit combodrop leftmove rightmove;
xywh 5 16 244 100;cc panel listbox ws_vscroll lbs_multiplesel rightmove bottommove;
pas 6 6;pcenter;
rem form end;
)

UNSET=: '<UNSET>'

NB. ========== ADVERBS ==========

NB. ========== CONJUNCTIONS ==========

shift=: 2 : 0
	NB. choose handler: u | v depending on shiftkey
	NB. use like this: myhnd=: testcurs shift opencurswd
if. 1=".sysmodifiers do. v y else. u y end.
)

NB. ========== VERBS ==========

Handler=: Handler1

Handler1=: 3 : 0
	NB. DIAGNOSTICS FOR HANDLER DEVT
if. -. TRACH do. return. end.
sessnb=. 3 : 'smoutput nb ''Handler1:'' ; y'
i.0 0
select. y
 case. 'mousemove' do.	NB. no-op
 case. 'calcmd' do.
	smoutput llog 'calco panel_select'
 case.	do.
	sessnb (brack y) ; 'syschild:' ; syschild
end.
)

about=: 3 : 0
	NB. retrieve fixed-info on 1-char commands
wd 'psel tab; set info *' , tabengine 'ABOU'
setshow 3
confirm tabengine 'ABTI'
)

add1u=: 3 : 0
Handler 'add1u'	NB. tool: add 1 / subtract 1
if. heldshift'' do. calcmd '-1' else. calcmd '+1' end.
)

additems=: 3 : 0
	NB. add 2 or more selected items
Handler 'additems'
if. -.setL 1 do. return. end.
NB. tabenginex nb 'plus' ; L0 ; L1
4 tabenginex 'plus' ; panel_select
)

addpc=: 3 : 0
Handler 'addpc'	NB. tool: add 1% / subtract 1%
if. heldshift'' do. calcmd '-1%' else. calcmd '+1%' end.
)

appet=: 'Append'&opent
beep=: wd@('beep'"_)
bit=: 4 : 'y{(>:y){.|. #: x'

bnxy=: 3 : 0
	NB. button X,Y for isigraph button# x
	NB. multiply by 32 for pixel X,Y
(16|y),(y>:16)
)

by2pi=: 3 : 0
Handler 'by2pi'	NB. tool: * PI / * PI2
if. heldshift'' do. calcmd '*PI2' else. calcmd '*PI' end.
)

calcmd=: 3 : 0
Handler 'calcmd'	NB. compose tabengine instructions
0 setL 0	NB. ignore response: only want valid global L0
	NB. Accept y-arg to emulate entering into: calco
	NB. calco -is global: the general input buffer string
if. 0<#y do. calco=: ":y end.
c0=. {. calco=: dltb calco
	NB. ====================
	NB. Whole-calco commands...
select. calco
fcase. '' do.			sess 'calcmd: Move sel down'
case. ,'[' do.			sess 'calcmd: Move sel down'
	movsel 0 return.
case. ,']' do.			sess 'calcmd: Move sel up'
	movsel 1 return.
case. ,'.' do.			sess 'calcmd: Undo'
	undo '' return.
case. '..' do.			sess 'calcmd: Redo'
	redo '' return.
case. ,';' do.			sess 'calcmd: Repeat last'
	tabenginex 'Repe' return.
end.
	NB. ====================
	NB. c0-identified commands...
select. c0	NB. c0 is SCALAR CHAR
case. '/' do.			sess 'calcmd: Engine cmd'
	tabenginex }.calco return.
case. '=' do.			sess 'calcmd: Formula'
	tabenginex nb 'fmla' ; L0 ; }.calco return.
end.
	NB. ====================
	NB. Applying only to line 0...
if. 0=L0 do. tabenginex 'titl' ; calco  return. end.
	NB. ====================
	NB. ALL ELSE needs an item selected...
if. -.setL 0 do. return. end.
	NB. Globals filled by: isunits, isvalunits...
VALUE=: UNDEFINED [ UNITS=: '??' [ RIDER=: ''
if. ']['-: 2{._1|.calco do.	sess 'calcmd: units (forced)'
	if. isunits z=. }.}:calco do.
	  tabenginex nb 'unit' ; L0 ; UNITS
	else. confirm '>>> bad units:' ; z
	end.
elseif. c0=QT do.		sess 'calcmd: label (forced)'
	tabenginex nb 'name' ; L0 ; }.calco
elseif. c0 e. '+-*/^' do.	sess 'calcmd: increment'
	increment calco
elseif. isnumeric calco do.	sess 'calcmd: numeric'
	tabenginex nb 'valu' ; L0 ; VALUE
elseif. isunits calco do. sess 'calcmd: units'
	tabenginex nb 'unit' ; L0 ; UNITS
	setunits 0
elseif. isvalunits calco do.	sess 'calcmd: value+units[+rider]'
	if. 0<#RIDER do.
	  tabengine nb 'name' ; L0 ; RIDER
	end.
	setunits 0 [ tabengine nb 'unit' ; L0 ; UNITS
	tabenginex nb 'valu' ; L0 ; VALUE
elseif. isnumvec calco do. sess 'calcmd: plot instruction'
	invalplot''	NB. discard PLOT* caches
	plotx calco rplc '-' ; '_'
	NB. -to make '-' stick to its atom & not negate the lot
elseif. do.		sess 'calcmd: label (default)'
	tabenginex nb 'name' ; L0 ; calco
end.
)

cb24=: 3 : 0
	NB. convert (r g b)-->24-bit-color
+/y * |.256^i.3
)

clearunits=: 3 : 0
	NB. clear contents of units combo
wd 'psel tab; set xunit ""'
NB. wd 'psel tab; setselect xunit 0'
)

click=: 3 : 0
	NB. execute the isigraph button-handler (CALLBK)
	NB. CALLBK is set continuously by handler: mousemove
	NB. It gets the handler name associated with the tool
if. y=1 do.	NB. mouse down
  1 drawico BNDOWN=:BN
  mousemove''	NB. repaints the toolbar
else.		NB. mouse up
  0 drawico BNDOWN	NB. not BN in case mouse elsewhere
  mousemove''	NB. repaints the toolbar
  if. BNDOWN=BN do. CALLBK apply'' end.
NB.   play 'click1'
end.
)

clickpanel=: 3 : 0
Handler 'clickpanel'	NB. select a line in: panel
smoutput=. empty
smoutput nb 'clickpanel: panel_select=' ; panel_select
0 setL 0
smoutput nb 'clickpanel: L0=' ; L0
if. L0>0 do.
  smoutput 'clickpanel: if. L0>0'
  setunits 0		NB. for dropdown: xunit
	NB. edit the nominal value of the item...
  setcalco scino tabengine 'VALU' ; L0
elseif. panel_select-:'' do.
  smoutput 'clickpanel: if. panel_select empty'
  setcalco ''
elseif. L0=0 do.
  smoutput 'clickpanel: if. L0=0'
  selline 0
  setcalco >{.f2b panel	NB. 1st line of selection buffer
elseif. do.
  smoutput 'clickpanel: no action defined'
end.
confirm details L0
smoutput ''
)

clicktab=: 3 : 0
Handler 'clicktab'	NB. shows selected tab
n=. ".tabs_select	NB. (int)# of the tab clicked
select. n	NB. refill only for these tabs:
case. 1 do. fillconsts''
case. 2 do. fillfuncts''
case. 3 do. ttinf''
end.
setshow n
inputfocus''
)

confirm=: 3 : 0
0 confirm y
:
	NB. standard output message: y to end-user
if. isBoxed y do. y=. nb y end.
putsb msg=: y
msg [ maybeep y		NB. can use: speak instead
DEAF=: DEAFEN		NB. suppress mousemove msg
)

conss=: setshow@(1"_)
consts_cappend_button=: newc
consts_casec_button=: empty
consts_close=: subwindowclose
consts_cons_button=: newc
consts_cons_select=: empty
consts_default=: needsHnd

consts_run=: 3 : 0
try.
  ZZ=: uurowsc searchc	NB. c/f fillconsts
catch.
  ZZ=: ,:UNSET
end.
wd CONSTS
wd 'setfont cons ',FONT
wd 'set cons *',x2f ZZ
wd 'pshow;'
)

consts_searchc_button=: fillconsts

contains=: 4 : 0
	NB. =1 iff x contains any of wds in: y
any (;:x) e. ;:y
)

convert=: convert_uu_

convicon=: 3 : 0
	NB. convert char-represented pixel to rgb num
z=. 0 16bff0000 16bffff00 16b00ff00 16b0000ff 16b3c90fc 16b8e530f 16b9500fc 16ba9a9a9 16be6e6e6 16bffffff
if. -.IFJ6 do.
NB. flip if 255 is red
  z=. fliprgb^:(-.RGBSEQ_j_) z
end.
z{~ '=rygbaMv.;' i. y -. LF
)

copal=: 3 : 0
Handler 'copal'	NB. toolbar
wd 'psel tab; clipcopy *',tabengine 'CTBU'
)

delit=: 3 : 0
Handler 'delit'	NB. delete selected line(s)
invalplot''	NB. discard PLOT* caches
1 tabenginex 'dele' ; panel_select
)

depen=: not_implemented

details=: 3 : 0
	NB. compose details of line: y
if. y=0 do. 'To update title: overtype and Enter' return. end.
nb (CO,~":y) ; (tabengine 'FMLA' ; y)
)

divitems=: 3 : 0
Handler 'divitems'
if. -.setL 1 do. return. end.
4 tabenginex 'divi' ; L0 ; L1
)

dofn=: 3 : 0
Handler 'dofn'	NB. service toolbar click
if. syschild-: ,'g' do. return. end.	NB. not for toolbar
fn=. syschild	NB. name of event-posting ctl, eg 'opent'
if. n9 e.~ {.fn do. fn=. 'N',fn end.	NB. to allow: Ctrl+9 etc
putsb1 fn	NB. gui ctl id into statusbar
if. isverb fn do.
  sess 'dofn: execute verb: ',fn
  fn 128!:2 ''
else.
  smoutput nb 'dofn: absent handler:' ; fn ; 'sysevent:' ; sysevent
  confirm z=. '>>> Not found: ',fn
end.
)

drawico=: 3 : 0
	NB. draws icon# y (0..31)
if. y -: '' do. y=. 1 end.
0 drawico y
:
	NB. if x=1, draws icon depressed
wd 'psel tab;'
icn=. 'ico',nom=. toupper word1 y ffrom BNS
if. 0>nc <icn do.
  nb '>>> unknown icon: ' ; (brack y) ; icn return.
end.
pp=. ". icn
if. x do.	NB. depressed button
  pp=. 33 |. pp
NB.   xx=. f2x }: pp
NB.   xx=. 1 |. _1 |."1 xx
NB.   pp=. LF,~ x2f xx
end.
y pix pp
)

dtblf=: #~ ([: +./\. [: -. (10 32{a.) e.~ ])
dupit=: 'dupl'&funline

eduu=: eduuc shift eduuf

eduuc=: 3 : 0
	NB. edit UUC.ijs
Handler 'eduuc'
open 'dev/uu/uuc'
)

eduuf=: 3 : 0
	NB. edit UUF.ijs
Handler 'eduuf'
open 'dev/uu/uuf'
)

equal=: 3 : 0
Handler 'equal'
('equl-'&funline)y
)

erasf=: 'orph'&funline
ext=: 4 : 'if. -. DT e. x do. x,DT,y else. x end.'

ffrom=: 4 : 0
	NB. analogue of From '{' for use with f-lists
LF taketo (x>0) }. y }.~ x i.~ +/\y=LF
)

fillconsts=: 3 : 0
Handler 'fillconsts'	NB. fill consts pane
set_ucase casec-: ,'0'
wd 'psel tab; set cons *',x2f uurowsc searchc
)

fillfuncts=: 3 : 0
Handler 'fillfuncts'	NB. fill functs pane
set_ucase casef-: ,'0'
wd 'psel tab; set func *',x2f uurowsf searchf
)

flags=: 3 : 0
	NB. literal flags in place of numeric x for tabenginex
if. isNo y do. y return. end.
	NB.	-c	clear calco
	NB.	-l	last line selected
	NB.	-s	clear all selections
#. 'lcs' e. y
)

formu=: 3 : 0
Handler 'formu'	NB. fmla --> calco (for editing)
if. -.setL 0 do. return. end.
if. 0=#f=. (tabengine 'FMLA';L0) do.
  confirm '>>> item' ; L0 ; 'has no formula'
else.
  setcalco '=',f
end.
)

funcs=: setshow@(2"_)
functs_casef_button=: empty
functs_close=: subwindowclose
functs_default=: needsHnd
functs_fappend_button=: newf
functs_func_button=: newf
functs_func_select=: empty

functs_run=: 3 : 0
try.
  ZZ=: uurowsf searchf	NB. c/f fillfuncts
catch.
  ZZ=: ,:UNSET
end.
wd FUNCTS
wd 'setfont func ',FONT
wd 'set func *',x2f ZZ
wd 'pshow;'
)

functs_searchf_button=: fillfuncts

funline=: 3 : 0
	NB. To gen handler: funline bind '<phrase>'
	NB. Cannot use tabenginex raw
	NB. because it needs to incorporate item#: L0
'cpyf' funline y	NB. -if no x <cmd> is given
:
	NB. x is 4-char cmd, with opt trailing flag
	NB. y (opt) is an expression to apply
	NB. -- y-:'' where no expression needed
Handler 'funline'	NB. handler-generator
if. -.setL 0 do. return. end.
tabenginex (4{.x) ; L0 ; y
	NB. derived lines have y==<expression>
	NB. so unless y-:'' select the last line...
if. '-'={:x do. selline nitems'' end.
)

goodfn=: 3 : 0
z=. 'abcdefghijklmnopqrstuvwxyz'
z=. '0123456789',UL,z,toupper z	NB. valid chars
z=. UL (I. -. y e. z)}y
z=. (#~ (+. (1: |. (> </\)))@(UL&~:))z
)

heldalt=: 	3 : '3 bit~ ".sysmodifiers'
heldcmnd=: 	3 : '2 bit~ ".sysmodifiers'
heldctrl=: 	3 : '1 bit~ ".sysmodifiers'
heldshift=: 	3 : '0 bit~ ".sysmodifiers'

hidel=: 3 : 0
Handler 'hidel'
if. -.setL 1 do. return. end.
5 tabenginex 'hide' ; panel_select
)

hinf=: ttinf
hint=: [: confirm '=== ' , ]

hlpa=: 3 : 0
Handler 'hlpa'	NB. retrieve fixed-info on cal-engine
wd 'psel tab; set info *' , tabengine 'ABOU'
setshow 3
)

hlpc=: 3 : 0
Handler 'hlpc'	NB. retrieve fixed-info on engine commands
wd 'psel tab; set info *' , tabengine 'QUER'
setshow 3
)

hlpca=: hlpc shift hlpa

hlpt=: 3 : 0
Handler 'hlpt'	NB. retrieve fixed-info on TABULA HELP
if. heldshift'' do. lob'' return. end.
wd 'psel tab; set info *',HELP
setshow 3
)

hold1=: tthld shift thold

hold=: 3 : 0
Handler 'hold'	NB. toggle (transient) hold to ALL selected items
if. 0=#panel_select do.
  confirm '>>> No action: needs 1 or more selected lines'
else.
  for_L. ps=.,". panel_select do.
    panel_select=: ,":L
    hold1''
  end.
  sellines ps
  panel_select=: ,":ps
end.
)

holdcons=: '!' ,~ ]

iedit=: 3 : 0
Handler 'iedit'	NB. tool: edit name / formula
if. heldshift'' do. formu'' else. label'' end.
)

ijsstr=: 3 : 0
	NB. Open a new IJS window with: (str)y
cocurrent 'jijs'
newijs''	NB. create a new IJS window
wd 'set e *',,y	NB. and fill it with the text in y
n=. {:conl 1
save__n ''
)

immx=: runimmx0_jijs_
inc1=: 3 : 'y{1 _1'

increment=: 3 : 0
	NB. treat y (from calco) as an incremental spec
	NB. serves: calcmd
NB. tabenginex =. smoutput
sess nb 'increment:' ; y
y=. dtb ,y
if. y-:,'+' do. tabenginex nb 'addv' ; L0 ; 1 return. end.
if. y-:,'-' do. tabenginex nb 'subv' ; L0 ; 1 return. end.
'c0 pc yval'=. ({.y) ; (('%'={:y){'vp') ; '%' -.~ }.y
cmd=. pc ,~ > ('+-*/^' i. c0) { ;:'add sub mul div rto'
if. isnumeric yval do.
  tabenginex nb cmd ; L0 ; VALUE
else.
  confirm '>>> bad command:' ; y
end.
)

inf_close=: subwindowclose
inf_default=: dofn

inf_run=: 3 : 0
wd INF
wd 'setfont info ',FONT
wd 'set info *' , tabengine 'INFO'
wd 'pshow;'
)

infor=: showttinf

inputfocus=: 3 : 0
Handler 'inputfocus'	NB. give calco the focus
wd 'psel tab; pactive'
select. TABNDX
case. 0 do. wd 'psel tab; setfocus calco'
case. 1 do. wd 'psel tab; setfocus searchc'
case. 2 do. wd 'psel tab; setfocus searchf'
case. 3 do.	NB. no-op
end.
i.0 0
)

invalg=: wd@('psel tab; setinvalid g'"_)

invalplot=: 3 : 0
	NB. Invalidate the PLOT* caches
erase listnameswithprefix 'PLOT'
)

isInf=: _ e. |
iscmd=: 3 : 'tabengine ''QCMD '',y'
iscmd1=: 3 : '{. (y e. ''.:<>\!I'') *. (1=#y)'

isnumeral=: 3 : 0
	NB. y is a (str) valid scalar numeral
if. 2~: 3!:0 y do. 0 return. end.	NB. must be 'literal'
a=. 0<#y		NB. not empty
NB. b=. *./y e. n9,DT	NB. only contains digits and DT
v=. _". y		NB. critical evaluation
c=. 0=#$v		NB. eval'd no is scalar
d=. -.NaN v		NB. v is valid numeral(s)
f=. -.isInf v		NB. v is not _ or __
NB. i=. *./y e. n9	NB. only contains digits
a *. c *. d *. f
)

isnumeric=: 3 : 0
	NB. y evaluates to a number
try. isNo VALUE=: ".y catch. 0 end.
)

isnumvec=: 3 : 0
	NB. y is a (str) valid vector numeral 1<# ".y
	NB. c/f isnumeral
if. 2~: 3!:0 y do. 0 return. end.	NB. must be 'literal'
if. 0=#y do. 0 return. end.		NB. not empty
try. v=. ". y		NB. evaluation as J noun expr
catch. 0 return.	NB. syntactically correct
end.
c=. 1<#v		NB. eval'd no is vec, #>1
d=. -.NaN v		NB. v is valid numeral(s)
c *. d
)

isunits=: 3 : 0
	NB. Bool: y is valid units, set UNITS
-. '??' -: >{.convert UNITS=: deb y
)

isvalunits=: 3 : 0
	NB. Bool: y is value + units, set UNITS
	NB. c/f isunits
if. 1<#z=. _". y do.	NB. converts to 2 nos or more
  if. (_=VALUE=:{.z) +. (_~:1{z) do. 0 return. end.
else. 0 return.
end.
'y r'=. 2{. QT cut y
RIDER=: dlb r
if. 0=#UNITS=: deb SP dropto y do. UNITS=: '/' end.
-. '??' -: >{.convert UNITS
)

isverb=: 3 = [: 4!:0 <

label=: 3 : 0
Handler 'label'	NB. label --> calco (for editing)
if. -.setL 0 do. return. end.
setcalco QT,(tabengine 'NAME' ; L0)
)

lob=: 3 : 0
Handler 'lob'
load '~user/lobrow.ijs'
)

maybeep=: 3 : 0
	NB. decides if message: y needs beep
if. -.isLit y do. return. end.
if. '>>>' -: 3{.y do. beep''
elseif. y contains 'bad incompatible' do. beep''
end.
)

merge=: 3 : 0
Handler 'merge'	NB. merge 2 lines
if. -.setL 1 do. return. end.
	NB. Shift held: setL swaps L0 L1
tabenginex 'merg' ; L0 ; L1
selline (L0,L1) {~ heldshift''
)

mousemove=: 3 : 0
Handler 'mousemove'	NB. tracks mouse
	NB. Mouse-hover over: g isigraph -repeatedly updates:
	NB.  sysdata -with x,y co-ords in: g, & modkeys
	NB. Info in sysdata and BNS (buttons definition) -->
	NB.  --BN	# of the button under mouse, 0 to 31
	NB.  --CALLBK	handler to be run if mouse clicked
	NB.  also writes a tool hint in status bar
'x y shifton'=. 0 1 7 { z=. ".sysdata
br=. <. y % 32	NB. button row: 0..1
bc=. <. x % 32	NB. button col: 0..16
BN=: (16*br)+bc	NB. button number 0..31
if. -. BN e. i.32 do.	NB. mouse has left toolbar...
  repaintg''	NB. to pop any buttons back up
  CALLBK=: '' return.
end.
CALLBK=: tolower word1 line=. BN ffrom BNS
z=. dltb > shifton{ 2 $ SL cut words line
if. 0=#z do. z=. nb 'Undefined BNS line:' ; BN end.
	NB. suppress putsb-message for DEAF more cycles...
if. DEAF>0 do. DEAF=: DEAF-1 else. putsb z end.
putsb1 ":BN
putsb2 CALLBK
)

movit=: 3 : 0
Handler 'movit'	NB. Move selected line (L0) down 1 line
	NB. c/f mvitu
if. L0>:MAXLINE do.
  confirm '>>> No action: last line reached'
  return.
end.
invalplot''	NB. discard PLOT* caches
'movd' funline L0
selline L0+1
)

movsel=: 3 : 0
	NB. move line selection down /up(y=1)
last=. {:items=. tabengine 'ITMS'
i=. L0 + y{1 _1
if. i>last do. i=. 1 end.
if. i<1 do. i=. last end.
selline i
)

movud=: mvitu shift movit

mulitems=: 3 : 0
Handler 'mulitems'
if. -.setL 1 do. return. end.
NB. tabenginex 'mult' ; L0 ; L1
4 tabenginex 'mult' ; panel_select	NB. accepts multiple lines
)

mvitu=: 3 : 0
Handler 'mvitu'	NB. Move selected line (L0) up 1 line
	NB. c/f movit
if. L0<:1 do.
  confirm '>>> No action: first line reached'
  return.
end.
invalplot''	NB. discard PLOT* caches
'movu' funline L0
selline L0-1
)

needsHnd=: 3 : 'smoutput sysevent,NEEDS'

newc=: 3 : 0
Handler 'newc'	NB. make a new Const line
cons newc y	NB. cons is selection buffer
:
if. 0=#x-.SP do.
  confirm '>>> No action: select a single line'
else.
  4 tabenginex 'cons' ; holdcons x
end.
)

newf=: 3 : 0
func newf y	NB. func is selection buffer
:
Handler 'newf'	NB. make a new Funct line
if. 0=#x-.SP do.
  confirm '>>> No action: select a single line'
else.
  4 tabenginex 'func' ; x
end.
)

newkg=: 4&tabenginex@('newu kg'"_)
newlc=: 4&tabenginex@('newu c'"_)
newlm=: 4&tabenginex@('newu m'"_)
newls=: 4&tabenginex@('newu s'"_)
newmo=: not_implemented

newsl=: 3 : 0
Handler 'newsl'
4 tabenginex 'newu /'
)

newst=: 4&tabenginex@('newu *'"_)

newtt=: 3 : 0
Handler 'newtt'	NB. New ttable
if. -. preload'' do. return. end.
0 ttinf''	NB. clear the info display
1 tabenginex 'newt'
clearunits''
immx 'inputfocus_tab_ 0'
)

nitems=: 3 : '+/LF=tabengine''CTBU'''
none=: not_implemented

not_implemented=: 3 : 0
	NB. assign to unimplemented handler
'form id control'=. UL cut sysevent
smoutput id,'=:',TAB,'not_implemented'
empty confirm '>>> NOT IMPLEMENTED: ',id
)

nr=: 3 : 0
	NB. (lit) numerical representation of (num): y
if. 1>|y do.		z=. 21j17 ": y
elseif. 1e10 <: |y do.	z=. 21j7 ": y
elseif.	do.		z=. ": y
end.
z rplc '_' ; '-'
)

opens=: 3 : 0
'$$' opens ''
:
Handler 'opens'	NB. Handler generator
	NB. load a sample ttable
	NB. This is a cut-down version of: opent
if. -. preload'' do. return. end.
1 tabenginex 'open' ; x
clearunits''
ttinf''
immx 'inputfocus_tab_ 0'
)

opent=: 3 : 0
'Open' opent y
:
	NB. x is: 'Open' | 'Append'
Handler 'opent'	NB. service handlers: opent, appet
	NB. If shift held, open SAMPLE instead...
if. heldshift'' do. opens'' return. end.
if. -. preload'' do. return. end.
cmd=. 4{. lowx=. tolower x
mytitle=. nb 'Choose a ttable to' ; lowx ; '...'
mydir=. TPATH_TTABLES
nom=. wd nb 'mbopen' ; (dquote mytitle) ; (dquote mydir)
	NB. At present we use filename-only: nom
	NB. and assume all ttables reside in folder: mydir
nom=. nom rplc BS ; SL
if. 0=#nom do.
  confirm '>>>' ; x ; '...cancelled'
else.
  1 tabenginex cmd ; fprefix nom
  clearunits''
  ttinf''
  immx 'inputfocus_tab_ 0'
end.
)

paneL0=: 3 : 'L0=: {. 0 ". panel_select'

pickunits=: 3 : 0
Handler 'pickunits'	NB. service the xunit combo
setunits 1
)

pix=: 4 : 0
	NB. draw pixels of nico: y for button#: x -- 0..31
'X Y'=. 32 * bnxy x
glpixels X,Y, 32 32 ,, convicon y
)

play=: 3 : '2!:1 ''afplay '',TPATH_TABULA,wav y'
playerror=: play@('error'"_)
playwarning=: play@('warning'"_)

plot=: 3 : 0
	NB. call plotting fn with data returned by: cal
	NB. (This fn originally came from: cal)
caller_jwplot_=. coname''
'' plot_jwplot_ y
:
caller_jwplot_=. coname''
x plot_jwplot_ y
inputfocus''
)

plotb=: 3 : 'replot PLOTF=:''bar'''
plotl=: 3 : 'replot PLOTF=:''line'''
plotp=: 3 : 'replot PLOTF=:''pie'''
plots=: 3 : 'replot PLOTF=:''surface'''

plotx=: 3 : 0
	NB. generate data for plot from input: y
	NB. y is STRING: (y) is numvec
	NB. to allow short string arg --> long num vec
	NB. e.g. 'i.10000'
smoutput nb 'plotx: y=' ; y
if. -.setL 0 do. return. end.
PLOTX=: L0	NB. the item with the x-axis points
PLOT=: tabengine 'PLOT' ; PLOTX ; y
undo''	NB. restore prior ttable values
NB. Y=. (0,PLOTX) -.~ i.#PLOT	NB. ALL y-axis item(s)
Y=. {: i.#PLOT			NB. LAST y-axis item only
PLOTY=: Y default 'PLOTY'	NB. same as prev -or Y
PLOTF=: 'line' default 'PLOTF'
PLOTF plot (PLOTX{PLOT) ; (PLOTY{PLOT)
sellines PLOTY	NB. indicate which have been plotted
)

powitems=: 3 : 0
Handler 'powitems'
if. -.setL 1 do. return. end.
4 tabenginex 'powe' ; L0 ; L1
)

preload=: 3 : 0
	NB. called by verbs which invalidate old table
	NB. heldalt'' skips the DIRTY check...
if. (tabengine 'DIRT') and -.heldalt'' do.
	par=. 'Save current ttable?'
	msg=. 'Ttable: ',tabengine 'TITL'
	msg=. msg,LF,'has unsaved structural changes.'
	msg=. msg,LF,'OK to continue (and lose the changes)?'
	if. 0 wdquery par;msg do.
	   confirm '>>> New/load ttable -cancelled'
	   0 return.
	end.
end.
invalplot''	NB. discard PLOT* caches
1 return.
)

print=: 3 : 0
	NB. Print the ttable
	NB. (For now: simply create an IJS window)
z=. tabengine 'TFIL'
if. IFJ6 do.
  z=. z,LF,LF,LF
  z=. z,tabengine 'CTBU'
  ijsstr z
else.
  require 'graphics/print'
  if.''-.@-: wd 'mbprinter' do. print_jprint_ z end.
end.
)

putpanel=: 3 : 0
	NB. put y (assumed zuf-format) into ctl; panel
wd 'psel tab; set panel *',y
MAXLINE=: +/LF=y
)

putsb=: 'status'&putsbx
putsb1=: 'sinf1'&putsbx
putsb2=: 'sinf2'&putsbx

putsbx=: 4 : 0
	NB. generator for: putsb putsb1 putsb2
wd 'psel tab; sbarset ',x,' -1 ',dquote ":,y
NB. sess 'putsbx: ',y
i.0 0
)

qs=: 3 : 0
	NB. query the current panel selection
smoutput llog 'L0 L1 panel_select'
)

quit=: 3 : 0
Handler 'quit'	NB. Orderly shutdown after housekeeping
if. -. preload'' do. return. end.
winpos 1	NB. write out window posn,size
RUNTIME_z_=: 0 default 'RUNTIME_z_'
if. RUNTIME or heldalt'' do. exit'' else. window_close'' end.
)

redo=: tabenginex@('Redo'"_)

refresh=: 3 : 0
0 refresh y		NB. y is always ignored
:
	NB. x (bit-int) sets finishing state of display
x=. flags x	NB. flags: lit --> bit-coded int
putpanel tabengine 'CTBU'
if. x bit 0 do.	NB. clear panel selections
  sellinex''	NB. c/f selline
else.	NB. restore panel selections
  if. L0>0 do. wd nb 'setselect panel' ; L0 end.
  if. L1>0 do. wd nb 'setselect panel' ; L1 end.
end.
if.-. x bit 1 do.	NB. clear calco
  upctl 'calco'
end.
if. x bit 2 do.		NB. select last line
  selline nitems''	NB. sets L0 for next stmt...
  setunits 0		NB. update units combo
  inputfocus''
end.
)

repaintg=: 3 : 0
	NB. refresh the toolbar
invalg''
for_i. i.32 do. 0 drawico i end.
)

repet=: tabenginex@('Repe'"_)

replot=: 3 : 0
	NB. plot existing PLOT again, using selections
Handler 'replot'
if. 0~:nc<'PLOT' do.
  confirm '>>> No action: no plot steps specified yet'
  return.
end.
if. heldshift'' do.	NB. plot all items
  PLOTY=: (0,PLOTX) -.~ i.#PLOT
else.	NB. Update PLOTY from selections only if any made
  Y=. (0,PLOTX) -.~ ".panel_select
  if. 0<#Y do. PLOTY=: Y end.
end.
PLOTF=: 'line' default 'PLOTF'
PLOTF plot (PLOTX{PLOT) ; (PLOTY{PLOT)
sellines PLOTY	NB. indicate which have been plotted
)

repos=: 3 : 0
return.
Handler 'repos'	NB. reset form pos+size to value in XYWH
if. (y-:0) or (heldshift'') do. XYWH=: XYWH0 end.
wd nb 'psel tab; pmovex' ; XYWH
)

restart=: 3 : 0
Handler 'restart' NB. warm-start TABULA, eg after editing UUC or tabtools
start_uu_''
start 1		NB. start detects 0<#y
)


savea=: 3 : 0
Handler 'savea'	NB. service the "save ttable as..." ctl
	NB. NEEDS...
	NB. trial save-name setup in field
mytitle=. 'Save ttable as...'
mydir=. TPATH_TTABLES
nom=. wd nb 'mbsave' ; (dquote mytitle) ; (dquote mydir)
if. 0=#nom do.
  confirm '>>> Save As... cancelled'
else.
  1 tabenginex 'save' ; fprefix nom
end.
)

saves=: 3 : 0
	NB. save ttable as: SAMPLE
tabenginex 'save $$'
)

savet=: 3 : 0
	NB. save ttable under current title
	NB. Use savea if title undefined
Handler 'savet'
if. (title'')-:tabengine'TITU' do. savea'' return. end.
tabenginex 'save' ; goodfn title''
)

savex=: 3 : 0
	NB. save ttable under existing filename
	NB. Use savea if file undefined
if. (ttname'')-:tabengine'TFLU' do. savea'' return. end.
tabenginex 'save'	NB. uses: file_cal_ anyway
)

savts=: savet shift saves

scino=: scino_uu_

selline=: 3 : 0
	NB. select single line: y
wd 'psel tab; setselect panel -1'
panel_select=: ,":L0=: {.y
L1=: 0	NB. to simulate clicking on the item y
wd nb 'psel tab; setselect panel' ; L0
)

sellines=: 3 : 0
	NB. select multiple lines: y
	NB. ASSUMES all item#s are valid.
wd 'psel tab; setselect panel -1'
panel_select=: ":y
'L0 L1'=: 2 {. y
	NB. ...just a formality: the work is done by:
for_i. y do.
  wd nb 'setselect panel' ; i
end.
)

sellinex=: 3 : 0
	NB. clear line selections
wd 'psel tab; setselect panel -1'
panel_select=: ''
L1=: L0=: 0
)

sess=: 3 : 'if. TRACE do. smoutput y end.'

setL=: 3 : 0
1 setL y
:
	NB. set L0 L1 from: panel_select
	NB. setL 0	-only L0>0 needed
	NB. setL 1	-both L0>0 and L1>0 needed
	NB. returns 1 iff condition satisfied
	NB. eg: if. -.setL 1 do. return. end.
z=. 0 ". panel_select,' 0 0'
if. (y>:1) *. heldshift'' do.
	'L1 L0'=: 2{.z
else.
	'L0 L1'=: 2{.z
end.
if. x-:0 do. empty'' return. end.	NB. suppress validn msg
valid=. (L0>0) *. ((L1>0) +. (y<1))
if. -.valid do.
  confirm '>>> No action: needs'; (>:y); 'or more selected lines'
end.
valid	NB. should abort the calling handler if 0
)

set_ucase=: set_ucase_uu_

setcalco=: 3 : 0
	NB. set text: y into ctl: calco
wd 'psel tab; set calco *',calco=: ,":y
)

setpreci=: 3 : 0
Handler 'setpreci'	NB. set numeric precision
	NB. set significant figures for cal numbers
if. 0=#y do. z=. preci else. z=. ":y end.
wd 'psel tab; setselect preci ',z
tabenginex 'prec' ;  z
)

setshow=: 3 : 0
	NB. show the ctls of tab#: y (int)
wd 'psel tab;'
	NB. expects old TABNDX here (of what's showing)
wd 'setshow ',(>TABNDX{tabgroups),' 0'	NB. hide ctls
TABNDX=: y
wd 'setshow ',(>TABNDX{tabgroups),' 1'	NB. show ctls
wd 'setselect tabs ',":y
)

setunits=: 3 : 0
	NB. set (y=0) or change (y=1) units of line L0
y_tab_=: y
sess log 'y L0 L1 xunit xunit_select'
if. -.setL 0 do. return. end.
if. y do.	NB. called with y=1: change units
  tabenginex nb 'unit' ; L0 ; xunit
else.		NB. called with y=0: set units in combo
  z=. any2f tabengine nb 'UCOM' ; L0
  wd 'psel tab; set xunit *',utf8 z
  wd 'psel tab; setselect xunit 0'	NB. -current unit
end.
i.0 0
)

setval=: 3 : 0
Handler 'setval'	NB. tool: set value 0 / 1
if. heldshift'' do. Vonep'' else. Vzero'' end.
)

showttinf=: 3 : 0
Handler 'showttinf'
ttinf setshow 3
)

siunt=: 3 : 0
	NB. cannot use funline: must call setunits
Handler 'siunt'	NB. convert to SI-units
if. -.setL 0 do. return. end.
tabenginex 'cvsi' ; L0 ; y
setunits 0
)

speak=: 3 : 0
	NB. decides if message: y needs spoken warning
if. -.isLit y do. return. end.
if. '>>>' -: 3{.y do. playerror''
elseif. y contains 'bad incompatible' do. playerror''
end.
)

start=: 3 : 0
	NB. start the app: create form and init: cal
if. 0[ -.IFJ6 do.
  smoutput '>>> TABULA is not yet supported in this JVERSION:'
  smoutput JVERSION
  return.
end.
load :: 0: TPATH_TABULA,'manifest.ijs'	NB. sets VERSION
RUNTIME_z_=: 0 default 'RUNTIME_z_'
if. coldstart=. 0=#y do.
  sess 'start_tab_: enters...'
else.
  sess 'start_tab_: called by: restart with y=',":y
end.
	NB. Load editable scripts for: tab
load TPATH_TABULA,'tabfun.ijs'
load TPATH_TABULA,'tabtools.ijs'
tabengine 'Init'	NB. Start the CAL engine
Handler=: Handler1	NB. or: Handler=: empty
L0=: 1
L1=: 0
sysmodifiers=: ,'0'
searchc=: searchf=: ''
MAXLINE=: 0
if. coldstart do.
	window_close''	NB. close any existing window
	TABNDX=: 0	NB. tab_tabs_button sets it to current tab
	wd TABU
	tabgroups=: 'ttable';'consts';'functs';'inf'	NB. wd-ids of sub-forms
	wd 'set tabs "Ttable" "Consts" "Functs" "Info"'	NB. labels in their tabs
	wd 'creategroup tabs'
	ttable_run''
	consts_run''
	functs_run''
	inf_run''
	wd 'creategroup'
	wd 'setshow ttable 1'
  wd^:(-.IFJ6) 'pshow;pshow sw_hide'
end.
calco=: ''	NB. used by: calcmd...
sess 'start_tab_: init the form'
paneL0'' [panel_select=: ,'1'
setpreci 3	NB. set precision in dropdown
setunits 0
winpos''	NB. restore saved window position,size
wd^:(-.IFJ6) 'pshow;pshow sw_hide'
wd 'pn "Tabula"'
	NB. Define toolbar buttons ...
toolbar_make''
	NB. Finish off ...
sess 'start_tab_: completed'
empty inputfocus''
wd 'pshow'
wdloop^:(-.IFJ6)''
)

stept=: 3 : 0
Handler 'stept'	NB. tool: plot in standard steps
if. -.setL 0 do. return. end.
selline L0
val=. | tabengine 'VALU' ; L0
if. val=0 do.
  confirm '>>> cannot plot zero-to-zero'
  return.
end.
if. heldshift'' do.
	z=. (-|val),(|val),100
else.
  if. val<0 do. z=. val,0,100 else. z=. 0,val,100 end.
end.
calcmd 'steps ',":z
)

stup=: 3 : 0
Handler 'stup'	NB. alter startup.ijs to run TABULA
efx=. 'load ''math/tabula'''
z=. freads fi=. jpath '~config/startup.ijs'
if. z-:freads'' do.	NB, startup file is absent
  rc=. efx fwrites fi
  confirm 'startup file created' ; (brack rc)
else.
  z fwrites jpath '~config/startup.bak'
  rc=. efx fwrites fi
  confirm 'startup file replaced' ; (brack rc) ; '(old=startup.bak)'
end.
)

subitems=: 3 : 0
Handler 'subitems'
if. -.setL 1 do. return. end.
4 tabenginex 'minu' ; L0 ; L1
)

subwindowclose=: wd@('pclose'"_)
tab_close=: quit
tab_default=: dofn
tab_g_focus=: empty
tab_g_focuslost=: empty
tab_g_mbldown=: click@(1"_)
tab_g_mblup=: click@(0"_)
tab_g_mmove=: mousemove
3 : 0''
if. -.IFJ6 do.
if. 3=GTKVER_j_ do.
tab_g_paint=: 3 : 'for_i. i.32 do. 0 drawico i end.'
end.
end.
''
)
tab_run=: start
tab_tabs_button=: clicktab
tabengine=: tabengine_cal_

tabenginex=: 3 : 0
0 tabenginex y
:
	NB. send y to cal and act on result	c/f: exe
	NB. if. 1= x bit 0(eg x=1)	-clear panel sel's
	NB. if. 1= x bit 1(eg x=2)	-clear calco
	NB. if. 1= x bit 2(eg x=4)	-select last line
if. isBoxed y do. y=. nb y end.
x refresh confirm tabengine INSTR=: ,y
setshow 0
)

tbx=: ijs
thold=: 'holm'&funline
title=: tabengine@('TITL'"_)

toolbar_make=: 3 : 0
	NB. draws pics in g isigraph
	NB. call inside: start_tab_
BNS=: BNS charsub~ TAB,SP
wd 'psel tab;'
	NB. assume always 32 buttons to find
for_i. i.32 do. 0 drawico i end.
)

traca=: 3 : 0
Handler 'traca'	NB. tool: toggle trace(s)
if. heldshift'' do. trach''
elseif. heldalt'' do. traci''
elseif. do. trace'' 
end.
)

trace=: 3 : 0
	NB. set/toggle TRACE in tab (not cal)
	NB. set TRACE in cal by direct engine call
	NB. or: ']trac _' in calco
if. (y=.{.y) e. 0 1 do.
  TRACE=: y
else.
  TRACE=: -. TRACE
end.
confirm '+++ TRACE=' ; TRACE
)

trach=: 3 : 0
	NB. set/toggle TRACH (Handler1)
if. (y=.{.y) e. 0 1 do.
  TRACH=: y
else.
  TRACH=: -. TRACH
end.
confirm '+++ TRACH=' ; TRACH
)

traci=: 3 : 0
	NB. toggle TRACI in: cal
	NB. echoes the commands received by cal
	NB. To toggle TRACE in cal: do direct engine call
	NB. or: ']trac _' in calco
smoutput nb 'traci:' ; tabengine 'trai _'
)

trunc=: i. {. [
truncl=: i: {. [
truncmax=: 4 : 'if. x<$y do. x{.y else. y end.'
truncn=: 3 : 'if. ''0123456789'' e.~ {:y do. }:y else. y end.'
truncnn=: truncn^:_

ttabl=: 3 : 0
Handler 'ttabl'	NB. show Ttable tab and refresh it
tabengine 'reca'
sellinex''
setcalco''
setshow 0
)

ttable_calco_button=: calcmd
ttable_close=: subwindowclose
ttable_default=: needsHnd
ttable_panel_button=: clickpanel
ttable_panel_select=: clickpanel
ttable_preci_select=: setpreci

ttable_run=: 3 : 0
	NB. create the subwindow for tab: "Ttable"
wd TTABLE
wd 'set xunit *',zuluf
wd 'setselect xunit 0'
wd 'set preci *', o2f ": i.16
wd 'setselect preci 2'
wd 'setfont panel ',FONT
NB. wd 'set panel *',ctt''
wd 'set panel *',UNSET
wd 'pshow;'
)

ttable_xunit_button=: empty
ttable_xunit_select=: pickunits

ttcont=: 3 : 0
Handler 'ttcont'
if. -:/tabengine each ;:'TFIL TFLU' do.
  confirm '>>> cannot open undefined ttable - save it first'
else.
  open tabengine 'TFIL'
end.
)

tthld=: 'hold'&funline

ttinf=: 3 : 0
Handler 'ttinf'	NB. called as a handler
1 ttinf y
:
	NB. Put / get ttable info to/from ctl: info
	NB. x-:0	-clears ctl: info
	NB. x-:1	-gets/shows TTINFO
	NB. x otherwise	-updates TTINFO from y
	NB.		-or from (info) if y is empty.
if. x-:1 do.		NB. -->CALLED AS HANDLER (default x)
  z=. tabengine 'INFO'	NB. return info string
  wd 'psel tab; set info *',z
  confirm 'ttable info retrieved'
elseif. x-:0 do.	NB. -->CALLED to clear the display
  wd 'psel tab; set info ""'
elseif. do.		NB. set ttable info from y or info
  if. 0=#y do. y=. info end.
  tabenginex 'info' ; y
  confirm 'Info: $=' ; ($y) ; 'updated in ttable:' ; ttname''
end.
)

ttname=: tabengine@('TNAM'"_)
undo=: tabenginex@('Undo'"_)

undoredo=: undo shift redo

unhid=: tabenginex@('unhid'"_)

upctl=: 3 : 0
	NB. put: x into ctl (y)
'' upctl y
:
(y)=: x=. ,":x
wd nb 'psel tab; set' ; y ; '*',x
)

updex=: tabenginex@('exch'"_)
updin=: 2&ttinf
uurowsc=: uurowsc_uu_
uurowsf=: uurowsf_uu_
vv=: ":@|:@,:
wav=: ] , '.wav' #~ [: -. '.' e. ]

3 : 0''
if. IFJ6 do.
  wd=: wd_probed
end.
''
)

wd_probed=: 3 : 0
try.
  11!:0 y
catch.
  sess 'wd: failed with: ',WD=: y
end.
)

win=: 3 : 0
	NB. convert path for Windows
y
if. IFWIN32 +. IFWINNT do. y rplc SL ; BS end.
)

window_close=: 3 : 0
NB. Close the form: tab
NB. SAFE TO CALL EVEN IF WINDOW IS ABSENT
try.
  wd`(11!:0)@.IFJ6 'psel tab; pclose;'
catch.
  i.0 0
end.
)

winpos=: 3 : 0
	NB. write out (y=1) or read back window pos
posfi=. TPATH_TABULA,'posn.ijs'
if. y-:1 do.	NB. write out...
 xywh''
 z=. 'XYWH=: ',":XYWH
 z fwrite posfi
else.		NB. read back...
 XYWH=: XYWH0
 load :: 0: posfi
 repos''
end.
)

word1=: 3 : 0
	NB. leading word in a string
SP taketo y
)

words=: 3 : 0
	NB. remaining words in a string
dltb SP takeafter y
)

xywh=: 3 : 0
	NB. get current window xywh --> mapped noun 
XYWH=: ". wd 'psel tab; qformx;'
)

NB. =========================================================
NB. NEEDED FOR MSWIN
NB. Hotkey handlers
NB. =========================================================
N0ctrl=:	Vzero
N1ctrl=:	Vonep
cctrlshift=:	copal
dctrl=:		dupit
ectrl=:		Lequl
fctrlshift=:	formu
gctrlshift=:	tthld
hctrlshift=:	thold
ictrl=:		infor
jctrl=:		mvitu
kctrl=:		movit
lctrl=:		newsl
mctrl=:		merge
nctrl=:		newtt
nctrlshift=:	label
octrl=:		opent
octrlshift=:	opens
qctrlshift=:	quit 
rctrlshift=:	repet
sctrl=:		savex
sctrlshift=:	siunt
tctrl=:		ttabl
tctrlshift=:	trace
yctrl=:		redo 
zctrl=:		undo	NB.inactive--masked!
uctrl=:		undo
uctrlshift=:	redo
	NB. --leave zctrlshift to pair with zctrl

NB. ========== z-LOCALE ==========

cocurrent 'z'

TPATH_TABULA=: 3 : 0 ''
	NB. returns directory containing this script
	NB. also assigns global: WHEREAMI -the folder in question
	NB. plus SEP -the platform-dependent path-separator.
ws=. [: 'Not from script'"_`({ 4!:3@(0&$))@.(0&<:) [: 4!:4 [: < >
WHEREAMI=: '<UNSET>'	NB. needed for ws to work with
z=. >ws 'WHEREAMI'
SEP=: '/\' {~ '\' e. z
WHEREAMI=: (>: z i: SEP) {.z
)

	NB. Load: cal -by looking for sibling folder
load (TPATH_TABULA,'tabula.ijs') rplc ;:'tabula cal'

	NB. Permit manual reset of window posn by entering: repos 0
repos=: repos_tab_

start_tab_''
