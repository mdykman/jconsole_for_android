NB. printf
NB.
NB. Functions to emulate C printf, sprintf, with added support for:
NB.
NB.   verbs in the field specifier, applied before formatting;
NB.   'j' field type, which means J default formatting;
NB.   'J' field type, default formatting, converting any rank to
NB.    rank-1 display;
NB.   'S' field type, which accepts a boxed list
NB.
NB. Also, the verb 'putdata' for fast disply of debugging data
NB.
NB. 'Using sprintf saves me %?*&100?d%% of my time every %s.\n' sprintf 0.05;'day'
NB.   returns a result of
NB.   'Using sprintf saves me 5% of my time every day.', CR, LF
NB.   (the CR is omitted on UNIX)
NB.
NB. Fields in the string x (scanned left-to-right) are replaced
NB.   by the printable form of the corresponding items of the list y
NB.   (items of y are opened before they are converted).
NB.
NB. The type may be preceded by ?verb? in which case the verb is applied
NB.   to the opened item before the rest of the processing is performed
NB.   (sprintf will apply the verb in the jprintf locale; the verb
NB.   created by vsprintf will apply the verb in whatever locale it is
NB.   defined in)
NB.
NB. An opened item of y may be a list.  In that case, for numeric
NB.   fields, each item of the list is converted using the precision
NB.   and flags; the results are concatenated with one space between them,
NB.   and the field width is applied to the concatenated result.
NB.   The %s field does not allow a boxed-list operand, but %S,
NB.   which is otherwise identical to %s, does: the elements of the
NB.   boxed list are opened and formatted using monad ": ; the results are
NB.   concatenated with one space between them, and the field width
NB.   is applied to the concatenated result.
NB.
NB. Format strings may be compiled using cprintf, which results in
NB.   a boxed format descriptor.  The result of cprintf may be supplied
NB.   as the left argument to sprintf.  This saves parsing time and is
NB.   recommended for formats that will be used often.
NB.
NB. For more speed, use the adverb vsprintf.  (format_string vsprintf)
NB.   produces a verb which, when executed, has the same effect as
NB.   (format_string&sprintf) but with minimal overhead.  For the
NB.   very fastest verb, use field type 'j'.  The derived verb is rank 1
NB.   if there is more than 1 field, rank 0 otherwise
NB.
NB. For maximum speed on rank-(2 or higher) arguments, use the adverb
NB.   vbsprintf.  (format_string vbsprintf) produces a verb which, when
NB.   executed, has the same effect as <@(format_string&sprintf)
NB.   (i. e. the string results are boxed and returned as a list).
NB.   The derived verb is rank 2 if there is more than 1 field, rank
NB.   1 otherwise, and produces one boxed string for each item.
NB.
NB. C backslash escapes are emulated.  '\' in a string followed by
NB.   't' 'b' 'r' 'f' '\' or '''' is replaced by
NB.   TAB BS  CR  VT  \      '     respectively.
NB.   In addition, '\l' is replaced by LF, and '\n' is replaced
NB.   by CRLF on Windows, LF on UNIX.
NB.   \nnn (octal escapes) are supported.
NB.
NB. Supported field types: d u o x X f e E g G s S c j J
NB.   If the field character is none of those, the results are unpredictable.
NB.   %% gives a '%' character.
NB.
NB. Field format is %[flags][width][.precision][?verb?]type
NB.
NB. Width is the minimum field width (default 0): the field will always
NB.   be extended as wide as necessary to display the information
NB.
NB. Precision gives: for integer conversions, the minimum number of
NB.   digits displayed - leading digits may be 0 (default 1); for
NB.   real conversions, the number of fractional digits after the
NB.   decimal point (default 6); for string conversions, the maximum
NB.   length of the string (default _)
NB.
NB. Flags may be '#' '-' '^' '+' ' ', which give additional controls.
NB.   # causes o fields to be prefixed by '0', x fields by '0x', X fields
NB.     by '0X'
NB.   '-' causes result to be left-aligned in the field rather than the default right
NB.   '^' causes result to be centered in the field
NB.   '+' causes signed fields to be prefixed with '+' if nonnegative
NB.   ' ' causes signed fields to be prefixed with ' ' if nonnegative
NB.   '0' causes a numeric result to be filled with 0 to the width of the field
NB.     (overriding an integer precision, if given)
NB.
NB. The verb, if given, is applied to the opened element of y before any further
NB.   processing for the field
NB.
NB. The meanings of the fields are: d decimal, u unsigned, o octal, x hex, X HEX,
NB.   f real, e scientific form nnemm, E scientific form nnEmm, g f or e based on size,
NB.   G f or E based on size, s string, S string or boxed list, c character,
NB.   j J default format (":), J J default format (":), and if result has rank > 1,
NB.   flatten to rank 1 with newlines between items
NB.
NB. Henry H. Rich (glasss@bellsouth.net), June 2001
NB.
NB. Changes 2001/05/18: speed up %s, drop support for lists from %s, add %S
NB.              to handle lists, make rank of vsprintf 0 or 1 depending
NB.              on # of fields, create vbsprintf, improve AR utilities
NB. Changes 2001/06/25: add routine qprintf, add %J

coclass 'jprintf'
thislocale=: '_' , (> 18!:5 '') , '_'

display=: (i.0 0)"_ ((1!:2) 2:)
ocol=: >@:({"1)
ux_vy=: 2 : '(y~ x)~'
butifnull=: 2 : 'v"_`u@.(*@#@])'

NB.*cprintf v-- apply break format descriptor into fields
NB. Example: cprintf 'Time was %d'

NB. y is format string, result is string broken into fields:
NB. < fixedstrings ,&< conversions
NB.   where conversions are a list of gerunds, conversion&verb:
NB.   conversion is
NB.   typeid,width,precision,centerspec,posfmt,altfmt
NB.     centerspec is 0 (right), 1 (left), 2 (center)
NB.     posfmt is 0 (no char), 1 ('+'), 2 (' ')
NB.     altfmt is 1 if the 'alternate formatting' is requested
NB.
cprintf=: 3 : 0
NB. Fields start with '%', except that '%%' is treated as a single
NB. '%' in the data.  So, we find the location of %, and also
NB. which ones are even-numbered positions in strings of % characters
evp=. 2 b. /\.&.|. p=. '%' = y
NB. The escaped % are the even ones that are followed by %.  Get a mask for
NB. all characters EXCEPT these
nep=. evp *: 1|.!.0 p
NB. Now save the characters before the first field, and then analyze each
NB. field.  Assemble all the character strings followed by the gerunds
< evp (i.&1 ux_vy (<@cescape@{.) ((, {."1) ,&< ({:"1)@]) fmtfld;._1)&(nep&#) y
)

NB. Manifests
NB. On UNIX, \n is LF; on Windows, CRLF
newline=: a. {~ 13 10 }.~ 3 5 e.~ 9!:12 ''
NB. We add the escape \l to mean linefeed
escchars=: 'nltbrf\'''
escxlate=: newline;(10{a.);(9{a.);(8{a.);(13{a.);(12{a.);'\';''''

