NB. =========================================================
NB. utils for Differential Evolution addon

NB.*getSampleNR v Sample from array without replacement
NB. y is array to sample
NB. x is optional number and size of samples
NB.      defaults to 1 sample of same size as y
NB. getSampleNR=: ((1 , #) $: ]) : (] {~ {:@[ ? {.@[ $ #@])
getSampleNR=: 3 : 0
  (1 , #y) getSampleNR y
:
  'num sz'=. x
  (sz ? num $ #y){y
)

NB.*getSampleR v Sample from array with replacement
NB. y is array to sample
NB. x is optional number and size of samples
NB.      defaults to 1 sample of same size as y
NB. getSampleR=: ((1 , #) $: ]) : (] {~ [ ?@$ #@])
getSampleR=: 3 : 0
  (1 , #y) getSampleR y
:
  (x ?@$ #y){y
)
