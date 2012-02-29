CAPT=: 'Asteroid Impact'

TT=: cmx 0 : 0
tn                     tu         ts         td    tf                                            
asteroid radius        m          m          0 0 0                                               
speed!                 mi/h       m/s        0 0 0                                               
relative density!      /          /          0 0 0                                               
asteroid impact energy Hiroshima  m m kg/s/s 1 2 3 (PI*2/3)*(r^3)*(v^2)*d*1000 : r(m),v(m/s),d(/)
)

vquan=: 0 2.5 91000 1 0.902615823578971632
vfact=: 0 1 0.447039999999999937 1 60000000000000
