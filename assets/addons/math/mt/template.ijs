NB. <this file purpose; brief description>
NB.
NB. <name>        <brief description>
NB. ...
NB. <name>        <brief description>
NB.
NB. <testxxname>  Test <name> by <matrix of type xx> given
NB. ...
NB. <testxxname>  Test <name> by <matrix of type xx> given
NB. <testname>    Adv. to make verb to test <names> by
NB.               matrix of generator and shape given
NB.
NB. Version: <n.n.n> <yyyy-mm-dd>
NB.
NB. Copyright <yyyy> <full name>
NB.
NB. This file is part of mt
NB.
NB. mt is free software: you can redistribute it and/or
NB. modify it under the terms of the GNU Lesser General
NB. Public License as published by the Free Software
NB. Foundation, either version 3 of the License, or (at your
NB. option) any later version.
NB.
NB. mt is distributed in the hope that it will be useful, but
NB. WITHOUT ANY WARRANTY; without even the implied warranty
NB. of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
NB. See the GNU Lesser General Public License for more
NB. details.
NB.
NB. You should have received a copy of the GNU Lesser General
NB. Public License along with mt. If not, see
NB. <http://www.gnu.org/licenses/>.

coclass 'mt'

NB. =========================================================
NB. Concepts <optional section>
NB.
NB. <Any text>

NB. =========================================================
NB. Local definitions <optional section>

<isolated definitions, optional section>

<localname>=: <definition>  NB. <individual description>
...
<localname>=: <definition>  NB. <individual description>

<OR>

NB. <multi-line...
NB. ...individual description>
<localname>=: <definition>

...

NB. <multi-line...
NB. ...individual description>
<localname>=: <definition>

<OR>

NB. <common description>
<localname>=: <definition>
...
<localname>=: <definition>

<end of optional isolated definitions section>

NB. ---------------------------------------------------------
NB. <grouped definitions description, optional section>

<localname>=: <definition>  NB. <individual description>
...
<localname>=: <definition>  NB. <individual description>

<OR>

NB. <multi-line...
NB. ...individual description>
<localname>=: <definition>

...

NB. <multi-line...
NB. ...individual description>
<localname>=: <definition>

<OR>

NB. <common description>
<localname>=: <definition>
...
<localname>=: <definition>

NB. ---------------------------------------------------------
NB. <LocalAdverb>
NB.
NB. Description: <optional section>
NB.   Adv. to make verb to <description>
NB.
NB. Syntax: <optional section>
NB.   vapp=. <u> <LocalAdverb>
NB.   vapp=. <u0>`<u1>`... <LocalAdverb>
NB. where
NB.   <u>  - monad/dyad to <description>, is called as:
NB.            <o>=. [<x>] <u> <y>
NB.   vapp - monad/dyad to <description>, is called as:
NB.            <o>=. [<x>] vapp <y>
NB.   <y>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.   <x>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.   <o>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.
NB. Formula: <optional section>
NB. - <description>:
NB.     <formula>
NB. ...
NB. - <description>:
NB.     <formula>
NB.
NB. Storage layout: <optional section>
NB.   <layout>
NB. where
NB.   <description>
NB.
NB. Algorithm: <optional section>
NB.   In: <input nouns; comma-separated list>
NB.   Out: <output nouns; comma-separated list>
NB.   1) <1st step description>
NB.   ...
NB.   x) <last step description>
NB.
NB. Assertions (with appropriate comparison tolerance): <optional section>
NB.   <assertion>
NB.   ...
NB.   <assertion>
NB. where
NB.   <copula>
NB.   ...
NB.   <copula>
NB.
NB. Examples: <optional section>
NB.    <command to execute>
NB. <output>
NB. ...
NB.    <command to execute>
NB. <output>
NB.
NB. Application: <optional section>
NB. - <description>
NB.     <command to execute>
NB. ...
NB. - <description>
NB.     <command to execute>
NB.
NB. Notes: <optional section>
NB. - <text>
NB. ...
NB. - <text>
NB.
NB. References: <optional section>
NB. [1] <reference>
NB. ...
NB. [x] <reference>
NB.
NB. TODO: <optional section>
NB. - <text>
NB. ...
NB. - <text>

<LocalAdverb>=: <definition>

