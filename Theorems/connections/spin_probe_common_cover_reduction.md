# Both endpoints survive the complete spin quotient after a double-cover refinement

Work over k=bar(F_p), p odd. Let

    X: y^a=F(x),  gcd(a,deg F)=1,  p does not divide a,

where F is squarefree, g(X)>=2, and g(X)-1>=a. Let Y be a genus-two
curve having an effective spin L_0=O(W) such that the square eta of its
nonzero section and Cartier(eta) are independent. In particular, in
characteristic five these conditions hold for ANY squarefree degree-ten
trigonal X and for Y=C_t, t^5-t!=0.

Suppose there is an ACTUAL coreless bi-etale spin-Cartier span

    X <- Z -> Y

as in spin_cartier_root_normal_form: compatible spin lines L_i and
compatible h_i in K(C_i,L_i), with nonempty reduced zero divisors.
No effectiveness of either endpoint spin is assumed.

There is a connected finite etale refinement V->Z of degree at most4.
Starting at T_0=V, alternate Galois closure over X and Y, keeping the
original embedded fields. For EVERY n>=8, the complete spin-series map

    phi_n:T_n -> S_n

is finite etale, and BOTH original maps factor through it. The resulting
maps S_n->X,Y are finite etale and still coreless. Moreover:

1. The canonical common spin and h descend to S_n and agree, compatibly,
   with the image spin M_n supplied by spin_series_etale_reduction.
2. Pullback H0(S_n,M_n)->H0(T_n,L_n) is an isomorphism. The COMPLETE
   spin series on S_n is base-point-free and birational onto its image.

Thus the entire weight-(p+2), reduced-double-zero case can be studied
on actual common sources with birational, base-point-free complete spin
series, retaining BOTH legs and the original shared tensor. The bound4
is on the initial refinement only; eight bounds closure steps, not degree.

This is NOT a nonexistence theorem. It gives no upper bound on g(S_n)
or the cover degrees, and does not address other weights or no-clump spans.
It bypasses the need to recover an ineffective endpoint spin at every
arbitrary unrefined Galois cover.

Version1,2026-09-08. Fresh medium audit PASS, /root/audit_spin_probe_reduction,
2026-09-08; no objections or revisions requested. Not Lean verified.
[Audit record](../../Research/audits/SPIN_PROBE_COMMON_COVER_REDUCTION_AUDIT_2026_09_08.md).
[Proof](../../Solutions/connections/spin_probe_common_cover_reduction.md).
