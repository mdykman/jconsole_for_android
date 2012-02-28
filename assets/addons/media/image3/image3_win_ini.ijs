NB. Image 3 Windows specific initialization
NB. Zach and Cliff Reiter
NB. April, 2002
NB. modified for J6.01, Sept 2006

NB. image3 addon library name
library_name=:'image3.dll'

NB. to add path to pthreadGC (windows)
NB. get path variable (assumed to be less than 4096 characters)
get_path=:3 : 0
t=.'kernel32 GetEnvironmentVariableA i *c *c i' cd 'PATH';(4096$' ');4096
n0=.>{.t
if. 4096< n0 do.  t=.'kernel32 GetEnvironmentVariableA i *c *c i' cd 'PATH';(n0$' ');n0 end.
{.&>/0 2{t
)

NB. set path variable
set_path=: 3 : 0
t=.'kernel32 SetEnvironmentVariableA i *c *c' cd 'PATH';y
)

NB. add a path to the path
adjoin_to_path=:3 : 0
t=.get_path ''
if. +./ y E. t do. 'already in path'
   else. >{. set_path t,';',y end.
)

NB. add the path
adjoin_to_path addon_path

NB. General file move/copy utilities
NB. file move (Fmove 'infile';'outfile')
Fmove=: >@{.@('kernel32 MoveFileA i *c *c '&cd)"1  NB. rank 1 boxed

NB. file copy (Fcopy 'infile';'outfile')  NB. rank 1 boxed
Fcopy=:>@{.@('kernel32 CopyFileA i *c *c i '"_ cd ] , (<0)"_)"1

