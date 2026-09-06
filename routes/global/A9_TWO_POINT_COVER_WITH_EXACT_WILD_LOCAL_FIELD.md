# A two-point cover from A9 with the exact prescribed wild local field

Date: 2026-09-05.  Author: Codex, `wild_two_point_disjoint_cover_boundary`.

Status: **PASS** independent primary-source and local proof audit,
/root/a9_local_realization_independent_audit, 2026-09-05.
No breaking objection; global-versus-inertia transitivity clarified below.
[Audit record](audits/A9_EXACT_LOCAL_REALIZATION_AUDIT_2026_09_05.md),
for investigating doubts rather than routine reading.

Primary source: Jeremy Muskat and Rachel Pries, *Alternating group covers of the
affine line*, Israel J. Math. 187 (2012), 117–139, Notation 4.7 and Theorem 4.9,
[author preprint, §4.3](https://arxiv.org/pdf/0908.2140#page=15).

## Existence lemma

Let k be algebraically closed of characteristic 5. There is a finite connected
Galois cover R → P¹_x, branched exactly at 0 and infinity, with tame index 16
at 0 and with completed local Galois extension at infinity exactly isomorphic,
over k((x⁻¹)), to

\[
x=t^4,\qquad v^5-v=-t^9.
\]

Its global Galois group Γ has a normal abelian 2-subgroup N of exponent dividing
16 with Γ/N ≅ A9. In particular Γ has no quotient AGL₁(5).

### 1. The A9 cover and numerical local data

Let K/k(x) be the splitting field of

\[
Y^9-xY^4+1.
\]

The cited theorem applies with p=5 and s=4: its assumptions are 2≤s<p, with
an exception only when (p,s)=(7,2). It gives Galois group A9, branching only
at infinity, inertia order

\[
5\frac{(5-1)4}{\gcd(4,4(4+1))}=20,
\]

and upper jump (5+4)/(5−1)=9/4. Thus the lower jump is 9. The inertia is the
faithful semidirect product C5 ⋊ C4 (the prime-to-5 central factor in the
theorem's proof has order gcd(9,4)=1).

### 2. Exact local identification by the order-nine symmetry

This step is an additional argument, not a conclusion asserted in Theorem 4.9.
For a primitive ninth root ζ, the transformation

\[
x\longmapsto\zeta^5x,\qquad Y\longmapsto\zeta Y
\]

preserves the equation. The splitting field is consequently stable under
the cyclic base extension k(x)/k(x⁹), and K/k(x⁹) is Galois. At a chosen point
above infinity its decomposition group D fits into

\[
1\longrightarrow I_{20}\longrightarrow D\longrightarrow C_9\longrightarrow1.
\]

Surjectivity on the right follows because A9 acts transitively on the points
above infinity. A Sylow 3-subgroup of D has order 9 and maps isomorphically to
C9. It centralizes the characteristic wild subgroup C5 of I20: conjugation
would otherwise give a nontrivial homomorphism C9 → Aut(C5)=C4.

The tame intermediate local field is k((t⁻¹)), with t⁴=x. The order-nine
action sends t to βt with β primitive of order 9: its fourth power acts on
x through a primitive ninth root, and the action itself has order 9.
Since this action centralizes C5, it fixes the Artin–Schreier class defining
the remaining cyclic extension. The unique reduced representative of that
class is a polynomial in t with exponents j satisfying 1≤j≤9 and 5∤j;
constants and the power-series part can be removed over algebraically closed k.
Invariance under t ↦ βt forces 9|j. Hence that representative is a t⁹ for
some a≠0.

Choose d∈k× with d⁹=−a and replace (t,x) by (dt,d⁴x). Then the completed
extension has exactly the equations in the lemma. Only a constant scaling of
the global coordinate was used; 0 and infinity are preserved. Rename this
coordinate x. The different exponent is (20−1)+9(5−1)=55.

### 3. Add tame index 16 without changing the wild completion

Let Z be the smooth projective curve with function field K, and let B be its
reduced fiber over 0. Since Z → P¹ is unramified there,

\[
\deg B=|A_9|=181440=16\cdot11340.
\]

Multiplication by 16 on Pic⁰(Z) is surjective. Consequently there is a divisor
E with 16E linearly equivalent to B. Choose f∈K× such that

\[
\operatorname{div}(f)=B-16E.
\]

The cyclic Kummer extension K(w)/K, w¹⁶=f, is connected and has tame index 16
at each point of B, and is unramified elsewhere. Connectivity and full index
follow from the valuations being congruent to 1 modulo 16 at B.

Let M be its Galois closure over k(x), and let R be the corresponding smooth
projective curve. Since K/k(x) is Galois and contains μ16, M/K is the
compositum of the conjugate Kummer extensions. Its Galois group N embeds in a
product of copies of C16. Thus N is abelian of exponent dividing 16, and

\[
1\longrightarrow N\longrightarrow\operatorname{Gal}(M/k(x))
\longrightarrow A_9\longrightarrow1.
\]

At 0 the local compositum still has index 16: over a complete local field
with algebraically closed residue field there is a unique tame extension of
degree 16 in a fixed separable closure. Away from B the Kummer extensions
are locally trivial over K, because an unramified extension of these local
fields is trivial. In particular the completion at infinity is unchanged.
There are no additional branch points.

### 4. Excluding the affine degree-twenty quotient

AGL₁(5)=C5 ⋊ C4 has no nontrivial normal 2-subgroup. Indeed any such subgroup
would commute with its normal C5, whereas the centralizer of C5 is C5 itself.
A surjection Γ → AGL₁(5) would therefore kill N and factor through A9, which
is impossible. This proves the lemma.

## Scope of the disjointness conclusion

The full-fiber construction proves the stated absence of an AGL₁(5)
quotient; it does not assert full disjointness from the degree-twenty cover,
whose proper quadratic or quartic subfields require separate consideration.
For a degree-five non-Galois leg with that normal closure, the needed
linear disjointness from M follows: the normal subgroup obtained after
Galois base extension has equally sized orbits on the five embeddings.
These orbits have size 5 or 1. Size 1 would put the entire normal closure in
M, contradicting the absence of the degree-twenty quotient.
