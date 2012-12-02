load 'jdgrid jsgrid jtgrid jvgrid jzgrid'

coclass 'jgriddemo'
coinsert 'jgl2 wdbase'
droidwd_run=: griddemo_run
grid=: ''

DEVOPTS=: OPTIONS_jzgrid_,cutopen 0 : 0
DATANAME
HDRCOL2
VERB
XPRECISION
)
3 : 0''
if. 0 ~: 4!:0 <'GRIDDEMOSEL' do.
  GRIDDEMOSEL=: 'GRID'
end.
EMPTY
)
create=: 0:
destroy=: 3 : 0
destroy__grid''
wd ::] 'psel gridedit;pclose'
wd ::] 'psel gridnotes;pclose'
wd ::] 'psel griddemo;pclose'
codestroy''
)
gridrun=: 3 : '0 gridinit y'
gridruns=: 3 : '1 gridinit y'
gridinit=: 4 : 0
wd 'psel griddemo'
griddemo_pn > GRIDNAMES {~ GRIDEXAMS i. <GRIDDEMOSEL
glsel 'grid'
erase DEVOPTS
grid_gridhandler=: 1:
GRIDPID=: 'griddemo'
if. x do.
  CLASS=: ". 'C',y
  y=. ". 'D',y
end.
0!:100 gridfix y
nms=. (0 = nameclass DEVOPTS) # DEVOPTS
pkg=. nms,.".each nms
if. #grid do.
  destroy__grid''
end.
grid=: '' conew CLASS
show__grid pkg
)
assign=: 4 : '".x,''=:y'''

fexist=: 1:@(1!:4)@boxopen ::0:
gridfix=: 3 : 0
y=. toJ y
y=. <;.2 y,LF
m=. y = <'()',LF
;(<')',LF) (I.m) } y
)
gridunfix=: 3 : 0
y=. toJ y
y=. <;.2 y,LF
m=. y = <')',LF
;(<'()',LF) (I.m) } y
)
ALPHAS=: (' ',LF) cutopen 0 : 0
Alpha Bravo Charlie Delta Echo Foxtrot Golf Hotel India Juliet
Kilo Lima Mike November Oscar Papa Quebec Romeo Sierra Tango
Uniform Victor Whiskey Xray Yankee Zulu
)

