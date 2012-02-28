NB. data
NB.
NB. following globals are defined from corresponding
NB. lif files from Al Hensel's collection.
NB.
NB. ACORN
NB. BIGUN
NB. COERAKE1
NB. GLIDERGUN
NB. PUFTRAIN
NB. RABBITS
NB. RELAY
NB. SPACEGUN
NB. SPIRAL

LIFS=: ;: 'acorn bigun coerake1 glidergun puftrain rabbits relay spacegun spiral'

NB. =========================================================
ACORN=: 0 : 0
#Life 1.05
#D Acorn
#D The most vigorously growing 7-cell
#D "methuselah" pattern.  See also RABBITS.
#N
#P -3 -1
.*
...*
**..***
)

NB. =========================================================
BIGUN=: 0 : 0
#Life 1.05
#D Two-barrelled p46 glider gun
#D found by Bill Gosper.
#N
#P -9 -7
***
..*
..*
.*
.
.*
..*
..*
***
#P 6 -3
***
*
*
.*
.
.*
*
*
***
#P 23 -3
**
.*
#P -25 0
*
**
)

NB. =========================================================
COERAKE1=: 0 : 0
#Life 1.05
#D p16 backward rake
#D A very simple construction: just
#D four *WSS and an extra cell.  By
#D Tim Coe, 1996.
#N
#P 4 -4
....**
****.**
.*****
..***
#P 5 2
.****
*...*
....*
...*
#P -6 -10
.******
*.....*
......*
.....*
#P -4 5
....**
****.**
******
.****
)

NB. =========================================================
GLIDERGUN=: 0 : 0
#Life 1.05
#D p30 glider gun (the Original)
#D
#D This is made of two of a pattern
#D know as the "queen bee", which
#D sometimes occurs naturally,
#D whose debris can be deleted on
#D the sides by blocks or eaters.
#D But a collision in the center
#D can, as seen here, miraculously
#D form a glider. Just one of these
#D moving back and forth is called
#D piston (see the p30 in OSCSPN2).
#N
#P 4 -5
....*
.****
****
*..*
****
.****
....*
#P 13 -4
*
*
#P -6 -3
..*
.*.*
*...**
*...**
*...**
.*.*
..*
#P 17 -2
**
**
#P -17 0
**
**
)


NB. =========================================================
PUFTRAIN=: 0 : 0
#Life 1.05
#D Puffer train
#D
#D This was created simply by perturbing
#D the sides of a B-heptomino with two
#D LWSS's.  A B-heptomino is a naturally
#D occurring object that lurches forward at
#D the speed c/2 before its own debris
#D usually destroys it.  Not here!  The
#D LWSS keep it alive.  See BHEPTO, RAKE,
#D RAKE2.  For a super dirty puffer, see
#D LINEPUF.
#N
#P -2 -8
...*
....*
*...*
.****
#P -2 -1
*
.**
..*
..*
.*
#P -2 6
...*
....*
*...*
.****
)

NB. =========================================================
RABBITS=: 0 : 0
#Life 1.05
#D Rabbits
#D Another small but vigorously growing population.
#D (If you look closely you can see a male and female rabbit!)
#D Andrew Trevorrow discovered Rabbits in 1986 using a
#D Methuselah search program.
#N
#P -3 -1
*...***
***..*
.*
)

