# A rigid active span has one forced canonical endpoint at every Witt level

Version1,2026-09-09. Focused medium audit PASS,
/root/audit_forced_canonical_witt; inherited inputs not re-audited.

Let k=bar(F5), W=W(k), and let X<-f-Z-g->Y be two ACTUAL finite etale
maps of smooth projective connected curves of genus at least two.
Suppose regular admissible ACTIVE nilpotent projective connections
r_X,r_Y have equal pullbacks r_Z, that r_Y is indigenous-ordinary, and
that

    f*H^1(X,T_X) intersect g*H^1(Y,T_Y)=0 in H^1(Z,T_Z).       (J)

Use marked deformations and the Frobenius convention of
[the canonical W2 dictionary](admissible_two_leg_w2_lifts.md).
Let Y^can/W be the canonical lift of (Y,r_Y).

1. For EVERY N>=2, any simultaneous marked W_N lift of the two curve
   maps has Y-endpoint isomorphic to Y^can modulo5^N. Its source is
   consequently the unique lift of the ORIGINAL g-cover to that fixed
   Y-endpoint. This is a necessity for EXISTING diagrams, not a claim
   that one exists at each N.

2. Such a diagram automatically carries compatible projective maximal-
   Higgs / filtered inverse-Cartier data through W_(N-1), lifting the
   given mod-five data. The original Hodge lines lift uniquely at each
   step. This conclusion does not assume that connections were included
   among the data of the given curve deformation.

3. The entire marked deformation functor equals its subfunctor with
   Y fixed to Y^can. Its ring is W/(5^e), e>=2 or infinity, by(J) and
   the existing deformation-ring theorem. Neither e>=3 nor e=infinity
   is proved here. No full lift of a connection on a last W_e curve
   is asserted: the inverse-Cartier data are constructed one level lower.

For a coreless span with g(Y)=2, condition(J) follows from the canonical
W2 lift and [two-leg negative extensions](two_leg_negative_extensions.md).
Thus the result applies to the active branch for BOTH choices of
endpoints. It does not need Hom(J_X,J_Y)=0, a restriction on map degrees,
ordinary J(Y), or ordinariness of r_X or r_Z.

## The remaining obstruction at each reached level

Put V_C=H^1(C,T_C), A=f*V_X, B=g*V_Y and Q=V_Z/(A+B).
Let Psi_C be the Frobenius-semilinear Hodge-obstruction variation map
of r_C, with its twists retained; Psi_Y is bijective. It preserves the
two pulled-back endpoint subspaces and gives barPsi on Q.
If a simultaneous diagram has reached W_n, n>=2, its obstruction to
W_(n+1) satisfies

                  o_(n+1) in ker(barPsi).                 (K)

The original maps extend exactly when o_(n+1)=0. Once(K) is known,
membership in the stable image of barPsi is EQUIVALENT to that
vanishing; it is not a weaker missing lemma.

More explicitly, after linearizing Frobenius, there is a natural exact
sequence of kernels and cokernels

    0 -> ker Psi_X -> ker Psi_Z -> ker barPsi
      -> coker Psi_X -> coker Psi_Z -> coker barPsi -> 0.   (S)

This uses(J), individual negative-H1 pullback injectivity, and
bijectivity of Psi_Y. Thus endpoint obstruction and extra source-kernel
directions are both retained. If Psi_X is also bijective, the residual
space ker barPsi is isomorphic to ker Psi_Z, not automatically zero.

[Proof and precise induction](../../Proofs/deformations/forced_canonical_witt_endpoint.md) ·
[Scoped audit](../../Research/audits/FORCED_CANONICAL_WITT_ENDPOINT_AUDIT_2026_09_09.md).
