NB. table
NB.
NB. !!! this is experimental and *will* change...
NB.
NB. cover for the QTableWidget
NB. initially, just provides a grid for pacman
NB. data types so far:
NB.  0 text
NB.  1 checkbox

NB. =========================================================
Dat=: 0 : 0
0 api/expat 1.0.0 1.0.0 libexpat
0 api/glx 1.0.2 1.0.2 "OpenGL GLX API"
1 "base library" 7.1.78 7.1.80 "base library scripts"
0 "data/jdb" 1.0.24 1.0.25 JDB
0 "debug/dissect" "" 1.03 "Run a sentence and produce a grid display of results"
0 "debug/lint" 1.10.0 1.10.0 "Load a script and check its syntax"
)

NB. =========================================================
table=: 3 : 0
wd 'pc table'
wd 'cc pac table'
wd 'setp pac coltypes 1 0 0 0 0'
wd 'setp pac colnames "" Package Installed Latest Caption'
wd 'set pac *',Dat
wd 'pmovex 100 10 600 250'
wd 'pshow'
)

NB. =========================================================
table_close=: 3 : 0
wd 'pclose'
)

NB. =========================================================
showevents_jqtide_ 2
table''