NB. =========================================================
RELAY=: 0 : 0
#Life 1.05
#D Relay with pit stops
#D Authors: David Bell, Dean Hickerson.
#N
#P -56 -60
***
*
.*
#P -61 -59
**
...*
*
....*
....*
.
..**
.*
#P -70 -61
....**
...***
*.**
*..*
*.**
...***
....**
#P -77 -58
**
**
#P -63 -49
**...**
**...**
.*****
..*.*
.
..***
#P -65 -40
..**
...*
***
*
#P -61 -38
..**
.*.*
.*
**
#P -52 -43
...*
..**
.**
***
.**
..**
...*
#P -45 -41
**
**
**
.
.
***
***
#P -47 -31
**...**
.*****
..***
...*
#P -49 -22
..**
...*
***
*
#P -45 -20
..**
.*.*
.*
**
#P -33 -25
*
*.*
.*.*
.*..*
.*.*
*.*
*
#P -31 -17
...*
..*.*
.*...*
..***
**...**
#P -33 -4
..**
...*
***
*
#P -29 -2
..**
.*.*
.*
**
#P -20 -7
**
***
..**.*
..*..*
..**.*
***
**
#P -15 3
..***
.
..*.*
.*****
**...**
**...**
#P -15 11
...*
.**
.
*
.
.*..*
...**
#P 54 57
.*
..*
***
#P 57 51
...*
.**
.
*
*
....*
.*
...**
#P 65 54
**
***
..**.*
..*..*
..**.*
***
**
#P 76 56
**
**
#P 57 43
..***
.
..*.*
.*****
**...**
**...**
#P 62 36
...*
.***
*
**
#P 58 34
..**
..*
*.*
**
#P 49 36
*
**
.**
.***
.**
**
*
#P 43 34
***
***
.
.
.**
.**
.**
#P 41 27
...*
..***
.*****
**...**
#P 46 18
...*
.***
*
**
#P 42 16
..**
..*
*.*
**
#P 29 18
....*
..*.*
.*.*
*..*
.*.*
..*.*
....*
#P 25 12
**...**
..***
.*...*
..*.*
...*
#P 30 0
...*
.***
*
**
#P 26 -2
..**
..*
*.*
**
#P 15 0
....**
...***
*.**
*..*
*.**
...***
....**
#P 9 -9
**...**
**...**
.*****
..*.*
.
..***
#P 11 -18
**
*..*
.
....*
.
..**
.*
)

NB. =========================================================
SPACEGUN=: 0 : 0
#Life 1.05
#D Lightweight Spaceship gun
#D by Dieter Leithner, Oct 1993
#N
#P -22 -13
**
**
.
.
.
.
.
.
**
**
#P -5 -21
*
**
.**
**
.
.
.
**
.**
**
*
#P 8 -17
***
*
*
.*
.
.*
*
*
***
#P 25 -17
**
**
#P -23 12
**.*...*.**
*..*...*..*
.***...***
#P -26 19
**.............**
**..**.....**..**
....**.....**
)

NB. =========================================================
SPIRAL=: 0 : 0
#Life 1.05
#D Spiral decay
#D A glider's work is never done.
#D Dean Hickerson, dean@ucdmath.ucdavis.edu  4/10/91
#N
#P -15 -27
.*
***
*.**
.***
.**
#P -10 -25
...*
..***
.**..*
.**.**
.*..***
..*.**
....*
*...*
.*.*
..*
#P -1 -27
.*
***
*.**
.***
.**
#P -16 -18
.***
*..*
...*
...*
..*
#P 23 -14
.****
*...*
....*
*..*
#P 20 -9
.**
*****
*....*
***..*
.*..**
..**
#P 23 0
.****
*...*
....*
...*
#P 15 -14
..**
**.**
****
.**
#P 3 22
.**
.***
*.**
***
.*
#P 9 17
...*
.**.**
.
*.*...*
*...*
**..*
.***
..*
#P 17 22
.**
.***
*.**
***
.*
#P 16 13
..*
...*
...*
*..*
.***
#P -28 16
.*..*
*
*...*
****
#P -28 2
.*
*
*...*
****
#P -26 9
..**
**..*
*..***
*....*
.*****
...**
#P -20 16
..**
.****
**.**
.**
#P -10 1
****
*...*
*
.*
#P 0 -9
..*
.***
**.*
***
.**
#P 5 1
...*
....*
*...*
.****
#P 0 4
.**
***
**.*
.***
..*
#P -7 6
.*
*.*
.**
#P -4 -4
.*
*.*
**
#P 4 -3
**
*.*
.*
#P 0 -1
.*
.**
*.*
)

NB. =========================================================
cmd=. (<'=: setpattern bind ''') ,each LIFS ,each <'''',LF
0!:100 ; (<'cb_pat_') ,each LIFS ,each cmd

NB. =========================================================
cb_pat_random=: 3 : 0
setpattern 0 = ? BOARD $ 10
)
