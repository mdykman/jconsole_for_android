require '~addons/net/clientserver/jssc.ijs'

coclass 'jdbclient'
coinsert 'jssc'
checkrc=: >@{:`(>@{: (13!:8) 3:)@.(0 ~: >@{.)
jdb=: checkrc @ calljdb
