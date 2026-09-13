# The rank25 fourth lifts form a smooth critical locus

Version2,2026-09-13. Consolidates the actual W4 witness and complete locus;
adds scheme equality, a deformation model and the cotangent quotient.

Let h:T→C be the actual maximal connected elementary-abelian étale cover
of the original marked genus-two pair in
[explicit_genus_two_witt_obstruction](../explicit_genus_two_witt_obstruction.md).
Keep its original pulled-back T2, square-trivial flat line and graded
identification. T has genus26 and defect9. Use

    k0=F5[t]/(t^4+4t^3+t^2+4t+3),
    abcd=a+b*t+c*t^2+d*t^3,
    Xi(x)=xi_*+sum_(i=0)^8 x_i*nu_i

in the actual tangent basis of the
[primary data](../../../Research/computations/rank25_small_field_fourth_inputs.json).
Over k=bar(F5), these are ALL compatible third lifts of that T2. Such a
lift admits W4 exactly when E(x^[5])=0, where E is the complete quadratic
fourth obstruction in the proof, including its transverse coordinates.

Write y=x^[5] as independent auxiliary coordinates and set

    U=y0, m=(y1,y2), a=y3, b=y4, s=y6,
    h=y5-0224*s, z=(y7,y8),
    F=0231+3234*a+4232*b+0314*a^2+2031*a*b+1032*b^2,
    G=2014*a+3304*b+2342*a^2+4303*a*b+4301*b^2,
    D=((2014,0130),(4342,3004)), c=(1002,4420),
    f_s=(F,G)^T+s*D*m+s^2*c.

The full ideal is

    (E0,...,E8)=(z1,z2,h,(f_s)_1,(f_s)_2).             (1)

Thus S_y=Spec k0[y]/(E) is smooth, geometrically irreducible and
four-dimensional. With n=-D*m-s*c it is

    A^1_U × Spec k0[a,b,s,n1,n2]/(F-s*n1,G-s*n2),

the deformation to the normal bundle of the four simple points

    (a,b)=(2321,2003),(2423,4303),(3134,4233),(4343,2312).

The s-open is A^3×Gm. The boundary is four copies of A^3, with U,m free.
A constant invertible P and cubic V satisfy ∇V=P E. Its normal Hessian
is nondegenerate, so J=dE/dy has rank5 and

    coker(J|_S_y) ≅ Omega^1_S_y, [c] ↦ (P c)|_(T S_y). (2)

In actual x-coordinates the REDUCED locus S_x is the coefficient inverse-
Frobenius twist of S_y. The full scheme E(x^[5])=0 is a Frobenius
thickening. Formula(2) pulls back to the actual relative fifth quotient
along F:S_x→S_y; F is not an étale coordinate change.

The original third point x*=(0,0,0,3003,0314,0,0,0,0) has an actual
compatible W4 lift over W4(k0). Its digit zeta_* solves
M*zeta_*^[5]=rho4 in all75 normal coordinates, and the corrected Hodge
line and prescribed grading glue. Every further actual finite étale
cover of T inherits this W4 tuple. In particular the lower bound holds
for every rank-two abelian5-group cover of C, which dominates T.
It gives no W5 upper bound on those refinements.

[Proof and data conventions](../../../Proofs/deformations/elementary_covers/rank25_fourth_locus.md) ·
[Critical-locus audit](../../../Research/audits/RANK25_CRITICAL_LOCUS_CONSOLIDATION_AUDIT_2026_09_13.md).
