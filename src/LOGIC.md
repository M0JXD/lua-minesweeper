# Lua Minesweeper Logic Implementation

Minesweeper Core Logic in Lua

Minesweeper logic offers support for three game modes:

- Beginner: 8x8 with 10 mines
- Intermediate: 16x16 with 40 mines
- Expert: 30x16 with 99 mines

The main board is represented by a 2D Matrix.

Each 'cell' contains a value reprenting what it is:

Internally, these values are:

- `nil` for hidden cell
- `0` for a revealed cell with no adjacent mines
- A number a revealed cell with 'n' adjacent mines
- `'F'` for a flagged cell with no mine
- `'FM'` for a flagged cell with a mine
- `'M'` for a  mine

Externally, this is simplified to:

- `nil` for a hidden cell
- `0` for a revealed cell with no adjacent mines
- A number a revealed cell with 'n' adjacent mines
- `'F'` for a flagged cell
- `'M'` mines upon game completion (user must check if board contains mines)

All functions return the simplified plottable board.

<a id="minesweeper_logic.get_details"></a>
## `minesweeper_logic.get_details`(*mode*)

Returns the columns, rows and a blank board (handy for first plots) for a mode.

Parameters:
- *mode*:  The mode to check for (beginner, intermediate or expert).

Returns: Details with no. columns, rows and a blank "board" to use for starting.

<a id="minesweeper_logic.setup_game"></a>
## `minesweeper_logic.setup_game`(*mv_x*, *mv_y*, *mode*)

Sets up a new game based on the mode and first sweep (where a mine must never be).

Parameters:
- *mv_x*:  Horizontal coordinate of first move.
- *mv_y*:  Vertical coordinate of first move.
- *mode*:  Mode the player chose.

Returns: Plottable board.

<a id="minesweeper_logic.sweep_cell"></a>
## `minesweeper_logic.sweep_cell`(*x*, *y*)

Sweep from selected cell.

Parameters:
- *x*:  Horizontal coordinate.
- *y*:  Vertical coordinate.

Returns: Plottable board, if the user won/lost.

<a id="minesweeper_logic.toggle_flag"></a>
## `minesweeper_logic.toggle_flag`(*x*, *y*)

Toggle the flag for a cell.

Parameters:
- *x*:  horizontal coordinate.
- *y*:  vertical coordinate.

Returns: Plottable board.



