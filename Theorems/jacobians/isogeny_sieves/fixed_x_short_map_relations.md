# Three cubic graphs control actual map relations and multiplicity

Version2,3 October2026. The original fixed-X short-relation audit
is retained; the generalization and stronger rank bounds have a
focused mathematical review.

## General three-graph theorem

Let X be a smooth proper curve over an algebraically closed field,
of genus g>4, with geometrically simple Jacobian A and number-field
endomorphism algebra K. Let gamma have order three and rational
quotient. Put E=Q(zeta), where zeta=gamma_* on A,
a=[K:E] and s=g/a. Let h_i:T->X be ACTUAL finite separable maps
of the same degree d from one smooth proper connected curve.
For pairwise distinct embedded fields h_i^*k(X), put
\[
u_i=(h_i)_*,\quad v_i=h_i^*=u_i^\dagger,\quad
H_{ij}=s\operatorname{Tr}_{K/E}(u_iv_j).
\]
Then s is a positive integer, and at either complex embedding of E,
\[
H_{ii}=gd,\quad H_{ji}=\overline{H_{ij}},\quad
\operatorname{Re}(\zeta^eH_{ij})\le d
\quad(i\ne j,\ e=0,1,2).
\tag{1}
\]
In particular |H_ij|<=2d. Any family of at most ceil(g/2)
distinct fields has E-linearly independent norm maps.

Let N be the number of fields, m the geometric multiplicity of A
in J(T), and r=rank_E H. The full triangle, rather than just its
radius, gives
\[
\max\left\{\frac{g^2N}{4N+g^2-4},
\frac{3g^2N}{4N+g^2(g+3)-4}\right\}\le r\le am.
\tag{2}
\]
For every positive integer k one also has
\[
\binom{r+k-1}{k}\ge
\frac{N}{1+(N-1)(4/g^2)^k}.
\tag{3}
\]
Consequently N<4^r<=4^(am), so
\[
m>\frac{\log N}{a\log4}.
\tag{4}
\]
Thus arbitrarily many distinct actual fields force unbounded
Jacobian multiplicity. No unbounded field family is presumed.

## The fixed genus-nine endpoint

For the fixed X, g=a=9 and s=1. Actual finite etale maps have
degree d=(g(T)-1)/8. Formula(2) becomes
\[
\max\left\{\frac{81N}{4N+77},
\frac{243N}{4N+968}\right\}\le r\le9m.
\]
In particular N>=102 forces m>=3, improving the old threshold155.
Formula(4) supplies a growing multiplicity bound as N increases.

The norms from at most FIVE distinct fields are independent over E.
Equal fields are grouped by the actual cubic automorphisms of X;
every grouped E-coefficient in such a relation must vanish separately.

A relation among THREE maps with nonzero coefficients in K whose
ratios belong to E forces all three fields to coincide. With
nonzero integer coefficients, the only possibilities are: all maps
identical and coefficients summing to zero, or the three cubic
conjugates of one map with equal coefficients. Hence a literal
identity (h1)_*+(h2)_*+(h3)_*=0 holds exactly for a cubic orbit.

These are statements about the supplied actual maps. Arbitrary
K-weighted relations, individual one-form relations, the existence
of an unbounded actual field orbit and a simultaneous finite
Galois closure remain outside their scope. In common-cover
applications BOTH original finite etale legs remain required.

[Proof](../../../Proofs/jacobians/isogeny_sieves/fixed_x_short_map_relations.md).
