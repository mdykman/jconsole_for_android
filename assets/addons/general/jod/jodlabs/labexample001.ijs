NB. long documentation example: used in JOD Introduction lab.

changestr=:4 : 0

NB.*changestr v-- replaces substrings - see long documentation.
NB.
NB. dyad:  clReps changestr cl
NB.
NB.   NB. first character delimits replacements
NB.   '/change/becomes/me/ehh' changestr 'blah blah ...'

pairs=. 2 {."(1) _2 [\ <;._1 x      NB. change table
cnt=._1 [ lim=. # pairs
while. lim > cnt=.>:cnt do.         NB. process each change pair
  't c'=. cnt { pairs               NB. /target/change
  if. +./b=. t E. y do.             NB. next if no target
    u=. I. b                        NB. target starts
    'l m'=. #&> cnt { pairs         NB. lengths
    p=. u + 0,+/\(<:# u)$ d=. m - l NB. change starts
    s=. * d                         NB. reduce < and > to =
    if. s = _1 do.
      b=. 1 #~ # b
      b=. ((l * # u)$ 1 0 #~ m,l-m) (,u +/ i. l)} b
      y=. b # y
      if. m = 0 do. continue. end.  NB. next for deletions
    elseif. s = 1 do.
      y=. y #~ >: d u} b            NB. first target char replicated
    end.
    y=.(c $~ m *# u) (,p +/i. m)} y  NB. insert replacements
  end.
end. y                              NB. altered string
)

changestrDOC=: 0 : 0
*changestr v-- replaces substrings within a string.

This algorithm was adapted from an APL algorithm. It requires
high speed boolean bit  manipulation and is not  as effective
in current  J systems as it  is in some  APL systems. Despite
J's non-optimal booleans this verb is still fast enough to be
fruitfully applied.  On  my  400MHZ NT  machine  you can make
20,000 length increasing replacements, (the worst case), in a
1  megabyte  string  in approximately  one  second.  For  100
kilobyte  strings typical operations complete is less than  a
tenth of second.

High speed substring replacement is difficult to achieve in J
and APL environments. This verb would be a good candidate for
an external compiled routine.

dyad:  clChanged =. clTargets changestr clStr

  '/change/becomes' changestr 'change me'

  '/delete' changestr 'delete me'   NB. null replacement deletes

  NB. first character is delimiter

  '.remove..purge..wipe' changestr 'removepurgewipe'

  '/' changestr 'nothing happens'

  '' changestr 'nothing happens'

  '/nothing/happens' changestr 'no matches to change'

  NB. multiple replacements are made in left to right order

  t =. 'once all things were many'

  '/many/changes/all/at/once/ehh' changestr t

  NB. even null subtring replacements are allowed

  '//XX' changestr 'insert big x chars around us'

  NB. finally all this applies in a clean elegant
  NB. way to UNICODE strings as well

  uchars=. u: 1033 + i. 500  NB. unicode string
  datatype uchars            NB. (datatype) from j profile

  usub0=. (100+i.11){uchars  NB. substrings
  usub1=. (313+i.7){uchars
  datatype usub0
  datatype usub1

  NB. strings that will not occur in the original
  unew0=. u: 40027+i.33
  unew1=. u: 50217+i.7

  +./ unew0 E. uchars   NB. not in uchars
  +./ unew1 E. uchars

  ucharsnew=. ('/',usub0,'/',unew0,'/',usub1,'/',unew1) changestr uchars

  +./ unew0 E. ucharsnew  NB. now in string
  +./ unew1 E. ucharsnew
)

put 'changestr'
0 9 put 'changestr';changestrDOC
erase 'changestr changestrDOC'
