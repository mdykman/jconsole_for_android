NB. Quaternions
NB.
NB. qnxx       Get/set component[s]
NB. qnmarkxxx  Mark component[s]
NB. qnconxx    Conjugate component[s]
NB. qnmul      Multiply
NB. qnrec      Reciprocal
NB. qndivl     Divide (left quotient)
NB. qndivr     Divide (right quotient)
NB. qnmod      Magnitude
NB. qnsign     Signum
NB. qnf        Adv. to make quaternion verb
NB.
NB. Version: 0.8.0 2011-10-29
NB.
NB. Copyright 2011 Igor Zhuravlov
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
NB. Concepts
NB.
NB. Let:
NB.   a,b,c,d ∊ ℝ        Basis elements multiplication table:
NB.   ℂi ≡ ℝ  + ℝ *i          i   j   k
NB.   ℂj ≡ ℝ  + ℝ *j      i  _1   k  -j
NB.   ℂk ≡ ℝ  + ℝ *k      j  -k  _1   i
NB.   ℍ  ≡ ℂi + ℂi*j      k   j  -i  _1
NB.
NB. J:                    Math:
NB.  x -: a j. b            x = a + b*i ∊ ℂi
NB.  y -: c j. d            y = c + d*i ∊ ℂi
NB.  z -: a j. c            z = a + c*j ∊ ℂj
NB.  w -: a j. d            w = a + d*k ∊ ℂk
NB.  q -: x , y             q = x + y*j = a + b*i + c*j + d*k ∊ ℍ
NB.
NB. Notes:
NB. - elements from ℂi, ℂj, ℂk must not be mixed with each
NB.   other by math operators in J

NB. =========================================================
NB. Local definitions

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. Get/set component[s]
NB.
NB. Verb:        Syntax (monad):        Syntax (dyad):
NB. qn1          a=. qn1  q             qa=. a qn1  q
NB. qni          b=. qni  q             qb=. b qni  q
NB. qnj          c=. qnj  q             qc=. c qnj  q
NB. qnk          d=. qnk  q             qd=. d qnk  q
NB. qn1i         x=. qn1i q             qx=. x qn1i q
NB. qnjk         y=. qnjk q             qy=. y qnjk q
NB. qn1j         z=. qn1j q             qz=. z qn1j q
NB. qn1k         w=. qn1k q             qw=. w qn1k q

qn1=:  9&o.@{. : ((j. qni) 0} ])
qni=: 11&o.@{. : ((j.~qn1) 0} ])
qnj=:  9&o.@{: : ((j. qnk) 1} ])
qnk=: 11&o.@{: : ((j. qnj) 1} ])

