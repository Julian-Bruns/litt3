# Proof of the two-profile degree-ten reduction

Use the [accepted degree-ten setup](admissible_degree_ten_trace_zero.md).
The original new report, complete coefficient recipe and executed
certificates are retained in
[degree10_etale_sector](../../../litt3-computation-data/actual_frontier_trial_replies_20260925/extracted/degree10_etale_sector/REPORT.md).
The [integration audit](../../Research/audits/ACTUAL_FRONTIER_TRIAL_REPLIES_2026_09_25.md)
records focused proof review and independent execution of its verifier.
This proof concerns only a_1=0,a_2!=0.

## Infinity and the two coefficient comparisons

Etaleness splits the completed algebra above O into ten base fields.
At each of the five selected points, ord(q)=-7=ord(f), and q=f+b^5
forces pole(b)<=1. At an unselected point with G-multiplicity m_i,
pole(q)=10+5m_i>7, so pole(b)=2+m_i. Also sum m_i=10-3d.
The [paired-coefficient gap](paired_coefficient_pole_gap.md) with m=5,
h=7,s=1 shows pole(a_4)<=17-3d and excludes exactly four positive m_i.
This already excludes the only quadratic-v profile (1,1,1,1), all its
finite collision cases, the linear profile (2,2,2,1), and three of the
constant profiles. No calculation on a finite set of r-values is used.

For the support omitting alpha, where
alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5]=0, write N_i=y^i v a_i.
The exact coefficient identity on the full trace-zero kernel is
\[
[x^{12}y]N_3=([24]+[4]\alpha+[23]\alpha^3)\kappa\ne0.
\]
The certificate gives65 nonzero row weights expressing this identity
in the302 defining linear rows; every entry has been reconstructed and
checked. Scalar extension proves the identity geometrically. The other
three supports follow by coefficient Frobenius. Since N_3 is in L_46
and x^12 y is its unique monomial of pole46, pole(a_3)=16-3d.

For the constant profiles (3,3,2,1,1) and (2,2,2,2,2), the sum of the
three largest b-poles is14 or12, respectively. This bounds pole(a_3)
above and contradicts16. The established list is therefore exhausted
except for the two rows in the statement. Their three-largest sums
are16 and13, exactly the forced poles, so this comparison stops there.

## The torsion function cannot factor through a quadratic cover

The actual divisor of h^*t_B is E+E^c-10H. Thus 2E~10H is equivalent
to existence of rho with divisor E-E^c. This function has degree50
and is separating because its zeros and poles are simple. Put
M=k(X)(rho), with smooth model D, and ell=[k(S):M]. Both intervening
maps are etale by multiplication of ramification indices in the
separable tower. Each selected base point has exactly five zeros and
five poles upstairs, so ell divides5. Consequently [M:k(X)] is2 or10.

In the quadratic case scale rho so its norm to k(X) is1, and set
lambda=rho+rho^-1. Its pole divisor on X is exactly B. Then
g=t_B lambda has sole pole10 at O and is a unit at every finite point
of B. The L_10 basis gives g=a y+p(x), a!=0, deg p<=3. The defining
quadratic discriminant is
\[
\lambda^2-4=(g-2t_B)(g+2t_B)/t_B^2.
\]
Etaleness makes its valuation even everywhere. The two numerator
factors have no common finite zero; both have even pole10 at O.
Each factor consequently has an even divisor. Cubic norm to k(x)
and rescaling give a prohibited identity P+((p+/-2t_B)/a)^3=J^2,
deg((p+/-2t_B)/a)<=3. The accepted square-norm exclusion applies.
Thus [M:k(X)]=10. Finally adjoining y to k(x,rho) has degree1 or3
by Kummer theory, while that index also divides50. It is1.

## Discriminant and generic failure

For polynomial v set
\[
\mathcal F(Z)=(Z^5+Q)(vZ^5+N_2Z^3+N_3Z^2+N_4Z+N_5)
 +\kappa t_B^3y^{10},\qquad
D(Z)=3N_2Z^2+2N_3Z+N_4,
\]
and mathcal R=Res_Z(mathcal F,D). Taking the discriminant of the
MONIC polynomial mathcal F/v and then changing Z=yb gives
\[
\operatorname{disc}(F_b)=-\kappa^5t_B^{15}\mathcal R/(v^{17}y^{40}),
\quad
\operatorname{Nm}_{k(X)/k(x)}\operatorname{disc}(F_b)
=-\kappa^{15}t_B^{45}\operatorname{Nm}(\mathcal R)/(v^{51}P^{40}).
\]
This uses derivative degree7 in characteristic5; a degree9 formula
would give a wrong exponent. At an etale fiber the discriminant is
the square of a local Vandermonde. Its norm has an even divisor on
P1, hence is a square. No assertion that the discriminant itself is
globally square on X is used.

The remaining coefficient inequalities give
\[
R_0=\operatorname{Nm}(\mathcal R)/(P^{40}t_B^{15})\quad(v=1),
\qquad
R_0=\operatorname{Nm}(\mathcal R)/(P^{40}t_B^{15}v^3)\quad(v=x-r).
\]
These are polynomials of degree at most144. Here is why the division
is uniform rather than sample evidence. At selected finite points the
shifted Newton polygon has five roots of valuation at least1 and five
units, giving discriminant order at least20, and norm order at least60.
At ordinary P-roots all shifted roots are integral. At the selected
linear-v P-root the pole budget is at most three, with each root pole
at most1, so the discriminant pole is at most48. The infinity root
poles in the statement bound discriminant poles by324 and276. Removing
the fixed t_B^60 contribution gives degree144 in both cases. These
valuation bounds hold over the generic coefficient field; division
by fixed monic polynomials extends the resulting identities to all
specializations. The retained report gives the shifted coefficient
inequalities that establish these Newton bounds explicitly.

The norm displayed above becomes -kappa^15 t_B^60 R_0 in the constant
case, and that expression divided by v^48 in the linear case. The
remaining factors are squares over the algebraic closure. Thus R_0
must be a nonzero square. The reconstructed coefficient spaces have
homogeneous dimension8 before fixing v, hence affine dimension7.
For each of the eleven fixed-v spaces one exact example has R_0 of
degree144 and gcd(R_0,R_0')=1. Nonvanishing of the leading coefficient
and discriminant is a nonempty open condition, dense in these affine
spaces. This proves generic failure, not emptiness of their exceptional
closed subsets. All thirteen supplied examples were independently
regenerated; no bounded search is promoted to a geometric exclusion.
