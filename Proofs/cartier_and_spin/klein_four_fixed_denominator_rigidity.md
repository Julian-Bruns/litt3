# Proof of fixed-denominator rigidity

Use the notation and actual-map hypotheses in
[the statement](../../Theorems/cartier_and_spin/klein_four_fixed_denominator_rigidity.md).
In particular T_j and T_k are units at a single-triple-pole value whose
inertia kernel is i. Let J2 be the reduced product of the double-triple
values, of degree j2, and U=(t^29-1)/E, of degree u.

## A homogeneous quadratic relation

For a difference h=(h_1,h_2,h_3) of two completions, the linear
conditions imply
\[
C_i\mid h_i,\quad U\mid h_i,\quad
(J_i^{(1)})^2\mid h_jT_k+h_kT_j.
\]
At a double-triple value every h_i is divisible by the square of
its local equation, because the difference of the corresponding B_i
is t^7h_i. Write h_i=Uv_i. Since U is a unit at all triple values,
the same triple-value conditions hold for the v_i.

Consider
\[
Q_T(v)=v_1v_2T_3+v_1v_3T_2+v_2v_3T_1.
\]
At a single-triple value of type i, group it as
v_i(v_jT_k+v_kT_j)+v_jv_kT_i. Its order is at least two.
At a double-triple value every v_i vanishes twice, giving order four.
Consequently
\[
J^2J2^2\mid Q_T(v),\qquad \deg Q_T(v)\le30+D-2u.
\]
The stated inequality g>57-2u-2j2 is exactly the strict inequality
between these divisor and polynomial degrees. It forces Q_T(v)=0.

The difference space is a k-vector space. Applying the same identity
to sums and using characteristic five shows that its generic span
is totally isotropic for Q_T over k(t). This quadratic form is
nondegenerate of rank three, since every T_i is nonzero and2 is
invertible. A totally isotropic subspace has dimension at most one.
Thus all homogeneous differences have a common projective direction.

If a difference had only coordinate i nonzero, the derivative condition
at every single value in C_i would make that coordinate vanish twice;
the other odd T is a unit there. Double values give the same conclusion.
It would follow that UC_i^2 divides h_i, contrary to
2c_i+u>15+d_i. A vector with exactly two nonzero coordinates cannot be
isotropic for Q_T. This excludes the coordinate-axis exceptions.

## A rational conic controls the remaining dimension

The linear divisibility conditions define a k[t]-submodule of k[t]^3.
Its intersection with the generic rank-one span just found is free of
rank one; choose its generator h*. The bounded difference space is
exactly
\[
\{p(t)h^*:p\in k[t],\ \deg p\le r\},\qquad
r=\min_i(15+d_i-\deg h_i^*).
\]
Indeed a nonzero bounded vector is a polynomial multiple of h*, so
h* itself satisfies the bounds, and the coordinate inequalities are
precisely the displayed bound on p.

Write h_i^*=Uv_i and set X_i=v_iT_jT_k. These polynomials have degrees
at most H-r, and
\[
X_1X_2+X_1X_3+X_2X_3=0.
\]
They give a map to the smooth conic defined by this equation. Remove
their polynomial gcd of degree b. If the induced map to the conic
has degree m, its primitive projective coordinates have degree2m;
therefore b+2m<=H-r. This also covers a constant map with m=0.

At a triple value of type i, either all coordinates vanish or the
projective value is the i-th coordinate vertex. At most b of the j
distinct values can be common zeros. The three vertices on the conic
have altogether3m inverse images counted with multiplicity. Thus
j-b<=3m, and hence
\[
b+2m\ge\lceil2j/3\rceil.
\]
It follows that r<=H-ceil(2j/3), proving the dimension bound.

For the coefficient-field assertion assume j>H. Every triple value is
in M, and whether it is a common zero of the three X_i is unchanged by
coefficient conjugation over M. The conic map and any such conjugate
therefore agree at at least j-b>H-b>=2m distinct arguments. Identify
the conic with P1 over M. Two maps of degree m to P1 agreeing at more
than2m points are equal, by cross multiplication of their numerator
and denominator polynomials. Thus the map is fixed by every coefficient
conjugation over M and is defined over M. Its projective coordinates
are precisely the ratios (h_i/T_i), up to their common factor.
No field of definition for the T_i or the original curve follows.

## The two actual endpoint jets force uniqueness

Consider two completions with the same T_i and forced endpoint labels.
At zero, if T_i(0)!=0, equality of the prescribed value and derivative
of F_i/T_i makes h_i vanish twice. If T_i(0)=0, the accepted paired-label
and first-jet results already make both F_i and T_i vanish twice for
each actual completion. Again h_i vanishes twice.

At infinity use the opposite normalized quotient t^-15*f_i/T_i.
If the prescribed leading coefficient of T_i is nonzero, equality of
its first two jets makes deg h_i<=13+d_i. If it is zero, the same
actual paired-label rule on the opposite endpoint makes those top two
coefficients vanish separately for each completion. Thus in every case
\[
t^2\mid h_i,\qquad \deg h_i\le13+d_i.
\]
After also dividing by U, the X_i in the preceding argument have a
common factor t^2 and degrees at most H-2. These two endpoint savings
leave at most H-4 for the finite triple-value incidence argument.
A nonzero difference would therefore require
H-4>=ceil(2j/3), contrary to the hypothesis. This proves uniqueness,
including the vanishing-leading-value boundaries.

## Integer scope and checks

The existing complete necessary-profile enumeration with `--characters`
retains eight scalar profiles and109 character allocations at n87.
For each of them the quadratic relation and axis exclusions hold,
j>H, and H-ceil(2j/3) is at most three. The same checks hold for580
of729 retained n86 allocations; the other149 have this last difference
equal to four. This is a reconstruction statement for the specified
linear conditions, not a claim that any allocation is geometrically
realizable.

The short checker
[check_klein_four_completion_profiles.py](../../scripts/arithmetic/check_klein_four_completion_profiles.py)
reads the retained complete necessary-profile output, checks all these
integer inequalities, and records its input hash. Its result is
`fixed_denominator_profiles.json` in
[the evidence directory](../../../litt3-computation-data/overnight_three_replies_20260926/).
The proof of the homogeneous conic and endpoint uniqueness is algebraic;
no additional finite-field search is used.
