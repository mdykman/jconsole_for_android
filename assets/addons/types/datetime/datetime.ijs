NB. =========================================================
NB. types/datetime
NB. Addon for extending the dates.ijs system script.
NB. Ric Sherlock, 2009 09 09
NB. Some of the verbs in this script were derived from 
NB. APL+Win functions written by Davin Church.

require 'dates dll strings'
NB. require 'numeric'  NB. round is defined in numeric but is not yet in J7

coclass 'rgsdatetime'

NB. =========================================================
NB. Constants

NB.*J0Date n Add to J's dayno to get Julian dayno
NB. Note that for astronomical use the start of a Julian day
NB. is noon so for an accurate representation of a Julian day/time
NB. combination 2378496.5 should be added instead.
J0Date=: 2378497

NB.*MS0Date n Add to Microsoft date to get a J dayno
NB. Note that the first date supported by Microsoft Excel is 1900 1 1
NB. but dates between 1900 1 1 and 1900 1 28 will not convert properly
NB. because Excel incorrectly denotes 1900 as a leap year, 
NB. http://support.microsoft.com/kb/214326
MS0Date=: 36522  NB. 

NB.*Linux0DateTime n Add to Linux-style date to get a J dayno
Linux0DateTime=: 62091 

WKDAYS=: ;:'Sunday Monday Tuesday Wednesday Thursday Friday Saturday'
MONTHS=: ''; ;:'January February March April May June July August September October November December'
DATECODES=: ;:'D DD DDD DDDD M MM MMM MMMM YY YYYY'
TIMECODES=: ;:'d h hh m mm s ss sss c cc ccc p pp'
NB. =========================================================
NB. Utility verbs

NB. escaped v process an escaped string
NB. eg: '\' escaped '\Date is: D\\MM\\YYYY'
NB. result: 2-item list of boxed mask & string:
NB.          0{:: boolean mask of non-escaped characters
NB.          1{:: string with escape character compressed out
NB. y is: An escaped string
NB. x is: character used to escape string
escaped=: 3 : 0
  '\' escaped y                         NB. default escape char
:
  mskesc=. y = x
  mskfo=. 2 < /\ 0&, mskesc             NB. 1st occurences of x
  mskesc=. mskesc ([ ~: *.) 0,}: mskfo  NB. unescaped 1st occurences of x
  mskunescaped=. -. 0,}: mskesc         NB. unescaped characters
  (-.mskesc)&# &.> mskunescaped;y       NB. compress out unescaped x
)

