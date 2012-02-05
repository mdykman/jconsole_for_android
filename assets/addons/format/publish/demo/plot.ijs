NB. plot
NB.
NB. functions in this script build plot files that
NB. can be referenced in <image></image> tags. The file
NB. extension is *.jpf. Use normal pd commands to build
NB. the plot, and then pd 'jpf {filename} {size}' to write
NB. the plot file. Size is the width,height in points.
NB. For example:
NB.
NB.   pd 'reset'
NB.   pd 'type bar'
NB.   pd 2 3 5 7
NB.   pd 'jpf c:\demo\plot71.jpf 300 150'
NB.
NB. Note: in the Publish demo, this script is not loaded when
NB. the report is built. It is assumed that the script
NB. has already been run.

DEMOPATH=: jpath '~addons/format/publish/demo/'

NB. =========================================================
SBARSTYLE=: 0 : 0
reset
type sbarv
barwidth 0.5
captionfont arial 11
framebackcolor silver
gridcolor black
gridpattern 1
grids 1
keypos rmo
keystyle bf
ticmajor 4
ticminor 3
)

NB. =========================================================
plot21=: 3 : 0
CBLUE_z_=: 153 153 255
CPURPLE_z_=: 153 51 102
CYELLOW_z_=: 235 235 153
pd SBARSTYLE
pd 'color cyellow,red,cpurple,green,cblue'
pd 'ycaption 1,000s'
pd 'key "London" "New York" "Paris" "Sydney" "Tokyo"'
pd 'title Sales<br/>(First Quarter 2007)'
pd 'yrange 0 5'
pd 'yticpos ',": 0.5 * i.11
pd 'xlabel Nuts Bolts Screws'
dat=. 0.038 * |: _5 [\ 30 10 5 5 50 15 5 2 3 25 7 7 2 10 2
pd dat
f=. DEMOPATH,'plot21.jpf'
pd 'jpf ',f,' 400 200'
)

PLOT22=: ". ;._2 (0 : 0)
16 13.42 13.32 13.21  11.1     8  4.99  3.88  8.77  6.67  3.56  5.45  3.21 0.11 5
16 15.64 12.29  8.93  9.57 10.21 12.86  12.5  9.14 10.79  8.43  8.07  4.71 3.36 6
18 20.57 24.13  20.7 17.27 14.77 14.33  11.9  8.47 12.03  8.87   6.3  8.87 7.43 4
19 17.29 13.57 11.86 16.14 15.43 14.71    18 18.29 17.57 13.86 12.14  9.43 5.71 8
17 18.09 19.18 22.27 21.36 18.45 16.27 13.36 11.46  8.55  7.64  9.73 11.82 8.91 9
)

NB. =========================================================
plot22=: 3 : 0
pd 'reset'
pd 'type line'
pd 'ycaption kp/l00 km'
pd 'keypos bco;keystyle bhf'
pd 'key "London" "New York" "Paris" "Sydney" "Tokyo"'
pd 'yrange 0 25'
lab=. _4 }. ;(": each 1970 + 5 * i.8),.<' "" '
pd 'xlabel ',lab
pd PLOT22
f=. DEMOPATH,'plot22.jpf'
pd 'jpf ',f,' 400 200'
)

NB. =========================================================
plot23=: 3 : 0
pd 'reset'
pd 'type pie'
pd 'piepercent 1'
pd 'captionfont arial 12 bold'
pd 'ycaption Nuts Screws Bolts Washers'
pd 'key Small Medium Large'
pd 'keypos rmo;keystyle bf'
pd 1 + ?. 4 3 $ 10
f=. DEMOPATH,'plot23.jpf'
pd 'jpf ',f,' 450 100'
)

plot21''
plot22''
plot23''

