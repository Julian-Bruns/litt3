# Effective spin probes retain both endpoints in the complete-series quotient

Version2,2026-09-14. Let k be algebraically closed of odd characteristic
p, and let X←Z→Y be an actual coreless finite étale spin-Cartier span
with compatible nonzero reduced sections h_X,h_Y as in
[the root normal form](spin_cartier_root_normal_form.md). Assume

    X: y^a=F(x),  a≥2,  p∤a,  F squarefree,
    gcd(a,deg F)=1,  g(X)−1≥a,

and Y has genus2 with an effective spin A_Y whose section square η
and Cartier(η) are independent. The original endpoint spins may be
ineffective. These hypotheses include the fixed degree-ten trigonal X
and the characteristic-five family C_t with t^5−t≠0.

There is an endpoint-preserving refinement whose complete spin quotient
φ:T→S is finite étale Galois. Both original maps factor through S, and
S→X,Y remain finite étale and coreless. The original common spin and h
descend to S and agree with the image spin M. Moreover

    H0(S,M)=H0(T,L_T),

so the complete spin series on S is base-point-free and birational.
These properties persist under subsequent alternating normal closures.

The constructions have the following bounds.

- If a is odd, a connected étale refinement V→Z of degree≤8 followed
  by one Galois closure T→Y suffices, over every such k.
- For any a, if k=bar(F_p), a refinement V→Z of degree≤4 suffices
  before alternating normal closures over X and Y. The conclusion
  holds for every resulting T_n with n≥8.

The odd-degree argument uses an effective spin A' such that, for
A_0=O_X((g(X)−1)O), e_0²=θ=dx/y^(a−1), and 0≠e'∈H0(X,A'),

    k(x,e'²/θ)=k(X).

Such A' exists for every odd a, including composite degrees.

The bounds concern the initial refinement and number of closures.
They do not bound the final degree or exclude a common cover.

[Proof](../../Proofs/cartier_and_spin/spin_probe_common_cover_reduction.md).
The original [eight-closure](../../Research/audits/SPIN_PROBE_COMMON_COVER_REDUCTION_AUDIT_2026_09_08.md)
and [one-closure](../../Research/audits/PRIME_SPIN_PROBE_REDUCTION_AUDIT_2026_09_08.md)
audits are retained; the odd-composite extension has a bounded medium
audit recorded in the proof.
