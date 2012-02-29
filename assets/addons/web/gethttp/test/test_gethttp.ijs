NB. =========================================================
NB. Tests for web/gethttp

Note 'To test'
  load 'web/gethttp'
  load 'web/gethttp/test/test_gethttp'
)

require 'files'

NB. Test nouns
  TestURL=: 'http://www.google.com/privacy_faq.html'
  TestCntFile=: jpath '~temp/gethttp_cnt.html'
  TestDefFile=: jpath '~temp/privacy_faq.html'
  TestLogFile=: jpath '~temp/gethttp_log.html'

NB. Test utils

NB. checkFile v Check file exists & contents match x, Erase.
NB. eg: noun checkfile filename
checkFile=: 3 : 0
  URLcnt checkFile y
:
  if. res=. fexist y do.
    if. #x do.
      res=. res, (toJ URLcnt) -: fread y
    end.
    ferase y
  end.
  res
)

NB. Tests
test=: 3 : 0
  try.
    CurrDir=. 1!:43 ''
    1!:44 jpath '~temp/'
    URLcnt=: gethttp TestURL
    assert 2000 < #URLcnt
    assert +./ 'Google' E. URLcnt
    
    assert URLcnt -: 'stdout' gethttp TestURL

    log=. 'file' gethttp TestURL
    assert 5 < #log
    assert checkFile TestDefFile

    log=. ('file';'') gethttp TestURL
    assert 5 < #log
    assert checkFile TestDefFile

    help=. 'help' gethttp ''
    assert +./ 'Usage:' E. help

    log=. ('file';TestCntFile) gethttp TestURL
    if. IFUNIX = UNAME -: 'Darwin' do. assert 30 < #log end. NB.Don't Test Linux
    assert checkFile TestCntFile

    NB. content saved to file, log saved to file
    if. IFUNIX = UNAME -: 'Darwin' do.  NB. cURL options
      opts=. '-o ',TestCntFile,' --stderr ',TestLogFile
    else.                                NB. Wget options
      opts=. '-O ',TestCntFile,' -o ',TestLogFile
    end.
    opts gethttp TestURL
    assert checkFile TestCntFile
    assert '' checkFile TestLogFile

    1!:44 CurrDir
    'test_gethttp passed'
  catch.
    1!:44 CurrDir
    13!:12 ''  NB. report last error
  end.
)

smoutput test ''

Note 'test commands for gethttp'
  1!:44 jpath '~temp' NB. ensure in user writeable folder
  gethttp 'http://www.jsoftware.com'
  'stdout' gethttp 'http://www.jsoftware.com'
  'help' gethttp ''
  'file' gethttp 'http://www.jsoftware.com/index.html'
  ('file';'') gethttp 'http://www.jsoftware.com/index.html'
  ('file';TestCntFile) gethttp 'http://www.jsoftware.com'
)

Note 'Example raw options for Wget (Linux)'
  NB. The following use raw Wget options.
  NB. content retrieved from stdout, log suppressed
  ]cnt=. '-O - -q' gethttp 'http://www.jsoftware.com'
  NB. content & log retrieved from stdout
  ]all=. ('-O -') gethttp 'http://www.jsoftware.com'
  NB. content retrieved from stdout, log saved to file
  ]cnt=. ('-O - -o ',jpath '~temp/gethttp.log') gethttp 'http://www.jsoftware.com'
  NB. file copied to current dir, log suppressed
  '-q' gethttp 'http://www.jsoftware.com'
  NB. file copied to current dir, log retrieved from stdout
  ]log=. '' gethttp 'http://www.jsoftware.com'
  NB. file copied to current dir, log saved to file
  ('-o ',jpath '~temp/gethttp.log') gethttp 'http://www.jsoftware.com'
  NB. content saved to file, log suppressed
  ('-O ',(jpath '~temp/jindex.htm'),' -q') gethttp 'http://www.jsoftware.com'
  NB. content saved to file, log retrieved from stdout
  ]log=. ('-O ',jpath '~temp/jindex.htm') gethttp 'http://www.jsoftware.com'
  NB. content saved to file, log saved to file
  ('-O ',(jpath '~temp/jindex.htm'),' -o ',jpath '~temp/gethttp.log') gethttp 'http://www.jsoftware.com'
)

Note 'Example raw options for cURL (Win/Mac)'
  NB. The following use raw cURL options. (untested)
  NB. content retrieved from stdout, log suppressed
  ]cnt=. '-o - -s -S' gethttp 'http://www.jsoftware.com'
  NB. content & log retrieved from stdout
  ]all=. ('-o - --stderr -') gethttp 'http://www.jsoftware.com'
  NB. content retrieved from stdout, log saved to file
  ]cnt=. ('-o - --stderr ',jpath '~temp/gethttp.log') gethttp 'http://www.jsoftware.com'
  NB. file copied to current dir, log suppressed
  '-O -s -S' gethttp 'http://www.jsoftware.com/index.html'
  NB. file copied to current dir, log retrieved from stdout
  ]log=. '-O --stderr -' gethttp 'http://www.jsoftware.com/index.html'
  NB. file copied to current dir, log saved to file
  ('-O --stderr ',jpath '~temp/gethttp.log') gethttp 'http://www.jsoftware.com/index.html'
  NB. content saved to file, log suppressed
  ('-o ',(jpath '~temp/jindex.htm'),' -s -S') gethttp 'http://www.jsoftware.com'
   NB. content saved to file, log retrieved from stdout
  ]log=. ('-o ',(jpath '~temp/jindex.htm'),' --stderr -') gethttp 'http://www.jsoftware.com'
  NB. content saved to file, log saved to file
  ('-o ',(jpath '~temp/jindex.htm'),' --stderr ',jpath '~temp/gethttp.log') gethttp 'http://www.jsoftware.com'
  NB. help
  '--help' gethttp ''
)
