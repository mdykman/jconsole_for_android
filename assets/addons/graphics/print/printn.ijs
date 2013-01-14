NB. printit text in n columns on a page.
NB.
NB. form: cols print text
NB.   cols = number of columns
NB.   text = matrix or character vector
NB.
NB. this differs from 2-up printing in allowing
NB. more than 2 columns, and treating the whole
NB. page as a single page; whereas 2-up printing
NB. treats as the page as if made up of 2 separate
NB. pages.
NB.
NB. uses the font for 2-up printing, which is assumed
NB. to allow at least 161 columns on a page.

require 'graphics/print'

printn_z_=: 4 : 0
if. 0 e. $y do. return. end.
if. 2 <: #$y do. mat=. y
else. mat=. ];._2 y,LF -. _1{.y
end.
cat=. ,&,.&.|:
txt=. ''
rws=. 72
cls=. _2+<. 161 % x
mat=. '  ' ,"1 ~ cls{."1 mat
pad=. 10
while. #mat do.
  blk=. rws {. mat
  ndx=. 1 i:~ blk *./ .= ' '
  if. ndx>rws-pad do. blk=. ndx{.blk end.
  txt=. txt,<rws{.blk
  mat=. mat }.~ #blk
end.
txt=. _4 (cat each /)\ txt
txt=. _2 (}."1) each txt
prn=. ; (,&FF) on  }. on , on (LF&,.) each txt
font=. P2UPFONT_jprint_
('land;font ',font) print prn
)
