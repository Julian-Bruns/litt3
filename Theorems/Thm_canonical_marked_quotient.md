# Canonical quotients for reduced canonical markings

Let k be algebraically closed of characteristic p>=5, C a smooth
projective connected curve of genus g>=2, and s a nonzero section of
omega_C^d, for ANY integer d>=1, with div(s)=dD and D reduced.
Put c_p=4p/(p-4).

There is a canonical smooth proper effective DM curve S_s with a
representable finite etale atlas C -> S_s, carrying a descended tensor
beta, such that:

- The components of C x_(S_s) C are exactly all normalized jointly
  minimal bi-etale self-images with f*s=g*s. Their TOTAL degree is
  n=deg(C/S_s)<=c_p d(g-1).
- An actual tensor-preserving span between two such endpoint pairs of
  the same weight identifies their canonical quotients and descended
  tensors. Its jointly minimal image is a fiber-product component.
- G=Aut(S_s,k beta) is finite cyclic of order prime to p; its multiplier
  character is injective. All line-preserving self-images are exactly
  the components of the G-twisted fiber products. Their quotient is
  S_[s]=[S_s/G].
- Exact quotients are invariant under connected finite etale endpoint
  refinement. For every r>=1, S_(s^r)=[S_s/G[r]]. The line quotient is
  invariant under refinements, scalars, and ALL positive powers.
- A finite list of exact preserving self-images has a terminating
  normalized composition closure: with initial total degree b_0 and
  B=floor(c_p d(g-1)), at most B-b_0 new images can be added. There is
  a common finite etale Galois envelope of all exact self-images of
  degree at most (B-1)! over C. This envelope is a CONSEQUENCE of the
  finite relation, not an assumption for arbitrary spans.

Over k=Fbar_p, every reduced effective D of degree 2g-2 defines a
canonical quotient S_(C,D)=S_[s], independent of choices: omega_C(-D)
is torsion and supplies s. This quotient governs precisely the spans
preserving the actual pulled-back marking. Compatible marked endpoints
have the same quotient, hence a core. For fixed (C,D), only finitely
many marked partners of each fixed genus h exist. They are exactly
curve atlases Y -> S_(C,D) with the descended marking pulled back;
their atlas degree is (h-1)deg(C/S_(C,D))/(g-1).

Over a general algebraically closed field the marked formulation requires
omega_C(-D) torsion. No ordinary, Jacobian, Galois, or prime-to-p weight
hypothesis is used. Reducedness and degree 2g-2 are essential. An
arbitrary unmarked common cover is NOT known to supply such a marking.

Evidence: major audit PASS, `/root/canonical_marked_quotient_major_stress_test`,
2026-09-06; nonbreaking clarifications incorporated. The final finite-partner
corollary is the immediate fixed-index consequence added afterward.
[Proof](../Solutions/Sol_canonical_marked_quotient.md).
[Audit metadata and optional record](../routes/global/audits/CANONICAL_MARKED_QUOTIENT_MAJOR_STRESS_TEST_2026_09_06.md).
