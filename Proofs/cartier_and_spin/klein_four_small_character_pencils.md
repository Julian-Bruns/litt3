# Proof of the small-character pencil restrictions

Use the [statement](../../Theorems/cartier_and_spin/klein_four_small_character_pencils.md)
and the preceding strict Hermite theorem. All maps and embedded
character components remain those of the actual V4 source.

## Polynomial and endpoint conventions

Write M=F_(25^7), K0=F_(25^4), with the exact coefficient convention,
alpha roots, canonical labels b_alpha and first jets of the preceding
proofs. Put r_i=A_i/B_i and s_i=(a_i B_i-A_i c_i)/B_i^2 whenever B_i!=0.
They are the value and derivative at0 of epsilon*K_i, where
\[
\epsilon K_i
=\frac{t^{22}T_i-F_i}{(t^{29}-1)T_i},
\quad F_i\in S_{d_i},\quad C_i\mid F_i. \tag{1}
\]
If d_i<=1 then B_i is nonzero. Indeed, write the signed sum at each
alpha root as X_alpha in M. The b_alpha basis shows that B_i=0 implies
all X_alpha=0. The next coefficient c_i of the branch series is then
also zero, since it is a sum of constants times X_alpha^5. Thus T_i
would be divisible by t^2, impossible for a nonzero polynomial of
degree at most1. This notation c_i for a local coefficient is used
only in the preceding sentence; elsewhere c_i=deg C_i as usual.

When deg C=15+2d for d=0 or1, the MDS theorem says that the polynomials
in S_d divisible by C form a two-dimensional space over M. The map
F -> (T(0),F(0)) on that space is invertible. For d=0 this follows
from the explicit formula below. For d=1 a kernel vector would have
T divisible by t and F(0)=0, so F/t would belong to S_0 and vanish at
17 cyclotomic nodes, contradicting its MDS bound of16 zeros.
Consequently r=F(0)/T(0) determines the projective polynomial over M(r).
If r belongs to M then s also belongs to M. The coefficient-field lemma
therefore gives at most one such character; it has four distinct alpha
labels, a common leading root-of-unity phase and, after normalization,
\[
(r,s)=([22],[8]). \tag{2}
\]
In particular, A_i=0 is impossible for either kind of pencil.

For d=0, polynomial dependence gives s linear in r over M. For d=1,
the invertibility just proved gives s quadratic in r over M. These
are necessary conditions, not sufficient formal or global realizations.

## Complete forced-label reduction, including collisions

Use the eleven alpha patterns listed by the source constructor, covering
the five multiplicity partitions4,3+1,2+2,2+1+1,1+1+1+1. Root Frobenius
and branch permutations give these representatives. Normalize one common
leading phase and enumerate29^3 exponent triples per pattern. No repeated
leading label is discarded: distinct formal branches may have the same
leading label.

In K0*M use the M-Frobenius sigma, acting by25^3 on K0 and fixing the
29th roots. The Moore determinants of the columns
\[
(B_i^2,A_i B_i,a_i B_i-A_i c_i),\qquad
(B_i^2,A_i B_i,A_i^2,a_i B_i-A_i c_i)
\]
test respectively s linear and s quadratic in r. This is ordinary
finite-field Moore rank, after clearing the nonzero denominator B_i^2.

The complete268279-label calculation retains19610 coincident-leading
tuples. The zero-B counts for0,1,2,3 vanishing characters are
(268107,0,171,1). After A_i!=0, the linear relation s=lambda*r+nu
has373 normalized label-character cases. They yield one rational target
(2) and142 nonrational targets. Every latter r has degree two over M,
with a checked equation
\[
r^2=\tau r+\upsilon. \tag{3}
\]
There are exactly two additional quadratic-only characters: alpha
patterns (0,0,1,2) and (0,0,2,3), all leading phases zero, character0.
Each has only one eligible quadratic character. Thus if two characters
are pencils of type(1,17), every eligible one satisfies the linear
relation and belongs to the preceding142-plus-one list. The full
joint-label check has143 possible pairs and zero pairs involving a
quadratic-only character. The zero-B counts also handle a potentially
vanishing third character.

The construction and complete evaluator are
[near_word_jets.py](../../scripts/arithmetic/klein_four_near_word_jets.py) and
[near_word_jets.cpp](../../scripts/arithmetic/klein_four_near_word_jets.cpp).
The target extractor solves the coefficient-field linear equations directly:
[constant_pencil_targets.py](../../scripts/arithmetic/klein_four_constant_pencil_targets.py).
An independent Gaussian-rank implementation checks462 specified direct
field cases, including collisions. These checks support, but do not
replace, the complete268279-label enumeration.

## Constant pencils

The strict bound already gives c<=15 when d=0. Suppose c=15 and
normalize T=1. If Q is the polynomial part of t^22/C, every word is
\[
F=2C(Q+a),\qquad a\in k.
\]
Let J be the14 complementary29th roots. Then
\[
\lambda_C=C'(0)/C(0)=\sum_{z\in J}z^{-1},\qquad
\nu_C=2C(0)Q'(0)=-2\Bigl(\prod_{z\in J}z\Bigr)^{-1}e_6(J),
\quad s=\lambda_C r+\nu_C. \tag{4}
\]
For a nonrational r the coefficients lambda,nu of its linear jet relation
are unique. Split the29 nodes into14 and15, enumerate every subset of
each half, and match the sum in(4) for each of the142 targets, retaining
only total size14. There are45 sum matches; none matches nu. All45 are
independently rechecked by direct multiplication of C and division of
t^22 by C. This excludes every nonrational target.

