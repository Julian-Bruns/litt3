# Proof: the split pullback of a determinant hypersurface

[Statement](../../Theorems/projective_connections/genus_two_determinant_cuts.md).
The genus-two theta isomorphism, its two-torsion equivariance and
\(j^*\mathcal O_S(1)=\mathcal O_A(2\Theta)\) hold in odd
characteristic; see [Ducrohet, Proposition 2.1](https://aif.centre-mersenne.org/item/10.5802/aif.2473.pdf).
The theta-characteristic twist changes determinant zero to
\(\omega_C\). The following argument concerns the Kummer quartic
in S, not the quartic in the dual projective coordinate space.

## Determinant line and nonzero section

Since \(\chi(V\otimes E)=0\), determinant of cohomology gives a
section whose vanishing is exactly nonzero cohomology. It descends
from the moduli stack to S: at a polystable V, each stable summand W
has slope one and \(\chi(W\otimes E)=0\). Its scalar automorphisms
therefore act with weight zero on the determinant line. Repeated
summands give the same zero exponent for the general linear
automorphism group. This is the usual determinant-line descent;
no universal bundle on the coarse space is presumed. The construction
and additivity are reviewed in [Popa, Section 3](https://arxiv.org/pdf/0712.3192).

In the K-group of the smooth curve,
\[
[E]=(r-1)[\mathcal O_C]+[\det E].
\]
Every degree-zero line test on S has line \(\mathcal O_S(1)\),
so the determinant line is \(\mathcal O_S(r)\). This is an
identity of lines; it does not split the section for a nonsplit E.

For a decomposable V, the actual complex is a direct sum. Hence
its determinant section pulls back under j to the product of the
sections defining \(B_E\) and \([-1]^*B_E\). Choosing N outside
their proper union proves both that \(Q_E\ne0\) and that its
restriction to K is nonzero. The product identity gives (1) as an
equality of Cartier divisors, with multiplicities. The theta class
calculation gives \([B_E]=r[\Theta]\) numerically.

If E were not semistable, a positive-degree subbundle F would have
\(\chi(\vartheta F\otimes N)=\deg F>0\) for every N, contradicting
properness. In rank two the converse needed here follows from the
genus-two theta isomorphism: choose a square root \(\eta^2=\det E\).
Then \(\vartheta E\eta^{-1}\) is semistable with determinant
\(\omega_C\), so its proper theta divisor translates to \(B_E\).

## The unavoidable singularity

The two effective divisors in (1) have intersection number
\[
B_E\cdot[-1]^*B_E=2r^2>0.
\]
Their supports meet. At a common point the equation of their sum
is the product of two elements of the maximal ideal of the smooth
surface A, and hence lies in its square. Their sum is not smooth;
this includes shared components and nonreduced cases.

The Kummer cut is a complete-intersection curve because the
restriction of \(Q_E\) is nonzero. If it contains a node of K, it
is singular: the quartic gradient vanishes there, so the Jacobian
of the two equations has rank at most one. If the cut were smooth,
it would therefore avoid the nodes. The finite quotient j is étale
off those nodes, making its pullback smooth, a contradiction.

For the transverse refinement, the two smooth divisors meet in
\(2r^2\) distinct points. None is in \(A[2]\), because inversion
acts by minus the identity on tangent spaces there and would make
their tangent lines coincide. Inversion pairs these intersection
points freely, and the quotient is étale nearby. The union descends
to precisely \(r^2\) ordinary nodes and is smooth elsewhere.

## A square when the rank-two determinant is trivial

Suppose \(r=2\) and \(\det E=\mathcal O_C\). Then
\(E^*\simeq E\), and relative Serre duality identifies the
determinant theta divisor \(B_E\) with \([-1]^*B_E\), including
multiplicities. It belongs to \(|2\Theta|\): the bundle
\(\vartheta E\) has determinant \(\omega_C\).

The pullback of linear forms under j is the complete four-dimensional
space \(H^0(A,2\Theta)\). Thus \(B_E=j^*H\) for a hyperplane H
in S, and (1) gives \(j^*\operatorname{div}(Q_E)=2j^*H\).
The corresponding sections are proportional on A. Hence
\(Q_E-cH^2\) vanishes on K for some nonzero c. Its degree is two,
less than the irreducible quartic degree of K, so it is zero as a
polynomial. This proves the square assertion without a Pfaffian
construction or a characteristic-zero duality theorem.

## The sign for fixed two-torsion determinant and double covers

First consider all semistable rank-two E with determinant
\(\kappa\in A[2]\setminus\{0\}\). The canonical rank-two
duality gives \(E^\vee\simeq E\otimes\kappa\). For every
canonical-determinant V, Serre duality identifies
\[
R\Gamma(C,V\otimes E^\vee)
\simeq R\Gamma(C,V\otimes E)^\vee[-1],
\]
The two actual determinant sections therefore have the same
zero divisor, including multiplicities. Tensoring V by \(\kappa\)
therefore preserves \([Q_E]\) projectively.

Choose a square root \(\eta^2=\kappa\). Twisting by \(\eta\)
identifies \(SU_C(2,\mathcal O_C)\) with \(SU_C(2,\kappa)\),
so this parameter space is connected. Determinant of cohomology
gives a morphism from it to the projective space of quadrics. For
clarity, it descends across strictly semistable points: determinant
sections multiply in a short exact sequence, and hence depend only
on the associated graded bundle. A polystable summand of E has
degree zero, so its automorphisms act with zero determinant weight
against V. There is no base point, by rank-two theta properness.

The fixed projective quadrics form the disjoint union of the
projectivizations of the c and -c eigenspaces for substitution by
\(M^{\mathsf T}\). At \(E=\mathcal O_C\oplus\kappa\) the
quadric is \(\ell_0\ell_\kappa\). The two linear factors are
interchanged with scalar product c. Thus the entire connected
fixed-determinant family lies in the c eigenspace.

Now consider the double-cover family, whose determinant may vary.

For \(E_L=\pi_*L\), the identity
\(\pi^*E_L=L\oplus\sigma^*L\) proves semistability and degree zero,
and \(E_L\otimes\kappa\simeq E_L\). The Poincaré family and its
determinant section give an everywhere-defined morphism
\[
J(D)\longrightarrow\mathbf P H^0(S,\mathcal O_S(2)),
\qquad L\longmapsto[Q_{E_L}].
\]
Indeed, the line on \(S\times J(D)\) is \(\mathcal O_S(2)\)
tensored with a line from the second factor, and no fiber section
is zero. Its image is projectively fixed under substitution by
\(M^{\mathsf T}\). On quadrics that substitution squares to
\(c^2I\); the fixed locus consists of the disjoint projectivizations
of the c and -c eigenspaces. Connectedness selects one of them.

At the trivial line the quadric is \(\ell_0\ell_\kappa\), since
\(E_0=\mathcal O_C\oplus\kappa\). If x is a coordinate vector
for zero in the dual Kummer space, choose Mx for \(\kappa\).
Substitution interchanges the two linear forms with scalars one
and c. Their product has eigenvalue c, proving (2). Rescaling M
changes both sides consistently. This proves the simultaneous-test
criterion by the singular-cut conclusion.

## The symmetric three-argument determinant

Choose an odd theta characteristic, and put \(W_a=V_a\vartheta^{-1}\).
The actual family \(\vartheta W_a\otimes W_b\otimes M\)
has determinant section on \(S\times S\times A\) with line
\[
\mathcal O_S(2)\boxtimes\mathcal O_S(2)
 \boxtimes\mathcal O_A(4\Theta).
\]
The first two degrees follow from the rank-two calculation. At
\(a=b=j(0)\) the bundle is four copies of \(\vartheta M\),
fixing the last line exactly, not just numerically. Picard groups
of products with projective space introduce no mixed factor.

Serre duality and \(W_a^*\simeq W_a\) make the section invariant
under inversion in M. Its parity is even: its restriction at M=0
is not identically zero, and the quotient linearization is positive
on that fiber. It descends to degree (2,2,2) on \(S\times S\times K\).
The exact sequence for the quartic K has
\(H^0(\mathbf P^3,\mathcal O(-2))=H^1(\mathbf P^3,\mathcal O(-2))=0\).
Restriction of quadrics is therefore an isomorphism, proving the
unique triquadratic extension R and its actual section criterion.

On \(K^3\), pullback to \(A^3\) gives the four theta factors
\(M+N+L,M+N-L,M-N+L,M-N-L\). Their divisor is invariant under
every permutation, since \(\Theta=-\Theta\). A transposition
fixes a point with nonzero section: choose its two equal variables
and the third generically outside the finitely many theta conditions.
Hence its scalar on the section is +1. Injectivity of restriction
in each quadratic factor proves full symmetry of R.

This is also the geometric construction behind the classical
biquadratic Kummer addition matrix: the products of the two theta
hyperplane values at \(N+M\) and \(N-M\) are precisely the
restriction of R. One may reconstruct R either by addition or by
its symmetric tensor and two-torsion calibrations. The numerical
uniqueness of a particular calibration is a separate finite rank
check; it is not asserted here for every curve.

## Ten-node interpolation of the actual section

The linear map \(j^*:H^0(S,\mathcal O(1))\to H^0(A,2\Theta)\)
is an isomorphism. The theta section of V_b is linear in its
coordinates b. Hence there is an invertible matrix H expressing
the hyperplane whose pullback is that theta section. The
determinant-zero square calculation normalizes R at p0 as in the
statement. Tensor covariance gives the calibration at p_tau, with
one unknown nonzero scalar lambda_tau.

These scalars need not be solved simultaneously with R. By full
symmetry of the ACTUAL R,
\[
R(p_0,b,p_\tau)=R(p_\tau,b,p_0)
=(p_\tau^{\mathsf T}Hb)^2.
\]
Comparison with the calibration formula makes the two nonzero
linear rows proportional and gives (4). If ten node evaluation
rows in the ten quadratic monomials are independent, their
values determine every coefficient of R in the third variable.
This proves the interpolation recipe for the actual determinant
section, rather than just for a form with prescribed zeroes.
