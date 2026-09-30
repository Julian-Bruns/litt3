# Proof: volume denominators exclude bad local factors

[Statement](../../Theorems/curve_arithmetic/six_cone_local_level_filter.md).
The unique torsion-free index-two subgroup has genus two. Its
square subgroup has index sixteen and genus seventeen and lies
in a maximal-order norm-one group. The resulting volume and
discriminant bounds give
\[
n=[F:\mathbf Q]\le10,
\quad n=9\Longrightarrow d_F<15143226271.
\tag{1}
\]
These apply to every arithmetic genus-two surface group, as shown
in [Ackermann, Satz3.1--3.2, printed pages19--20](https://eldorado.tu-dortmund.de/bitstreams/0ba5e0b5-d911-4497-9bd5-867639433fc9/download).
In particular the residue degree in the statement is $f=3,6$, or $9$.

## The denominator implication

For an odd prime $\ell$ and integer $a\ge1$,
\[
v_\ell(\zeta_F(-1))\le-a
\quad\Longrightarrow\quad
\mathbf Q(\zeta_{\ell^a})^+\subset F.
\tag{2}
\]
Here is an unconditional integrality proof. Deligne--Ribet's
twisted-value integrality, in the formulation of
[Ribet, Theorem2.1 and assertion A](https://www.numdam.org/item/AST_1979__61__177_0.pdf),
gives
\[
(1-\chi_\ell(c)^2)\zeta_F(-1)\in\mathbf Z_\ell
\quad(c\in\operatorname{Gal}(F^{\rm ab}/F)),
\]
where $\chi_\ell$ is the cyclotomic character. Apply it to the
constant function one, conductor one, and weight two. The hypothesis
in (2) forces every cyclotomic image modulo $\ell^a$ to have square
one. Since $\ell$ is odd, that image lies in $\{1,-1\}$.
Its fixed subfield contains the maximal real cyclotomic field,
proving (2). No conjectural special-value formula is needed.

## The exact volume constraint

The positive normalizer of the square-free Eichler order has
norm-one subgroup of index $2^a$ for some $a$. Reduced norm modulo
squares embeds their quotient in an exponent-two group. Locally,
a norm-one normalizer of a split Eichler edge cannot exchange its
vertices, so the kernel is the norm-one unit subgroup itself.
The normalizer description is
[Long--Maclachlan--Reid, Theorem3.1 and Lemma4.2](https://web.math.ucsb.edu/~long/pubpdf/genus0_final.pdf).

The Shimizu volume formula, including the Eichler factors, is
\[
1=2^{2-n-a}|\zeta_F(-1)|
\prod_{w\in\operatorname{Ram}_f B}(Nw-1)
\prod_{w\mid\mathfrak n}(Nw+1).
\tag{3}
\]
The left side is the area divided by $2\pi$ for the six-cone
signature. The normalization agrees, for example, with the
[norm-one volume formula](https://docs.magma-maths.org/ModularArithmeticGeometry/ArithmeticFuchsianGroupsAndShimuraCurves/ArithmeticFuchsianGroups.html).
Thus every odd prime factor in either product, with its full
multiplicity, must be canceled by the denominator of $\zeta_F(-1)$.

If $B$ ramifies at the selected $v$, then $31\mid5^f-1$ for
each $f=3,6,9$. Equations (2)--(3) force
$\mathbf Q(\zeta_{31})^+\subset F$, impossible since its degree
is fifteen. Therefore $B_v$ splits.

Suppose instead that $v\mid\mathfrak n$. For $f=6$, the factor
$5^6+1$ is divisible by the prime $601$; (2) forces degree at
least $300$. For $f=9$, the prime $5167\mid5^9+1$ forces degree
at least $2583$. These both contradict (1).

For $f=3$, one has $5^3+1=126=2\cdot3^2\cdot7$. Thus $F$
contains both $\mathbf Q(\zeta_9)^+$ and $\mathbf Q(\zeta_7)^+$.
They are distinct cyclic cubic fields, with coprime discriminants
$81$ and $49$. Their compositum has degree nine and discriminant
\[
81^3\,49^3=62523502209.
\]
Since its degree divides $n\le10$, it would equal $F$. Its
discriminant contradicts (1). This eliminates the final level case.

The small integer and number-field checks are reproduced by
[the local-factor script](../../scripts/orbifolds/six_cone_local_factors.py).
Its [executed output](../../../litt3-computation-data/six_cone_arithmetic_20260921/local_factors.json)
checks each prime factor and the compositum discriminant.
The argument retains the selected place throughout; it asserts
nothing about other quaternion or level primes.
