NB. test_rserve
NB.
NB. test the Rserve socket connection
NB.
NB. requires that the R addon and Rserve are loaded

cocurrent 'base'
coreset ''
sdcleanup_jsocket_''

NB. =========================================================
test=: 3 : 0
Ropen''

assert. (o.1) = Rget'pi'
assert. 1 2 3 4 -: Rget 'c(1,2,3,4)'
assert. (1 2 _ __ __) -: Rget 'c(1,2,Inf,-Inf,NA)'
assert. isnan_rserve_ -: Rget 'NaN'

Rcmd 'x = 1:24'
Rcmd 'dim(x) = c(2,3,4)'
assert. (_2 |: 4 3 2 $ 1 + i.24) -: Rget 'x'

Rcmd 'x=1.23 + 1:8'
Rcmd 'dim(x)=c(2,4)'
assert. (|:1.23+1+i.4 2) -: Rget 'x'

NB. ---------------------------------------------------------
assert. (2 j. _3+|: i.4 3) -: Rget '2 + 1i * matrix(-3:8,nrow=3)'

assert. 'abc 123' -: Rget 'charToRaw("abc 123")'

NB. ---------------------------------------------------------
Rcmd 'x = c("a","b","c","d","e","f","g","h")'
Rcmd 'dim(x) = c(2,4)'
assert. (|:4 2$'abcdefgh') -: {.&> Rget 'x'

Rcmd 'x = c("abc","b","c","d","e","fore","g","h")'
Rcmd 'dim(x) = c(2,4)'
v=. |:4 2$ <;._1 '/abc/b/c/d/e/fore/g/h'
assert. v -: Rget 'x'

NB. ---------------------------------------------------------
Rcmd 'x=TRUE'
assert. 1 -: Rget 'x'
Rcmd 'x=FALSE'
assert. 0 -: Rget 'x'
Rcmd 'x=c(TRUE,FALSE,NA,TRUE,TRUE,FALSE)'
assert. (1 0 2 1 1 0) -: Rget 'x'

NB. ---------------------------------------------------------
Rcmd 'foo <- function(x,y) {x + 2 * y}'
assert. 'closure' -: Rget 'typeof(foo)'
assert. 11 = Rget 'foo(5,3)'
NB. assert. 'function(x,y) {x + 2 * y}' -: 1 1 {:: Rget'foo'

NB. ---------------------------------------------------------
Rcmd 'x=factor(c("one","two","three","four"))'
d=. '`class';'factor'
d=. d,:'`data';2 4 3 1
d=. d,'`levels';<;:' four one three two'
assert. d -: Rget 'x'

NB. ---------------------------------------------------------
'abc' Rset 'qwerty'
assert. 'qwerty' -: Rget 'abc'
'abc' Rset i.10
assert. (i.10) -: Rget 'abc'
'abc' Rset 1 2.2 3
assert. 1 2.2 3 -: Rget 'abc'
'abc' Rset i.2 3 4
assert. (i.2 3 4) -: Rget 'abc'

Rclose''
'test_rserve done'
)

smoutput test''
