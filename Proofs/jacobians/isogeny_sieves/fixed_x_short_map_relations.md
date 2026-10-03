# Proof: retain the entire three-graph triangle

We prove a general graph bound, then specialize its short-relation
consequences to the fixed X. The older
[independent audit](../../../Research/audits/SHORT_ACTUAL_MAP_RELATIONS_INDEPENDENT_2026_09_22.md)
covers the fixed-X trace normalization, positivity and five-field
arguments. The new rank deductions use tensor Gram matrices.

## 1. The general graph and independence bound

Use the notation of the statement. The rational quotient gives
1+zeta+zeta²=0, so E=Q(zeta3). Rosati sends zeta to zeta² and,
on the number field K, is complex conjugation. In particular K
is CM. By [Milne, Section12, Proposition12.12](https://www.jmilne.org/math/xnotes/AVs.pdf#page=24),
H1(A,Q_ell) has rank s=2g/[K:Q]=g/a over K tensor Q_ell,
and its trace on b in K is s*Tr_(K/Q)(b).

Write u_i=(h_i)_*, v_i=h_i^*, and H_ij=s*Tr_(K/E)(u_i v_j).
Norm-pullback gives H_ii=gd; adjunction gives H_ji=conjugate(H_ij).
For i!=j, let Gamma_ij be their reduced joint image in X times X,
and let c be the degree from T to its normalization. Its
bidegrees are d/c. Distinct embedded fields make Gamma_ij
different from each graph of gamma^e.

The bilinear Kunneth intersection formula gives
\[
0\le\Gamma_{ij}\cdot\operatorname{Graph}(\gamma^e)
=\frac{2d-\operatorname{Tr}(\zeta^e u_i v_j\mid H^1(A))}{c}
=\frac{2d-2\operatorname{Re}(\zeta^eH_{ij})}{c},
\tag{5}
\]
up to reindexing e. This is the general correspondence calculation
in [Rosati factorization, Section1](etale_rosati_factorization.md#1-normalize-the-same-source-image).
Only that bilinear intersection identity is used here; neither
map is assumed etale. The formula and its inequality require only
that the joint image differ from the three graphs; distinct fields
are a sufficient condition. The positive cycle factor c is retained,
including a singular joint image. Distinct effective divisors
on a smooth surface have nonnegative intersection.

Hence the three rotations satisfy Re(zeta^e H_ij)<=d. Their
half-planes form the triangle with vertices -2d zeta^e,
whose radius is2d. For R of the maps and coefficients c_i in C,
\[
\overline c^{\,t}Hc
\ge\bigl(g-2(R-1)\bigr)d\sum_i|c_i|^2.
\tag{6}
\]
This follows by bounding each off-diagonal modulus by2d and
using 2 sum_(i<j)|c_i||c_j|<=(R-1)sum|c_i|².
If R<=ceil(g/2), the lower bound is positive for c!=0.
An E-linear relation among the norms gives zero squared Rosati
norm, hence zero traced quadratic form. Thus all its coefficients
vanish. Rational denominators can be cleared; no identity is
reduced modulo the ground-field characteristic.

## 2. Fixed-X short relations and coincident fields

Now specialize to the fixed genus-nine X. Its established
[endomorphism field](etale_endomorphism_packets.md) has [K:E]=9,
so s=1, and Aut(X)=<gamma>. For actual etale maps,
d=(g(T)-1)/8. Section1 proves independence through five distinct
fields.

Equal embedded X-fields mean that the corresponding maps differ
by one of the three actual automorphisms of X. Their norms therefore
differ by powers of zeta, which belong to E. Grouping terms by fields
in a relation supported on at most five fields, independence makes each
field's grouped coefficient vanish separately.

In particular, if THREE maps satisfy
\[
a_1u_1+a_2u_2+a_3u_3=0,\qquad a_i\ne0,
\qquad a_i/a_1\in E,
\tag{8}
\]
then all three embedded fields coincide. Cancel the common nonzero
K-scalar a_1 first. If there were two fields, one field would have
only one term and its nonzero coefficient could not vanish; three
fields are excluded by independence. This includes arbitrary nonzero integer
coefficients and any common CM multiple of E-coefficients.

An integral Rosati-unit coefficient satisfies a^dagger a=1. Its
CM conjugates all have absolute value one, so integrality makes it
a root of unity. By K intersect Q^ab=E, these units are precisely
the six elements +/-zeta^e. Thus these unitary coefficients are
covered. An arbitrary integral CM unit need not be Rosati-unitary
and is not thereby covered.

## 3. The literal three-point addition map

Choose the point O at infinity, fixed by gamma, and let
j_X:X->A be P|->[P-O]. A literal norm identity
\[
u_1+u_2+u_3=0
\tag{9}
\]
means that j_X h_1+j_X h_2+j_X h_3 is constant, by the universal
property of J(T). This is CONSTANCY of the actual morphism, not
vanishing of its differential.

Thus D_t=h_1(t)+h_2(t)+h_3(t) moves in a fixed complete linear
system of degree three. The divisors are not constant, since each
h_i is nonconstant. The low-degree pencil result for X says that
every rational function of degree at most six belongs to k(x).
A moving degree-three divisor is therefore a complete fiber of
the unique trigonal pencil. Consequently xh_1=xh_2=xh_3, and the
three generic points of the fiber are distinct. Connectedness of
T then gives, after permuting the maps,
\[
\boxed{(h_1,h_2,h_3)=(h,\gamma h,\gamma^2h).}
\tag{10}
\]
Conversely this triple satisfies (9), since the cubic fiber is
linearly equivalent to 3O. This proof is the arbitrary-three-map
form of the existing low-degree divisor mechanism; it does not
require the three maps to have started as a deck orbit.

For integer coefficients n_i!=0, (8) first puts all three maps in
one field. The equation 1+zeta+zeta^2=0 then gives a complete
classification: either all three maps are IDENTICAL and
n_1+n_2+n_3=0, or they are the three distinct cubic conjugates
and their coefficients are all equal. Exactly two distinct maps
cannot give such a three-term relation with every coefficient
nonzero. In particular u_1+u_2-u_3=0 is impossible.

## 4. A stronger rank bound from the cubic tensor

Return to the general setup, and let m be the multiplicity of A
in J(T). The K-space Hom^0(A,J(T)) has dimension m, and its
E-dimension is am. Its Hermitian form
Q(v,w)=s*Tr_(K/E)(v^dagger w) is positive definite at either
embedding of E. Indeed
\[
Q(v,v)=\tfrac12\operatorname{Tr}(v^\dagger v\mid H^1(A))>0
\quad(v\ne0)
\]
by [Rosati positivity](https://www.jmilne.org/math/xnotes/AVs.pdf),
Theorem17.3, applied on A times J(T). Density of E in C gives
positive semidefiniteness after extension. A singular matrix
over E would have a nonzero E-kernel, contradicting strict
positivity. Therefore H is a positive semidefinite Gram matrix
of rank r<=am.

Normalize G=H/(gd), so G_ii=1 and |G_ij|<=2/g. Cauchy--Schwarz
on its nonzero eigenvalues gives r>=N²/tr(G²). The radius bound
gives tr(G²)<=N+(4/g²)N(N-1), proving the first part of(2).

For any off-diagonal entry z=H_ij/d, retain all three half-planes:
\[
0\le\prod_{e=0}^2(1-\operatorname{Re}(\zeta^e z))
=1-\tfrac34|z|^2-\tfrac14\operatorname{Re}(z^3).
\]
Equivalently 3g²|G_ij|²+g³Re(G_ij³)<=4. The entrywise cube
G^(circle3) is the Gram matrix of the third tensor powers of
vectors realizing G; hence it is positive semidefinite and
sum_(i,j)Re(G_ij³)>=0. Summing the displayed inequality off
the diagonal, whose contribution is g²(g+3)N, gives
\[
3g^2\operatorname{tr}(G^2)
\le4N^2+\bigl(g^2(g+3)-4\bigr)N.
\]
Combine with r>=N²/tr(G²) to prove the second bound in(2).
For g=a=9, that bound exceeds18 exactly when N>17424/171,
so the new integer threshold is102.

## 5. Tensor powers force growing multiplicity

For each k>=1, the entrywise power G^(circle k) is the Gram
matrix of the k-th tensor powers. They lie in Sym^k(C^r), of
dimension B_k=binom(r+k-1,k). Its diagonal is one and its
off-diagonal squared moduli are at most(4/g²)^k. The same
trace-square estimate gives
\[
B_k\ge\operatorname{rank}G^{\circ k}
\ge\frac{N}{1+(N-1)(4/g^2)^k},
\]
which is(3). Whenever B_k(4/g²)^k<1, rearranging yields
N<=B_k(1-(4/g²)^k)/(1-B_k(4/g²)^k).

Take k=r. Then B_r=binom(2r-1,r)<=4^r/2 and, since g>4,
B_r(4/g²)^r<1/2. Thus N<2B_r<=4^r<=4^(am),
proving(4). This is an unbounded multiplicity conclusion
conditional on an unbounded supplied family of distinct fields.

All arguments concern maps from the SAME actual curve T.
They do not prove that a field orbit is unbounded, construct
a simultaneous Galois closure, or replace either actual etale
leg of the original common-cover problem.
