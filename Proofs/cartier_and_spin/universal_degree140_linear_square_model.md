# The missing index125 is an explicit carry, not an extra hypothesis

27 September2026. Work over an arbitrary commutative characteristic-five
ring R. Every series with constant coefficient one is a unit. Since
alpha^625=1 modulo T^141, the exponent313 is an inverse of two on the
multiplicative group of such truncated series:
\[
(\alpha^{313})^2=\alpha\pmod{T^{141}}.
\]
The square root with constant coefficient one is unique: if U^2=V^2
in this truncated ring and U(0)=V(0)=1, then U+V has constant
coefficient2 and is a unit. Thus U=V. Consequently
\[
B^2=\alpha\quad\Longleftrightarrow\quad
B\alpha^{-313}=1\pmod{T^{141}}.
\tag{1}
\]
For the reverse implication, the congruence B^2=alpha is an equality
because the difference has degree at most140. No reducedness assumption
enters this proof.

Within the same truncated ring alpha^-313=alpha^312, and
\[
\alpha^{312}=\alpha^{62}\alpha^{250}
 =\alpha^{62}(1+2\alpha_1^{125}T^{125}).
\]
The last factor has inverse1-2 alpha1^125 T^125. Thus(1) is exactly
\[
B\alpha^{62}=1+3\alpha_1^{125}T^{125}\pmod{T^{141}}.
\tag{2}
\]
In particular, the apparent contributions at indices126,...,140 are
already handled by the same lower equations; they are not discarded.

The coefficient matrix on B1,...,B70 in the first70 rows of(2) is
unit lower triangular. In this range alpha^125=1, so its solution is
B=alpha^-62=alpha^63 modulo T^71. Substitution in rows71,...,140
is an isomorphism of the quotient coordinate rings, not only a
bijection of geometric points. It commutes with every base change.
There are exactly70 residual generators.

An even shorter eliminated presentation is
\[
[T^n]\alpha^{313}=0,\qquad71\le n\le140.
\tag{3}
\]
Indeed alpha^313 is the unique normalized square root in the truncated
ring. Writing C_n=[T^n]alpha^63 gives the equivalent circuits
C_n=0 for71<=n<=124, and
C_n+2 alpha1^125 C_(n-125)=0 for125<=n<=140. Thus the sixteen late
conditions are kept explicitly, without growing the exponent in an
implementation. This is an exact change of generators, not a further
relaxation.

More generally, for any odd prime p, degree bound d and p^e>d, a
normalized polynomial of degree d is a square of degree at most
floor(d/2) precisely when
B alpha^(-(p^e+1)/2)=1 modulo T^(d+1). This is a linear system in
the root coefficients. The small carry in(2) is the specific useful
form at p=5,d=140; the general observation alone is not an emptiness
criterion.

## Relationship to the received Hasse model

The received model omits index125 from B/alpha^63 through index148.
It kills the omitted carry using the hypothesis that alpha16,...,
alpha23 generate1. The model(2) instead keeps and fixes that carry
explicitly. For the trap alpha=1+T^125,B=1, its125th equation is
nonzero, whereas the older rows without their unit hypothesis vanish.
The same statement holds for alpha=1+epsilon T^125 over
R=F5[epsilon]/epsilon^2: nilpotent discrepancies are retained.

For the actual double-root family, alpha=Astar/L and L is already
inverted on the original open. The source bounds give
4 deg_nu(alpha_i)<=3i and deg_nu(alpha1)=0. Each new residual has
scale degree at most floor(3n/4)<=105. This bound is larger than
the established82 for the older77 Hasse generators. The uniform
model removes a hypothesis and applies to the primitive constant
family, but is not claimed to dominate the old model computationally.

The complete ideal in either actual family is still OPEN. Normalizing
by L retains the known nonzero-leading-coefficient chart and introduces
no new denominator. Over geometric fields, multiplying a polynomial
by its nonzero leading coefficient does not change existence of a
square root; over a general base the assertion concerns the stated
normalized square scheme only.

## Verification

The proof above is universal ring algebra. A fresh independent proof
audit is recorded in the current research audit. The standalone
[implementation check](../../scripts/arithmetic/verify_universal_degree140_square_model.py)
compares the new carry model with the independent coefficient-by-
coefficient square-root recurrence over a finite extension and a
dual-number algebra. It includes exact squares, arbitrary polynomials,
late nilpotent perturbations and the omitted-carry trap. Its bounded
checks validate the implementation, not either open global ideal.

Both base-ring tests passed: three exact squares and thirteen nonsquares
or late perturbations over F625, and the same counts over its dual numbers.
The initial larger exploratory test was stopped for efficiency and is not
credited. The completed focused run is verification.json in the external
universal_degree140_square_model_20260927 directory.

The [actual-family check](../../scripts/arithmetic/verify_actual_universal_degree140_model.py)
uses the complete length-nine ratio algebra at u=1 and a polynomial scale.
It independently reconstructs the first70 root coefficients by the usual
quadratic recurrence. All70 square errors equal the unit triangular
convolution3 sum_(j=71)^n B_(n-j) [T^j]alpha^313, with every late
coefficient retained. This checks the exact generator change on an actual
complete algebra, not only on randomly chosen field points. Its maximum
observed scale degree is105; the receipt is actual_u1.json in that directory.
