# Proof of the single-unused-pole small-character exclusion

Retain the notation and actual-map assumptions of
[the statement](../../Theorems/cartier_and_spin/klein_four_single_unused_pole.md).
The [unused-pole identity](klein_four_unused_pole_constraints.md) says
\[
F(a)=a^{22}T(a)\qquad(a\in\mu_{29}\setminus\operatorname{Supp}E).
\tag{1}
\]
By the uniform bound only c=14,d=0 and c=16,d=1 need exclusion.
Fix one unused a. All coefficient calculations below take place over
M=F_(25^7); unknown actual curve coefficients remain unrestricted.
For d<=1, the forced-label implication B_i=0 implies T_i has a double
zero at0, which is impossible. Thus normalize T(0)=1 throughout.

## Constant character

Let C be the monic product of the14 required zeros and Q=floor(t^22/C).
Every word with T=1 is
\[
F=2CQ+C(b_0+b_1t).
\]
Equation(1) cuts out an affine pencil. Set C_+=(t-a)C and let J_+
be its14 complementary roots in mu_29. For its first jet (r,s) one gets
\[
s=\lambda r+\nu,
\quad\lambda=\sum_{z\in J_+}z^{-1},
\quad\nu=\nu_++C_+(0)a^{21}J_+(a), \tag{2}
\]
where nu_+=2C_+(0)*(floor(t^22/C_+))'(0) is the old constant-pencil
intercept. Here J_+(a) means evaluation of the monic root polynomial.
For example, compare the word with prescribed r to the old word vanishing
at a. Their difference is a^21*C(t)*t/C(a), so the derivative changes
by a^21*C(0)/C(a). Since C(a)=29a^28/J_+(a) and
C_+(0)=-aC(0), characteristic five gives exactly the last term in(2).

The previous complete endpoint calculation gives142 nonrational affine
jet targets. Its complete additive subset matching found45 possible
pairs (target,J_+) having the required lambda. For each pair retain all15
choices a outside J_+. None of these675 exact intercepts equals the
target intercept. Thus no nonrational first ratio occurs.

If r belongs to M, (2) makes s belong to M; the field lemma forces
the jet ([22],[8]) up to common phase and coefficient Frobenius.
Checking all58 transformed targets on every marked subset orbit gives
37442160 normalized subsets,191280 unmarked orbits,2869200 marked-node
tests and zero matches. Every unused location is retained, not just a
representative location within a subset.

The exact sources are
[mixed_constant_nonrational.py](../../scripts/arithmetic/klein_four_mixed_constant_nonrational.py)
and [mixed_constant_rational.cpp](../../scripts/arithmetic/klein_four_mixed_constant_rational.cpp).
Consequently c=14,d=0 is impossible.

## Linear character: an explicit mixed pencil

Now c=16,d=1 and let J be the13 complementary roots. Put
\[
h_k=(-1)^k e_k(J),\quad \alpha=C'(0)/C(0),\quad
Q_0=\lfloor t^{22}/C\rfloor,\quad Q_1=tQ_0+h_7.
\]
For the basis T_0=1,T_1=t, (1) gives words
\[
F_0=C(2Q_0+b_0),\qquad F_1=C(2Q_1+b_1),
\quad b_0=a^{22}/C(a)-2Q_0(a),\quad b_1=ab_0-2h_7.
\]
Define their endpoint coefficients
\[
B_0=C(0)(2h_6+b_0),\quad\Delta=B_1=C(0)ab_0,
\]
\[
D_0=\alpha B_0+2C(0)h_5,\quad
D_1=\alpha\Delta+2C(0)h_6.
\]
If Delta!=0, the first jet satisfies
\[
s=\frac{-r^2+(D_1+B_0)r+D_0\Delta-D_1B_0}{\Delta}. \tag{3}
\]
No unknown scalar has been specialized: solving r=B_0+Delta*z for
the coefficient z of T=1+zt proves(3).

The same complete forced-label list used in the uniform pencil theorem
applies. Its safe closure has3364 quadratic-extension targets,116
quartic-extension targets and58 rational targets. The complete mixed
test has30421755 normalized subsets,167367 unmarked orbits and2175771
marked-node tests. It has no match of any type. For the quadratic
targets the first coefficient equation has two matches, both rejected
by the second equation. The separate rational run also has zero matches.
The two run modes explicitly label the inactive counters.

For efficient exact evaluation, no inverse C(a) need be computed:
\[
b_0=\sum_{j=0}^{12}
\bigl(j+2\mathbf1_{j\ge7}\bigr)h_j a^{6-j}. \tag{4}
\]
This follows from C(a)=29a^28/J'(a) and differentiation of the
degree13 polynomial J. Exponents in(4) are reduced modulo29.

## All31 degenerate pencils are excluded

There are31 marked orbits with Delta=0. Here b_0=0 and the first
ratio of every T=1+zt word is the fixed M-value
\[
r=B_0=2C(0)h_6.
\]
These are precisely the31 degree-zero minimum-word exceptions already
retained in the unused-pole calculation. Direct reconstruction checks
that each displayed B_0 is nonzero and B_0^29 is not in F25.

For a nonzero forced ratio r in M, the established normal-basis
argument alone, without any assumption on s, forces four distinct
alpha labels, a common leading phase, and r in [22]*mu_29. Its29th
power must belong to F25. Thus every degenerate pencil is impossible.
The nonzero-ratio check matters: r=0 by itself would not force s into M.

The source is
[mixed_linear_pencil.cpp](../../scripts/arithmetic/klein_four_mixed_linear_pencil.cpp),
compiled normally for nonrational targets and with
KLEIN_FOUR_MIXED_RATIONAL for rational targets.
[The independent verifier](../../scripts/arithmetic/check_klein_four_mixed_pencils.py)
constructs48 marked pencils by direct polynomial division, verifies
their actual mixed value, and checks all coefficients of(2),(3),(4).
It also reconstructs every degenerate ratio and verifies its norm
escape, and checks both complete enumeration totals. All checks passed.

## Genus and degree consequence

If g=48+j, all three uniform character slacks are zero and all c_i
are even. The two exclusions just proved force d_i>=2 for every i.
But sum d_i=27+2j-g=j-21, so j>=27. This proves g<=47+j
whenever e<=28 and j<=26. The previous actual degree bound n<=88
gives j<=25, so this covers every remaining e<=28 case.

Applying the existing exact grid relaxation with the improved bound
leaves only the two degree88 profiles in the statement. Their three
allocations follow from c_i=14+2d_i and sum d_i=j-21. These
computations impose necessary scalar conditions only. No field,
polynomial or cover realization is inferred from a surviving profile.

Evidence with prefixes mixed_constant, mixed_linear and mixed_pencils
is retained in
[the external evidence directory](../../../litt3-computation-data/overnight_three_replies_20260926/).
The sources regenerate the small evidence and stream their concise logs;
no growing symbolic intermediate or finite-field search for curves is used.
