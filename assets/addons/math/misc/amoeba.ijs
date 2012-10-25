NB. math/misc/amoeba
NB. Nelder-Mead multi-dimentional minimization, aka the amoeba method
NB. version: 1.0.1
NB. Henry H. Rich, David Hash, Marshall Lochbaum, September 2011

NB.*amoeba c Nelder-Mead multi-dimentional minimization
NB. u is: the function to be minimized
NB. n is: the terminating volume of the simplex (or, if boxed, the log2 of
NB.  the ratio by which the volume must shrink before termination (the boxed form
NB.  may be used for high-dimension applications where the volume is unrepresentably small))
NB. y is: the starting simplex to use
NB. result is: list of 2 boxes.  First contains coordinates of (local) minimum,
NB.  second contains function value at the minimum
NB.
NB. y is defined to be a simplex, that is, it is n+1 points in a n-dimensional
NB. space.  So, the shape of y is (n+1),n.
NB. The method is to evaluate the function u at each vertex of the simplex,
NB. and then choose a new simplex in search of a new better value.  The new
NB. simplex keeps the same volume as the old simplex, until we think we
NB. have the minimum surrounded, at which time the simplex shrinks around
NB. the minimum until it shrinks to a point, which is the answer.
NB.
NB. The new simplex is chosen as follows:
NB. Consider a 3-dimensional case.  Call the points of the Simplex A B C D.
NB. First, find the point that has the worst (=highest) value of the objective
NB. function.  We will try 3 possible simplices that might give a better value,
NB. in each case we will be moving point A along a line that passes through
NB. the center of the opposite face BCD:
NB. (0) try moving A halfway to BCD
NB. (1) try moving A to the other side of BCD, at the same distance, in other
NB.   words pass A through BCD to a point on the other side;
NB. (2) like (1), but move point A to twice the distance on the other side (this
NB.   is done to pick up speed when we have picked a good direction of movement).
NB.
NB. After trying all these cases, we pick the one with the best value at the
NB. new position of A - unless none of those values was better then the original A.
NB. In that case, we have surrounded the minimum, and we try
NB. (3) shrink the simplex by a factor of 2 in each dimension.
NB.
NB. The algorithm terminates when the simplex is 'small enough' in volume, as given by
NB. the parameter n.
NB.
NB. Note that move (1) preserves the volume of the simplex, move (0) cuts it in
NB. half, move (2) doubles it, and move (3) divides it by 2^<:#y.  We use those facts
NB. to avoid recalculating the volume of the simplex
amoeba =: conjunction define
NB. fail if y has an incorrect shape
assert.(1 = -/$y) *. 2 = #$y
NB. rank 1 user defined verb, with _ in case of error: points out of domain will not be considered.
uverb =. (u :: _:)"1
NB. Initial simplex, user-specified starting values
simplex =. y
NB. Calculate the initial volume of the simplex, and the termination condition.  But
NB. if the termination condition is boxed, i. e. is the number of shrinks to allow,
NB. don't bother with the volume.
if. 32 = 3!:0 n do.
  excessvol =. >n
