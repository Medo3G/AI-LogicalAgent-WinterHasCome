# AI-LogicalAgent-WinterHasCome
A logic-based agent for a Game of Thrones themed search problem.

## Problem Description
This project uses search to help Jon Snow save Westeros. The field where the white walkers are frozen in place can be thought of as an *m* x *n* grid of cells where *m*, *n* >= 4 . A grid cell is either free or contains one of the following: a white walker, Jon Snow, the dragonstone, or an obstacle. Jon Snow can move in the four directions as long as the cell in the direction of movement does not contain an obstacle or a living white walker. To obtain the dragonglass by which the white walkers can be killed, Jon has to go to the cell where the dragonstone lies to pick up a fixed number of pieces of dragonglass that he can carry. In order to kill a white walker, Jon has to be in an adjacent cell. An adjacent cell is a cell that lies one step to the north, south, east, or west. With a single move using the same piece of dragonglass, Jon can kill all adjacent white walkers. If Jon steps out of a cell where he used a piece of dragonglass to kill adjacent walkers, that piece of dragonglass becomes unusable. Once a white walker is killed, Jon can move through the cell where the walker was. If Jon runs out of dragonglass before all the white walkers are killed, he has to go back to the dragonstone to pick up more pieces of dragonglass. The project formulates a plan that Jon can follow to kill all the white walkers. An optimal plan is one where Jon uses the least number of pieces of dragonglass to kill all the white walkers.

## Implementation
### Actions
We have the following 5 actions in our implementation:

#### Up
When this action is triggered, Jon Snow moves to the upper cell if the conditions are satisfied.

#### Down
When this action is triggered, Jon Snow moves to the lower cell if the conditions are satisfied.

#### Left
When this action is triggered, Jon Snow moves to the left cell if the conditions are satisfied.

#### Right
When this action is triggered, Jon Snow moves to the right cell if the conditions are satisfied.

#### Attack
When this action is triggered, Jon Snow attacks the white walkers in the adjacent cells if the conditions are satisfied.

### Predicates
*jon_snow(X,Y,D, result(up, S))*: This predicate has two clauses, one that is satisfied if the cell in the successor state is a dragon stone cell, in this case Jon Snow will collect dragon stone automatically through this predicate and go up. Otherwise if the cell is not a dragon stone cell it will go to the second clause which only does the go up action.

*jon_snow(X,Y,D, result(down, S))*: This predicate has two clauses, one that is satisfied if the cell in the successor state is a dragon stone cell, in this case Jon Snow will collect dragon stone automatically through this predicate and go down. Otherwise if the cell is not a dragon stone cell it will go to the second clause which only does the go down action.

*jon_snow(X,Y,D, result(right, S))*: This predicate has two clauses, one that is satisfied if the cell in the successor state is a dragon stone cell, in this case Jon Snow will collect dragon stone automatically through this predicate and go right. Otherwise if the cell is not a dragon stone cell it will go to the second clause which only does the go right action.

*jon_snow(X,Y,D, result(left, S))*: This predicate has two clauses, one that is satisfied if the cell in the successor state is a dragon stone cell, in this case Jon Snow will collect dragon stone automatically through this predicate and go left. Otherwise if the cell is not a dragon stone cell it will go to the second clause which only does the go left action.

*jon_snow(X,Y,D, result(attack, S))*: This predicate has two clause, one that is satisfied if Jon Snow is trying to attack and there exists a white walker in a adjacent cell and Jon Snow has dragon glass. The other clause is satisfied if Jon Snow is trying to attack and there exists a white walker in a adjacent cell and the current cell is a dragon stone cell.

*white_walker(X,Y,result(A,S))*: This predicate solves a persistence case were we need to make sure that if the action is not attack, a living white walker should stay alive.

*white_walker(X,Y,result(attack,S))*: This predicate makes sure that a white walker will stay alive if an attack action is done when this white walker was not in a adjacent cell to Jon Snow.

*dead_white_walker(X,Y,result(attack,S))*: This predicate will kill a white walker if it was alive and the action was attack and the white walker was in a adjacent cell to Jon Snow and the dragon glass count was bigger than zero.

*dead_white_walker(X,Y,result(A,S))*: This predicate solves a persistence case were we need to make sure that a dead white walker will stay dead at any action.

### Successor State Axioms
*jon_snow(X,Y,D, result(up, S))*: The successor state of this predicate will be the new location of Jon Snow and it will be satisfied in case the new cell is not an obstacle cell and not a white walker cell. In this case the Y will be updated to Y-1 if Y-1 > 0. In case that the new cell is a dragon stone cell, the dragon stone count will be set to max.

*jon_snow(X,Y,D, result(down, S))*: The successor state of this predicate will be the new location of Jon Snow and it will be satisfied in case the new cell is not an obstacle cell and not a white walker cell. In this case the Y will be updated to Y+1 if Y+1 < the max height. In case that the new cell is a dragon stone cell, the dragon stone count will be set to max.

*jon_snow(X,Y,D, result(right, S))*: The successor state of this predicate will be the new location of Jon Snow and it will be satisfied in case the new cell is not an obstacle cell and not a white walker cell. In this case the X will be updated to X+1 if X+1 < the max width. In case that the new cell is a dragon stone cell, the dragon stone count will be set to max.

*jon_snow(X,Y,D, result(left, S))*: The successor state of this predicate will be the new location of Jon Snow and it will be satisfied in case the new cell is not an obstacle cell and not a white walker cell. In this case the X will be updated to X-1 if X-1 > 0. In case that the new cell is a dragon stone cell, the dragon stone count will be set to max.

*jon_snow(X,Y,D, result(attack, S))*: The successor state of this predicate updates the states of the white walkers in the adjacent and kills them if Jon Snow is having a dragon stone count > 0 or he is in a dragon stone cell.

*white_walker(X,Y,result(A,S))*: The successor state of this predicate makes sure that a white walker will stay alive if the action is not attack.

*white_walker(X,Y,result(attack,S))*: The successor state of this predicate will make sure that a white walker will stay alive if the action is attack but he is not in an adjacent cell to Jon Snow.

*dead_white_walker(X,Y,result(attack,S))*: The successor state of this predicate will make dead white walker true if he was already alive and in an adjacent cell to Jon Snow and Jon Snow's dragon glass count is bigger than zero.

*dead_white_walker(X,Y,result(A,S))*: This successor state is for persistence it will make sure that a dead white walker will stay dead.

### Plan Generation Query
*query(S)*: This query will try to unify all the predicates without a depth limit.

*query_with_depth(S, N, L)*: This query will try to unify with a depth limit as an input.

*start(S)*: This query will unify using iterative deepening.
***
Done as a part of Artificial Intelligence course.
