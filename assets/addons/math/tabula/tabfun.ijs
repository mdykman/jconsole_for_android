NB. tabula/tabfun.ijs
NB. Defines semantic fns for menu: Function --and all 1-line uses of: funline
NB. 
NB. Semantic fn names are derived from cal-cmds by prefixing with V- or L-
NB. Cmds ending in -v -p simply alter the given item's value
NB. Cmds ending in -l -c create a new item dependent on the given item
NB. 
NB. These semantic fns have a script to themselves to be easily extendable.
NB. This script is loaded by: start_tab_ --to replace residually-defined synonyms
NB. -whose names should be put in EXCLUDE_tab_ for tidiness, but it doesn't matter.
NB. 
NB. THIS SCRIPT SHOULD NEVER BE MANAGED BY: LOBROW (which will munge: bind)

NB. THE SI- PREFIX MULTIPLIERS

cocurrent 'tab'

Vunsc=: 'unsc'&funline
Vstpu=: 'stpu'&funline
Vstpd=: 'stpd'&funline
Vcent=: 'cent'&funline
Vdeca=: 'deca'&funline
Vdeci=: 'deci'&funline
Vdeka=: 'deka'&funline
Vexaa=: 'exaa'&funline
Vfemt=: 'femt'&funline
Vgiga=: 'giga'&funline
Vhect=: 'hect'&funline
Vkilo=: 'kilo'&funline
Vmega=: 'mega'&funline
Vmicr=: 'micr'&funline
Vmill=: 'mill'&funline
Vnano=: 'nano'&funline
Vpeta=: 'peta'&funline
Vpico=: 'pico'&funline
Vtera=: 'tera'&funline
Vyoct=: 'yoct'&funline
Vyott=: 'yott'&funline
Vzept=: 'zept'&funline
Vzett=: 'zett'&funline

NB. THE VALUE ADJUSTERS

Vabsv=: 'absv'&funline
Vaddp=: 'addp'&funline
Vaddv=: 'addv'&funline
Vcbtv=: 'cbtv'&funline
Vcubv=: 'cubv'&funline
Vdblv=: 'dblv'&funline
Vdivp=: 'divp'&funline
Vdivv=: 'divv'&funline
Vetwv=: 'expv'&funline
Vexpv=: 'expv'&funline
Vextv=: 'extv'&funline
Vhlvv=: 'hlvv'&funline
Vinvv=: 'invv'&funline
Vintv=: 'intv'&funline
Vlnnv=: 'lnnv'&funline	NB. ln of value
Vltnv=: 'ltnv'&funline	NB. log10 of value
Vltwv=: 'ltwv'&funline	NB. log2 of value
Vmulp=: 'mulp'&funline
Vmulv=: 'mulv'&funline
Vnegv=: 'negv'&funline
Vpidv=: 'pidv'&funline
Vpimv=: 'pimv'&funline
Vptdv=: 'ptdv'&funline
Vptmv=: 'ptmv'&funline
Vsqrv=: 'sqrv'&funline
Vsqtv=: 'sqtv'&funline
Vsubp=: 'subp'&funline
Vsubv=: 'subv'&funline
Vvalu=: 'valu'&funline

NB. THE VALUE REPLACERS

Vonen=: 'onen'&funline
Vonep=: 'onep'&funline
Vzero=: 'zero'&funline

NB. THE LINE DERIVERS (c/f value adjusters)
NB. Laddc Laddl Lsubc Lsubl Lequl
NB. 	NEW reqd in cal...
NB. Lmulc Lmull Ldivc Ldivl Labsl Linvl Ldbll Lhlvl 
NB. Lintl Lnegl Lsqrl Lsqtl Lcubl Lcbtl Lexpl Lextl Llnnl Lltnl
NB. Lpidl Lpiml Lp2dl Lp2ml 
NB.  DECIDE ORDERLY NAMING... cmd suffixes: v-->l, p-->c
NB. --meaning: value-->line, percent-->[per]cent
NB. Trailing '-' gets funline to select the line just created

Labsl=: 'absl-'&funline
Laddc=: 'addc-'&funline	NB. copy line adding v%	[not menu]
Laddl=: 'addl-'&funline	NB. copy line adding v	[not menu]
Lcubl=: 'cubl-'&funline	NB. cubed line
Lcbtl=: 'cbtl-'&funline	NB. cube-rooted line
Ldbll=: 'dbll-'&funline	NB. doubled line
Ldivc=: 'divc-'&funline	NB. copy line by v%	[not menu]
Ldivl=: 'divl-'&funline	NB. copy line by v	[not menu]
Lequl=: 'equl-'&funline	NB. equal line
Lexpl=: 'expl-'&funline	NB. e^line
Lextl=: 'extl-'&funline	NB. 10^line
Letwl=: 'etwl-'&funline	NB. 2^line
Lhlvl=: 'hlvl-'&funline	NB. halved line
Lintl=: 'intl-'&funline	NB. integer line
Linvl=: 'invl-'&funline	NB. inverted line
Llnnl=: 'lnnl-'&funline	NB. ln line
Lltnl=: 'ltnl-'&funline	NB. log10 line
Lltwl=: 'ltnl-'&funline	NB. log2 line
Lmulc=: 'mulc-'&funline	NB. copy line times v%	[not menu]
Lmull=: 'mull-'&funline	NB. copy line times v	[not menu]
Lnegl=: 'negl-'&funline	NB. negated line
Lpidl=: 'pidl-'&funline	NB. line %PI
Lpiml=: 'piml-'&funline	NB. line *PI
Lptdl=: 'ptdl-'&funline	NB. line %PI2
Lptml=: 'ptml-'&funline	NB. line *PI2
Lsqrl=: 'sqrl-'&funline	NB. squared line
Lsqtl=: 'sqtl-'&funline	NB. square-rooted line
Lsubc=: 'subc-'&funline	NB. copy line subbing v%[not menu]
Lsubl=: 'subl-'&funline	NB. copy line subbing v	[not menu]
Lt1dl=: 't1dl-'&funline	NB. line %10
Lt1ml=: 't1ml-'&funline	NB. line *10
Lt2dl=: 't2dl-'&funline	NB. line %100
Lt2ml=: 't2ml-'&funline	NB. line *100
Lt3dl=: 't3dl-'&funline	NB. line %1000
Lt3ml=: 't3ml-'&funline	NB. line *1000