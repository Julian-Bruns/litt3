# Strict spin growth and a base-point-free second closure

Let k=bar(F_p), p odd. Retain BOTH finite etale maps X<-Z->Y of smooth
projective curves of genus at least2, with compatible spin lines L_i
and sections h_i in K(C_i,L_i) having nonempty reduced divisors, as in
spin_cartier_root_normal_form. Suppose the actual embedded endpoint
fields intersect in k. Put Z_0=Z, and form Z_1 by Galois closure over X,
Z_2 by Galois closure over Y, and continue alternating, keeping embeddings.
All these are actual connected finite etale covers of BOTH endpoints.
Write L_n for the pulled-back spin and r_n=h0(Z_n,L_n). Then:

1. r_0>=1 and r_(n+1)>r_n for every n>=1. In particular r_n>=n
   for n>=1. The same conclusion holds with the endpoints interchanged.
2. If g(Y)=2, L_2 is globally generated. Every subsequent L_n is also
   globally generated. This is a consequence at TWO closure steps, not
   a conjectured eventual stabilization.

More generally, the strict-growth implication whenever r_n>0 only needs
compatible line bundles L_i and an invariant section h_i of L_i^m,
m>=2, whose divisor has a coefficient not divisible by m. It does not
need a Cartier operator, a cyclic root cover, or ordinarity. The spin
primitive theorem supplies the initial nonzero section in the case above.

No upper bound on r_n or on the genera is asserted. Normality alternates;
no finite cover normal over both endpoints is assumed. Globally generated
spin lines occur on large ordinary etale covers of our genus-two family,
so neither conclusion alone excludes the putative common cover.

Version1,2026-09-08. Fresh medium audit PASS, /root/audit_spin_growth_boundary,
2026-09-08; no objections. Not formally verified.
[Audit record](../../Research/audits/SPIN_GROWTH_BOUNDARY_AUDIT_2026_09_08.md).
The strict spin-growth argument was supplied by the user's Pro response;
root generalized its finite-dimensional argument and added assertion2.
[Proof](../../Proofs/cartier_and_spin/alternating_spin_growth.md).
