NB. built from project: ~Addons/general/inifiles/inifiles
NB. =========================================================
NB. general/inifiles
NB. Read from & write to INI files


require 'files regex'
coclass 'rgsini'

NB. =========================================================
NB. utils for rgsini

boxtolower=: 13 : '($y) $ <;._2 tolower ; y ,each {:a.'

NB.*join v Unbox and delimit a list of boxed items y with x
NB. form: Delimiter join BoxedList
NB. eg: '","' join 'item1';'item2'
NB. eg: LF join 'item1';'item2'
NB. eg: 99 join <"0 i.8
NB. based on forum post
NB. http://www.jsoftware.com/pipermail/programming/2007-June/007077.html
NB. see also joinstring in strings script
join=: ' '&$: : (4 : '(;@(#^:_1!.(<x))~  1 0$~0 >. _1 2 p.#) y')

mktbl=: ,:^:(0:>.2:-#@:$)

NB.*makeString v Creates space-delimited string from numeric list, list of boxed literals or numbers
NB. returns: space-delimited string or unchanged y, if y is literal
NB. y is: string, numeric list, list of boxed literals and/or numbers
makeString=: ' ' join 8!:0

NB. ---------------------------------------------------------
NB.*makeVals v Interprets a string as numeric or list of boxed literals
NB. form: [ErrorValue] makeVals String
NB. returns: if y can be interpreted as all numeric, returns numeric list
NB.       elseif y contains spaces or commas, returns list of boxed literals
NB.       else returns original string
NB. y is: a string to interpret
NB. x is: optional numeric value used to signify non-numeric.
NB.       Choose value for x that will not be valid numeric in your data.
makeVals=: 3 : 0
  _999999 makeVals y
  :
  err=. x
  if. L.y do. y return. end.  NB. already boxed
  val=. ', ' charsub y        NB. values delimited by commas and/or spaces
  if. -.+./err= nums=. err&". val do. val=. nums end.
  if. ' ' e. val do. val=. <;._1 ' ',deb val end.
  val
)

patsection=: rxcomp '^\[[[:alnum:]]+\]'  NB. compile pattern
NB. patsection rxmatches inistr
NB. rxfree patsection  NB. frees compiled pattern resources


NB. =========================================================
NB. reading ini structures, strings and files

