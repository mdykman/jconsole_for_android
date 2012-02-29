NB. general/misc/trace.ijs
NB. Execution trace utilities
NB. version: 1.0.0

cocurrent 'jtrace'

Note 0
The main functions are "trace" and "paren".

x trace y   trace sentence y to x levels of function calls
trace y     same as  _ trace y

For example:
   trace '3+i.4'
 --------------- 1 Monad ------
 i.
 4
 0 1 2 3
 --------------- 2 Dyad -------
 3
 +
 0 1 2 3
 3 4 5 6
 ==============================
3 4 5 6

Tracing provides information on results within a line;
the action labels 0 monad, 1 monad, 9 paren, etc.,
are from the parse table in Section II.E of the J dictionary.


paren y     fully parenthesize sentence y

For example:
   paren '+/i.4'
((+/)(i.4))
   paren '(3 4$i.12)+/ .**:i.4'
((3 4$(i.12))((+/) .*)(*:(i.4)))

)


(x)=: 2^i.#x=. ;:'noun verb adv conj lpar rpar asgn name mark'
any =: _1
avn =: adv + verb + noun
cavn=: conj + adv + verb + noun
edge=: mark + asgn + lpar

x=. ,: (edge,       verb,       noun, any      ); 0 1 1 0; '0 Monad'
x=. x, ((edge+avn), verb,       verb, noun     ); 0 0 1 1; '1 Monad'
x=. x, ((edge+avn), noun,       verb, noun     ); 0 1 1 1; '2 Dyad'
x=. x, ((edge+avn), (verb+noun),adv,  any      ); 0 1 1 0; '3 Adverb'
x=. x, ((edge+avn), (verb+noun),conj, verb+noun); 0 1 1 1; '4 Conj'
x=. x, ((edge+avn), (verb+noun),verb, verb     ); 0 1 1 1; '5 Trident'
x=. x, (edge,       cavn,       cavn, any      ); 0 1 1 0; '6 Bident'
x=. x, ((name+noun),asgn,       cavn, any      ); 1 1 1 0; '7 Is'
x=. x, (lpar,       cavn,       rpar, any      ); 1 1 1 0; '8 Paren'

