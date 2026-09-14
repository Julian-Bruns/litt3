# Proof: effective probes recover the fields, then the common spin

[Statement](../../Theorems/cartier_and_spin/spin_probe_common_cover_reduction.md).
All field inclusions use the original embeddings into one common source.
Write g=g(X), m=p+2 and L_i for the original endpoint spins.

## 1. The probes and their étale trivializations

The unique point O at infinity on X satisfies

    θ=dx/y^(a−1),  div(θ)=2(g−1)O,  ord_O(x)=−a.

Thus A_0=O_X((g−1)O) is spin, with regular sections e_0 and xe_0,
where e_0²=θ. On Y choose e_Y∈H0(Y,A_Y) with e_Y²=η.

For each probe A on an endpoint, the line L_i A^−1 has a specified
square trivialization. Its μ_2-torsor is étale and identifies the two
spins compatibly with their squares. Trivialize the two probes A_0,A_Y
over Z and take a connected component V; then deg(V/Z)≤4. Adding a
third probe A' on X raises this bound to8. Both original maps stay
étale and their embedded fields still intersect in k.

## 2. An odd-degree separating probe

Assume a is odd. Put G=Gal(X/P1)=C_a. In Mumford's notation S(X) is
the set of theta characteristics, J_2=J(X)[2], and
e_*(A)=h0(X,A) mod2. The number with e_*=1 is

    2^(g−1)(2^g−1),

by [Mumford, Theta characteristics of an algebraic curve, §4, third theorem, pp190–191](https://www.numdam.org/article/ASENS_1971_4_4_2_181_0.pdf#page=11).
All these classes are effective.

For each prime ℓ|a, let H=C_ℓ. Its quotient has genus

    g_H=(a/ℓ−1)(deg F−1)/2 < g/3.

Since A_0 is H-invariant, the H-fixed part of S(X) is A_0·J_2^H.
Pullback and norm identify J_2^H with J(X/H)[2]: both composites
are multiplication by the odd number ℓ on invariant two-torsion.
Thus exactly2^(2g_H) theta classes are fixed by H.

Every nontrivial stabilizer contains one such H. The number of
prime divisors of a is at most g, and g−1≥a≥3 gives g≥4. Using
g≤2^(g−2), the union of their fixed classes has size

    ≤ sum_(prime ℓ|a) 2^(2g_H)
    < g·2^(2g/3) ≤ 2^(5g/3−2) < 2^(2g−2)
    < 2^(g−1)(2^g−1).

Choose an odd A' with trivial G-stabilizer and any nonzero section e'.
If σ∈G fixes e'²/θ, then σ(e'²) is a scalar multiple of e'² because
θ is a G-eigenform. Its half-divisor, and hence A', is σ-invariant.
Therefore the ratio has trivial stabilizer and

    k(x,e'²/θ)=k(X).                                  (1)

After the three torsors, take one Galois closure T→Y of V→Y.
The pulled-back spin has at least two sections. Its complete series
is base-point-free by
[the degree-one lemma](complete_section_quotients.md#2-global-generation-and-separability).
Let φ:T→S be its normalized image with image line M. All sections
descend, and the ratios x=(xe_0)/e_0 and e'²/θ=(e'/e_0)² put k(X)
in k(S) by(1). Both φ and S→X are therefore intermediate étale maps
of T→X. No separate separability argument is needed.

Bounded medium audit of the fixed-theta count and(1): PASS,
/root/audit_extension_fiber_scope,2026-09-14. This extends the original
prime-degree argument; its later geometric steps are unchanged.

## 3. The construction for any exponent

When k=bar(F_p), use only A_0,A_Y and the degree≤4 refinement.
The [eight-closure theorem](spin_series_etale_reduction.md) gives,
for every n≥8, a finite étale complete-series quotient φ:T_n→S
with all sections descending. This construction permits even a.

In both constructions the
[complete-section descent lemma](complete_section_quotients.md#3-descent-determined-by-complete-sections)
makes M a spin compatibly with L_T. Thus θ and xθ descend as regular
differentials. Their ratio gives x∈k(S), and if β is the descended θ,

    dx/β=y^(a−1),  F(x)/(dx/β)=y

inside k(T). Separability makes dx nonzero. This recovers k(X) for
the construction of this section as well.

## 4. Recover Y and the original common spin

The section e_Y descends to M, so η and Cartier(η) descend to S.
They span H0(Y,ω_Y), and
[Cartier endpoint recovery](cartier_endpoint_recovery.md) gives
k(Y)⊂k(S). Thus S→Y is intermediate étale too. The intersection of
the two endpoint fields is still k. Since T is Galois over one of
these endpoints, T→S is Galois.

The common tensor s_i=h_i² descends through both maps to the same
tensor on S, with divisor2D_S and D_S reduced. Its root normal form is

    L_S=O_S(D_S) ω_S^−((p+1)/2),

with the original common section h_S and compatible square. Hence
φ*L_S=L_T=φ*M. Source effectivity from
[spin primitives](spin_primitive_matching_defect.md) gives h0(S,L_S)>0.
The complete-section descent lemma now identifies L_S with M,
including the prescribed square; this removes any two-torsion ambiguity.

Finally M generates its own ratio field k(S), so its complete series
is birational and base-point-free. The
[normal-closure lemma](complete_section_quotients.md#1-normal-closure-and-the-projective-kernel)
preserves this in every restarted alternating tower.

For the stated family, the needed independence of η and Cartier(η)
for all six effective spins is proved in
[the torsion specialization](../jacobians/torsion/family_small_torsion_specialization.md).
