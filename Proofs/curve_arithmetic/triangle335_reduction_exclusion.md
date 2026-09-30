# Proof: a totally ramified field of source models

[Combined atlas theorem](../../Theorems/curve_arithmetic/backup_characteristic_zero_atlases.md).
This is local continuation, with exact rational polynomial elimination
and a separate field-identity check. The certificate is not a numerical
recognition of approximate roots.

## The actual hyperelliptic quotient

Let $f:C\to\mathbf P^1$ have complete profile $(3,3,5)$, degree
fifteen, with the index-three values at zero and one. Composing with
$4z(1-z)$ gives an ACTUAL degree-thirty map of profile $(2,3,10)$.
It retains the degree-fifteen intermediate map $f$.

The [complete degree-thirty census](../../../litt3-computation-data/uniform_triangle_continuation_20260921/analysis.json)
has twenty classes. Three have an elliptic intermediate quotient,
six have a nonhyperelliptic deck involution, and four have a larger
deck group. Specialization embeds $\operatorname{Aut}(C)$ in $C_2$
and $\operatorname{End}^0J(C)$ in the quartic CM field of
[the backup](../../Theorems/curve_arithmetic/backup_curve_arithmetic.md).
Thus $\operatorname{Aut}(C)=C_2$ and $J(C)$ is simple, excluding
all thirteen classes just described.
Two further classes have no nontrivial intermediate map at all, so
cannot be the composite just constructed. The remaining five have
their hyperelliptic involution as deck involution, with fixed-point
counts $(5,0,1)$ above the indices $(2,3,10)$.

The degree-thirty map consequently descends through the ACTUAL
hyperelliptic quotient to a degree-fifteen rational map $q(x)$.
Relabel its target so its three partitions are
\[
3^5,\qquad 1^5 2^5,\qquad (5,10).
\]
Its unique pole at a Weierstrass point has order five. Put that point
at infinity, and put the other pole, of order ten, at zero. Then
\[
q(x)=\frac{B(x)^3}{c x^{10}},\qquad
B=x^5+b_4x^4+b_3x^3+b_2x^2+b_1x+b_0,\quad b_0c\ne0.
\]
Here $B$ has been made monic; this only changes $c$. The other five
critical points, all over the index-two value, are the roots of
\[
A=3xB'-10B.
\]
They are distinct for the specified passport, so the following is a
necessary polynomial identity for EVERY candidate:
\[
A^2\mid B^3-cx^{10}.
\tag{1}
\]
The five simple preimages of the index-two value and infinity are
exactly the hyperelliptic branch points. Thus, up to a geometric
quadratic twist, a source model is
\[
y^2=F(x),\qquad F=(B^3-cx^{10})/A^2.
\tag{2}
\]

Only coordinate scalings remain. If $b_4\ne0$, scale to $b_4=1$.
If $b_4=0$, scale to $b_0=1$. These TWO charts cover all candidates;
no nondegenerate root is discarded by a convenient normalization.

## Exact necessary equations

The [equation generator](../../scripts/orbifolds/triangle335_square_factor_models.py)
forms every coefficient of the remainder in (1), clears rational
denominators, and adds $v b_0c-1=0$. In the boundary chart it sets
$b_4=0,b_0=1$ and adds $vc-1=0$ instead.

Exact rational Groebner elimination gives:

| Chart | Quotient length | Elimination form |
|---|---:|---|
|$b_4=1$|5|A quintic in $v$, and five linear expressions for $b_0,b_1,b_2,b_3,c$ in $v$|
|$b_4=0,b_0=1$|1|$b_1=b_2=b_3=0,\ c=27/4,\ v=4/27$|

The full [equations and elimination coefficients](../../../litt3-computation-data/triangle335_square_models_20260921/)
are retained externally. The [verification source](../../scripts/orbifolds/verify_triangle335_field.py)
reconstructs and compares the exact reduced Groebner bases of the
original equations and the elimination presentations. It also
checks the following independent field substitution and all original
equations at the resulting universal field-valued point.

For $a^5+5a^3-5a^2+2=0$, the old parameter is
\[
\begin{aligned}
v={}&-\frac{9398098319100927734375}{16599265906765726789632}a^4
+\frac{2618115071365673828125}{16599265906765726789632}a^3\\
&-\frac{1461950258083642578125}{614787626176508399616}a^2
+\frac{35317573887190478515625}{8299632953382863394816}a
+\frac{30181833237649287109375}{16599265906765726789632}.
\end{aligned}
\tag{3}
\]
Substituting (3) in the old quintic gives exactly zero. The new
quintic is irreducible by the Eisenstein calculation below, and (3)
is nonrational, so it generates the same degree-five field. The
linear elimination expressions therefore put all coefficients of
each open-chart source (2) in one conjugate of $L$.

The boundary gives $F=(x^5+1/4)/25$, hence a source over $\mathbf Q$.
It has extra automorphisms, but the residue argument already excludes
it without using that additional fact. The negative conclusion only
requires that the equations be NECESSARY and exhaustively eliminated;
it does not infer that every solution has the desired passport.

## Residue degree rather than reduction of a map

Writing $f(a)=a^5+5a^3-5a^2+2$, one has
\[
f(z-2)=z^5-10z^4+45z^3-115z^2+160z-90.
\]
This is five-Eisenstein. Thus $L$ has a unique place over five,
with ramification index five and residue degree one. Every conjugate
field and every possible selected place have the same property.

Apply the [moduli residue theorem](../../Theorems/curve_arithmetic/moduli_residue_obstruction.md)
to the source model (2). Even if obtaining good reduction requires
an extension, the smooth geometric reduction has moduli orbit
dividing the ORIGINAL field's residue degree, hence one. A geometric
twist cannot change that moduli point. Since the established orbit
of $Y$ has length three, none of these sources can reduce to $Y$.

The [executed verification log](../../../litt3-computation-data/triangle335_square_models_20260921/verification.txt)
records exact ideal equality, the field embedding, the original
equation substitutions, both chart lengths, and the Eisenstein test.