NB. y is a escaped character string (with the leading backslash omitted)
NB. Result is the string with the escape sequence replaced
applyesc=. 3 : 0
if. 1 > #y do. '' return. end.
if. (t=. 0 { y) e. escchars do.
NB. non-octal escape chars
  ((escchars i. t) {:: escxlate) , 1 }. y return.
end.
NB. The rest is for octal escapes: \n, \nn, \nnn, using up to 3 octal digits
if. -. t e. '01234567' do. y return. end.
if. -. '01234567' e.~ 1 }. 2 {. y do.
  (a. {~ 8 #. '01234567' i. 1 {. y) , 1 }. y return.
end.
if. -. '01234567' e.~ 2 }. 3 {. y do.
  (a. {~ 8 #. '01234567' i. 2 {. y) , 2 }. y return.
end.
(a. {~ 8 #. '01234567' i. 3 {. y) , 3 }. y
)

NB. Handle C backslash-escaped fields.  Find backslashes that are
NB. even-numbered ones, cut on them, and analyze the escape character
NB. y is the string to analyze, result is escaped string.
NB. This is designed for max speed on strings that have no \ chars;
NB. we find the first '\', and then process the rest if there was one
evs=. 13 : '2 b. /\.&.|. ''\'' = y'
cescape=: ((({. , ;@:(evs <@applyesc;._1 ])@}.) ^: (< #))~ i.&'\') f.

NB. Atomic-representation utilities
NB. y is string name of verb, result is AR of verb
arverb=: <@,
NB. y is noun, result is AR of noun
arnoun=: <@((,'0')&(,&<))
NB. (adverb) m is conjunction, x is AR, y is AR
NB. Result is AR of x m y
arconj=: 1 : '<@((,&<~ ,)&m)@,"0'
NB. y is a list of 3 ARs, result is AR of their fork
arfork=: <@((,'3')&(,&:<))
NB. x is AR, y is AR, result is AR for (x y)
arhook=: <@((,'2')&(,&:<))@,"0

NB. Analyze a single field specification
NB. y is field plus following text (up to the next %), with no leading %
NB. result is (characters after the field);(gerund to execute)
NB.   The gerund is (descriptor&verb >) where the verb comes from
NB.     the type, and the descriptor is
NB.   typeid,width,precision,centerspec,posfmt,altfmt
NB.     centerspec is 0 (right), 1 (right with zero fill), 2 (center) , 3 (left)
NB.     posfmt is 0 (no char), 1 ('+'), 2 (' ')
NB.     altfmt is 1 if the 'alternate formatting' is requested
typechars=: 'duoxXfeEgGsScjJ'
precdefal=: 1 1 1 1 1 6 6 6 6 6 _ _ 1 _ _
flagchars=: '-^ +#0'
flagactions=: 3 0 0 , 2 0 0 , 0 2 0 , 0 1 0 , 0 0 1 ,: 1 0 0

NB. y is the string, which has been checked and is known to produce
NB. a dyadic field-processing gerund
fmt2fld=. 3 : 0
NB. Find the index of the type character, and extract the field (not including the type char)
fld=. (nfld=. y i.&1@:e. typechars,'?') {. y
NB. Classify the type character; but if we hit '?', extract the verb and then get the
NB. type character (which had better be valid, or we take index error when
NB. we look up the gerund).
NB. While we're at it, return the final result:  string , scalar gerund
if. (#typechars) = typex=. typechars i. type=. nfld { y do.
  fmtstg=. ({.~ i.&'?') (>:nfld)}.y
  typex=. typechars i. type=. (nfld=. 2 + nfld + #fmtstg) { y
else. NB. Normal return with no ?verb?
  fmtstg=. ''
end.
NB. Count the flags, and assemble the data vector for them
flgs=. 0 >. >./ flagactions {~ flagchars i. (nflgs=. 0 i.~ y e. flagchars) {. fld
NB. Find the end of the width field: '.' or the end of the field.  Default to 0
width=. 0&". '0' , nflgs }. (nwid=. fld i. '.') {. fld
NB. Find the precision: everything after the '.'
prec=. 0&". butifnull (typex { precdefal) (>: nwid) }. fld
NB. Return the final result:  string , scalar gerund
NB. Remove \ escapes from the string after the type character.  We wait till now
NB. so that '\' can be used inside the ?verb? field.  We build up the gerund by
NB. hand, as an atomic representation
NB. The main verb is 'format?' where '?' is the type character, EXCEPT for the
NB. 'j' type character, which is just ":.  For the J type, we don't bother with
NB. the left argument - it's not used anyway.  When we build the gerunds, we
NB. affix our locale name to them, so that they can be called via vsprintf, in
NB. any locale
NB. If width is nonzero, install the code to apply it
actar=. arverb 'format',type,thislocale  NB. the verb to use
if. #fmtstg do.  NB. ?verb? given, use (actionrtn verb)
  vb=. 13 : (fmtstg , ' y')
  actar=. actar arhook 5!:1 <'vb'
end.
if. width do. NB. width given, apply width limit
  actar=. arfork ('[' ,&arverb 'applywidth',thislocale),actar
end.
NB. Now append the precision information as x to the formatting
NB. verb, and return the field
(cescape (>:nfld)}.y) ; (arnoun typex,width,prec,flgs) ('&' arconj) actar
)

NB. For speed, we analyze the field in tacit form first to see if the
NB. length and width are omitted.  In that case, we produce a monadic
NB. verb; and %s and %j are replaced by ] and ": .
NB. Here for monad.  x is the type char, y is the rest of the string
fmt1fld=. ((,']')"_)`(('":')"_)`('format'&,@(,&thislocale))@.('sj'&i.) ux_vy (;~ cescape)
NB. y is the string, analyze and direct to monad or dyad production
fmtfld=: ( ((fmt2fld@])`(fmt1fld }.))@.(e.&typechars@[)~ {. ) butifnull ('';'') f.

NB.*vsprintf a-- Create a verb to apply formatting
NB. m is (possibly compiled) format descriptor, result is a monadic
NB.  verb that is equivalent to (m&sprintf).  The verb is designed to
NB.  be fast, especially if only %j and %s fields types are used.
NB. The rank of the resulting verb is 1 if there was more than 1 field,
NB.  otherwise 0
vsprintf=: 1 : 0
NB. Get the fixed strings and the field descriptors
'chars fields'=. > cprintf ^: (2: = 3!:0) m
NB. Convert the fixed strings to the atomic representation of string"_
chars=. ((('"' arconj)&arnoun)&_)@> chars
NB. Convert each verb gerund to the atomic representation of
NB. verb @ (n&{::) where n is the index of the verb...
if. 1 < #fields do.
  fields=. fields ('@' arconj (('&' arconj)&(arverb '{::'))@arnoun)"0 i.#fields
else.
NB. ...but, if there is no more than 1 field, use verb @ > , since
NB. the verb will have rank 0
  fields=. (('@' arconj)&(arverb '>'))"0 fields
end.
NB. Now interleave the character strings and the field gerunds, and
NB. delete any that were omitted (i. e. are for ''"_).  If there are
NB. no fields left, return the verb ''"0
if. 0 = # train=. (}:,chars,.fields,a:) -. (arnoun '') ('"' arconj) (arnoun _) do.
  train=. (arnoun '')
end.
NB. create a long train for all of them, with ',' verbs inserted in between.
NB. Return that as a verb
((arnoun 1 < #fields) ('"' arconj)~ arfork@(, (arverb ',')&,)/ train) 5!:0
)

NB.*vbsprintf a-- Create a verb to apply formatting, producing boxed strings
NB. m is (possibly compiled) format descriptor, result is a monadic
NB.  verb that is equivalent to (m&sprintf).  The verb is designed to
NB.  be very fast, especially if only %j and %s fields types are used, and
NB.  gives better performance than vsprintf when applied to a list.
vbsprintf=: 1 : 0
NB. Get the fixed strings and the field descriptors
'chars fields'=. > cprintf ^: (2: = 3!:0) m
NB. Now create the verb used to format the argument data.
NB. If all fields are %s fields, this becomes ] if more than 1 field,
NB. or ,"0 if 1, or (<'')"0 if none;
NB. If all the fields are %j or %s fields, this becomes simply
NB. ":&.> if there is more than 1 field, or ,"0@:(":&.>) if
NB. only one, or (<'')"0 if none; otherwise, we select the columns and apply the
NB. formatting verb to each one
if. 2 > maxx=. 0 >. >./ ]`": i. fields do.
  train=. (<maxx,2 <. #fields) { ((<'')"0)`(,"0)`] ,: ((<'')"0)`(,"0@:(":&.>))`(":&.>)
else.
NB. Convert each verb gerund to the atomic representation of
NB. verb&.> @: ((,n)&{"1) where n is the index of the verb -
NB. but if verb is field is ], don't bother with ]&.>
  if. 1 < #fields do.
    fieldsel=. (('"' arconj)&(arnoun 1))@(('&' arconj)&(arverb '{'))@arnoun@,"0 i.#fields
    train=. fields (('&.' arconj)&(arverb '>') ux_vy ('@:' arconj))^:(~:&(arverb ']')@[)"0 fieldsel
  else.
NB. ...but, if there is no more than 1 field, use ,"0@:(verb&.>).  There
NB. can't be 0 fields - we would have treated that as the %j case
    train=. (,"0`'')&('@:' arconj) @ (('&.' arconj)&(arverb '>')) "0 fields
  end.
end.
NB. Create the AR of the verb that will be used to select and format the data.
fmtvb=. arfork@(, (arverb ',.')&,)/ train
NB. Create the AR of the verb to append the fixed fields at the beginning of the formatted
NB. list.  This is fields&,"1.  We discard any fields that have no data; if there
NB. are no fields left, just skip the selection and the fixed fields
if. nflds=. +/ fldhasdata=. chars ~: <'' do.
  fldvb=. ((arnoun fldhasdata # chars) '&' arconj arverb ',') '"' arconj arnoun 1
NB. Create the AR of the selector verb for each row.  This is
NB. index&{"1 where index is the column numbers to be selected.  We assign the
NB. fixed fields with their numbers after null strings have been deleted
  selvec=. (fldhasdata,.1) #&(}:@,) (fldhasdata&#^:_1 i. nflds) ,. nflds + i. # chars
  selvb=. ((arnoun selvec) '&' arconj arverb '{') '"' arconj arnoun 1
else. fldvb=. selvb=. 0$a: end.

NB. Final result is <@;"1@:selvb@:fldvb@:fmtvb"(1 or 2)
NB. Return that as a verb
vb=: ('@:' arconj)~/ |. (('<' ('@' arconj)&arverb ';') '"' arconj arnoun 1),selvb,fldvb,fmtvb
(vb '"' arconj arnoun >: 1 < #fields) 5!:0
)

NB.*sprintf v-- insert fields into format descriptor
NB. x is (possibly compiled) format descriptor, y is list, one item for
NB.  each field in x .  Elements of y are unboxed and inserted in place of the
NB.  corresponding field
NB. Example: 'It took %d minutes to %S' sprintf 5 ;< 'play';3;'games'
sprintf=: (cprintf ^: (2: = 3!:0)) ux_vy (> ux_vy applyformat "0 1) "_

NB.*printf v-- apply sprintf, then type on console
NB. Example: 'It took %d minutes to %S' printf 5 ;< 'play';3;'games'
printf=: display@sprintf

NB.*qprintf v-- quick display
NB. y is string of labels/expressions.  The last character in y is a
NB.  delimiter; y is cut using this character to separate the
NB.  labels/expressions.  Within each label/expression, the last '?' character,
NB.  if any, separates the label from the expression.  If there is no
NB.  '?' character, the entire string is used as both the label and the
NB.  expression (with a trailing '=' appended to the label).
NB. x (optional) is string containing field specifiers (starting with %)
NB. Examples:
NB.    qprintf 'name1 name2 ' [ 'name1 name2'=.5 10
NB. name1=5 name2=10
NB.    qprintf 'vec >./vec {.vec ' [ vec =. 20 50 10
NB. vec=20 50 10 >./vec=50 {.vec=20
NB.    qprintf 'Time remaining: ?tr!%left: ?100*pct!ivbl!' [ 'tr pct ivbl' =. 20 0.2 5
NB. Time remaining: 20 %left: 20 ivbl=5
NB.    qprintf 'box1 box2 ' [ 'box1 box2' =. (<'555'),&< <'666'
NB. box1=
NB. +---+
NB. |555|
NB. +---+
NB.  box2=
NB. +---+
NB. |666|
NB. +---+

NB. This is defined as a tacit verb in the z locale so that it
NB. can be used anywhere to display local symbols
NB. Extract the fields from y, leave as a boxed list
fields=. (< ;.1~ =&'%')^:(32&~:@(3!:0))
NB. Extract the labels/expressions from y, leave as list of label;expression
NB. We search for '?' and create either the default string or the user's string
exprs=. ( ({. ; }.@}.)`((;~ ' '&,@(,&'='))@]) @. (= #)~ i:&'?' ) ;. _2
NB. x is fields, y is (label;expression)s.  Convert to
NB. label;field.  Double any % and \ characters in the
NB. label before adding them to the field.  If there is a leading space
NB. remaining from the first label, remove it.  Result is the
NB. printf template for the data
buildfmt=. }.^:(' '&=@{.) @ ; @ ((#~ >:@(e.&'%\'))&.>@:({."1)@] ,. ($~ #))
NB. Put it all together.
NB. Fix all the subroutines to avoid namespace pollution
qsprintf_z_=: (<'%J')&$: : (fields@[ f. (buildfmt f. sprintf ".&.>@:({:"1)@]) exprs@] f.)
qprintf_z_=: display f. @: qsprintf

NB. The field descriptor is
NB.   typeid,width,precision,centerspec,posfmt,altfmt
NB.     centerspec is 0 (right), 1 (right with zero fill), 2 (center) , 3 (left)
NB.     posfmt is 0 (no char), 1 ('+'), 2 (' ')
NB.     altfmt is 1 if the 'alternate formatting' is requested

NB. x is opened compiled format (list of fixed string ; gerund), y is data
NB. Apply the descriptors to the data; then interleave the plaintext
NB. strings with the results from the descriptors; raze the results to combine them
NB. into one output string
applyformat=: ;@(0&{::@[ ,. (,&(<''))@(1&{:: ux_vy exeformat))

NB. x is field descriptor  y is data  result is boxed string.
NB. Apply the width here, since that applies equally to all types
exeformat=: 4 : '(x`:6)&.> y'"0

NB. x is field descriptor  y is displayable result
NB. We lengthen the data if it is smaller than the minimum width,
NB. and handle the left/right/center/zerofill alignment.  For the case of
NB. zero-fill we must move any leading sign, + or -, to before the fill
NB. number of extra characters
surpluswidth=. 0: >. 1&{ ux_vy (- #)
NB. number of characters to put on left (y is surpluswidth, x is descriptor)
charsleft=. (1 1 0.5 0 {~ 3&{) ux_vy (<.@*)
NB. x is descriptor, y is result, result is left pad,right pad,pad selector (0=space, 1='0')
lrpad=. (1 = 3&{@[) ,~ [ (] (] , -) charsleft) surpluswidth
NB. Split the arg into sign/data (only if zero-fill)
applywidth=: ( lrpad (0&{::@] , (# {&' 0')/@(0 2&{)@[ , 1&{::@] , #&' '@(1&{)@[) ((1 = 3&{@[) * '+-' e.~ {.@]) ({. ; }.) ]) f.

NB. utilities
NB. x is min length, y is string, result is padded with zero on the left.  The count is a number of
NB. digits, so we don't include a leading minus sign (& we preserve it)
zeropad=. ({.~  '-' = {.)@] , ((#&'0'@(0: >. (- #)) , ]) }.^:('-'={.))
NB. y is number, result is octal form
convertoctal=. {&'01234567'@((_11&({.!.7)@])^:([<0:) (8&#.^:_1))
NB. y is number, result is hex form.  If number < 0, force 8 digits
converthex=. {&'0123456789abcdef'@((_8&({.!.15)@])^:([<0:) (16&#.^:_1))
NB. y is number, result is HEX form
convertHEX=. {&'0123456789ABCDEF'@((_8&({.!.15)@])^:([<0:) (16&#.^:_1))

NB. y is string, result is string with '_' replaced by '-', except in the
NB. last character position (there, it means infinity)
changesigns=. ({&('-',a.)) @ (('_',a.)&i.) @ }: , {:

NB. Now, the formatting routines for each field type.  Each has the
NB. descriptor as x, the unboxed data value as y, and returns an unboxed string.
NB. The formatting routine is responsible for applying the precision, the positive
NB. flag, and the 'alternate format' flag

NB. We accommodate the case where the variable is a list.  In that case, the width
NB. applies to the entire field, and the components are converted using the
NB. precision, positive, and alternate format flags; the results are concatenated
NB. with one space in between.  For strings we support a boxed list by razing with
NB. a space between.

NB. adverb to apply u on a list and merge the results
allowvec=. (1 : '(;:^:_1) @: (<@u"_ 0)') f.

NB. The monad case of the formats is for %? bare
formatd=: (0 0 1 0 0 0&$:) : (( ({::&('';'+';' '))@(4&{ ux_vy * >:!.0&0) , 2&{@[ zeropad changesigns@(0&":)@<.@] ) allowvec)
formatu=: (0 0 1 0 0 0&$:) : (formatd 4294967296&+^:(0&>))
formato=: (0 0 1 0 0 0&$:) : (( #&'0'@(5&{ ux_vy * >:!.0&0) , 2&{@[ zeropad convertoctal@<.@] ) allowvec)
formatx=: (0 0 1 0 0 0&$:) : (( #&'0x'@(5&{ ux_vy * >:!.0&0) , 2&{@[ zeropad converthex@<.@] ) allowvec)
formatX=: (0 0 1 0 0 0&$:) : (( #&'0X'@(5&{ ux_vy * >:!.0&0) , 2&{@[ zeropad convertHEX@<.@] ) allowvec)
formatf=: (0 0 6 0 0 0&$:) : (( ({::&('';'+';' '))@(4&{ ux_vy * >:!.0&0) , (0&j.)@(2&{)@[ changesigns@": ] ) allowvec)
NB. obsolete Use 0j_prec unless prec is 0; then use __j0.  __jprec fails if prec ~: 0,
NB. obsolete and (__ j. 0) gives a value that doesn't work either
NB. obsolete formate=: (0 0 6 0 0 0&$:) : (( (-.@* __"_^:[ 0&j.@-)@(2&{)@[ changesigns@}.@": ] ) allowvec)
NB. e format changed in 6.01, now we must calculate the number of digits explicitly; and infinity no longer
NB. allowed for width.  So we calculate a lavish width, including user's frac digits, plus
NB. sign, decimal point, exponent, plus one in case of precision issues on log; then we
NB. remove spaces after formatting, and prepend a blank if the field doesn't start with _
formate=: (0 0 6 0 0 0&$:) : ((( (((1+1+4+1) -@+ ] + [: >. 10 ^. 1 >. |@[) j. ]) (2&{) )~ changesigns@(' '&,^:('_'~:{.))@(-.&' ')@": ] ) allowvec)
formatE=: (0 0 6 0 0 0&$:) : (('E'&(i.&'e'@]})^:('e'&e.)) @ formate allowvec)
formatg=: (0 0 6 0 0 0&$:) : (formatf`formate @.((10&^@(2&{) ux_vy < +. 0.0001&>@]) |) allowvec)
formatG=: (0 0 6 0 0 0&$:) : (formatf`formatE @.((10&^@(2&{) ux_vy < +. 0.0001&>@]) |) allowvec)
formats=: ] : (2&{ ux_vy ((<. #) {. ]))
formatS=: ;:^:_1 @: (":&.>)^: (32&=@(3!:0)) : (2&{ ux_vy ((<. #) {. ]) ;:^:_1 @: (":&.>)^: (32&=@(3!:0)))
formatc=: formats
formatj=: ": : (2&{ ux_vy ((<. #) {. ":@]))
NB. ":, but if result has rank > 2, put a NL before each item, and after
NB. the whole thing, so that the array is broken out visibly
formatJ=: (,&newline)@:((,@:(newline&,"1)"2)^:(<:@#@$)) ^:(1:<#@$) @ formatj

eps=. ;: 'vbsprintf vsprintf sprintf cprintf printf'
('`' , ;:^:_1 ,&'_z_'&.> eps)=: (,&thislocale&.>) eps
