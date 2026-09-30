# Actual fourth-reference data on the original rank125 cover

Version1,2026-09-14. This is an actual marked fourth-Witt computation;
it makes no fifth-lift or unmarked common-cover assertion.

Use k0=F5[t]/(t^3+t+1), the ordinary genus-two base and canonical
reference of the [base theorem](../cubic_ordinary_base_reference.md),
and the normalized genus-three and original scaled AS cover of the
[integral-reference theorem](rank125_integral_reference.md). Retain the
original character labels, flat two-torsion line, graded identification
and preceding filtered object. Field codes [d] mean
d0+d1*t+d2*t^2, where d=d0+5d1+25d2 and 0<=di<5.

Let R=k0[s1,s2,s3]/(s_i^5), K=Ann(f), with the actual scalar Schur
symbol f and full primary coordinates of the
[quadratic-channel theorem](fourth_hodge_quadratic_channel.md).
The scalar H is after the specified coefficient Frobenius. Let
nu0,...,nu42 be the completed RREF kernel basis with preferred pivot
columns (014),(104),(113),(203), followed by total degree and lexicographic
order. E_abc denotes the target coordinate after reducing the relation
span fR in increasing degree and lexicographic order.

Put B0=[101]nu1+[14]nu2. Its complete actual fourth obstruction is

    E4(B0)=[9]E111+[66]E120+[24]E300
           +[46]E131+[115]E140+[59]E311+[77]E320
           +[34]E331+[16]E340.

Every unlisted coordinate is zero. Define alpha,beta by the degree-five
part of the ACTUAL regular correction

    D_regular(B0)=E4(B0)-Q(B0)-C(B0),
    C(B0)=-[f_hat*B0_hat/5],
    [D_regular(B0)]5=alpha*v_minus+beta*v_plus,

where the whole integral product is divided before projection, and in
coordinate order (041),(131),(140),(221),(230),(311),(320),(410),

    v_minus=(0,[16],[115],0,0,[19],[108],0),
    v_plus =(0,[62],[15],0,0,[10],[29],0).

Then alpha=[1] and beta=[0]. The actual source

    H_A=[101]nu1+[14]nu2+[122]nu11+[93]nu12
         +[117]nu15+[115]nu16+[119]nu27

has complete obstruction

    E4(H_A)=[57]E331+[17]E340.

Thus the actual terminal reference coefficients are omega1=[57],
omega2=[17], with omega0=omega3=0. In particular the explicit point

    Hstar=[101]nu1+[14]nu2+[122]nu11+[93]nu12
           +[117]nu15+[115]nu16+[83]nu27+[74]nu30+[58]nu31

satisfies E4(Hstar)=0 and admits a genuine compatible fourth extension.
It equals H_A-[81]gamma1-[97]gamma2 for
gamma1=[11]nu27+nu30, gamma2=[87]nu27+nu31.

The comparisons use actual whole first affine and formal repairs and
source/flat moduli625/125. Both complete vectors and the full finite
repair tables have been independently reconstructed locally; the
geometric interpretation, two-branch regularity and projection have
passed a separate bounded audit. No unspecified reference coefficient
has been specialized to obtain these values. The actual fifth slope
and constant are evaluated in the separate
[whole fifth theorem](rank125_fixed_line_fifth.md), with its combined second repairs.

[Proof and exact reconstruction evidence](../../../Proofs/deformations/elementary_covers/rank125_actual_fourth_reference.md).
