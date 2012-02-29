NB. init

coclass 'jfftw'
NB. z definitions:

fftw_z_=: (_1 & fftwnd_jfftw_) :. (1 & fftwnd_jfftw_)
ifftw_z_=: (1 & fftwnd_jfftw_) :. (_1 & fftwnd_jfftw_)
NB. fftw utils
NB.
NB. cd            15!:0
NB. clean         clean numbers near 0
NB. info          cover for wdinfo
NB. matchclean    if clean x-y is all 0

zzero=: 1j1-1j1

3 : 0''
if. UNAME-:'Linux' do.
  DLL=: 'libfftw3.so.3'
elseif. UNAME-:'Darwin' do.
  DLL=: '"',~'"',jpath '~addons/math/fftw/libfftw3.3.dylib'
elseif. do.
  DLL=: '"',~'"',jpath '~addons/math/fftw/libfftw3-3', (IF64#'_64'), '.dll'
end.
)

FFTW_FORWARD=: _1
FFTW_BACKWARD=: 1
FFTW_ESTIMATE=: 6 (33 b.) 1
FFTW_MEASURE=: 0

FFTW_VERSION=: 3.2

cd=: 15!:0

info=: wdinfo @ ('FFTW'&;)

matchclean=: 0: *./ . = clean @ , @: -

NB. =========================================================
NB.*clean v clean numbers to tolerance (default 1e_10)
NB. sets values less than tolerance to 0
clean=: (1e_10&$:) : (4 : 0)
if. L. y do.
  x clean each y
else.
  if. 16 ~: 3!:0 y do.
    y * x <: |y
  else.
    j./"1 y* x <: | y=. +.y
  end.
end.
)
NB. fftw

NB. =========================================================
NB.*createplan v create a plan
NB. y = shape ; in ; out ; direction; flag
NB.
NB.   direction = FFTW_FORWARD | FFTW_BACKWARD
NB.   flag = FFTW_ESTIMATE | FFTW_MEASURE
createplan=: 3 : 0
'shape in out dir flag'=. y
assert dir e. FFTW_FORWARD,FFTW_BACKWARD
assert flag e. FFTW_ESTIMATE, FFTW_MEASURE
shape=. ,shape
cmd=. DLL,' fftw_plan_dft + x i *i *j *j i i'
0 pick cmd cd (#shape);shape;in;out;dir;flag
)

NB. =========================================================
NB.*destroyplan v destroy a plan
destroyplan=: 3 : 0
cmd=. DLL,' fftw_destroy_plan + n x'
1 [ cmd cd y
)

NB. =========================================================
NB.*fftwnd d n-dimensional FFT
NB. x =  _1 forward
NB.        1 backward
NB. y =  data
fftwnd=: 4 : 0
shp=. $y
if. 0 e. shp do. y return. end.
in=. zzero + , |: y
out=. in * 0
assert x e. _1 1
dir=. x
plan=. createplan shp;in;out;dir;FFTW_ESTIMATE
fftwexecute plan
destroyplan plan
res=. |: (|.shp) $ out
if. dir=1 do. res % */shp end.
)

NB. =========================================================
NB.*fftwexecute d one call to n-dimensional FFT
NB. y =  plan
fftwexecute=: 3 : 0
cmd=. DLL,' fftw_execute + n x'
1 [ cmd cd y
)

