# An actual genus-three A3 abelian defect germ

Version1,2026-09-11. Focused audit PASS,
/root/audit_bad_double_abelian_germ. Exact computation and audited prose;
no coefficient correction and no Lean verification.

Over k=bar(F5), choose t with t^2+2=0. Set

    G=u(u-1)(u-2)(u-3), F=G(u-t), A=(t+1)^2 G,
    Y:v^2=F, a=A/F^2, r=3a''/a+(a'/a)^2,
    C: k(C)=k(u,v,kappa), kappa^2=u(u-3).

Pull r back along the actual connected etale double C->Y.
C has genus3 and ordinary Jacobian. Its completed scalar defect
relation for the maximal abelian pro5 cover has formal type

                         UV+W^4.

For every n>=0, q=5^n, let T_q->C be the actual maximal balanced
abelian cover with group(Z/q)^3. Then

    dim coker(Psi_(T_q)) = (7q^2-3)/4.

In particular the degree125 cover has genus251 and defect43.
Any actual further finite etale cover of T_q has defect at least this
number, by pullback on sections of the actual defect bundle.

This is a SPECIALIZATION theorem about the completed abelian-cover
defect module. It is not the fixed-curve nilpotent germ or a higher
Witt obstruction. It gives no uniform-in-t theorem, unbalanced-cover
formula, second map, or common-cover exclusion.

[Proof](../Solutions/Sol_bad_double_abelian_a3_specialization.md) ·
[Audit](../Research/audits/BAD_DOUBLE_ABELIAN_GERM_AUDIT_2026_09_11.md).