PTpatterns=: >0{"1 x  NB. parse table - patterns
PTsubj    =: >1{"1 x  NB. "subject to" masks
PTactions =:  2{"1 x  NB. actions

bwand     =: 17 b.    NB. bitwise and

prespace=: ,~ e.&'.:'@{. $ ' '"_
                      NB. preface a space to a word beginning with . or :

isname=: ({: e. '.:'"_) < {. e. (a.{~,(i.26)+/65 97)"_
                      NB. 1 iff a string y from the result of ;: is is a name

class=: 3 : 0         NB. the class of the word represented by string y
 if. y-:mark do. mark return. end.
 if. isname y do. name return. end.
 if. 10>i=. (;:'=: =. ( ) m n u v x y')i.<y do.
  i{asgn,asgn,lpar,rpar,6#name return.
 end.
 (4!:0 <'x' [ ".'x=. ',y){noun,adv,conj,verb
)

show=: 3 : 0
 if. (depth>:indent) *. equals *: y-:30$'-' do.
  equals=: y-: 30$'='
  smoutput (indent$' '),"1 ] 1 1}._1 _1}.": <y
 end.
 y
)

encall1=: '('"_ , ] , ' call"'"_ , ] , ')'"_
encall =: encall1&.>^:(isname&> *. 3: = 4!:0)"0
                      NB. replace function names f in words y by (f call"f)

call=: 1 : 0          NB. for tracing function calls
 (5!:5 <u=. 5!:5 <'u') call1    <y
 :
 (5!:5 <u=. 5!:5 <'u') call1 x;<y
)

call1=: 4 : 0         NB. call function x on argument(s) y
 't_x t_y'=. _2{.y
 indent=: >:indent
 show 30$'-'
 if. 2=#y do. show 5!:5 <'t_x' end.
 show x
 show 5!:5 <'t_y'
 ". 't_z=. ',((2=#y)#'t_x '),'(',(encall&.;: x),') t_y'
 show 5!:5 <'t_z'
 show 30$'='
 indent=: <:indent
 t_z
)

executet=: 4 : 0      NB. execute rule x for stack y for "trace"
 t_b=. x{PTsubj
 t_x=. t_b # , 4 _1{.y
 show 30{.(15$'-'),' ',(>x{PTactions),' ',15$'-'
 show&> t_x
 if. 7 =x do. t_x=. (<'=:') 1}t_x end.
 if. 2>:x do. t_x=. (encall&.;:&.>_2{t_x) _2}t_x end.
 if. 6>:x do. t_x=. (<'( '),&.>t_x,&.><' )' end.
 ". 't_z=. ', ; t_x
 t_c=. (4!:0 <'t_z'){noun,adv,conj,verb
 if. noun=t_c do.
  t_z=. 5!:5 <'t_z' [ show t_z
 else.
  t_z=. show 5!:5 <'t_z'
 end.
 ((t_b i. 1){.y),(t_c;t_z),(1+t_b i: 1)}.y  NB. new stack
)

executep=: 4 : 0      NB. execute rule x for stack y for "paren"
 t_b=. x{PTsubj
 t_x=. t_b # , 4 _1{.y
 select. x
  case. 0;1;2;5 do.
   t_c=. noun [ t_x=. '(',(;:^:_1 t_x),')'
  fcase. 7 do.
   t_x=. (<'=:') 1}t_x
  case. 3;4;6 do.
   ". 't_z=. ',t_x=. '(',(;:^:_1 t_x),')'
   t_c=. (4!:0 <'t_z'){noun,adv,conj,verb
  case. 8 do.
   t_c=. >1{t_b#,4 1{.y [ t_x=. >1{t_x
 end.
 ((t_b i. 1){.y),(t_c;t_x),(1+t_b i: 1)}.y  NB. new stack
)

movet=: 3 : 0         NB. move from queue to stack for "trace"
 'queue stack'=. y
 't_c t_x'=.{:queue
 if. (name~:t_c)+.asgn=0 0{::stack do.
  stack=. ({:queue),stack
 else.
  t_c=. (4!:0 <t_x){noun,adv,conj,verb
  if. t_c~:verb do. t_x=. 5!:5 <t_x end.
  stack=. (t_c;t_x),stack
 end.
 (}:queue);<stack
)

movep=: 3 : 0         NB. move from queue to stack for "paren"
 'queue stack'=. y
 't_c t_x'=.{:queue
 if. (name~:t_c)+.asgn=0 0{::stack do.
  stack=. ({:queue),stack
 else.
  t_c=. (4!:0 <t_x){noun,adv,conj,verb
  stack=. (t_c;t_x),stack
 end.
 (}:queue);<stack
)

NB. stack=: parse mode;depth;sentence
NB.  mode:     'trace' or 'paren'
NB.  depth:    depth of function calls to trace
NB.  sentence: string of the sentence to be parsed
NB.  stack:    stack at the end of the parse

parse=: 3 : 0
 't_mode t_d t_sent'=. y
 queue =. (mark;'') , (class&.> ,. prespace&.>) ;: t_sent
 stack =. 4 2$mark;''
 depth =: 1+t_d
 indent=: 1
 equals=: 0
 if. 'trace' -: t_mode do.
  execute=. executet
  move   =. movet
 else.
  execute=. executep
  move   =. movep
 end.
 while. 1 do.
  t_i=. 1 1 1 1 i.~ * PTpatterns bwand"1 ,>4 1{.stack
  if. t_i<#PTpatterns do.        NB. a pattern fits; execute the action
   stack=. t_i execute stack
  else.                          NB. no pattern fits; move from queue to stack
   if. 0=#queue do. break. end.
   'queue stack'=. move queue;<stack
  end.
 end.
 assert. * (mark+cavn,0) bwand >(<1 2;0){stack [ 'stack must be empty or has a single noun, verb, adverb, or conj'
 show 30$'='
 stack
)

trace=: 3 : 0         NB. trace sentence y to depth x (_ default)
 _ trace y
 :
 ". >(<1 1){parse 'trace';x;y
)

paren=: 3 : 0         NB. fully parenthesize sentence y
 >(<1 1){parse 'paren';__;y
)

trace_z_=: trace_jtrace_
paren_z_=: paren_jtrace_