MONTHS=: <;._2 (0 : 0)
January
February
March
April
May
June
July
August
September
October
November
December
)
COUNTRIES=: <;._2 (0 : 0)
Afghanistan
Albania
Algeria
Andorra
Angola
Anguilla
Antigua and Barbuda
Argentina
Armenia
Aruba
Australia
Austria
Azerbaijan
Bahamas
Bahrain
Bangladesh
Barbados
Belarus
Belgium
Belize
Benin
Bermuda
Bhutan
Bolivia
Bosnia and Herzegovina
Botswana
Brazil
British Virgin Islands
Brunei
Bulgaria
Burkina Faso
Burma
Burundi
Cambodia
Cameroon
Canada
Cape Verde
Cayman Islands
Central African Republic
Chad
Chile
China
Colombia
Comoros
Congo
Costa Rica
Cote d'Ivoire
Croatia
Cuba
Cyprus
Czech Republic
Denmark
Djibouti
Dominica
Dominican Republic
East Timor
Ecuador
Egypt
El Salvador
Equatorial Guinea
Eritrea
Estonia
Ethiopia
Federated States of Micronesia
Fiji
Finland
France
French Guiana
Gabon
Gambia
Georgia
Germany
Ghana
Greece
Greenland
Grenada
Guadeloupe
Guatemala
Guinea
Guinea-Bissau
Guyana
Haiti
Holy See
Honduras
Hong Kong
Hungary
Iceland
India
Indonesia
Iran
Iraq
Ireland
Israel
Italy
Jamaica
Japan
Jordan
Kazakhstan
Kenya
Kiribati
Kuwait
Kyrgyzstan
Laos
Latvia
Lebanon
Lesotho
Liberia
Libya
Liechtenstein
Lithuania
Luxembourg
Macau
Madagascar
Malawi
Malaysia
Maldives
Mali
Malta
Marshall Islands
Martinique
Mauritania
Mauritius
Mexico
Moldova
Monaco
Mongolia
Montserrat
Morocco
Mozambique
Namibia
Nauru
Nepal
Netherlands
New Zealand
Nicaragua
Niger
Nigeria
North Korea
Norway
Oman
Pakistan
Palau
Panama
Papua New Guinea
Paraguay
Peru
Philippines
Poland
Portugal
Puerto Rico
Qatar
Republic of Macedonia
Republic of the Congo
Romania
Russia
Rwanda
Saint Kitts and Nevis
Saint Lucia
Saint Vincent and the Grenadines
Samoa
San Marino
Sao Tome and Principe
Saudi Arabia
Senegal
Seychelles
Sierra Leone
Singapore
Slovakia
Slovenia
Solomon Islands
Somalia
South Africa
South Korea
Spain
Sri Lanka
Sudan
Suriname
Swaziland
Sweden
Switzerland
Syria
Taiwan
Tajikistan
Tanzania
Thailand
Togo
Tonga
Trinidad and Tobago
Tunisia
Turkey
Turkmenistan
Turks and Caicos Islands
Tuvalu
US Virgin Islands
Uganda
Ukraine
United Arab Emirates
United Kingdom
United States
Uruguay
Uzbekistan
Vanuatu
Venezuela
Vietnam
Yemen
Yugoslavia
Zambia
Zimbabwe
)
j=. <;._2 (0 : 0)
colib.ijs 41129170540 3610 rw- -----a
compare.ijs 40910082404 5147 rw- -----a
conlib.ijs 40213125530 566 rw- -----a
convert.ijs 40910082404 1751 rw- -----a
coutil.ijs 40910082404 2556 rw- -----a
dates.ijs 40910082404 8138 rw- -----a
dd.ijs 40922131158 853 rw- -----a
debug.ijs 50201161840 4169 rw- -----a
defs 50321094503 20 rw- ----d-
dir.ijs 50113153140 10587 rw- -----a
dll.ijs 40829125754 1632 rw- -----a
files.ijs 50113153140 8077 rw- -----a
format.ijs 40910083152 10174 rw- -----a
gl2.ijs 50113153140 3096 rw- -----a
gl3.ijs 40801151316 25676 rw- -----a
jmf.ijs 50224141534 14068 rw- -----a
libpath.ijs 40910083152 2141 rw- -----a
map.ijs 40922141442 7631 rw- -----a
misc.ijs 50113153140 6859 rw- -----a
myutil.ijs 30421141846 935 rw- -----a
numeric.ijs 40910083152 4293 rw- -----a
pack.ijs 40910083152 2910 rw- -----a
parts.ijs 40922141614 2442 rw- -----a
printf.ijs 40910083152 26445 rw- -----a
regex.ijs 50321095130 8442 rw- -----a
socket.ijs 50105093434 14659 rw- -----a
stdlib.ijs 40910083152 10397 rw- -----a
strings.ijs 40910083152 6815 rw- -----a
sysenv.ijs 40830100204 2808 rw- -----a
text.ijs 40922141852 3366 rw- -----a
trig.ijs 30421141846 876 rw- -----a
validate.ijs 40922141928 1665 rw- -----a
version_lib.txt 50317114542 11 rw- -----a
winlib.ijs 40923143612 12545 rw- -----a
)

