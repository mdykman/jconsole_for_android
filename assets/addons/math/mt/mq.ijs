NB. Multiply a general matrix by a matrix with orthonormal
NB. rows or columns, which is represented in factored form
NB.
NB. unmlqxx    Multiply a general matrix by a matrix with
NB.            orthonormal rows, which is represented in
NB.            factored form, as returned by gelqf
NB. unmqlxx    Multiply a general matrix by a matrix with
NB.            orthonormal columns, which is represented in
NB.            factored form, as returned by geqlf
NB. unmqrxx    Multiply a general matrix by a matrix with
NB.            orthonormal columns, which is represented in
NB.            factored form, as returned by geqrf
NB. unmrqxx    Multiply a general matrix by a matrix with
NB.            orthonormal rows, which is represented in
NB.            factored form, as returned by gerqf
NB. unmhrxxx   Multiply a general matrix by an unitary
NB.            (orthogonal) matrix, which is represented in
NB.            factored form, as returned by gehrdx
NB. unmbrxx    Multiply a general matrix by an unitary
NB.            (orthogonal) matrix, which is represented in
NB.            factored form, as returned by gebrdx
NB.
NB. testunmq   Test unmxxxx by general matrix given
NB. testunmhr  Test unmhrxxx by square matrix given
NB. testmq     Adv. to make verb to test unmxxxxx by matrix of
NB.            generator and shape given
NB.
NB. Version: 0.7.0 2011-08-06
NB.
NB. Copyright 2010-2011 Igor Zhuravlev
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

NB. ---------------------------------------------------------
NB. Blocked code constants

MQNB=: 32   NB. block size limit

NB. ---------------------------------------------------------
NB. Miscellaneous

arounddown=: 1 : '- m&|'  NB. adv. to round down by an integer constant

NB. ---------------------------------------------------------
NB. Description:
NB.   Single step of non-blocked version of algorithms
NB.
NB. Syntax
NB.   'pfxCi1 sfxCi1'=. Qf unmxxxx (pfxCi ; sfxCi)
NB. where
NB.   pfxCi   - pfxC(i), the prefix of eC(i), either already
NB.             processed or not yet processed part
NB.   sfxCi   - sfxC(i), the suffix of eC(i), either not yet
NB.             processed or already processed part,
NB.             inversely to pfxC(i)
NB.   eC(i)   - matrix C augmented by trash vector, after
NB.             i-th and before (i+1)-th step, it may be
NB.             restored by merging pfxC(i) and sfxC(i)
NB.   C       - m×n-matrix to multiply
NB.   Qf      - unit triangular matrix, it represents Q in
NB.             factored form, and contains vectors
NB.             vtau[0:k-1]
NB.   Q       - matrix with orthonormal rows or columns,
NB.             which is defined as the product of
NB.             elementary reflectors
NB.   pfxCi1  - pfxC(i+1), the prefix of eC(i+1), either
NB.             already processed or not yet processed part
NB.   sfxCi1  - sfxC(i+1), the suffix of eC(i+1), either not
NB.             yet processed or already processed part,
NB.             inversely to pfxC(i)
NB.   eC(i+1) - matrix C augmented by modified trash vector,
NB.             after (i+1)-th step, it may be restored by
NB.             merging pfxC(i+1) and sfxC(i+1)
NB.
NB. Algorithm:
NB.   In:  Qf pfxC(i) sfxC(i)
NB.   Out: pfxC(i+1) sfxC(i+1)
NB.   1) form rios, rIOS of vtau[i] which defines an
NB.      elementary reflector, depending on aC(i)'s size
NB.   2) extract vtau[i] from Qf and ravel it:
NB.        vtaui=. rios (, ;. 0) Qf
NB.   3) apply an elementary reflector defined by vtau[i] to
NB.      either pfxC(i) or sfxC(i) to produce tmp:
NB.        tmp=. vtaui larfxxxx xfxCi
NB.   4) combine tmp and either pfxC(i) or sfxC(i) to
NB.      produce pfxC(i+1) and sfxC(i+1)

