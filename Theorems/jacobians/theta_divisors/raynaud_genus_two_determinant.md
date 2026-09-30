# Cartier matrices and Kummer equations in genus two

## All powers in every odd characteristic

Let C:v²=F(u) be a smooth genus-two curve over an algebraically
closed field of odd characteristic p, where F is monic, squarefree of
degree5. Write H=F^((p-1)/2). Let M on J(C^(1)) have a
valid reduced degree-two Mumford representative (U1,V1), with U1 monic,
deg V1<2, U1 dividing V1^2-F^(1), and gcd(U1,F^(1))=1.
Use [B_{1,C} on C^(1)](../../../Definitions/theta_cartier.md).
Repeated support is allowed. For every integer m≥1 define

    S_m={A:deg A<=pm+1, [u^(pi+p-1)]AH=0, 0<=i<=m+1}.

This space has dimension (p-1)m. In k[z]/U1^m let V_m be the unique
square root of F^(1) reducing to V1 modulo U1. It is a unit. For a
basis A_j of S_m and r=0,...,p-2, form

    C_rj(z)=sum_l [u^(r+pl)](A_j H) z^l,
    T_m[(r,i),j]=[z^i](V_m^(-1) C_rj mod U1^m),
                      i=m,...,2m-1.

Then T_m is a (p-1)m-square matrix and

    h0(C^(1),B_{1,C} tensor M^m)=dim ker T_m.             (P)

This includes m divisible by p; M^m need not have a reduced degree-two
representative. There is no torsion-order or cover-degree bound. The
matrix preserves actual sheetwise cancellation, not merely a norm.

## Four-square specialization in characteristic five

Let C:v^2=F(u) be a smooth genus-two curve over an algebraically closed
field of characteristic5, with F monic of degree5. Put

    S_F={A in k[u], deg A<=6: [u4,u9,u14](AF^2)=0}.

This space has dimension4. Choose a basis A_j and write c_i(A)=[u^i](AF^2),
with out-of-range coefficients zero. For a reduced degree-two Mumford
class M on J(C^(1)), write

    U1=z^2-S*z+P, V1=q0+q1*z, U1 divides V1^2-F^(1),
    gcd(U1,F^(1))=1,  F^(1)=sum f_i^5*z^i.

Define the4x4 matrix, r=0,1,2,3, j=1,2,3,4, by

    D_rj=q1*(c_r-P*c_(r+10)-S*P*c_(r+15))
         -q0*(c_(r+5)+S*c_(r+10)+(S^2-P)*c_(r+15)),

where every c is evaluated on A_j. Then

    h0(C^(1),B_{1,C} tensor M)=dim ker D.

Thus det D=0 is an EXACT theta-membership criterion on this Mumford
chart, not merely a necessary norm condition. Repeated U1 is allowed
provided it is a valid reduced Mumford divisor and coprime to F^(1).

## Raynaud theta on the Kummer surface

For any smooth genus-two curve in odd characteristic p, let Θ be its
Raynaud divisor and Θ_class the symmetric principal theta divisor.
In Tong's notation, Θ descends to an effective Cartier divisor Θ̃ on
Kum=J(C^(1))/{±1}, with O(Θ̃)=O_Kum((p−1)/2).
In particular, in characteristic5 the whole Raynaud divisor is cut out
by a unique quadric up to scalar. Ordinarity is unnecessary.
This is [Tong, Propositions1.2.3.1 and1.2.3.3](https://arxiv.org/pdf/0712.2046),
together with the quartic Kummer embedding.

## Explicit formula for the high-degree partner family

For F_t=u(u-1)(u-2)(u-3)(u-t), t not in F5, C_t is ordinary.
In standard Kummer coordinates (Z0,Z1,Z2,Z3)
on J(C_t^(1)), let Q_t=sum_(i<=j) c_ij Z_i Z_j, with

| ij | c_ij |
| --- | --- |
| 00 | t^8(t+1)(t^5-2t^4+t^2-2t-1) |
| 01 | -2t^7(t+1)(t^4-t^3-t^2-t+1) |
| 02 | t^2(-2t^10+t^9+2t^7-2t^6-2t^4+2t^3+t-2) |
| 03 | t^4(t+1)(t^4-2t^3+t^2-1) |
| 11 | t^6(t^2+t+1) |
| 12 | t^2(t+1)(-2t^4+2t^3+2t^2+2t-2) |
| 13 | -t^3(t+1)(2t^2+t+2) |
| 22 | (t+1)(-t^5-2t^4+t^3-2t+1) |
| 23 | (t+1)(-t^4+t^2-2t+1) |
| 33 | (t+1)^4 |

For EVERY geometric M in J(C_t^(1)),

    h0(B_{1,C_t} tensor M)>0 iff Q_t(kappa(M))=0.

On the Mumford chart kappa(M)=[1,S,P,w], where

    w=q1^2-f_2^5-f_3^5*S-f_4^5*S^2-f_5^5*S*(S^2-P).

The formula is ON C_t^(1): its curve polynomial has parameter t^5,
whereas the displayed quadric coefficients are functions of t. Do not
silently use it on C_t without transporting coefficient Frobenius.

Version3,2026-09-14. Joshi's stability theorem removes ordinarity and
the separate rank hypothesis from the matrix construction. This step
passed a bounded medium audit; the exact quadric remains author-proved.
The global quadric assertion concerns support, with no multiplicity
comparison assumed.
[Proof](../../../Proofs/jacobians/theta_divisors/raynaud_genus_two_determinant.md).
