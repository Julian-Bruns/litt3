# Proof: graph intersections bound short actual-map relations

[Statement](../../../Theorems/jacobians/isogeny_sieves/fixed_x_short_map_relations.md).
The new argument passed an
[independent audit](../../../Research/audits/SHORT_ACTUAL_MAP_RELATIONS_INDEPENDENT_2026_09_22.md).
Both original common-cover problems remain open.

There is a new short-relation constraint: norms from up to FIVE
distinct embedded X-fields are linearly independent over
E=Q(zeta3). In particular, a relation with three nonzero coefficients
whose ratios belong to E forces all three fields to coincide.
This uses intersections with the three actual automorphism graphs,
not only disjointness of the pulled-back one-form spaces.

For a literal sum of three Abel--Jacobi maps, the unique trigonal
pencil gives the exact answer: the three maps form one cubic orbit.
Arbitrary CM-weighted sums, and a relation involving just one form
from each nine-space, are different questions and remain outside
this conclusion.

## Inputs and inventory

Work over k=bar(F5). Let X be the fixed genus-nine cyclic trigonal
curve, A=J(X), and gamma its cubic deck automorphism. Let zeta be
the induced automorphism gamma_* of A. The established inputs are
\[
\operatorname{End}^0(A)=K,\qquad [K:\mathbf Q]=18,\qquad
E=\mathbf Q(\zeta)\subset K,\qquad [K:E]=9,
\quad1+\zeta+\zeta^2=0.
\tag{1}
\]
Rosati on K is complex conjugation, and Aut(X)=<gamma>.
The [endomorphism-packet theorem](../../../Theorems/jacobians/isogeny_sieves/etale_endomorphism_packets.md)
also gives K intersect Q^ab=E.

The moving degree-three divisor argument already occurs in
[degree-five trace descent](../../../Proofs/quotient_geometry/degree_five_trace_descent.md)
for the degree-three norm case. The three graph intersections occur
in [cubic packet rigidity](../../../Proofs/quotient_geometry/cubic_packet_map_rigidity.md)
for a cyclic orbit. Here the latter calculation is applied to an
arbitrary same-source family, and then traced only from K to E.
No deck orbit or common finite Galois source is needed for the
short-relation theorem.

## 1. A bound from actual graph intersections

Let h_1,...,h_N:T->X be actual finite etale maps from the SAME smooth
proper connected curve. They all have the same degree
d=(g(T)-1)/8. Assume their embedded fields F_i=h_i^*k(X) are pairwise
distinct. Write
\[
u_i=(h_i)_*:J(T)\to A,\qquad v_i=h_i^*=u_i^\dagger,
\quad b_{ij}=u_iv_j\in K,
\quad H_{ij}=\operatorname{Tr}_{K/E}(b_{ij})\in E.
\tag{2}
\]
Then
\[
H_{ii}=9d,\qquad H_{ji}=\overline{H_{ij}},\qquad
|H_{ij}|\le2d\quad(i\ne j),
\tag{3}
\]
where either complex embedding of E can be used for the modulus.

To verify the normalization, let Gamma_ij be the reduced joint image
of (h_i,h_j) in X x X, and c the degree from T to its normalization.
The two bidegrees of Gamma_ij are d/c. It is distinct from every
graph of gamma^e, since F_i and F_j are distinct. The three
intersection numbers, as e ranges through 0,1,2, are
\[
\frac{2d-\operatorname{Tr}_{K/\mathbf Q}
                    (\zeta^e b_{ij})}{c}\ge0.
\tag{4}
\]
Reversing the correspondence convention just permutes the three
values. This is the bilinear graph formula in the cited proof.
The factor c remains in the denominator; it is positive and does
not change the upper bound 2d. Thus normalization degree greater
than one is allowed.

