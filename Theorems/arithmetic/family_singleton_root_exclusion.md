# No singleton Cartier-zero root in the ordinary parameter family

Let k be algebraically closed of characteristic five, t in k with t^5-t!=0,
and C=C_t the smooth projective model of

    v^2=u(u-1)(u-2)(u-3)(u-t), O=infinity.

Write J=Pic^0(C), J1=Pic^0(C^(1)), V=F_C^*:J1->J and
B_C=coker(O_(C^(1))->F_(C*)O_C). Then:

1. No non-Weierstrass P and no M in J1(k) satisfy BOTH

       V(M)=[2P-2O], H^0(C^(1),B_C tensor M)!=0.

   Equivalently, there are no such P, effective degree-two D and rational
   h with div(h)=5D-2P-8O and Cartier((du/v)/h)=0.

2. For every n prime to five, there is no nonzero canonical tensor s
   with div(s)=2nP whose tautological differential on its actual normalized
   etale nth-root cover is Cartier-zero. Here P is arbitrary, including
   Weierstrass points. Disconnected root torsors are allowed.

3. More precisely, on the connected degree25 etale curve

       T=C x_([2]Abel,J,V) J1,

   the explicit Raynaud Kummer quadric Q_t defines a divisor of degree160.
   Its support is exactly the144 points (W,N), W Weierstrass and
   0!=N in ker V. Put tau=t^5, lambda^2=t+1 and

       M=[(tau,0)+(t,(t-tau)/(2lambda))-2O1].

   The multiplicities of THIS QUADRIC divisor are four at (W_t,+/-M),
   two at (W,+/-M) for the other five W, and one at the other132 points.
   No multiplicity identification with the Raynaud determinant is assumed.

In particular, an actual coreless bi-etale span with endpoint C_t cannot
have a singleton clump image there in the Cartier-zero branch. No bound
on larger clumps, clump-existence theorem, or exclusion of coreless spans
is asserted. The result applies to high-prime-degree family members in
bounded_atlas_partner_finiteness, but does not complete that counterexample.

Version1,2026-09-08. AUDITED PROSE, PASS by
/root/audit_family_singleton_medium,2026-09-08.
Proof supplied by the user's Pro response; root independently replayed all
twelve exact polynomial identities and checked the intersection argument.
[Audit verdict and scope](../../Research/audits/FAMILY_SINGLETON_ROOT_EXCLUSION_AUDIT_2026_09_08.md).
[Proof](../../Solutions/arithmetic/family_singleton_root_exclusion.md).
