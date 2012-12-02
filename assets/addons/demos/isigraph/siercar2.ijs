NB. Sierpinski Carpet by repeated copying

copy=. ((],,),.~),.],,~

(|.YELLOW,BLUE) vmat copy^:5 ,1

NB. alternates:
NB. 1.
NB.    copy=.. [:,./^:2*/~
NB.    copy^:2 #:7 5 7
NB.
NB. 2.
NB.    s0=. ,~(,-~)
NB.    s1=. ,,~
NB.    copy=. s1 ,. s0 ,. s1
NB.    copy^:5 1
