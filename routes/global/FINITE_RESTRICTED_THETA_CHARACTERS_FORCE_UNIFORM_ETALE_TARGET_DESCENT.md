# Finite bad characters force one finite etale descent level

Date: 2026-09-05. Proposal: `/root`.
Proof and write-up: `/root/canonical_trace_algebra`.
Status: author proof using the previously checked whole-Jacobian
orthogonality theorem; no independent audit or novelty claim.

## 1. Arbitrary prime-to-p torsion directions

Let k be algebraically closed of characteristic p>0, and let U be a
smooth projective connected curve of genus at least two. Write

\[
 B_U=F_{U/k*}O_U/O_{U^{(1)}},\qquad
 \Theta_U=\{L\in J(U^{(1)}):h^0(B_U\otimes L)>0\}.
\]

Let Gamma be **any subgroup** of J(U^(1))(k) consisting of torsion
points of order prime to p. Assume only that

\[
                          S=\Theta_U(k)\cap\Gamma
                    \quad\hbox{is finite}.                 \tag{1.1}
\]

No fixed prime support, divisibility of Gamma, ambient abelian
subvariety, or geometric dimension hypothesis is imposed. No
ordinarity hypothesis on U is imposed.

For each finite Lambda<=Gamma, let W_Lambda -> U be the connected
abelian etale character cover of degree |Lambda|. Construct it on U^(1)
by Kummer theory and transport it to U by etale Frobenius base change.
Compatible basepoints realize all these covers in one separable closure
of k(U), with W_(Lambda+Lambda') dominating W_Lambda and W_Lambda'.
Put

\[
                  \Lambda_0=\langle S\rangle,
                  \qquad W_0=W_{\Lambda_0}.                 \tag{1.2}
\]

This is a finite group, even when Gamma has infinitely many primes.

### Theorem 1

For every finite Lambda containing Lambda_0, the Prym of
W_Lambda -> W_0 is ordinary. In particular

\[
                         \Delta(W_\Lambda)=\Delta(W_0),
                  \qquad \Delta(V)=g(V)-f_V.                \tag{1.3}
\]

For arbitrary finite Lambda<=Gamma, Delta(W_Lambda)<=Delta(W_0).
Every cofinal nested sequence in this directed family eventually has
ordinary successive and composite Pryms.

### Proof, including all Frobenius iterates

Etale functoriality of B and the character decomposition give

\[
 a(W_\Lambda)=h^0(W_\Lambda^{(1)},B_{W_\Lambda})
                =\sum_{L\in\Lambda}h^0(U^{(1)},B_U\otimes L), \tag{1.4}
\]

and the corresponding direct sum decomposition as a deck module.
Inverting character labels, if necessary, does not change a subgroup
Lambda. Every nonzero summand lies in S and hence in Lambda_0.

Multiplication by p is an automorphism of every prime-to-p torsion
subgroup: each individual point has an inverse p-multiple obtained
by multiplication by an integer. Thus Lambda_0 and its complement
in Lambda are invariant under the p-power permutation of characters.

Absolute Frobenius on H^1(W_Lambda,O) is semilinear and sends the
chi-eigenspace to the chi^p-eigenspace. Its old part, indexed by
Lambda_0, and the complementary new part are invariant. Equivalently
use the averaging projector for Gal(W_Lambda/W_0), whose order is
prime to p and which commutes with Frobenius.

The defining sequence for B identifies its global sections with the
kernel of relative Frobenius on H^1: the preceding map on H^0(O)
is an isomorphism. After scalar twisting, (1.4) therefore says that
the new part has zero Frobenius kernel. Frobenius is bijective there,
since it is injective on a finite-dimensional space over the perfect
field k. That new part is the coherent H^1 of the relative Prym,
which is consequently ordinary.

This addresses stable nilpotence, not merely the first kernel. Any
nonzero nilpotent character component eventually maps into a first
kernel component; its character lies in the multiplication-by-p orbit
of a point of S. All those orbits are finite and contained in Lambda_0.
The finite set S itself need not be invariant under multiplication by p.

Poincare reducibility now proves (1.3). For arbitrary Lambda, dominate
it by Lambda+Lambda_0 and use nonnegativity of the defect of its relative
Prym. This also proves the assertion for every cofinal sequence.
\(\square\)

Equation (1.4) is an a-number formula. It does not identify the
a-number with Delta or bound Delta by the number of points of S.
Long p-power character orbits are relevant to the latter distinction.

## 2. Uniform actual target descent

Let T vary over all hyperbolic curves whose Jacobians have no ordinary
simple isogeny factor. The fixed W_0 in (1.2) works simultaneously
for all such targets and all their genera.

### Theorem 2

Every actual morphism W_Lambda -> T, with Lambda containing Lambda_0,
descends uniquely to W_0. An etale morphism descends etale. There are
only finitely many isomorphism classes of such T admitting a finite
etale map from any member of the entire directed family or from an
actual etale quotient of a member.

**Proof.** The Prym in Theorem 1 is ordinary, so it has no nonzero
homomorphism to J(T). Apply
[Theorem A of the checked non-Galois Jacobian descent theorem](NONGALOIS_JACOBIAN_ORTHOGONALITY_AND_ETALE_MAP_STABILIZATION.md).
For arbitrary Lambda first pull the map up to W_(Lambda+Lambda_0);
the same W_0 receives its descent. The same argument handles maps
from an actual etale quotient by first composing with the quotient map.

The fixed hyperbolic curve W_0 has only finitely many hyperbolic etale
quotient curves, by Section 7 of that theorem. Its proof bounds the
outgoing degrees by g(W_0)-1 and their Galois closures by bounded-degree
etale covers of W_0, then uses finite generation of its etale
fundamental group and finite automorphism groups. \(\square\)

### Retaining a given second-leg diagram

Suppose also b:U -> B is fixed finite etale of degree e. Let Z be an
actual intermediate of W_Lambda -> B, and let r:Z -> T be finite
etale. In k(W_(Lambda+Lambda_0)), the pulled-up map descends to W_0.
Therefore

\[
                  k(D)=k(B)\,r^*k(T)
                       \subset k(Z)\cap k(W_0),
        \qquad [k(D):k(B)]\le e|\Lambda_0|.                  \tag{2.1}
\]

Normalization gives actual etale maps Z -> D -> B and D -> T, with
r factoring through D. Each is an intermediate map of one of the
original etale maps. This requires neither Z/B nor Z/T to be Galois,
and does not require W_0 to be contained in Z or W_Lambda.

## 3. Application and boundary

For an ordinary genus-two Y in characteristic five and an etale double
cover U -> Y, its elliptic Prym has ordinary complementary quotient.
Its Raynaud theta restriction is therefore finite. Applying this
theorem to all odd prime-to-five Prym torsion gives
[the generalized-dihedral corollary](ODD_GENERALIZED_DIHEDRAL_TOWERS_OVER_ORDINARY_GENUS_TWO_HAVE_FINITE_NONORDINARY_TARGETS.md),
including actual non-Galois intermediate covers.

The substantive hypothesis here is (1.1). Properness of theta on a
higher-dimensional parameter subvariety alone does not imply it. No
assertion for arbitrary nonabelian towers, unrestricted prime-to-p
torsion in a full Jacobian, or p-primary character covers follows.
