# The complete spin map is etale after eight alternating closures

Use the hypotheses and tower of alternating_spin_growth over bar(F_p),
with p odd, g(Y)=2, and h_i in K(C_i,L_i) with nonempty reduced divisors.
The actual span is coreless. No ordinarity assumption is needed.

For n>=2, let phi_n:Z_n->S_n be the complete spin-series map to the
smooth model of its ratio field, and let M_n be its image line. Then:

1. Every phi_n is separable. The inclusions of ratio fields give finite
   separable maps S_(n+1)->S_n and pull back M_n to M_(n+1).
2. g(S_5)>=2, and g(S_n) tends to infinity.
3. Every phi_n with n>=8 is finite ETALE. For those n, M_n is a spin
   line, compatibly with phi_n^*M_n=L_n. Moreover pullback gives the
   entire space of spin sections: H0(S_n,M_n)=H0(Z_n,L_n).

Thus, after a bounded number of closure operations, the section-defined
quotients are genuine etale spin quotients of hyperbolic curves, not
ramified maps to rational or elliptic curves. The integer8 bounds tower
steps only; it does not bound their cover degrees or computational cost.

This statement alone does not assert descent of the endpoint fields
or h_n. Under additional endpoint hypotheses,
[effective spin probes](spin_probe_common_cover_reduction.md) give both
after a bounded refinement. Neither result excludes the original span.

Version1,2026-09-08. Fresh medium audit PASS, /root/audit_eight_closure_spin_reduction,
2026-09-08. No mathematical objection; inverse-isomorphism wording clarified.
[Audit record](../../Research/audits/EIGHT_CLOSURE_SPIN_REDUCTION_AUDIT_2026_09_08.md).
[Definitions](../../Definitions/spin_cartier_roots.md) ·
[Proof](../../Proofs/cartier_and_spin/spin_series_etale_reduction.md).
