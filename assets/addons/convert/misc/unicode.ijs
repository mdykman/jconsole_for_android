NB. convert/misc/unicode
NB. Unicode utilities
NB. version: 1.0.1
NB.
NB. unicode
NB.
NB. isutf8     check if text is valid UTF-8
NB. isutf8x    extended version of isutf8
NB. toutf8     convert text to UTF-8
NB. ucpindex   convert utf8 index to code point index
NB. ucpmatch   convert utf8 match to code point match
NB.
NB. See also definitions in stdlib.ijs:
NB. ucp        7&u:  convert to wchar
NB. utf8       8&u:  convert to UTF-8
NB. ucpcount   counts number of unicode code points (glyphs) in a string.

cocurrent 'z'

NB. =========================================================
NB.*isutf8 v check if text is valid UTF-8
NB. returns 1 or 0
isutf8=: (2=3!:0) *. 1:@(7&u:) :: 0:

NB. =========================================================
NB.*isutf8x v check if text is valid UTF-8
NB. returns: 1 = success
NB.      or: 0, position of first error
isutf8x=: 3 : 0
if. isutf8 y do. 1 return. end.
ndx=. #: a.i.y
pos=. 0
while.
  ind=. ({."1 ndx) i. 1
  pos=. pos + ind
  ndx=. ind }. ndx do.
  if. (1 < #ndx) *. 1 1 0 -: 3 {. 0 { ndx do.
    if. 1 0 -: 2 {. 1 { ndx do.
      ndx=. 2 }. ndx
      pos=. pos + 2
    else.
      0,pos return.
    end.
  elseif. (2 < #ndx) *. 1 1 1 0 -: 4 {. {. ndx do.
    if. 1 0 1 0 -: , (<1 2;0 1) { ndx do.
      ndx=. 3 }. ndx
      pos=. pos + 3
    else.
      0,pos return.
    end.
  elseif. do.
    0,pos return.
  end.
end.
0,pos
)

NB. =========================================================
NB.*toutf8 v convert text to UTF-8
NB.
NB. y may be:
NB.   valid utf8 - returned unchanged
NB.   wchar (2-byte characters)
NB.   text prefixed with UTF-8 byte order mark
NB.   text prefixed with UTF-16 little endian byte order mark
NB.   ISO 8859-1 (Latin-1) codepage
toutf8=: 3 : 0
if. 131072 = 3!:0 y do. 8 u: y return. end.
NB. u8 marker:
if. (239 187 191 { a.) -: 3 {. y do.
  3 }. y
NB. u16 marker:
elseif. (255 254 { a.) -: 2 {. y do.
  8 u: 6 u: 2 }. y
NB. 8859-1 codepage:
elseif. do.
  if. isutf8 y do. y return. end.
  val=. a. i. y
  msk=. 127 < val
  uni=. 192 128 +"1 [ 0 64 #: msk # val
  val=. val #~ 1 j. msk
  ndx=. I. 127 < val
  a. {~ uni (ndx +/ 0 1) } val
end.
)

NB. =========================================================
NB.*ucpindex v convert utf8 index to code point index
NB.
NB. convert indices into a UTF-8 string, into character (code point) indices
NB. x = indices
NB. y = UTF-8 string
NB.
NB. For example:
NB.   A=: '沒有沒abc漢語123漢語'
NB.   [B=: I. '漢語' E. A
NB. 12 21
NB.   B ucpindex A
NB. 6 11
ucpindex=: 4 : 0
ndx=. ,x
nub=. /:~ ~.ndx
msk=. 1, }: 1 nub } (1+#y)$0
len=. msk #@(7&u:);.1 'a',y
($x) $ (nub i. ndx) { <: +/\ len
)

NB. =========================================================
NB.*ucpmatch v convert utf8 match to code point match
NB.
NB. convert matches into a UTF-8 string, into character (code point) matches
NB. x = matches
NB. y = UTF-8 string
NB.
NB. Here, a match is a pair: position, length, or an array of such pairs,
NB. as in the result of regex rxmatch or rxmatches.
NB.
NB. For example:
NB.    A=: '沒有沒abc漢語123漢語'
NB.    [B=: '漢語' rxmatches A
NB. 12 6
NB.
NB. 21 6
NB.    B ucpmatch A
NB.  6 2
NB.
NB. 11 2
ucpmatch=: 4 : 0
+/\^:_1"1 (+/\"1 x) ucpindex y
)