NB. ---------------------------------------------------------
NB. <LocalConjunction>
NB.
NB. Description: <optional section>
NB.   Conj. to make verb to <description>
NB.
NB. Syntax: <optional section>
NB.   vapp=. <u> <LocalConjunction> <v>
NB.   vapp=. <u0>`<u1>`... <LocalConjunction> <v0>`<v1>`...
NB. where
NB.   <u>  - monad/dyad to <description>, is called as:
NB.            <o>=. [<x>] <u> <y>
NB.   <v>  - monad/dyad to <description>, is called as:
NB.            <o>=. [<x>] <v> <y>
NB.   vapp - monad/dyad to <description>, is called as:
NB.            <o>=. [<x>] vapp <y>
NB.   <y>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.   <x>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.   <o>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.
NB. Formula: <optional section>
NB. - <description>:
NB.     <formula>
NB. ...
NB. - <description>:
NB.     <formula>
NB.
NB. Storage layout: <optional section>
NB.   <layout>
NB. where
NB.   <description>
NB.
NB. Algorithm: <optional section>
NB.   In: <input nouns; comma-separated list>
NB.   Out: <output nouns; comma-separated list>
NB.   1) <1st step description>
NB.   ...
NB.   x) <last step description>
NB.
NB. Assertions (with appropriate comparison tolerance): <optional section>
NB.   <assertion>
NB.   ...
NB.   <assertion>
NB. where
NB.   <copula>
NB.   ...
NB.   <copula>
NB.
NB. Examples: <optional section>
NB.    <command to execute>
NB. <output>
NB. ...
NB.    <command to execute>
NB. <output>
NB.
NB. Application: <optional section>
NB. - <description>
NB.     <command to execute>
NB. ...
NB. - <description>
NB.     <command to execute>
NB.
NB. Notes: <optional section>
NB. - <text>
NB. ...
NB. - <text>
NB.
NB. References: <optional section>
NB. [1] <reference>
NB. ...
NB. [x] <reference>
NB.
NB. TODO: <optional section>
NB. - <text>
NB. ...
NB. - <text>

<LocalConjunction>=: <definition>

NB. ---------------------------------------------------------
NB. <LocalVerb>
NB.
NB. Description:
NB.   <description>
NB.
NB. Syntax:
NB.   <o>=. [<x>] <LocalVerb> <y>
NB. where
NB.   <y>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.   <x>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.   <o>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.
NB. Formula: <optional section>
NB. - <description>:
NB.     <formula>
NB. ...
NB. - <description>:
NB.     <formula>
NB.
NB. Storage layout: <optional section>
NB.   <layout>
NB. where
NB.   <description>
NB.
NB. Algorithm: <optional section>
NB.   In: <input nouns; comma-separated list>
NB.   Out: <output nouns; comma-separated list>
NB.   1) <1st step description>
NB.   ...
NB.   x) <last step description>
NB.
NB. Assertions (with appropriate comparison tolerance): <optional section>
NB.   <assertion>
NB.   ...
NB.   <assertion>
NB. where
NB.   <copula>
NB.   ...
NB.   <copula>
NB.
NB. Examples: <optional section>
NB.    <command to execute>
NB. <output>
NB. ...
NB.    <command to execute>
NB. <output>
NB.
NB. Application: <optional section>
NB. - <description>
NB.     <command to execute>
NB. ...
NB. - <description>
NB.     <command to execute>
NB.
NB. Notes: <optional section>
NB. - <text>
NB. ...
NB. - <text>
NB.
NB. References: <optional section>
NB. [1] <reference>
NB. ...
NB. [x] <reference>
NB.
NB. TODO: <optional section>
NB. - <text>
NB. ...
NB. - <text>

<LocalVerb>=: <definition>

NB. =========================================================
NB. Interface

<isolated definitions, optional section>

<name>=: <definition>  NB. <individual description>
...
<name>=: <definition>  NB. <individual description>

<OR>

NB. <multi-line...
NB. ...individual description>
<name>=: <definition>

...

NB. <multi-line...
NB. ...individual description>
<name>=: <definition>

<OR>

NB. <common description>
<name>=: <definition>
...
<name>=: <definition>

<end of optional isolated definitions section>

NB. ---------------------------------------------------------
NB. <grouped definitions description, optional section>

<name>=: <definition>  NB. <individual description>
...
<name>=: <definition>  NB. <individual description>

<OR>

NB. <multi-line...
NB. ...individual description>
<name>=: <definition>

...

NB. <multi-line...
NB. ...individual description>
<name>=: <definition>

<OR>

NB. <common description>
<name>=: <definition>
...
<name>=: <definition>

