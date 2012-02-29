NB. math/misc/simplexnr
NB. Simplex method (after Numerical Recipes in C)
NB. version: 1.0.0
NB.
NB. see also math/misc/simplex
NB.
NB. This implementation follows Numerical Recipes in C, 2/e,
NB. section 10.8, except that we let the user specify the type of
NB. each constraint rather than expecting the order <: >: =
NB. and we use a similar but refined way of handling degenerate pivots
NB.
NB. Henry H. Rich (HenryHRich@nc.rr.com), June 2001

NB. simplexnr  - simplex method following Numerical Recipes in C

NB. =========================================================
NB. solverestricted v Solve restricted form
NB. y is: tableau.  
NB. x is: 
NB.   (phase number);(constraint type);(row vbl label);(col vbl label)
NB.   shapes '' ; ((<: #y) - phase number) ; (#y) ; ({:$y)
NB.   where
NB. phase number is 0 for phase 1, 1 for phase 2.  In phase 1 we are
NB.  searching for an initial feasible vector; in phase 2 we are finding
NB.  a final solution.  In phase 1 the auxiliary objective function
NB.  is item _1 of y, the real objective is item _2, after the constraints;
NB.  in phase 2 the objective funtion is item _1, after the constraints.
NB. constraint type for each constraint is _1 for <:, 0 for =, 1 for >:
NB. row vbl labels are associated with each row (the row variables are
NB.  the nonzero variables in the basis).  As rows are
NB.  swapped with columns, the labels are swapped also.  In phase 1,
NB.  the rows for = constraints become unused when they are swapped to
NB.  columns; they are deleted as the columns are
NB. col vbl labels similarly; the col vbls are the zero variables not in
NB.  the basis
NB.
NB. result is solution, in the form:
NB. retcode ; modified tableau ; row vbl numbers ; col vbl numbers
NB. retcode is 0 (normal), 1 (unbounded) , 2 (infeasible)
solverestricted =: 4 : 0
'phase epsilon contype rowlab collab' =. x
NB. Set up according to phase number.  The pivot search covers
NB. only the actual constraint equations, not the objective function(s)
NB. (of which there are 2 in phase 1, 1 in phase 2)
NB. In phase 2, we set all constraint types to <:, meaning 'no special action'
nobj =. _2 + phase
if. phase do. contype =. (#contype) # _1 end.
while. 1 do.
    NB. Find the best column to process.  If none with positive slope, we are done
  if. epsilon > maxobj =. >./ objr =. }: {: y do.
    NB. no positive z-row elements, we have maximized as far
    NB. as we can.  If we are in phase 1, there is a little cleanup
    NB. work to do to make sure that all the artificial variables
    NB. have been flushed out.  If there are any = constraints left, those
    NB. are artificial variables that we must swap over to the
    NB. right-hand side.  Pick one, and swap it with the column
    NB. that has the highest absolute value among the row coefficients
    NB. But only do this if the (aux) objective has gone to 0; otherwise
    NB. the problem is infeasible
    if. ((-epsilon) < ((<_1 _1) { y)) *. (#contype) ~: pivrowx =. contype i. 0 do.
      pivcolx =. (i: >./) | }: pivrowx { y
      NB. here Numerical Recipes makes the swap only if there is a nonzero
      NB. element of the row; I don't think it hurts to swap anyway, in J
      NB. This establishes the pivot.  Fall through to perform the pivot
    else.
      NB. Also, if there are any >: constraints that never got swapped out,
      NB. we must replace them with their slack variables, and when we do so,
      NB. we must change their signs
      unswapge =. I.  contype = 1
      y =. (- unswapge { y) unswapge} y
      NB. Here is the normal return.
      0 ; y ; rowlab ; collab return.
    end.
  else.
    NB. More optimization available.  Find the pivot.  The pivot column is the
    NB. one with the maximum value; we examine only rows with negative entries.
    pivcolx =. objr i.!.0 maxobj
    if. 0 = #negrowx =. I.  (-epsilon) > nobj }. pivcolx {"1 y do.
      NB. If there are no negative entries, the problem is unbounded.
      1 ; '' ; '' ; '' return. end.
    NB. Select the row(s) with maximum ratio of (constant value%column value)
    NB. (since these are negative numbers, maximum = smallest absolute value).
    NB. These are the rows that limit movement.
    if. 1 = #limrows =. negrowx (#~ (= >./)) %/"1 (<negrowx;_1,pivcolx) { y do.
      NB. If there is only 1 limiting row, it is the pivot.  Move to it.
      pivrowx =. {. limrows
    else.
      NB. If there are multiple limiting rows, we are about to move to a degenerate
      NB. vertex.  To speed things along, recompute the limiting amounts for
      NB. all columns, and move to that column that has the largest number of
      NB. maximum values (NR looks for the first larger value per row,
      NB. but surely this is better)
      pivrowx =. limrows {~ (i. >./) +/"1 (="1 >./) pivcolx (] % {"1) limrows { y
    end.
  end.
  NB. We now have pivot (row,col).  Do the pivot.  First, save the pivot column.
  pivot =. pivrowx { pivcol =. pivcolx {"1 y
  NB. Exchange the exiting row for the entering column.  Use elementary
  NB. row operations to zero out the entering column (this is solving the
  NB. pivot row in terms of the entering variable and substituting that
  NB. into the other rows)
  y =. y - (0 pivrowx} pivcol % pivot) */ pivrow =. pivrowx { y
  NB. For the pivot itself, we use the equation of the exiting row, solved
  NB. in terms of the entering column
  y =. (pivrow % -pivot) pivrowx} y
  NB. Now account for the fact that the column has been changed from the entering
  NB. column to the exiting row.  Replace the column (now zero) with the saved
  NB. pivot column, divided by the saved pivot.  The pivot element itself
  NB. just becomes its reciprocal.  This has the effect of preserving the
  NB. coefficients of the exiting row when we solved for it in terms of
  NB. the entering column, and putting those coefficients in the column
  NB. where the exiting row now resides
  y =. (pivot %~ 1 pivrowx} pivcol) (<a:;pivcolx)} y
  NB. Exchange the labels between the entering and exiting columns
  exitingrow =. pivrowx { rowlab  NB. save the exiting row number
  rowlab =. (pivcolx { collab) pivrowx} rowlab
  collab =. exitingrow pivcolx} collab
  NB. Now, some special work for phase 1.  If an = constraint is being
  NB. swapped out for the first time, it is an artificial variable
  NB. which must never be swapped back in; delete its column (and column label).
  NB. If a >: constraint is being swapped out for the first time, it is
  NB. an artificial variable that is being changed to a slack variable with
  NB. the opposite sign; we change the sign of the column AND subtract 1 from
  NB. the objective function to account for the 1 that would have been
  NB. in the slack variable's column (and would have been subtracted from the
  NB. auxiliary objective function) if we had been holding the variable
  NB. explicitly.  If a <: constraint is swapped out, we do nothing, because
  NB. that kind of constraint starts out as a slack variable and stays that
  NB. way forever - so we change the other type to <: constraints once they
  NB. have been swapped out, indicating 'no more work to do'
  select. pivrowx { contype
  case. 0 do. NB. = constraint.  Remove the column.
     NB. We could keep a mask of valid columns, but then we'd have to check it every
     NB. iteration.  Here we get it over with - equality constraints are rare anyway
    collab =. (<<<pivcolx) { collab
    y =. (<a:;<<pivcolx) { y
    contype =. _1 pivrowx} contype
  case. 1 do. NB. >: constraint
    y =. (>: (<_1,pivcolx){y) (<_1,pivcolx)} y  NB. account for missing column
    y =. (- pivcolx {"1 y) (<a:;pivcolx)} y  NB. ...and change signs
    contype =. _1 pivrowx} contype
  end.
end.
)

NB. =========================================================
NB.*simplexnr v Run simplex method
NB. y is the problem:
NB. (objective function);constraints;(constraint values);(constraint types)[;(fudge constant)]
NB. There are N variables to be solved for.  The shapes of the
NB. components are
NB. N ; (m,N) ; m ; m [; '']
NB. The objective function is the N coefficients of the function
NB.  to be maximized
NB. The constraints are the coefficients (N per constraint) of each
NB.  constraint
NB. The constraint type is _1, 0, or 1: _1 means that
NB.  +/ constraint * solution must be <: the constraint value;
NB.  0 means =, 1 means >:
NB. the fudge constant, which defaults to 1e_6, is how close a coefficient
NB.  needs to be to 0 to be considered 0.
NB. The result is (return code);(solution vector);(objective value)
NB. shapes '' ; N ; ''
NB. where return code = 1 if the problem is unbounded, 2 if infeasible, 0
NB.  if solvable, and in that case
NB.  objective value = +/ (solution vector) * (objective function)
NB.  and this is the largest possible objective value satisfying the
NB.  constraints.
NB.
NB. Example:
NB. Maximize x1 + x2 + 3x3 - 0.5x4
NB. subject to
NB. x1       + 2x3       <: 740
NB.      2x2       - 7x4 <: 0
NB.       x2 -  x3 + 2x4 >: 0.5
NB. x1 +  x2 +  x3 +  x4 = 9
NB. is
NB. simplex 1 1 3 _0.5 ; (1 0 2 0 , 0 2 0 _7 , 0 1 _1 2 ,: 1 1 1 1) ; 740 0 0.5 9 ; _1 _1 1 0
NB. Solution is 0 3.325 4.725 0.95
simplexnr =: 3 : 0
NB. Audit shape/rank of inputs, fail if error
if. -. 1 = #$y do. 'Wrong rank of y' 13!:8 (9) end.
if. 4 = #y do. y =. y , <1e_6 end.
if. -. (,5) -: $y do. 'Wrong shape of y' 13!:8 (9) end.
if. -. 1 2 1 1 0 -: #@> shp =. $&.> y do. 13!:8 (14) end.
if. -. *. 1 = (0 2;1 3 4) #@~.@:{&> <;shp do. 'Components do not conform' 13!:8 (9) end.
NB. Shapes conform.
'objective constraints values types epsilon' =. y
NB. First of all, if any of the constraint values is negative, change the
NB. sign of the constraint, the value, and the constraint type.
if. 0 ~: +/ negval =. - values < 0 do.
  'constraints values types' =. (negval{1 _1)&*&.> 1 2 3 { y
end.
NB. Create a tableau of the constraints for the phase-2 problem
NB. The last column is the value, the remaining columns are
NB. the constraints with signs reversed.  The last row is
NB. the objective function.  Append a value of 0 to the objective
NB. function, representing its value at the starting vertex
NB. (the origin)
tableau =. (values ,.~ - constraints) , (objective , 0)

NB. Build the vector indicating the row/column labels etc.
NB. numbers in i. (# decision variables) are the decision variables,
NB. higher numbers are slack variables
startphase =. -. +./ nonlemsk =. types ~: _1
parm =. startphase;epsilon;types;((+ i.)~/ $ constraints);i. {: $ constraints
if. -. startphase do.
  NB. If all constraints are <: constraints, then the origin is a feasible
  NB. vector, and we can start there without need for phase 1.

  NB. With constraints other than <:, we must run phase 1 to find an
  NB. feasible initial basic vector.  Here goes.

  NB. We are going to add an artificial variable for each >: or =
  NB. constraint, such that the origin of the original problem
  NB. is a feasible point for the augmented system (the artificial
  NB. variables are not 0 at this starting point).  We will supply
  NB. a special auxiliary objective function that is maximized when
  NB. all the auxiliary variables are 0, and we will then solve that
  NB. system.  The result will be a point on the simplex which
  NB. satisfies all the constraints and has the auxiliary variables
  NB. 0; we then discard the auxiliary variables and solve the
  NB. original problem starting at that vertex.  The auxiliary
  NB. objective function is the negative of the sum of all the
  NB. >: and = constraints.

  NB. For <: constraints, the row of the tableau represents a slack
  NB. variable.  No artificial variable is required.  For =
  NB. constraints, no slack variable is needed, but an artificial
  NB. variable is, and the row represents that variable.  For
  NB. >: constraints, both a slack variable and an artificial
  NB. variable are needed; the row represents the artificial
  NB. variable.

  NB. For >: constraints, we cleverly avoid the need to add a row
  NB. for the slack variable, by the following observation.
  NB. Each >: equation during phase 1 is of the form
  NB. artificial_vbl = constraint + slack_vbl
  NB. The key observation is that as rows enter the left side,
  NB. they make no change to the slack_vbl; and the slack_vbl
  NB. column does not affect any other row until this equation leaves
  NB. (because each slack vbl starts out in only one equation).
  NB. So, when this artificial_vbl is ready to move to the right
  NB. side, it must be 0, and we then rewrite the equation as
  NB. slack_vbl = -constraint
  NB. just after we exchange the artificial_vbl to the right side.
  NB. We also remember that the slack variable has a contribution
  NB. of 1*itself to the auxiliary objective, so we add that in when
  NB. the slack variable makes its first appearance.
  NB.
  NB. = constraints have no slack variable, so we simply put the
  NB. artificial variable on the left side and delete it after
  NB. phase 1.
  NB.
  NB. We have to be careful that all the artificial variables
  NB. are removed from the left side after phase 1 is finished, in case
  NB. that didn't happen naturally during phase 1.  Once an artificial
  NB. variable is swapped to the right side, we make sure it never returns.

  NB. The auxiliary objective function becomes the last line of the tableau,
  NB. with the actual objective function as the second-last line.
  tableau =. (nonlemsk , 0) (] , -@(+/)@#) tableau

  NB. Now run simplex phase 1 to find an initial feasible basic vector.
  NB. The left-side labels are for slack variables, the right-side labels
  NB. for real variables
  'rc tableau rowlab collab' =. parm solverestricted tableau

  if. rc do. rc  ; (({:$constraints)#0) ; 0 return. end.  NB. if phase 1 error, abort now

  NB. Check to see if there was no initial feasible basic vector found by
  NB. phase 1.  This will be the case if the phase-1 search was unable to
  NB. drive the auxiliary objective function up to 0.  In that case, exit.
  if. (-epsilon) > (<_1 _1) { tableau do. 2 ; ((#constraints)#0) ; 0 return. end.

  NB. Trim the tableau.  Remove the auxiliary objective function.
  parm =. 1;epsilon;types;rowlab;collab
  tableau =. }: tableau
end.
NB. We have a feasible starting vector.  Solve the system
'rc tableau rowlab collab' =. parm solverestricted tableau

if. rc do. rc  ; (({:$constraints)#0) ; 0 return. end.  NB. if error, abort now

NB. At last, a solution.  Extract the nonzero decision variables
NB. and return them in their proper positions.
dvm =. rowlab < {:$constraints  NB. mask of nonzero decision (i. e. non-slack) vbls

0 ; ((dvm # }: {:"1 tableau) (dvm # rowlab)} ({:$constraints)#0) ; (<_1 _1){tableau
)

NB. Testcases
0 : 0
(0;(0,(1%3),0 9);2%3) -: simplexnr 0 2 _4 0 ; (1 6 _1 0 ,: 0 _3 4 1) ; 2 8 ; 0 0
(0;0 3.325 4.725 0.95;17.025) -: simplexnr 1 1 3 _0.5 ; (1 0 2 0 , 0 2 0 _7 , 0 1 _1 2 ,: 1 1 1 1) ; 740 0 0.5 9 ; _1 _1 1 0
(0;0 4;12) -: simplexnr _2 3 ; (1 1 ,: 1 _1) ; 4 6 ; _1 _1
(0;2 0 8;280) -: simplexnr 60 30 20 ; (8 6 1 , 4 2 1.5 , 2 1.5 0.5 ,: 0 1 0) ; 48 20 8 5 ; _1 _1 _1 _1
(0;4 0 0;240) -: simplexnr 60 30 20 ; (8 6 1 , 4 2 1.5 , 2 1.5 0.5 ,: 0 1 0) ; 48 16 8 5 ; _1 _1 _1 _1
(0;3 3;21) -: simplexnr 5 2 ; (1 1 ,: 1 _1) ; 6 0 ; _1 _1
(0;0 3.325 4.725 0.95;17.025) -: simplexnr 1 1 3 _0.5 ; (1 0 2 0 , 0 2 0 _7 , 0 1 _1 2 ,: _1 _1 _1 _1) ; 740 0 0.5 _9 ; _1 _1 1 0
(0;3 3;21) -: simplexnr 5 2 ; (_1 _1 ,: 1 _1) ; _6 0 ; 1 _1
)
