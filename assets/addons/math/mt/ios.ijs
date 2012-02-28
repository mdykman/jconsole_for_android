NB. IOS
NB.
NB. liofmax    lIO 1st element with maximum sum of real and
NB.            imagine parts' modules
NB. liolmax    lIO last element with maximum sum of real and
NB.            imagine parts' modules
NB. th2lios    Generate lIOS from tail and head
NB. dhs2lios   Generate lIOS from head, size and optional
NB.            delta
NB. rios2ios   Convert rIOS to IOS
NB. rios2lios  Convert rIOS to lIOS
NB. liosX      lIOS of vector laying between diagonal and
NB.            matrix edge
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
NB. Concepts
NB.
NB. IO   - index of
NB. lIO  - linear IO, is an integer
NB. IOS  - indices of
NB. lIOS - linear IOS, is a vector of integers
NB. rIOS - rectangular IOS, for r-rank array is a 2×r-array
NB.        of integers ((head0,head1,...),:(size0,size1,...))
NB.
NB. Following are equivalents:
NB.   (3 5 _7,:2 _3 4) (] ;. 0) report
NB.   (< 3 4;7 6 5;_10 _9 _8 _7) { report
NB.   (rios2ios (3 5 _7,:2 _3 4)) { report
NB.   (ios2rios (< 3 4;7 6 5;_10 _9 _8 _7)) (] ;. 0) report
NB.
NB. Following are equivalents:
NB.   (0 1 ; 1 2 ; 2 3) { i. 3 4
NB.   (4 lios2ios 1 6 11) { i. 3 4
NB.   (4 ios2lios (0 1 ; 1 2 ; 2 3)) ({,) i. 3 4
NB.   1 6 11 ({,) i. 3 4

NB. =========================================================
NB. Local definitions

NB. convert rIOS to opened (non-boxed) IOS
rios2oios=: <@dhs2lios/"1@:|:

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. Miscellaneous

NB. lIO 1st element e with max(|Re(e)|+|Im(e)|) from list y
NB. implements BLAS's IxAMAX
liofmax=: (i.>./)@sorim

NB. lIO last element e with max(|Re(e)|+|Im(e)|) from list y
liolmax=: (i:>./)@sorim

NB. ---------------------------------------------------------
NB. th2lios
NB.
NB. Description:
NB.   Generate lIOS from tail and head
NB.
NB. Syntax:
NB.   lios=. t th2lios h
NB. where
NB.   h    - integer, head of lios
NB.   t    - integer, tail of lios
NB.   lios - (x-y)-vector of integers, lIOS from head h to
NB.          tail (t-1) with delta=1:
NB.            h (h+1) ... (t-1)
NB.
NB. Notes:
NB. - monadic case is possible, though awkward:
NB.     _3 _2 _1 -: th2lios _3
NB.     5 4 3    -: th2lios  3

th2lios=: ] + i.@-

NB. ---------------------------------------------------------
NB. dhs2lios
NB.
NB. Description:
NB.   Generate lIOS from head, size and optional delta
NB.
NB. Syntax:
NB.   lios=. [d] dhs2lios (h,s)
NB. where
NB.   h    - integer, head of lios, if h<0 then lios is
NB.          pointed to h, otherwise away from h
NB.   s    - integer, size of lios, if s<0 then lios's order
NB.          is reversed
NB.   d    - optional non-negative integer, delta of lios,
NB.          default is 1
NB.   lios - |s|-vector of integers
NB.
NB. Examples:
NB.    2 dhs2lios 4 3                 2 dhs2lios _4 3
NB. 4 6 8                          _8 _6 _4
NB.    2 dhs2lios 4 _3                2 dhs2lios _4 _3
NB. 8 6 4                          _4 _6 _8
NB.
NB. Notes:
NB. - monadic case models rIOS in (u;.0) with following
NB.   difference: s cannot be ±∞

dhs2lios=: 1&$: :({.@] + (negneg~ {.) * i.@(negneg/)@])

NB. ---------------------------------------------------------
NB. rios2ios
NB.
NB. Description:
NB.   Convert rIOS to IOS
NB.
NB. Syntax:
NB.   ios=. rios2ios rios
NB.
NB. Notes:
NB. - rios with columns count less than array's rank is
NB.   indexing the slice

rios2ios=: <"1@rios2oios

NB. ---------------------------------------------------------
NB. rios2lios
NB.
NB. Description:
NB.   Convert rIOS to lIOS
NB.
NB. Syntax:
NB.   lios=. sh rios2lios rios
NB. where
NB.   rios  - 2×r-array of integers, rIOS of subarray:
NB.             (2,r) $ from[0:r-1],size[0:r-1]
NB.   sh    - r-array of integers, shape of array to explore:
NB.             Size[0:r-1]
NB.   lios  - |Π{size[i],i=0:r-1}|-array of integers, rowwise
NB.           lIOS of subarray elements
NB.   r     ≥ 0, integer, rank of array to explore
NB.
NB. Formula:
NB.   lios[k] := Σ{Π{Size[j],j=i+1:r-1}*(n[k][i]-(n[k][i+1]<0 ? 1 : 0)),i=0:r-2} + n[k][r-1]
NB. where
NB.   k       = 0:|Π{size[i],i=0:r-1}|-1, IO lios' item
NB.   n[k][i] - i-th axis' IO for k-th lios' item
NB.
NB. Assertions:
NB.   (lios ({,) array) -: (rios (, ;. 0) array)
NB. where
NB.   rios=. 2 4 $ 7 _3 7 _3 2 2 _2 _2
NB.   sh=. 10 11 12 13
NB.   array=. i. sh
NB.   lios=. sh rios2lios rios

rios2lios=: */\.@(1&(|.!.1))@[ +/@:* (+ 1&(|.!.0)@(0&>))@|:@:>@,@{@rios2oios@]

NB. ---------------------------------------------------------
NB. liosE
NB. liosN
NB. liosS
NB. liosW
NB.
NB. Description:
NB.   lIOS of vector laying between diagonal and matrix edge
NB.   in any of one cardinal direction: east, north, south or
NB.   west; and having optional gap between diagonal, at head
NB.   or tail
NB.
NB. Syntax:
NB.   vapp=. gap liosX
NB. where
NB.   liosX - adv., any of: liosE liosN liosS liosW
NB.   gap   - integer, negative value means "from
NB.           head", otherwise "from tail"
NB.   vapp  - dyad to return lios; is called as:
NB.             lios=. l vapp n
NB.   lios  - l-vector of integers, lIOS of v in ravelled A
NB.   v     - l-vector from A:
NB.             v -: lios ({,) A
NB.   A     - m×n-matrix
NB.
NB. Examples:
NB.    '***' ((((0 liosE)&c) }),.' ',.(((1 liosE)&c) }),.' ',.(((_1 liosE)&c) })) 5 6$'-'
NB. ------ ------ ------
NB. ------ --***- ---***
NB. ---*** ------ ------
NB. ------ ------ ------
NB. ------ ------ ------
NB.    '***' ((((0 liosN)&c) }),.' ',.(((1 liosN)&c) }),.' ',.(((_1 liosN)&c) })) 5 6$'-'
NB. --*--- ---*-- ------
NB. --*--- ---*-- ---*--
NB. --*--- ---*-- ---*--
NB. ------ ------ ---*--
NB. ------ ------ ------
NB.    '***' ((((0 liosS)&c) }),.' ',.(((1 liosS)&c) }),.' ',.(((_1 liosS)&c) })) 5 6$'-'
NB. ------ ------ ------
NB. ------ --*--- ------
NB. ---*-- --*--- --*---
NB. ---*-- --*--- --*---
NB. ---*-- ------ --*---
NB.    '***' ((((0 liosW)&c) }),.' ',.(((1 liosW)&c) }),.' ',.(((_1 liosW)&c) })) 5 6$'-'
NB. ------ ------ ------
NB. ------ ------ ------
NB. ***--- ------ ------
NB. ------ ***--- -***--
NB. ------ ------ ------

liosE=: 1 : 'dhs2lios_mt_@(((_1-0>.m)- (*((<:|m)&+))~),[)'
liosW=: 1 : 'dhs2lios_mt_@(((   0<.m)-~(*((<:|m)&+))~),[)'

liosN=: 1 : ']dhs2lios_mt_(((-~((<:|m)&+))~(*&(0<.m))),[)'
liosS=: 1 : ']dhs2lios_mt_(((-~((- |m)&-))~(*&(0>.m))),[)'
