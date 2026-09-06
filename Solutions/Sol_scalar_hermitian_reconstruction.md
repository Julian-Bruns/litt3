# Proof: bounded scalar Hermitian reconstruction

[Statement](../Theorems/Thm_scalar_hermitian_reconstruction.md).
All frames use the convention in `scalar_hermitian_data`. This proof is
pointwise in a fixed geometric dormant oper; it does not discard the
local multiplicities in the separate oper enumeration.

## 1. The fixed obstruction map

The gap basis and monomial elimination give the exact identity

    ker Q = Acal^2 + t^32 G_K Rcal^2.                          (3)

Indeed, for Q(w)=0 put f_i=aff(w_i),

    g2=t^-48(w2-f2),
    g1=t^-32(w1-f1-t^31 g2).

The second block of Q says g2 is regular; its constant coefficient is
c_48(w2). The first block then says g1 is regular. Thus
w=f+t^32G_K g. Conversely substitution proves Q vanishes on this sum.
The g_i are rational whenever w_i are rational. This represents
H1(K tensor omega^-2) without an unspecified cohomology comparison.
The nine gaps and the 31 or 47 positive coefficients give dimensions
40 and 56. The correction at degree48 is essential.

## 2. Bounded frames for the fixed oper

Put P=A+(B+2x^8)y+C_0 y^2. Substituting u=yf into u''=ru gives
delta^2 f=P f. For n=18,35 compute the linear kernels

    S_n=ker(L(5n-8) --delta^2-P--> L(5n+26)).

They have dimensions20 and54. Choose f1 in S_18 and f2 in S_35 with

    f1 delta f2-f2 delta f1=1,
    H=[f1,f2; delta f1,delta f2].                            (4)

Here is the existence argument, which is also necessary for choosing f1.
Let L=O(8O), Bop=J^1(L^-1), and W be its Cartier descent. The oper
line has nonzero second fundamental map. The Frobenius pullback of a
line A1 in W cannot lie in that line; projection to L^-1 gives
5deg A1<=-8. Hence W is stable of degree zero. The horizontal realization
of H0(W(nO)) is S_n. In local oper coordinates, a corresponding section
has coordinates (h,t^16 delta h), h=t^(5n-8)f. They are regular exactly
when f lies in L(5n-8). The second coordinate is regular for regular h
because t^16 delta is a regular nonvanishing derivation at O.

Stability and Serre duality imply W(18O) is globally generated. A general
section is nowhere zero: vanishing at a fixed point imposes two conditions,
and the curve has dimension one. Choose f1 from this locus, NOT arbitrarily
from S_18. It yields 0 -> O(-18O) -> W -> O(18O) -> 0. After twisting
by35O, H1(O(17O))=0 lets the quotient section1 lift, giving f2 with (4).
Riemann--Roch gives the stated dimensions. Since delta raises pole order
by at most17, entries of H and H^-1 have poles at most184.

The oper transition is

    T_op=[t^8,0; 8t^7 delta t,t^-8].

For V=W tensor L define, entrywise,

    Car_t(z)=sum_(i=0)^4 (-t)^i/i! (partial_t)^i z,
    B_0=H^-1 t^-40 T_op,
    G_0=Car_t(B_0)^[1/5],
    epsilon=t^16 det G_0,
    G=G_0 diag(epsilon^-1,1).                              (5)

The projector Car_t takes rational functions to k(C)^5. The lattice with
columns B_0 is preserved by the canonical connection partial_t. Applying
Car_t changes a basis by a matrix congruent to the identity modulo t,
and gives horizontal columns. Their unique fifth roots give a rational
local frame of V. Thus epsilon is a local unit and det G=t^-16.
Both rational frame sections of W lie in W(35O); their local coordinates
after tensoring by L have poles at most27. Consequently

    pole(G^-1)<=27,        pole(G)<=43.                     (6)

This uses inverse Frobenius only for the fixed geometric r.

The fixed isomorphism j_0:K -> (F_C^*V)^vee tensor omega^2 has U matrix
H^T. Indeed the target transition in the oper frame is

    t^8 T_op^-T=[1,-8t^15 delta t; 0,t^16].

Since delta t=3t^-16(1+O(t)), its off-diagonal entry minus t^-1 is
regular, proving the identification with G_K. Finally H0(K)=ke,
and its extension is nonzero. Every automorphism of K therefore has
U matrix A_(a,b)=[a,b;0,a], with a!=0 and b in L(16).

## 3. Quotient maps and their bounded certificates

