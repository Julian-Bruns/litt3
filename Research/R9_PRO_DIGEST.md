# R9 response digest —2026-09-08

Verdict: R9 still UNDECIDED. No actual higher-radical atlas was produced.
The exact modification/Hom description below is useful; the proposed
covector certificate is sufficient, not supplied by Frobenius.

## What is new and checked

Let G_s=ker(V->omega²|D_s), using the ACTUAL osculating quotient, not
the unrelated covector sigma_s. Then det G_s=O and H0(G_s)=0. The map

    T:G_s->V |-> tracefree((T tensor omega) * (multiplication by s))

gives an exact sequence 0->k i_s->Hom(G_s,V)->ker M_s->0. Locally
G_s=<ell,z^m n> in V=<ell,n>, so the inverse is (phi-rI)/s and works
on nonreduced D_s too. Kernel scalars cannot have poles, since the
osculating subline is a direct summand at every point. Thus the proof
does not need a rank-three or Frobenius hypothesis beyond the existing
definition of M_s. The evenness of Hom here uses the actual parity input.

For any saturated N in G_s, Hom(-,V) and Serre duality give the useful
general bounds

    h0(V N) <= h0(G_s^vee V) <= h0(V N)+h0(V N^-1),
    h0(V N)-h0(V N^-1)=2deg N.

If deg N=d>0, inclusion in V gives h0(V N^-1)>=1; evenness therefore
forces dim ker M_s>=2d+1. If N=O(-D) with D effective of degree e>0,
acyclicity gives h0(V N)=0 and h0(V N^-1)=2e, hence

    dim ker M_s <= 2e-1.

The Pro point certificate is exactly e=1. This parameterized version
can bound higher coranks without pretending every G_s has such a line.
The degree-zero variant with h0(V N)=h0(V N^-1)=1 also forces nullity1.

## Already available / not an extra breakthrough

The Frobenius sequence 0->omega³->F*V->omega²->0 and the resulting
5deg N<=2deg omega are already in semilinear_hermitian_lift /
tangent_bundle_cyclic_refinements / scalar_hermitian_reconstruction.
For genus9 they say deg N<=6. Do not count this again as new evidence.
Strong semistability of E3 does not imply semistability of G_s.

## Why the sufficient certificate is not yet a viable universal shortcut

For each point x, W_x=H0(V(x)) has dimension2. Under acyclicity its
principal-part evaluation V(x)|x is an isomorphism. Since
H0(omega(x))=H0(omega), factorization h_tau=s r first requires that
h_tau have no pole at x. This is ONE nonzero linear condition on W_x:
the residue covector must kill the osculating line at x. Thus there is
already a UNIQUE candidate line of tau for each x, up to scale.
One must still prove its surjectivity and that its resulting regular
quadratic is divisible by a member of the specified pencil.

Equivalently via the acyclic Bezout/Cauchy construction, that quadratic
is, up to the fixed local trivialization/sign, B_u applied to evaluation
at x in H0(omega²)^vee. Its being a product of two canonical forms is a
genuine restriction, not something a2-dimensional covector space ensures.
In genus9 such products have dimension at most16 in P23 (two projective
canonical8-spaces, modulo interchange); with the first factor in a
fixed pencil the dimension is at most9. This dimension observation is
NOT a nonexistence proof for actual Frobenius atlases; it explains why
the Pro sufficient certificate cannot simply be assumed to exist.

## Interaction with the current frontier

During the Pro run, the new selected-column inverse theorem emerged:
the FULL inverse system can be tested on three fixed multiplication-
spanning columns, for BOTH cohomology profiles. Its fresh bounded audit
has returned PASS. This avoids every pencil-corank stratification, so
R9 is no longer required by the most promising new A18 representation.
Do not make another Pro request merely restating its unproved certificate.

After integrating this digest, return to Sol_inverse_cup_atlas_system Section9
and ATLAS_REDESIGN. User also requested strategic/random combinations
of old degree5 pairs; queue a bounded diagnostic AFTER Pro processing,
prefer provenance-guided combinations rather than random redundant rows.
No new Pro question selected yet; one concurrency slot is now free.
