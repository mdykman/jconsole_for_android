NB. Test
NB.
NB. tmonad    Template conj. to make verbs to test
NB.           computational monad
NB. tdyad     Template conj. to make verbs to test
NB.           computational dyad
NB.
NB. Version: 0.7.0 2011-08-06
NB.
NB. Copyright 2010-2011 Igor Zhuravlov
NB.
NB. This file is part of mt
NB.
NB. mt is free software: you can redistribute it and/or
NB. modify it under the terms of the GNU Lesser General
NB. Public License as published by the Free Software
NB. Foundation, either version 3 of the License, or (at your
NB. option) any later version.
NB.
NB. mt is distributed in the hope that it will be useful, but
NB. WITHOUT ANY WARRANTY; without even the implied warranty
NB. of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
NB. See the GNU Lesser General Public License for more
NB. details.
NB.
NB. You should have received a copy of the GNU Lesser General
NB. Public License along with mt. If not, see
NB. <http://www.gnu.org/licenses/>.

coclass 'mt'

NB. =========================================================
NB. Local definitions

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. tmonad
NB. tdyad
NB. Template conj. to make monad to test computational verb
NB.
NB. Syntax:
NB.   vtestm=. mname tmonad        vgety`vgeto`vrcond`vferr`vberr
NB.   vtestd=. dname tdyad   vgetx`vgety`vgeto`vrcond`vferr`vberr
NB. where
NB.   vgetx  - monad to extract left argument for vd; is
NB.            called as:
NB.              argx=. vgetx y
NB.   vgety  - monad to extract right argument for vm or vd;
NB.            is called as:
NB.              argy=. vgety y
NB.   vgeto  - monad to extract output from ret;
NB.            is called as:
NB.              out=. vgeto ret
NB.   vrcond - dyad to find rcond; is called as:
NB.              rcond=. y vrcond out
NB.   vferr  - dyad to find ferr; is called as:
NB.              ferr=. y vferr out
NB.   vberr  - dyad to find berr; is called as:
NB.              berr=. y vberr out
NB.   mname  - literal, the name of monad vm to test
NB.   dname  - literal, the name of dyad vd to test
NB.   vtestm - monad to test monad vm and to log result:
NB.              mname rcond ferr berr time space
NB.            on the screen, in the global var TESTLOG and,
NB.            optionally, in the log file; is called as:
NB.              vtestm y
NB.   vtestd - monad to test dyad vd and to log result:
NB.              dname rcond ferr berr time space
NB.            on the screen, in the global var TESTLOG and,
NB.            optionally, in the log file; is called as:
NB.              vtestd y
NB.   vm     - monad to test; is called as:
NB.              ret=. vm argy
NB.   vd     - dyad to test; is called as:
NB.              ret=. argx vd argy
NB.   y      - some input for vtestm or vtestd
NB.   argx   - some left argument for vd
NB.   argy   - some right argument for vm or vd
NB.   ret    - some output from vm or vd
NB.   out    - rectified ret, i.e. filtered output
NB.   ferr   ≥ 0 or +∞ or indeterminate, the relative forward
NB.            error
NB.   berr   ≥ 0 or +∞ or indeterminate, the relative
NB.            backward error
NB.   rcond  ≥ 0, the estimated reciprocal of the condition
NB.            number of the input matrix; +∞ if matrix is
NB.            singular; indeterminate if matrix is
NB.            non-square
NB.
NB. Application:
NB. - to test geqrf:
NB.     NB. to estimate rcond in 1-norm
NB.     vrcond=. (_."_)`gecon1@.(=/@$)@[
NB.     NB. to calc. berr, assuming:
NB.     NB.   berr := ||A - realA||_1 / (m * ε * ||A||_1)
NB.     vberr=. ((- %&norm1 [) % FP_EPS * (norm1 * #)@[) unmqr
NB.     NB. do the job
NB.     ('geqrf' tmonad ]`]`vrcond`(_."_)`vberr) A
NB. - to test getrs:
NB.     NB. to estimate rcond in ∞-norm
NB.     vrcond=. (_."_)`geconi@.(=/@$)@(0 {:: [)
NB.     NB. to calc. ferr, assuming:
NB.     NB.   ferr := ||x - realx||_inf / ||realx||_inf
NB.     vferr=. ((- %&normi [) 1&{::)~
NB.     NB. to calc. componentwise berr [LUG 75], assuming:
NB.     NB.   berr := max_i(|b - A * realx|_i / (|A| * |realx| + |b|)_i)
NB.     vberr=. (mp&>/@[ |@- (0 {:: [) mp ]) >./@% (((0 {:: [) mp&| ]) + |@mp&>/@[)
NB.     NB. do the job
NB.     ('getrs' tdyad (0&{::)`(mp&>/)`]`vrcond`vferr`vberr) (A;x)

tmonad=: 2 : 0
  '`vgety vgeto vrcond vferr vberr'=. n
  argy=. vgety y
  try. 't s'=. timespacex 'ret=. ' , m , ' argy'      catch. t=. s=. ret=. _. end.
  try. out=. vgeto ret                                catch. out=. _.         end.
  try. rcond=. y vrcond out                           catch. rcond=. _        end.
  try. ferr=. y vferr out                             catch. ferr=. _.        end.
  try. berr=. y vberr out                             catch. berr=. _.        end.
  NB. fix J6 prinf bug
  if. rcond = _ do.
    rcond=. FP_OVFL
  end.
  logline=. fmtlog m ; rcond ; ferr ; berr ; t ; s
  (logline , LF) ((1!:3)^:(0 < (#@]))) TESTLOGFILE
  TESTLOG=: TESTLOG , logline
  logline (1!:2) 2
  EMPTY
)

tdyad=: 2 : 0
  '`vgetx vgety vgeto vrcond vferr vberr'=. n
  argx=. vgetx y
  argy=. vgety y
  try. 't s'=. timespacex 'ret=. argx ' , m , ' argy' catch. t=. s=. ret=. _. end.
  try. out=. vgeto ret                                catch. out=. _.         end.
  try. rcond=. y vrcond out                           catch. rcond=. _        end.
  try. ferr=. y vferr out                             catch. ferr=. _.        end.
  try. berr=. y vberr out                             catch. berr=. _.        end.
  NB. fix J6 prinf bug
  if. rcond = _ do.
    rcond=. FP_OVFL
  end.
  logline=. fmtlog m ; rcond ; ferr ; berr ; t ; s
  (logline , LF) ((1!:3)^:(0 < (#@]))) TESTLOGFILE
  TESTLOG=: TESTLOG , logline
  logline (1!:2) 2
  EMPTY
)
