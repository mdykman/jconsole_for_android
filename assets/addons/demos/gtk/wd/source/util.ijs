NB. util

addchild=: 3 : 0
'c xy'=. y
fl=. FormList{~i=. (>{."1 FormList)i.Cparent
fb=. 1{::fl
gtk_fixed_put fb,c,xy
FormList=: ((2{.fl),<c,~2{::fl) i}FormList
)

window_destroy=: 3 : 0
'widget data'=. y
i=. (>{."1 FormList)i.widget
FormList=: (<<<i){FormList
if. 0=#FormList do.
  if. -.IFGTK do.
    gtk_main_quit''
  end.
  cbfree''
  codestroy''
end.
)

NB. export to z locale
wd_z_=: 3 : 0
(coname'') wd_jwd_ y
)

