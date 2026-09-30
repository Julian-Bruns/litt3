# Proof: the full common-critical algebra and its scale obstructions

[Statement](../../Theorems/cartier_and_spin/degree140_common_critical_exclusion.md).
The [complete received report](../../../litt3-computation-data/critical_descent_replies_20260927/extracted/common_critical/common_critical/REPORT.md)
defines the original155-variable source, reconstructs its rank149
linear system and infinity normalization, and gives every exact
certificate format. The present record distinguishes the complete
finite algebra from any bounded field search.

## Scheme-preserving critical equations

The fixed coefficient field is K=F25(alpha), with beta^2=beta+3 and
alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5]=0. Coordinates and codes
are those of the compact norm. Write
G_i=w U_i(x)+y V_i(x)+(y^2/w^4)Z_i(H,q,x), with
U2=k0 P,k0=3794,V2=0. Put Z=Z2. All divisions in
\[
\begin{aligned}
A_3&=(U_3-3B_0U_2)/P,&B_3&=V_3/P,&C_3&=(Z_3-3B_0Z_2)/P,\\
A_4&=(U_4-2B_0U_3+3B_0^2U_2)/P^2,&
B_4&=(V_4-2B_0V_3)/P,&C_4&=(Z_4-2B_0Z_3+3B_0^2Z_2)/P
\end{aligned}
\]
are EXACT polynomial divisions; P is not inverted. With v=y/w,
qv^3=P, the conditions g2=g3=g4=0 are equivalent to
\[
\begin{aligned}
Z^3+q^5k_0^3P&=0,\\
C_3Z^2-q^3k_0B_3Z+q^5k_0^2A_3&=0,\\
A_4Z^2-k_0C_4Z+q^3k_0^2B_4&=0.
\end{aligned}
\tag{1}
\]
Indeed w^4g2=Z+q^2k0 v eliminates v using only the unit q^2k0.
These equations have431,391,241 nonzero coefficient records.
Use r for the incidence point's x-coordinate and X for the
INDEPENDENT residual variable; r is never substituted for X.

## Entire localized incidence, including its scheme structure

Adjoin s and the relation s*q*t(r)-1 to(1). The retained derivation
DAG proves ideal membership for every one of the65 claimed Groebner
generators. The reverse input containment and all2080 S-pairs are
checked independently. The standard monomials give dimension116.
Multiplication matrices yield a shape presentation K[q]/F(q), with
H,r,s polynomial in q. F is squarefree with irreducible factor
degrees1,3,7,11,94. These assertions identify the whole localized
algebra, rather than selected points or its reduction alone.

Exact inverse certificates make H,q,P(r),t(r),Psi,a0,q-15383,q-1
units in this algebra. A separate branch Bezout identity excludes
P(r)=0 without first reducing the branch incidence. Thus the
absence of branch points is proved, not assumed. No required open
stratum or nilpotent component is silently discarded.

## Full residuals and two coprime square equations

The primitive change Z=yW-B0 gives the fixed-degree identities
f_lambda(yW-B0)=y^10 fbar_lambda(W),
S'(yW-B0)=y^4 Sbar'(W), and
Res(f_lambda,S')=y^40 Dbar. On each of the five incidence fields
set ell=q^3 mu. The regenerated residual S(ell,X) satisfies
\[
S(\ell,X)=q^3\mathcal R(H,q,\ell/q^3,X),
\tag{2}
\]
where calR is the specified globally normalized degree140 residual.
The harmless nonzero scalar does not alter geometric squareness.
The seven possible scale powers have X-degrees
(140,138,137,136,133,131,129), and the leading coefficient is a
certified unit in every component field.

The universal fixed-degree resultant identity is verified before
specialization, including drops in its quadratic leading coefficient.
Residual interpolation is then checked by a DIFFERENT polynomial
identity test: the explicit norm numerator has X-degree at most460,
and equality is checked at624 distinct nodes. No denominator at t
is used in this identity check. Thus this proves each entire
polynomial, not merely its values at sampled parameters.

Let L be its leading X-coefficient and
\[
C_j=[T^j]\left(T^{140}S(\ell,T^{-1})/L\right)^{63}.
\]
Since 2*63=126=1 modulo125, this computes the formal square root
through degrees below125. A polynomial square of degree140 must
satisfy C71=C72=0. In every one of the five component fields these
are degree47 polynomials in ell, and the archive gives degree46
polynomials U,V with
\[
U C_{71}+V C_{72}=1.
\tag{3}
\]
Independent multiplication checks(3), while formal square-root
recursion checks the coefficients. It follows that no geometric
scale works on any component, including ell=0. A finite-type
nonempty thickening has a geometric point; in fact the stronger
unit identities already prove the empty square incidence scheme.

## The affine critical double cover has no vertical fiber

The new calculation concerns t!=0. At t=0 the earlier endpoint
certificates excluded the ENTIRE incidences Acal=Bcal=0 and
Bcal=(Ccal/t)=0 against the square ideal; they did not merely
test points already known to have higher content. Here
Acal,Bcal,Ccal are the cubic coefficients after translating by L0.

The critical quadratic is zero in the fiber exactly when all
three coefficients of the derivative vanish. Translating its
variable preserves that condition. At t=0, y is a unit, so changing
between the barred and original primitives preserves it too.
Thus g2=g3=g4=0 there implies Acal=Bcal=Ccal=0, in particular the
already excluded Acal=Bcal=0 incidence. This proves the extension
to every affine point, without a new numerical calculation.

The homogeneous polynomial
3g2 U^2+2g3 UV+g4 V^2 consequently defines a nonzero length-two
divisor on every projective-line fiber. Its zero scheme is proper
and quasi-finite over the affine curve, hence finite. The relative
effective Cartier divisor of constant degree two is flat; equivalently
this follows in local monic charts. Generic nonsplitting is an
established input. Neither reduced fibers nor etaleness follows.

## Local verification and provenance

The full23-stage replay and all21 regenerated-file comparisons
passed on this Mac. It includes original source reconstruction,
the1522-node provenance DAG,468408 exact reductions, all S-pairs,
the whole quotient, factor tests, branch and open units, all five
residual polynomial identities, and all five Bezout certificates.
No Buchberger discovery search was needed. The unchanged source
required only the local Boost include path for its C++ compilation.

Original evidence and the complete local verification receipt are
under [the external evidence directory](../../../litt3-computation-data/critical_descent_replies_20260927/).
Byte-identical source is retained in
[the source directory](../../scripts/arithmetic/pro_critical_descent_20260927/common_critical/verify.py).
See [the integration audit](../../Research/audits/CRITICAL_DESCENT_REPLIES_2026_09_27.md)
for versions, hashes and the exact command.
