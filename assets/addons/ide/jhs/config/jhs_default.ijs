NB. JHS initialization loads files to initialize
NB.  loads
NB.   ~addons/ide/jhs/config/jhs_default.ijs
NB.  then loads first file (if any) that exists from
NB.   jhs x argument (error if not '' and does not exist)
NB.   ~config/jhs.ijs
NB.   ~addons/ide/jhs/config/jhs.ijs

NB. jhs_default.ijs is a default/template (do not edit)
NB. copy 2nd and 3rd from default and edit as required

NB. custom configs (2nd/3rd files) need not be a complete
NB. and can just change specific things

NB. JAL or installer creates new jhs_default.ijs
NB. with luck old later files may still work

NB. private port range 49152 to 65535
PORT=: 65001

NB. 0 localhost jlogin if PASS set
NB. 1 localhost ok (no jlogin even if PASS set)
LHOK=: 1

NB. 'localhost' access from same machine
NB. 'any' access from any machine (should have PASS set)
BIND=: 'localhost'

NB. ''    no jlogin
NB. '...' jlogin password
PASS=: ''

NB. user for PASS
NB. JUM ignores and sets USER to be JUM username (jhs folder)
USER=: ''