For the rational target(2), rotations of J and Frobenius5 are permitted
on the necessary subset equations provided the target is transformed
as well. Common leading phase zeta^k changes (r,s) to
([22]zeta^-k,[8]zeta^(3k)); Frobenius5 adds its coefficient conjugate.
The exhaustive subset test checks all58 transformed targets on each
orbit representative. It covers37442160 normalized subsets with191280
representatives. Exactly one first-endpoint orbit remains:
\[
J=\{0,1,2,4,5,6,8,9,11,14,18,22,23,24\}
\]
in exponent notation, with phase1 and no coefficient conjugation.
The parameter a is determined by F(0)=[22]zeta^-1. Direct reconstruction
gives F'(0)=[8]zeta^3 as required.

At infinity swap the actual endpoints and use t'=1/t, epsilon'=epsilon^-1.
Equation(1) gives
\[
r_\infty=F_{15},\qquad s_\infty=F_{14}.
\]
Both belong to M. The coefficient-field lemma would require
r_infinity in[22]*mu29, hence r_infinity^29=[6]. The reconstructed
word instead has r_infinity=[6]zeta and r_infinity^29=[22]. This excludes
the last orbit, including all its rotations and Frobenius transforms.
Thus d=0 implies c<=14.

Source: [nonrational subset matcher](../../scripts/arithmetic/klein_four_constant_pencil_subsets.cpp),
[rational subset evaluator](../../scripts/arithmetic/klein_four_constant_pencil_rational.cpp),
and [independent verifier](../../scripts/arithmetic/check_klein_four_constant_pencils.py).

## Two linear pencils cannot coexist

Suppose two characters have (d,c)=(1,17). By the first section and the
joint-label check, at least one is a nonrational target from(3), with
s=lambda*r+nu. Let J now have12 roots and write h_k=(-1)^k e_k(J).
Since C has degree17, division gives
\[
T=1+zt,\quad F=2C\left\lfloor t^{22}T/C\right\rfloor,
\quad r=2C(0)(h_5+h_6z).
\]
Here h_6!=0 by the invertibility argument after(1). With
alpha_C=C'(0)/C(0), elementary differentiation yields
\[
s=-\frac{r^2}{m}+\frac{b}{m}r+\frac{c}{m},
\quad m=2C(0)h_6,
\quad b=m\alpha_C+4C(0)h_5,
\quad c=4C(0)^2(h_4h_6-h_5^2).
\]
Using(3), the two necessary equations are
\[
\lambda m+\tau=b,\qquad\nu m+\upsilon=c. \tag{5}
\]
No such subset exists. To avoid assuming that coefficient Frobenius
preserves an unknown curve, take the explicit over-approximation of
the142 targets closed under all coefficient Frobenius and common phases.
It has3364 targets. On every cyclotomic subset orbit the first equation
in(5) already fails for every target. The full count is21474180 normalized
subsets,128037 representatives, zero h_6 zeros and zero first-equation
matches. Thus the two linear pencils cannot coexist.

Source: [target closure](../../scripts/arithmetic/klein_four_linear_pencil_targets.py),
[complete subset evaluator](../../scripts/arithmetic/klein_four_linear_pencil_subsets.cpp),
and [independent polynomial verifier](../../scripts/arithmetic/check_klein_four_linear_pencils.py).
The latter performs48 direct quotient-polynomial calculations over the
quadratic algebra(3), verifies the low/high coefficient gap and checks
(5) against the actual evaluated first jet. It also verifies all recorded
coverage counts and the degree89 allocation elimination.

## Genus and degree consequence

If g=49+j, then sum d_i=j-22 and the three nonnegative slacks
15+2d_i-c_i sum to1. Two characters are therefore on the one-step
boundary c_i=15+2d_i. Neither can have d_i=0, and they cannot both
have d_i=1. Hence sum d_i>=3, forcing j>=25. This proves g<=48+j
when j<=24.

The prior complete grid-profile certificate leaves only
(g,s,a,j1,j2,e)=(73,5,5,24,0,29) at degree89. It violates the new
g<=48+j bound. Equivalently, the constant-pencil bound eliminates
three of the four prior character allocations and the linear-pair
bound eliminates the remaining (c;d)=((17,17,14);(1,1,0)).

All generated inputs, complete logs, word coefficients, bounded independent
checks and source hashes are retained under
[overnight_three_replies_20260926](../../../litt3-computation-data/overnight_three_replies_20260926/),
with prefixes near_word_jets, constant_pencil and linear_pencil. Compile
the C++ sources with C++17; the target DAT files are generated by the
named Python constructors. Run both independent checkers with that
external directory as their sole argument. All listed checks passed.
An exploratory distinct-leading-label restriction was removed before
the accepted complete run; all19610 collisions are included in this proof.
