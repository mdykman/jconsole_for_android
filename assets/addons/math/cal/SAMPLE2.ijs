CAPT=: 'Pseudogravity by rotation'

TT=: cmx 0 : 0
tn                         tu    ts    td     tf                           
Frequency; hertz!          Hz    /s                                        
r:radius of circuit        km    m                                         
circumference              km    m          2 a*2*PI: a(km)                
v:rotational speed         km/s  m/s      1 3 a*b:    a(cyc/sec),b(km)     
c:centripetal acceleration m/s/s m/s/s    4 2 v*v/r:  v(m/s),r(m)          
i:selector (1 or 2)        /     /                                         
g:earth gravity unit!      m/s/s m/s/s                                     
a:mars gravity unit!       m/s/s m/s/s                                     
target pseudogravity       *     *      6 7 8 i choice(a,b): i(/),a(*),b(*)
Set "U" to force equal     *     *        5 9 a/b:           a(m/s/s),b(*) 
)

vquan=: _. 0.0166666669999999996 0.338311409999999979 2.12567328056320859 0.0354278887179445695 3.70999990514970879 0 9.8100000000000005 3.70999999999999996 9.8100000000000005 0.378185515305780706
vfact=: _. 1 1000 1000 1000 1 1 1 1 1 1
