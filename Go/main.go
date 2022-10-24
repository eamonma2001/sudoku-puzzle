package main

import (
	"fmt"
	"os"
	"strconv"
	"sudokuSolver/solver"
)

func main() {
	//read board
	solver.Board = readSudoku("txt/sudoku-test2.txt")
	fmt.Print("Input Sudoku Board:\n\n")
	for i := 0; i < 9; i++ {
		fmt.Println(solver.Board[i])
	}
	fmt.Println()

	//find and print solution
	if solver.Solve(solver.Board) {
		fmt.Print("Solved! Solution is:\n\n")
		for i := 0; i < 9; i++ {
			fmt.Println(solver.Board[i])
		}
		fmt.Println()
	} else {
		fmt.Println("Unsolvable Puzzle")
		return
	}

	//compare solutions
	solutionBoard := readSudoku("txt/sudoku-test2-solution.txt")
	if solver.Board == solutionBoard {
		fmt.Println("Congrats! It is the correct solution")
	} else {
		fmt.Println("Meh. You got it wrong.")
	}

	//read board from user input
	fmt.Print("Enter Input Sudoku Board:\n\n")
	var board string
	//take input from user
	fmt.Scanln(&board)

	solver.Board = readSudoku(board)
	for i := 0; i < 9; i++ {
		fmt.Println(solver.Board[i])
	}
	fmt.Println()

	//find and print solution
	if solver.Solve(solver.Board) {
		fmt.Print("Solved! Solution is:\n\n")
		for i := 0; i < 9; i++ {
			fmt.Println(solver.Board[i])
		}
		fmt.Println()
	} else {
		fmt.Println("Unsolvable Puzzle")
		return
	}
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}

/**
 * Re-initializes the object with a new puzzle from the specified file.
 *
 * @param  loc The relative path of the text file
 * @return [9][9]int   the sudoku board that is being solved
 */
func readSudoku(loc string) [9][9]int {
	raw, err := os.ReadFile(loc)
	check(err) //error check

	//read the sudoku into a 2d Array
	var dat [9][9]int //array type for ease of comparison
	for i := 0; i < 9; i++ {
		for j := 0; j < 9; j++ {
			n, _ := strconv.Atoi(string(raw[i*18+j*2]))
			dat[i][j] = n
		}
	}

	return dat
}
