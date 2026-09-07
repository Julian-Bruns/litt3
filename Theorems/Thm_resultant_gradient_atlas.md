# The Hermitian atlas obstruction is the gradient of a resultant

Fix any geometric oper in `dormant_differential_projection`. Let A=S_U,
E=P48, J=Ann ker(Q:L64->A), and identify J with A* by

    i(Y)(Qh)=Res_O(Y h theta).

Let e(U) in E^[5] be the primitive homogeneous kernel vector of N_U,
of degree46, unique up to constant. Define the polynomials

    T(U)=-aff(U e(U)),
    Delta(U)=Wh(U,T(U)),               degree48,
    B(U)=R_U e(U) in J,                degree47.

Then Delta is a nonzero constant multiple of the REDUCED resultant of
the rank-two section space W(24O). Its nonvanishing is exactly the locus
of admissible quotients, including both pole111 and pole112 charts. One has
the GLOBAL polynomial identity

    i(B(U))=-dDelta(U).                                      (1)

In particular i(B(U))(U)=2Delta(U). Thus B is never zero when Delta!=0.

The actual untwisted atlas equation is equivalently

    B(U)^[5]=Delta(U)^4 e(U),      Delta(U)!=0.               (2)

This retains every quotient direction and its scale. Projectively, some
scale works precisely when B(U)^[5] and e(U) are proportional; both are
automatically nonzero on this open set. Exactly three scales then work.
The older nonzero-R-output proviso is therefore automatic here.

At any normalized atlas eta=B/Delta, one also has the quadratic identity

    i(eta)(U)=2.                                            (3)

Equation (2) is NOT proved empty. This result neither excludes an entire
oper nor settles the other cored/twisted/coreless branches of Litt3.

Status: proved, independently audited. Auditor: resultant_gradient_major_audit,
2026-09-07. Verdict PASS; no remaining objections. The degree48 scalar
resultant is a coefficient Frobenius twist, not its degree240 Frobenius
pullback. [Audit reference](../Research/audits/RESULTANT_GRADIENT_AUDIT_2026_09_07.md).
[Proof](../Solutions/Sol_resultant_gradient_atlas.md).
