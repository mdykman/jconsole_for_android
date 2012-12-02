require 'droidwd gtkwd'
require 'gl2'

coclass 'jprintdemo'
coinsert'jgl2 wdbase'
droidwd_run=: print_run

NB. print 'page one'
NB. print 'page one';'page two'
NB. 'print job args' print 'One';'Two'
print=: 3 : 0
'' print y
:
DATA=: boxopen y
PRINT_MORE=: #DATA
wdpclose 'print'             NB. close old print form
wd 'pc print; cc g isigraph'
glprint x                    NB. start printing
)

print_g_print=: 3 : 0
smoutput 'print event page pass: ',sysdata
'page pass'=.".sysdata
select. pass
case. _1 do. NB. printing finished - cleanup
 wd'pclose'
case. 0 do.  NB. is there data to print?
 glprintmore PRINT_MORE
case. 1 do.  NB. print page
 print_draw ''
case. 2 do.  NB. banding - print page again
 wd'mb Print *Printer banding not supported'
end.
)

print_draw=: 3 : 0
data=. >{.DATA   NB. data for this page
DATA=: }.DATA    NB. remaining data to print
PRINT_MORE=: #DATA

WH=: wh=. glqprintwh''  NB. printable area in twips
PAPER=: glqprintpaper'' NB. paper wh and xy offset in twips

glrect 0 0,wh
gllines 0 0,wh

glfont 'arial 11'
gltextxy 1440 1440 NB. 1 inch over and down
gltext data
)

print_run=: 3 : 0
wd'mbprinter'
'"print demo" "" "" copies 2' print 'page one';'这首歌很好听'
evtloop^:(-.IFJ6)''
)

print_run`start_droidwd@.('Android'-:UNAME) coname''
