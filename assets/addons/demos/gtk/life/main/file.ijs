NB. file
NB.
NB. load lif file

NB. =========================================================
life_file_load=: 3 : 0
pat=. <'*.lif';'lif pattern file'
r=. filechooser 0;'load *.lif file';pat;PATH
if. 0=#r do. 0 return. end.
  PATH=: }:0 pick fpathname r
  dat=. readlif r
if. dat-:0 do. return. end.
setpattern dat
)

NB. =========================================================
NB. readlif - read a *.lif file
NB.
NB. form: readlif file
readlif=: 3 : 0
dat=. 'b' fread y
if. 0 e. ('#Life 1.05';'#N') e. dat do.
  info 'Not a Life 1.05 file' 
  0 return.
end.
buildlife dat
)
