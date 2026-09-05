# Finite nonordinary targets in finite-support abelian etale towers

Author: `/root`. Date: 2026-09-05.
Status: author proof, using the independently checked non-Galois descent
theorem and Boxall-method torsion lemma. The finite-prime-support extension
in Section 2 received a focused **PASS**, no breaking objection, from
`/root/canonical_trace_algebra`, 2026-09-05. The final combined theorem is
not separately audited. No novelty or solution of Litt's problem is claimed.

## 1. A uniform finite-target theorem

Let `k=Fbar_p`, let `C/k` be a smooth projective connected hyperbolic curve
with geometrically simple Jacobian, and let `S` be a fixed finite set of
primes different from `p`. Let `C_n/C` be the maximal abelian etale cover
of exponent

\[
                           N_n=\prod_{\ell\in S}\ell^n.
\]

These are connected nested covers of degree `N_n^(2g(C))`. Their union
contains every connected abelian Galois cover of `C` whose group has
prime support in `S`.

### Theorem 1

There exists a finite level `C_m` with the following property. For every
hyperbolic curve `X/k` whose Jacobian has **no ordinary simple isogeny
factor**, every finite etale map from any `C_n`, `n>=m`, to `X` descends
to `C_m`.

The level `m` is independent of `X`, its genus, and both covering degrees.
Consequently only finitely many such target curves `X`, up to geometric
isomorphism, can share a cover with `C` whose leg to `C` is abelian with
prime support in `S`.

More precisely, every actual such correspondence has a common quotient
diagram

\[
                        C\longleftarrow D\longrightarrow X
\]

with both maps finite etale and `deg(D/C)<=deg(C_m/C)`. No Galois
assumption is made on the map to `X`.

The target condition includes every supersingular Jacobian, every
Jacobian of p-rank zero, and every absolutely simple nonordinary
Jacobian, including those of positive p-rank. It does not require the
whole target Jacobian to be simple or its endomorphism algebra to be a
field. The hypothesis on the base Jacobian is different and explicit.

## 2. The finite-prime-support torsion lemma

Write `A[S^infty]` for the geometric torsion points of an abelian variety
whose orders have all prime factors in `S`.

### Lemma 2

If `A/k` is geometrically simple and `D` is a proper closed subvariety,
then `D(k) intersect A[S^infty]` is finite.

The elementary single-prime proof and its primary-source provenance are
in [the checked Boxall-method note](BOXALL_PRUFER_TORSION_AND_EVERY_CYCLIC_TOWER.md).
Here is the additional argument needed to handle several primes at once.

Choose a finite field `F_q` defining `A,D` such that its Frobenius `M`
is the identity on `A[ell]` for every `ell in S`, and on `A[4]` if
`2 in S`. On each finite ell-primary torsion group the order of `M`
is an ell-power: on the Tate module its matrix lies in the congruence
subgroup `1+ell M_r(Z_ell)` (in `1+4 M_r(Z_2)` for `ell=2`).

Let `P in A[S^infty]` not be rational over `F_q`, and write it as the
sum of its primary components. Choose `ell` with

\[
                          Q=(M-1)P_\ell\ne0.
\]

Let `a` be the product of the Frobenius orbit lengths of all the other
primary components. Then `a` is prime to `ell` and `M^a` fixes all
those other components. On the ell-adic Tate module,

\[
             M^a-1=(1+M+\cdots+M^{a-1})(M-1)=U_a(M-1),
\]

where `U_a` is invertible, since `U_a congruent a I mod ell`.
Thus `(M^a-1)P_ell` has the same exact order `ell^s` as `Q`.
The checked single-prime binomial argument, applied to `M^a`, gives

\[
                 (M^{a\ell^{s-1}}-1)P=T,
                        \qquad 0\ne T\in A[\ell](k).                 \tag{2.1}
\]

Every other primary component is still fixed. Therefore there is a
fixed finite list of possible nonzero prime-order translations `T`,
for `ell in S`, such that each nonrational torsion point of `D` lies in
`D intersect (D-T)` for one of them.

To finish, induct on the dimension of `D`, component by component.
Since `A` is simple, every proper irreducible subvariety has finite
reduced translation stabilizer. Quotient by that finite subgroup. The
quotient remains a simple abelian variety, and the image subvariety has
trivial reduced stabilizer. Torsion points of finite prime support lift
through this quotient: every point over `Fbar_p` is torsion, and one
takes the `S`-primary part of a lift. The quotient has finite fibers.

On the quotient, each intersection with a nonzero translate in (2.1)
has smaller dimension, so the induction applies. The rational points
over the chosen finite field form a finite exceptional set. Pulling
back through the finite stabilizer quotient preserves finiteness.
Nonreduced stabilizers are harmless because the proof only uses
nonzero geometric prime-to-p torsion translations. This proves Lemma 2.

