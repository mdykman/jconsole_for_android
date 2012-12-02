NB. allout
NB.
NB. Contributed by eesuk (eesuk@kt.co.kr)
NB.
NB. Allout is a 5x5 board Game. It attracted me. I noticed that some configurations
NB. have no solution.
NB.
NB. THe 5x5 case has no unique solution. The 6x6 case always has a unique solution.
NB. IMHO, Its dynamic behavior lies between 1D cellualar automata and 2D Game of Life.
NB.
NB. So, I deeply studied it,and finally found an algorithm for the general MxN case.
NB.
NB. The algorithm is related to (MN)x(MN) matrix inversion in GF(2)-Vector Space.
NB.
NB. i.e (+) --> XOR, (*)--> AND, binary vector space. It requires about O( (MN)^3 )
NB. computation but due to special matrix structure, it reduced to a KxK matrix
NB. inversion (where, K=min{M,N)).

NB. not updated for J6 /cdb

require 'gtkwd gui/gtkwd/jview gl2'

cocurrent 'jallout'
coinsert 'jgl2'

NB. =========================================================
COMMANDS=: 0 : 0
Esc: Exit,Close

Mouse:
- Leftclick:
      Game-mode, on-off the cell and its 4 neighbors (Toggle)

- Rightclick:
      Edit-mode, on-off the cell (Toggle)

Key:
 - S : Solve and Mark it
 - D : New Game (generate feasible random board configuration)
 - R : Reverse Board configuration
 - F : Reset Board null
 - N : New Size Game
)


NB. =========================================================
NB. randomize
9!:1 >.1000*60#._2{.6!:0 ''

NB. =========================================================
NB. GF(2) matrix product
NB. (+)-->XOR   (*)-->AND
wx=: ~:/ . *

