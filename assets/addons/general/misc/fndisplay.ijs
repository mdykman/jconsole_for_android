NB. general/misc/fndisplay.ijs
NB. Display hooks, forks and other syntax elements
NB. version: 1.0.0
NB.
NB. This script allows you to see how hooks, forks, and other
NB. structural elements affect the order of processing verbs.
NB.
NB. First, select the kind of display you want with 'setfnform'.
NB. The operands are 'math' (display like f(x,y)), 'J' (display
NB. like  x f y), and 'Jv' (like J, but monads are followed by '_'
NB. and dyads are preceded and followed by '_').  Example:
NB.    setfnform 'math'
NB.
NB. Then, define the verb-names you want to use:
NB.    defverbs 'f g h'
NB.
NB. Finally, define any names you want to use for nouns:
NB.    defnouns 'x y'
NB.
NB. Then, entering combinations of your verbs and nouns will
NB. show you how the combinations will be executed.
NB. By default a verb has infinite rank; you can append "r to
NB. a verb-name in defverbs to assign the rank r to the verb.
NB. Example:
NB.    x f&.g y
NB. +----------------+
NB. |g`(f(g(x),g(y)))|
NB. +----------------+
NB. where g` means the inverse of g.
NB.
NB.
NB. This script implements a proposal made by Kirby Urner.
NB. Henry H. Rich (glasss@bellsouth.net), September 2002

NB. =========================================================
NB.*setfnform v-- select template to use for displaying a function
NB. Example: setfnform 'math'
NB. y is 'math','J', or 'Jv'
NB.    if 'math', functions are f(y), f(x,y) and inverses f`(y), f`(x,y)
NB.    if 'J', functions are f y, x f y  and inverses f` y, x f` y
NB.    if 'Jv', functions are f_ y, x _f_ y and inverses fI_ y, x _fI_ y
NB. Or, the individual elements of the display can be specified:
NB. y is (monadic form);(dyadic form);(monadic inverse form);(dyadic inverse form)
NB. Where, in each, 'x' will be replaced by the x operand,
NB.   'y' by the y operand, and 'f' by the function name
setfnform =: 3 : 0
if. 2 = 3!:0 y do.
  select. y
    case. 'math' do. y =. 'f(y)';'f(x,y)';'f`(y)';'f`(x,y)'
    case. 'J' do. y =. 'f y';'x f y';'f` y';'x f` y'
    case. 'Jv' do. y =. 'f_ y';'x _f_ y';'fI_ y';'x _fI_ y'
    case. do. 'Invalid format selection' 13!:8 (3)
  end.
end.
verbtemplate =: y
0 0$0
)

NB. =========================================================
defverbs =: (0 0$0)"_ @: (3 : 0 @ >) @: (<;._1 @: (' '&,) ^:(2: = 3!:0))
prerank =. '"' taketo y
if. (<prerank) e. ,each 'xy' do.
  'Names x and y are not permitted as verb names' return.
end.
rank =. _ ". '_'&[^:(0:=#) '"' takeafter y
(prerank) =: (prerank defverb 0 " rank) :. (prerank defverb 2)
''
)

NB. =========================================================
NB.*defverbs v-- define names of verbs for function display
NB. Example: defverbs 'f g h sin cos'
NB. The verb name may be followed by "rank
NB. names x and y are not permitted here
defverbs =: 3 : 0
if. L.y do.
  nms=. y
else.
  nms=. <;._1 ' ',y
end.
r=. ;~.defverbs1 each nms
if. 0=#r do. i.0 0 end.
)

NB. =========================================================
defverbs1=: 3 : 0
prerank =. '"' taketo y
if. (<prerank) e. ,each 'xy' do.
  'Names x and y are not permitted as verb names' return.
end.
rank =. _ ". '_'&[^:(0:=#) '"' takeafter y
(prerank) =: (prerank defverb 0 " rank) :. (prerank defverb 2)
''
)


NB. =========================================================
NB. verbtemplate is (monadic form);(dyadic form);(monadic inverse form);(dyadic inverse form)
NB. u is name of function, v is 0 for fn, 2 for inverse
NB. x and y are arguments
defverb =: 2 : 0
if. 1 < #$ cy =. ": >y do. cy =. (":$y),'$',, (') ' ,~ '(' , ])"1 cy end.
rp =. 'y';cy;'f';u
< (v {:: verbtemplate) rplc rp
:
if. 1 < #$ cx =. ": >x do. cx =. (":$x),'$',, (') ' ,~ '(' , ])"1 cx end.
if. 1 < #$ cy =. ": >y do. cy =. (":$y),'$',, (') ' ,~ '(' , ])"1 cy end.
if. ' 'e.,cx do. cx =. '(',cx,')' end.
rp =. 'x';cx;'y';cy;'f';u
< ((>:v) {:: verbtemplate) rplc rp
)

NB. =========================================================
NB.*defnouns v-- define names of nouns for function display
NB. Example: defnouns 'f g h sin cos'
NB.
NB. y is noun names, either as string of words (e. g. 'a b cd')
NB.  or a list of boxes (e. g. 'a';'b';'cd')
NB. Each noun is defined as a boxed character string whose value equals its name
defnouns =: 3 : 0
nms=. ;: :: ] y
txt=. > nms ,each (<'=: ''') ,each nms ,each ''''
3 : '". y [ 4!:55<''y''' txt
i. 0 0
)