Finiteness of `S` and its exclusion of `p` are essential assumptions of
this proof. It does not assert finiteness for all prime-to-p torsion.

## 3. Eventually ordinary new parts

On `C^(1)` let

\[
  \mathcal B_C=F_{C/k*}\mathcal O_C/\mathcal O_{C^{(1)}},\qquad
  D=\Theta_{\mathcal B_C}\subset J(C^{(1)}).
\]

The theta locus is a proper effective divisor. Simplicity is unchanged
by Frobenius twist. By Lemma 2 it contains only finitely many
`S`-primary torsion points. Choose `m` so that all these points have
order dividing `N_m`.

For any `n>=m`, the character decomposition of `C_n/C` splits
`H^1(O_(C_n))` into the old block with characters of order dividing
`N_m` and its complement. Semilinear Frobenius permutes the characters
by their p-th powers and preserves these two blocks. By the relative
Frobenius sequence and the etale pullback identity for `B`, the kernel
on a character block is governed by

\[
                       H^0(C^{(1)},\mathcal B_C\otimes L).
\]

This vanishes on every character in the complementary block. Frobenius
is therefore bijective on that entire block, not merely bounded in its
first kernel. Thus the Prym of `C_n/C_m` is ordinary for every `n>=m`.
In particular `g(C_n)-f(C_n)` is eventually constant. The base curve
itself need not be ordinary.

## 4. Descent and finiteness of actual target curves

For every target in Theorem 1, an ordinary abelian variety has no
nonzero homomorphism to `J(X)`. Apply
[Theorem A of the checked non-Galois descent theorem](NONGALOIS_JACOBIAN_ORTHOGONALITY_AND_ETALE_MAP_STABILIZATION.md#1-setup-and-statements)
to `q:C_n->C_m`. It makes every actual morphism `C_n->X` descend to
`C_m`, and retains etaleness when the morphism was etale.

The fixed hyperbolic curve `C_m` has only finitely many hyperbolic etale
quotient curves, as proved in Section 7 of that theorem: the outgoing
degree is at most `g(C_m)-1`; the Galois closures are bounded-degree
etale covers of `C_m`; and their automorphism groups are finite.
This proves the finiteness assertion uniformly in the target genus.

For the more precise common-quotient assertion, embed the function
field of an arbitrary abelian `S`-cover `W/C` in a sufficiently high
`k(C_n)`, with `n>=m`. Pull an actual etale map `r:W->X` up to `C_n`.
By descent its image field lies in both `k(W)` and `k(C_m)`. Therefore

\[
                      k(D)=k(C)\,r^*k(X)
                          \subset k(W)\cap k(C_m)
\]

has degree over `k(C)` at most `deg(C_m/C)`. Normalization yields the
claimed diagram. Both maps from `D` are etale, since they are
intermediate maps of the original two etale maps from `W`.
This proves Theorem 1 without replacing the common source by unrelated
maps or assuming that `W` contains `C_m`.

## 5. Fixed initial covers with a proper restricted theta locus

There is a parallel conditional version. Fix an actual finite etale
map `Z->C`, not necessarily Galois, with `J(C)` simple, and suppose the
closed locus

\[
 D_Z=\{L\in J(C^{(1)}):
     H^0(Z^{(1)},\mathcal B_Z\otimes L|_{Z^{(1)}})\ne0\}
\]

is proper. Lemma 2 again gives finitely many bad `S`-primary characters.
The same block argument bounds the total defect in the full fiber
products `Z times_C C_n`. Their number of connected components is
bounded and eventually constant; the abelian deck group permutes them
transitively. Hence any compatible connected-component tower has
bounded, eventually constant defect and eventually ordinary Pryms.
Section 4 applies on that actual tower, with one fixed level for all
targets whose Jacobians have no ordinary simple factor.

Properness of `D_Z` is not automatic: the earlier Raynaud no-theta
examples make it fail. Nor does this conditional tower become cofinal
in the recursive tower forced by an arbitrary common cover.

## 6. Comparison and exact unsolved boundary

This gives a parameterized all-degree result, not an individual degree
calculation. Its finite-target conclusion applies with no simplicity,
endomorphism-field or automorphism-group hypothesis on the targets.

It does not supersede file 95: that theorem can exclude arbitrary
nonconstant target maps and arbitrary mixed-prime abelian groups,
including characteristic-divisible groups, under different arithmetic
and genus hypotheses. Here the two maps are etale, `S` is fixed, and
the base Jacobian rather than the target Jacobian is simple.

Every recursive tower has some finite prime support determined by its
initial finite monodromies, but its groups need not be abelian. The
finite-support statement here therefore does not control such a core
tower. Known fixed-support nonabelian examples can have unbounded
defect. Likewise, taking the union of finite exceptional target sets
over all finite `S` does not produce a finite exceptional set.

No no-common-cover conclusion for the original pair, or for unrestricted
monodromy, is claimed.