The spaces Pi and Sigma in the statement are respectively
H0(V^vee tensor omega^2) and H0(V tensor omega^-2(65O)). Stability and
Riemann--Roch give dimensions32 and66. Bounds (6) give the indicated
pole bounds59 and76. Setting the negative Laurent coefficients from
degree-70 through-1 equal to zero implements their regularity conditions.

Equation ps=1 ensures pi is surjective on U; p_O,j(0)!=0 ensures it at O.
Conversely a surjection has kernel omega^-1. Twisting its exact sequence
by omega^-2(65O) gives

    0 -> O(17O) -> V tensor omega^-2(65O) -> O(65O) -> 0.

H1(O(17O))=0 supplies s in Sigma lifting1. This proves the necessity
of the bounded certificate; it is not an extra restriction on pi.
The space of such certificates for fixed p is affine of dimension9.

Define S,s_O,eta as in the statement and put
S_O=[p_O,2,s_O,1; -p_O,1,s_O,2]. Both S and S_O have determinant1.
Direct multiplication gives

    S^-1 G S_O=G_V=[t^16,t^-32 eta; 0,t^-32].                 (7)

The matrix of j_0 in these quotient-adapted frames is
J_0=(H S^[5])^T. Let J_(0,O) be defined by

    J_0 G_K = G_J J_(0,O),
    G_J=t^-32 (G_V^[5])^-T.                                (8)

It is regular and invertible at O, by the preceding construction of j_0.

## 4. The exact equations before normalization

Initially allow a!=0,b in L(16). All lifts of the fixed quotient
presentation have transitions, after principal-part reduction,

    G_E=[1,t^16 kappa,t^-32 lambda;
         0,t^16,      t^-32 eta;
         0,0,         t^-32],             lambda in P_32.    (9)

For E^D=(F_C^*E)^vee tensor omega^2, order the dual basis as (2,3,1).
Inverse transpose gives

    G_ED=[G_J,t^-32 d; 0,t^-32],
    d=(-kappa^5, eta^5 kappa^5-lambda^5)^T.                 (10)

An adjoint E -> E^D with kernel map j_0 A_(a,b) and quotient map1
exists exactly when

    zeta=J_0^-1 d-A_(a,b)(lambda,eta)^T
        lies in Acal^2+t^32 G_K Rcal^2.                    (11)

By (3), this is exactly Q(zeta)=0. To verify sufficiency globally, write
zeta=f+t^32G_K g using (3); set h_U=J_0 f and h_O=-J_(0,O)g.
With A_O=[a,t^16 b;0,a], the matrices

    Phi_U=[J_0 A_(a,b),h_U; 0,1],
    Phi_O=[J_(0,O) A_O,h_O; 0,1]

satisfy Phi_U G_E=G_ED Phi_O. Their determinants are a^2, so the adjoint
is nonsingular everywhere. Its final row is (0,0,1), giving
beta(-,F_C^*e)=q. Also det E=omega. The audited
`hermitian_atlas_extension_criterion` therefore gives the actual
untwisted PSU atlas, including etaleness at O. Conversely the adjoint of
any such atlas supplies (11); reduction modulo Acal+t^32 Rcal gives its
unique lambda in P_32. This proves necessity too.

All functions here are rational. One may shrink the local neighborhood
of O to remove their other poles; no formal algebraization is needed.
Useful sufficient bounds are pole(eta)<=87, pole(J_0^+-1)<=564,
pole(zeta_i)<=1084. Thus Q(zeta) needs only coefficients from degree
-1084 through48 and expansions of affine monomials of pole order at
most1084 through48. The inverse of p_O,j is computed recursively from
its nonzero constant term. These are finite polynomial operations with
one chart inverse variable. The reconstructed h_U has pole order<=1648.

## 5. Eliminating the ten identification parameters

First remove b. For h=b/a in L(16), keep p and s, replace

    lambda by rho_32(lambda+h eta),      b by0.              (12)

The Frobenius part introduced by h eta is a coboundary. Explicitly

    G_J=[t^-112,0; -t^-112 eta^5,t^128],
    (0,h^5 eta^5)^T
       =h^5 e1-t^32 G_J(t^80 h^5 e1).

Since h belongs to Acal and t^16h is regular at O, applying J_0^-1 and
(8) proves Q(v(h eta)^5)=0. Thus the unnormalized substitution
lambda -> lambda+h eta changes (11) only by a Q-zero term while
canceling b eta. Reducing to P_32 is harmless: if lambda changes by
f+t^32g, its ordinary contribution is a coboundary, as is the fifth-power
contribution. The latter follows from v in Acal^2 and

    t^160 v=t^32 G_K J_(0,O)^-1 e2.

Now remove a. Choose u in k^x with u^3=a and rescale

    p'=u p, s'=u^-1 s, eta'=u^-2 eta, lambda'=u^-2 lambda,
    a'=u^-3 a=1, b'=u^-3 b.

