package solver

var Board [9][9]int

/**
* check if the value is valid at certain location
*
* @param row the row that will be checked
* @param col the column that wil be checked
* @param val the value that might be placed in the empty cell
* @param board the sudoku board that is being solved
* @return bool   whether the value is valid at the location
 */
func checkLoc(row, col, val int, board [9][9]int) bool {
	return checkRow(row, val, board) &&
		checkCol(col, val, board) &&
		checkSubMatrix(row, col, val, board)
}

/**
* check if the value exists in the row
*
* @param row the row that will be checked
* @param val the value that might be placed in the empty cell
* @param board the sudoku board that is being solved
* @return bool   whether the value is valid in this row
 */
func checkRow(row, val int, board [9][9]int) bool {
	for i := 0; i < 9; i++ {
		if board[row][i] == val {
			return false
		}
	}
	return true
}

/**
* check if the value exists in the column
*
* @param col the col that will be checked
* @param val the value that might be placed in the empty cell
* @param board the sudoku board that is being solved
* @return bool   whether the value is valid in this column
 */
func checkCol(col, val int, board [9][9]int) bool {
	for i := 0; i < 9; i++ {
		if board[i][col] == val {
			return false
		}
	}
	return true
}

/**
* check if the value exists in the submatix
*
* @param row the row in the target submatrix
* @param col the col in the target submatrix
* @param val the value that might be placed in the target cell
* @param board the sudoku board that is being solved
* @return bool   whether the value is valid in this submatrix
 */
func checkSubMatrix(row, col, val int, board [9][9]int) bool {
	var sRow int = row - row%3
	var sCol int = col - col%3

	for i := 0; i < 3; i++ {
		for j := 0; j < 3; j++ {
			if board[sRow+i][sCol+j] == val {
				return false
			}
		}
	}
	return true
}

/**
 * Check whether a solution is found.
 *
 * @param board the sudoku board that is being solved
 * @return bool   whether a solution is found.
 */
func Solve(board [9][9]int) bool {
	stack := make([][]int, 0) //slice to store empty entries locations

	for i := 0; i < 9; i++ {
		for j := 0; j < 9; j++ {
			if board[i][j] == 0 {
				temp := make([]int, 2) // [i,j] pair for empty space
				temp[0] = i
				temp[1] = j
				stack = append(stack, temp)
			}
		}
	}

	Board = board //set global var
	return solveHelper(stack, 0)
}

/**
 * Helper function that serves as Tte entry point for the solver.
 *
 * @param stack the slice to store empty entries locations
 * @param index the num used to track whther spaces are filled
 * @return bool   whether a solution is found.
 */
func solveHelper(stack [][]int, index int) bool {
	if index >= len(stack) { //finished filling all spaces
		return true
	}

	row := stack[index][0] //init values
	col := stack[index][1]

	possibleVal := [9]int{1, 2, 3, 4, 5, 6, 7, 8, 9}
	for i := 0; i < 9; i++ {
		//find valid value - recursive backtrack
		if checkLoc(row, col, possibleVal[i], Board) {
			Board[row][col] = possibleVal[i] //choose
			if solveHelper(stack, index+1) {
				return true
			}
			Board[row][col] = 0 //unchoose
		}
	}

	return false
}