j=. <;._1 &> ' ' ,each j
nms=. (<'/home/genie/j6/system/') ,each {."1 j
dat=. <. (_6{.5$100) #: 2e13 + 0 ". &> 1 {"1 j
siz=. 0 ". &> 2 {"1 j
prm=. > 3 {"1 j
att=. > 4 {"1 j

MAINDIR=: nms;dat;siz;prm;att
GRIDEDIT=: 0 : 0
pc gridedit;pn "View Definition";
xywh 0 13 308 150;cc gdef editm ws_vscroll rightmove bottommove;
xywh 182 1 42 12;cc redisplay button leftmove rightmove;cn "&Redisplay";
xywh 224 1 42 12;cc help button leftmove rightmove;cn "&Help";
xywh 266 1 42 12;cc close button leftmove rightmove;cn "&Close";
pas 0 0;
rem form end;
)
gridedit_run=: 3 : 0
GNAME=: 'D',y,(0=#y)#'GRID'
if. wdisparent 'gridedit' do.
  wd 'psel gridedit'
else.
  wd GRIDEDIT
  wd 'setfont gdef ',FIXFONT
end.
wd 'set gdef *',gridfix ".GNAME
wd 'setfocus gdef'
wd 'pshow;'
)
gridedit_close_button=: 3 : 0
GDEF=: gdef
GNAME assign gdef
wd 'pclose'
)
gridedit_close=: gridedit_close_button
GRIDEDITHELP=: 0 : 0
To experiment, modify the commands, then Redisplay.
)

gridedit_help_button=: 3 : 0
sminfo 'Grid Demo';GRIDEDITHELP
)
gridedit_redisplay_button=: 3 : 0
GDEF=: gdef
try.
  wd 'psel ', ":PForm
  gridrun gdef
  wd 'psel gridedit'
catch.
  sminfo 'error in grid definition'
  0 return.
end.
1
)
gridedit_sctrlshift_fkey=: 3 : 0
grf=. gridunfix gdef
grf=. (+./\. grf ~: LF) # grf
grf=. grf,LF
f=. jpath '~Source\grid\dev\demo\exam.ijs'
dat=. freads f
sel=. GNAME,'=: 0 : 0',LF
ndx=. (#sel) + 1 i.~ sel E. dat
hdr=. ndx {. dat
dat=. ndx }. dat
ndx=. 1 + 1 i.~ (LF,')',LF) E. dat
mid=. ndx {. dat
ftr=. ndx }. dat
ftr=. ftr, LF -. {:ftr
new=. hdr,grf,ftr
new fwrites f
sminfo 'Grid';'Saved: ',GNAME
)
sumdata=: (,+/) @: (,.+/"1)
j=. <;._2 (0 : 0)
GRID Report
DIR Directory List
COLORS Colors
CUBE Multi-Dimensional
HIER Hierarchical
MLINE Multi-Line
COLSIZE Column Sizes
CONTROLS Controls
COUNTRIES Countries
VCOUNTRIES Virtual Countries
DEVTRIANGLE Development Triangle
FINANCIAL Financial Report
TABLE Function Table
)

ndx=. j i.&> ' '
GRIDEXAMS=: ndx {.each j
GRIDNAMES=: (ndx+1) }.each j

3 : 0 ''
if. IFWINCE do.
  msk=. GRIDEXAMS ~: <'VCOUNTRIES'
  GRIDEXAMS=: msk#GRIDEXAMS
  GRIDNAMES=: msk#GRIDNAMES
end.
)

GRIDALL=: 'D', each GRIDEXAMS
CCOLORS=: 'jzgrid'
NCOLORS=: 0 : 0
Shows examples of cell colors and fonts.

Each color setting defines normal, marked, highlighted, and marked highlighted.

Each cell can have its own font.

In the example, cells divisible by 7 are highlighted.

Cells in the block from 55 to 78 are marked. Typically this is done by selecting with the mouse.

The initially marked cell, 55, is shown in its normal color.
)

DCOLORS=: 0 : 0
CELLDATA=: i. 10 10
CELLHIGH=: 0 = 7|CELLDATA
CELLMARK=: 7 8 5 5
CELLFONTS=: 'Arial 12';'Arial 30 italic';'Arial 50'
CELLFONT=: +/ 9 35 38 38 49 75 94 =/ CELLDATA
HDRCOL=: HDRROW=: 0
)

CCOLSIZE=: 'jzgrid'
NCOLSIZE=: 0 : 0
This example has column widths predefined (not autofit).

Columns can be resized with by dragging the column header grid line with the mouse.

Column sizes are subject to a minimum column width.

If the grid is flipped, the columns then become autofit.
)

DCOLSIZE=: 0 : 0
CELLDATA=: _5 [\ +/\ o. ?. 40 $ 1e2
CELLFMT=: 'c2'
COLAUTOFIT=: 0
COLRESIZE=: 1
COLWIDTH=: 30 40 50 60 70 80
HDRROW=: HDRCOL=: 0
)
CCONTROLS=: 'jzgrid'

