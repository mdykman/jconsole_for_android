NB. event

NB. =========================================================
bestfit_click=: 3 : 0
cfg_read''
wh=. _10 _120 + getscreenwh window
Nboard=: |. <. wh % Nscale
cfg_show''
)

NB. =========================================================
cfg_close=: 3 : 0
gtk_widget_destroy window
1
)

NB. =========================================================
ok_click=: 3 : 0
if. #locWin do.
  cfg_read''
  dat=. pack 'Nboard Nscale Nmaxiter Nmaxbuf Nminrun Ntimer'
  life_cfg_return__locWin dat
end.
cfg_close''
)

NB. =========================================================
restore_click=: 3 : 0
cfg_init''
cfg_show''
)

NB. =========================================================
cancel_click=: cfg_close
escale_select=: cfg_reshow
window_delete=: cfg_close
window_destroy=: 0:

