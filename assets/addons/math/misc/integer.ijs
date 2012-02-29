NB. math/misc/integer
NB. Verbs to generate various integer sequences
NB. version: 1.0.0

NB. inta   augmented integers     inta 4    is  1 2 3 4
NB. inte   extended integers      inte 4    is  0 1 2 3 4
NB. ints   symmetric integers     ints 4    is  _4 _3 _2 _1 0 1 2 3 4
NB. intm   minus integers         intm _4   is  _1 _2 _3 _4
NB. intn   normal integers        intn _4   is  0 _1 _2 _3
NB. intr   reflexive integers     intr 4    is  3 2 1 0 1 2 3
NB. jint   complex integers       jint 2 3  is  (j. i.2) +/ i.3
NB. jints  complex symmetric ints jints 1 2 is  (j. i:1) +/ i:2
NB.
NB. Examples:
NB.
NB.    inta each _5 0 5
NB. +---------++---------+
NB. |5 4 3 2 1||1 2 3 4 5|
NB. +---------++---------+
NB.
NB.    inte each _5 0 5
NB. +-----------+-+-----------+
NB. |5 4 3 2 1 0|0|0 1 2 3 4 5|
NB. +-----------+-+-----------+
NB.
NB.    ints each _5 0 5
NB. +--------------------------+-+--------------------------+
NB. |5 4 3 2 1 0 _1 _2 _3 _4 _5|0|_5 _4 _3 _2 _1 0 1 2 3 4 5|
NB. +--------------------------+-+--------------------------+
NB.
NB.    intm each _5 0 5
NB. +--------------++---------+
NB. |_1 _2 _3 _4 _5||0 1 2 3 4|
NB. +--------------++---------+
NB.
NB.    intn each _5 0 5
NB. +-------------++---------+
NB. |0 _1 _2 _3 _4||0 1 2 3 4|
NB. +-------------++---------+
NB.
NB.    intr each _5 0 5
NB. +-----------------++-----------------+
NB. |0 1 2 3 4 3 2 1 0||4 3 2 1 0 1 2 3 4|
NB. +-----------------++-----------------+
NB.
NB.    intj 3 4
NB.   0   1   2   3
NB. 0j1 1j1 2j1 3j1
NB. 0j2 1j2 2j2 3j2
NB.
NB.    intjs 1 3
NB. _3j_1 _2j_1 _1j_1 0j_1 1j_1 2j_1 3j_1
NB.    _3    _2    _1    0    1    2    3
NB.  _3j1  _2j1  _1j1  0j1  1j1  2j1  3j1

NB.*inta v Augmented integers     
NB. eg: inta 4    is  1 2 3 4
inta=: >:@i.

NB.*inte v Extended integers
NB. eg: inte 4    is  0 1 2 3 4
inte=: i.@(+ (* + 0&=))

NB.*ints v Symmetric integers
NB. eg: ints 4    is  _4 _3 _2 _1 0 1 2 3 4
ints=: i:

NB.*intm v Minus integers
NB. eg: intm _4   is  _1 _2 _3 _4
intm=: i. + (* 0&>)

NB.*intn v Normal integers
NB. eg: intn _4   is  0 _1 _2 _3
intn=: * * i.@|

NB.*intr v Reflexive integers
NB. eg: intr 4    is  3 2 1 0 1 2 3
intr=: |@i:

NB.*jint v Complex integers
NB. eg: jint 2 3  is  (j. i.2) +/ i.3
jint=: j.~/&i./

NB.*jints  complex symmetric ints
NB. eg: jints 1 2 is  (j. i:1) +/ i:2
jints=: j.~/&i:/
