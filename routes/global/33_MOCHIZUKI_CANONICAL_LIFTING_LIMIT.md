# Canonical lifting of compatible ordinary pairs and the triangle obstruction

Author source-checked conditional lifting proofs and character obstruction.
Consolidated2026-09-07 with the later two-leg source check; not independently
audited. The positive theorem requires ordinary COMPATIBLE pairs on the
specified common source. The characteristic5 triangle obstruction is
unconditional. Neither result excludes an unmarked common cover.

## 1. Exact datum and primary-source scope

Let k be perfect of odd characteristic p, A=W(k). For a smooth proper
hyperbolic pointed curve(C,D), put

    T_C^log=T_C(−D), Q(C,D)=H⁰(C,ω_C²(D)).

A nilpotent indigenous bundle P has square-Hasse-induced dual maps

    Φ_P^τ:H¹(T_C^log)^(1)→H¹(T_C^log),
    Φ_P^ω:Q(C,D)→Q(C,D)^(1).

[Mochizuki, ChapterII Proposition2.12/Definition3.1](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf)
calls P ordinary when either map is invertible; ordinary implies
admissible (Proposition3.2). This differs from Jacobian ordinarity
and ordinary dormant opers.

His ChapterIII Theorem3.2 gives a unique canonical Witt lift of the
PAIR(C,D;P). Theorem2.8 constructs Frobenius on N^ord_(g,r), not on
bare-curve moduli. The nilpotent-indigenous map to M_(g,r) has degree
p^(3g−3+r); ChapterII Proposition3.13 and its discussion give no
canonical choice of bundle in the generic situation stated there.
This does NOT prove that different choices have distinct underlying
curve lifts; it means uniqueness supplies no identification between them.

ChapterIII Definition2.9/Theorem2.10 (PDF pp.111–112) treats a finite
log-etale marked-point-preserving map ONLY when the pulled-back
special-fiber indigenous bundle is ordinary. Its stated base is
log etale over ordinary nilcurve moduli, formally smooth over Z_p,
with normal-crossings log structure. The proof inducts mod p^i:
renormalized Frobenius/Lemma2.6 identify underlying bundles, indigenous
structures identify classifying maps, and Lemma2.5 identifies connections.
It does not prove ordinary pullback for every cover.

## 2. One-leg theorem and SAME-source simultaneous lifting

Let f₀:(Z₀,D_Z)→(C₀,D_C) be an ACTUAL finite etale map with
D_Z=f₀^*D_C reduced. Suppose P₀ is ordinary nilpotent indigenous
on(C₀,D_C), and f₀^*P₀ is ordinary on(Z₀,D_Z). If(C,P) is the
canonical lift of(C₀,P₀), then f₀ has a unique finite etale lift
f:Z→C with its specified reduction, and(Z,f^*P) is the canonical
lift of(Z₀,f₀^*P₀), with the pulled-back marking.

