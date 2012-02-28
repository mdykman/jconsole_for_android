cocurrent 'base'
coinsert 'jgtk'

run_me=: 3 : 0
wd'pc abc'
wd'pn demo'
wd'xywh 10 20 120 30'
wd'cc e edit'
wd'xywh 10 80 80 30'
wd'cc b button'
wd'cn "press me"'
wd'pshow'
)

abc_close=: 3 : 0
smoutput 'good bye'
wd'pclose'
0
)

abc_b_button=: 3 : 0
smoutput 'hello'
)

abc_e_button=: 3 : 0
smoutput 'what'
)

run_me''
