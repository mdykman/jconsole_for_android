NB. Builds and loads project, then 
NB. loads test_{addonname}.ijs located in the same folder as this script.
buildproject_jproject_ ''
loadtarget_jproject_ ''
TestPath=. getpath_j_ TESTFILE_jproject_
TestFile=.'test_',(#@getpath_j_ }. ]) TARGETFILE_jproject_
cocurrent 'base'
load TestPath,TestFile