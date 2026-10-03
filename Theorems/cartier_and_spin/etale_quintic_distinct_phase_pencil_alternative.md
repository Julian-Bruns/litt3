# Etale quintic distinct-phase pencil alternative

Version 1. 2 October2026. [Focused whole-argument review](../../Research/audits/DISTINCT_PHASE_QUINTIC_PENCIL_AUDIT_2026_10_02.md) PASS.

Let k be algebraically closed of characteristic5. Let pi:T->S be an
actual connected finite etale map of degree5 between smooth projective
curves, and let H be a line bundle of degree m>0 on S. Suppose an
original section a of pi^*H is primitive over k(S), has reduced zeros,
and has exactly two zeros above each point of a reduced divisor D0,
with no other zeros. Write its monic polynomial in a local H-frame as
F(Z)=Z^5+c1 Z^4+c2 Z^3+c3 Z^2+c4 Z+c5,
where cj is a global section of H^j.

Assume at every Q in D0 that the ratio of its two zero sections is
c+O(w^2), up to inversion, for the SAME c in mu29 minus{1}, and that
the three nonzero values belong to one mu3 orbit. Their multiplicities
need not initially be balanced. Put K=c+c^-1+2 and
s=K c3 c5-c4^2. Then m is even and exactly one of the following
coefficient alternatives applies.

1. If s!=0, or if s=0 and c1!=0, the actual S has a separating
   pencil of degree at most5m/2.
2. If s=c1=0, then8 divides m. There is a line L with L^2=H and
   sections p of L^3 and q0 of L^5 with disjoint zero divisors D3,D0,
   respectively, such that deg D3=3m/2. With kappa^2=K, the ORIGINAL
   map pi is the degree-five pullback by the separating function
   f=q0^3/p^5 of the rational map
   R:P1_b->P1_f, f=-(b^2+kappa b+1)/b^5,
   where b=a p/q0 on T. Every multiplicity in D3 is divisible by4.

In alternative2 the rational map R has local splitting-field inertia
F20, ramification index20 and different23 at its wild branch. Its
other inertia groups are C3 and C2; its global group is S5 and its
Galois closure has genus20. These assertions concern R. Neither the
monodromy of pi nor etaleness of a source map to that auxiliary
genus-twenty curve is asserted.

If the actual source also satisfies omega_S=H^16, then in the
nonzero-s branch there is an effective divisor DB of degree m/2 with
B=O(DB), B^2=H and omega_S=B^32, and the separating function has
divisor D0-5DB. If an ORIGINAL etale map q:S->Y of degree8m to a
genus-two curve is retained, then32[Nm_q(DB)-(m/2)O]=0 in J(Y),
for any Weierstrass O. For m=2, alternative2 is impossible and the
actual S has a separating pencil of degree3,4 or5; in the nonzero-s
branch DB=P and the exhibited degree is5 or4 according as P is
outside or inside D0.

The phase and orbit hypotheses are additional source conditions. This
does not extract them from an arbitrary unmarked common cover, recover
the original X-field, or exclude all sources of low gonality.

Proof: [canonical proof](../../Proofs/cartier_and_spin/etale_quintic_distinct_phase_pencil_alternative.md).
