NB. fns

NB. =========================================================
cfg_read=: 3 : 0
Nboard=: (0 ". getentry erows),0 ". getentry ecols
Nscale=: 0 ". readcombo escale
Nmaxbuf=. 0 ". getentry emaxbuf
Nminrun=: 1 >. 0 ". getentry eminrun
Nmaxiter=: {. (0 ". getentry emaxiter),_
Ntimer=: 1 >. 0 ". getentry etimer
1
)

NB. =========================================================
cfg_reshow=: 3 : 0
if. NoEvents do. return. end.
cfg_read''
cfg_show''
)

NB. =========================================================
cfg_show=: 3 : 0
NoEvents=: 1
setentry erows;":{.Nboard
setentry ecols;":{:Nboard
setcombo_select escale,Nscale-1
setlabel spixels;fmtsize Nboard * Nscale
setentry emaxiter;(Nmaxiter ~: _) # ":Nmaxiter
setentry emaxbuf;":Nmaxbuf
setentry eminrun;":Nminrun
setentry etimer;":Ntimer
NoEvents=: 0
)

