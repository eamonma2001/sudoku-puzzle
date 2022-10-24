#lang racket

(provide get-board-from-file)
(provide get-value)
(provide set-value)

(require racket/lazy-require)
(lazy-require ["project2.rkt" (solve-sudoku)])

; CS 3270 instructor
; Vanderbilt University

; DO NOT ALTER THIS FILE.


; Define some global constants.
(define BOARD-SIZE 9)       ; The size of the board.
(define ROWS 9)             ; The number of rows.
(define COLS 9)             ; The number of columns.
(define GRID-SIZE 3)        ; The size of a subgrid.


; Add path to file name.
;
; @param  file-name Name of file to add path to.
; @return Path of the file.
(define (file-path file-name)
  (build-path 'up "txt" file-name))


; Entry point to the sudoku solver with textual output.
; Times the solution function.
;
; This function accepts zero or one parameter.
;
; Calling just (run-sodoku) will run the Sudoku solver on the 
; default puzzle in sudoku-test1.txt in the "txt" directory.
;
; To solve a different puzzle (in a different text file),
; pass the name of the file as a parameter (enclosed with
; double quotes). For example, (run-sudoku "sudoku-test2.txt")
; It is assumed that the file is in the "txt" directory.
;
; @param  args The file to load.
(define (run-sudoku [file-name "sudoku-test1.txt"])
  (let ([board (get-board-from-file (file-path file-name))])
    (if board
        (begin
          (displayln "")
          (displayln "Puzzle:")
          (displayln "")
          (print-board board)
          (displayln "")
          (let ([solution (time (solve-sudoku board))])
            (if (null? solution)
                (displayln "No solution")
                (begin
                  (displayln "")
                  (displayln "Solution:")
                  (displayln "")
                  (print-board solution)
                  (displayln "")))))
        (displayln "There is no board to process"))))


; Loads a board from the given file.
; It expects the board to be in the format of a single S-expression:
; a list of nine lists, each containing nine numbers.
;
; @param  file-location The location of file to load.
(define (get-board-from-file file-location)
  (let ([in (open-input-file file-location #:mode 'text)])
    (read in)))
    

; Prints a board.
;
; @param  board The board to print.
(define (print-board board)
  (begin
    (print-row (list-ref board 0))
    (print-row (list-ref board 1))
    (print-row (list-ref board 2))
    (printf "------+-------+------ ~n")
    (print-row (list-ref board 3))
    (print-row (list-ref board 4))
    (print-row (list-ref board 5))
    (printf "------+-------+------ ~n")
    (print-row (list-ref board 6))
    (print-row (list-ref board 7))
    (print-row (list-ref board 8))))


; Print a row of the board with dividing lines.
;
; @param  row The row of the board to print.
(define (print-row row)
  (printf "~a ~a ~a | ~a ~a ~a | ~a ~a ~a ~n"
          (list-ref row 0)
          (list-ref row 1)
          (list-ref row 2)
          (list-ref row 3)
          (list-ref row 4)
          (list-ref row 5)
          (list-ref row 6)
          (list-ref row 7)
          (list-ref row 8)))


; Returns the value on the board at a specified row and column.
;
; @param  board The board where the value is located.
; @param  row   The row of the value.
; @param  col   The column of the value.
; @return The value at row and col of board.
(define (get-value board row col)
  (list-ref (list-ref board row) col))

  
; Places a given value in the specified row and column and
; return the new board.
; Note: non-destructive! It returns a new board.
;
; @param  board The initial board that will be added value.
; @param  row   The row of the value.
; @param  col   The column of the value.
; @param  num   The number to set on the board.
; @return A new copy of the board where value is placed at row and col.
(define (set-value board row col num)
  (list-set board row (list-set (list-ref board row) col num)))
