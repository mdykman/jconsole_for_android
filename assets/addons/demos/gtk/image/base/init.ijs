NB. init

coclass 'pimage'
coinsert 'jgtk'

NB. =========================================================
create=: 3 : 0
File=: y
Dat=: fread File
if. Dat-:_1 do.
  smoutput 'not found: ',File
  destroy'' return.
end.
if. -.IFGTK do.
  require 'gtk'
  gtkinit_jgtk_''
end.
Pwh=: Twh=: 0
Resize=: (<(1+File i:'.')}.File) e. ;: 'svg'
make_win ''
make_timer 2000
if. -.IFGTK do.
  gtk_main''
end.
1
)

NB. =========================================================
destroy=: 3 : 0
cbfree''
codestroy''
)