NB.*parseIni v Parse string contents of an INI file
NB. returns: 5-column boxed table
NB.       (lc section name;lc key name;section name;key name;key string & comments)
NB. y is: string contents of an Ini file
parseIni=: 3 :0
  ini=. }.(patsection&rxmatches rxcut ]) y    NB. cut on section names & drop first
  'snmes secs'=. <"1 |: (] $~ 2 ,~ -:@#) ini  NB. reshape to 2-column table
  snmes=. (<'[]')-.~each snmes
  secs=. parseIniSection each secs
  nkys=. 1 >. #&> secs
  ini=. (nkys#snmes),. ;secs
  (([: boxtolower 2&{."1) ,. ]) ini
)

NB.*parseIniSection v Parse content of INI file section
parseIniSection=: 3 : 0
  keys=. }.<;._2 (],LF -. {:) y    NB. box each line (using LF) and drop first
  msk=. 0< #@> keys                NB. lines of non-zero length
  keys=. msk#keys
  >(_2{. [: <;._1 '==',]) &.> keys NB. box on '='
)

NB. ---------------------------------------------------------
NB.*getIniAllSections v Gets all the keynames and values in an INI file
NB. form: [IniFileContent] getIniAllSections IniFileName
NB. returns: 5-column boxed table,
NB.       0{"1 lowercase sectionnames, 1{"1 lowercase keynames,
NB.       2{"1 sectionnames, 3{"1 keynames, 4{"1 keyvalues and comments
NB. y is: literal filename of Ini file to read. (can be 0-length if x is given)
NB. x is: optional. Either string contents of Ini file, 
NB.       or 5-column boxed table result of parseIni
NB. Where both x & y are given, x is used in preference.
getIniAllSections=: 3 :0
  '' getIniAllSections y
  :
  fln=. 0{:: ,boxopen y
  ini=. x
  if. -.*#ini do.             NB. read Ini from file
    if. -.fexist fln do. '' return. end.  NB. file not found or given
    ini=. freads fln
  end.
  if. (L.=0:) ini do.         NB. parse string contents of Ini file
    ini=. parseIni ini
  else.                       NB. x was already parsed
    ini
  end.
)

NB. ---------------------------------------------------------
NB.*getIniSectionNames v Gets section names from INI file
NB. form: [IniFileContent] getIniSectionNames IniFileName
NB. returns: list of boxed section names from the INI string
NB. y is: literal filename of Ini file to read. Can be 0-length if x given.
NB. x is: optional. String contents of Ini file (LF delimited)
getIniSectionNames=: 3 : 0
  '' getIniSectionNames y
  :
  fln=. 0{:: ,boxopen y
  ini=. x
  if. -.*#ini do. NB. read Ini from file
    if. -.fexist fln do. '' return. end. NB. file not found or given
    ini=. freads fln
  end.
  (<'[]')-.~each patsection rxall ini
)

NB. ---------------------------------------------------------
NB.*getIniIndex v Gets row index of INI key in parsed INI file
NB. form: [IniFileContent] getIniIndex KeyName[;SectionName[;IniFileName]]
NB. returns: 2-item boxed list
NB.       0{:: numeric list of row indicies of INI keys in parsed INI file
NB.       1{:: parsed INI file if not given in x
NB. y is: one of: literal ; 1,2 or 3-item boxed list ; 1,2 or 3-column boxed table.
NB.       literal, 0{:: or 0{"1 is key name(s) to look up
NB.       1{:: or 1{"1 is optional section name(s) of Ini to look for key in
NB.       2{:: or 2{"1 is optional file name of Ini file to read.
NB. x is: optional. Either string contents of Ini file,
NB.       or 5-column table result of parsing Ini file using parseIni
NB. Keyname lookup is case-insensitive.
getIniIndex=: 3 :0
  '' getIniIndex y
  :
  'keyn secn fln'=. <"1|: 3{."1 mktbl boxopen y
  ini=. x
  'All keys must be from same file.' assert 1=#~.fln
  ini=. ini getIniAllSections 0{::fln
  if. -.*#ini do. '' return. end.  NB. error (reading Ini from file)
  parsed=. (L.=0:) x
  NB. look up keyn in 5-column table ini
  if. *./a: = secn do.             NB. no section names given so look up keyn ignoring section
    tbl=. 1{"1 ini
    kys=. keyn
  else.                            NB. look up keyn within section
    tbl=. 2{."1 ini
    kys=. secn,.keyn
  end.
  i=. tbl i. boxtolower kys
  i=. (#ini) (I.keyn=a:)}i         NB. empty keynames never match
  i;< parsed#ini                   NB. return parsed ini if not given in x
)

NB. ---------------------------------------------------------
NB.*getIniStrings v Gets INI key value string(s) from INI array
NB. form: [IniFileContent] getIniStrings KeyName[;SectionName[;IniFileName[;CommentDelimiter]]]
NB. returns: one or more INI key values as list of boxed strings
NB. y is: one of: literal; 1,2,3 or 4-item boxed list; 1,2,3 or 4-column boxed table.
NB.       literal, 0{:: or 0{"1 is key name(s) to look up
NB.       1{:: or 1{"1 is optional section name(s) of Ini to look for key in
NB.       2{:: or 2{"1 is optional file name of Ini file to read.
NB.       3{:: or 3{"1 is optional comment delimiter (defaults to '#')
NB. x is: optional. Either string contents of Ini file,
NB.       or 5-column table result of parsing Ini file using parseIni
NB. Keyname lookup is case-insensitive.
getIniStrings=: 3 : 0
  '' getIniStrings y
  :
  'i ini'=. 2{.!.a: x getIniIndex y
  delim=. 3{:: 4{.{.mktbl boxopen y
  if. 0=#delim do. delim=. '#' end.  NB. default comment delimiter is #
  if. -.*#ini do. ini=. x end.       NB. x was parsed Ini
  dtb@(delim&taketo) each (<i;4){ ini,a:
)

NB. ---------------------------------------------------------
NB.*getIniString v Gets single, unboxed key value string from INI array
NB. form: [IniFileContent] getIniString KeyName[;SectionName[;IniFileName[;CommentDelimiter]]]
getIniString=: 3 : 0
  '' getIniString y
  :
  0{:: x getIniStrings {.mktbl boxopen y
)

NB. ---------------------------------------------------------
NB.*getIniValues v Gets INI key value(s) from an INI array
NB. form: [IniFileContent] getIniValues KeyName[;SectionName[;IniFileName[;CommentDelimiter]]]
NB. returns: one or more INI key values as boxed list of 
NB.       interpreted strings (literal, numeric list or boxed list of literals)
NB. y is: one of: literal; 1,2,3 or 4-item boxed list; 1,2,3 or 4-column boxed table.
NB.       literal, 0{:: or 0{"1 is key name(s) to look up
NB.       1{:: or 1{"1 is optional section name(s) of Ini to look for key in
NB.       2{:: or 2{"1 is optional file name of Ini file to read.
NB.       3{:: or 3{"1 is optional comment delimiter (defaults to '#')
NB. x is: optional. Either string contents of Ini file,
NB.       or 5-column table result of parsing Ini file using parseIni
NB. Keyname lookup is case-insensitive.
getIniValues=: [: makeVals&.> getIniStrings

NB. ---------------------------------------------------------
NB.*getIniValue v Gets single, unboxed key value from INI array
NB. form: [IniFileContent] getIniValue KeyName[;SectionName[;IniFileName[;CommentDelimiter]]]
getIniValue=: [: makeVals getIniString


NB. =========================================================
NB. writing ini structures, strings and files

NB.*makeIni v Create string with INI format from 5-column boxed table
NB. form: makeIni IniTable
NB. returns: literal in format of INI file.
NB. y is: 5-column boxed table (result of parseIni)
makeIni=: 3 : 0
  ini=. _3{."1 y            NB. drop lowercase columns
  'snmes keys'=. split |: ini
  secs=. snmes </. |: keys
  ini=. (~.snmes) makeIniSection each secs
  (],LF -. {:) LF join ini  NB. join with LFs and ensure trailing LF
)

NB.*makeIniSection v Creates INI formated string of an INI section
NB. form: SectionName makeIniSection TableOfKeyValuePairs
NB. returns: literal representation of an Ini section
NB. y is: list of boxed Key;Value pairs for an Ini section
NB. x is: literal section name for all items in y
makeIniSection=: 4 : 0
  'snme sec'=. x;<y
  snme=. '[',snme,']'
  msk=. -.*#&>{."1 sec  NB. where no keyname
  sec=. <@('='&join)"1 sec
  sec=. msk }.&.> sec   NB. drop first ('=') where no keyname
  LF join snme;sec      NB. join lines with LFs
)

NB. ---------------------------------------------------------
NB.*updateIniStrings v Updates key and key value in an INI file
NB. form: [IniFileContent] updateIniStrings KeyValue;KeyName[;SectionName[;IniFileName[;CommentDelimiter]]]
NB. returns: updated 5-column boxed table.
NB. y is: 2,3,4 or 5-item boxed list OR 2,3,4 or 5-column boxed table.
NB.       0{:: or 0{"1 is key value(s) to update
NB.       1{:: or 1{"1 is key name(s) to update
NB.       2{:: or 2{"1 is section name(s) of Ini to look for key in
NB.       3{:: or 3{"1 is optional file name of Ini file.
NB.       4{:: or 4{"1 is optional comment delimiter (defaults to '#')
NB. x is: optional. Either string contents of Ini file,
NB.       or 5-column table result of parsing Ini file using parseIni
NB. Keyname lookup is case-insensitive.
NB. Sections and keys not found in current Ini are appended.
updateIniStrings=: 3 : 0
  '' updateIniStrings y
  :
  'val knme snme fnme delim'=. <"1|: 5{."1 y=. mktbl boxopen y
  val=. makeString each val
  'i ini'=. 2{.!.a: x getIniIndex }."1 y
  if. -.*#ini do. ini=. x end.  NB. x was parsed Ini
  msk=. i<#ini                  NB. existing keys to amend
  ini=. (msk#val) (<(msk#i);4) } ini
  msk=. (-.msk) *. a:~:knme     NB. new, non-empty key names to append
  ini=. ini, (boxtolower@(2&{."1) ,. ]) msk#snme,.knme,.val
)

NB. ---------------------------------------------------------
NB.*writeIniAllSections v Writes Ini string or table to an Ini file.
NB. form: IniFileContent writeIniAllSections TargetIniFileName
NB. returns: bytes written if success, else _1
NB. y is: literal filename to write to.
NB. x is: ini file in literal or boxed table form.
writeIniAllSections=: 4 : 0
  fln=. 0{:: ,boxopen y
  ini=. x
  if. (L.=1:) ini do.  NB. reformat to string
    ini=. makeIni ini
  end.
  ini fwrites fln
)

NB. ---------------------------------------------------------
NB.*writeIniStrings v Writes updated key and key value to an INI file
NB. form: [IniFileContent] writeIniStrings KeyValue;KeyName[;SectionName[;IniFileName[;CommentDelimiter]]]
NB. returns: Boolean, 1 if wrote OK, otherwise 0.
NB. y is: 2,3,4 or 5-item boxed list OR 2,3,4 or 5-column boxed table.
NB.       0{:: or 0{"1 is key value(s) to write
NB.       1{:: or 1{"1 is key name(s) to write
NB.       2{:: or 2{"1 is section name(s) of Ini to look for key in
NB.       3{:: or 3{"1 is file name of Ini file to write to.
NB.       4{:: or 4{"1 is optional comment delimiter (defaults to '#')
NB. x is: optional. Either string contents of Ini file,
NB.       or 5-column table result of parsing Ini file using parseIni
NB. Keyname lookup is case-insensitive.
NB. If x is not given, the Ini file will be read from and written to the file name in y.
NB. Sections and keys not found in current Ini are appended.
writeIniStrings=: 3 : 0
  '' writeIniStrings y
  :
  ini=. x updateIniStrings y
  'All keys must be from same file.' assert 1=# fln=. ~. 3{"1 mktbl y
  ini writeIniAllSections 0{::fln  NB. write ini boxed table to file
)


NB. =========================================================
NB. Definitions exported to z locale

getIniAllSections_z_=: getIniAllSections_rgsini_
getIniIndex_z_=: getIniIndex_rgsini_
getIniString_z_=: getIniString_rgsini_
getIniStrings_z_=: getIniStrings_rgsini_
getIniValue_z_=: getIniValue_rgsini_
getIniValues_z_=: getIniValues_rgsini_
updateIniStrings_z_=: updateIniStrings_rgsini_
writeIniAllSections_z_=: writeIniAllSections_rgsini_
writeIniStrings_z_=: writeIniStrings_rgsini_
makeVals_z_=: makeVals_rgsini_

