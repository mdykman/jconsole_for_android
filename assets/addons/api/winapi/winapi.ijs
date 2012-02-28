NB. windows api utilities
NB.
NB. win32api       look up Win32 API call
NB. winconst       look up Windows constant
NB. winset         set Windows constant

cocurrent 'z'

NB. =========================================================
NB.*win32api a look up Win32 API declaration, returning verb
NB. e.g.
NB.    'GetProfileStringA' win32api
NB. 'kernel32 GetProfileStringA i *c *c *c *c i'&(15!:0)
NB.    >'GetVersion' win32api ''
NB. _1073741820
win32api=: 1 : 0
c=. freads '~addons/api/winapi/win32api.dat'
n=. 1 i.~ (' ',m,' ') E. c
if. n=#c do.
  n=. 1 i.~ (' ',m,'A ') E. c
  if. n=#c do. ] return. end.
end.
n=. >:n-LF i.~ (n-i.100<.n){c
(({.~ i.&LF)n}.c)&(15!:0)
)

NB. =========================================================
NB.*win32apir as win32api, except verb returns first element of call result
win32apir=: 1 : '>@{.@(x win32api)'

NB. =========================================================
NB.*winconst v look up Windows constants
NB. returns table of names;values
NB. e.g. winconst 'EM_GETMODIFY EM_SETMODIFY'
winconst=: 3 : 0
y=. toupper each cutopen y
c=. freads '~addons/api/winapi/winconst.dat'
n=. (#c) -.~ y (i.&1@E.) &> <c
if. 0=#n do. (i.0);'' return. end.
x=. I. c=LF
i=. +/ x <:/ n
x=. ;:(-.&LF)&>i{ <;._2 c
({:"1 x) ,. 0 ". each {."1 x
)

NB. =========================================================
NB.*winset v set values of windows constants
winset=: 3 : 0
n=. winconst y
if. #n do. ({."1 n)=: {:"1 n end.
empty''
)
