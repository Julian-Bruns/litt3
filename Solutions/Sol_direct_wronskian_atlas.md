# Proof: direct Wronskian atlas reconstruction

[Statement](../Theorems/Thm_direct_wronskian_atlas.md).
We use the gluing and normalization theorem `scalar_hermitian_reconstruction`,
but replace its auxiliary bounded frames by the quotient's own horizontal
frame. All assertions involving inverse Frobenius are pointwise over k.

## 1. The two scalar spaces and the quotient condition

Write L=O(8O), and W for the stable rank-two Cartier descent, det W=O,
of Bop=J^1(L^-1). Then V=W tensor L. The scalar realization of
H0(W(nO)) is ker(delta^2-P on L((5n-8)O)); see Section2 of the scalar
reconstruction proof, including its local regularity verification.
Thus S_U realizes H0(W(24O))=H0(V^vee tensor omega^2), using the
determinant pairing of W, and S_T realizes H0(W(41O)). Stability,
Serre duality and Riemann--Roch give dimensions32 and66.

A surjection pi:V->omega^2 has kernel omega^-1. A bounded complement
is a lift of1 through

    0 -> O(17O) -> V tensor omega^-2(65O) -> O(65O) -> 0.

It exists because H1(O(17O))=0. In scalar horizontal coordinates its
determinant condition is U delta T-T delta U=1. Conversely this identity
makes [U,T;delta U,delta T] an SL2 frame on X-{O}, hence ensures
surjectivity there. It remains to check the kernel section at O.

The oper transition and F*V lattice, in oper coordinates, are

    T_op=[t^8,0;8t^7 delta t,t^-8],       t^-40 T_op Rcal^2.

The local coordinates of t^80(U,delta U)^T are

    (t^112 U, t^128 delta U-8t^127(delta t)U).               (3)

They are regular for U in S_U. If pole U=112, the first is a unit;
the possible t^-1 term of the second cancels since -112-8=-120=0
in characteristic5. If pole U=111, the first vanishes, but the second
has nonzero constant term: (-111-8)*3=3. If pole U<=110, both vanish.
These assertions also follow by applying t^16 delta to t^112 U;
112=-8 in k. Consequently (1) is exactly global surjectivity.

## 2. A canonical rational local complement

On k(X), partial_t^5=0 and k(X) has basis1,t,...,t^4 over k(X)^5.
The displayed Car_t is projection to the first basis summand, as follows
from sum_i(-1)^i binomial(j,i)=0 for1<=j<=4. On Laurent expansions
it retains precisely the exponents divisible by5. Hence eta is rational.

Put H=T/U. Wronskian1 gives

    partial_t H=1/((delta t)U^2).                            (4)

If pole U=d, d=111 or112, the right side has valuation16+2d.
For H-Car_t(H), every nonzero exponent is not divisible by5; its
derivative therefore lowers its valuation by exactly1. This proves
val(H-Car_t H)>=17+2d, and hence val V_0>=17+d. Also pole H<=197-d,
which is85 or86. Its retained negative exponents are multiples of5,
so pole eta<=17.

Use [U,T;delta U,delta T] as the horizontal frame on the affine chart.
The proposed descended local transition is

    G_V=[t^16,t^-32 eta;0,t^-32].                            (5)

Its Frobenius columns in oper coordinates are t^80(U,delta U)^T
and t^-160(V_0,delta V_0)^T. The second has local coordinates

    (t^-128 V_0,t^-112 delta V_0-8t^-113(delta t)V_0).        (6)

For val V_0>=129 these are regular. For valuation128 the only possible
pole in the second coordinate cancels since128-8=120=0. Formula (3)
is regular as well, and the determinant of these two local columns is1:
the determinant in oper coordinates is t^-80, equal to det(t^-40 T_op).
They therefore form a local basis, not just a sublattice. Both are
horizontal, so Cartier descent proves (5) is a local frame of the
ALREADY FIXED V. No formal algebraization or new bundle assumption occurs.

## 3. The atlas equations and precision bound