qn1i=: {.            : (0})
qnjk=: {:            : (1})
qn1j=: j./@(9   &o.) : ((j.~+.)~ 11&o.)
qn1k=: j./@(9 11&o.) : ((2 2 $ 0 0;2 0;1 1;0 1)j./@:{(,&:+.))

NB. ---------------------------------------------------------
NB. Markers
NB.
NB. Verb:        Action:                  Syntax:
NB. qnmark1      a + 0*i + 0*j + 0*k      qa=.   qnmark1   q
NB. qnmarki      0 + b*i + 0*j + 0*k      qb=.   qnmarki   q
NB. qnmarkj      0 + 0*i + c*j + 0*k      qc=.   qnmarkj   q
NB. qnmarkk      0 + 0*i + 0*j + d*k      qd=.   qnmarkk   q
NB. qnmark1i     a + b*i + 0*j + 0*k      qab=.  qnmark1i  q
NB. qnmark1j     a + 0*i + c*j + 0*k      qac=.  qnmark1j  q
NB. qnmark1k     a + 0*i + 0*j + d*k      qad=.  qnmark1k  q
NB. qnmarkij     0 + b*i + c*j + 0*k      qbc=.  qnmarkij  q
NB. qnmarkik     0 + b*i + 0*j + d*k      qbd=.  qnmarkik  q
NB. qnmarkjk     0 + 0*i + c*j + d*k      qcd=.  qnmarkjk  q
NB. qnmark1ij    a + b*i + c*j + 0*k      q1ij=. qnmark1ij q
NB. qnmark1ik    a + b*i + 0*j + d*k      q1ik=. qnmark1ik q
NB. qnmark1jk    a + 0*i + c*j + d*k      q1jk=. qnmark1jk q
NB. qnmarkijk    0 + b*i + c*j + d*k      qijk=. qnmarkijk q

qnmark1=: ( 9    o. {.),0:
qnmarki=: (11 j.@o. {.),0:
qnmarkj=: 0, 9    o. {:
qnmarkk=: 0,11 j.@o. {:

qnmark1i=: 0&(1})
qnmarkjk=: 0&(0})
qnmark1j=:       9&o.
qnmarkik=: j.@:(11&o.)
qnmark1k=: ( 9    o. {.) , 11 j.@o. {:
qnmarkij=: (11 j.@o. {.) ,  9    o. {:

qnmark1ij=: 1}~ ( 9    o. {:)
qnmark1ik=: 1}~ (11 j.@o. {:)
qnmark1jk=: 0}~ ( 9    o. {.)
qnmarkijk=: 0}~ (11 j.@o. {.)

NB. ---------------------------------------------------------
NB. Conjugators
NB.
NB. Verb:        Action:                  Syntax:
NB. qncon1       -a + b*i + c*j + d*k     qc=. qncon1  q
NB. qnconi        a - b*i + c*j + d*k     qc=. qnconi  q
NB. qnconj        a + b*i - c*j + d*k     qc=. qnconj  q
NB. qnconk        a + b*i + c*j - d*k     qc=. qnconk  q
NB. qnconij       a - b*i - c*j + d*k     qc=. qnconij q
NB. qnconjk       a + b*i - c*j - d*k     qc=. qnconjk q
NB. qnconik       a - b*i + c*j - d*k     qc=. qnconik q
NB. qnconv        a - b*i - c*j - d*k     qc=. qnconv  q
NB.
NB. References:
NB. [1] Karataev E.A. Inner conjugation of quaternions.
NB.     Volzhskiy, 2002 (Каратаев Е.А. Внутреннее сопряжение
NB.     кватернионов. Волжский, 2002)
NB.     http://karataev.nm.ru/

NB. inner single conjugation
qncon1=: -@+@{. ,     {:  NB. by 1
qnconi=:   +@{. ,     {:  NB. by i
qnconj=:     {. , -@+@{:  NB. by j
qnconk=:     {. ,   +@{:  NB. by k

NB. inner double conjugation
qnconik=: +                NB. by i,k
qnconjk=: {. , -@{:        NB. by j,k
qnconij=: qnconik@qnconjk  NB. by i,j

NB. vector conjugation
qnconv=:  +@{. , -@{:

NB. ---------------------------------------------------------
NB. Operators

NB. Product
qnmul=: mp (,: (-@{: ,. {.)@:+)

NB. Reciprocal
qnrec=: qnconv % +/@:*:@,@:+.

NB. Divide
qndivl=: qnmul qnrec  NB. via left quotient
qndivr=: qnmul~qnrec  NB. via right quotient

NB. Magnitude
qnmod=: norms

NB. Signum
qnsign=: % qnmod

NB. ---------------------------------------------------------
NB. qnf
NB.
NB. Description:
NB.   Adv. to quaternificate verb
NB.
NB. Formula [1]:
NB.   f(q) = Re(f(λ)) + sgn(q-a) * Im(f(λ))
NB. where
NB.   q = a + b*i + c*j + d*k ∊ ℍ
NB.   λ = a + |q-a|*i         ∊ ℂ
NB.   sgn(q) = q/|q|,     if q ≠ 0
NB.          = undefined, if q = 0
NB.
NB. Syntax:
NB.   vapp=. f qnf
NB. where
NB.   f    - monad to compute real or complex function value
NB.          of real or complex argument, is called as:
NB.            o=. f y
NB.   vapp - monad to compute quaternion function value of
NB.          quaternion argument, is called as:
NB.            o=. vapp y
NB.
NB. Examples:
NB.    ^ 1
NB. 2.71828
NB.    NB. quaternificated exp(x) of real x has b=c=d=0
NB.    ^ qnf_mt_ 1 0
NB. 2.71828 0
NB.    ^ 1j2
NB. _1.1312j2.47173
NB.    NB. quaternificated exp(x) of complex x has c=d=0
NB.    ^ qnf_mt_ 1j2 0
NB. _1.1312j2.47173 0
NB.    NB. quaternificated exp(x) of quaternion x
NB.    ^ qnf_mt_ 1j2 3j4
NB. 1.69392j_0.78956 _1.18434j_1.57912
NB.
NB. Notes:
NB. - 0-rank approach
NB. - the following intermediate quaternion is used:
NB.     |q-a| + b*i + c*j + d*k
NB.   to aviod |q-a| value computing twice
NB.
NB. References:
NB. [1] Bairak L.G. Integral Formula of Cauchy for
NB.     Quaternions. 2010. (Байрак Л.Г. Интегральная формула
NB.     Коши для кватернионов. 2010.)
NB.     http://scholium.narod.ru

qnf=: 1 : 'qn1_mt_ (u@(j. qn1_mt_) ((9 o. [) qn1_mt_ (* 11&o.)~) (% qn1_mt_)@]) qnmod_mt_@qnmarkijk_mt_ qn1_mt_ ]'
