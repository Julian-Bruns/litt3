# A pole-semigroup test shared by the two degree140 families

[Statement](../../Theorems/cartier_and_spin/degree140_regular_root_scale_bound.md).
The constant-family construction and its exact leading coefficients
are proved in Sections67--68 of the received
[primitive report](../../../litt3-computation-data/september29_replies/primitive140_continuation_record/primitive140/REPORT.md).
Here its geometric mechanism is retained and transferred to the
root-nine Newton edge. No previous large calculation is replayed.

## Regular roots and triangular projection

Work on q*z^3=P(x), without adjoining a cube root of q. At O take
\[
x=qT^{-3},\qquad z=q^3T^{-10}Y(T),\qquad
Y^3=q^{-10}T^{30}P(qT^{-3}),\quad Y(0)=1.
\]
The monic series Y exists uniquely since3 is invertible. Its terms
have indices divisible by three. For a regular function e_mu with
pole140, put A(T,mu)=q^{-46}T^140*e_mu and ell=A(0,mu), a unit
independent of scale in these two families.

Any geometric rational square root has no affine poles and lies in
L(70O). The monomial basis of that space is x^i*z^j with
0<=j<=2 and3i+10j<=70. After multiplication by T70 and unit scalar
rescaling, its monic series basis is
\[
T^nY^j,\qquad n=70-3i-10j.
\]
There are62 such indices. The omitted indices in0..70 are
53,56,59,62,63,65,66,68,69. Starting at index zero, subtract each
pivot coefficient times its monic basis series. At each omitted
index retain the resulting coefficient, denoted G_n.

After adjoining a square root of ell and normalizing its sign, the
unique square root of A/ell agrees with (A/ell)^63 modulo T125,
because126=1+125 in characteristic5. Thus applying the preceding
linear projection to A^63 through order74 gives thirteen necessary
equations: the nine gaps and indices71,72,73,74. This works over
coefficient rings with nilpotents for the stated regular-root
incidence, since all pivots and2 are units. No sufficiency of these
thirteen equations alone is asserted.

## The constant family's gap59

The exact source has
A=A0+mu*B+mu^2*D with orders0,4,11 and leading coefficients
ell,gamma1,gamma2 all units. In A^63=A^3*(A^2)^5*(A^2)^25,
the unique contribution of scale degree14 at T59 is the product of
the degree4 term of A^3, the degree10 term of (A^2)^5, and the
constant term of (A^2)^25. Hence
\[
[mu^{14}]G_{59}=3\ell^{50}\gamma_1^{12}\gamma_2.
\]
Every earlier T-coefficient has scale degree at most13, so triangular
projection does not alter this coefficient. This is a unit on the
entire original constant-family chart, giving a monic degree14 equation.

## The root-nine family's gap56

The accepted [two-branch Newton edge](degree140_root9_six_scale_curves.md)
has the form
\[
A(T,mu)=\ell(1+a\,mu T^4)(1+b\,mu T^4)
 +\text{terms of strictly positive excess},
\]
where excess means T-degree minus four times scale degree. Both a
and b are units, and (a/b)^3=(sigma0/s)^3 in the ratio notation of
that theorem. Therefore every coefficient at T^n has scale degree
at most floor(n/4). At T56, its degree14 coefficient is the binary
binomial coefficient
\[
[mu^{14}]G_{56}
=3\ell^{63}ab(a-b)^2(a^2-ab+b^2)^5.
\]
Indeed this is the coefficient of Z14 in
(1+aZ)^63(1+bZ)^63 in characteristic5. It follows either by Lucas
decomposition or direct expansion of the two finite binomial rows.
All preceding T-coefficients have degree at most13, so projection
again leaves the leading coefficient unchanged.

Its possible nonunit factors imply(a/b)^6=1, equivalently
s^6=sigma0^6. All six such curves are already excluded by the
full-source all-scale certificates. On their complement the displayed
coefficient is a unit; division produces a monic degree14 equation.
This is a necessary identity in the normalized regular-root scheme,
not merely a statement about its reduced support.

## Length and scope

At a fixed geometric ratio the scale algebra is a quotient of the
rank14 algebra defined by this monic equation. Its length is at most14;
localizing at nonzero scale cannot increase that length. The two
possible signs form a finite étale degree-two choice, giving28 for
the unsigned root incidence. This imposes no such bound on the
whole norm-square deformation functor.

The transferred root-nine projection is implemented in the
[compact function-field code](../../scripts/arithmetic/root9_curve_square_gaps_20260929.hpp).
Focused controls used three genuine regular squares with all three
cubic characters, then a nonsquare perturbation. They passed and are
retained in the [new evidence directory](../../../litt3-computation-data/conceptual_continuation_20260929/root9_endpoint_content/gap_controls/).
The leading-coefficient proof above is symbolic and independent of
those sample controls.