NCONTROLS=: 0 : 0
Shows examples of built-in controls.
)
DCONTROLS=: 0 : 0
CELLITEMS=: MONTHS;<ALPHAS
CELLDATA=: <&> 1 + i.8 4
CELLDATA=: ((3 { MONTHS),(5 { MONTHS),1;0) 2 } CELLDATA
CELLDATA=: ((10 { ALPHAS),(22 { ALPHAS),1;1) 3 } CELLDATA
CELLTYPE=: (200 300 100 101,: 201 301 100 101) 2 3 } 8 4$0
HDRCOL=: 'ComboList';'ComboDrop';'Flat Checkbox';'3D Checkbox'
)
CCOUNTRIES=: 'jzgrid'

NCOUNTRIES=: 0 : 0
Size is 100 rows x 208 columns.

Use to test formatting, scrolling and flip speeds.

To test time for complete redraw, zoom in or out.
)
DCOUNTRIES=: 0 : 0
size=. 100,#COUNTRIES
alf=. ,<@,"0/~a.{~(i.26)+/a.i.'A'
CELLDATA=: (10 * 1 + i.size) + size $ 0.01*?~100
CELLFMT=: 'c2'
HDRCOL=: COUNTRIES,:(#COUNTRIES) {. alf
HDRROW=: 1
)
CVCOUNTRIES=: 'jvgrid'

NVCOUNTRIES=: 0 : 0
This uses the jvgrid class to display a noun of size 10000 rows x 208 columns, i.e. just over 2 million cells.

The grid operates in virtual mode. Data is passed to the grid as required by the scrolling.

Cells can be edited. After any edit, see VDATA_jgriddemo_ for the changed cells.
)
DVCOUNTRIES=: 0 : 0
size=. 10000,#COUNTRIES
alf=. ,<@,"0/~a.{~(i.26)+/a.i.'A'
VDATA=: (10 * 1 + i.size) + size $ 0.01*?~100
DATANAME=: 'VDATA'
CELLFMT=: 'c2'
HDRCOL=: COUNTRIES,:(#COUNTRIES) {. alf
HDRROW=: 1
)
CCUBE=: 'jzgrid'
NCUBE=: 0 : 0
Displays multi-dimensional data.

The rows and columns are at bottom left and top right.

At top left are any slices through the data. Drag and drop to rearrange, or click a slice to select a new value.
)

DCUBE=: 0 : 0
a0=. ;: 'Ford GM Honda Toyota Total'
a1=. '2006';'2007'
a2=. ;: 'Hire Lease Sale'
a3=. ;: 'CA KS MN NY TX'
a4=. <;._1 '/Compact/Standard/Full Size/Luxury/MiniVan/SUV/Total'
AXISLABELS=: a0;a1;a2;a3;<a4
AXISNAMES=: ;: 'Model Year Finance State Group'
AXISORDER=: 0;1 2;3 4;0 2
d=. 3 + ?. 17 $~ _1 0 0 0 _1 + # &> AXISLABELS
CELLDATA=: d,"1 0 +/"1 d=. d,"5 4 +/"5 d
)
CDEVTRIANGLE=: 'jdgrid'
NDEVTRIANGLE=: 0 : 0
This uses the jdgrid demo class to display a development triangle.

The data has values for yearly durations based on the start year. The flip button shows the same data with columns of attained years, instead of durations.

For example, consider the first two numbers in column 2 in the initial display.

  151 = value after 2 years, commencing 1990
  271 = value after 2 years, commencing 1991.

Now flip the display.

  151 = value in 1992, commencing 1990
  271 = value in 1993, commencing 1991.

Cells outside the triangle are blanked out.

Arrow buttons move the marked cell to follow the shape of the triangle.
)
DDEVTRIANGLE=: 0 : 0
CELLDATA=: 0 >. +/\"1 +/\ _75 + ?. (15,15) $ 200
CELLFMT=: 'c'
COLWIDTH=: 50
HDRCOL=: 1
HDRCOL2=: 1991
HDRROW=: 1990
)
CDIR=: 'jsgrid'

NDIR=: 0 : 0
Example of jsgrid class.

Selection is by rows.

Click headers to sort. The sorting is on the raw data, for example, try sort by Modified column.

