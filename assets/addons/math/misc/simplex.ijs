NB. math/misc/simplex
NB. Simplex method
NB. version: 1.0.0
NB.
NB. see also math/misc/simplexnr for the simplex method following
NB. "Numerical Recipes in C"
NB.
NB. example description thanks to Henry H. Rich

NB. simplex              simplex method
NB.
NB. Example:
NB.    mat=: 1 _2 _3 0 0 0 , 0 4 1 1 0 12 ,: 0 2 5 0 1 15
NB.    simplex mat
NB. 1 0 0  0.2222222   0.5555556  11
NB. 0 1 0  0.2777778 _0.05555556 2.5
NB. 0 0 1 _0.1111111   0.2222222   2
NB.
NB. The example corresponds to the problem:
NB.
NB. Maximize
NB.   2x[2] + 3x[3]
NB. subject to the constraints
NB.   4x[2] +  x[3] <: 12
NB.   2x[2] + 5x[3] <: 15
NB.
NB. The first line of 'mat' is reserved for the objective
NB. function.  The new variable x[1] is introduced, appearing
NB. in no other equation, and the rest of the objective
NB. function is negated, leaving
NB.
NB. x[1] - 2x[2] - 3x[3] = objective (initially 0)
NB.
NB. When the simplex method finishes, x[1] will represent the
NB. value of the objective function.  The right-hand column
NB. of 'mat' has the constant constraints.
NB.
NB. All rows of 'mat' after the first represent constraints.
NB. All the constraints in 'mat' are equalities.  To use
NB. the simplex code to solve a given problem, additional
NB. variables must be added to the problem, as follows
NB. (the so-called 'Big M' method):
NB.
NB. For a constraint of the form
NB.   c[2]x[2] + ... + c[n]x[n] <: value ,
NB. create a new variable, and put it into the constraint
NB. equation with a coefficient of 1.  The coefficient of
NB. this variable in all other rows (including the objective)
NB. will be 0.  This added variable is called a 'slack variable'.
NB.
NB. For a constraint of the form
NB.   c[2]x[2] + ... + c[n]x[n] = value ,
NB. create a new variable, and put it into the constraint
NB. equation with a coefficient of 1.  The coefficient of
NB. this variable in all other rows (EXCEPT the objective)
NB. will be 0.  The coefficient in the objective equation
NB. will be a (negative) Big Number - such a big cost that the
NB. system will not rest until the added variable has been
NB. assigned the value 0.  The definition of Big depends on
NB. the scale of your problem.  This added variable is called
NB. an 'artificial variable'.
NB.
NB. For a constraint of the form
NB.   c[2]x[2] + ... + c[n]x[n] >: value ,
NB. create 2 new variables, as above: one artificial variable
NB. and one slack variable.
NB.
NB. In the example, the 2 added slack variables make the system
NB. look like:
NB.
NB. 4x[2] +  x[3] + x[4]        = 12
NB. 2x[2] + 5x[3]        + x[5] = 15
NB.
NB. The simplex code does elementary row operations on this system
NB. while ensuring that the objective increases.  When execution
NB. terminates, (#y) variables are nonzero, and the rest will have
NB. zero values. The nonzero variables are the ones whose column
NB. headings are 0 with a single 1 somewhere in a column that is
NB. otherwise all 0.  The value of each such variable is given in
NB. the right-hand column, in the row in which the 1 was found.
NB.
NB. If artificial variables were introduced, you should check to
NB. verify that they are all given 0 value.  If they are not,
NB. the problem has no solution satisfying the constraints.
NB.
NB. In the example, the solution is
NB. x[1] = 11 (final objective value), x[2]=2.5, x[3]=2

require 'math/misc/matutil'

NB. =========================================================
NB.*simplex v Simplex method
NB. eg:
NB.    mat=: 1 _2 _3 0 0 0 , 0 4 1 1 0 12 ,: 0 2 5 0 1 15
NB.    simplex mat
NB. 1 0 0  0.2222222   0.5555556  11
NB. 0 1 0  0.2777778 _0.05555556 2.5
NB. 0 0 1 _0.1111111   0.2222222   2
NB.
NB. The example corresponds to the problem:
NB.
NB. Maximize
NB.   2x[2] + 3x[3]
NB. subject to the constraints
NB.   4x[2] +  x[3] <: 12
NB.   2x[2] + 5x[3] <: 15
NB. See the 'math/misc/simplex' script for full description
simplex=: 3 : 0
min=. i. <./
m=. y
while.
  r0=. }:{.m
  c=. min r0
  0 > c{r0
do.
  t=. {:"1 m
  d=. c{"1 m
  f=. (0 > d){0 _	
  r=. min f + t % d
  m=. (r,c) pivot m
end.
)
