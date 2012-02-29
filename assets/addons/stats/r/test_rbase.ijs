NB. =========================================================
NB. Test script for rbase utilities

Note 'To run tests:'
  NB. Ensure Rserve sockets server is started
  load 'stats/r/rserve'
  load '~addons/stats/r/test_rbase.ijs'
)

NB. Test data
erase 'AKEYS NKEYS VARNM'   NB. Nouns for checking
erase 'IRIS LMSWISS SWISS'  NB. R objects
Rreset''
IRIS=: Rget 'iris'
Rcmd 'data(swiss)'
SWISS=: Rget 'swiss'
LMSWISS=: Rget 'lm(Infant.Mortality ~ Catholic, data=swiss)'

AKEYS=: ,<'`class'
p=. 'assign';'call';'coefficients';'df.residual';'effects';'fitted.values'
NKEYS=: p, 'model';'qr';'rank';'residuals';'terms';'xlevels'
VARNM=:'Infant.Mortality';'Catholic'

test=: 3 : 0
  assert (AKEYS,NKEYS) -: ~.;{.@parsekey_rbase_ &.> Rmap LMSWISS
  assert (AKEYS,NKEYS) -: Rkeys bytoplevel_rbase_ LMSWISS
  assert AKEYS -: getattrkeys_rbase_ Rmap LMSWISS
  assert AKEYS -: Rmap byattr_rbase_ LMSWISS
  assert AKEYS -: Rattrkeys LMSWISS
  assert NKEYS -: Rnames LMSWISS
  assert (Rnamekeys bytoplevel_rbase_ -: Rnames) LMSWISS
  assert 2 2 = $'coefficients' Rmap LMSWISS
  assert 0.00001 > 0.01225676 - 'coefficients$Catholic' Rmap LMSWISS
  assert 47 2 = $'residuals' Rmap LMSWISS
  assert 8 = 3!:0 >{:"1 'residuals' Rmap LMSWISS
  assert 0.00001 > _1.957214 - 'residuals$V. De Geneve' Rmap LMSWISS
  assert 47 2 = $'fitted.values' Rmap LMSWISS
  assert *./ VARNM e. Rmap getnamekeys_rbase_ 'model' Rmap LMSWISS
  assert 13 = #Rmap getattrkeys_rbase_ 'model$`terms' Rmap LMSWISS
  assert 13 = #Rattrkeys 'model$`terms' Rmap LMSWISS
  assert 'Catholic'-:'terms$`term.labels' Rmap LMSWISS
  assert VARNM -: }. res=.'model$`terms$`variables' Rmap LMSWISS
  assert res -: '`variables' Rmap 'model$`terms' Rmap LMSWISS
  assert 'numeric' -: 'model$`terms$`dataClasses$Catholic' Rmap LMSWISS
  assert 47 2 -: #&> 'qr$qr$`dimnames' Rmap LMSWISS
  assert (Rnames -: Rnamekeys bytoplevel_rbase_) IRIS
  NB. Get more than one key
  datkeys=. 'model$'&,&.> Rnames 'model' Rmap LMSWISS
  data=. datkeys Rmap"0 _ LMSWISS
  assert 2 47 -: $data
  assert 8 = 3!:0 data
  data=. (;:'assign BADNAME rank xlevels coefficients') <@Rmap"0 _ LMSWISS
  assert 2 0 1 1 2 -: #&> data
  assert 1 1 0 2 2 -: #@$&> data
  'test_rbase.ijs rmap interface tests passed'
)

test2=: 3 : 0
  assert 'data.frame' -: Rclass IRIS
  assert 'factor' -: Rclass 'Species' Rmap IRIS
  assert 'data.frame' -: Rclass 'model' Rmap LMSWISS
  assert 'qr' -: Rclass 'qr' Rmap LMSWISS
  assert 'matrix' -: Rclass 'qr$qr' Rmap LMSWISS
  assert 'matrix' -: Rclass 'qr$qr$`data' Rmap LMSWISS
  assert 'list' -: Rclass 'qr$qr$`dimnames' Rmap LMSWISS
  assert 'integer' -: Rclass 'rank' Rmap LMSWISS
  assert 'floating' -: Rclass 'qr$qraux' Rmap LMSWISS
  'test_rbase.ijs showdata tests passed'
)

Note 'tests for Rshow and Rdata'
 Rshow SWISS
 Rshow IRIS
 Rshow 'model' Rmap LMSWISS
 Rshow 'Species' Rmap IRIS
 Rshow 'qr$qr' Rmap LMSWISS
 Rshow 'qr$qr$`data' Rmap LMSWISS
 Rshow 'qr$qr$`dimnames' Rmap LMSWISS
 Rdata SWISS
 Rdata IRIS
 Rdata 'model' Rmap LMSWISS
 Rdata 'Species' Rmap IRIS
)

smoutput test''
smoutput test2''
