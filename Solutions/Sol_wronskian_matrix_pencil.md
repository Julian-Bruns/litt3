# Proof: eliminating the polynomial complement altogether

[Statement](../Theorems/Thm_wronskian_matrix_pencil.md).
We use the audited `direct_wronskian_atlas` criterion and its local
cocycle invariance. All principal-part reductions are the fixed linear
maps of `scalar_hermitian_data`.

## 1. Normalize the actual extension class

Given an admissible U and bounded complement T, the direct test constructs
a rational eta. Replace it by rho48(eta), subtracting an affine polynomial
h in L17 and a term t48 g regular at O. Subtracting h changes T to
T+U h^5 and does not change its Wronskian or the residual. The local
change t48 g changes lambda by g(0)t31; the resulting residual correction
has valuation at least48, as explicitly proved in the direct theorem.

For the new eta in E, U eta^5 equals -T_new plus a series of valuation
at least128: the old positive part had valuation>=128, and the local
correction U t240 g^5 has valuation>=128. Since T_new is affine,

    T_new=-aff(U eta^5),       rho128(U eta^5)=0.            (4)

This proves necessity of the first two conditions in (2). Substituting
(4) in the direct residual gives its third condition, exactly.

## 2. Sufficiency and automatic horizontality

Conversely take U in S_U with pole d=111 or112 and eta in E with
N_U eta^[5]=0. Define T=-aff(U eta^5), V_0=rem(U eta^5). Then

    T in L197,       V_0 in t128 Rcal.

The rational function U eta^5 is horizontal for delta^2-P, since delta
annihilates fifth powers. Thus

    (delta^2-P)T=(delta^2-P)V_0.

The left side is affine. The right side has valuation at least94:
delta raises pole order by at most17 and P has pole at most34. An
affine function regular and zero at O is zero on the projective curve.
Consequently T belongs to S_T.

Its Wronskian W(U,T)=W(U,V_0) is affine. At O each product has valuation
at least128-d-17, hence at least-1. On the112 chart the only possible
pole has coefficient (128+112)*3=0; on the111 chart there is no possible
pole. It is therefore a constant. If that constant is1, the local
matrices (3),(6) in the direct proof form a regular determinant-one
basis, including when V_0 has valuation128. The gluing argument applies
with this eta representative and gives the atlas exactly when the last
condition in (2) holds. This proves the equivalence without selecting
generic quotients or assuming their ranks.

Every operation used in (1) is fixed linear reduction, multiplication
by U, or a fifth power. Thus the two matrix pencils are linear in U.
T is bilinear in U and eta^[5]; its Wronskian is quadratic in U and
linear in eta^[5]. On N=0 only its constant coefficient needs imposing.

## 3. The one-dimensional kernel

For admissible U, Section1 supplies a nonzero vector in ker N_U whose
Wronskian equals1. Suppose a kernel vector has Wronskian zero. Then
T/U=h^5 for a rational h. Since U and delta U generate the affine
unit ideal, h is affine. Also pole h<=17, as in the direct proof.
Now V_0=U(eta+h)^5 has valuation>=128, so

    val(eta+h)>=ceil((128+d)/5)=48.

Since eta is the unique P48 representative modulo Acal+t48Rcal,
eta=0. Thus the linear Wronskian functional on ker N_U is injective.
It is nonzero by the vector already found; the kernel has dimension1
and N_U has rank55.

Admissible sections are dense in P(S_U): W(24O) is globally generated,
and vanishing at a fixed point imposes two conditions while the curve
has dimension one. The determinant-pairing quotient of a nowhere-zero
section is surjective. Hence all56 minors of the linear matrix N_U
vanish on a dense open set, and identically. This establishes rank<=55
even on inadmissible strata, without claiming their kernel dimension1.

## 4. A Frobenius stability test for the kernel line

For an admissible U choose eta in E giving Wronskian1 and let e=eta^[5].
Then e spans ker N_U. The two observations of the direct theorem are

    A_U=R_U e,          B_U=eta.

The equation N_U^[1/5] R_U e=0 is equivalent to
N_U (R_U e)^[5]=0. As ker N_U is a line, and B_U!=0, this is precisely
the assertion that R_U e is proportional to eta, allowing zero.
Excluding zero gives exactly the three-scale criterion of the direct
theorem. Since the first block already has rank55, the stacked matrix
has rank55 or56, and (3) follows. With U=sum u_i^5 U_i, its fifth-root
block is sum u_i N_(U_i)^[1/5], while R_U=sum u_i^5 R_(U_i). This
gives the polynomial degrees5 and6 and avoids a rational kernel basis.

## Implementation evidence and scope

`scripts/wronskian_matrix_pencil.sage` independently constructs the maps
from Laurent multiplication and affine reduction. All five saved direct
samples, including pole111, give rank N=55/nullity1, polynomial ODE and
Wronskian1 for reconstructed T, and EXACTLY the same residual as the
older implementation. Every sampled kernel generator has nonzero constant
Wronskian. Data: `Research/computations/wronskian_matrix_pencil.json`.
No emptiness certificate on the full admissible P31 has yet been produced.
