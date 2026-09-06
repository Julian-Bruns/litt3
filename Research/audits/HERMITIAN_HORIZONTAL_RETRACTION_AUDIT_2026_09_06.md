# Intrinsic horizontal retraction audit

Verdict: PASS. Auditor: /root/horizontal_retraction_audit.
Date: 2026-09-06. Fresh bounded prose audit; no formal verification.

Scope: proposed strengthening of `semilinear_hermitian_lift`, for every
smooth projective connected curve over algebraically closed k of
characteristic five, g>=2, 5 not dividing kappa=2g-2, with FIXED
(V,pi,j) and M=omega^2 tensor tau, tau^3=O as in that theorem.
This includes its torsion twists. No atlas exclusion or common-cover
solution is asserted. The upstream atlas criterion was used as a
dependency, not re-audited.

Put N=M^-1 and W=K tensor M^-1, identified via j with F^*(V^vee).
Transport its canonical connection. The quotient of N in W is
L=omega^-1 tensor M^-1, so L tensor omega=N. The second fundamental
map is an O-linear global endomorphism b of N, hence a scalar.
If b=0 the connection preserves N; its restriction has zero p-curvature.
Cartier descent gives N as a Frobenius pullback line bundle, forcing
5 to divide deg N=-2 kappa, a contradiction. Thus b is invertible.
The degree assertion works equally for nontrivial degree-zero tau.
Reference: Katz, *Nilpotent connections and the monodromy theorem*,
[Theorem 5.1, pp. 190–191](https://web.math.princeton.edu/~nmk/old/nilpconn.pdf).

The operator P=b^-1(q tensor 1)nabla:W->N is k-linear and commutes
with restriction, though it is not O-linear. It satisfies P i=id.
It therefore induces a k-linear map H1(W)->H1(N) splitting i.
One can compute this directly on an affine Cech cover: differential
operators commute with its differential, and affine intersections are
acyclic for the underlying quasicoherent bundles. No O-linear splitting
of the nonsplit bundle extension is being asserted.

The natural additive, five-semilinear sheaf map V^vee->F^*(V^vee)
has horizontal image. In local splittings, dualizing an extension
negates its extension cocycle, and Frobenius raises its coefficients to
the fifth powers in pulled-back frames. Thus after cancelling the M
twist, D(alpha) represents -F^*(alpha) and has horizontal Cech
representatives. Transport through j agrees with the connection just
defined. Consequently P_* j^-1_* D(alpha)=0 for EVERY alpha, including
alpha_0 and pi^*lambda. The sign does not affect this vanishing.

Applying P_* to i(lambda)-T_j(lambda)=b0 forces the unique candidate
lambda=P_*b0=-P_*xi0. Its sufficiency is exactly the remaining test
b0-i(lambda)+T_j(lambda)=0, which lies in ker P_* of dimension
12(g-1)-5(g-1)=7(g-1). No lower-block rank hypothesis is needed.
Changing xi0 by i(mu) changes b0 by T_j(mu)-i(mu), and changes this
candidate by -mu, preserving the lifted extension and solvability.
The operator is canonical for the prescribed data; independence of
arbitrary changes to the prescribed j or pi is not claimed.

The full semilinear rank bound <=4g-5 remains valid: stability of V
gives H0(V^vee)=0; the dual extension injects the g-dimensional
H0(omega) as ker(pi^*:H1(M^-1)->H1(V^vee)). Frobenius cannot increase
that rank over perfect k. This bound is additional information, not
a hypothesis of the retraction.

No material objections. State explicitly that cohomology uses the
underlying sheaves of k-vector spaces, that the connection is transported
through j after removing M, and that all conclusions concern fixed
marked data. Extension to varying nonreduced parameter bases would
require a separate relative construction and is outside this audit.
