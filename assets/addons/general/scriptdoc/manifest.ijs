NB. scriptdoc manifest

CAPTION=: 'scriptdoc'

DESCRIPTION=: 0 : 0
Scripts are documented in comment lines (i.e. lines
beginning with NB.). Multi-line comments are consecutive
lines beginning with NB. with no break.

The first line of a multi-line comment may be used
for summary documentation of the script.


1. The first line in the script is a comment line describing the script, i.e

   NB. script description

2. Global definitions produced by the script are preceded by
one or more comment lines. The first such comment line has
the form:

   NB.*name type description

where type is one of:
        v verb
        a  adverb
        c  conjunction
        n  noun

After this first comment line, all subsequent comment lines
without a break are assumed to be part of the description
for the definition.

The * should not be given after the NB. unless it begins
a new definition.

Conventionally, the second such line may be a "form" statement
describing the usage of the definition, e.g.

   form:  calendar year [,months]

Other lines include an "example" statement

   example: calendar 1998 5

3. Other NB. comment lines in the script are ignored.
)

VERSION=: '1.0.0'

RELEASE=: 'j701'

FILES=: 0 : 0
scriptdoc.ijs
history.txt
)
