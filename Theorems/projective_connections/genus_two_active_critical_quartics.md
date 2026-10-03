# Genus-two active connections from fifteen critical quartics

Version6,3 October2026. The critical degeneration now has an intrinsic
dormant-incidence interpretation, giving one exact invariant family locus. Work over an algebraically closed field k
of characteristic5. Let Y: v²=F(u), F monic squarefree of degree5,
eta=du/v, with Weierstrass point O at infinity.

Represent each nonzero class of Pic(Y)[2] by a pair of the six
Weierstrass points. Put R equal to the monic product of the finite
abscissas of the pair, so deg R is1 or2, and put S=F/R. Define

    D=R S²,       J=R' S+2R S',       K=D^[6],
    c=[u^4](S R²),

where D^[6] is the sixth Hasse derivative. J has degree exactly4.
The normalized quartics of ACTIVE regular nilpotent connections
with this Hasse root class are precisely the following DISTINCT tensors:

    c S eta^4                         if c!=0;
    K(h) R(u)(u-h)² eta^4              for J(h)=0, K(h)!=0.

Every listed tensor has four double zeros and reconstructs the actual
regular connection by the scalar nilpotent dictionary. No geometric
root is restricted to the coefficient field. Repeated quartic roots
count only once here; no local multiplicity claim is implicit.
There are at most five such active connections in each nonzero class.

## The exact eighty-five-point family locus

For $F=u(u-1)(u-2)(u-3)(u-t)$, take an ordinary smooth parameter
$t\notin\mathbf F_5$ and put
\[
z=(t+1)^{-1},\qquad A=(z^5-z)^4.
\]
There are exactly85 active connections if and only if
\[
\boxed{(A-2)(A^6+A^4+A^2+4)\ne0.}
\]
Equivalently, every $J$ is squarefree, every $\gcd(J,K)=1$ and
every $c\ne0$. The factor $A^3+3A^2+4$ is exactly the first-height
dormant pointed-incidence locus; its complementary cubic factor
$A^3+2A^2+1$ and $A-2$ detect critical-root collisions.
This is a geometric condition over the algebraic closure.

Both the older degree condition $[\mathbf F_5(t):\mathbf F_5]>6$
and the actual backup $t^3+t+1=0$ satisfy this condition. On the
whole displayed locus, including those two original cases:

- every one of the fifteen J is squarefree and coprime to its K,
  and all fifteen c are nonzero;
- there are exactly75 nonsplit active connections, five in each class;
- there are exactly10 split active connections and five dormant ones;
- ALL85 active connections are ordinary in the INDIGENOUS nilpotent
  deformation sense;
- the full nilpotent scheme consists of those85 reduced active points
  and five dormant points, each of local length8;
- every connected etale double of Y has exactly15 dormant connections,
  all reduced. For every dormant r on Y and every L in Pic(Y)[2],
  its L-twisted dormant tangent kernel is zero.

Two affine branch-pair orbits determine the collision locus. Unnormalized
Cartier roots identify vanishing normalization factors with dormant
pointed incidence, replacing the separate critical resultants.
Nilpotent length125 determines all local multiplicities; canonical-double
counting proves reducedness and twisted-tangent vanishing on every double.
No identification of Jacobian and indigenous ordinarity is used.

These are endpoint results. They neither make an arbitrary common-source
connection ordinary nor supply a common connection or common-cover exclusion.

[Proof](../../Proofs/projective_connections/genus_two_active_critical_quartics.md) ·
[Independent review](../../Research/audits/CRITICAL_FAMILY_DORMANT_HINDSIGHT_AUDIT_2026_10_03.md).
