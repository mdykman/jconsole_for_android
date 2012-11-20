NB. general/misc/part.ijs
NB. Partition functions
NB. version: 1.0.0
NB.
NB. partition functions
NB.
NB. Partitions are typically given by a boolean with 1's marking
NB. the beginning or end of each partition. Partitions are also
NB. sometimes given in terms of the lengths of each partition.
NB.
NB. Verbs defined here assume that boolean 1's mark the beginning
NB. of each partition - see comments at the end for examples of
NB. end-partition verbs.
NB.
NB. The verbs psum and psumscan illustrate definitions appropriate
NB. for verbs that return scalar or non-scalar results, respectively.
NB. utility used to build non-scalar partition functions:
NB.
NB. Examples:
NB.
NB.   1 0 0 1 0 0 0 = firstones 1 1 0 1 1 1 0
NB.   0 0 1 0 1 = lastones 1 1 1 0 1
NB.   2 3 1 = lfp 1 0 1 0 0 1
NB.   1 1 0 1 0 0 1 = partition 1 9 9 4 4 4 9
NB.   0 0 0 1 2 2 3 = runindices 3 1 2 1
NB.   1 2 3 1 = runlengths 1 9 9 4 4 4 9
NB.
NB.   x=. 1 0 1 0 0 [ y=. 5 3 2 2 7
NB.
NB.   3 5 7 2 2 = x preverse y
NB.   3 5 2 2 7 = x psort y
NB.   8 11 = x psum y
NB.   5 8 2 4 11 = x psumscan y

cocurrent 'z'

NB. =========================================================
NB. verb cp cut       where cut is 1=beginning, 2=end.
cp=. 2 : '; @ (<@u ;. n)'

NB. =========================================================
NB.*firstones v first 1's in partition
NB. form: firstones part
firstones=: > |.!.0

NB.*lastones v last 1's in partition
NB. form: lastones part
lastones=: > 1&(|.!.0)

NB.*lfp v lengths from partition
NB. form: lfp part
lfp=: #;.1

NB.*partition v partition items (1 marks new item)
NB. form: partition dat
partition=: }:@(1 , -.)@((-:"_1) 1&|.)

NB.*pfl v partition from lengths
NB. form: pfl len
pfl=: [: ; {.&1&.>

NB.*runindices v indices from run lengths
NB. form: runindices
runindices=: I.

NB.*runlengths v lengths of each run
NB. form: runlengths dat
runlengths=: lfp@partition f.

NB. =========================================================
NB.*preverse v partioned reverse
NB. form: part preverse dat
preverse=: |. cp 1

NB.*psort v partioned sort
NB. form: part psort dat
psort=: /:~ cp 1

NB.*psum v partioned sum
NB. form: part psum dat
psum=: +/;.1

NB.*psumscan v partioned sumscan
NB. form: part psumscan dat
psumscan=: +/\ cp 1

NB. =========================================================
NB. example end-partition verbs (use 2 instead of 1):
NB. preverse=: |. cp 2
NB. psum=: +/;.2
