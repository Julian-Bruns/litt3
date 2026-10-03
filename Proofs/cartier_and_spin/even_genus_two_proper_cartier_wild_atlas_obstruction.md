# Proof: regular Cartier fiber and the positive-different residue

Version2,3 October2026. Root and independent whole-scope review **PASS** in the [Version2 audit](../../Research/audits/PROPER_CARTIER_ETALE_ATLAS_WILD_GENERALIZATION_AUDIT_2026_10_03.md). The Version1 exact scope and proof remain in the provenance subsections. See the [statement](../../Theorems/cartier_and_spin/even_genus_two_proper_cartier_wild_atlas_obstruction.md). No computation is used.

Put N=|R|. Étale Hurwitz gives g(D)−ONE=N/e. Every target inertia order divides e, since it acts freely on the complete étale ρ-fiber. A native determinant of degree N/e has an invariant rational section by Hilbert90. Orbit degrees have gcd N/ℓ for the stabilizer lcm ℓ. Thus N/ℓ divides N/e, while free étale fibers give ℓ dividing e. Therefore ℓ=e. Alternatively use the explicitly assumed ℓ=e in the degree-free version.

An attempted wild inertia forces e≥p. The normalized area is TWO/e. A genusONE coarse quotient would require total ramification contribution TWO/e≤TWO/p, whereas a wild contribution is strictly greater thanONE. Coarse genus at leastTWO forces e=ONE and no ramification. Hence the attempted wild quotient is rational automatically. A wild inertia of order i and first wild group order w has different at least i+p−TWO. Thus TWO wild values, or ONE wild plus TWO other values, already exceed area TWO/e. There are at mostTWO branch values and at mostONE wild value.

An automorphism with first breakONE acts on the Cartier fiber basis dt,t dt,…,t^(p−TWO)dt as a regular unipotent block of size p−ONE: the successive leading coefficients are TWO a,THREE a,…,(p−ONE)a, all nonzero. Every proper invariant subspace omits the zeroth evaluation. Therefore the assumed proper evaluating image forces first wild break at leastTWO, and its positive different sum \mathcal D is at least TWO(w−ONE).

If the wild value were ALONE, its inertia would be e=wh by the lcm. Hurwitz gives δ=TWO e+TWO and hence \mathcal D=wh+THREE. The actual local tame constraint h|\mathcal D forces h|THREE. Every positive ramification group is a p-group, so p≡ONE moduloFOUR gives \mathcal D≡ZERO and w≡ONE moduloFOUR. Thus h≡ONE moduloFOUR and h=ONE. But then \mathcal D=w+THREE<TWO(w−ONE), since w≥p>FIVE. Contradiction. Exactly ONE wild and ONE tame value must therefore occur, without assuming e even.

Write the inertia orders as wh and j, where p does not divide h j, and set g=gcd(h,j). The lcm gives e=whj/g. Rational quotient area gives
\[
j(\mathcal D-1)=wh+2g.
\]
The positive different sum is even. Taking TWO-adic valuations shows that h and j have identical TWO-parts. Set h=gH,j=gJ with coprime ODD H,J. General local tame ramification characters give h|\mathcal D, so
\[
H\mid J+2,\qquad J\mathcal D=wH+J+2.
\]
Because w≥p>FIVE, \mathcal D≥TWO(w−ONE)>w+THREE. This forces H>J; as H is an odd divisor of J+TWO, H=J+TWO. Consequently
\[
J\mathcal D=(w+1)(J+2).
\]
Each positive ramification group is a p-group, and p≡ONE moduloFOUR, so FOUR divides \mathcal D and w≡ONE moduloFOUR. The left side of the last identity is ZERO moduloFOUR and the right side TWO. Contradiction.

No simultaneous source closure or opposite endpoint descent is used.

## Version1 proof provenance

Version1 assumed EVEN e, rational quotient and ℓ=e at the outset, without the native degree condition. Its sole-wild step used the following valid shorter parity argument: i=e gives δ=TWO e+TWO, but δ=(e−ONE)+Σ_{a≥ONE}(|I_a|−ONE) is odd when e is even. Its remaining proper-fiber and two-branch residue argument is exactly the argument retained above. Version2 supplies ℓ=e from the native positive degree, proves rationality from Hurwitz, and replaces the parity step by h|THREE and the moduloFOUR constraint. All previously reviewed Version1 cases remain covered.
