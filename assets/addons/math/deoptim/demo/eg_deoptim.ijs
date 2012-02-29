NB. =========================================================
NB. GUI for DE example
NB. http://www.icsi.berkeley.edu/~storn/code.html

require 'gtkwd'

require 'plot strings'
require 'math/deoptim'
coclass 'pegde'
coinsert 'pdeoptim jgl2'

steps=: {. + (1&{ - {.) * (i.@>: % ])@{:

NB. =========================================================
NB. Problem definition - Chebyshev polynomial fitting problem 

NB. Coefficients for Chebychev polynomials
T4=: 1 _8 8
T8=: 1 _32 160 _256 128
T16=: 1 _128 2688 _21504 84480 _180224 212992 _131072 32768
FuncNames=: 'T4 T8 T16'

updateFunc=: 3 : 0
  Tcoeff=: }:,y,.0
  xVect=: ((],-)1.2) ,(%~i:) (9<#Tcoeff){30 50 NB. number of samples
  LowLimit=: Tcoeff p. 1.2
)

NB.*testfunc v Evaluates set of vars and calculates value
testfunc=: 3 : 0
  res=. y p. xVect
  objfn res
)

reportProgress=: 3 : 0
  'BestVars BestVal Generations Digits'=. 4{.y
  result=: pack 'BestVars BestVal Generations nFEval Digits'
  updateOutput''
)

NB.*objfn v Objective function for calcluting value of a set of vars
NB. value is sum of squared errors from 63 or 103 samples
NB. errors when value outside _1 & 1 where x is _1 to 1
NB. errors when value is less than lowlimit Tcoeff at _1.2 & 1.2
objfn=: 3 : 0
  value=. ([: +/ [: *: -. * 1 < |) 2}.y  NB. between _1 & 1
  value + ([:+/[:(*: * 0&>) LowLimit -~ ]) 2{. y NB. _1.2 & 1.2
)

NB.*optimize v Applies DE to parameters given & returns DE result
optimize=: 3 : 0
  vtr=. 1e_12
  genmax=. 2000
  refresh=. 30
  args=. (pack 'vtr genmax refresh') pset y
  cntrl=. 'vtr genmax npop f cr strategy refresh' psel args
  bounds=. |:((#Tcoeff),2)$(- , ]) 'bounds' pget args
  cntrl getDEoptim 'testfunc';bounds
)

NB. =========================================================
NB. Form Definition
EGDE=: 0 : 0
pc egde;pn "Differential Evolution Example";
xywh 2 8 60 60;cc cblFunc combolist;
xywh 62 8 60 60;cc cblStrat combolist;
xywh 2 29 247 50;cc gbParams groupbox;cn "Parameters";
xywh 8 42 33 11;cc lblBounds static;cn "Bounds :";
xywh 73 42 13 11;cc lblF static;cn "F :";
xywh 134 42 17 11;cc lblCR static;cn "CR :";
xywh 195 42 18 11;cc lblNP static;cn "NP :";
xywh 37 42 22 11;cc edBounds edit ws_border es_readonly;
xywh 94 42 19 11;cc edF edit ws_border es_readonly;
xywh 154 42 19 11;cc edCR edit ws_border es_readonly;
xywh 218 42 19 11;cc edNP edit ws_border es_readonly;
xywh 6 54 59 14;cc tbBounds trackbar tbs_top;
xywh 70 54 50 14;cc tbF trackbar tbs_top;
xywh 130 54 50 14;cc tbCR trackbar tbs_top;
xywh 194 54 50 14;cc tbNP trackbar tbs_top;
xywh 146 8 48 12;cc bStart button;cn "Start";
xywh 198 8 48 12;cc bClear button;cn "Clear";
xywh 2 80 247 70;cc gbOutput groupbox;cn "Output";
xywh 6 91 49 11;cc lblIter static ss_right;cn "Generations :";
xywh 6 102 49 11;cc lblnEval static ss_right;cn "Evaluations :";
xywh 6 113 49 11;cc lblVal static ss_right;cn "Cost-Value :";
xywh 62 91 46 11;cc valIter static;cn "0";
xywh 62 102 46 11;cc valnEval static;cn "0";
xywh 62 113 78 11;cc valVal static;cn "0";
xywh 2 152 247 156;cc deplot isigraph rightscale bottomscale;
xywh 6 124 49 11;cc lblMem static ss_right;cn "Best member :";
xywh 62 124 182 25;cc valMem static;cn "0";
pas 6 6;pcenter;
rem form end;
)

NB. ---------------------------------------------------------
create=: 3 : 0
  wd EGDE
  NB. initialize form here
  initControls''
  wd 'pshow;'
  deplot=: conew 'jzplot'
  PForm__deplot=: 'myplot'
  PFormhwnd__deplot=: wd 'qhwndp'
  PId__deplot=: 'deplot'
)

destroy=: 3 : 0
  wd'pclose'
  destroy__deplot''
  codestroy''
)