The Name column is scaled to fit available width. Try resizing the form.

Grid cannot be edited.

No row labels.
)
DDIR=: 0 : 0
CELLDRAW=: MAINDIR
ts=. timestamp 1 pick CELLDRAW
CELLDATA=: (< <"1 ts) 1 } CELLDRAW
CELLALIGN=: 0 2 2 1 1
COLSCALE=: 1 0
HDRCOL=: ;: 'Name Modified Size Permission Attributes'
)
CGRID=: 'jzgrid'

NGRID=: 0 : 0
Shows merged row and column headers.

Totals cannot be edited.

Totals are automatically recomputed after a change.

Column widths are autofit. Try entering a large value in a cell.
)
DGRID=: 0 : 0
j=. 'Lyon';'Nice';'Paris';'Berlin';'Bonn';'Dresden'
city=. j,'Hamburg';'Munich';'Milan';'Rome';'Total'
qtr=. ('1st';'2nd';'3rd';'4th') ,each <' Quarter'
mth=. 'JanFebMarAprMayJunJulAugSepOctNovDec'

HDRCOL=: 9 4 # 'Actual';'Forecast'
HDRCOL=: HDRCOL,:(3 # qtr),<'Year'
HDRCOL=: HDRCOL, (_3 <\ mth),<'Total'
HDRCOLALIGN=: 1
HDRCOLMERGE=: 1 1

HDRROW=: (3 5 2 # 'France';'Germany';'Italy'),<''
HDRROW=: HDRROW ,. city
HDRROWALIGN=: 1
HDRROWMERGE=: 1

COLMINWIDTH=: 50

grid_gridhandler=: 3 : 0
if. y -: 'change' do.
  changex__grid''
  CELLDATA__grid=: sumdata 10 12 {. CELLDATA__grid
  0 [ show__grid''
end.
()

CELLDATA=: sumdata ?. 10 12$1500
CELLFMT=: 'c'
CELLEDIT=: ((10 12$1),0),.0
)
DGRIDCE=: 0 : 0
j=. 'Lyon';'Nice';'Paris';'Berlin';'Bonn';'Dresden'
city=. j,'Hamburg';'Munich';'Milan';'Rome';'Total'
qtr=. ('1st';'2nd';'3rd';'4th') ,each <' Quarter'
mth=. 'JanFebMarAprMayJunJulAugSepOctNovDec'

HDRCOL=: (3 # qtr),<'Year'
HDRCOL=: HDRCOL,: (_3 <\ mth),<'Total'
HDRCOLALIGN=: 1
HDRCOLMERGE=: 1 1

HDRROW=: city
HDRROWALIGN=: 1
HDRROWMERGE=: 1
HDRSTYLE=: 2
COLMINWIDTH=: 50

grid_gridhandler=: 3 : 0
if. y -: 'change' do.
  changex__grid''
  CELLDATA__grid=: sumdata 10 12 {. CELLDATA__grid
  0 [ show__grid''
end.
()

CELLDATA=: sumdata ?. 10 12$1000
CELLFMT=: 'c'
CELLEDIT=: ((10 12$1),0),.0
)
3 : 0''
if. IFWINCE do.
  DGRID=: DGRIDCE
end.
)

CFINANCIAL=: 'jzgrid'

NFINANCIAL=: 0 : 0
Uses cell overflow to enable title cells to span several columns.

Negative values shown in red.

No row or column headers. No gridlines.

Uses a minimum column width.
)
DFINANCIAL=: 0 : 0
d=. 5 6 $ <''
d=. (<'Appendix B2') (<0;_1) } d
d=. (<'Expenses and Other Income') (<1;2) } d
d=. (<'International Biscuit Machines and Subsidiaries') (<2;2) } d
d=. (<'($''000)') (<3;2) } d
d=. d,'Year Ended December 31:';'Notes';'2004';'2003';'2002';'2001'
d=. d,'Selling, general and administrative';'';'17,852';'18,738';'17,048';'16,395'
d=. d,'Research, development and engineering';'q';'5,077';'4,750';'2,986';'(2,113)'
d=. d,'Intellectual property and custom income';'r';'(1,168)';'(790)';'123';'175'
d=. d,'Other (income) and expense';'k,m';'145';'150';'234';'239'
d=. d,'Total Expense and Other Income';'';'22,144';'22,760';'20,439';'18,928'
CELLDATA=: d
CELLALIGN=: 2,1,1,1,0,6 6$0 1 2 2 2 2
CELLOVERFLOW=: ,. 1 (i.4) } (#CELLDATA) $ 0
CELLCOLORS=: (0 0 0,:255 0 0) ,"1 [ 255 255 255
CELLCOLOR=: 1 (<7;5) } 1 (<8;2 3) } ($CELLDATA) $ 0
GRIDLINES=: 0
HDRSTYLE=: 2
COLMINWIDTH=: 72
)
CHIER=: 'jzgrid'

