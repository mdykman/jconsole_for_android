NB. Sierpinksi Carpet by (OR dot AND) matrix product
NB.
NB. Try different values for P
NB. P=2 gives Sierpinksi's Triangle

P=. 3
S=. 243

Y=. P&#. inverse i.S
CLR=. (STDCLR-.j),~j=. YELLOW,BLUE,GREEN,BROWN,RED

(P$CLR) vmat Y +./ . *. |: Y
