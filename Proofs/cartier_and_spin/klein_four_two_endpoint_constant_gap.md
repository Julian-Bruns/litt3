# Proof of the two-endpoint constant-character gap

Use every actual-map hypothesis in
[the statement](../../Theorems/cartier_and_spin/klein_four_two_endpoint_constant_gap.md).
The uniform theorem already gives c<=14 for a constant character.
Suppose c=14, normalize T=1, and let C be the monic polynomial of its
14 required zeros in mu29. The exact word identity is
\[
\epsilon K=\frac{t^{22}-F}{t^{29}-1},\qquad
F=2t^{22}+F_{\rm low},\quad\deg F_{\rm low}\le15,\quad C\mid F.
\tag{1}
\]
The endpoint denominator cannot vanish: the proved forced-label
implication B=0 would give a double zero of T. This applies at both ends.

## The actual opposite endpoint

Under s=1/t and swapping u,v, put epsilon'=epsilon^-1. Directly from
w=v-epsilon*t^4*u one obtains
\[
\epsilon'K'=-t^7-\epsilon t^{14}K.
\]
Consequently the normalized endpoint jets are
\[
r=F(0),\quad s=F'(0),\qquad
r_\infty=F_{15},\quad s_\infty=F_{14}. \tag{2}
\]
The letter s in the jet pair denotes the first derivative, separately
from the temporary reciprocal parameter used to derive(2).

Write Q=floor(t^22/C), alpha=C'(0)/C(0), gamma=C_13. Every word is
\[
F=2CQ+C(a+bt).
\]
The first jet determines a,b, and hence the whole word. In particular
\[
r_\infty=\frac{s-\alpha r}{C(0)}-2Q_1,\qquad
s_\infty=\frac r{C(0)}-2Q_0+\gamma r_\infty. \tag{3}
\]
This affine transformation is invertible over M. It preserves
span_M(1,r,s), but when that span has dimension three, the class of
r_infinity modulo M cannot be proportional to the class of r: its
s-coefficient is nonzero.

## A complete endpoint-plane rigidity certificate

The forced jets are those already derived from the actual endpoint
identities. With K0=F25[alpha]/(5+2alpha+6alpha^2+7alpha^3+alpha^4),
each branch label is alpha_j, B_j=b_j*zeta^e, with b_j in K0 and
zeta in M. Its derivative labels are C_j*B_j^4 and L_j*B_j^5.
The two fields have coprime degrees4,7. All jets therefore belong to
K0*M; no coefficient-field hypothesis on a curve is being made.

Enumerate all35 sorted four-multisets of the four alpha labels, all29^3
phase triples with first phase0, and all three Fourier characters.
Permuting branches permutes these characters up to sign. A common
phase scales r,s by elements of M and leaves their plane and the
distinguished direction unchanged. Thus this enumeration includes
every geometric plane/direction pair, including leading-label collisions.

In the basis 1,alpha,alpha^2,alpha^3 over M, a non-affine jet has plane
normal equal to the cross product of the three nonconstant coefficients
of r and s. Normalize this exact normal, sort by it, and compare the
projective first-coordinate directions inside every equal-normal group.
The exhaustive counts are
\[
\begin{array}{c|r}
\text{label-character cases}&2560845\\
\text{zero leading denominator}&1032\\
\text{affine jets}&585421\\
\text{non-affine jets}&1974392\\
\text{distinct non-affine planes}&687440\\
\text{planes with conflicting first-coordinate directions}&0.
\end{array}
\]
The implementation computes ratios up to M-scalars by a relative norm;
an independent checker instead solves multiplication systems over M
to divide by B directly. All218 deterministic direct plane/direction
checks pass. They check implementation, not exhaustive coverage; the
complete count and exact grouping are the separate C++ certificate.

The same enumeration confirms that all1116 affine jets with r outside M
have quadratic r and belong to the previously established3364-target
safe closure. Thus there is no missing quartic affine case.

Combining this rigidity with(3) excludes every non-affine jet.

## The affine and zero-ratio cases

Let J be the15 complementary roots of C and write e_k=e_k(J). Then
\[
\alpha=\sum_{a\in J}a^{-1},\quad\gamma=\sum_{a\in J}a,\quad
p=\prod_{a\in J}a=C(0)^{-1},\quad Q_0=e_8,\quad Q_1=-e_7.
\]
For a nonrational affine target write
\[
s=\lambda r+\nu,\qquad r^2=\tau r+\upsilon.
\]
Equation(3) gives r_infinity=k*r+l, where
\[
k=p(\lambda-\alpha),\qquad l=p\nu+2e_7.
\]
If k!=0 and the opposite target is (lambda',nu',tau',upsilon'),
the exact necessary equations are
\[
(\lambda'-\gamma)(\lambda-\alpha)=1,\qquad
\nu'=(\gamma-\lambda')l-2e_8,
\]
\[
\tau'=k\tau+2l,\qquad
\upsilon'=k^2\upsilon-k\tau l-l^2. \tag{4}
\]
If k=0, a nonzero rational r_infinity is impossible: the endpoint
field lemma would also make s_infinity rational, contrary to(3).
The only remaining possibility is l=0. This case is checked explicitly.

