NB. =========================================================
NB. Utilities for working with verbs with multiple arguments
NB.  * can specify default values for args
NB.  * arguments given as name-value pairs in 2-col table
NB.  * allows list of first n args in expected order
NB.  * verb user cannot define un-expected arg names

require 'pack'

coclass 'pargs'

NB.*makeTable v Reshape y as 2-column table
NB. use to coerce list of boxes to 2-column table
makeTable=: _2 [\ ,

NB.*isList v Is y less than rank 2?
isList=: 2 > #@$@]

NB.*paramListToTable v Stiches on the first N parameter names to the input list
NB. adapted from Dan Brons parameterized_verbs script.
paramListToTable=: (([: ({."1@:[ ,. ,@:])&>/ <.&# {.&.> ,&<) boxxopen)^:isList

NB.*packarg v Package namelist
NB. result: 2-column table of boxed name-value pairs
NB. Similar to pack from pack.ijs but doesn't sort names
NB. eg: packargs 'imm frq int pay'
packargs=: [: (, ,&< ".)&> ;:@] :: ]

NB.*getArgs v Resolves defaults and specified parameters as table of 2-col name-value pairs
NB. result: 2-column table of name-value pairs
NB. used at start of multi-param verb to override default values
NB. y is: list of boxed parameter values in expected order
NB.       or 2-column table of name-value pairs in any order
NB. x is: list of argument names in expected order (boxed or space-delimited string)
NB. Names in x must have already been defined (default values)
getArgs=: ([ psel packargs@[ pset~ packargs@[ paramListToTable ]) f.

NB. =========================================================
NB. Export to z locale
makeTable_z_=: makeTable_pargs_
getArgs_z_=: getArgs_pargs_

NB. =========================================================
NB. Example usage

Note 'example usage in verb definition'

NB. version of npv with imm and frq set to defaults
NB. y is a list of name/value pairs or a table of same
npv=: 3 : 0
  args=.  'imm frq    int          pay'
  (args)=.  0 ; 12 ;0.10 5 0.09 ; (12#1) 
  (args)=. {:"1 args getArgs y         NB. update defaults
...
)   NB. remove this comment to finish verb

npv makeTable 'pay';(24#1);'int';0.10 5 0.09


getWeaned=: 3 : 0
  args=. ;: 'ndams weanrate sexratio'  NB. Parameters
  (}. args)=.         1.2     0.5      NB. default values
  (args)=. {:"1 args getArgs y         NB. update defaults
  ((] , -.) sexratio) * weanrate * ndams
) NB. remove this comment to finish verb

NB. use all defaults
getWeaned ''

NB. use list of boxed params
getWeaned 300;1.2;0.5

NB. use partial list of boxed params
getWeaned 300;1.2

NB. use name-value pairs
getWeaned (;:'weanrate ndams sexratio'),.1.3;300;0.55
NB. OR
getWeaned makeTable 'weanrate';1.3;'ndams';300;'sexratio';0.55

NB. use partial list of name-value pairs
getWeaned (;:'weanrate ndams'),.1.2;300
)

