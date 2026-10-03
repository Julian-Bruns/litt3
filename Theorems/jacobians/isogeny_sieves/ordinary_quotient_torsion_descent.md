# Ordinary quotient descent through prime-primary monodromy

Version2,3 October2026. The all-prime cover theorem and reciprocal
Frobenius pairs sharpen the earlier torsion-descent argument.

Let X/F25 be the fixed genus-nine curve, and let
\[
X\xleftarrow f Z\xrightarrow gY
\]
be ACTUAL finite etale maps from the SAME smooth proper connected
curve. Suppose the Galois closure of f has an ell-group as its
group, for some prime ell. Y is ordinary of genus two. Neither
original map need be Galois, and J(Y) need not be simple.

Let m_Y be the F25-Frobenius orbit length of the geometric
isomorphism class of Y. If ell!=5, let m_ell be the Frobenius
order on J(X)[ell]. Then every prime divisor of m_Y divides
\[
\boxed{\quad
2\cdot3\cdot5\cdot m_\ell\cdot\ell
(\ell-1)(\ell^2-1)(\ell^4-1).
\quad}
\tag{1}
\]
For ell=5, the sharper conclusion is
\[
\boxed{\quad
\operatorname{Supp}(m_Y)\subseteq\{2,3,5,7,13\}.
\quad}
\tag{2}
\]
The cover order, exponent, nilpotency class and number of group
generators are unrestricted. In particular the main high-prime-degree
partner has NO common cover whose X-leg has a2-group,3-group or
5-group Galois closure. This includes ALL nonabelian five-groups
and an arbitrary non-Galois genus-two leg.

For ell=2 and3 the explicit supports are respectively
\[
\{2,3,5,7,19\},\qquad\{2,3,5,7\}.
\tag{3}
\]
More generally, a prime-primary X-leg for the main partner must
have ell!=5 and, writing r for its selected prime moduli degree,
\[
\ell=r\quad\text{or}\quad\operatorname{ord}_r(\ell)\le18.
\tag{4}
\]
In particular ell>r^(1/18). This leaves no small-prime exception
to the unbounded-group exclusion.

The backup has moduli degree three and is not excluded by these
supports. Mixed-prime monodromy and the unrestricted common-cover
problem remain open.

## Torsion lemma underlying the theorem

Let A/F_q be an abelian variety.

- If ell differs from the characteristic and A[ell] is rational
  for ell>=3, then every geometric abelian subvariety of A and
  every geometric endomorphism of A is defined over F_q. For
  ell=2 it suffices that A[4] is rational.
- In characteristic p>=3, if all geometric points of A[p] are
  rational, then every ORDINARY geometric abelian subvariety B
  is defined over F_q and all of its geometric endomorphisms
  are defined there. No ordinariness of A is needed.

The second assertion uses only the unit-root Tate module. It does
not descend arbitrary p-rank-zero subvarieties or their subgroup
schemes. The theorem uses the actual second map's norm kernel,
killed by8 times the X-leg degree, to pass from its Jacobian image
to the target's given principal polarization and curve moduli.

[Proof](../../../Proofs/jacobians/isogeny_sieves/ordinary_quotient_torsion_descent.md).
