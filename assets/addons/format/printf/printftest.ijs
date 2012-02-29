display=: (i.0 0)"_ ((1!:2) 2:)
display&('Error count: '&,)@: ": @: (+/) @: (1&~:) @: (".;._2) (0 : 0)
'No fields' -: 'No fields' sprintf ''
'This has %% no fields % either' -: 'This has %%%% no fields %% either' sprintf ''
'%% This has %1% field' -: '%%%% This has %%%d%% field' sprintf 1
92 39 10 9 8 13 12 13 10 -: a. i. '\\\''\l\t\b\r\f\n' sprintf ''
'Testing ?verb?, should type        0 1 3' -: 'Testing ?verb?, should type %12?+/\?d' sprintf <i. 3
('Verifying escapes.',CR,LF,'This is line 1',CR,LF,'This is line 2') -: 'Verifying escapes.\nThis is line %d\nThis is line %d' sprintf 1;2
':1:' -: ':%d:' sprintf 1
'55' -: '%u' sprintf 55
'4294967241' -: '%u' sprintf _55
':  1:' -: ':%3d:' sprintf 1
': 1 :' -: ':%^3d:' sprintf 1
':1  :' -: ':%-3d:' sprintf 1
':001:' -: ':%.3d:' sprintf 1
':  001:' -: ':%5.3d:' sprintf 1
':10:' -: ':%o:' sprintf 8
':010:' -: ':%#o:' sprintf 8
':1a:' -: ':%x:' sprintf 26
':1A:' -: ':%X:' sprintf 26
':0x1a:' -: ':%#x:' sprintf 26
':0X1A:' -: ':%#X:' sprintf 26
'ffffffe6' -: '%x' sprintf _26
':5.000000:' -: ':%f:' sprintf 5
':5.000:' -: ':%.3f:' sprintf 5
':5.500:' -: ':%.3f:' sprintf 5.5
':  5.500:' -: ':%7.3f:' sprintf 5.5
': +5.500:' -: ':%+7.3f:' sprintf 5.5
': 5.500:' -: ':% .3f:' sprintf 5.5
':-5.500:' -: ':%.3f:' sprintf _5.5
': 5.500000e0:' -: ':%e:' sprintf 5.5
': 5e0:' -: ':%.0e:' sprintf 5
': 2e3:' -: ':%.0e:' sprintf 1500
': 5.500000E0:' -: ':%E:' sprintf 5.5
':5.500000:' -: ':%g:' sprintf 5.5
': 5.000000e8:' -: ':%g:' sprintf 500000000
':-5:' -: ':%d:' sprintf _5
': -0005:' -: ':%6.4d:' sprintf _5
':  0005:' -: ':%6.4d:' sprintf 5
': +0005:' -: ':%+6.4d:' sprintf 5
':    +5:' -: ':%+6d:' sprintf 5
':    -5:' -: ':%+6d:' sprintf _5
':000005:' -: ':%06d:' sprintf 5
':-00005:' -: ':%06d:' sprintf _5
':+00005:' -: ':%+06d:' sprintf 5
':-00005:' -: ':%+06d:' sprintf _5
':000005:' -: ':%06.3d:' sprintf 5
':-00005:' -: ':%+06.3d:' sprintf _5
'xxx' -: '%s' sprintf <'xxx'
'xx' -: '%.2s' sprintf <'xxx'
'xx' -: '%?}.?s' sprintf <'xxx'
'bc' -: '%.2?}.?s' sprintf <'abcd'
'A string and the number 5.' -: 'A %s and the number %d.' sprintf 'string';5
'A list of strings and the numbers 1 2 3.' -: 'A %S and the numbers %d.' sprintf ('list';'of';'strings');1 2 3
'Heterogeneous list of strings and 2 numbers' -: 'Heterogeneous list of strings %S' sprintf < 'and';2;'numbers'
'50.5% complete.' -: '%0.1?*&100?f%% complete.' sprintf 0.505
'AAA' -: 'AAA' vsprintf 0
'AAA0' -: 'AAA%d' vsprintf 0
'AAA5BBxxx' -: 'AAA%dBB%s' vsprintf 5;'xxx'
'AAA_10CC' -: 'AAA%jCC' vsprintf _10
'AAA10BBxxx' -: 'AAA%jBB%j' vsprintf 10;'xxx'
0 0 0 -: 'xxx%d' vsprintf b. 0
1 1 1 -: 'xxx%d%d' vsprintf b. 0
(<;._1 ' AabBcdC AefBghC AijBklC') -: 'A%sB%sC' vbsprintf 3 2 $ 'ab';'cd';'ef';'gh';'ij';'kl'
(<;._1 ' AabBcd AefBgh AijBkl') -: 'A%sB%s' vbsprintf 3 2 $ 'ab';'cd';'ef';'gh';'ij';'kl'
(<;._1 ' AabB AcdB AefB') -: 'A%sB' vbsprintf 3 $ 'ab';'cd';'ef'
(<;._1 ' abBcd efBgh ijBkl') -: '%sB%s' vbsprintf 3 2 $ 'ab';'cd';'ef';'gh';'ij';'kl'
(<;._1 ' abcd efgh ijkl') -: '%s%s' vbsprintf 3 2 $ 'ab';'cd';'ef';'gh';'ij';'kl'
(<;._1 ' ab cd ef') -: '%s' vbsprintf 3 $ 'ab';'cd';'ef'
(<;._1 ' Aab Acd Aef') -: 'A%s' vbsprintf 3 $ 'ab';'cd';'ef'
(<;._1 ' abB cdB efB') -: '%sB' vbsprintf 3 $ 'ab';'cd';'ef'
(<;._1 ' AabBcdC AefBghC AijBklC') -: 'A%jB%sC' vbsprintf 3 2 $ 'ab';'cd';'ef';'gh';'ij';'kl'
(<;._1 ' AabBcd AefBgh AijBkl') -: 'A%jB%s' vbsprintf 3 2 $ 'ab';'cd';'ef';'gh';'ij';'kl'
(<;._1 ' AabB AcdB AefB') -: 'A%jB' vbsprintf 3 $ 'ab';'cd';'ef'
(<;._1 ' abBcd efBgh ijBkl') -: '%jB%s' vbsprintf 3 2 $ 'ab';'cd';'ef';'gh';'ij';'kl'
(<;._1 ' abcd efgh ijkl') -: '%s%j' vbsprintf 3 2 $ 'ab';'cd';'ef';'gh';'ij';'kl'
(<;._1 ' ab cd ef') -: '%j' vbsprintf 3 $ 'ab';'cd';'ef'
(<;._1 ' Aab Acd Aef') -: 'A%j' vbsprintf 3 $ 'ab';'cd';'ef'
(<;._1 ' abB cdB efB') -: '%jB' vbsprintf 3 $ 'ab';'cd';'ef'
(<;._1 ' AabBcdC AefBghC AijBklC') -: 'A%jB%jC' vbsprintf 3 2 $ 'ab';'cd';'ef';'gh';'ij';'kl'
(<;._1 ' AabBcd AefBgh AijBkl') -: 'A%jB%j' vbsprintf 3 2 $ 'ab';'cd';'ef';'gh';'ij';'kl'
(<;._1 ' abBcd efBgh ijBkl') -: '%jB%j' vbsprintf 3 2 $ 'ab';'cd';'ef';'gh';'ij';'kl'
(<;._1 ' abcd efgh ijkl') -: '%j%j' vbsprintf 3 2 $ 'ab';'cd';'ef';'gh';'ij';'kl'
)