unml2lnstep=: (0 {:: ]) ((,    1  _&rt)  ;  }.   @])  (,;.0~ (1 _ ,:~ 2 #      #@(0&({::)))) larflcfr 1 {:: ]
unml2lcstep=: (0 {:: ]) ((, ~ _1  _&rt)~ ;~ }:   @[)  (,;.0~ (1 _ ,:~ 2 #      #@(0&({::)))) larflnfr 1 {:: ]
unml2rnstep=: (0 {:: ]) ((,.~  _ _1&rt)~ ;~(}:"1)@[)  (,;.0~ (1 _ ,:~ 2 #      c@(0&({::)))) larfrcfr 1 {:: ]
unml2rcstep=: (0 {:: ]) ((,.   _  1&rt)  ; (}."1)@])  (,;.0~ (1 _ ,:~ 2 #      c@(0&({::)))) larfrnfr 1 {:: ]

unm2llnstep=: (1 {:: ]) ((,    1  _&rt)  ;  }.   @])~ (,;.0~ (_ 1 ,:~ 2 # _1 - #@(1&({::)))) larflnbc 0 {:: ]
unm2llcstep=: (1 {:: ]) ((, ~ _1  _&rt)~ ;~ }:   @[)~ (,;.0~ (_ 1 ,:~ 2 # _1 - #@(1&({::)))) larflcbc 0 {:: ]
unm2lrnstep=: (1 {:: ]) ((,.~  _ _1&rt)~ ;~(}:"1)@[)~ (,;.0~ (_ 1 ,:~ 2 # _1 - c@(1&({::)))) larfrnbc 0 {:: ]
unm2lrcstep=: (1 {:: ]) ((,.   _  1&rt)  ; (}."1)@])~ (,;.0~ (_ 1 ,:~ 2 # _1 - c@(1&({::)))) larfrcbc 0 {:: ]

unm2rlnstep=: (0 {:: ]) ((, ~ _1  _&rt)~ ;~ }:   @[)  (,;.0~ (_ 1 ,:~ 2 #      #@(0&({::)))) larflnfc 1 {:: ]
unm2rlcstep=: (0 {:: ]) ((,    1  _&rt)  ;  }.   @])  (,;.0~ (_ 1 ,:~ 2 #      #@(0&({::)))) larflcfc 1 {:: ]
unm2rrnstep=: (0 {:: ]) ((,.   _  1&rt)  ; (}."1)@])  (,;.0~ (_ 1 ,:~ 2 #      c@(0&({::)))) larfrnfc 1 {:: ]
unm2rrcstep=: (0 {:: ]) ((,.~  _ _1&rt)~ ;~(}:"1)@[)  (,;.0~ (_ 1 ,:~ 2 #      c@(0&({::)))) larfrcfc 1 {:: ]

unmr2lnstep=: (1 {:: ]) ((, ~ _1  _&rt)~ ;~ }:   @[)~ (,;.0~ (1 _ ,:~ 2 # _1 - #@(1&({::)))) larflcbr 0 {:: ]
unmr2lcstep=: (1 {:: ]) ((,    1  _&rt)  ;  }.   @])~ (,;.0~ (1 _ ,:~ 2 # _1 - #@(1&({::)))) larflnbr 0 {:: ]
unmr2rnstep=: (1 {:: ]) ((,.   _  1&rt)  ; (}."1)@])~ (,;.0~ (1 _ ,:~ 2 # _1 - c@(1&({::)))) larfrcbr 0 {:: ]
unmr2rcstep=: (1 {:: ]) ((,.~  _ _1&rt)~ ;~(}:"1)@[)~ (,;.0~ (1 _ ,:~ 2 # _1 - c@(1&({::)))) larfrnbr 0 {:: ]

NB. ---------------------------------------------------------
NB. Verb     Action   Side   Tran  Syntax
NB. unml2ln  Q * C    left   none  eCprod=. Qf unml2ln (C, 0)
NB. unml2lc  Q^H * C  left   ct    eCprod=. Qf unml2lc (C, 0)
NB. unml2rn  C * Q    right  none  eCprod=. Qf unml2rn (C,.0)
NB. unml2rc  C * Q^H  right  ct    eCprod=. Qf unml2rc (C,.0)
NB. unm2lln  Q * C    left   none  eCprod=. Qf unm2lln (0, C)
NB. unm2llc  Q^H * C  left   ct    eCprod=. Qf unm2llc (0, C)
NB. unm2lrn  C * Q    right  none  eCprod=. Qf unm2lrn (0,.C)
NB. unm2lrc  C * Q^H  right  ct    eCprod=. Qf unm2lrc (0,.C)
NB. unm2rln  Q * C    left   none  eCprod=. Qf unm2rln (C, 0)
NB. unm2rlc  Q^H * C  left   ct    eCprod=. Qf unm2rlc (C, 0)
NB. unm2rrn  C * Q    right  none  eCprod=. Qf unm2rrn (C,.0)
NB. unm2rrc  C * Q^H  right  ct    eCprod=. Qf unm2rrc (C,.0)
NB. unmr2ln  Q * C    left   none  eCprod=. Qf unmr2ln (0, C)
NB. unmr2lc  Q^H * C  left   ct    eCprod=. Qf unmr2lc (0, C)
NB. unmr2rn  C * Q    right  none  eCprod=. Qf unmr2rn (0,.C)
NB. unmr2rc  C * Q^H  right  ct    eCprod=. Qf unmr2rc (0,.C)
NB.
NB. Description:
NB.   Multiply a general matrix C, augmented by trash vector,
NB.   by matrix Q. This is non-blocked version of algorithm
NB. where
NB.   C      - m×n-matrix to multiply
NB.   Qf     - unit triangular matrix, it represents Q in
NB.            factored form as returned by ge{lq,ql,qr,rq}2,
NB.            and contains vectors vtau[0:k-1]
NB.   Q      - matrix with orthonormal rows or columns, which
NB.            is defined as the product of elementary
NB.            reflectors
NB.   eCprod - being product of matrix Q and augmented matrix
NB.            C, trash vector is modified on exit
NB.
NB. Algorithm:
NB.   In: Qf , eC
NB.   Out: eCprod
NB.   1) form (pfxC;sfxC) as (aC;bC) or (bC;aC)
NB.   2) find I, the decremented number of iterations
NB.   3) start iterations by Power (^:) on (pfxCi;sfxCi) as
NB.      (aCi;bCi) or (bCi;aCi)
NB.      3.1) apply unmxxxxstep:
NB.             tmp=. Qf unmxxxxstep (pfxCi;sfxCi)
NB.      3.2) combine aCi and tmp to produce (pfxCi1;sfxCi1)
NB.           as (aCi1;bCi1) or (bCi1;aCi1)
NB.   4) apply unmxxxxstep to (pfxCi1;sfxCi1) to produce bCi1
NB.   5) combine aCi1 and bCi1 to produce eCprod
NB.
NB. Assertions:
NB.   (idmat n) (-: (clean@:( }:   ))) ((   tru1 gelqf A) unml2ln ((ct unglq gelqf A) ,   0))
NB.   (idmat n) (-: (clean@:( }:   ))) ((   tru1 gelqf A) unml2lc ((   unglq gelqf A) ,   0))
NB.   (idmat n) (-: (clean@:((}:"1)))) ((   tru1 gelqf A) unml2rn ((ct unglq gelqf A) ,.  0))
NB.   (idmat n) (-: (clean@:((}:"1)))) ((   tru1 gelqf A) unml2rc ((   unglq gelqf A) ,.  0))
NB.   (idmat n) (-: (clean@:( }.   ))) ((_1 tru1 geqlf A) unm2lln ((ct ungql geqlf A) , ~ 0))
NB.   (idmat n) (-: (clean@:( }.   ))) ((_1 tru1 geqlf A) unm2llc ((   ungql geqlf A) , ~ 0))
NB.   (idmat n) (-: (clean@:((}."1)))) ((_1 tru1 geqlf A) unm2lrn ((ct ungql geqlf A) ,.~ 0))
NB.   (idmat n) (-: (clean@:((}."1)))) ((_1 tru1 geqlf A) unm2lrc ((   ungql geqlf A) ,.~ 0))
NB.   (idmat n) (-: (clean@:( }:   ))) ((   trl1 geqrf A) unm2rln ((ct ungqr geqrf A) ,   0))
NB.   (idmat n) (-: (clean@:( }:   ))) ((   trl1 geqrf A) unm2rlc ((   ungqr geqrf A) ,   0))
NB.   (idmat n) (-: (clean@:((}:"1)))) ((   trl1 geqrf A) unm2rrn ((ct ungqr geqrf A) ,.  0))
NB.   (idmat n) (-: (clean@:((}:"1)))) ((   trl1 geqrf A) unm2rrc ((   ungqr geqrf A) ,.  0))
NB.   (idmat n) (-: (clean@:( }.   ))) (( 1 trl1 gerqf A) unmr2ln ((ct ungrq gerqf A) , ~ 0))
NB.   (idmat n) (-: (clean@:( }.   ))) (( 1 trl1 gerqf A) unmr2lc ((   ungrq gerqf A) , ~ 0))
NB.   (idmat n) (-: (clean@:((}."1)))) (( 1 trl1 gerqf A) unmr2rn ((ct ungrq gerqf A) ,.~ 0))
NB.   (idmat n) (-: (clean@:((}."1)))) (( 1 trl1 gerqf A) unmr2rc ((   ungrq gerqf A) ,.~ 0))
NB. where
NB.   2 -: # $ A  NB. A is a 2-rank array (i.e. matrix)
NB.   -:/ @ $ A   NB. A is a square matrix (it's not
NB.               NB.   necessary and is assumed just
NB.               NB.   to simplify assertions)
NB.   n=. # A     NB. size of matrix A
NB.
NB. Notes:
NB. - input's and output's shapes are the same
NB. - implements LAPACK's {DOR,ZUN}M{L2,2L,2R,R2}
NB. - unml2{ln,lc,rn,rc} and unmlq{ln,lc,rn,rc} respectively
NB.   are topologic equivalents

unml2ln=: , &>/@(  unml2lnstep^:(#@[) (;~ 0  &{.                         ) )
unml2lc=: , &>/@([ unml2lcstep^:(#@[) (( {.       ;   }.      )~ (_1 + #))~)
unml2rn=: ,.&>/@([ unml2rnstep^:(#@[) ((({.~ _&,) ;  (}.~ 0&,))  (_1 + #))~)
unml2rc=: ,.&>/@(  unml2rcstep^:(#@[) (;~ _ 0&{.                         ) )

unm2lln=: , &>/@([ unm2llnstep^:(c@[) (( {.       ;~  }.      )~ ( 1 - c))~)
unm2llc=: , &>/@(  unm2llcstep^:(c@[) (;  0  &{.                         ) )
unm2lrn=: ,.&>/@(  unm2lrnstep^:(c@[) (;  _ 0&{.                         ) )
unm2lrc=: ,.&>/@([ unm2lrcstep^:(c@[) ((({.~ _&,) ;~ (}.~ 0&,))  ( 1 - c))~)

unm2rln=: , &>/@([ unm2rlnstep^:(c@[) (( {.       ;   }.      )~ (_1 + c))~)
unm2rlc=: , &>/@(  unm2rlcstep^:(c@[) (;~ 0  &{.                         ) )
unm2rrn=: ,.&>/@(  unm2rrnstep^:(c@[) (;~ _ 0&{.                         ) )
unm2rrc=: ,.&>/@([ unm2rrcstep^:(c@[) ((({.~ _&,) ;  (}.~ 0&,))  (_1 + c))~)

unmr2ln=: , &>/@(  unmr2lnstep^:(#@[) (;  0&{.                           ) )
unmr2lc=: , &>/@([ unmr2lcstep^:(#@[) (( {.       ;~  }.      )~ ( 1 - #))~)
unmr2rn=: ,.&>/@([ unmr2rnstep^:(#@[) ((({.~ _&,) ;~ (}.~ 0&,))  ( 1 - #))~)
unmr2rc=: ,.&>/@(  unmr2rcstep^:(#@[) (;  _ 0&{.                         ) )

NB. ---------------------------------------------------------
NB. Description:
NB.   Single step of algorithms
NB.
NB. Syntax
NB.   'pfxCi1 sfxCi1'=. Qf unmxxxx (pfxCi ; sfxCi)
NB. where
NB.   pfxCi   - pfxC(i), the prefix of eC(i), either already
NB.             processed or not yet processed part
NB.   sfxCi   - sfxC(i), the suffix of eC(i), either not yet
NB.             processed or already processed part,
NB.             inversely to pfxC(i)
NB.   eC(i)   - matrix C augmented by trash vector, after
NB.             i-th and before (i+1)-th step, it may be
NB.             restored by merging pfxC(i) and sfxC(i)
NB.   C       - m×n-matrix to multiply
NB.   Qf      - unit triangular matrix, it represents Q in
NB.             factored form, and contains vectors
NB.             vtau[0:k-1]
NB.   Q       - matrix with orthonormal rows or columns,
NB.             which is defined as the product of
NB.             elementary reflectors
NB.   pfxCi1  - pfxC(i+1), the prefix of eC(i+1), either
NB.             already processed or not yet processed part
NB.   sfxCi1  - sfxC(i+1), the suffix of eC(i+1), either not
NB.             yet processed or already processed part,
NB.             inversely to pfxC(i)
NB.   eC(i+1) - matrix C augmented by modified trash vector,
NB.             after (i+1)-th step, it may be restored by
NB.             merging pfxC(i+1) and sfxC(i+1)
NB.
NB. Algorithm:
NB.   In:  Qf pfxC(i) sfxC(i)
NB.   Out: pfxC(i+1) sfxC(i+1)
NB.   1) form rios, rIOS of matrix VTau[i] which defines the
NB.      block reflector, it depends on aC(i)'s size
NB.   2) try to extract VTau[i] from Qf:
NB.        VTaui=. rios (] ;. 0) Qf
NB.      2.1) if failure occures (i.e. execution is at first
NB.           or last step and 0<MQNB|k ), then replace in
NB.           rios wrong explicit length (MQNB) by implicit
NB.           one (∞) and retry
NB.   3) apply a block reflector defined by VTau[i] to either
NB.      pfxC(i) or sfxC(i) to produce tmp:
NB.        tmp=. VTaui larfbxxxx xfxCi
NB.   4) combine tmp and either pfxC(i) or sfxC(i) to
NB.      produce pfxC(i+1) and sfxC(i+1)
NB.
NB. Notes:
NB. - assigning MQNB=:1 transforms this verbs to their
NB.   non-blocked counterparts

unmlqlnstep=:                          (0 {:: ])              ((,   (MQNB* 1  _)&rt)             ;  (MQNB* 1  0)&}.@])  (  ];.0~ ::(];.0~ _&(2:})) ((MQNB*1 _) ,:~ 2 # #@(0&({::))                                                      )) larfblcfr 1 {:: ]
unmlqlcstep=:                          (0 {:: ])              ((, ~ (MQNB*_1  _)&rt)~            ;~ (MQNB*_1  0)&}.@[)  (  ];.0~ ::(];.0~ _&(2:})) ((MQNB*1 _) ,:~ 2 # #@(0&({::))                                                      )) larfblnfr 1 {:: ]
unmlqrnstep=:                          (0 {:: ])              ((,.~ (MQNB* _ _1)&rt)~            ;~ (MQNB* 0 _1)&}.@[)  (  ];.0~ ::(];.0~ _&(2:})) ((MQNB*1 _) ,:~ 2 # c@(0&({::))                                                      )) larfbrcfr 1 {:: ]
unmlqrcstep=:                          (0 {:: ])              ((,.  (MQNB* _  1)&rt)             ;  (MQNB* 0  1)&}.@])  (  ];.0~ ::(];.0~ _&(2:})) ((MQNB*1 _) ,:~ 2 # c@(0&({::))                                                      )) larfbrnfr 1 {:: ]

unmqllnstep=:                          (1 {:: ])              ((,   (MQNB* 1  _)&rt)             ;  (MQNB* 1  0)&}.@])~ ([ ];.0~ ::(];.0~ _&(3:})) ((MQNB*_ 1) ,:~ ((((((<:@-) {.)~ {.) ,  ((MQNB arounddown @ -~ {:)~ >:@{:))~ $)~ #&>))) larfblnbc 0 {:: ]
unmqllcstep=: (((<@(_1-(MQNB|<:@(c@[-#@(1 {:: ])))))`0:`]) }) (((1 {:: ]) , ~ ({.  ~ (0&({::)))) ;~ (}.  ~ (0&({::))))~ ([ ];.0~ ::(];.0~ _&(3:})) ((MQNB*_ 1) ,:~ ((((((<:@-) {.)~ {.) ,  ((MQNB arounddown @ -~ {:)~ >:@{:))~ $)~ #&>))) larfblcbc 0 {:: ]
unmqlrnstep=: (((<@(_1-(MQNB|<:@(c@[-c@(1 {:: ])))))`0:`]) }) (((1 {:: ]) ,.~ ({."1~ (0&({::)))) ;~ (}."1~ (0&({::))))~ ([ ];.0~ ::(];.0~ _&(3:})) ((MQNB*_ 1) ,:~ ((((((<:@-) {.)~ {.) ,  ((MQNB arounddown @ -~ {:)~ >:@{:))~ $)~ c&>))) larfbrnbc 0 {:: ]
unmqlrcstep=:                          (1 {:: ])              ((,.  (MQNB* _  1)&rt)             ;  (MQNB* 0  1)&}.@])~ ([ ];.0~ ::(];.0~ _&(3:})) ((MQNB*_ 1) ,:~ ((((((<:@-) {.)~ {.) ,  ((MQNB arounddown @ -~ {:)~ >:@{:))~ $)~ c&>))) larfbrcbc 0 {:: ]

unmqrlnstep=:                          (0 {:: ])              ((, ~ (MQNB*_1  _)&rt)~            ;~ (MQNB*_1  0)&}.@[)  (  ];.0~ ::(];.0~ _&(3:})) ((MQNB*_ 1) ,:~ 2 # #@(0&({::))                                                      )) larfblnfc 1 {:: ]
unmqrlcstep=:                          (0 {:: ])              ((,   (MQNB* 1  _)&rt)             ;  (MQNB* 1  0)&}.@])  (  ];.0~ ::(];.0~ _&(3:})) ((MQNB*_ 1) ,:~ 2 # #@(0&({::))                                                      )) larfblcfc 1 {:: ]
unmqrrnstep=:                          (0 {:: ])              ((,.  (MQNB* _  1)&rt)             ;  (MQNB* 0  1)&}.@])  (  ];.0~ ::(];.0~ _&(3:})) ((MQNB*_ 1) ,:~ 2 # c@(0&({::))                                                      )) larfbrnfc 1 {:: ]
unmqrrcstep=:                          (0 {:: ])              ((,.~ (MQNB* _ _1)&rt)~            ;~ (MQNB* 0 _1)&}.@[)  (  ];.0~ ::(];.0~ _&(3:})) ((MQNB*_ 1) ,:~ 2 # c@(0&({::))                                                      )) larfbrcfc 1 {:: ]

unmrqlnstep=: (((<@(_1-(MQNB|<:@(#@[-#@(1 {:: ])))))`0:`]) }) (((1 {:: ]) , ~ ({.  ~ (0&({::)))) ;~ (}.  ~ (0&({::))))~ ([ ];.0~ ::(];.0~ _&(2:})) ((MQNB*1 _) ,:~ ((((((<:@-) {:)~ {.) ,~ ((MQNB arounddown @ -~ {.)~ >:@{:))~ $)~ #&>))) larfblcbr 0 {:: ]
unmrqlcstep=:                          (1 {:: ])              ((,   (MQNB* 1  _)&rt)             ;  (MQNB* 1  0)&}.@])~ ([ ];.0~ ::(];.0~ _&(2:})) ((MQNB*1 _) ,:~ ((((((<:@-) {:)~ {.) ,~ ((MQNB arounddown @ -~ {.)~ >:@{:))~ $)~ #&>))) larfblnbr 0 {:: ]
unmrqrnstep=:                          (1 {:: ])              ((,.  (MQNB* _  1)&rt)             ;  (MQNB* 0  1)&}.@])~ ([ ];.0~ ::(];.0~ _&(2:})) ((MQNB*1 _) ,:~ ((((((<:@-) {:)~ {.) ,~ ((MQNB arounddown @ -~ {.)~ >:@{:))~ $)~ c&>))) larfbrcbr 0 {:: ]
unmrqrcstep=: (((<@(_1-(MQNB|<:@(#@[-c@(1 {:: ])))))`0:`]) }) (((1 {:: ]) ,.~ ({."1~ (0&({::)))) ;~ (}."1~ (0&({::))))~ ([ ];.0~ ::(];.0~ _&(2:})) ((MQNB*1 _) ,:~ ((((((<:@-) {:)~ {.) ,~ ((MQNB arounddown @ -~ {.)~ >:@{:))~ $)~ c&>))) larfbrnbr 0 {:: ]

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. Verb      Action   Side   Tran  Syntax
NB. unmlqln   Q * C    left   none  B=. LQf unmlqln C
NB. unmlqlc   Q^H * C  left   ct    B=. LQf unmlqlc C
NB. unmlqrn   C * Q    right  none  B=. LQf unmlqrn C
NB. unmlqrc   C * Q^H  right  ct    B=. LQf unmlqrc C
NB.
NB. Description:
NB.   Multiply a general matrix C by matrix Q, which is
NB.   represented in factored form LQf as returned by gelqf
NB. where
NB.   B,C - m×n-matrices
NB.   LQf - n×(m+1)-matrix (ln,lc cases) or m×(n+1)-matrix
NB.         (rn,rc), contains Qf (unit diagonal not stored),
NB.         the output of gelqf
NB.   Qf  - k×(m+1)-matrix (ln,lc) or k×(n+1)-matrix (rn,rc),
NB.         unit upper triangular, the Q represented in
NB.         factored form
NB.   Q   - m×m-matrix (ln,lc) or n×n-matrix (rn,rc), unitary
NB.         (orthogonal), which is defined as a product of k
NB.         elementary reflectors:
NB.           Q = Π{H(i)',i=k-1:0}
NB.   k   = min(m,n)
NB.
NB. Algorithm:
NB.   In:  LQf C
NB.   Out: B
NB.   1) augment C by zero vector:
NB.        aC=. C ,   0    NB. ln,lc
NB.        aC=. C ,.  0    NB. rn,rc
NB.   2) extract Qf from LQf
NB.   3) if k>MQNB
NB.      3.1) then
NB.           3.1.1) split aC on prefix pfxaC and suffix sfxaC:
NB.                    'pfxaC sfxaC'=. 0 ({. ;  }.)   eC    NB. ln
NB.                    'pfxaC sfxaC'=. b ({. ;  }.)   eC    NB. lc
NB.                    'pfxaC sfxaC'=. b ({. ;  }.)"1 eC    NB. rn
NB.                    'pfxaC sfxaC'=. 0 ({. ;  }.)"1 eC    NB. rc
NB.                  where
NB.                    b := ⌊(k-1)/MQNB⌋*MQNB , size of part
NB.                         processed by blocked algorithm
NB.           3.1.2) find I, the number of iterations:
NB.                    I := ⌈k/MQNB⌉
NB.           3.1.3) do iterations:
NB.                    'pfxaB sfxaB'=. Qf (unmlqxxstep ^: I) (pfxaC;sfxaC)
NB.           3.1.4) unbox and merge pfxaB and sfxaB to produce aB,
NB.                  being B augmented by trash vector:
NB.                    aB=. pfxaB ,  sfxaB    NB. ln,lc
NB.                    aB=. pfxaB ,. sfxaB    NB. rn,rc
NB.      3.2) else process by non-blocked algorithm:
NB.             aB=. Qf unml2xx aC
NB.   4) cut off trash vector from aB to produce B:
NB.        B=. }:   C    NB. ln,lc
NB.        B=. }:"1 C    NB. rn,rc
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   ((idmat @ c) (-: clean) (unmlqln (ct @ ((<:@c) unglq ]))) @ gelqf) A
NB.   ((idmat @ c) (-: clean) (unmlqlc       ((<:@c) unglq ]) ) @ gelqf) A
NB.   ((idmat @ c) (-: clean) (unmlqrn (ct @ ((<:@c) unglq ]))) @ gelqf) A
NB.   ((idmat @ c) (-: clean) (unmlqrc       ((<:@c) unglq ]) ) @ gelqf) A
NB.
NB. Notes:
NB. - implements LAPACK's DORMLQ, ZUNMLQ
NB. - unml2{lc,ln,rc,rn} and unmlq{lc,ln,rc,rn} respectively
NB.   are topologic equivalents

unmlqln=: }:   @ ((unml2ln`(, &>/@(  unmlqlnstep^:(>.@(MQNB %~ #@[)) (;~ 0& {.                                          ) ))@.(MQNB < #@[)~  tru1            @({.  ~     0 _1&(ms $) ))~ ,   &0)
unmlqlc=: }:   @ ((unml2lc`(, &>/@([ unmlqlcstep^:(>.@(MQNB %~ #@[)) (( {.     ;   }.  )~   (MQNB arounddown @ (_1 + #)))~))@.(MQNB < #@[)~  tru1            @({.  ~     0 _1&(ms $) ))~ ,   &0)
unmlqrn=: }:"1 @ ((unml2rn`(,.&>/@([ unmlqrnstep^:(>.@(MQNB %~ #@[)) ((({."1~) ;  (}."1~))  (MQNB arounddown @ (_1 + #)))~))@.(MQNB < #@[)~  tru1            @({.  ~     0 _1&(ms $) ))~ ,.  &0)
unmlqrc=: }:"1 @ ((unml2rc`(,.&>/@(  unmlqrcstep^:(>.@(MQNB %~ #@[)) (;~ 0&({."1)                                       ) ))@.(MQNB < #@[)~  tru1            @({.  ~     0 _1&(ms $) ))~ ,.  &0)

NB. ---------------------------------------------------------
NB. Verb      Action   Side   Tran  Syntax
NB. unmqlln   Q * C    left   none  B=. QfL unmqlln C
NB. unmqllc   Q^H * C  left   ct    B=. QfL unmqllc C
NB. unmqlrn   C * Q    right  none  B=. QfL unmqlrn C
NB. unmqlrc   C * Q^H  right  ct    B=. QfL unmqlrc C
NB.
NB. Description:
NB.   Multiply a general matrix C by matrix Q, which is
NB.   represented in factored form QfL as returned by geqlf
NB. where
NB.   B,C - m×n-matrices
NB.   QfL - (m+1)×n-matrix (ln,lc cases), (n+1)×m-matrix
NB.         (rn,rc), contains Qf (unit diagonal not stored),
NB.         the output of geqlf
NB.   Qf  - (m+1)×k-matrix (ln,lc) or (n+1)×k-matrix (rn,rc),
NB.         unit upper triangular, the Q represented in
NB.         factored form
NB.   Q   - m×m-matrix (ln,lc) or n×n-matrix (rn,rc), unitary
NB.         (orthogonal), which is defined as a product of k
NB.         elementary reflectors:
NB.           Q = Π{H(i),i=k-1:0}
NB.   k   = min(m,n)
NB.
NB. Algorithm:
NB.   In:  QfL C
NB.   Out: B
NB.   1) augment C by zero vector:
NB.        aC=. C , ~ 0    NB. ln,lc
NB.        aC=. C ,.~ 0    NB. rn,rc
NB.   2) extract Qf from QfL
NB.   3) if k>MQNB
NB.      3.1) then
NB.           3.1.1) split aC on prefix pfxaC and suffix sfxaC:
NB.                    'pfxaC sfxaC'=. b ({. ;~ }.)   eC    NB. ln
NB.                    'pfxaC sfxaC'=. 0 ({. ;~ }.)   eC    NB. lc
NB.                    'pfxaC sfxaC'=. 0 ({. ;~ }.)"1 eC    NB. rn
NB.                    'pfxaC sfxaC'=. b ({. ;~ }.)"1 eC    NB. rc
NB.                  where
NB.                    b := MQNB - k , negated size of part
NB.                         not processed by blocked
NB.                         algorithm
NB.           3.1.2) find I, the number of iterations:
NB.                    I := ⌈k/MQNB⌉
NB.           3.1.3) do iterations:
NB.                    'pfxaB sfxaB'=. Qf (unmqlxxstep ^: I) (pfxaC;sfxaC)
NB.           3.1.4) unbox and merge pfxaB and sfxaB to produce aB,
NB.                  being B augmented by trash vector:
NB.                    aB=. pfxaB ,  sfxaB    NB. ln,lc
NB.                    aB=. pfxaB ,. sfxaB    NB. rn,rc
NB.      3.2) else
NB.             aB=. Qf unm2lxx aC
NB.   4) cut off trash vector from aB to produce B:
NB.        B=. }.   C    NB. ln,lc
NB.        B=. }."1 C    NB. rn,rc
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   ((idmat @ #) (-: clean) (unmqlln (ct @ ((<:@#) ungql ]))) @ geqlf) A
NB.   ((idmat @ #) (-: clean) (unmqllc       ((<:@#) ungql ]) ) @ geqlf) A
NB.   ((idmat @ #) (-: clean) (unmqlrn (ct @ ((<:@#) ungql ]))) @ geqlf) A
NB.   ((idmat @ #) (-: clean) (unmqlrc       ((<:@#) ungql ]) ) @ geqlf) A
NB.
NB. Notes:
NB. - implements LAPACK's DORMQL, ZUNMQL
NB. - unm2l{lc,ln,rc,rn} and unmql{lc,ln,rc,rn} respectively
NB.   are topologic equivalents

unmqlln=: }.   @ ((unm2lln`(, &>/@([ unmqllnstep^:(>.@(MQNB %~ c@[)) (( {.     ;~  }.    )~ (MQNB                  - c ))~))@.(MQNB < c@[)~ (tru1~ (-~/ @ $))@({."1~ -@(_1  0&(ms $))))~ , ~ &0)
unmqllc=: }.   @ ((unm2llc`(, &>/@(  unmqllcstep^:(>.@(MQNB %~ c@[)) (;  0& {.                                          ) ))@.(MQNB < c@[)~ (tru1~ (-~/ @ $))@({."1~ -@(_1  0&(ms $))))~ , ~ &0)
unmqlrn=: }."1 @ ((unm2lrn`(,.&>/@(  unmqlrnstep^:(>.@(MQNB %~ c@[)) (;  0&({."1)                                       ) ))@.(MQNB < c@[)~ (tru1~ (-~/ @ $))@({."1~ -@(_1  0&(ms $))))~ ,.~ &0)
unmqlrc=: }."1 @ ((unm2lrc`(,.&>/@([ unmqlrcstep^:(>.@(MQNB %~ c@[)) ((({."1~) ;~ (}."1~))  (MQNB                  - c ))~))@.(MQNB < c@[)~ (tru1~ (-~/ @ $))@({."1~ -@(_1  0&(ms $))))~ ,.~ &0)

NB. ---------------------------------------------------------
NB. Verb      Action   Side   Tran  Syntax
NB. unmqrln   Q * C    left   none  B=. QfR unmqrln C
NB. unmqrlc   Q^H * C  left   ct    B=. QfR unmqrlc C
NB. unmqrrn   C * Q    right  none  B=. QfR unmqrrn C
NB. unmqrrc   C * Q^H  right  ct    B=. QfR unmqrrc C
NB.
NB. Description:
NB.   Multiply a general matrix C by matrix Q, which is
NB.   represented in factored form QfR as returned by geqrf
NB. where
NB.   B,C - m×n-matrices
NB.   QfR - (m+1)×n-matrix (ln,lc cases), (n+1)×m-matrix
NB.         (rn,rc), contains Qf (unit diagonal not stored),
NB.         the output of geqrf
NB.   Qf  - (m+1)×k-matrix (ln,lc) or (n+1)×k-matrix (rn,rc),
NB.         unit lower triangular, the Q represented in
NB.         factored form
NB.   Q   - m×m-matrix (ln,lc) or n×n-matrix (rn,rc), unitary
NB.         (orthogonal), which is defined as a product of k
NB.         elementary reflectors:
NB.           Q = Π{H(i),i=0:k-1}
NB.   k   = min(m,n)
NB.
NB. Algorithm:
NB.   In:  QfR C
NB.   Out: B
NB.   1) augment C by zero vector:
NB.        aC=. C ,   0    NB. ln,lc
NB.        aC=. C ,.  0    NB. rn,rc
NB.   2) extract Qf from QfR
NB.   3) if k>MQNB
NB.      3.1) then
NB.           3.1.1) split aC on prefix pfxaC and suffix sfxaC:
NB.                    'pfxaC sfxaC'=. b ({. ;  }.)   eC    NB. ln
NB.                    'pfxaC sfxaC'=. 0 ({. ;  }.)   eC    NB. lc
NB.                    'pfxaC sfxaC'=. 0 ({. ;  }.)"1 eC    NB. rn
NB.                    'pfxaC sfxaC'=. b ({. ;  }.)"1 eC    NB. rc
NB.                  where
NB.                    b := ⌊(k-1)/MQNB⌋*MQNB , size of part
NB.                         processed by blocked algorithm
NB.           3.1.2) find I, the number of iterations:
NB.                    I := ⌈k/MQNB⌉
NB.           3.1.3) do iterations:
NB.                    'pfxaB sfxaB'=. Qf (unmqrxxstep ^: I) (pfxaC;sfxaC)
NB.           3.1.4) unbox and merge pfxaB and sfxaB to produce aB,
NB.                  being B augmented by trash vector:
NB.                    aB=. pfxaB ,  sfxaB    NB. ln,lc
NB.                    aB=. pfxaB ,. sfxaB    NB. rn,rc
NB.      3.2) else
NB.             aB=. Qf unm2rxx aC
NB.   4) cut off trash vector from aB to produce B:
NB.        B=. }:   C    NB. ln,lc
NB.        B=. }:"1 C    NB. rn,rc
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   ((idmat @ #) (-: clean) (unmqrln (ct @ ((<:@#) ungqr ]))) @ geqrf) A
NB.   ((idmat @ #) (-: clean) (unmqrlc       ((<:@#) ungqr ]) ) @ geqrf) A
NB.   ((idmat @ #) (-: clean) (unmqrrn (ct @ ((<:@#) ungqr ]))) @ geqrf) A
NB.   ((idmat @ #) (-: clean) (unmqrrc       ((<:@#) ungqr ]) ) @ geqrf) A
NB.
NB. Notes:
NB. - implements LAPACK's DORMQR, ZUNMQR
NB. - unm2r{lc,ln,rc,rn} and unmqr{lc,ln,rc,rn} respectively
NB.   are topologic equivalents

unmqrln=: }:   @ ((unm2rln`(, &>/@([ unmqrlnstep^:(>.@(MQNB %~ c@[)) (( {.     ;   }.    )~ (MQNB arounddown @ (_1 + c)))~))@.(MQNB < c@[)~  trl1            @({."1~    _1  0&(ms $) ))~ ,   &0)
unmqrlc=: }:   @ ((unm2rlc`(, &>/@(  unmqrlcstep^:(>.@(MQNB %~ c@[)) (;~ 0& {.                                          ) ))@.(MQNB < c@[)~  trl1            @({."1~    _1  0&(ms $) ))~ ,   &0)
unmqrrn=: }:"1 @ ((unm2rrn`(,.&>/@(  unmqrrnstep^:(>.@(MQNB %~ c@[)) (;~ 0&({."1)                                       ) ))@.(MQNB < c@[)~  trl1            @({."1~    _1  0&(ms $) ))~ ,.  &0)
unmqrrc=: }:"1 @ ((unm2rrc`(,.&>/@([ unmqrrcstep^:(>.@(MQNB %~ c@[)) ((({."1~) ;  (}."1~))  (MQNB arounddown @ (_1 + c)))~))@.(MQNB < c@[)~  trl1            @({."1~    _1  0&(ms $) ))~ ,.  &0)

NB. ---------------------------------------------------------
NB. Verb      Action   Side   Tran  Syntax
NB. unmrqln   Q * C    left   none  B=. RQf unmrqln C
NB. unmrqlc   Q^H * C  left   ct    B=. RQf unmrqlc C
NB. unmrqrn   C * Q    right  none  B=. RQf unmrqrn C
NB. unmrqrc   C * Q^H  right  ct    B=. RQf unmrqrc C
NB.
NB. Description:
NB.   Multiply a general matrix C by matrix Q, which is
NB.   represented in factored form RQf as returned by gerqf
NB.
NB. where
NB.   B,C - m×n-matrices
NB.   LQf - n×(m+1)-matrix (ln,lc cases) or m×(n+1)-matrix
NB.         (rn,rc), contains Qf (unit diagonal not stored),
NB.         the output of gerqf
NB.   Qf  - k×(m+1)-matrix (ln,lc) or k×(n+1)-matrix (rn,rc),
NB.         unit lower triangular, the Q represented in
NB.         factored form
NB.   Q   - m×m-matrix (ln,lc) or n×n-matrix (rn,rc), unitary
NB.         (orthogonal), which is defined as a product of k
NB.         elementary reflectors:
NB.           Q = Π{H(i)',i=0:k-1}
NB.   k   = min(m,n)
NB.
NB. Algorithm:
NB.   In:  RQf C
NB.   Out: B
NB.   1) augment C by zero vector:
NB.        aC=. C ,~  0    NB. ln,lc
NB.        aC=. C ,.~ 0    NB. rn,rc
NB.   2) extract Qf from RQf
NB.   3) if k>MQNB
NB.      3.1) then
NB.           3.1.1) split aC on prefix pfxaC and suffix sfxaC:
NB.                    'pfxaC sfxaC'=. 0 ({. ;~ }.)   eC    NB. ln
NB.                    'pfxaC sfxaC'=. b ({. ;~ }.)   eC    NB. lc
NB.                    'pfxaC sfxaC'=. b ({. ;~ }.)"1 eC    NB. rn
NB.                    'pfxaC sfxaC'=. 0 ({. ;~ }.)"1 eC    NB. rc
NB.                  where
NB.                    b := MQNB - k , negated size of part
NB.                         not processed by blocked
NB.                         algorithm
NB.           3.1.2) find I, the number of iterations:
NB.                    I := ⌈k/MQNB⌉
NB.           3.1.3) do iterations:
NB.                    'pfxaB sfxaB'=. Qf (unmrqxxstep ^: I) (pfxaC;sfxaC)
NB.           3.1.4) unbox and merge pfxaB and sfxaB to produce aB,
NB.                  being B augmented by trash vector:
NB.                    aB=. pfxaB ,  sfxaB    NB. ln,lc
NB.                    aB=. pfxaB ,. sfxaB    NB. rn,rc
NB.      3.2) else process by non-blocked algorithm:
NB.             aB=. Qf unmr2xx aC
NB.   4) cut off trash vector from aB to produce B:
NB.        B=. }.   C    NB. ln,lc
NB.        B=. }."1 C    NB. rn,rc
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   ((idmat @ c) (-: clean) (unmrqln (ct @ ((<:@c) ungrq ]))) @ gerqf) A
NB.   ((idmat @ c) (-: clean) (unmrqlc       ((<:@c) ungrq ]) ) @ gerqf) A
NB.   ((idmat @ c) (-: clean) (unmrqrn (ct @ ((<:@c) ungrq ]))) @ gerqf) A
NB.   ((idmat @ c) (-: clean) (unmrqrc       ((<:@c) ungrq ]) ) @ gerqf) A
NB.
NB. Notes:
NB. - implements LAPACK's DORMRQ, ZUNMRQ
NB. - unmr2{lc,ln,rc,rn} and unmrq{lc,ln,rc,rn} respectively
NB.   are topologic equivalents

unmrqln=: }.   @ ((unmr2ln`(, &>/@(  unmrqlnstep^:(>.@(MQNB %~ #@[)) (;  0& {.                                          ) ))@.(MQNB < #@[)~ (trl1~ (-~/ @ $))@({.  ~ -@( 0 _1&(ms $))))~ , ~ &0)
unmrqlc=: }.   @ ((unmr2lc`(, &>/@([ unmrqlcstep^:(>.@(MQNB %~ #@[)) (( {.     ;~  }.    )~ (MQNB                  - # ))~))@.(MQNB < #@[)~ (trl1~ (-~/ @ $))@({.  ~ -@( 0 _1&(ms $))))~ , ~ &0)
unmrqrn=: }."1 @ ((unmr2rn`(,.&>/@([ unmrqrnstep^:(>.@(MQNB %~ #@[)) ((({."1~) ;~ (}."1~))  (MQNB                  - # ))~))@.(MQNB < #@[)~ (trl1~ (-~/ @ $))@({.  ~ -@( 0 _1&(ms $))))~ ,.~ &0)
unmrqrc=: }."1 @ ((unmr2rc`(,.&>/@(  unmrqrcstep^:(>.@(MQNB %~ #@[)) (;  0&({."1)                                       ) ))@.(MQNB < #@[)~ (trl1~ (-~/ @ $))@({.  ~ -@( 0 _1&(ms $))))~ ,.~ &0)

NB. ---------------------------------------------------------
NB. Verb      Action   Side   Tran  Syntax
NB. unmhrlln  Q * C    left   none  B=. HQf unmhrlln C
NB. unmhrllc  Q^H * C  left   ct    B=. HQf unmhrllc C
NB. unmhrlrn  C * Q    right  none  B=. HQf unmhrlrn C
NB. unmhrlrc  C * Q^H  right  ct    B=. HQf unmhrlrc C
NB.
NB. Description:
NB.   Multiply a general matrix C by unitary (orthogonal)
NB.   matrix Q, which is represented in factored form HQf as
NB.   returned by gehrdl
NB. where
NB.   B,C - m×n-matrices
NB.   HQf - m×(m+1)-matrix (ln,lc cases) or n×(n+1)-matrix
NB.         (rn,rc), contains Qf (unit diagonal not stored),
NB.         the output of gehrdl
NB.   Qf  - (s-1)×(m-h)-matrix (ln,lc) or (s-1)×(n-h)-matrix
NB.         (rn,rc), unit upper triangular, the Q represented
NB.         in factored form, located in HQf[h:h+s-2,h+1:end]
NB.   Q   - m×m-matrix (ln,lc) or n×n-matrix (rn,rc), being
NB.         unit matrix with unitary (orthogonal) matrix
NB.         inserted into elements Q[h:h+s-1,h:h+s-1] :
NB.           Q = Π{H(i)',i=h+s-2:h}
NB.   hs  - 2-vector of integers (h,s) 'head' and 'size',
NB.         defines submatrix Qf position in matrix HQf, see
NB.         see gehrdl
NB.
NB. Algorithm:
NB.   In:  HQf C
NB.   Out: B
NB.   1) shift HQf down to produce Qf:
NB.        Qf=. |. !. 0 HQf
NB.   2) call correspondent unmlqxx to do the job:
NB.        B=. Qf unmlqxx C
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   ((idmat @ c) (-: clean) (unmhrlln (ct @ unghrl)) @ gehrdl) A
NB.   ((idmat @ c) (-: clean) (unmhrllc (ct @ unghrl)) @ gehrdl) A
NB.   ((idmat @ c) (-: clean) (unmhrlrn (ct @ unghrl)) @ gehrdl) A
NB.   ((idmat @ c) (-: clean) (unmhrlrc (ct @ unghrl)) @ gehrdl) A
NB.
NB. Notes:
NB. - input's and output's shapes are the same
NB. - instead of using f and s parameters, the following
NB.   product is really calculating:
NB.     Q = Π{H(i)',i=n-1:0} ,
NB.   where
NB.     H(0:f-1) = H(f+s-1:n-1) = I .
NB.   This approach delivers excessive calculations in rare
NB.   case ((f>0) OR (f+s<n)).

unmhrlln=: (unmlqln~ (|. !. 0))~
unmhrllc=: (unmlqlc~ (|. !. 0))~
unmhrlrn=: (unmlqrn~ (|. !. 0))~
unmhrlrc=: (unmlqrc~ (|. !. 0))~

NB. ---------------------------------------------------------
NB. Verb      Action   Side   Tran  Syntax
NB. unmhruln  Q * C    left   none  B=. HQf unmhruln C
NB. unmhrulc  Q^H * C  left   ct    B=. HQf unmhrulc C
NB. unmhrurn  C * Q    right  none  B=. HQf unmhrurn C
NB. unmhrurc  C * Q^H  right  ct    B=. HQf unmhrurc C
NB.
NB. Description:
NB.   Multiply a general matrix C by unitary (orthogonal)
NB.   matrix Q, which is represented in factored form HQf as
NB.   returned by gehrdu
NB. where
NB.   B,C - m×n-matrices
NB.   HQf - (m+1)×m-matrix (ln,lc cases) or (n+1)×n-matrix
NB.         (rn,rc), contains Qf (unit diagonal not stored),
NB.         the output of gehrdu
NB.   Qf  - (m-h)×(s-1)-matrix (ln,lc) or (n-h)×(s-1)-matrix
NB.         (rn,rc), unit lower triangular, the Q represented
NB.         in factored form, located in HQf[h+1:end,h:h+s-2]
NB.   Q   - m×m-matrix (ln,lc) or n×n-matrix (rn,rc), being
NB.         unit matrix with unitary (orthogonal) matrix
NB.         inserted into elements Q[h:h+s-1,h:h+s-1] :
NB.           Q = Π{H(i),i=h:h+s-2}
NB.   hs  - 2-vector of integers (h,s) 'head' and 'size',
NB.         defines submatrix Qf position in matrix HQf, see
NB.         see gehrdu
NB.
NB. Algorithm:
NB.   In:  HQf C
NB.   Out: B
NB.   1) shift HQf to the right to produce Qf:
NB.        Qf=. 0 _1 |. !. 0 HQf
NB.   2) call correspondent unmqrxx to do the job:
NB.        B=. Qf unmqrxx C
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   ((idmat @ c) (-: clean) (unmhrlln (ct @ unghrl)) @ gehrdl) A
NB.   ((idmat @ c) (-: clean) (unmhrllc (ct @ unghrl)) @ gehrdl) A
NB.   ((idmat @ c) (-: clean) (unmhrlrn (ct @ unghrl)) @ gehrdl) A
NB.   ((idmat @ c) (-: clean) (unmhrlrc (ct @ unghrl)) @ gehrdl) A
NB.
NB. Notes:
NB. - implements LAPACK's DORMHR, ZUNMHR
NB. - instead of using f and s parameters, the following
NB.   product is really calculating:
NB.     Q = Π{H(i),i=0:n-1} ,
NB.   where
NB.     H(0:f-1) = H(f+s-1:n-1) = I .
NB.   This approach delivers excessive calculations in rare
NB.   case ((f>0) OR (f+s<n)).

unmhruln=: (unmqrln~ (0 _1 & (|. !. 0)))~
unmhrulc=: (unmqrlc~ (0 _1 & (|. !. 0)))~
unmhrurn=: (unmqrrn~ (0 _1 & (|. !. 0)))~
unmhrurc=: (unmqrrc~ (0 _1 & (|. !. 0)))~

NB. =========================================================
NB. Test suite

NB. ---------------------------------------------------------
NB. testunmq
NB.
NB. Description:
NB.   Test Q multiplication qf-algorithms by general matrix
NB.   given
NB.
NB. Syntax:
NB.   testunmq (A;C)
NB. where
NB.   A - m×n-matrix, is used to get Qf
NB.   C - m×n-matrix, is used as multiplier
NB.
NB. Formula:
NB. - for LQ:
NB.   - for Q * C  : berr := ||Q * C   - Q * C  || / (ε * ||C|| * s)
NB.   - for Q^H * C: berr := ||Q^H * C - Q^H * C|| / (ε * ||C|| * s)
NB.   - for C * Q  : berr := ||C * Q   - C * Q  || / (ε * ||C|| * s)
NB.   - for C * Q^H: berr := ||C * Q^H - C * Q^H|| / (ε * ||C|| * s)
NB. - for QL:
NB.   - for Q * C  : berr := ||Q * C   - Q * C  || / (ε * ||C|| * m)
NB.   - for Q^H * C: berr := ||Q^H * C - Q^H * C|| / (ε * ||C|| * m)
NB.   - for C * Q  : berr := ||C * Q - C * Q    || / (ε * ||C|| * m)
NB.   - for C * Q^H: berr := ||C * Q^H - C * Q^H|| / (ε * ||C|| * m)
NB. - for QR:
NB.   - for Q * C  : berr := ||Q * C   - Q * C  || / (ε * ||C|| * m)
NB.   - for Q^H * C: berr := ||Q^H * C - Q^H * C|| / (ε * ||C|| * m)
NB.   - for C * Q  : berr := ||C * Q - C * Q    || / (ε * ||C|| * m)
NB.   - for C * Q^H: berr := ||C * Q^H - C * Q^H|| / (ε * ||C|| * m)
NB. - for RQ:
NB.   - for Q * C  : berr := ||Q * C   - Q * C  || / (ε * ||C|| * n)
NB.   - for Q^H * C: berr := ||Q^H * C - Q^H * C|| / (ε * ||C|| * n)
NB.   - for C * Q  : berr := ||C * Q   - C * Q  || / (ε * ||C|| * n)
NB.   - for C * Q^H: berr := ||C * Q^H - C * Q^H|| / (ε * ||C|| * n)

testunmq=: 3 : 0
  'A C'=. y
  rcond=. ((_."_)`gecon1 @. (=/@$)) C  NB. meaninigful for square matrices only
  'LQf QfL QfR RQf'=. xQf=. (gelqf ; geqlf ; geqrf ; gerqf) A
  'Qlq Qql Qqr Qrq'=. (((unglq~ (<:@c))&.>)`((ungql~ (<:@#))&.>)`((ungqr~ (<:@#))&.>)`((ungrq~ (<:@c))&.>)) ag xQf

  ('unmlqln' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp~ & >/)@}.))~)) % (FP_EPS*((norm1*c)@(1 {:: [))))))) (LQf;(ct C);    Qlq )
  ('unmlqlc' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp~ & >/)@}.))~)) % (FP_EPS*((norm1*c)@(1 {:: [))))))) (LQf;(ct C);(ct Qlq))
  ('unmlqrn' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp  & >/)@}.))~)) % (FP_EPS*((norm1*c)@(1 {:: [))))))) (LQf;    C ;    Qlq )
  ('unmlqrc' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp  & >/)@}.))~)) % (FP_EPS*((norm1*c)@(1 {:: [))))))) (LQf;    C ;(ct Qlq))

  ('unmqlln' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp~ & >/)@}.))~)) % (FP_EPS*((norm1*#)@(1 {:: [))))))) (QfL;    C ;    Qql )
  ('unmqllc' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp~ & >/)@}.))~)) % (FP_EPS*((norm1*#)@(1 {:: [))))))) (QfL;    C ;(ct Qql))
  ('unmqlrn' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp  & >/)@}.))~)) % (FP_EPS*((norm1*#)@(1 {:: [))))))) (QfL;(ct C);    Qql )
  ('unmqlrc' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp  & >/)@}.))~)) % (FP_EPS*((norm1*#)@(1 {:: [))))))) (QfL;(ct C);(ct Qql))

  ('unmqrln' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp~ & >/)@}.))~)) % (FP_EPS*((norm1*#)@(1 {:: [))))))) (QfR;    C ;    Qqr )
  ('unmqrlc' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp~ & >/)@}.))~)) % (FP_EPS*((norm1*#)@(1 {:: [))))))) (QfR;    C ;(ct Qqr))
  ('unmqrrn' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp  & >/)@}.))~)) % (FP_EPS*((norm1*#)@(1 {:: [))))))) (QfR;(ct C);    Qqr )
  ('unmqrrc' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp  & >/)@}.))~)) % (FP_EPS*((norm1*#)@(1 {:: [))))))) (QfR;(ct C);(ct Qqr))

  ('unmrqln' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp~ & >/)@}.))~)) % (FP_EPS*((norm1*c)@(1 {:: [))))))) (RQf;(ct C);    Qrq )
  ('unmrqlc' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp~ & >/)@}.))~)) % (FP_EPS*((norm1*c)@(1 {:: [))))))) (RQf;(ct C);(ct Qrq))
  ('unmrqrn' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp  & >/)@}.))~)) % (FP_EPS*((norm1*c)@(1 {:: [))))))) (RQf;    C ;    Qrq )
  ('unmrqrc' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp  & >/)@}.))~)) % (FP_EPS*((norm1*c)@(1 {:: [))))))) (RQf;    C ;(ct Qrq))

  EMPTY
)

