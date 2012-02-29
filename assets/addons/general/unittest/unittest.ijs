require 'general/unittest/base'

coclass 'pUnitRun'

attr_ignore=: 4 : 0
  if. 0~:4!:0<a=. cofullname__x y,'_ignore'do.0 return.end.
  if. a~ do.1 return.else.0 return.end.
)

attr_expect=: 4 : 0
  if. 0~:4!:0<a=. cofullname__x y,'_expect'do.''return.end.
  a~
)

errNum=: 13!:11
errMsg=: 13!:12
ERR_NAMES=: 9!:8''

pad=: ' ',~ ' ', '.'#~ 40-#  NB. customizable padding

unittest=: 3 : 0
  r=. 'Test: ',y,LF
  c=. conew 'pUnitBase'
  try.
    script__c y
    
    before_all__c''
    tl=. 'test_'nl__c''
    for_tb. tl do.
      t=. 5}.> tb
      p=. pad t
      rr=. t,p,'OK',LF
      if. c attr_ignore t do.
        rr=. t,p,'Ignored',LF
      else.
        v=. cofullname__c > 'test_',t
        try.
          before_each__c t
          try.
            v~''
          catch.
            e=. (_1+errNum''){::ERR_NAMES
            if. e -: c attr_expect t do.
              rr=. t,p,'OK',LF
            else.
              rr=. t,p,'Fail',LF,errMsg''
            end.
          end.
          after_each__c t
        catch.
          rr=. LF,'Test Error:',LF,(errMsg''),LF
        end.
      end.
      r=. r,rr
    end.
    after_all__c''
  catch.
    r=. r,LF,'Suite Error:',LF,(errMsg''),LF
  end.
  codestroy__c''
  r,LF
)

unittest_z_=: unittest_pUnitRun_

Note 'Single files'
  unittest jpath '~addons/general/unittest/demo/one_test.ijs'
  unittest jpath '~addons/general/unittest/demo/two_test.ijs'
)

Note 'Directory tree'
  require 'dir'
  ;unittest each{."1 dirtree jpath '~addons/general/unittest/demo/*_test.ijs'
)
