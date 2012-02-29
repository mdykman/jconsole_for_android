cocurrent 'z'

NB. create 'tags' file in the directory specified by the right argument
NB. syntax:
NB.   x jtags '/path/to/foo1'                  (generate /path/to/foo1/tags)
NB.   x jtags '/path/to/foo1';'/path/to/foo2'  (generate 2 tags files)
NB.   x jtags ''                               (use Tags_j_)
NB.   x jtags <''                              (do not generate tags files. reload tags cache depending on x)
NB.
NB.   if x=1 (default), reload tags cache from files in Tags_j_
jtags=: 3 : 0
1 jtags y
:
if. 0= #y=. boxxopen y do. y=. ({.~ i:&'/')@jpath&.> boxxopen Tags_j_ end.
p=. 1!:43''
for_t. y do.
  if. #dtb >t do.
NB. may fail because of path not exist or file permission error
    try.
      1!:44 >t
      smoutput >t
      if. '/gtkinclude'-:(}.~ i:&'/') >t do.
NB. .h files
        if. IFUNIX do.
          2!:0 'ctags -R --c++-kinds=+p --fields=+iaS --extra=+q'
        else.
          _1&fork_jtask_ (dquote jpath '~addons/general/jtags/ctags.exe'), ' -R --c++-kinds=+p --fields=+iaS --extra=+q'
        end.
      else.
        if. IFUNIX do.
          2!:0 '/bin/sh ',(dquote jpath '~addons/general/jtags/jtags')
        else.
          _1&fork_jtask_ (dquote jpath '~addons/general/jtags/ctags.exe'), ' -R --tag-relative=yes --exclude=snap --exclude=release --langdef=j --langmap=j:.ijs --regex-j="/([a-zA-Z][a-zA-Z0-9_]*)[ \t]*=:/\1/d,definition/" --languages=j'
        end.
      end.
    catch. end.
  end.
end.
1!:44 p
loadtags^:(0~:x) ''
EMPTY
)

