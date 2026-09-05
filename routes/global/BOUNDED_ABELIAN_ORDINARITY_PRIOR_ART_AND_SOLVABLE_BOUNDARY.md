# Bounded abelian-cover ordinarity: prior art and the solvable boundary

Date: 2026-09-05.

Status: bounded primary-literature comparison by the gluing/cohomology agent,
with the normal-p-Sylow consequence supplied collaboratively by the root.
This is not an independent audit of the local ordinarity theorem, nor a claim
that the search exhausts the literature. No fixed curve has been replaced.

Local target: [the bounded-exponent hyperelliptic theorem](GENERIC_HYPERELLIPTIC_BOUNDED_ABELIAN_COVERS_ORDINARY.md).

## 1. Exact proof-level prior art: Zhang

Bin Zhang, *Revêtements étales abéliens de courbes génériques et ordinarité*,
Ann. Fac. Sci. Toulouse (6) 1 (1992), 133–138,
[primary PDF](https://www.numdam.org/item/AFST_1992_6_1_1_133_0.pdf).

Theorem 3.1, pp. 136–138, proves ordinarity of all connected prime-to-p abelian
étale covers of the geometric generic curve of full moduli. Corollary 3.4
adds the p-primary part using Crew. Zhang's notation for a stable Hilbert
parameter space must not be confused with the hyperelliptic locus.

The entire proof was read. Its mechanism is precisely the one used locally:
degenerate to a chain of ordinary elliptic curves; use compact type to make
the relative Picard scheme abelian (Lemma 3.3); extend prime-to-p torsion over
a strict henselization; extend the actual torsor étale, including at nodes;
then use ordinary elliptic normalization components, Corollary 2.3, and
openness of Frobenius bijectivity.

The hyperelliptic version is thus a bounded-level adaptation of Zhang's
classical argument, not a new ordinarity mechanism. The additional local
work is a hyperelliptic smoothing with Weierstrass attachment points and a
finite-level open condition. An explicit printed theorem naming all
hyperelliptic loci and all prime-to-p exponents was not located in this
bounded check. Nakajima's original proof was not independently inspected.

## 2. Larger solvable groups: exact positive and negative scope

Michel Raynaud, *Revêtements des courbes en caractéristique p > 0 et
ordinarité*, Compositio Math. 123 (2000), 73–88,
[primary PDF](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/16AB72912D3CE32BFC5D012B1025A8E4/S0010437X00000440a.pdf/revetements-des-courbes-en-caracteristique-pandgt0-et-ordinarite.pdf).

For the geometric generic curve of full moduli:

- Corollary 8, p. 77, treats an abelian kernel and a cyclic prime-to-p
  quotient.
- Theorem 14, pp. 82–83, treats central extensions of two finite abelian
  groups when the group order is coprime to g!.

The proofs use symplectic monodromy before elliptic-tail degeneration.
Corollary 8 does not transfer automatically to hyperelliptic 2-primary
monodromy. Theorem 14 already excludes even orders; its hyperelliptic
adaptation is not certified here either.

Theorem 2: for each p and g at least two, a finite prime-to-p solvable group
gives a nonordinary Galois étale cover of every genus-g curve. The proof uses
a cyclic cover followed by a Heisenberg construction (pp. 85–86). Thus no
open locus controls all solvable covers. These proofs were read; their
auxiliary Brill–Noether input was not independently re-audited.

## 3. A direct common-cover consequence, without an orbifold

Write U_(h,N) for the local open locus on which every connected abelian
étale cover of exponent dividing N is ordinary; assume p does not divide N.
Let Y lie in this locus and W → Y be connected Galois étale with group G.
Suppose its p-Sylow P is normal and G/P is abelian of exponent dividing N.
Then W is ordinary.

Indeed, V = W/P → Y is one of the controlled abelian covers, while W → V
is Galois étale of p-power degree. The latter preserves ordinarity by
Richard Crew, *Etale p-covers in characteristic p*, Compositio Math. 52
(1984), 31–45, Corollary 1.8.3, pp. 36–37
([primary PDF](https://www.numdam.org/item/CM_1984__52_1_31_0.pdf)).
This corollary and its Deuring–Shafarevich proof were checked directly.

Consequently, a nonordinary smooth proper curve X cannot share an actual
finite étale source Z with this Y if the étale Galois closure of Z → Y has
such a group. That closure W still maps étale to Z and X. A nonzero
holomorphic differential in the kernel of Cartier on X pulls back to one
on W: separability gives injective differential pullback, and Cartier
commutes with étale pullback. This contradicts ordinarity of W.

Normality of P is essential to this argument. Iterating abelian covers
would require the intermediate curves to satisfy their own controlled-cover
property; ordinarity of those intermediates alone does not supply it.

## 4. The short coreless-correspondence check found no matching bridge

Raju Krishnamoorthy, *Correspondences without a core*, Algebra & Number
Theory 12 (2018), starting at p. 1173,
[primary PDF](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf).
Section 8's cyclic-cover construction requires an invariant line bundle
and a specified invariant section. The resulting vertical cyclic covers
can ramify along its zero divisor. Example 8.5's Hasse-invariant/Igusa
construction does not assert nonordinarity of the covering curve's
Jacobian. Thus this construction does not produce the required bounded-order
nonordinary étale cyclic cover merely from corelessness.

Shinichi Mochizuki, *Correspondences on Hyperbolic Curves*, Theorem A,
[author PDF](https://www.kurims.kyoto-u.ac.jp/~motizuki/Correspondences%20on%20Hyperbolic%20Curves.pdf),
does give finitely many partners of fixed type for a fixed hyperbolic curve,
but in characteristic zero. This is not a characteristic-five finiteness
input. Separate liftability of the two maps does not supply a joint lift.

For the already-checked simultaneous-deformation boundary, see
[the existing source note](CORELESS_JOINT_DEFORMATION_RIGIDITY_SOURCE_BOUNDARY.md).
No positive-characteristic coreless criterion implying a bounded-order
nonordinary cyclic cover, or the required fixed-genus partner finiteness,
was found in this bounded primary-source check. This is a search boundary,
not an assertion of a universally open problem.
