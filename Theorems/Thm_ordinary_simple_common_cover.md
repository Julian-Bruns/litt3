# An ordinary absolutely simple endpoint does not prevent common covers

Over k=bar(F5), take a^2+2=0 and

    A(t)=t^3+4a*t^2+t+2a+4,
    B(t)=t^3+(4a+3)*t^2+(a+4)*t+4a+1.

Let C_plus and C_minus be the smooth projective models of

    y^3=A(t)B(t),             w^3=A(t)/B(t).

Both have genus4 and absolutely simple geometric Jacobians. J(C_minus)
is ordinary, J(C_plus) has p-rank2, and geometric Hom between the two
Jacobians is zero in both directions.

Nevertheless the connected smooth projective curve T with function field

    k(t)(u,v), u^3=A(t), v^3=B(t)

has genus10 and actual everywhere finite etale Galois maps of degree3
to both endpoints, given by y=uv and w=u/v. Their common core is P1_t.

The geometric construction works for ANY pair of coprime squarefree
monic cubics A,B in characteristic different from3. Only the asserted
Jacobian properties use the displayed coefficients and characteristic5.
No coreless span for this particular pair is asserted.

Thus even the combination of absolute simplicity of BOTH Jacobians,
ordinary versus nonordinary endpoints, geometric Hom-zero, and both
prime-to-five Galois etale legs does not exclude a common cover. This
does not settle the fixed genus-nine/genus25 pair: their additional
specific geometry, or another genuine two-leg obstruction, is needed.

Version1, audited prose and exact coefficient/count certificate.
PASS2026-09-07, /root/ordinary_simple_pair_audit; no objections.
[Audit metadata](../Research/audits/ORDINARY_SIMPLE_COMMON_COVER_AUDIT_2026_09_07.md).
[Proof](../Solutions/Sol_ordinary_simple_common_cover.md).