NB. ---------------------------------------------------------
egde_close=: destroy

egde_bStart_button=: 3 : 0
  'bounds npop f cr strategy'=. 0". > edBounds;edNP;edF;edCR;cblStrat_select
  func=. cblFunc
  strategy=. >:strategy
  result=: optimize pack 'bounds npop f cr strategy func'
  updateOutput''
)

egde_bClear_button=: 3 : 0
  erase 'result'
  updateOutput''
)

egde_cblFunc_select=: 3 : 0
  updateFunc cblFunc~
  egde_bClear_button''
)

egde_tbBounds_button=: 3 : 0
  wd 'set edBounds *',tbBounds
)

egde_tbF_button=: 3 : 0
  wd 'set edF ',": 100 %~ <: 0".tbF
)

egde_tbCR_button=: 3 : 0
  wd 'set edCR ',": 100 %~ <: 0".tbCR
)

egde_tbNP_button=: 3 : 0
  wd 'set edNP ',": 4 + 0".tbNP
)

egde_deplot_paint=: 3 : 0
  pd__deplot 'reset'
  pd__deplot 'xrange _1.5 1.5;yrange _1 10;grids 0 0;'
  pd__deplot 'color red;'
  pd__deplot _2 _1.2 _1.2 1.2 1.2 2; 2|.(4#LowLimit), _1 _1
  pd__deplot _1 _1 1 1 ; 1000 1 1 1000
  if. 0 = 4!:0 <'result' do.
    pd__deplot 'color blue;'
    NB. plot__deplot _1.01 1.01;(": 'BestVars' pget result),' p. y'
    vls=. steps _1.4 1.4 100
    pd__deplot vls;('BestVars' pget result) p. vls
  end.
  pd__deplot 'show'
)

NB. ---------------------------------------------------------
updateOutput=: 3 : 0
  if. 0~: 4!:0 <'result' do.
    result=. (0;0;0;0);<''
  end.
  wd 'set valIter  *', ": 'Generations' pget result
  wd 'set valnEval *', ":      'nFEval' pget result
  wd 'set valVal   *', ":     'BestVal' pget result
  wd 'set valMem   *', ' 'joinstring '0.3' 8!:0 'BestVars' pget result
  wd 'msgs'
  egde_deplot_paint''
)

initControls=: 3 : 0
  wd 'set cblFunc ',FuncNames
  wd 'setselect cblFunc ',": (;:FuncNames) i. <'T8'
  wd 'set cblStrat DEBest1 DERand1 DERandToBest1 DEBest2'
  wd 'setselect cblStrat 2;'
  wd 'set tbBounds 1 101 491 5 3'
  wd 'set tbF      1  81 201 5 3'
  wd 'set tbCR     1  91 101 5 3'
  wd 'set tbNP     1   1   6 1 3'
  wd 'set edBounds 100'
  wd 'set edF 0.8'
  wd 'set edCR 0.9'
  wd 'set edNP 5'
  updateFunc T8
  ''
)

''conew 'pegde'
