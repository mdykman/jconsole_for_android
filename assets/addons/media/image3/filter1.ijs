NB. filter1.ijs
NB. Cliff Reiter
NB. January 2003
NB.
NB. Some utilities for filtering 2-dimensional
NB. arrays in the spatial domain
NB. It is assumed that image3 addon is available
NB. Some suggested experiments appear at the end

NB. locale for image3 addon
coinsert 'ima3'
coinsert 'jgl2'
coclass  'ima3'

NB. path to the image3 addon library needs to be correct.
dir_sep=: PATHSEP_j_             NB. directory separator
addon_path=: jpath '~addons/media/image3/'
require addon_path,'image3.ijs'
require addon_path,'view_m.ijs'

NB. *************************
NB. Part I: General Functions
NB. *************************

NB. round x  eounds to the nearest integer
round=:<.@(0.5&+)

NB. clamp values to between 0 and 255
clamp=: 255&<.@(>.&0)

NB. toG m 
NB. converts a matrix of grayscales to an image
NB. in the form for use by the image3 addon
toG=: BW256&;

NB. n sup b
NB. duplicate each pixel in b by a n by n super pixel
sup=: [ # #"1

NB. *******************************
NB. Part II: Multiplicative Filters
NB. *******************************

NB. s gauss n gives a vector that is approximately 
NB. normally distributed with standard deviation s
NB. and with n sample points.
gauss=:1 : '[:(%+/)^@-@*:@-:@(%&m)@:(i.--:@<:)'

NB. s gauss2d n gives a matrix that is approximately 
NB. binormally distributed with standard deviation s
NB. and with n sample points in each direction.
gauss2d=:1 : '[: */~ m gauss'

NB. d golay n
NB. give a vector of Savitsky-Golay coefficients
NB. -- coefficients based upon degree d least square
NB. fit of n points
NB. These are used in MFilt1d2 to produce a filter
NB. 
sav_gol=: 4&$: : ([: {.@%. i:@-:@<:@] ^/ i.@>:@[)

NB. d sav_gol_2d n
NB. matrix form of the Savitsky-Golay coefficients
sav_gol_2d=: */~@:sav_gol  

NB. W MFilt2d b  applies a filter given by the 
NB. matrix W on the matrix of grayscales b. It is
NB. assumed that the entries in W sum to 1.
MFilt2d=: 1 : 0
[: round ($ m)"_ +/@,@:(m&*);._3 ]
)

NB. W MFilt1d2 b  applies a filter given by the 
NB. vector W on the rows and columns of the matrix 
NB. of grayscales b. It is assumed that the entries 
NB. in W sum to 1.
MFilt1d2=: 1 : 0
[: round (# m)"_ +/@:(m&*)\"1 (# m)"_ +/@:(m&*)\ ]
)

NB. ****************************
NB. Part III: Order Rank Filters
NB. ****************************

NB. n medianf b
NB. applies a median filter on n by n size neighborhoods
NB. of the grayscale matrix b. It is assumed that n is odd.
medianf=: 1 : 0
(2#m)"_ (<.-:*:m)&{@:(/:~)@,;._3 ]
)

NB. mediano5 b
NB. applies a median filter on octagonal 5 by 5 size neighborhoods
NB. of the grayscale matrix b. 
mediano5=:3 : 0
5 5(10)&{@:(/:~)@((0 4 20-.~i.24)&{)@,;._3 y
)

NB. hmedianf b
NB. applies the hybrid median filter on 5 by 5 size neighborhoods
NB. of the grayscale matrix b. 
hmedianf=:3 : 0
med3=. 1&{@:(/:~)
med9=. 4&{@:(/:~)
x0=.0 4 6 8 12 16 18 20 24&{
p=.2 7 10 11 12 13 14 17 22&{
5 5 med3@:(med9@:x0,med9@:p,12&{)@:,;._3 y
)

NB. tmedianf b
NB. applies the truncated median filter to the grayscale matrix b
NB. this is an approxiamtion to a mode based filter
tmedianf=: 3 : 0
lf=.[:({~3&{@:/:) 7&{.@:/:@:(|@- +/ % #){]
3 3 lf@:,;._3 y
)

NB. **********************
NB. Part IV: Other Filters
NB. **********************

NB. maxlike b
NB. applies the maximum likelihood filter to g
maxlike=:3 : 0
ic=.,0 5 10+/6 7 8
i9=.,/3 3 ,;._3 i.5 5
lfilt=.({~ [: {&ic@:{.@:/: [:(+/)@:*:"1 i9&{ - ic&{)@:,
5 5 lfilt;._3 y
)

NB. [n] minmax b
NB. a two-pass filter that takes the max in the
NB. first pass and the min in the second pass
minmax=:3 : 0
3 minmax y
:
x <./\ x <./\"1 x >./\ x >./\"1 y 
)

NB. [n] maxmin b
NB. a two-pass filter that takes the min in the
NB. first pass and the max in the second pass
maxmin=:3 : 0
3 maxmin y
:
x >./\ x >./\"1 x <./\ x <./\"1 y 
)

NB. sf_filt b
NB. Cliff's original ad hoc snowflake filter
NB. 3&medianf or tmedainf are recommended instead
sf_filt=:3 : 0
255*180<2 2((2&{)@:(/:~)@:,);._3 y
)

NB. *******************
NB. Part V: Experiments
NB. *******************
NB. Run individual lines of interest

experiments=:0 : 0
NB. The test image snowflake.png is available from
NB. http://www.lafayette.edu/~reiterc/j/withj/snowflake.png
NB. Save it in the image3 addon directory
NB. Adjust path to read the image if necessary
NB. b should have shape 700 by 780
$b=: ,. read_image addon_path,'snowflake.png'

sf_zoom=:4&sup@:(175 195&{.)@:(65 195&}.)

view_image toG b
view_image toG sf_zoom b

$f2=:(2 gauss 9) MFilt1d2 b
view_image toG f2
view_image toG sf_zoom f2

$f3=: clamp (2 sav_gol 9)MFilt1d2 b
view_image toG f3
view_image toG sf_zoom f3

$f4=:3 medianf b
view_image toG f4
view_image toG sf_zoom f4

$f5=:hmedianf b
view_image toG f5
view_image toG sf_zoom f5

$f6=:sf_filt b
view_image toG f6
view_image toG sf_zoom f6

$f7=:maxlike b
view_image toG f7
view_image toG sf_zoom f7

NB. some extra filters
NB. Octogonal 5 by 5 median filter
$x1=:mediano5 b
view_image toG x1
view_image toG sf_zoom x1

NB. truncated median attempts to shift toward the mode
$x2=:tmedianf b
view_image toG x2
view_image toG sf_zoom x2

NB. min/max filter
$x3=:minmax b
view_image toG x3
view_image toG sf_zoom x3

NB. max/min filter
$x4=:maxmin b
view_image toG x4
view_image toG sf_zoom x4

)
NB. end of experiments