The H1 trace is Tr_(K/Q), with no additional multiplicity: H1(A)
has rank one over K. Since E is imaginary quadratic, (4) says
\[
\operatorname{Re}(\zeta^e H_{ij})\le d\qquad(e=0,1,2).
\tag{5}
\]
For any complex number z, one of its rotations by these three
cube roots has real part at least |z|/2. Hence (5) gives exactly
|H_ij|<=2d. Equivalently its three half-planes bound the triangle
with vertices -2d,-2d zeta,-2d zeta^2. This proves (3).

## 2. Independence through five distinct fields

For any r of the maps and any c_1,...,c_r in C, (3) gives
\[
\begin{aligned}
\overline c^{\,t}Hc
&\ge9d\sum_i|c_i|^2-4d\sum_{i<j}|c_i||c_j|\\
&\ge\bigl(9-2(r-1)\bigr)d\sum_i|c_i|^2.
\end{aligned}
\tag{6}
\]
Here 2 sum_(i<j)|c_i||c_j| <= (r-1) sum_i|c_i|^2.
For r<=5 the lower bound is strictly positive unless c=0.

Suppose sum_i a_i u_i=0 with a_i in E. Taking adjoints gives
sum_i v_i conjugate(a_i)=0. Its squared Rosati norm, traced from
K to E, is c^*Hc=0 with c_i=conjugate(a_i). Equation (6) forces
every a_i=0. All identities are in rational Hom groups; denominators
can be cleared before invoking them. None is reduced modulo five.

We have proved
\[
\boxed{r\le5,\quad F_1,\ldots,F_r\text{ distinct}
\quad\Longrightarrow\quad
u_1,\ldots,u_r\text{ are E-linearly independent}.}
\tag{7}
\]

Equal embedded X-fields mean that the corresponding maps differ
by one of the three actual automorphisms of X. Their norms therefore
differ by powers of zeta, which belong to E. Grouping terms by fields
in a relation supported on at most five fields, (7) makes each
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
fields are excluded by (7). This includes arbitrary nonzero integer
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

## 4. A bounded multiplicity consequence

Let m be the geometric multiplicity of A in J(T). The K-space
Hom^0(A,J(T)) has dimension m. Restrict scalars to E and use the
Hermitian form Tr_(K/E)(v^dagger w). It has E-dimension 9m. For a nonzero v its diagonal is rational,
being fixed by conjugation on E, and equals
\[
\operatorname{Tr}_{K/E}(v^\dagger v)
=\tfrac12\operatorname{Tr}_{K/\mathbf Q}(v^\dagger v)>0.
\]
Apply Rosati positivity on the polarized product A times J(T);
see [Milne, Theorem17.3](https://www.jmilne.org/math/xnotes/AVs.pdf).
In an E-basis, density of E in C makes the Hermitian matrix
positive semidefinite at either embedding. A singular matrix over
E would have a nonzero E-kernel, contradicting the strict positivity
just proved. Thus it is positive definite at the chosen embedding. Thus H is a positive semidefinite
Gram matrix and rank_E H<=9m.

Its nonzero eigenvalues and (3) give
\[
\operatorname{rank}_E H
\ \ge\ \frac{(\operatorname{tr}H)^2}{\operatorname{tr}(H^2)}
\ \ge\ \frac{81N}{4N+77},\qquad
\operatorname{rank}_E H\le9m.
\tag{11}
\]
Indeed tr H=9dN and tr(H^2)<=d^2 N(4N+77). Hence N>154 forces
m>=3. This holds for any such actual same-source family, without
a Galois hypothesis. The lower bound tends to 81/4; it does NOT
give unbounded multiplicity or a growing-rank solution.

Focused verification: checked the normalization factor c, the full
H1 versus relative field traces, the triangle radius 2d, the
five-vector lower bound, the rank threshold 154, and the distinction
between homomorphism identities and differentials. The
[independent audit](../../../Research/audits/SHORT_ACTUAL_MAP_RELATIONS_INDEPENDENT_2026_09_22.md)
checks all these points, including positivity at the chosen E-embedding.
