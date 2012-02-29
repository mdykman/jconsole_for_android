NB. help

NB. =========================================================
ABOUT=: 0 : 0
This is Conway's Game of Life. The rules are:

For a space that is occupied:
    Each cell with one or no neighbors dies
    Each cell with four or more neighbors dies
    Each cell with two or three neighbors survives.
For a space that is empty:
    Each cell with three neighbors becomes populated.

The pattern examples are taken from Al Hensel's collection, lifep.zip. If this is installed, each file can be loaded from the File menu. See:

   http://www.ibiblio.org/lifepatterns

There are many versions of Life in J. For example, see Cliff Reiter's Vector article (V21.3) on colored life, with scripts at:

   http://ww2.lafayette.edu/~reiterc/j/vector

)

NB. =========================================================
HELP=: 0 : 0
Menus:

File|Load Pattern File... reads Life 1.05 pattern files.

File|Configure... sets various options.

Patterns has several built-in patterns.

Buttons:
Back and Step move one step at a time. Back uses a buffer, default size 100 steps.

Code:
See help file: User Manual|Project Manager|Example: Life Project.

)