else.
  vol =. (-/ .* (}. -"1 {.) simplex) % !<:#simplex
  NB. Calculate the termination condition - the number of powers of 2 that
  NB. the volume is above what it needs to be.  We are done when this value drops to 0
  excessvol =. 2 ^. | vol % n
end.

NB. Error is function value of simplex at each point.  This is modified
NB. as we go along
err =. uverb simplex
NB. If for some reason the initial condition matches the termination condition, we
NB. need to exit, returning the best point, because the simplex volume may be 0,
NB. in which case none of the changes might make progress; but owing to numerical
NB. inaccuracy it might appear that the volume-expansion did; and a loop might result.
NB. We jam excessvol negative so that we will go through the loop one time to sort the
NB. simplex on error and then quit
if. excessvol <: 0 do. excessvol =. _1 end.

NB. Loop until the simplex has shrunk far enough.
whilst. excessvol > 0 do.
  NB. Sort the simplex into order, low point to high point
  NB. using the err values
  simplex =. simplex /: err
  NB. Sorts err to coorespond to the simplex's order
  err =. /:~ err
  NB. Try various moves with the worst (last) point
  NB. The point is moved along a line through center of the opposite face,
  NB. which is the centroid (mean) of all the other points
  NB. Calculates the center point of the simplex through which the high
  NB. Point is reflected
  cp =. (+/ % #) }: simplex
  NB. Calculate the candidate positions, linear combinations of cp and the high point
  NB. beta is _0.5 for halfway to cp, 1 for mirror around cp, 2 for double-mirror
  NB. The new position is cp + (beta * (cp-hp))
  NB. So for each candidate, we have the row 1+beta , -beta
  NB. Produce the points, corresponding to betas _0.5, 1, 2
  simptry =. (3 2 $ 0.5 0.5  2 _1  3 _2)  +/ . * cp ,: {:simplex
  NB. create a 3 item list (tryerr) of the error of the simplex
  NB. if the high point is replaced with the high point generated
  NB. by the 3 respective beta values.  The lowest item from this
  NB. array is saved as the minval, and its index saved in
  NB. minindx, so that it can later be accessed
  minindx =. tryerr i. minval =. <./ tryerr =. uverb simptry
  NB. If this point has less error than the previous high point,
  NB. it replaces the previous high point.
  if. minval < {:err do.
    NB. Replaced the highest value in simplex with
    NB. the lowest point stored in simptry
    simplex =. (minindx { simptry) _1} simplex
    NB. Replace the last value of err with the error
    NB. value of the new point.
    err =. minval _1} err
    NB. Adjust the current volume of the simplex
    excessvol =. excessvol + minindx { _1 0 1
  else.
    NB. If even the best point still is no better than
    NB. the previous highest point, the simplex is contracted
    NB. towards the lowest point.
    simplex =. -: (+"1 {.) simplex
    NB. And the error function is re-evaluated and updated
    err =. ({.err) , uverb }. simplex
    NB. The simplex has shrunk in each dimension
    excessvol =. excessvol - <:#simplex
  end.
end.
NB. Returns boxed array of (the n coordinates of the minimum) ;
NB. (the corresponding function value)
({.simplex);({.err)
:
NB. Dyadic case: bond x to u
x&u amoeba v y
)

NB.*createsimplex v create a simplex from a starting point and lengths in each axis
NB. verb to generate a simplex given one point y (a list)
NB.
NB. For the general matrix x, which must have shape (,~ #y) , x is added to
NB. y with rank 1 and the resulting y points are concatenated with y to form
NB. a list of >: y points.
NB.
NB. If x is a list, of shape #y , a shape (,~ #x) identity matrix
NB. is generated and multiplied by x, then added to y and appended to y,
NB. again forming >: #y points, with volume (*/x) * (% ! #y)
NB. 
NB. x can be a scalar, in which case it is multiplied by the shape ,~ y identity
NB. matrix and added to y, the appended to y, generating >: #y points.
NB. Note that in this case the result has volume (x&^ * %@!) #y, which grows very
NB. small for large values of #y and small (ie. 1) values of x.
NB.
NB. Result is a simplex (with shape (,~ >:) #y) that can be used as y
NB. in the amoeba conjunction below.
createsimplex =: 4 : 0
NB. fail if any axis of x is not equal to y or x has rank greater than 2
assert. (2 >: #$x) *. (*./ (#y) = $ x)
if. 2 = #$x do. (, x&+) y
NB. both other cases are encompassed simply by multiplying x by the proper
NB. identity matrix.
else. (, (x * =/~ i. #y)&(+"1)) y end.
)


Note 'Example usage'
 (+/@:*:) amoeba 1e_20 (3 2 $ 1 0 2 1 1 2)  NB. Gets close to minimum at 0 0
 (+/@:*:) amoeba (<40) (3 2 $ 1 0 2 1 1 2)  NB. Gets close to minimum at 0 0
)
