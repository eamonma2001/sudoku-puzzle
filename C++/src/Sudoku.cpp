#include "Sudoku.h"
#include <fstream>
#include <iostream>

/**
 * Default constructor.
 * Should initialize the object with an empty puzzle (81 zeroes).
 */
Sudoku::Sudoku()
{
    for (uint32_t row = 0; row < BOARD_SIZE; ++row) {
        for (uint32_t col = 0; col < BOARD_SIZE; ++col) {
            board[row][col] = 0; // Sets all squares to 0
        }
    }
}

/**
 * Re-initializes the object with a new puzzle from the specified file.
 *
 * @param  filename  The relative path of the text file
 */
void Sudoku::loadFromFile(std::string filename)
{
    std::ifstream file;
    file.open(filename.c_str());

    if (file.fail()) {
        std::cout << "Error opening file" << std::endl;
        std::cout << "press enter to exit";
        std::cin.get();
        exit(1);
    }

    int num;
    file >> num;
    for (uint32_t row = 0; row < BOARD_SIZE; ++row) {
        for (uint32_t col = 0; col < BOARD_SIZE; ++col) {
            board[row][col] = num;

            // read until the end
            if (!file.eof()) {
                file >> num;
            }
        }
    }

    file.close();
}

/**
 * The entry point for the solver.
 *
 * @return True if a solution was found, otherwise returns false
 */
bool Sudoku::solve()
{
    int row = 0, col = 0;

    // check if a solution is found
    if (findSolution(row, col)) {
        return true;
    }

    for (uint32_t i = 0; i < BOARD_SIZE; ++i) {
        // check if a number is available in this case
        if (checkRow(row, i + 1) && checkCol(col, i + 1) && checkBox(row, col, i + 1)) {
            board[row][col] = i + 1;

            // call solve() recursively
            if (solve()) {
                return true;
            }
            board[row][col] = 0;
        }
    }
    return false;
}

/**
 * Determines if two puzzles are equal.
 * Two puzzles are equal if the values in each corresponding cell are the same.
 *
 * @param  other  The other Sudoku to be compared with
 * @return  True if two puzzles are equal, otherwise returns false
 */
bool Sudoku::equals(const Sudoku& other) const
{
    for (uint32_t row = 0; row < BOARD_SIZE; ++row) {
        for (uint32_t col = 0; col < BOARD_SIZE; ++col) {
            if (board[row][col] != other.board[row][col]) {
                return false;
            }
        }
    }
    return true;
}

/**
 * A friend function that prints to the output stream out the current puzzle contents
 * in a nicely formatted manner.
 *
 * @param  out  The output stream
 * @param  sudoku  The current puzzle
 * @return  The output stream
 */
std::ostream& operator<<(std::ostream& out, const Sudoku& sudoku)
{
    for (uint32_t row = 0; row < BOARD_SIZE; ++row) {
        for (uint32_t col = 0; col < BOARD_SIZE; ++col) {
            if (sudoku.board[row][col] == 0) {
                out << "  ";
            } else {
                out << sudoku.board[row][col] << " ";
            }

            if (col == 2 || col == 5) {
                out << "| ";
            }
        }

        out << "\n";

        if (row == 2 || row == 5) {
            out << "------+-------+------\n";
        }
    }
    return out;
}

/**
 * Check whether a solution is found.
 *
 * @param  row  The row
 * @param  col  The column
 * @return  True if a solution is found, otherwise returns false
 */
bool Sudoku::findSolution(int& row, int& col)
{
    for (uint32_t i = 0; i < BOARD_SIZE; ++i) {
        for (uint32_t j = 0; j < BOARD_SIZE; ++j) {
            if (board[i][j] == 0) {
                row = i;
                col = j;
                return false;
            }
        }
    }
    return true;
}

/**
 * Check whether a certain number is available to be entered within a row
 *
 * @param  row  The row
 * @param  num  The number to be checked
 * @return  True if a certain number is available, otherwise returns false
 */
bool Sudoku::checkRow(int row, int num)
{
    for (uint32_t i = 0; i < BOARD_SIZE; ++i) {
        if (board[row][i] == num) {
            return false;
        }
    }
    return true;
}

/**
 * Check whether a certain number is available to be entered within a column
 *
 * @param  col  The column
 * @param  num  The number to be checked
 * @return  True if a certain number is available, otherwise returns false
 */
bool Sudoku::checkCol(int col, int num)
{
    for (uint32_t i = 0; i < BOARD_SIZE; ++i) {
        if (board[i][col] == num) {
            return false;
        }
    }
    return true;
}

/**
 * Check whether a certain number is available to be entered within a 3x3 box
 *
 * @param  row  The row
 * @param  col  The column
 * @param  num  The number to be checked
 * @return  True if a certain number is available, otherwise returns false
 */
bool Sudoku::checkBox(int row, int col, int num)
{
    for (uint32_t i = 0; i < 3; ++i) {
        for (uint32_t j = 0; j < 3; ++j) {
            if (board[row - row % 3 + i][col - col % 3 + j] == num) {
                return false;
            }
        }
    }
    return true;
}
