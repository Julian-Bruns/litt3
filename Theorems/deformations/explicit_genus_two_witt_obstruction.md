# A genuine one-endpoint W3 obstruction on an ordinary-Jacobian curve

Version1,2026-09-10. Pro calculation, locally reproduced and focused
medium audit PASS /root/audit_explicit_w3_obstruction. Not Lean verified.

Use the explicit genus-two/F625 pair of
[critical quartics, version2](../projective_connections/genus_two_active_critical_quartics.md):

    t^4+4t^3+t^2+4t+3=0,
    C: v^2=F=u(u-1)(u-2)(u-3)(u-t),
    P=2u^3+(2t+3)u^2+(3t^2+3)u+2t^3+4t^2+4t+4,
    r=2(F'/F)^2-F''/F+P/F.

This pair is admissible and active, with ordinary Jacobian, a nonsplit
canonical double, and a one-dimensional Hodge kernel (defect one).
This does not mean its Fitting nilpotent subspace is one-dimensional.
With the
[canonical first lift and higher obstruction](../../Definitions/witt_hodge_obstruction.md),

    epsilon(C,r) != 0.

Precisely, put eta=du/v, z=u^2/v and
phi=(u^2+(t+3)u+2t^2+4)eta^2. In the Cech orientation of the proof,

    <rho,phi>=3+4t+4t^2+3t^3=(4+4t)^(-1).

Consequently NO marked W3 lift of its canonical C2 lifts the original
Hodge line in higher inverse Cartier. The curve alone lifts; this is
not a counterexample to curve lifting.

## Transfer to actual covers

For any actual finite etale h:T->C of admissible active pairs,
epsilon(T,h*r)=h*epsilon(C,r). If 5 does not divide deg(h), this map
on Frobenius cokernels is injective.

Thus if C<-h-T-j->B is an actual matched finite etale span, with
indigenous-ordinary r_B and h*r=j*r_B, then 5 divides deg(h).
This consequence holds for ANY endpoint with nonzero epsilon, not
only the displayed pair. No corelessness or Jacobian hypothesis is needed.

The theorem does not construct a common cover, replace the fixed main
endpoints, or evaluate epsilon for their connections. It refutes a
universal assertion that every admissible active pair has a compatible
one-endpoint W3 lift. The two-leg source-kernel mismatch remains separate.

[Proof and executable certificate](../../Proofs/deformations/explicit_genus_two_witt_obstruction.md).
