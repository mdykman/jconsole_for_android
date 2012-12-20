NB. =========================================================
NB.*evtloop v stub for compatibility
evtloop_z_=: empty

NB. =========================================================
NB.*evthandler v event handler
NB. runs in form locale
NB. sets global event data: evtdata
NB. runs first found of: form_handler, form_event, form_default,
NB. with global event variables from evtdata
NB. if debug is off, wraps event handler in try. catch.
NB. catch exits if error message is the last picked up by debug.
evthandler_z_=: 3 : 0
evtdata=: y
evt_val=. {:"1 evtdata
({."1 evtdata)=: evt_val
if. 3=4!:0<'evthandler_debug' do.
  try. evthandler_debug'' catch. end.
end.
evt_ndx=. 1 i.~ 3 = 4!:0 [ 3 {. evt_val
if. 3 > evt_ndx do.
  evt_fn=. > evt_ndx { evt_val
  if. 13!:17'' do.
    evt_fn~''
  else.
    try. evt_fn~''
    catch.
      evt_err=. 13!:12''
      if. 0=4!:0 <'ERM_j_' do.
        evt_erm=. ERM_j_
        ERM_j_=: ''
        if. evt_erm -: evt_err do. i.0 0 return. end.
      end.
      evt_err=. LF,,LF,.}.;._2 evt_err
      sminfo 'evthandler';'error in: ',evt_fn,evt_err
    end.
  end.
end.
i.0 0
)
