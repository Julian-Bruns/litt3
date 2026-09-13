# The parameterized genus-three A3 abelian defect germ

Version1,2026-09-11. Exact generic certificate, independent Laurent replay
and focused geometric audit PASS.

Work over an algebraically closed field k of characteristic5. Put

    G=u(u-1)(u-2)(u-3), F=G(u-t), A=(t+1)^2G,
    Y_t: v^2=F, a=A/F^2, r_t=3a''/a+(a'/a)^2,
    C_t: k(C_t)=k(u,v,kappa), kappa^2=u(u-3).

Here C_t is the smooth projective connected genus3 curve, and the pair
on C_t is the pullback along the actual finite etale double C_t->Y_t.
Assume

                Delta(t)=(t^5-t)(t^2+2t+3)!=0.

The scalar relation for its completed maximal abelian pro5 defect module
has formal type

                             UV+W^4,

up to an invertible formal coordinate change and multiplication by a unit.
For every n>=0 and q=5^n, the actual maximal balanced cover
T_q->C_t with deck group(Z/q)^3 has

                  defect(T_q)=(7q^2-3)/4.

Every actual finite etale source dominating T_q, with the pulled-back
connection, has defect at least this number.

After dividing the injection defining the defect bundle by(t+1)^2,
one formal Picard coordinate system has scalar4-jet

    f_2=3(t^5-t)X^2+4(t^5-t)/(t+1)^2 Z^2,
    f_1=f_3=0, [Y^4]f_4=3, [XY^3]f_4=2t(t^4+3).

Solving the two transverse critical equations leaves corrected radical
quartic3Y^4. All Schur-block corrections are included in this assertion.

For alpha^3+alpha+1=0, Delta(alpha)=-alpha^2!=0. More generally every
algebraic parameter of degree>=3 over F5 satisfies the hypothesis, so
this theorem applies to both the backup and the chosen main parameter.

This is an abelian-cover defect theorem, not a higher-Witt obstruction,
an unbalanced-cover formula, an assertion of domination by an arbitrary
common source, or an exclusion of all common covers. The original t²+2=0 actual-cover
computation remains an independent check of this general theorem.

[Proof](../../Solutions/deformations/bad_double_abelian_a3_family.md) ·
[Audit](../../Research/audits/PARAMETERIZED_BAD_DOUBLE_GERM_AUDIT_2026_09_11.md).