For ANY polynomial horizontal SL2 frame H, the matrix of the fixed
identification K->(F*V)^vee tensor omega^2 is H^T. Indeed in the oper
frame its target transition is

    t^8 T_op^-T=[1,-8t^15 delta t;0,t^16],

whose off-diagonal differs from t^-1 by a regular function. Changing
from oper to horizontal frame gives H^T, independently of pole bounds
used to construct a different frame in the older theorem.

Now apply Sections4--6 of `scalar_hermitian_reconstruction` using (5).
They glue the actual rank-three bundle and nonsingular Frobenius form,
remove the identification parameters by changing the quotient presentation,
and give lambda=-rho32(delta eta) and exactly (2). Conversely an atlas
supplies a quotient and bounded complement by Section1, hence these
equations. Changing the regular local complement only changes cocycle
representatives, not the existence test. This last claim can also be
checked directly by the coboundary identities in the scalar proof.

Explicitly, eta'=eta+t^48 g with g regular at O gives
lambda'=lambda+g(0)t^31 and V_0'=V_0+t^240 g^5 U. The residual changes
by U t^155(g^5-g(0)^5)-t^48g, whose valuation is at least48, including
the pole112 chart. Thus the necessary lambda correction is not omitted.

The term kappa^5 V_0 has valuation>=43 (>=44 on the112 chart).
Since lambda in P32 has pole at most17, U lambda^5 has pole at most
112+85=197. Eta has pole at most17. Thus the principal-part claim follows.
For an implementation, lambda needs eta through order48: errors in
t^49Rcal differentiate into t^32Rcal. V_0 must be known through132
to recover kappa^5 V_0 through47. Products still require sufficient
INPUT precision, not merely a final truncation to these orders.

## 4. Removing the complement choices

If T,T' have Wronskian1, (T'-T)/U has derivative zero, hence equals h^5.
The two horizontal columns differ by h^5(U,delta U). Since U,delta U
generate the unit ideal on X-{O}, h^5 is regular there. The pole bound
for T'-T gives pole h<=floor((197-d)/5)=17. Conversely every such h
produces another bounded T'. Thus all complements form T+U L17^5.
Riemann--Roch gives h0(O(17O))=9.

Projection Car_t then changes eta to eta-h, and V_0 stays unchanged.
Since delta h belongs to Acal, lambda stays unchanged. Also rho48(h)=0.
Both A_U and B_U are therefore independent of T. The affine part of
eta belongs to L17, so choosing h=aff(eta) gives the unique normalized
complement aff(eta)=0. Uniqueness uses Acal intersect tRcal=0.
The Wronskian equations are linear in T. The nine gauge equations are
also linear after fifth powers, because eta^5=-Car_t(T/U) is linear
in T for fixed U and aff is linear. Thus this is an exact linear
normalization, not a generic rank assumption or an extra condition.

## 5. Projective direction and scale

If B_U=0, the class of eta in k((t))/(Acal+t^48Rcal) vanishes. Formula
(5) then splits the extension0->omega^-1->V->omega^2->0. But V is
stable of slope8, whereas a split extension contains omega^2 of degree32.
This contradiction proves B_U!=0.

Write a nonzero scalar as c=d^5. Replacing U,T by cU,c^-1T replaces
eta,lambda by d^-2 eta,d^-2 lambda and V_0 by d^-5 V_0. Hence

    A_(cU)=d^-5 A_U,       B_(cU)=d^-2 B_U.

Equation (2) for some scale is exactly A_U=d^3 B_U. Since B_U is
nonzero, this holds for some d!=0 exactly when A_U is a nonzero multiple
of B_U; over k it then has exactly three solutions for d. This treats
all quotient directions and preserves the affine nonzero-scale condition.

## Exact tests and limitation

`scripts/direct_wronskian_test.sage` checks the original scalar polynomial
identities, Wronskian1, dimensions32/66, rank57/nullity9, and Laurent
bounds for five deterministic directions of a noninvariant F25 oper.
Four use pole112 and one pole111. All five observation pairs have rank2.
Saved output is `Research/computations/direct_wronskian_samples.json`.
This demonstrates and checks the implementation; it is NOT a proof of
global nonexistence on P31, for this oper or for the other17 representatives.
