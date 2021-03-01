# ChessyStory

This is an iOS application written in Swift, where the user can generate all the paths
a knight can take on a chessboard from a starting position to an ending position in 3 moves.

The app shows an empty chessboard created with UIView, a calculate and a reset button.

The user drags his finger from the starting position to the ending position and presses
calculate. Then the application will show below the chessboard the results as a Algebraic
chess notation. If there no paths that the knight can take the application will show an
appropriate message and the user can try again after he resets the board.

The Algebraic chess notation will look like this (1,1) -> (2,2) -> (3,3) -> (4,4) and it
starts with the starting position and ends with the ending position.
