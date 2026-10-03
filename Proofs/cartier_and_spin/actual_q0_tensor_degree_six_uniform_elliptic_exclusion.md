# Proof: distinct translation kernels force four to divide six

Version1,3 October2026. Frozen pending independent whole review; see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_six_uniform_elliptic_exclusion.md).

By the [disjoint degree-SIX profile](actual_q0_tensor_degree_six_two_triple_disjoint_reduction.md), B is its actual joint x-field. Both xi have degree SIX, local indices ONE orTHREE and TWO triple infinity points. Assume additionally that EVERY ramified fiber for BOTH maps is uniform. A uniform index-THREE fiber of degree SIX contains TWO points and contributes FOUR to Hurwitz. Since B is elliptic, its total different degree over P1 is TWELVE, so each xi has exactly THREE such fibers. The q0-root values are disjoint from the fixed P/∞ branch values, hence unramified. Their common reduced inverse image D⊂B has TWELVE points, as supplied by the accepted actual coarse reduction.

## Each individual uniform map has an actual translation kernel of order two

For ONE xi, take its OWN separable Galois closure Z→P1. At each branch value its completed local maps all have tame index THREE; over algebraically closed residue fields the tame extension of index THREE is unique. Hence the closure still has inertia THREE, and Z→B is étale. This is an individual actual Galois closure, not an assumed simultaneous closure of the two xi. Since B is elliptic, Z is elliptic too.

Write G for the closure group and H for its subgroup with Z/H=B. Choose an origin on Z. The translation subgroup A of G is normal, and G/A is contained in the automorphisms fixing an elliptic origin. The inertia groups have fixed points, so their order-THREE action cannot be a nontrivial translation. They give order THREE in G/A. The image is exactly C3: inertia normally generates G because its quotient is an unramified cover of P1, while the elliptic origin automorphism group in characteristic FIVE is cyclic of order TWO,FOUR orSIX. Thus G/A=C3.

Since Z→B is étale, every nontrivial element of H acts freely on Z and is a translation; an elliptic automorphism with nontrivial linear part has a fixed point. Therefore H⊂A. The actual quotient tower is
\[
B=Z/H\xrightarrow{\phi} E=Z/A\longrightarrow P^1,
\qquad \deg\phi=|A|/|H|=2.
\]
The first map is an étale isogeny with translation kernel P of order TWO; the second is the quotient by an actual order-THREE elliptic automorphism. This factorization is valid whether or not H is normal in all of G. Only H being a subgroup of the abelian translation group A is used.

Apply this separately to BOTH xi, obtaining φi:B→Ei and their order-TWO translation subgroups Pi. On Ei choose an origin fixed by its quotient rotation. Translating these origins does not change the induced homomorphisms of translation groups; φi(Pj) below denotes that induced image. An elliptic curve with such an order-THREE origin automorphism in characteristic FIVE has model Y²=X³+c, c≠ZERO, and the rotation cycles its THREE nonzero TWO-torsion points. Thus any one nonzero translation in Ei[TWO], together with its rotation conjugates, generates Ei[TWO] of order FOUR.

## The common reduced two-value divisor excludes different kernels

Each Pi fixes xi, so it preserves D. Suppose P1 and P2 are DISTINCT. Since φ1 is étale of degree TWO with kernel P1, D is the full reduced inverse image of a SIX-point set Q⊂E1. That set is the inverse image of the TWO unramified q0-root values under the order-THREE quotient E1→P1, so it is preserved by that rotation. The image φ1(P2) is a NONZERO TWO-torsion translation on E1, and also preserves Q: translation by P2 preserves D and commutes with the isogeny φ1. Rotation conjugates then make Q invariant under ALL E1[TWO]. This translation group acts freely on the elliptic curve. Its invariant finite reduced set must have cardinality divisible by FOUR, contrary to |Q|=SIX.

Therefore P1=P2. But this nontrivial translation subgroup on B fixes BOTH xi, placing their joint field strictly inside B. This contradicts B=k(x1,x2). All uniform elliptic alternatives are consequently excluded.

No point of the q0 divisor was omitted, no coordinate line was assumed proportional, and no target quotient was substituted for an original source. The proof does not close a nonuniform finite branch fiber, other genera, the nonsplit class in general or cubic root index ONE.
