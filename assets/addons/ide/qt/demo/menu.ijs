NB. menu demo

test=: 3 : 0
wd 'pc test'
wd 'menupop "&File"'
wd 'menu new "&New File"'
wd 'menu open "&Open File"'
wd 'menusep'
wd 'menu quit "Quit" "Ctrl+Q"'
wd 'menupopz'
wd 'menupop "&Edit"'
wd 'menu inputlog "Input &Log"'
wd 'menusep'
wd 'menupop "&Configure"'
wd 'menu base "&Base"'
wd 'menu launchpad "Launch &Pad"'
wd 'menupopz'
wd 'menusep'
wd 'menu sidebar "&Sidebar" "Ctrl+B"'
wd 'menu font "Session &Font"'
wd 'menupopz'
wd 'menupop "&Help"'
wd 'menu about "&About"'
wd 'menupopz'
wd 'set sidebar 1'
wd 'setenable font 0'
wd 'cc list listbox'
wd 'set list one two three'
wd 'pmovex 700 10 300 200'
wd 'pshow'
)

NB. =========================================================
test_close=: 3 : 0
wd 'pclose'
)

showevents_jqtide_ 2
test''