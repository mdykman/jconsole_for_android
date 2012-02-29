NB. xml/sax/fileWriter

require 'files'

coclass 'pfileWriter'

create=: 3 : 0
  name=: jpath 8 u: > y
  f=: (1!:21) :: _1: < name
)

destroy=: 3 : 0
  r=. (1!:22) :: _1: f
  codestroy ''
)

write=: 3 : 0
  dat=. ,y
  append=. #@[ [ 1!:3
  dat append :: _1: f
)