Then S'=S diag(u,u^-1), J_0'=diag(u^5,u^-5)J_0, and direct
substitution gives zeta'=u^-5 zeta. Hence solvability is preserved.
After (12), b=0 stays zero. These changes prove existence equivalence,
not a claim that every marked j is literally equal. Over a parameter
scheme the cube root is a finite etale change of base; here k is closed.

With a=1,b=0, expansion of (11) is precisely equation (5) in the
statement. Thus these ten parameters need not enter the existence search.

## 6. Unconditional differential elimination

For any rational z, principal-part reduction writes

    z=aff(z)+rho_48(z)+c_48(z)t^48+O(t^49).

The derivation delta preserves Acal. Also delta t=3t^-16(1+O(t)), so
delta(t^48)=-t^31+O(t^32), because 48 times3 is -1 in k, and
delta(t^49 Rcal) is contained in t^32 Rcal. Therefore

    rho_32(delta z)=rho_32(delta rho_48(z))-c_48(z)t^31.

It follows that, for arbitrary rational z1,z2,

    Q_1(z1,z2)-Dbar Q_2(z1,z2)=rho_32(z1+delta z2),           (13)

where Dbar=-rho_32 delta on P_48. The target change on the left is
fixed, linear and invertible. This is the key simplification; there is
no rank condition in (13).

Write H S^[5]=[U_0,T_0;delta U_0,delta T_0]. Its determinant is1.
Thus J_0^-1=[delta T_0,-delta U_0;-T_0,U_0]. Put

    Y_0=kappa^5(T_0+eta^5 U_0)-U_0 lambda^5.

In (11) the two components are

    zeta1=-delta Y_0-a lambda-b eta,
    zeta2=Y_0-a eta.

Here delta annihilates fifth powers, including those of rational lambda
and eta. Consequently

    zeta1+delta zeta2=-a(lambda+delta eta)-b eta.              (14)

By (13), Q(zeta)=0 is equivalent to the56 equations rho_48(zeta2)=0
and the40 LINEAR equations

    lambda=-rho_32(delta eta+(b/a)eta).                      (15)

This determines lambda uniquely for every admissible p,s,a,b. After
a=1,b=0, (15) and the remaining block are exactly (2)--(4) in the
statement. No pivot, rank condition, or choice among Frobenius roots
is needed. This is also an isomorphism of the solution schemes on
fixed-oper charts: (13) is a linear target automorphism and (15)
eliminates variables with coefficient1. Quotient regularity and the
bounded Bezout certificate from Section3 remain necessary.

Derivatives in this argument are of rational functions. A finite series
implementation must retain enough coefficients of each factor before
multiplying and differentiating. For example, for eta of pole order87,
computing delta eta through31 from raw factors can require delta t
through119. Reducing eta first to its gap principal part and coefficients
through48 gives the same rho_32(delta eta), with much smaller bounds.

## 7. Rank identity and its exact tests

Matrix inversion using det S=det H=1 gives

    J_0^-1 e2=(-delta U_0,U_0)^T,
    U_0=f1 p2^5-f2 p1^5.

It satisfies delta^2 U_0=P U_0. It is the weight-seven horizontal
tensor attached to pi, so U_0 lies in L(112). The second component of
Q immediately gives M_2[:,nu]=rho_48(U_0 ell_nu^5).
Applying (13) to (-delta(U_0 lambda^5),U_0 lambda^5) proves
M_1=Dbar M_2. Thus rank M=rank M_2 for every quotient. The general
bound in `semilinear_hermitian_lift` gives rank M_2<=31. Its strengthened
differential retraction supplies the intrinsic explanation in every
allowed genus; the present proof makes that retraction explicit.

The exact script `scripts/scalar_residual_rank.sage` computed the
32-dimensional space ker(delta^2-P:L(112)->L(146)) for the first two
F25-rational invariant opers. Eight reproducible samples for each all
gave rank31. All16 full40-by40 upper matrices were then computed
independently from (-delta U_0,U_0), including the c_48 correction,
and verified to equal Dbar times the lower matrix. For one saved sample
of each, the affine ideal
(y^3-F,U_0,delta U_0) has Groebner basis[1], and
ord_O(U_0 theta^7)=112-112=0. Thus their zeros are globally reduced,
and their quotient maps are genuinely surjective. Data, not routine
context: `Research/computations/scalar_residual_rank.json`.

For each tested fixed oper the rank31 locus is therefore a nonempty
open subset of the quotient space. This does NOT imply the same for
every oper, or exclude solutions of the 56 remaining equations.
