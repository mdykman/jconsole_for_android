NB. stats/r/rbase
NB. Standard utilities for rserve interface with R

require 'pack strings'

coclass 'rbase'
coinsert 'rserve'
NB. =========================================================
NB. R range
range=: <./ , >./

NB.*rpath v Valid R path from jpath
NB. (R requires '\\' on windows but '/' works on all platforms)
rpath=: '\/' charsub jpath

NB. utils from Inverted Tables essay
ifa=: <@(>"1)@|:  NB. inverted from atomic
afi=: |:@:(<"_1@>)  NB. atomic from inverted
NB. =========================================================
NB. Utilities for working with R map structures

DELIM=: '$'
ATTRIB=: '`'

STRTYP=. 2 65536 131072
istble=. ((2: = {:) *. 2: = #)@$
isstr=. (STRTYP e.~3!:0&>) *./@, 2>#@$&>
iskeys=. (isstr *. 1: = L.)@:({."1)

NB.*ismap v Is y an R map structure
NB. eg: BOOL=: ismap MAPR
ismap=: (iskeys *. istble) f.

NB. parsekey v Parses string of key name for Rmap
NB. returns list of boxed literals describing key
NB.  eg:  parsekey 'terms$`terms.labels'
parsekey=: [: <;._1 DELIM&,@:>

NB.*ndxmap v Indices in MAPR of all keys with leading keys matching x
NB. eg: 'key' ndxmap MAPR
ndxmap=: 4 : 0
  lookup=. parsekey x
  keys=. lookup&((#@[ <. #@]) {. parsekey@])&.> Rmap y
  I. keys e.&> <,:lookup
)

NB.*Rmap v [monad] Returns keys from R map structure
NB. eg: KEYS=: Rmap MAPR
NB. Rmap v [dyad] Returns value(s) from R map structure
NB. result: value(s) of key(s) matching x if exact match,
NB.       or map of trailing keys and values if x matches leading keys
NB. form: key(s) Rmap mapstruct
NB. key is: string of key name delimited by DELIM.
NB.       attribute names are designated by leading ATTRIB
NB. eg: VALUE=: 'qr$qr$`dimnames' Rmap MAPR
NB. eg: VALUE=: 'qr$qr$`dimnames' Rmap MAPR
Rmap=: 3 : 0
  {."1^:ismap y
  :
  try.
    x=. boxopen x
    tmp=. x (ndxmap { ]) y
    if. *./ x&(>@[ =&# ]) &> {."1 tmp do.
      >,/{:"1 tmp
    else.
      keys=. DELIM&joinstring@((#parsekey x) }. parsekey@])&.> Rmap tmp
      keys,.{:"1 tmp
    end.
  catch. empty'' end.
)

NB. isattr v Is a key an attribute?
isattr=: ATTRIB = [: {. &> Rkeys^:ismap

NB.*getattrkeys v Filters y for attributes
NB. eg: getattrkeys Rmap MAPR
NB. eg: getattrkeys 'model' Rmap MAPR
getattrkeys=: #~ isattr

NB.*getnamekeys v Filters y for names
NB. eg: getnamekeys Rmap MAPR
NB. eg: getnamekeys 'model' Rmap MAPR
getnamekeys=: #~ -.@isattr

NB.*getnamekeys v Filters y for top level keys
gettoplevel=: [: ~. DELIM&taketo&.>

NB.*byname a Filter result of u by R name
byname=: 1 : 'getnamekeys_rbase_@:u'

NB.*byattr a Filter result of u by R attribute
byattr=: 1 : 'getattrkeys_rbase_@:u'

NB.*bytoplevel a Filter result of u by top-level keys
bytoplevel=: 1 : 'gettoplevel_rbase_@:u'

NB.*Rkeys v [monad] retrieves R keys from map structure y
NB.  same as monadic Rmap
Rkeys=: 3 : 'Rmap y' 

NB.*Rnamekeys v [monad] retrieves R name keys from map structure y
Rnamekeys=: 3 : 'Rmap byname y'

NB.*Rattrkeys v [monad] retrieves R attribute keys from map structure y
Rattrkeys=: 3 : 'Rmap byattr y'

NB.*Rnames v [monad] retrieves top-level R name keys from map structure y
Rnames=: 3 : 'Rnamekeys bytoplevel y'

NB.*Rattr v [monad] retrieves top-level R attribute keys from map structure y
Rattr=:  3 : 'Rattrkeys bytoplevel y'
NB. =========================================================
NB. Utilities for displaying formated R map structures
NB. and returning data from R map structures based on class of structure

NB.*Rclass v Determines R class of (R map) structure y
NB. If class not explicitly given by key then Rclass tries to  
NB. determine what it is: matrix, call, list, integer, numeric, ...
NB. eg: Rclass IRIS
Rclass=: 3 : 0
 res=. '`class' Rmap y
 if. 0 = >./ #&> boxopen res do.
   res=. empty''
   if. ismap y  do.                 NB. check if map structure
     if. #dat=. '`data' Rmap y do.  NB. if `data attribute present
       NB. rank 2 - matrix ('qr$qr' Rmap MAPR)
       NB. > rank 2 - array
       res=. (;:'vector matrix array'){::~ 1 2 i. #$dat
     else.
       if. 1 = L. y do. 
         res=. 'numeric'            NB. - numeric ('residuals' Rmap MAPR)
       else.
         res=. 'unknown'
       end.
     end.
   else.                            NB. not a map structure
     if. 0 = L. y do.               NB. not boxed
       if. 1 < #$y do. 
         res=. (;:'vector matrix array'){::~ 1 2 i. #$y
       else.
         res=. datatype y
       end.
     else.                          NB. is boxed
       res=. 'list'
       NB. check if boxed list with `NULL in 2nd one - call
       NB. check if boxed list containing literals - character (Rmap 'residuals' Rmap MAPR)
     end.
   end.
 end.
 res
)

NB.*Rshow v Returns "formatted" representation of R map structure y
NB.  the representation depends on the class of the map structure
NB. eg: a data.frame will show row & column labels
NB. eg: Rshow IRIS
Rshow=: 3 : 0
  rclass=. Rclass y
  select. rclass 
  case. 'data.frame' do.
    showDataFrame y
  case. 'floating';'integer';'boolean' do.
    y
  case. 'factor' do.
    showFactor y
  case. 'list' do.
    showList y
  case. 'matrix' do.
    showMatrix y
  case. do.
    (rclass,' class not handled yet') assert 0
  end.
)

NB.*Rdata v Returns data representation of R map structure y
NB.  the representation depends on the class of the map structure
NB.  result: data[;labels]
Rdata=: 3 : 0
  rclass=. Rclass y
  select. rclass 
  case. 'data.frame' do.
    dataDataFrame y
  case. 'floating';'integer';'boolean' do.
    y
  case. 'list' do.
    dataList y
  case. 'factor' do.
    dataFactor y
  case. do.
    (rclass,' class not handled') assert 0
  end.
)

NB.*showDataFrame v Displays representation of R dataframe.
showDataFrame=: 3 : 0
  'Not a data.frame' assert 'data.frame' -: Rclass y
  df=. y
  rlabels=. '`row.names' Rmap df
  clabels=. Rnames df
  data=. clabels <@Rshow@Rmap"0 _ df
  clabels=. (a: #~ 0 < #rlabels), clabels
  clabels ,: (<,.>rlabels) , ,.&.> data
)

showMatrix=: 3 : 0
  'Not a matrix' assert 'matrix' -: Rclass y
  mat=. y
  if. 0 < L. mat do.
    mat=. '`data' Rmap mat
    if. 0< #labels=. '`dimnames' Rmap y do.
      'rlabels clabels'=. labels
      mat=. (,.>rlabels) ,. ' ' ,. ": mat
      hdr=. (({:$,.>rlabels)#' '),' 'joinstring clabels
      mat=. hdr , mat
    end.
  end.
  mat
)

NB.*dataDataFrame v Displays representation of R dataframe.
dataDataFrame=: 3 : 0
  'Not a data.frame' assert 'data.frame' -: Rclass y
  df=. y
  rlabels=. '`row.names' Rmap df
  clabels=. Rnames df
  data=. clabels Rdata@Rmap"0 _ df
  data;< rlabels;<clabels
)

showFactor=: 3 : 0
  'Not a factor' assert 'factor' -: Rclass y
  fac=. y
  >ifa (<:@('`data'&Rmap) { '`levels'&Rmap) fac
)

dataFactor=: 3 : 0
  'Not a factor' assert 'factor' -: Rclass y
  fac=. y
  <:@('`data'&Rmap) fac
)

showList=: >^:(1 = L.)
NB. =========================================================
NB. Exported to the z locale

Rmap_z_=: Rmap_rbase_
Rkeys_z_=: Rkeys_rbase_
Rnamekeys_z_=: Rnamekeys_rbase_
Rattrkeys_z_=: Rattrkeys_rbase_
Rnames_z_=: Rnames_rbase_
Rattr_z_=: Rattr_rbase_

Rclass_z_=: Rclass_rbase_
Rshow_z_=: Rshow_rbase_
Rdata_z_=: Rdata_rbase_
