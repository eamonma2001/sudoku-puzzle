% Complete description: A Prolog program that reads a file containing an unfinished Sudoku puzzle, 
% then solves the puzzle using a recursive backtracking algorithm.


% Use routines from the Constraint Logic Programming over Finite Domains library.
:- use_module(library('clpfd')).


% The main entry point. Enter "go." at the Prolog prompt.
% 
go :-
    File = 'txt/sudoku-test1.txt',
    start(File).


% The absolute path of the root folder of the project.
% NOTE: MUST BE CHANGED TO THE ABSOLUTE PATH OF ROOT FOLDER OF YOUR PROJECT ON YOUR LOCAL COMPUTER.
%       MAC USERS: USE FORWARD SLASH '/'
%
project_root(Dir) :-
    Dir = '/Users/mayimeng/Documents/Projects/sudoku-puzzle/prolog/'.


% To test other than 'sudoku-test1.txt', pass the text file name preceded by 'txt/'.
% For example, enter "start('txt/sudoku-test2.txt')."
%
start(File) :-
    project_root(Dir),                       % Get absolute path to root folder of project.
    atom_concat(Dir, File, PuzzleFile),      % Concatenate path with text file relative location.
    see(PuzzleFile),                         % Open file.
    write(trying_file(PuzzleFile)), nl, nl,  % Display puzzle.
    read(Board),                             % Read board.
    seen,                                    % Close file.
    time(sudoku(Board)),                     % Call solver (with timer).
    pretty_sudo_print(Board), nl.            % Printed solution.


% Print the board to the screen, where each row printed using printsudorow.
%
pretty_sudo_print(Board) :-
    Board = [R1, R2, R3, R4, R5, R6, R7, R8, R9],
    nl, nl,
    printsudorow(R1),
    printsudorow(R2),
    printsudorow(R3),
    write('-------+-------+-------'), nl,
    printsudorow(R4),
    printsudorow(R5),
    printsudorow(R6),
    write('-------+-------+-------'), nl,
    printsudorow(R7),
    printsudorow(R8),
    printsudorow(R9).


% Print row by printing each column.
%
printsudorow(Row) :-
    Row = [C1,C2,C3,C4,C5,C6,C7,C8,C9],
    write(' '),
    write(C1), write(' '),
    write(C2), write(' '),
    write(C3), write(' '), write('|'), write(' '),
    write(C4), write(' '),
    write(C5), write(' '),
    write(C6), write(' '), write('|'), write(' '),
    write(C7), write(' '),
    write(C8), write(' '),
    write(C9), write(' '), nl.


% Main solver containing the rules to solve Sudoku.
%
sudoku(Board) :-

    % the Sudoku board with 81 unique variables.
    Board = [[E11, E12, E13, E14, E15, E16, E17, E18, E19],
            [E21, E22, E23, E24, E25, E26, E27, E28, E29],
            [E31, E32, E33, E34, E35, E36, E37, E38, E39],
            [E41, E42, E43, E44, E45, E46, E47, E48, E49],
            [E51, E52, E53, E54, E55, E56, E57, E58, E59],
            [E61, E62, E63, E64, E65, E66, E67, E68, E69],
            [E71, E72, E73, E74, E75, E76, E77, E78, E79],
            [E81, E82, E83, E84, E85, E86, E87, E88, E89],
            [E91, E92, E93, E94, E95, E96, E97, E98, E99]],

    % Each of the variables represent a unique row of the puzzle.
    Board = [One, Two, Three, Four, Five, Six, Seven, Eight, Nine],

    % Ensure that each row in the puzzle has all different values.
    all_different(One),
    all_different(Two),
    all_different(Three),
    all_different(Four),
    all_different(Five),
    all_different(Six),
    all_different(Seven),
    all_different(Eight),
    all_different(Nine),

    % Ensure each column must also be all unique values.
    all_different([E11, E21, E31, E41, E51, E61, E71, E81, E91]),
    all_different([E12, E22, E32, E42, E52, E62, E72, E82, E92]),
    all_different([E13, E23, E33, E43, E53, E63, E73, E83, E93]),
    all_different([E14, E24, E34, E44, E54, E64, E74, E84, E94]),
    all_different([E15, E25, E35, E45, E55, E65, E75, E85, E95]),
    all_different([E16, E26, E36, E46, E56, E66, E76, E86, E96]),
    all_different([E17, E27, E37, E47, E57, E67, E77, E87, E97]),
    all_different([E18, E28, E38, E48, E58, E68, E78, E88, E98]),
    all_different([E19, E29, E39, E49, E59, E69, E79, E89, E99]),

    % Ensure each submatrix must be all unique values.
    all_different([E11, E12, E13, E21, E22, E23, E31, E32, E33]),
    all_different([E14, E15, E16, E24, E25, E26, E34, E35, E36]),
    all_different([E17, E18, E19, E27, E28, E29, E37, E38, E39]),
    all_different([E41, E42, E43, E51, E52, E53, E61, E62, E63]),
    all_different([E44, E45, E46, E54, E55, E56, E64, E65, E66]),
    all_different([E47, E48, E49, E57, E58, E59, E67, E68, E69]),
    all_different([E74, E75, E76, E84, E85, E86, E94, E95, E96]),
    all_different([E71, E72, E73, E81, E82, E83, E91, E92, E93]),
    all_different([E77, E78, E79, E87, E88, E89, E97, E98, E99]),

    % Instantiate each variable in the Board with values.
    flatten(Board, Lst),

    % Specify the range of values for all the variables in the flattened list.
    Lst ins 1..9,

    % Find the values for each unknown variable.
    label(Lst).
    