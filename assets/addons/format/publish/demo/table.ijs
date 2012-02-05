NB. table

col=: '<col>' , ,&'</col>'
color=: '<high>' , ,&'</high>'
data=: '<data>' , ,&'</data>'
row=: '<row>' , ,&'</row>'
top=: '<top>' , ,&'</top>'
quote=: '"' , ,&'" '

NB. =========================================================
gettable=: 3 : 0
r=. ('get_',y)~''
'<table class=keskey>',r,'</table>',LF
)

NB. =========================================================
get_tab11=: 3 : 0
r=. top 'Sales'
r=. r,row 'London,"New York",Paris,Sydney,Tokyo'
r=. r,col 'Small<br/>0-30%,Medium<br/>30-75%,Large<br/>75-100%,Mixed'
r=. r,data '11% 21% 27% 2% 23% 25% 35% 20% 23% 7% 5% 2% 23% 16% 25% 3% 0% 17% 35% 28%'
)