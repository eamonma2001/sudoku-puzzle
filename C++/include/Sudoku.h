#include <iostream>

#ifndef SUDOKU_H
#define SUDOKU_H

// numbers per row/column
const int BOARD_SIZE = 9;

class Sudoku {
public:
    Sudoku();

    void loadFromFile(std::string filename);

    bool solve();

    [[nodiscard]] bool equals(const Sudoku& other) const;

private:
    // set a 2D array to represent the puzzle
    int board[BOARD_SIZE][BOARD_SIZE];

    friend std::ostream& operator<<(std::ostream& out, const Sudoku& sudoku);

    bool findSolution(int& row, int& col);

    bool checkRow(int row, int num);

    bool checkCol(int col, int num);

    bool checkBox(int row, int col, int num);
};

#endif