The complete subset calculation has40116600 normalized15-subsets and
191280 orbits under rotations and coefficient Frobenius. It tests
all3364 closed quadratic targets at each end, allowing extra coefficient
conjugates for a safe exclusion. The first equation in(4) has8859
matches; the second leaves3; none passes the trace equation. There
are2 cases k=0, and neither has l=0.

This also disposes of an initial r=0. The field lemma then gives
s outside M. Formula(3) makes r_infinity nonrational and its jet affine.
It must therefore be one of the quadratic targets, and reversing the
endpoints gives one of the k=l=0 cases just excluded. In particular,
an unclassified degree-four s at the initial zero ratio is not lost.

## Rational jets must use the same coefficient conjugate

For the fixed curve every rational jet is
\[
([22]\zeta^{-a},[8]\zeta^{3a}). \tag{5}
\]
In reducing subset orbits, Frobenius5 adds its F25 coefficient conjugate.
But this Frobenius acts on BOTH endpoints simultaneously. The two
endpoint targets must therefore have the same coefficient-conjugation
parity. They cannot be chosen independently from the enlarged set.

There are exactly3 matches if one deliberately ignores this parity:
\[
\begin{array}{c|c|c}
J\text{ bitmask}&\text{first target index}&\text{second target index}\\
29641599&1&57\\
29641719&1&57\\
36027279&21&37.
\end{array}
\]
Index29*f+a denotes coefficient conjugate f and phase a. Every row
has f=0 at one end and f=1 at the other. None is admissible.

For precision, rotating the C-roots by a in mu29 transforms the first
jet by (a^22,a^21) and the opposite jet by (a^7,a^8). These are allowed
phase changes in(5), with unchanged conjugation parity. Thus no actual
case is lost by the subset normalization.

The independent polynomial checker reconstructs64 arbitrary words
by division by C and checks(2),(3). It then checks all3 rational pairs,
all3 remaining affine pairs and both zero-ratio candidates directly.
All checks pass. This proves c<=13 whenever d=0.

## Degree consequence and evidence

There is a useful general interpolation consequence. Suppose the
constant character has c+u>=14, where u=29-e. Choose14-c of the
unused locations (c>14 has already been excluded), and let
\[
D=C\prod_{a\text{ chosen}}(t-a),\qquad\deg D=14.
\]
The actual constraints are F=0 at the C-roots and F(a)=a^22 at the
chosen unused locations. These are linear equations over M for the
low coefficients of F=2t^22+F_low. They have an M-valued solution F_0:
ordinary interpolation of degree<=13 supplies one. Every solution is
\[
F=F_0+D(a+bt).
\]
Thus its first jet determines a,b affinely over M, and the opposite
jet is an invertible affine function of the first. Its r_infinity
coefficient of s is1/D(0), still nonzero. The same plane-rigidity
argument excludes M-dimension three.

If r is outside M, the complete affine endpoint classification puts
r,s in the quadratic extension M2 of M inside K0*M. If r is nonzero
in M, the endpoint field lemma makes s belong to M as well. If r=0,
the opposite r_infinity is outside M and affine, so s also belongs
to M2. The first-jet reconstruction then puts every coefficient of
F in M2. These are restrictions on a normalized character word,
not a model-field bound for the original two-map curve. No further
enumeration is required for this consequence.

The preceding single-unused-pole theorem leaves only two scalar profiles
at degree88. Every listed character allocation contains d=0,c=14,
so all are excluded. Actual V4 degrees89..182 were already excluded;
the remaining range is14..87.

If g=48+j, all uniform slacks vanish and sum d_i=j-21. The new result
forces each d_i>=1, hence j>=24. For e=29, however,
n=12+a+3j_1+6j_2>=12+(29-j)+3j=41+2j. Since n<=87,
j<=23. The e<=28 case was already handled by the single-unused-pole
theorem. Thus g<=47+j throughout the remaining actual range.

Sources are `klein_four_two_endpoint_planes.py/.cpp`,
`klein_four_two_endpoint_constant.cpp`, the two corresponding
`check_*.py` files, and `klein_four_small_pencil_profiles.py` with
`--two-endpoints`, all in [scripts/arithmetic](../../scripts/arithmetic/).
The constructor regenerates the small field table. Compile each C++
source with C++17. Run the plane program with that DAT file, `all`,
an exception-output path, a sample-output path and the retained
`linear_pencil_targets.dat`. Run the constant program with the field
DAT and that target DAT. The target file is regenerated by
`klein_four_linear_pencil_targets.py` from the earlier complete target
constructor. Run both independent checkers with the evidence directory.

Exact logs, data and independent outcomes have prefix `two_endpoint_`
in [the retained evidence directory](../../../litt3-computation-data/overnight_three_replies_20260926/).
An uninitialized root-power array was fixed before either complete
enumeration; the final source explicitly zero-initializes it. No
bounded search over curves or unseen-field restriction is used.
