NB. math/misc/gamesolver
NB. Find optimal mixed strategies for 2-person games
NB. Henry H. Rich (HenryHRich@nc.rr.com), April 2005
NB. version: 1.0.0

require 'math/misc/simplexnr'

NB.*solvegame v Find optimal mixed strategies for 2-person games
NB. y is: payoff matrix.  Red is at the top of the matrix,
NB.     Blue is on the left; in other words, each
NB.     row of y gives the payoffs to Blue for each of
NB.     Red's responses to one of Blue's plays.  Columns
NB.     give the payoff to Blue for each of his responses to
NB.     one of Red's plays.  Payoffs are payoffs to Blue.
NB. Result is: (Blue Strategy);(Red strategy);Value
NB.     or null if there is an error
solvegame =: 3 : 0"2
'Bn Rn' =. $y  NB. number of strategies for Blue and Red
NB. Solve for Red
m =. y - Rm =. 0 <. <./ ,y
'r Rs Rv' =. simplexnr (Rn$1);m;(Bn$1);(Bn$_1)
if. r ~: 0 do. '' return. end.
NB. Solve for Blue
m =. (|:-y) - Bm =. 0 <. <./ ,-y
'r Bs Bv' =. simplexnr (Bn$1);m;(Rn$1);(Rn$_1)
if. r ~: 0 do. '' return. end.
NB. Return result
((% +/) Bs) ; ((% +/) Rs) ; Rm + %Rv
)

NB. The following examples of game theory are taken from
NB. _The Compleat Strategyst_ by J. D. Williams:
NB.
NB. On a slow day, Red and Blue decide to match coins.  Blue
NB. suggests a slight change to the game: if the coins match,
NB. Blue wins $20; if they don't match, Red gets $30 if Blue
NB. has tails, $10 if he has heads.  What strategy should each
NB. player use, and how much, on average, will change hands
NB. per play?
NB.
NB. The payoff matrix is
NB.
NB.       Red
NB.      T   H
NB. B T  20 _30
NB. l
NB. u H _10  20
NB. e
NB.
NB.  and it is solved by
NB.
NB.    solvegame 2 2 $ 20 _30   _10 20
NB. +-----------+-----------+----+
NB. |0.375 0.625|0.625 0.375|1.25|
NB. +-----------+-----------+----+
NB.
NB. Blue should call tails 3/8 of the time; Red should call tails
NB. 5/8 of the time; Blue wins $1.25 per play on average.
NB.
NB.
NB. Blue has two radar installations.  He can defend one or the
NB. other but not both; Red can destroy either but not both.
NB. One installation is three times as valuable as the other.
NB. What strategies should they adopt?
NB.
NB. Valuing the lesser installation A at 1, Blue's surviving
NB. vaue after the attack is
NB.
NB.       Red
NB.      A   B
NB. B A  4   1
NB. l
NB. u B  3   4
NB. e
NB.
NB.    solvegame 2 2 $ 4 1   3 4
NB. +---------+---------+----+
NB. |0.25 0.75|0.75 0.25|3.25|
NB. +---------+---------+----+
NB.
NB. Blue defends the better installation 3/4 of the time; Red attacks
NB. the lesser one 3/4 of the time.  Blue's expected undestroyed value is
NB. 3.25.
