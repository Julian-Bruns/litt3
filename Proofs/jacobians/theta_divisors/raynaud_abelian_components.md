# Proof: polarization and the Dirac property

[Statement](../../../Theorems/jacobians/theta_divisors/raynaud_abelian_components.md).
The [bounded independent audit](../../../Research/audits/RAYNAUD_ABELIAN_COMPONENTS_AUDIT_2026_09_16.md)
passes the complete argument, including the scheme-level equality case.
The input from our earlier work is the audited
[rank-one dimension bound](raynaud_rank_one_dimension.md): a
translated abelian family with generic Raynaud defect one has
dimension at most (p-1)(G-1)/p. Its codimension-one consequence
also says that an abelian divisor THROUGH THE ORIGIN has
generic defect zero. The latter uses the quotient a-number
bound, since the complementary quotient has dimension one.

The published additional inputs are Raynaud's theta class and
Dirac property, and the ampleness consequence of the latter.
They are stated in [Tong, Section1.2.7, especially
Proposition1.2.7.5 and Theorem1.2.7.7](https://arxiv.org/pdf/0712.2046).
We keep the full finite kernel scheme, including its nonreduced
part. No argument below replaces it by its geometric points.

## 1. A component supplies an elliptic map and an intersection bound

Let A+x be the asserted component of D, of multiplicity mu.
Its generic cohomology dimension delta is positive. At the
generic point of this divisor a square cohomology presentation
is a matrix over a discrete valuation ring. Smith normal form
gives mu at least delta. The rank-one dimension bound excludes
delta=1, because dim A=G-1. Thus delta at least two.

Choose an Abel embedding a:C^(1)->J taking a base point to zero.
The quotient q:J->E=J/A is smooth with connected kernel A.
The curve h=q a is nonconstant because the Abel curve generates
J; set e=deg h. It is finite. Degree one would identify C^(1)
with an elliptic curve, so e at least two.

Use the principal polarizations to write i=h^*:E->J. The norm
h_* is q, since this equality holds after composition with a.
Duality for the quotient q makes i a closed immersion. The
usual norm identity gives
\[
q i=[e]:E\longrightarrow E,
\qquad i^*[\Theta]=e[0_E].
\tag{4}
\]
The second identity also follows by restricting the Jacobian
polarization and using that h_* is adjoint to h^*. Thus the
elliptic curve E'=i(E) satisfies
\[
\Theta\cdot E'=e,\qquad (A+x)\cdot E'=e^2.
\tag{5}
\]
Indeed A+x is a scheme-theoretic fiber of the smooth quotient
q, and its pullback by i is the degree-e-squared fiber of [e].
The norm identity and these intersection numbers are valid even
before separability of h is known.

The residual divisor R=D-mu(A+x) is effective or zero. Every
effective divisor on an abelian variety is nef: translate it
away from any given curve and compute their nonnegative
intersection. Since [D]=(p-1)[Theta], (5) gives
\[
0\le R\cdot E'=(p-1)e-\mu e^2.
\tag{6}
\]
Hence mu e at most p-1. Together with mu at least two, this
already forces e<p and therefore separability of h.

## 2. Equality would leave a nonample Dirac divisor

Suppose mu e=p-1. The Raynaud divisor is invariant under
inversion, by its Serre self-duality. If A+x and A-x were
distinct, both would occur with multiplicity mu. Subtracting
both and intersecting with E' would give
\[
0\le(p-1)e-2\mu e^2=-\mu e^2<0,
\tag{7}
\]
a contradiction. Therefore q(x)=-q(x).

The component cannot be A itself: the through-origin
codimension-one vanishing input above excludes that. Hence
q(x) is a NONZERO two-torsion point. The equality case can
occur only for odd p, because mu e at least four.

Let K=ker(V_J), where V_J:J->J^(-1) is Verschiebung.
It is a finite group scheme killed by p. Its image under q
is also killed by p. Thus the fiber A+x over a nonzero
two-torsion point is disjoint from K scheme-theoretically.
Indeed its geometric intersection is empty and K is finite;
this says its defining section is a unit on all of K,
including each infinitesimal local factor.

Locally near K, write an equation of D as u r, where r
is an equation of R and u is the equation of mu(A+x).
The restriction of u to K is a unit. The Dirac property says
that the restriction of u r vanishes on every nonidentity
local factor of O_K and spans the nonzero socle at the
identity. Dividing by a unit preserves both assertions:
the maximal ideal kills the socle, so multiplication there
is multiplication by a nonzero residue scalar. Therefore
R has the Dirac property too.

Tong's ampleness proposition now makes R ample. This also
excludes R=0: the zero divisor cannot have the Dirac
property on the nontrivial Verschiebung kernel in positive
dimension. But (6) in the equality case says R.E'=0,
contradicting ampleness. This proves mu e<p-1.

## 3. Small-characteristic and source consequences

The positive integers mu,e are both at least two. Their
product therefore cannot be strictly below p-1 for p=2,3,5.
This proves the complete absence of abelian components in
these characteristics, with no restriction on G or a(C).
For p=7, the only product possible is four, hence mu=e=2
and delta=2.

The underlying theta divisor is proper. An abelian divisor
coset contained in its support would be an irreducible
component, by equality of dimensions. Absence of components
is therefore exactly the generic-vanishing assertion in the
statement. Frobenius twists preserve the hypotheses.

This proof is separate from Tong's longer characteristic-three
argument (Theorem4.1.3.4) and does not claim that result as new.
The use of the Dirac property is essential for removing the
equality case in characteristic five; mere positivity leaves
the possible double bielliptic component.

For an actual two-map span, the source is one of the curves
covered by the theorem. Both maps remain present, but this
does not make their inherited parameter space an abelian
divisor. In particular it does not prove that the mixed
Raynaud defect vanishes in codimension greater than one,
and it does not solve either common-cover problem.