NHIER=: 0 : 0
Displays hierarchical data in a grid.

Data is numeric, and subtotalled in groups.

Arrows at left and/or right expand and contract the hierarchy.

Combo boxes in the axis names set the top level to be displayed.

Click on a row or column header to walk down the hierarchy. Click on a walk tile to move to that level.

The demo initially shows only columns in a hierarchy. Select View Definition, set HierRows=:1 and Redisplay to view both axes in hierarchies.
)

DHIER=: 0 : 0

HierRows=: 0

cs=. <;._1
n0=. cs '/Node 1/Node 2'
n1=. cs '/Node 11/Node 12/Node 13/Node 21/Node 22'
n2=. cs '/Node 111/Node 112/Node 121/Node 131/Node 132/Node 133/Node 211/Node 221/Node 222'
m0=. 1 0 0 0 0 0 1 0 0
m1=. 1 0 1 1 0 0 1 1 0
LVLROW=: n0;n1;<n2
LVLROWMASK=: m0,:m1
LVLROWID=: cs '/Distribution/Category/Product'
". (-.HierRows) # 'LVLROW=: LVLROWMASK=: LVLROWID=: $0'

s0=. cs '/Asia/Europe'
s1=. cs '/China/Japan/France/Germany/Italy'
s2=. cs '/Beijing/Shanghai/Fukuoka/Kobe/Nagoya/Tokyo/Lyon/Nice/Bonn/Dresden/Munich/Milan'
r0=. 1 0 0 0 0 0 1 0 0 0 0 0
r1=. 1 0 1 0 0 0 1 0 1 0 0 1
LVLCOL=: s0;s1;<s2
LVLCOLMASK=: r0,:r1
LVLCOLID=: cs '/Region/Country/City'

HDRROW=: n2
ROWTOTAL=: COLTOTAL=: 1
CELLDATA=: 100 + ?. 9e3 $~ (#m0),#r0
CELLFMT=: 'c'
CELLFONTS=: ,<HDRFONT=: IFUNIX pick 'Arial 10';'"Bitstream Vera Sans" 10'
)
CMLINE=: 'jzgrid'

NMLINE=: 0 : 0
Shows multi-line cells. These are LF-delimited character strings.

Cell vertical alignment is defined for the grid as a whole, here set to 1=centred. Try setting CELLALIGNV to 0 or 2.
)
DMLINE=: 0 : 0
CELLALIGNV=: 1
CELLFONTS=: 'Arial 12';'Arial 20'
CELLDATA=: 'c2' 8!:0 o. ?. 4 5 $ 1e4
CELLALIGN=: 0 0 1 1 2 (0 1;2 3;3 3;0 4;3 4) } ($CELLDATA) $ 2
CELLFONT=: 1 (0 1;0 2;3 3;3 4) } CELLALIGN * 0

txt=. }: ; (;:'first second third fourth') ,each <' line',LF
CELLDATA=: (<txt) (<0 1) } CELLDATA

txt=. 'Canada/Cape Verde/Cayman Islands/Central African Republic/Chad'
txt=. LF (I. txt='/') } txt
CELLDATA=: (<txt) (2 3;0 4;3 4) } CELLDATA

HDRCOL=: 'A'
HDRROW=: 0
)
CTABLE=: 'jtgrid'

NTABLE=: 0 : 0
Displays a function table using the jtgrid class.

