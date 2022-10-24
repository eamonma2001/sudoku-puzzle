#lang racket

(require "main.rkt")
(require "project2.rkt")

(require rackunit)
(require rackunit/text-ui)

; CS 3270 instructor
; Vanderbilt University

; DO NOT ALTER THIS FILE.


(define-test-suite test-checkpoint
   (let ([puzzle (get-board-from-file (build-path 'up "txt" "sudoku-test1.txt"))])
     (test-equal?
      "Check if 1 can be placed at row 0 and column 8 of sudoku-test1.txt."
      (test-checkpoint-code puzzle 0 8 1) #t)

     (test-equal?
      "Check if 6 can be placed at row 0 and column 8 of sudoku-test1.txt."
      (test-checkpoint-code puzzle 0 8 6) #t)

     (test-equal?
      "Check if 7 can be placed at row 0 and column 8 of sudoku-test1.txt."
      (test-checkpoint-code puzzle 0 8 7) #t)

     (test-equal?
      "Check if 3 can be placed at row 8 and column 0 of sudoku-test1.txt."
      (test-checkpoint-code puzzle 8 0 3) #f)

     (test-equal?
      "Check if 9 can be placed at row 8 and column 0 of sudoku-test1.txt."
      (test-checkpoint-code puzzle 8 0 9) #f)

     (test-equal?
      "Check if 2 can be placed at row 8 and column 0 of sudoku-test1.txt."
      (test-checkpoint-code puzzle 8 0 2) #f)

     (test-equal?
      "Check if 6 can be placed at row 8 and column 8 of sudoku-test1.txt."
      (test-checkpoint-code puzzle 8 8 6) #t)

     (test-equal?
      "Check if 5 can be placed at row 8 and column 8 of sudoku-test1.txt."
      (test-checkpoint-code puzzle 8 8 5) #f))

   (let* ([puzzle (get-board-from-file (build-path 'up "txt" "sudoku-test1-solution.txt"))]
          [row (random 0 8)]
          [col (random 0 8)]
          [num (get-value puzzle row col)]
          [bad-num (if (= num 1) 9 (- num 1))]
          [one-left (set-value puzzle row col 0)])
     (test-equal?
      (format "~a~a"
       (format "Set value at row ~a and column ~a of ~a to zero, "
              row col "sudoku-test1-solution.txt")
       (format "then check if ~a can be placed at that position."
               num))
      (test-checkpoint-code one-left row col num) #t)

     (test-equal?
      (format "~a~a"
       (format "Set value at row ~a and column ~a of ~a to zero, "
              row col "sudoku-test1-solution.txt")
       (format "then check if ~a can be placed at that position."
               bad-num))
      (test-checkpoint-code one-left row col bad-num) #f)))

(define-test-suite test-solve
   (let ([puzzle (get-board-from-file (build-path 'up "txt" "sudoku-test1.txt"))]
         [solution (get-board-from-file (build-path 'up "txt" "sudoku-test1-solution.txt"))])
     (test-equal?
      "Solve sudoku-test1.txt"
      (solve-sudoku puzzle) solution))

   (let ([puzzle (get-board-from-file (build-path 'up "txt" "sudoku-test2.txt"))]
         [solution (get-board-from-file (build-path 'up "txt" "sudoku-test2-solution.txt"))])
     (test-equal?
      "Solve sudoku-test2.txt"
      (solve-sudoku puzzle) solution))

   (let ([puzzle (get-board-from-file (build-path 'up "txt" "sudoku-impossible.txt"))])
     (test-equal?
      "Solve sudoku-impossible.txt"
      (solve-sudoku puzzle) null)))

; Set up test suite for all tests.
(define all-tests
  (test-suite "Project 2"
   test-checkpoint
   test-solve))

; Run tests.
(run-tests all-tests)