NB. =========================================================
NB. matrix inversion for GF(2)-vector space
inv=: 3 : 0
E0=. <@] C. [
E1=. ([: ~:/ {~)`({:@])`[}
A=. y,.=in=. i.n=. #y[jq=. 0[kj=: ''
for_k. }:in do.
  c=. k{"1 A
  j=. c #&(jq&}.) in
  if. #j do. 'j0 j1'=. ({.;}.)j
    if. j0 ~: jq do.A=. A E0 jq,j0 end.
    for_q. j1 do.A=. A E1 jq,q end.
    jq=. jq+1[kj=: kj,k,jq
  end.
end.
if. A{~<jq,kn=. {:in do.kj=: kj,kn,jq end.
kj=: _2 [\kj
for_k. }.i.#kj do.
  'ku ju'=. kj{~-k
  c=. ku{"1 A
  j1=. c #&(ju&{.) in
  for_q. j1 do. A=. A E1 ju,q end.
end. G=. n}."1 A
jN=. in-.jB=. {."1 kj
jN;G
)

NB. =========================================================
Finv=: 3 : 0
'm n'=. y
A=. (*|:)in</2+in=. i.n
bf=. <F1=. A[F2=. =in
for_k. >:i.m-1 do.
  F=. F2~:A wx F1
  bf=. bf,<F
  F1=. F[F2=. F1
end.(inv >{:bf),}:bf
)

NB. =========================================================
MxN=: DEF_MxN=: 5 5 NB. Problem size
cell=: DEF_cell=: 15 NB. Cell size

NB. =========================================================
main_run=: 3 : 0
wdpclose 'sub'
wdpclose 'main'
NewSize''
wd 'pc main nomax nosize;pn "Allout"'
wd 'menupop "&Help";'
wd 'menu helpcmd "&Commands" "" "" "";'
wd 'menusep ;'
wd 'menu helpsrc "&Source" "" "" "";'
wd 'menupopz;'
wd 'xywh 5 5 ',":cell*N,M
wd 'cc gg isigraph;'
wd 'pas 5 5;pcenter;'
wd^:(-.IFJ6) 'pshow;pshow sw_hide'
ResetD''
Don NewD''
wd 'pshow;'
evtloop^:(-.IFJ6)''
)

NB. =========================================================
NewSize=: 3 :0
'M N'=: MxN[NM=: |.MxN
XY=: 1000*>,|:{(N%~i.N);M%~i.-M
vbf=. Finv MxN
'null V'=: 2{.vbf[BF=: 2}.vbf
'' NB. Nullity -: 2^#null
)

NB. =========================================================
ResetD=: 3 : 0
D=: MxN$0[stgl=: 0
glclear''
glbrush glrgb 3#255
glrect 0 0 1000 1000
glpen 0 0[glrgb 3#0
vm=: (1000%M)*0,.l,.M,.l=. i.>:M
gllines vm
vn=: (1000%N)*l,.0,.l,.N[l=. i.>:N
gllines vn
glpaint ''
)

NB. =========================================================
Mark=: 4 : 0
glbrush glrgb x{(3#255),:(3#0)
glpen 1 0
glrect (y+300%NM),(400%NM)
)

NB. =========================================================
MarkS=: 4 : 0
glbrush glrgb x{(3#255),:(0 200 200)
glpen 1 0
glrect (y+200%NM),(600%NM)
)

NB. =========================================================
Son=: 3 : 0
if. +/,D do.S=. Solve D
  INF=: 0
  if. *#null do.SolInfo D end.
  if. -.INF do.
    1 MarkS"0 1 XY#~,S
    1 Mark"0 1 XY#~,D
    glpaint '' end.
end.
)

NB. =========================================================
Solve=: 3 : 0
if. 1-:{.$y do. top=: V wx ,y
else.X=. y ~:~:/BF(wx~|.)S:0}.;/[\.|.y
  'bottom x'=. ({:;}:)X
  top=: V wx bottom
  top,x~:top wx S:0 BF end.
)

NB. =========================================================
SolInfo=: 3 : 0
if. INF=: *+/bl=. null{top do.
  top=: 0 null}top
  MDF=: (bl{.~-N)~:{:y
  msg=. '** Infeasible **',LF
  msg=. msg,'If Bottom line is modified '
  msg=. msg,'then feasible. '
  msg=. msg,'In fact, there are 2^',(":#null)
  msg=. msg,' solutions.'
  wd 'pc solinfo nomax nosize owner closeok'
  wd 'pn ""'
  wd 'xywh 5 5 100 40;cc msgbd static ss_center'
  wd 'setfont msgbd "Courier New" 12'
  wd 'set msgbd *',msg
  wd 'xywh 5 50 100 28'
  wd 'cc modf groupbox;cn "Modify it?"'
  wd 'setfont modf "Courier New" 12'
  wd 'xywh 20 62 35 10'
  wd 'cc r0 button;cn "OK"'
  wd 'setfont r0 "Courier New" 12'
  wd 'xywh 60 62 35 10'
  wd 'cc r1 button group ;cn "Cancel"'
  wd 'setfont r1 "Courier New" 12'
  wd 'pas 5 5;pcenter;pshow'
end.
)

NB. =========================================================
solinfo_r1_button=: wdpclose bind 'solinfo'

NB. =========================================================
solinfo_r0_button=: 3 : 0
wdpclose 'solinfo'
wd 'psel main'
Don D=: (}:D),MDF
glpaint ''
)

NB. =========================================================
Soff=: 3 : 0
if. +/,D do.0 MarkS"0 1 XY
  1 Mark"0 1 XY#~,D
  glpaint '' end.
)

NB. =========================================================
NewD=: 3 : 0
D=: ?MxN$2[stgl=: 0
if. #null do. Solve D
  if. INF=: +/bl=. null{top do.
    D=: (}:D),(bl{.~-N) ~: ({:D)end.end.
)

NB. =========================================================
RevD=: 3 : 'D=:-.D'

NB. =========================================================
Don=: 3 : 0
0 MarkS"0 1 XY
if. +/,D do.1 Mark"0 1 XY#~,D end.
glpaint ''
)

NB. =========================================================
main_gg_mbldown=: 3 : 0
dxy=. 4{.". sysdata
ij=. (((M-1)&-)@{:,{.)xy=. <.NM*2({.%}.)dxy
four=. (ij~:<:MxN),ij~:0
ij4=. (,-)1 0,: 0 1[xy4=. (,-)0 _1,:1 0
Nij=. ij([,+"1)four#ij4
Nxy=. xy([,+"1)four#xy4
DNij=. -.(;/Nij){D
DNij Mark"0 1 (1000%NM)*"1 Nxy
D=: DNij (;/Nij)}D
glbrush glrgb 3#255
glpen 1 0
NB. !!! glflood ((xy*1000%NM)+250%NM),3#0
glpaint ''
)

NB. =========================================================
main_gg_mbrdown=: 3 : 0
dxy=. 4{.". sysdata
ij=. (((M-1)&-)@{:,{.)xy=. <.NM*2({.%}.)dxy
Dij=. -.(<ij){D
Dij Mark (1000%NM)*xy
D=: Dij (<ij)}D
glpaint ''
)

NB. =========================================================
main_gg_char=: 3 : 0
aid=. a.i.d=. sysdata
if. d e.'nN' do. PopSize''
elseif. d e.'sS' do. stgl=: -.stgl
  if. stgl do. Son D else. Soff'' end.
elseif. d e. ,'dD' do. Don@NewD''
elseif. d e.'fF' do. ResetD''
elseif. d e. 'rR' do. Don@RevD''
end.
)

NB. =========================================================
PopSize=: 3 : 0
wd 'pc sub nomax nosize owner closeok;pn "Size"'
wd 'pn "Option"'
wd 'xywh 5 10 25 10;'
wd 'cc subg1 static;cn "MxN ="'
wd 'setfont subg1 "Courier New" 12'
wd 'xywh 32 9 14 10;cc sgm edit es_center;cn ""'
wd 'setfont sgm "Courier New" 12'
wd 'xywh 48 9 5 10;cc sgx static'
wd 'setfont sgx "Courier New" 12'
wd 'cn "x";xywh 55 9 14 10;'
wd 'cc sgn edit es_center;cn ""'
wd 'setfont sgn "Courier New" 12'
wd 'xywh 5 35 55 10'
wd 'cc subg2 static ;cn "Cell Unit = "'
wd 'setfont subg2 "Courier New" 12'
wd 'xywh 55 34 14 10 ;cc sgc edit;cn ""'
wd 'setfont sgc "Courier New" 12'
wd 'set sgm *',":M
wd 'set sgn *',":N
wd 'set sgc *',":cell
wd 'xywh 27 55 20 10'
wd 'cc ok button bs_defpushbutton;cn "Set!" '
wd 'setfont ok "Courier New" 12'
wd 'pas 5 5'
wd 'pcenter;'
wd 'pshow;'
)

NB. =========================================================
main_helpcmd_button=: 3 : 0
wdview COMMANDS
)

NB. =========================================================
main_helpsrc_button=: 3 : 0
wdview 1!:1 <jpath '~addons/demos/wd/allout.ijs'
)

NB. =========================================================
sub_sgc_button=: sub_ok_button=: 3 : 0
if.''-:'0123456789'-.~sgm,sgn,sgc do.
  MxN=: (".sgm),".sgn[cell=: ".sgc end.
main_run''
)

NB. =========================================================
sub_sgm_button=: sub_sgn_button=: sub_ok_button

NB. =========================================================
wdpclose=: [:wd :: empty 'psel '&,@(,&';pclose')
main_close=: main_cancel=: wdpclose bind 'main'

main_run''