NB. ---------------------------------------------------------
NB. testunmhr
NB.
NB. Description:
NB.   Test Q multiplication hrd-algorithms by square general
NB.   matrix given
NB.
NB. Syntax:
NB.   testunmhr (A;C)
NB. where
NB.   A - n×n-matrix, is used to get Qf
NB.   C - n×n-matrix, is used as multiplier
NB.
NB. Formula:
NB. - for lower HRD:
NB.   - for Q * C  : berr := ||Q * C   - Q * C  || / (ε * ||C|| * n)
NB.   - for Q^H * C: berr := ||Q^H * C - Q^H * C|| / (ε * ||C|| * n)
NB.   - for C * Q  : berr := ||C * Q   - C * Q  || / (ε * ||C|| * n)
NB.   - for C * Q^H: berr := ||C * Q^H - C * Q^H|| / (ε * ||C|| * n)
NB. - for upper HRD:
NB.   - for Q * C  : berr := ||Q * C   - Q * C  || / (ε * ||C|| * m)
NB.   - for Q^H * C: berr := ||Q^H * C - Q^H * C|| / (ε * ||C|| * m)
NB.   - for C * Q  : berr := ||C * Q   - C * Q  || / (ε * ||C|| * m)
NB.   - for C * Q^H: berr := ||C * Q^H - C * Q^H|| / (ε * ||C|| * m)