NB. ---------------------------------------------------------
NB. <Adverb>
NB.
NB. Description: <optional section>
NB.   Adv. to make verb to <description>
NB.
NB. Syntax: <optional section>
NB.   vapp=. <u> <Adverb>
NB.   vapp=. <u0>`<u1>`... <Adverb>
NB. where
NB.   <u>  - monad/dyad to <description>, is called as:
NB.            <o>=. [<x>] <u> <y>
NB.   vapp - monad/dyad to <description>, is called as:
NB.            <o>=. [<x>] vapp <y>
NB.   <y>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.   <x>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.   <o>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.
NB. Formula: <optional section>
NB. - <description>:
NB.     <formula>
NB. ...
NB. - <description>:
NB.     <formula>
NB.
NB. Storage layout: <optional section>
NB.   <layout>
NB. where
NB.   <description>
NB.
NB. Algorithm: <optional section>
NB.   In: <input nouns; comma-separated list>
NB.   Out: <output nouns; comma-separated list>
NB.   1) <1st step description>
NB.   ...
NB.   x) <last step description>
NB.
NB. Assertions (with appropriate comparison tolerance): <optional section>
NB.   <assertion>
NB.   ...
NB.   <assertion>
NB. where
NB.   <copula>
NB.   ...
NB.   <copula>
NB.
NB. Examples: <optional section>
NB.    <command to execute>
NB. <output>
NB. ...
NB.    <command to execute>
NB. <output>
NB.
NB. Application: <optional section>
NB. - <description>
NB.     <command to execute>
NB. ...
NB. - <description>
NB.     <command to execute>
NB.
NB. Notes: <optional section>
NB. - <text>
NB. ...
NB. - <text>
NB.
NB. References: <optional section>
NB. [1] <reference>
NB. ...
NB. [x] <reference>
NB.
NB. TODO: <optional section>
NB. - <text>
NB. ...
NB. - <text>

<Adverb>=: <definition>

NB. ---------------------------------------------------------
NB. <Conjunction>
NB.
NB. Description: <optional section>
NB.   Conj. to make verb to <description>
NB.
NB. Syntax: <optional section>
NB.   vapp=. <u> <Conjunction> <v>
NB.   vapp=. <u0>`<u1>`... <Conjunction> <v0>`<v1>`...
NB. where
NB.   <u>  - monad/dyad to <description>, is called as:
NB.            <o>=. [<x>] <u> <y>
NB.   <v>  - monad/dyad to <description>, is called as:
NB.            <o>=. [<x>] <v> <y>
NB.   vapp - monad/dyad to <description>, is called as:
NB.            <o>=. [<x>] vapp <y>
NB.   <y>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.   <x>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.   <o>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.
NB. Formula: <optional section>
NB. - <description>:
NB.     <formula>
NB. ...
NB. - <description>:
NB.     <formula>
NB.
NB. Storage layout: <optional section>
NB.   <layout>
NB. where
NB.   <description>
NB.
NB. Algorithm: <optional section>
NB.   In: <input nouns; comma-separated list>
NB.   Out: <output nouns; comma-separated list>
NB.   1) <1st step description>
NB.   ...
NB.   x) <last step description>
NB.
NB. Assertions (with appropriate comparison tolerance): <optional section>
NB.   <assertion>
NB.   ...
NB.   <assertion>
NB. where
NB.   <copula>
NB.   ...
NB.   <copula>
NB.
NB. Examples: <optional section>
NB.    <command to execute>
NB. <output>
NB. ...
NB.    <command to execute>
NB. <output>
NB.
NB. Application: <optional section>
NB. - <description>
NB.     <command to execute>
NB. ...
NB. - <description>
NB.     <command to execute>
NB.
NB. Notes: <optional section>
NB. - <text>
NB. ...
NB. - <text>
NB.
NB. References: <optional section>
NB. [1] <reference>
NB. ...
NB. [x] <reference>
NB.
NB. TODO: <optional section>
NB. - <text>
NB. ...
NB. - <text>

<Conjunction>=: <definition>