In this example, the verb is ! (combinations). Use View Definition to try other verbs.
)
DTABLE=: 0 : 0
CELLRANGE=: 100 100
XPRECISION=: 1
VERB=: '!'
)
GNOTES=: 0 : 0
pc gridnotes;pn "Grid Notes";
xywh 0 13 250 100;cc gdef editm ws_vscroll rightmove bottommove;
xywh 208 1 42 12;cc close button leftmove rightmove;cn "&Close";
pas 0 0;
rem form end;
)
gridnotes_run=: 3 : 0
NNAME=: 'N',y,(0=#y)#'GRID'
if. -. '2' e. sysmodifiers do.
  sminfo 'Grid Notes';". NNAME
  return.
end.
if. wdisparent 'gridnotes' do.
  wd 'psel gridnotes'
else.
  wd GNOTES
  wd 'setfont gdef ',PROFONT
  wd 'setcolor gdef ',": 0 0 0,6 $ wdqcolor 15
end.
wd 'set gdef *',".NNAME
wd 'setfocus gdef'
wd 'pshow;'
)
gridnotes_close_button=: 3 : 0
NDEF=: gdef
NNAME assign gdef
wd 'pclose'
)
gridnotes_close=: gridnotes_close_button
gridnotes_sctrlshift_fkey=: 3 : 0
grf=. toJ gdef
grf=. (+./\. grf ~: LF) # grf
grf=. grf,LF
f=. jpath '~Source\grid\dev\demo\exam.ijs'
dat=. freads f
sel=. NNAME,'=: 0 : 0',LF
ndx=. (#sel) + 1 i.~ sel E. dat
hdr=. ndx {. dat
dat=. ndx }. dat
ndx=. 1 + 1 i.~ (LF,')',LF) E. dat
mid=. ndx {. dat
ftr=. ndx }. dat
ftr=. ftr, LF -. {:ftr
new=. hdr,grf,ftr
new fwrites f
sminfo 'Grid';'Saved: ',NNAME
)
GRIDDEMO=: 0 : 0
pc griddemo;
menupop "&Options";
menu view "&View Definition" "" "" "";
menusep;
menu notes "View &Notes" "" "" "";
menusep;
menu zoomout "Zoom &Out" "" "" "";
menu zoomin "&Zoom In" "" "" "";
menusep;
menu exit "E&xit" "" "" "";
menupopz;
menupop "&Gallery";
menu MGRID "Report" "" "" "";
menusep;
menu MDIR "Directory List" "" "" "";
menusep;
menu MCOLORS "Colors and Fonts" "" "" "";
menusep;
menu MCUBE "Multi-Dimensional" "" "" "";
menusep;
menu MHIER "Hierarchical" "" "" "";
menusep;
menu MMLINE "Multi-Line" "" "" "";
menusep;
menu MCOLSIZE "Column Sizes" "" "" "";
menusep;
menu MCONTROLS "Controls" "" "" "";
menusep;
menu MCOUNTRIES "Countries" "" "" "";
menusep;
menu MVCOUNTRIES "Virtual Countries" "" "" "";
menusep;
menu MDEVTRIANGLE "Development Triangle" "" "" "";
menusep;
menu MFINANCIAL "Financial Report" "" "" "";
menusep;
menu MTABLE "Function Table" "" "" "";
menupopz;
menupop "&Help";
menu next "&F12 Next" "" "" "";
menu prev "&Shift F12 Previous" "" "" "";
menusep;
menu about "&About" "" "" "";
menupopz;
tbar "XX" 8 tbstyle_flat;
tbarset flip 0 0 "Flip" "Flip";
tbarset "" 1 11;
tbarset zoomout 2 1 "Zoom Out" "Zoom Out";
tbarset zoomin 3 2 "Zoom In" "Zoom In";
tbarset "" 4 11;
tbarset view 5 3 "Definition" "Definition";
tbarset "" 6 11;
tbarset notes 7 4 "Notes" "Notes";
tbarshow;
xywh 15 15 325 175;cc grid isigraph rightmove bottommove;
pas 15 15;pcenter;
rem form end;
)
GRIDDEMOCE=: 0 : 0
pc griddemo closeok;
menupop "&Options";
menu view "&View Definition" "" "" "";
menusep;
menu notes "View &Notes" "" "" "";
menusep;
menu zoomout "Zoom &Out" "" "" "";
menu zoomin "&Zoom In" "" "" "";
menusep;
menu exit "E&xit" "" "" "";
menupopz;
menupop "&Gallery";
menu MGRID "Report" "" "" "";
menu MDIR "Directory List" "" "" "";
menu MCOLORS "Colors and Fonts" "" "" "";
menu MMLINE "Multi-Line" "" "" "";
menu MCOLSIZE "Column Sizes" "" "" "";
menu MCONTROLS "Controls" "" "" "";
menu MCOUNTRIES "Countries" "" "" "";
menu MDEVTRIANGLE "Development Triangle" "" "" "";
menu MFINANCIAL "Financial Report" "" "" "";
menu MTABLE "Function Table" "" "" "";
menupopz;
menupop "&Help";
menu next "Next" "Ctrl+A" "" "";
menu prev "Previous" "Ctrl+Shift+A" "" "";
menusep;
menu about "&About" "" "" "";
menupopz;
xywh 0 0 100 100;cc grid isigraph rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)
griddemo_run=: 3 : 0
wd :: ] 'psel griddemo;pclose'
if. IFWINCE do.
  wd GRIDDEMOCE
