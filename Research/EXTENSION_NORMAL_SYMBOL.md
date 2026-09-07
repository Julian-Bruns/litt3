# A quadratic symbol for the actual normal-space test

2026-09-07. Uses `extension_fiber_geometry` and the scalar dormant Bol
complex. This is NOT a proof of transversality at every admissible point,
nor an atlas exclusion. The explicit transport was checked at one exact
point for the first saved genus-nine oper.

Use delta^2 U=P U, and h in ker(Q:L64->S_U), where
Q=delta^3+P delta+3 delta(P). Define

    B_U(h)=U^2 delta^2(h)/2-U delta(U) delta(h)
             +((delta(U))^2-P U^2)h.                       (1)

Direct differentiation gives delta B_U(h)=0 using Qh=0. The initial
pole bound is322; since it is a fifth power in the function field its
pole order is a multiple of5 and hence at most320. It is affine regular,
so B_U(h)=f^5 for a unique f in L64. No truncation argument is required.

For a horizontal basis u0,v0 with Wh(u0,v0)=1, write
U=d u0+e v0 and h=a u0^2+b u0 v0+c v0^2 over K^5. Formula(1) gives

    B_U(h)=a e^2-b d e+c d^2.

This is the scalar Frobenius realization of the determinant contraction
phi |-> det(u,phi(u)), up to the fixed nonzero sign in the standard
Sym^2 W = End_0 W identification. It supplies a QUADRATIC matrix in U
for the normal-space map, not a derivative of an expanded degree46
polynomial.

Let V(U) be the56x24 coefficients of B_U(h_j) in the monomial FIFTH
POWERS m_l^5, for a basis h_j of ker Q. With the stored residue matrix S,

    Normal(U)=V(U)^T (S^[5])^T,       Project(U)=Qc^[5] V(U).

Here Qc is the scalar Q-coordinate matrix. The coefficient fifth powers
on Qc and S are essential; applying ordinary Q directly to B_U(h)
would be wrong. At an admissible weak point, the exact transversality
test is rank Project(U)=24. A kernel of dimension d gives weak tangent
dimension7+d, by the general theorem.

The verifier reproduces all24 polynomial fifth-power identities at the
saved point, checks both ranks24, and verifies

    ker Normal(U) = image of d(e/Delta)_U,
    Project(U)=(Bc^[5])^T Normal(U)^T.

The derivative is independently obtained from the original64-row pencil
and its Wronskian normalization. The point is NOT in the weak incidence,
so this does not certify transversality on that incidence. This limitation
is deliberate. Reproduce using

    sage scripts/extension_normal_symbol.sage

[Exact result](computations/extension_normal_symbol.json). A future use
must prove all-point rank conditions or retain the rank-drop strata.
