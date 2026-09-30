# Proof: the explicit degree-one bundle and its étale sections

The input is the first returned flag request, integrated with a
focused author review. The sandbox ZIP mentioned in that reply was
not attached. The inline data were independently reconstructed by
[this source](../../scripts/arithmetic/check_flag_reply_algebra.py);
the [receipt](../../../litt3-computation-data/flag_replies_20260923/inline_reconstruction.json)
records the actual executed checks. No execution of the unavailable
package is claimed.

Write F25=F5[a]/(a^2-a-3), [n0+5n1]=n0+n1*a. Ascending codes give
\[
X:y^3=P(x),\quad P=(11,22,18,5,19,20,15,16,9,22,1).
\]
The actual bundle is
\[
0\to O(-5O)\to K\to O(6O)\to0,\qquad
e=y^2\sum_{m=1}^{10}[c_m]x^{-m},
\quad c=(2,16,16,7,1,2,7,1,24,11).
\]
Use the two standard affine charts pulled back from P1_x. The
stability of K is the established generated-hyperplane calculation.

## The positive Frobenius presentation

Let b0 have ascending codes
\[
(13,12,9,11,19,18,1,17,23,12,8,10,9,13,8,
0,9,10,4,23,24,24,2,2,12,0,19,14,1,24,
8,5,6,7,17,18,18,21,8,11,13,5,20,14,1).
\]
Put C25=sum[c_m]x^(25(10-m)) and divide
P^17*C25*b0=x^250*a0+r. Exact arithmetic gives degrees
(a0,r,b0)=(189,205,44) and gcd(a0,b0)=gcd(a0,P)=1.
Since e^25=y^2*P^16*C25/x^250, the coordinates
\[
(a_U,b_U)=(a0,yb0),\qquad (a_V,b_V)=(-r/x^{250},yb0)
\]
define a section of F^2*K(-8O). The extension lines there are
O(-133O), O(142O). At infinity the coordinate orders are135,-142,
so the second component is a unit in its line-bundle frame.
The two gcd identities rule out every finite common zero.
The section is nowhere zero, giving the asserted sequence.

Pull this sequence back by h. A quotient F_C^{2*}Q either receives
a nonzero map from h^*O(8O), or factors as a line quotient of
h^*O(17O), which is then an isomorphism. This proves the uniform
positive bound. Alternatively ampleness follows immediately because
F^2*K is an extension of two positive-degree lines and ampleness
descends under finite surjective pullback.

## All degree-zero twists

The connecting map for K(O) has source1,x,x^2 and seven rows
([c_{i+j}]), i=1,...,7, j=0,1,2. Its first minor is[19], so
H0(K(O))=0.

The cubic automorphism gamma linearizes K because e is a character
vector. Suppose a saturated degree-zero line L has three distinct
conjugate isomorphism classes L0,L1,L2. Their wedges have degree-one
divisors P,gamma P,gamma^2P. With consistent cyclic labels,
Li*L_(i+1)=O(O-gamma^i P). The orbit sum is linearly equivalent
to3O, so L0^2=O(2gamma P-2O). Write
L0=O(gamma P-O)*tau with tau^2=O. The first wedge identity implies
gamma*tau=tau. The norm1+gamma+gamma^2 vanishes on Pic^0 because
the quotient is P1; thus tau^3=O and tau=O. The resulting section
of L0(O) contradicts H0(K(O))=0.

It remains to exclude invariant classes. An invariant line can be
linearized, and Hilbert90 supplies an invariant rational section.
Its invariant divisor reduces to branch-point differences because
nonfixed orbits are fibers of x. With R_i=(r_i,0), all such classes
are represented by
\[
D_s=\sum s_i(R_i-O),\quad s_i=0,1,2,\quad s_{10}=0.
\]
The relations3(R_i-O)=0 and sum(R_i-O)=0 give these19683
representatives; distinctness is not needed for exhaustiveness.

Put A_s=prod_(s_i=1)(x-r_i), B_s=prod_(s_i=2)(x-r_i),
S=deg A_s+2deg B_s, D_j=(1,B_s,A_sB_s). The character-j
basis of H0(O(dO+D_s)) is
\[
y^jx^i/D_j,\quad
0\le i\le\left\lfloor(d-S-10j+3\deg D_j)/3\right\rfloor.
\]
The H1 basis has exponents strictly between this upper bound and0.
Writing e=y^2*x^-10*C(x), multiplication shifts j to j+2 modulo3
with polynomial factors A_sB_s, P/B_s, P/A_s. These explicitly
describe all connecting matrices for source d=6 and target d=-5.
The separate Sage reconstruction verifies P splits in F_(5^8),
the stated relative quartic is irreducible over F25, and every map
is injective. Source dimensions0,1,2,3 occur14490,4917,275,1 times.

Any map from a degree-zero line saturates to a line of nonnegative
degree. Stability of K forces degree zero. This completes all-twist
vanishing, including noninvariant and nonrational twists.

## What an étale section would mean

Pass to a connected Galois étale cover pi:S->X. Its full section
evaluation image I is G-equivariant and locally free; descent gives
E subset K with pi^*E=I. It is globally generated upstairs, hence
deg E>=0. Rank one would give a nonnegative saturated line in K,
contrary to stability and all-twist vanishing. Thus a nonzero
section forces rank two. Since deg K=1, deg E is0 or1.

For deg E=0, the globally generated degree-zero bundle pi^*E is
trivial: two generically independent sections have a nonzero
determinant section of degree zero. K/E has length one. On a
trivializing cover, a constant vector outside the finitely many
kernel lines of O^2->pi^*K is nowhere zero.
For deg E=1 the two locally free sheaves are equal. A general
section of a globally generated rank-two bundle on a proper curve
has no zero, by the incidence dimension count.

An abelian G acts on a nonzero section space with a common eigenline
over k, without a semisimplicity assumption. Equivariant descent of
that line gives a map from a finite-character degree-zero line to K,
which is impossible. This includes five-divisible abelian groups.

Adjoin all cubic conjugates of S over P1. The resulting cover is
still étale over X. If its evaluation image is not K, it is cubic
equivariant of degree zero, so its length-one quotient is supported
at O or one of the ten fixed branch points. There are exactly two
eigenquotients at each. Their characters are distinct: in compatible
affine splitting coordinates one may use weights1,zeta^2; at
infinity the O(-5O),O(6O) frames give distinct weights zeta,zeta^2.
Changing the lift of the linearization scales both weights and
does not change the two eigenlines.

Each kernel E_(P,ell) is stable of degree zero: any line of
nonnegative degree would also saturate to a forbidden line in K.
Its étale trivializability is equivalent over bar(F5) to an actual
isomorphism F^{r*}E=E for some r>0. This is the finite-field
Frobenius-periodicity criterion; see
[Langer, §7.2](https://arxiv.org/html/1301.4450v2).
An eventual cycle reached after a nontrivial Frobenius prefix
does not establish this for the original E.

On a particular cover the two image alternatives remain distinct.
The subsequent [finite-coefficient reduction](../../Theorems/cartier_and_spin/finite_coefficient_generation.md)
shows, using the six nonperiodicity exclusions and arithmetic
conjugation, that any nonzero etale section implies generation on
another cover. Neither existence nor nonexistence is proved, and
no second curve map is produced.