NB. ---------------------------------------------------------
NB. <Verb>
NB.
NB. Description:
NB.   <description>
NB.
NB. Syntax:
NB.   <o>=. [<x>] <Verb> <y>
NB. where
NB.   <y>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.   <x>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.   <o>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.
NB. Formula: <optional section>
NB. - <description>:
NB.     <formula>
NB. ...
NB. - <description>:
NB.     <formula>
NB.
NB. Storage layout: <optional section>
NB.   <layout>
NB. where
NB.   <description>
NB.
NB. Algorithm: <optional section>
NB.   In: <input nouns; comma-separated list>
NB.   Out: <output nouns; comma-separated list>
NB.   1) <1st step description>
NB.   ...
NB.   x) <last step description>
NB.
NB. Assertions (with appropriate comparison tolerance): <optional section>
NB.   <assertion>
NB.   ...
NB.   <assertion>
NB. where
NB.   <copula>
NB.   ...
NB.   <copula>
NB.
NB. Examples: <optional section>
NB.    <command to execute>
NB. <output>
NB. ...
NB.    <command to execute>
NB. <output>
NB.
NB. Application: <optional section>
NB. - <description>
NB.     <command to execute>
NB. ...
NB. - <description>
NB.     <command to execute>
NB.
NB. Notes: <optional section>
NB. - <text>
NB. ...
NB. - <text>
NB.
NB. References: <optional section>
NB. [1] <reference>
NB. ...
NB. [x] <reference>
NB.
NB. TODO: <optional section>
NB. - <text>
NB. ...
NB. - <text>

<Verb>=: <definition>

NB. =========================================================
NB. Test suite

NB. ---------------------------------------------------------
NB. <testxxname>
NB.
NB. Description:
NB.   Test <description> by <matrix of type xx> given
NB.
NB. Syntax:
NB.   <testxxname> <y>
NB. where
NB.   <y>  - scalar/n-vector/m×n-matrix/sh-array <description>
NB.
NB. Formula: <optional section>
NB. - <description>:
NB.     <formula>
NB. ...
NB. - <description>:
NB.     <formula>
NB.
NB. Storage layout: <optional section>
NB.   <layout>
NB. where
NB.   <description>
NB.
NB. Algorithm: <optional section>
NB.   In: <input nouns; comma-separated list>
NB.   Out: <output nouns; comma-separated list>
NB.   1) <1st step description>
NB.   ...
NB.   x) <last step description>
NB.
NB. Assertions (with appropriate comparison tolerance): <optional section>
NB.   <assertion>
NB.   ...
NB.   <assertion>
NB. where
NB.   <copula>
NB.   ...
NB.   <copula>
NB.
NB. Examples: <optional section>
NB.    <command to execute>
NB. <output>
NB. ...
NB.    <command to execute>
NB. <output>
NB.
NB. Application: <optional section>
NB. - <description>
NB.     <command to execute>
NB. ...
NB. - <description>
NB.     <command to execute>
NB.
NB. Notes: <optional section>
NB. - <text>
NB. ...
NB. - <text>
NB.
NB. References: <optional section>
NB. [1] <reference>
NB. ...
NB. [x] <reference>
NB.
NB. TODO: <optional section>
NB. - <text>
NB. ...
NB. - <text>

<testxxname>=: <definition>

NB. ---------------------------------------------------------
NB. <testname>
NB.
NB. Description:
NB.   Adv. to make verb to test <names> by matrix of
NB.   generator and shape given
NB.
NB. Syntax:
NB.   vtest=. mkmat <testname>
NB. where
NB.   mkmat - monad to generate a matrix; is called as:
NB.             mat=. mkmat (m,n)
NB.   vtest - monad to test algorithms by matrix mat; is
NB.           called as:
NB.             vtest (m,n)
NB.   (m,n) - 2-vector of integers, the shape of matrix mat
NB.
NB. Formula: <optional section>
NB. - <description>:
NB.     <formula>
NB. ...
NB. - <description>:
NB.     <formula>
NB.
NB. Storage layout: <optional section>
NB.   <layout>
NB. where
NB.   <description>
NB.
NB. Algorithm: <optional section>
NB.   In: <input nouns; comma-separated list>
NB.   Out: <output nouns; comma-separated list>
NB.   1) <1st step description>
NB.   ...
NB.   x) <last step description>
NB.
NB. Assertions (with appropriate comparison tolerance): <optional section>
NB.   <assertion>
NB.   ...
NB.   <assertion>
NB. where
NB.   <copula>
NB.   ...
NB.   <copula>
NB.
NB. Examples: <optional section>
NB.    <command to execute>
NB. <output>
NB. ...
NB.    <command to execute>
NB. <output>
NB.
NB. Application: <optional section>
NB. - <description>
NB.     <command to execute>
NB. ...
NB. - <description>
NB.     <command to execute>
NB.
NB. Notes: <optional section>
NB. - <text>
NB. ...
NB. - <text>
NB.
NB. References: <optional section>
NB. [1] <reference>
NB. ...
NB. [x] <reference>
NB.
NB. TODO: <optional section>
NB. - <text>
NB. ...
NB. - <text>

<testname>=: 1 : 'EMPTY_mt_ [ <definition>'