else.
  tbf=. jpath '~addons/demos/wd/gdtbar.bmp'
  ndx=. 1 i.~ 'XX' E. GRIDDEMO
  txt=. (ndx{.GRIDDEMO),tbf,(ndx+2)}. GRIDDEMO
  wd txt
end.
wd 'pshow;'
wdfit ''
PForm=: wdqhwndp''
gridruns GRIDDEMOSEL
wd 'setfocus grid'
evtloop''
)
griddemo_default=: 3 : 0
if. systype -: 'button' do.
  name=. }.syschild
  if. name -: GRIDDEMOSEL do.
    wd 'set M',GRIDDEMOSEL,' 1'
    return.
  end.
  if. (<name) e. GRIDEXAMS do.
    wd 'set M',GRIDDEMOSEL,' 0'
    GRIDDEMOSEL=: name
    wd 'set M',GRIDDEMOSEL,' 1'
    gridruns GRIDDEMOSEL
    ndx=. GRIDEXAMS i. <name
  end.
end.
''
)
griddemo_notes_button=: 3 : 0
gridnotes_run GRIDDEMOSEL
)
griddemo_view_button=: 3 : 0
gridedit_run GRIDDEMOSEL
)
griddemo_exit_button=: 3 : 0
wd 'psel griddemo;pclose;'
try. wd 'psel gridedit;pclose' catch. end.
)
griddemo_contents_button=: 3 : 0
sminfo 'help contents'
)
griddemo_about_button=: 3 : 0
j=. 'Grid Demo VJ602'
sminfo 'Grid';j
)
griddemo_step=: 3 : 0
ndx=. (#GRIDALL) | y + GRIDALL i. <'D',GRIDDEMOSEL
wd 'set M',GRIDDEMOSEL,' 0'
GRIDDEMOSEL=: }.ndx pick GRIDALL
wd 'set M',GRIDDEMOSEL,' 1'
gridruns GRIDDEMOSEL
)
griddemo_pn=: 3 : 0
wd 'pn *Grid - ',y
)
griddemo_close=: destroy
formselect=: 3 : 'wd ''psel '',":formhwnd'
3 : 0 ''
if. IFWINCE do.
  griddemo_actrl_fkey=: griddemo_next_button
  griddemo_actrlshift_fkey=: griddemo_prev_button
else.
  griddemo_f12_fkey=: griddemo_next_button
  griddemo_f12shift_fkey=: griddemo_prev_button
end.
0
)

griddemo_next_button=: 3 : 'griddemo_step 1'
griddemo_prev_button=: 3 : 'griddemo_step _1'
griddemo_flip_button=: 3 : 'flip__grid y'
griddemo_zoomin_button=: 3 : 'zoomin__grid y'
griddemo_zoomout_button=: 3 : 'zoomout__grid y'

griddemo_run_jgriddemo_`start_droidwd_jgriddemo_@.('Android'-:UNAME) 'jgriddemo'
