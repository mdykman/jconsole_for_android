

NB. Evaluation in Slow Motion  

NB.  This script defines: 
NB.
NB.  an adverb EVM  which evaluates an expression. 
NB.                 The argument of EVM is an expression as character-string, 
NB.                 for example '2+2' EVM .
NB.
NB.                 EVM also produces global variables Qh, Sh and Rh
NB.                 which, when displayed, show the history of the stages 
NB.                 in the evaluation process.
NB.
NB.  a verb   hist  which produces a formatted display of the
NB.                 history from Qh, Sh,  Rh.
NB.                 The argument of hist is ''


NB. The main function:

EVM =: 1 : 0
setup x
done  =: 0
while. not done  do.
   r =: inspect ''          NB. look for applicable rule
   update (<Q),(<S), <<r    NB. update history

   if.     not r -: 'none'  NB. some rule applies
       do. execute r , ' 0' NB. execute the rule

   elseif. (#Q) > 0         NB. no rule, some Q
       do. transfer ''      NB. get a word from Q

   elseif. 1
       do. done =: 1
   end.
end.

". 'zz =: ',  ; }. S
((5 !: 1) <'zz') (5 !: 0)    NB. deliver the result
)


NB.  Utility Functions and Constants

wordform =: ;:
unwordfm =: ;: ^: _1
print    =: (1 !: 2 ) & 2
First    =: {.
Last     =: {:
Most     =: }:
jclass   =: 4 !: 0
T1       =: 1 & {.  NB. Take 1 (first)
T2       =: 2 & {.
T3       =: 3 & {.  NB. Take 3
T4       =: 4 & {.  NB. Take 4
D3       =: 3 & }.  NB. Drop 3
D4       =: 4 & }.  NB. Drop 4
and      =: *.
or       =: +.
not      =: -.
rep      =: 5 !: 6  NB. representation-function
execute  =: ".

mark     =: 'mark'
letters  =:  ((65 + i. 26), (97 + i. 26)) { a.
digits   =: (48 + i. 10) { a.
nchars   =:  letters,digits,'_'

NB. A scheme for classifying the objects of the stack. 
NB. We assign a number for each kind of object. 
NB. Following the built-in J classification scheme, 
NB. nouns are class-0 objects, adverbs are class-1 objects
NB.  and  so on.

Noun =: 0
Adv  =: 1
Conj =: 2
Verb =: 3
Name =: _1  NB. a name with no assigned value

NB. Also in the stack will be objects which are 
NB. punctuation rather
NB. than values. We have the "mark" (marking the 
NB. beginning of the expression), left and right
NB. parentheses and the symbol for assignment, ([=:] or
NB.  [=.]). We give arbitrary numbers 
NB. to encode these classes.

Mark =: 99
Rpar =: 98
Lpar =: 97
Asgn =: 96

NB. Next some larger classes, represented by lists. 

VN   =: Verb, Noun
AVN  =: Adv,  Verb, Noun
CAVN =: Conj, Adv,  Verb, Noun
EDGE =: Mark, Asgn, Lpar
EAVN =: EDGE, AVN
NN   =: Noun, Name

NB. A pattern is a sequence of classes. Here is a verb to
NB. match the stack against a pattern and identify the corresponding rule.

inspect =: 3 : 0
   if.     S match EDGE; Verb; Noun       do. 'monad'  
   elseif. S match EAVN; Verb; Verb; Noun do. 'monad2'  
   elseif. S match EAVN; Noun; Verb; Noun do. 'dyad'
   elseif. S match EAVN; VN;   Adv        do. 'adv'
   elseif. S match EAVN; VN;   Conj; VN   do. 'conj' 
   elseif. S match EAVN; VN;   Verb; Verb do. 'trident' 
   elseif. S match EDGE; CAVN; CAVN       do. 'bident'  
   elseif. S match NN;   Asgn; CAVN       do. 'assign'  
   elseif. S match Lpar; CAVN; Rpar       do. 'paren'  
   elseif. 1                              do. 'none' 
   end.
)

setup =: 3 : 0
NB. set up global variables
Q   =: mark ; wordform y  NB. a list of boxed strings
S   =: 0 $ < ' '           NB. a list of boxed strings
Qh  =: (0 , (#Q)) $ Q      NB. Q history
Sh  =: 0 1 $ Q             NB. Stack history
Rh  =: (0,1) $ < '  '      NB. Rule history
)

NB. verb to transfer a word from end of Q to front of S, 
NB. evaluating names which are nouns and not about to be 
NB. assigned-to 

transfer =: 3 : 0
a =. > Last Q
if. isname a do. 
   if.  (classify a) = Noun  do.
         if. 1 - S match < Asgn  do.
             a =. > Eval < a 
end. end. end. 

S =: (<a) , S
Q =: Most Q
)

NB. A verb to test whether the stack matches a pattern of
NB.  object-classes.
NB. The left argument x is the stack, and the right 
NB. argument y
NB. is a pattern, a list of (sets of) classes.

match =: 4 : 0
if.   (# x) < (# y) do. 0       NB. stack too short
else. x =. (# y) {. x
      *. / x (match1 &: > " 0 0) y
end.
)

NB. a verb to match a single stack item against a 
NB. classification.
NB. case [q] catches reassigning to existing name
NB. case [r] embodies the assumption that an unassigned 
NB. name denotes a verb

match1 =: 4 : 0
c =. classify x
p =.  c e. y 
q =. (y -: NN)   and (isname x) 
r =. (Verb e. y) and (c -: Name) 
or/p,q,r
)

NB. A verb which tests whether a string is a name , 
NB. that is,
NB. begins with a letter and contains only letters or 
NB. digits or underscores.

isname=:3 : '((0 { y)e.letters) and (*./  y e. " 0 1 nchars)'

NB. A verb to classify a stack-item (a string). 

classify =: 3 : 0
if.     y -: mark          do. Mark
elseif. y -: 1 $ ')'       do. Rpar
elseif. y -: 1 $ '('       do. Lpar
elseif. y -: '=:'          do. Asgn
elseif. y -: '=:'          do. Asgn
elseif. Name = jclass < y  do. Name  NB.  an unused name !
elseif. 1                   do. 
                                ". 'x =. ' , y
                                jclass < 'x'
end.
)


NB. Functions for the rules. Each computes a new value of S. 

monad  =: 3 : 'S =: (T1 S), (Eval 1 2 { S),   (D3 S) '
monad2 =: 3 : 'S =: (T2 S), (Eval 2 3 { S),   (D4 S) '
dyad   =: 3 : 'S =: (T1 S), (Eval 1 2 3 { S), (D4 S) '
adv    =: 3 : 'S =: (T1 S), (Eval 1 2   { S), (D3 S) '
conj   =: 3 : 'S =: (T1 S), (Eval 1 2 3 { S), (D4 S) '
trident=: 3 : 'S =: (T1 S), (Eval 1 2 3 { S), (D4 S) '
bident =: 3 : 'S =: (T1 S), (Eval 1 2 { S),   (D3 S) '
assign =: 3 : 'S =: (Is 0 1 2 { S), (D3 S)           '
paren  =: 3 : 'S =: (1&{ , D3) S                     '

NB. Each of these rule-functions performs a computation.
NB. The computations are done by the Eval verb, or in case
NB. of assignments, by the Is verb.

NB. The argument of Eval is a sequence of stack items.
NB. After parenthesizing each item they are run together  
NB. to form a single string.  This string is executed. 
NB. The resulting value (of whatever kind) is turned back into 
NB. a string with 
NB. the representation-function and boxed to give a single 
NB. stack-item, which is the result of Eval. 

Paren   =:  (('( '&,) @ (, & ' )')) &. >

Eval =: 3 : 0
try. execute 'z=. ' , ; Paren y catch. z =. 'error' end.
< rep < 'z'
)

NB. The Is verb executes assignments. 
NB. Note that, for the purpose of the modelling, it is 
NB. convenient 
NB. to force the assignment to be global. Otherwise, a local 
NB. assignment would be
NB. buried inside the model itself. 

Is =: 3 : 0
execute 'z=. ', (> 0 { y), '=:', (> 2} y) 
< rep < 'z'
)

NB. function to record one stage, adding it to the history

update =: 3 : 0
'Q S R' =. y
Qh =: Qh,Q
Sh =: Sh,S
if. R -: <'none' do. R =. <'    ' end.
Rh =: Rh,R
''
)

NB.  End of EVM.


NB. function to format the history (Qh Sh and Rh) 

hist =: 3 : 0
Q   =. ": ,. (<&unwordfm "1) Qh
R   =. ": Rh
aw  =. 72 - (1{$ Q) + (1{$ R)  NB. available width
S1w =. 1{$ S1 =. ": Sh
S2w =. 1{$ S2 =. ": (fc"0) Sh
S3w =. 1{$ S3 =. ": (fa"0) Sh
if.     S3w <: aw do. S =. S3  NB. format S to fit width
elseif. S2w <: aw do. S =. S2
elseif. 1         do. S =. S1
end. 
fb 2 5 $  'Queue'; ' '; 'Stack'; ' '; 'Rule';   Q; ' ';S;' ';R
)


NB. format with blanks for box-drawing characters

fb =: 3 : 0
B =. 9!:6 ''
9 !:7 (11# ' ')
z =. ": y
9 !:7 B
z
)

fa =: (' '&,) @: (,&' ') &. >       NB. space before and after
fc =: (' '&,) &. >                  NB. space before

NB.   -------  e n d ----------    last updated  23 Apr 2006
