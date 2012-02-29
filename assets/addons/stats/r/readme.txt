stats/r addon

The stats/r addon has core utilities for interfacing with R.

There are three such interfaces:

  rserve - uses the Rserve system for communicating via sockets
  rdcmd  - calls R in batch
  rdcom  - calls R using OLE - Windows only

The distributed scripts are:

  rserve.ijs   - load the rserve utilities
  rdsock.ijs   - rserve socket handling
  rbase.ijs    - rserve base utilities

  rdcmd.ijs    - batch script
  rdcom.ijs    - com script

For more information, see http://www.jsoftware.com/jwiki/Interfaces/R