Proof. Proper formal etale invariance and algebraization identify
finite etale covers of C with those of C₀
([SGA1, ExposeIX Theorem1.10](https://arxiv.org/abs/math/0206203)).
The lift is smooth and log admissible. Mochizuki III Corollary3.5
makes the pulled-back pair canonical under its ordinary-reduction
hypothesis. Equivalently, etale pullback preserves the canonical
MF-∇ structure, so Corollary3.4 (PDF p.114) characterizes it as the
canonical pair; the same uniqueness lemmas identify the connection.
For a more general log-admissible map this argument requires an
ACTUAL log-admissible lift; no automatic ramified lifting is asserted.

Now suppose the actual finite etale span X₀←Z₀→Y₀ has compatible
reduced markings and ordinary nilpotent indigenous bundles such that

    D_Z=f₀^*D_X=g₀^*D_Y,
    f₀^*P_X≅P_Z≅g₀^*P_Y,   P_Z ordinary.                 (1)

Apply the one-leg theorem twice. Both lifted source pairs are the
canonical lift of the SAME(Z₀,D_Z;P_Z). Theorem3.2 identifies them
with the specified special-fiber identification, giving actual maps

    X_can ← Z_can → Y_can

over W(k), finite etale also on the characteristic-zero generic fiber.
By finite presentation that diagram can descend to a finitely generated
characteristic-zero field and then base-change to complex curves.

Without the bundle isomorphism in(1), the two legs lift different
pairs(Z₀,f₀^*P_X),(Z₀,g₀^*P_Y). The uniqueness theorem says nothing
about identifying their underlying lifted curves. Without ordinary
P_Z neither canonical-source identification applies.
Compatible eigenforms still require the correct indigenous/marking
conventions and ordinary data on ALL THREE curves. One cannot enlarge
markings and presume the bundle remains indigenous.

## 3. Frobenius-character obstruction to ordinary pullback

A Frobenius-semilinear equivariant map on a finite-dimensional
representation of a finite prime-to-p abelian group sends a character
space χ toχ^p (or χ^(p⁻¹) for inverse semilinearity). Bijectivity
therefore requires the character multiplicities to be constant on
every Frobenius orbit. This elementary test needs no linearization
of an indigenous bundle if its square Hasse invariant is invariant:
the induced operator is built naturally from that invariant and Cartier.

For an ACTUAL cyclic etale cover from n-torsion L, p∤n,

    Q(Z)=⊕_(i mod n)H⁰(C,ω_C²⊗L^i).

Every summand has dimension3g(C)−3. Thus the dimension test is silent;
ordinary base controls only the invariant block, while the others
have additional operator conditions. Frobenius permutes their
characters; it need not preserve an individual k-valued character.
The [exact F_p coefficient criterion](TWISTED_CARTIER_ETALE_COVERS_AND_SIMPLE_MONODROMY_FACTORS.md)
handles that issue. The next ramified coarse/log-etale example has
unequal multiplicities, so the obstruction is immediate.

## 4. The actual genus15 triangle, pointed and unpointed

In characteristic5 let Y:y³¹=x(x−1), Γ=μ₃₁, and mark the unique
P₀,P₁,P∞ above0,1,∞. Then Y→P¹ is finite log etale and g(Y)=15.
NO indigenous bundle with Γ-invariant square Hasse invariant is
ordinary, either with these three markings or unpointed.

Here are the full character calculations. Valuations are

| Function/form | P₀ | P₁ | P∞ |
|---|---:|---:|---:|
| x |31|0|−31|
| x−1 |0|31|−31|
| y |1|1|−2|
| dx |30|30|−32|

For η=dx/(x(x−1)), div(η)=−P₀−P₁+30P∞. Division by η identifies

    Q(Y,P₀+P₁+P∞) ≅ H⁰(Y,ω_Y(31P∞)),
    Q(Y) ≅ H⁰(Y,ω_Y(30P∞−P₀−P₁)).

In the pointed case a basis is x^a dx/y^j with
1≤j≤30,0≤a≤floor((2j−1)/31). Indeed finite regularity forces
polynomial coefficients in k(x), and infinity gives31a≤2j−1.
No invariant(j=0) vector is allowed. Its count15+30=45 equals
3g−3+3. Character−j has multiplicity1 for1≤j≤15 and2 otherwise.

Unpointed, a basis is dx/y^j for1≤j≤29 and x dx/y^j for17≤j≤29:
the finite valuations require vanishing at P₀,P₁ and the infinity
bound is31a≤2j−2. Its count29+13=42 equals3g−3. Multiplicities
are1 for1≤j≤16,2 for17≤j≤29,0 forj=30; again no invariant vector.

The orbit1→5→25→1 has dimensions(1,1,2) in BOTH cases.
An invariant square Hasse operator sends character−j to−5⁻¹j,
so cannot be bijective. Reversing relative-Frobenius convention
reverses the same orbit and does not change the conclusion.

The three-pointed line is totally degenerate: Mochizuki II
Propositions3.5/3.7 give its unique ordinary nilpotent admissible
bundle. Its pullback to marked Y is nilpotent and admissible with
invariant square Hasse invariant, hence is NOT ordinary.
Any ordinary indigenous bundle on unpointed Y, if one exists,
must break μ₃₁ symmetry. Invariance of its isomorphism class already
makes the square Hasse invariant invariant; no chosen linearization
is hidden in this obstruction.

## 5. Limits of the route

Ordinary Jacobian (“parabolic” ordinarity) does not provide a
nilpotent ordinary indigenous bundle (“hyperbolic” ordinarity) on
an explicit curve merely because the latter locus is open dense.
Even existing ordinary endpoint bundles must stay ordinary on the
source AND agree there to apply Section2.

The [characteristic5 destruction theorem](FINITE_ETALE_COVER_DESTROYS_ALL_ORDINARY_INDIGENOUS_DATA_ON_ONE_CURVE.md)
shows an actual2-group cover can destroy the entire finite endpoint
pool; its source comparison explains Hoshi's characteristic3 result
and why that proof does not transfer directly to5. This makes the
missing source condition concrete, not just absent from a citation.

[Wakabayashi, TheoremsA/B](https://arxiv.org/abs/1602.07061)
concern DORMANT GL_n-opers, a different ordinary condition, abelian
prime-to-p covers and a general base curve in the preservation
direction. They do not supply(1) for these explicit curves or the
coarse triangle cover. Mochizuki ordinary nilpotent data here are
admissible and active, not dormant.

The positive result is a functor on compatible ordinary PAIRS with
ordinary pullback, not bare curves with all etale maps. It does not
prove a core or classify characteristic-zero correspondences; a
further obstruction is required. The old lifting plan remains closed.