testunmhr=: 3 : 0
  'A C'=. y
  rcond=. gecon1 C
  'HlQf HuQf'=. xQf=. ((gehrdl~ (0,#)) ; (gehrdu~ (0,c))) A
  'Qhrl Qhru'=. ((unghrl&.>)`(unghru&.>)) ag xQf

  ('unmhrlln' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp~ & >/)@}.))~)) % (FP_EPS*((norm1*c)@(1 {:: [))))))) (HlQf;(ct C);    Qhrl )
  ('unmhrllc' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp~ & >/)@}.))~)) % (FP_EPS*((norm1*c)@(1 {:: [))))))) (HlQf;(ct C);(ct Qhrl))
  ('unmhrlrn' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp  & >/)@}.))~)) % (FP_EPS*((norm1*c)@(1 {:: [))))))) (HlQf;    C ;    Qhrl )
  ('unmhrlrc' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp  & >/)@}.))~)) % (FP_EPS*((norm1*c)@(1 {:: [))))))) (HlQf;    C ;(ct Qhrl))

  ('unmhruln' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp~ & >/)@}.))~)) % (FP_EPS*((norm1*#)@(1 {:: [))))))) (HuQf;(ct C);    Qhru )
  ('unmhrulc' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp~ & >/)@}.))~)) % (FP_EPS*((norm1*#)@(1 {:: [))))))) (HuQf;(ct C);(ct Qhru))
  ('unmhrurn' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp  & >/)@}.))~)) % (FP_EPS*((norm1*#)@(1 {:: [))))))) (HuQf;    C ;    Qhru )
  ('unmhrurc' tdyad ((0 & {::)`(1 & {::)`]`(rcond"_)`(_."_)`(((norm1@((- ((mp  & >/)@}.))~)) % (FP_EPS*((norm1*#)@(1 {:: [))))))) (HuQf;    C ;(ct Qhru))

  EMPTY
)

NB. ---------------------------------------------------------
NB. testmq
NB.
NB. Description:
NB.   Adv. to make verb to test unmxxxxx by matrix of
NB.   generator and shape given
NB.
NB. Syntax:
NB.   vtest=. mkmat testmq
NB. where
NB.   mkmat - monad to generate a matrix; is called as:
NB.             mat=. mkmat (m,n)
NB.   vtest - monad to test algorithms by matrix mat; is
NB.           called as:
NB.             vtest (m,n)
NB.   (m,n) - 2-vector of integers, the shape of matrix mat
NB.
NB. Application:
NB. - test by random rectangular real matrix with elements
NB.   distributed uniformly with support (0,1):
NB.     ?@$&0 testmq_mt_ 200 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     (_1 1 0 4 _6 4 & gemat_mt_) testmq_mt_ 200 200
NB. - test by random rectangular complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) testmq_mt_ 150 200

testmq=: 1 : 'EMPTY_mt_ [ (testunmhr_mt_ ^: (=/@$@(0&({::))) [ testunmq_mt_) @ (u ; u)'
