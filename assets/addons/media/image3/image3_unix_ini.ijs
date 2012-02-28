NB. Image 3 UNIX specific initialization
NB. Zach and Cliff Reiter
NB. November, 2002

NB. image3 addon library name
3 : 0 ''
if. UNAME-:'Darwin' do.
library_name=:'libimage3.dylib'
else.
library_name=:'libimage3.so'
end.
)

NB. General file move/copy utilities
NB. file move (Fmove 'infile';'outfile')  NB. rank 1 boxed
Fmove=:(2!:0@('/bin/mv '&,)@;@:(,&' '@('"'&([ , [ ,~ ]))&.>))"1

NB. file copy (Fcopy 'infile';'outfile')  NB. rank 1 boxed
Fcopy=:(2!:0@('/bin/cp '&,)@;@:(,&' '@('"'&([ , [ ,~ ]))&.>))"1
