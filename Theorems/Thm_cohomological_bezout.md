# Small quadratic resultant matrices, including nonacyclic bundles

Use `cohomological_bezout`. There is an explicitly Cech-constructible
(n+r)x(n+r) polynomial matrix

    D(u) = [ B(u)  q(u) ] : H1(T) + H0(V) -> H0(M) + H1(V),
           [ a(u)    0  ]

where B is homogeneous quadratic, q=H0(b_u) and a=H1(a_u) are linear.
For EVERY nonzero section u,

    corank D(u) = deg D_u.

In particular det D is, up to a nonzero constant, the reduced irreducible
resultant of V tensor T^-1, of degree2n. All zeros, including repeated
zeros at any point of the projective curve, are retained. No characteristic
restriction or acyclicity assumption on V is required.

If r=0, B is canonical and B(u)=K(eta_u)^-1 on admissible sections.
If also det V=omega, identify H1(T)=H0(M)^vee by Serre duality;
then B is symmetric. If the linear cup map K:E->Hom(H0(M),H1(T)) is
injective, the normalized extension class is recovered from B(u)^-1
by one fixed linear left inverse. Equivalently adj B gives a homogeneous
polynomial extension representative of degree2n-2, without expanding det B.

For the chosen genus-nine curve take V=W(8O), T=omega^-1, M=omega^2.
Then n=24. The28935 simple opers have r=0 and therefore symmetric24x24
quadratic matrices. The55 invariant opers have r=3 and27x27 block matrices
of the displayed form. Each determinant has degree48. This follows from
the tangent/horizontal-section identification and the complete enumeration,
not from assuming that every oper is acyclic.

For the first new F25 oper, the24x24 tensor is computed exactly in
`Research/computations/wronskian_quadratic_bezout.json`. In scalar Frobenius
coordinates the identity reads B(U) K(eta_u)^[5]=I. Along the full saved
line its determinant equals(4a+1)Delta. No atlas emptiness is asserted.

Status: proved, independent bounded audit PASS. Auditor:
cohomological_bezout_major_audit,2026-09-07. No blocking objections.
Qualification: the exceptional r=3 uses the explicit invariant tangent-rank
calculation, not merely the local multiplicity8.
[Audit reference](../Research/audits/COHOMOLOGICAL_BEZOUT_AUDIT_2026_09_07.md).
[Proof](../Solutions/Sol_cohomological_bezout.md).
