# Genus-two active connections from fifteen critical quartics

Version5,2026-09-24. Author proof with exact certificates and a bounded
audit of the affine-orbit reduction. Work over an algebraically closed field k
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

## Two explicit loci in the genus-two family

For F=u(u-1)(u-2)(u-3)(u-t), suppose either [F5(t):F5]>6 or
t³+t+1=0. This includes the high-degree partner and the small backup.
Then:

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

Two affine branch-pair orbits reduce the family certificate to two
critical quartics, with parameter-degree bounds at most6. The backup
checks all fifteen directly at its cubic parameter. Nilpotent scheme
length125 determines the local multiplicities; canonical-double counting
proves reducedness and twisted-tangent vanishing on every double.
No identification of Jacobian and indigenous ordinarity is used.

These are endpoint results. They neither make an arbitrary common-source
connection ordinary nor supply a common connection or common-cover exclusion.

[Proof](../../Proofs/projective_connections/genus_two_active_critical_quartics.md) ·
[Exact verifier](../../scripts/genus_two/check_genus_two_active_twists.py).
