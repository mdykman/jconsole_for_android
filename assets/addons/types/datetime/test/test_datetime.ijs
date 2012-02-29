NB. =========================================================
NB. Example usage and Testing for datetime

NB. Tests for types/datetime
NB. To run all tests, select all file contents and choose Run|Selection

Note 'To run all tests:'
 load 'types/datetime'
 load 'types/datetime/test/test_datetime'
)

NB. Test data
ttime=: 2009 9 19 18 39 55.765
tdayno=: 76597.77772876
tstdmshms=: 20090907.133031267

tstdayno=: 65101.201 16542.081 85421.246
tstdatefmt0=: '30/03/1978';'17/04/1845';'16/11/2033'
tstdatefmt1=: '30 Mar 1978';'17 Apr 1845';'16 Nov 2033'
tsttimefmt0=: '4:49:26 am';'1:56:38 am';'5:54:14 am'                 NB. Default
tsttimefmt1=: 'Times: 04\49\26';'Times: 01\56\38';'Times: 05\54\14'  NB.'Ti\me\s: hh\\mm\\ss'
tsttimefmt2=: '04:49:26:400';'01:56:38:400';'05:54:14:400'           NB.'hh:mm:ss:ccc'
tsttimefmt3=: '4:49am';'1:56am';'5:54am'                             NB.'h:mmpp'

test=: 3 : 0
  NB. date / day number conversion
  assert 1e_8 > | tdayno - toDayNo ttime
  assert 1e_8 > | ttime - toDateTime tdayno
  assert 1e_8 > | ttime - toDateTime fromJulian toJulian toDayNo ttime
  assert 1e_7 > | (toDayNo ttime) - 1 toDayNo 1&toDateTime toDayNo ttime

  NB. date/time formating
  assert 'September 19, 2009' -: fmtDate toDayNo ttime
  assert 'Saturday, 19 September 2009' -: 'DDDD, D MMMM YYYY' fmtDate toDayNo ttime
  assert 'Day: 19, Month: 9, Year: 09' -: '\Day: D, \Month: M, Year: YY' fmtDate toDayNo ttime
  assert 'Sat, Sep 19, 2009' -: 'DDD, MMM DD, YYYY' fmtDate toDayNo ttime
  assert '19/09/2009' -: 'DD/MM/YYYY' fmtDate toDayNo ttime
  assert tstdatefmt0 -: 'DD/MM/YYYY' fmtDate tstdayno
  assert ($ -: $@fmtDate) 3 4 5 $ tstdayno
  assert '19/9/09' -: 'D/M/YY' fmtDate toDayNo ttime
  assert '6:39:56 pm' -: fmtTime 0 60 60#. _3{. ttime
  assert '18:39:56' -: 'hh:mm:ss' fmtTime 0 60 60#. _3{. ttime
  assert tsttimefmt0 -: fmtTime 86400 * 1|| tstdayno
  assert tsttimefmt1 -: 'Ti\me\s: hh\\mm\\ss' fmtTime 86400 * 1|| tstdayno
  assert tsttimefmt2 -: 'hh:mm:ss:ccc' fmtTime  86400 * 1|| tstdayno
  assert (tstdatefmt1,&.>' ',&.> tsttimefmt3) -: 'D MMM YYYY h:mmpp' fmtDateTime tstdayno

  NB. date/time arithmetic
  diff=. 2009 2 17 3 5 16 daysDiff 2008 10 20 14 26 14
  assert 2009 2 17 3 5 16 -: toDateTime diff + toDayNo 2008 10 20 14 26 14
  assert 0 3 27 12 39 2 -: 2009 2 17 3 5 16 tsDiff 2008 10 20 14 26 14
  assert 0 3 27 13 -: 2009 2 17 3 tsDiff 2008 10 20 14
  assert 0 3 28 -: 2009 2 17 tsDiff 2008 10 20
  assert 2009 2 17 3 5 16 -: 2008 10 20 14 26 14 tsPlus 0 3 27 12 39 2
  assert 2008 10 20 14 26 14 -: 2009 2 17 3 5 16 tsMinus 0 3 27 12 39 2
  assert 2009 1 20 11 20 58 -: 2009 2 17 tsMinus 27 12 39 2
  assert '20090120.1120580' -: 0j7 ": 1 toDateTime toDayNo 2009 2 17 tsMinus 27 12 39 2
  assert 4 5 6 -: $(4 5 3$2009 2 17) tsMinus 27 12 39 2
  assert 2009 1 20 11 20 58 ="1 (4 5 3$2009 2 17) tsMinus 27 12 39 2

  'test_datetime passed'
)

smoutput test''