NB. round v round y to nearest x (e.g. 1000 round 12345)
NB. from j602 numeric script (which is not yet available in j7)
round=: [ * [: <. 0.5 + %~

fmt=: 8!:0

NB. getDateFormats v returns boxed table of all formatted date components
NB. y is: numeric array of [fractional] day numbers
NB. could have give desired components as optional left arg then
NB. for loop through each component using a select case to build
getDateFormats=: 3 : 0
  ymd=. |: todate (* * <.@:|),y    

  t=. 2{ymd                                  NB. Days
  values=. ('';'r<0>2.0') fmt"0 1 t
  t=. (7|3+<.,y){WKDAYS                      NB. Day names
  values=. values,(3&{.&.> ,: ]) t
  t=. 1{ymd                                  NB. Months
  values=. values, ('';'r<0>2.0') fmt"0 1 t
  t=. (0>.t){MONTHS                          NB. Month names
  values=. values, (3&{.&.> ,: ]) t
  t=. 0{ymd                                  NB. Years
  values=. values, (2&}.&.> ,: ]) fmt t
)

NB. getTimeFormats v returns boxed array of all formatted time components
NB. y is: numeric array of fractional day numbers
getTimeFormats=: 3 : 0
  0 0 0 getTimeFormats y
:
  dcp=. x
  dhms=. 1e_3 round 86400 * 1|| , y
  NB.if. *./ , 0 = dhms do. '' return. end.      NB. No times given
  ccc=.  1 | dhms                                NB. fractions of seconds
  dhms=. |:(0,(24*0{dcp),60 60) #: dhms          NB. to lists of D,H,M,:S
  values=. ,:fmt 0{dhms                          NB. Days
  t=. (1{dhms) (] + 12&*@] | -) 2{dcp            NB. Hours, 12/24 hour formats
  values=. values,('';'r<0>2.0') fmt"0 1 t
  t=. 2{dhms                                     NB. Minutes
  values=. values,('';'r<0>2.0') fmt"0 1 t
  t=. 3{dhms                                     NB. Seconds
  values=. values,('';'r<0>2.0') fmt"0 1 t
  values=. values, 'r<0>6.3' fmt t+ccc               NB. sss
  t=. 100 10 1 round"0 1 ccc * 1000              NB. c, cc, ccc
  values=. values, 1 2 3 {.&.> 'r<0>3.0' fmt t
  t=. (12<:24|1{dhms){ ;:'am pm'                 NB. am/pm
  values=. values,(1&{.&.> ,: ]) t
)
NB. =========================================================
NB. Verbs for converting between dates and daynumbers

NB.*toDayNo v Extends verb "todayno" to handle time
NB. eg: toDayNo 6!:0 ''
NB. result: numeric array as J day numbers, decimals represent time
NB. y is: numeric array in date/time format specified by x
NB. x is: optional boolean specifying input format. Default 0.
NB.      0 : date/time format <yyyy mm dd hh mm ss.sss>
NB.      1 : date/time format <yyyymmdd.hhmmss.sss>
NB. Dates before 1800 1 1 are not supported
toDayNo=: 3 : 0
  0 toDayNo y
:
  ymd=. y
  if. x do.                      NB. form <yyyymmdd.hhmmss>
    hms=. 0 100 100 #: 1e_3 round 1e6 * 1||ymd
    ymd=. 0 100 100 #: <.ymd
  else.                          NB. form <yyyy mm dd hh mm ss.sss>
    hms=. 3({."1) 3}."1 ymd
    ymd=. 3{."1 ymd
    hms=. hms + (24 * 1|_1{."1 ymd) (,"1) 0 0  NB. add part day to hours
    ymd=. (* * <.@:|) ymd        NB. truncate part years or months
  end.
  hms=. 86400 %~ 0 60 60 #. hms  NB. to proportion of a day
  dayn=. 0 todayno ymd
  dayn+hms
)

NB.*toDateTime v Extends verb "todate" to handle time
NB. eg: 1 toDateTime toDayNo 6!:0 ''
NB. result: numeric array in date/time format specified by x
NB. y is: array of J day numbers
NB. x is: optional boolean specifying output format. Default 0.
NB.      0 : date/time format <yyyy mm dd hh mm ss.sss>
NB.      1 : date/time format <yyyymmdd.hhmmss.sss>
NB. Dates before 1800 1 1 are not supported
toDateTime=: 3 : 0
  0 toDateTime y
:
  dayno=. y
  hms=. 1e_3 round 86400 * 1||dayno NB. get any decimal component
  dayno=. <.|dayno        NB. drop any decimal
  ymd=. x todate dayno    NB. get date component from todate
  if. x do.               NB. yyyymmdd.hhmmsssss
    hms=. 1e_6 * 0 100 100#. 0 60 60#: hms  NB. convert to 0.hhmmsssss
    ymd=. ymd + hms
  else.                   NB. yyyy mm dd hh mm ss.sss
    hms=. 0 60 60 #: hms  NB. convert to hh mm ss.sss
    ymd=. ymd ,"1 hms
  end.
  ymd
)

NB.*toJulian v Converts J day number to Julian day number
NB. eg: toJulian toDayNo 6!:0 ''
NB. Dates before 1800 1 1 are not supported
NB. Add another 0.5 to get true Julian Day number where noon is
NB. regarded as the "start" of the day.
toJulian=: +&J0Date

NB.*fromJulian v Converts Julian day number to J day number
NB. eg: fromJulian toJulian toDayNo 6!:0 ''
NB. Dates before 1800 1 1 are not supported
fromJulian=: -&J0Date
NB. =========================================================
NB. Verbs for date and time arithmetic

NB.*tsPlus v Adds time (y) to timestamp (x)
NB. eg: 2009 2 28 20 30 0 tsPlus 5 0 0     NB. add 5 hours to timestamp
NB. eg: 2009 2 28 20 30 0 tsPlus 34 5 0 0  NB. add 34 days, 5 hours to timestamp
NB. result: array of resulting numeric timestamp(s) in <Y M D h m s> format
NB. y is: array of numeric time(s) to add to x. Format: [[[[[Y] M] D] h] m] s
NB. x is: array of numeric timestamps to add y to. Format: Y [M [D [h [m [s]]]]]
tsPlus=: [: toDateTime@toDayNo (6&{.@[ + _6&{.@])"1

NB.*tsMinus v Subtract time (y) from timestamp (x)
NB. eg: 2009 3 1 1 30 0 tsMinus 5 0 0   NB. subtract 5 hours from timestamp
NB. result: array of resulting numeric timestamp(s) in <Y M D h m s> format
NB. y is: array of numeric time(s) to subtract from x. Format: [[[[[Y] M] D] h] m] s
NB. x is: array of numeric timestamps to subtract y from. Format: Y [M [D [h [m [s]]]]]
tsMinus=: tsPlus -

NB.*daysDiff v Difference in days from timestamp y to timestamp x
NB. form: endtimestamp daysDiff starttimestamp
NB. result: numeric array of time difference for x-y in <Days.fraction of days> format
NB. y is: numeric start date,time in <Y M D h m s> format
NB. x is: numeric end date,time in <Y M D h m s> format
daysDiff=: -&toDayNo

NB.*tsDiff v Time periods elapsed <Y M D H m s> from timestamp y to timestamp x
NB. form: endtimestamp tsDiff starttimestamp
NB. result: numeric array of time difference for x-y in <Y M D h m s> format
NB. y is: numeric start date,time in <Y M D h m s> format
NB. x is: numeric end date,time in <Y M D h m s> format
tsDiff=: 4 : 0
  r=. -/"2 d=. _12 (_6&([\)) \ , x ,&(6&{.)"1 y
  if. #i=. I. (+./"1) 0 > _3{."1 r do. NB. negative time
    n=. <i;2 3 4 5
    r=. (]&.(0 24 60 60&#.) n{r) n} r
  end.
  if. #i=. I. 0 > 2{"1 r do.           NB. negative days
    j=. (-/0=4 100 400 |/ (<i;1;0){d)* 2=m=. (<i;1;1){d
    j=. _1,.j + m{0 31 28 31 30 31 30 31 31 30 31 30 31
    n=. <i;1 2
    r=. (j + n{r) n} r
  end.
  if. #i=. I. 0 > 1{"1 r do.           NB. negative months
    n=. <i;0 1
    r=. (]&.(0 12&#.) n{r) n} r
  end.
  ($y) $, r
)
NB. =========================================================
NB. Verbs for formating string representations of Dates and Times
 
NB.*fmtDate v Format a date in a given format
NB. eg: '\Date is: DDDD, D MMM, YYYY' fmtDate toDayNumber 6!:0''
NB. result: formated date string (or array of boxed, formated date strings)
NB. y is: numeric array of dates given as Day Numbers
NB. x is: optional format string specifing format of result
NB.      Use the following codes to specify the date format:
NB.      D: 1   DD: 01   DDD: Sun   DDDD: Sunday
NB.      M: 1   MM: 01   MMM: Jan   MMMM: January
NB.             YY: 09              YYYY: 2009
NB.     To display any of the letters (DMY) that are codes, 
NB.     "escape" them with '\'
fmtDate=: 3 : 0
  'MMMM D, YYYY' fmtDate y
  :
  codes=. DATECODES
  pic=. x
  'unesc pic'=. '\' escaped pic
  msk=. (>./ (I. -.unesc)} ]) pic i.~ ~.;codes
  pic=. (1 , 2 ~:/\ msk) <;.1 pic                      NB. Cut into tokens
  var=. pic e. codes                                   NB. mark sections as vars

  values=. getDateFormats y

  res=. <@;"1 (|:(codes i. var#pic){values) (I. var)}"1 pic
  if. 0=#$y do. res=. ,>res else.  res=. ($y)$ res end.
  res
)

NB.*fmtTime v Format a time (in seconds) in a given format.
NB. eg: 'Ti\me i\s: hh:mm:ss' fmtTime 86400 * 1|toDayNumber 6!:0 ''
NB. result: formated time string (or array of boxed, formated time strings)
NB. y is: numeric array of times given as time in seconds since start of the day
NB. x is: optional format string specifing format of result
NB.      Use the following codes to specify the date format:
NB.      days ("d"), hours ("h"), minutes ("m"), seconds ("s"), 
NB.      fractions of a second ("c"), or AM/PM designator ("p"):
NB.     d: 1    h: 1    m: 1    s: 1      c: 1       p: a
NB.            hh: 01  mm: 01  ss: 01    cc: 01     pp: am
NB.                           sss: 1.2  ccc: 001
NB.     If no "p" designator is present, 24 hour format is used.
NB.     To display any of the letters (dhmscp) that are codes, 
NB.     "escape" them with '\'
fmtTime=: 3 : 0
  'h:mm:ss pp' fmtTime y
  :
  codes=. TIMECODES
  pic=. x
  'unesc pic'=. '\' escaped pic
  dcp=. 'dcp' e. pic                                     NB. are days, millisecs, am/pm present
  msk=. (>./ (I. -.unesc)} ]) pic i.~ ~.;codes
  pic=. (1 , 2 ~:/\ msk) <;.1 pic                      NB. Cut into tokens
  var=. pic e. codes                                     NB. mark sections as vars
  
  values=. dcp getTimeFormats y % 86400

  res=. <@;"1 (|:(codes i. var#pic){values) (I. var)}"1 pic
  if. 0=#$y do. res=. ,>res else.  res=. ($y)$ res end.
  res
)

NB.*fmtDateTime v Formats combined date and time strings
fmtDateTime=: 3 : 0
  'YYYY/MM/DD hh:mm:sss' fmtDateTime y
:
  codes=. DATECODES,TIMECODES
  pic=. x
  'unesc pic'=. '\' escaped pic
  dcp=. 'dcp' e. pic                                     NB. are days, millisecs, am/pm present
  msk=. (>./ (I. -.unesc)} ]) pic i.~ ~.;codes
  pic=. (1 , 2 ~:/\ msk) <;.1 pic                      NB. Cut into tokens
  var=. pic e. codes                                     NB. mark sections as vars

  values=. getDateFormats y
  values=. values, dcp getTimeFormats y

  res=. <@;"1 (|:(codes i. var#pic){values) (I. var)}"1 pic
  if. 0=#$y do. res=. ,>res else.  res=. ($y)$ res end.
  res
)

NB.*fmtTimeDiff v Formated time difference
NB. y is: time difference in <YYYY MM DD hh mm ss.sss> format
NB. x is: format string
NB. eg: 'Y year\s, M \months DDD days' fmtTimeDiff y
NB. eg: 'D day\s' fmtTimeDiff y
NB. Handle part units for smallest specified unit in format string:
NB. Truncate, round, decimal
NB. How to specify? 
NB.  -additional option to format string eg:
NB.      [format string[;0 or 1 or 2]] fmtTimeDiff y
NB.  -or part of format string
NB.    * decimal: YYY, MMM, DDD, hhh, mmm, sss
NB.    * round (to nearest unit): YY, MM, DD, hh, mm, ss
NB.    * truncate (only complete units): Y, M, D, h, m, s
NB.!! TO DO
NB. =========================================================
NB. Verbs for reading string representations of Dates and Times

NB.!! to do
NB. =========================================================
NB. Verbs for working with time zones
require 'dll'

NB.*getTimeZoneInfo v function to return Windows time zone info
NB. eg: getTimeZoneInfo ''
NB. result: 3-item list of boxed info
NB.    0{:: Daylight saving status (0 unknown, 1 standarddate, 2 daylightdate)
NB.    1{:: Bias (offset of local zone from UTC in minutes)
NB.    2{:: 2 by 3 boxed table: Standard,Daylight by Name,StartDate,Bias
getTimeZoneInfo=: 3 : 0
  'tzstatus tzinfo'=. 'kernel32 GetTimeZoneInformation i *i'&cd <(,43#0)
  NB. read TIME_ZONE_INFORMATION structure
  tzinfo=. (1 (<:+/\ 1 16 4 1 16 4 1)}43#0) <;.2 tzinfo    NB. 4 byte J integers
  tzbias=. 0{:: tzinfo
  tzinfo=. _3]\ }. tzinfo                  NB. Standard info ,: Daylight info
  'name date bias'=. i. 3                  NB. column labels for tzinfo
  tmp=. (6&u:)@(2&ic)&.> name {"1 tzinfo   NB. read names as unicode text
  tmp=. (0{a.)&taketo&.> tmp               NB. take to first NUL
  tzinfo=. tmp (<a:;name)}tzinfo           NB. amend TZ names
  tmp=. _1&ic@(2&ic)&.> date{"1 tzinfo     NB. read SYSTEMTIME structures
  tzinfo=. tmp (<a:;date)}tzinfo           NB. amend TZ dates

  tzstatus;tzbias;<tzinfo
)
NB. =========================================================
NB. Export to z locale
fmtTime_z_ =: fmtTime_rgsdatetime_
fmtDate_z_ =: fmtDate_rgsdatetime_
fmtDateTime_z_ =: fmtDateTime_rgsdatetime_
toDayNo_z_ =: toDayNo_rgsdatetime_
toDateTime_z_ =: toDateTime_rgsdatetime_
toJulian_z_ =: toJulian_rgsdatetime_
fromJulian_z_=: fromJulian_rgsdatetime_
tsPlus_z_=: tsPlus_rgsdatetime_
tsMinus_z_=: tsMinus_rgsdatetime_
daysDiff_z_=: daysDiff_rgsdatetime_
tsDiff_z_=: tsDiff_rgsdatetime_
