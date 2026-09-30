# Proof: differentiate the actual locally split source polynomial

30 September2026.
[Statement](../../Theorems/cartier_and_spin/degree140_actual_split_derivative_traces.md).
The input local charts and pole profiles are Sections3,4 and12 of the
[accepted normalization report](../../../litt3-computation-data/september29_evening_replies/actual_ramification/REPORT.md).
Their computations are not replayed. The argument here adds the local
splitting of the ACTUAL source, which the ramification-only trace
criterion did not use at branch points of C->X.

## Actual splitting removes the eta factor

At an affine base point p let R=k[[r]]. The actual etale source splits
over R, and its source coordinate is integral in the regular affine
model. With lambda fixed and nonzero the leading coefficient is the
unit lambda. Hence
\[
F_\lambda(W)=\lambda\prod_{i=1}^{10}(W-u_i),\qquad u_i\in R.
\]
Consider a normalized critical point above p in the lambda fibre.
The accepted chart theorem gives a finite W=c and a unit phi(c).
Since F_lambda(c)=0 in the residue field and its W derivative vanishes,
at least two of the u_i have residue c. The derivation delta0 preserves
R. Differentiating coefficients with W fixed gives
\[
(\delta_0F_\lambda)(c)
 =-\lambda\sum_i(\delta_0u_i)\prod_{j\ne i}(c-u_j).
\]
Every summand has positive valuation on the normalized critical branch:
even after removing one factor, a coincident root remains. Thus this
function vanishes at the point. The identity
F_lambda=phi^2*(lambda-Lambda), differentiated on the critical curve,
now gives delta0F_lambda=-phi^2*delta0Lambda in the residue field.
It follows that delta0Lambda vanishes. No division by eta, the
ramification index, or the source degree is used.

## Regularity and degree bounds

At a finite nonzero Lambda value, the same chart theorem gives phi a
unit, and coefficient differentiation with W fixed shows that both
delta0Lambda and delta0Lambda/phi are regular. This also covers branch
points of C->X: the W-derivative is zero, so differentiating the critical
coordinate does not introduce its apparent discriminant denominator.

At scale zero, a critical-coordinate pole is handled by Z=1/W.
The accepted expansion of Lambda has regular coefficients and starts
with Z^3 on the critical curve; before using the critical equation its
partial coefficient derivative starts with Z^2. Thus delta0Lambda is
regular there. Dividing by phi, which has a pole at Z=0, preserves
regularity. All finite-coordinate points at scale zero are handled
as before. The only phi=t=0 branches are Lambda poles of types A and B.
Consequently both trace functions are regular on the entire affine
Lambda line, and hence polynomial.

Let e be the pole order of Lambda at an affine point of C and let
r_pi in {1,2} be its ramification index over X. The differential
dx/(3y^2) is a unit at the affine base point and has pullback order
r_pi-1. Therefore
\[
\operatorname{pole}(\delta_0\Lambda)\le e+r_{\pi}.
\]
At an ordinary phi zero away from t=0, write s=ord(phi)>0.
Then e=2s, and dividing by phi gives pole at most3s+r_pi.
Their trace-degree contributions are at most two. At a type-A endpoint,
(e,r_pi,s)=(1,1,3), giving bounds two and five. At a type-B endpoint,
(e,r_pi,s)=(5,2,5), giving bounds one and two. These exhaust the affine
poles. An affine regular multiplier f cannot worsen these bounds.

Over O the map C->X is unramified. The base differential has order16,
and the Lambda pole orders are4 and7, neither divisible by5.
Thus delta0Lambda has exact pole orders21 and24. The phi pole orders
are20 and7, giving bounds1 and17 for delta0Lambda/phi. Adding the
pole bound p of f and using the local trace inequality
pole(Tr(g))<=floor(pole(g)/e) proves the statement.

For actual lambda, the trace specializes to the trace of multiplication
on the finite fibre algebra. The functions just constructed vanish at
every point of that fibre, so their multiplication operators are
nilpotent. Their traces are zero, including nonreduced fibres and wild
ramification. This proves the necessary equations.

## The quintic leading coefficient needs two infinity terms

Write Lambda=c0*z^-4+c1*z^-3+O(z^-2) at O4. There is no z term
in Y, because Y^3 is a power series in z^3. Direct residue expansion
therefore gives
\[
[\ell^5]\widehat T_1=3c_1c_0^{-5}.
\]
Only O4 contributes: the other infinity has trace degree at most
three, and the finite contributions have degree at most two.
In the fixed family's incoming coefficient convention, its two jets are
\[
c_0=\langle164100\rangle h^3,
\qquad c_1=\langle259583\rangle h^3w.
\]
Consequently the coefficient is <333905>*w*h^-12, a unit on the
original chart. This particular calculation is reproduced by the
[two-jet source](../../scripts/arithmetic/degree140_actual_derivative_leading_20260930.sage)
from the accepted448-term family. The
[compact output](../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/actual_derivative_leading.json)
records the exact coefficients and agreement with the independent,
longer new top-coefficient construction. The two-jet computation
takes1.47 seconds on one core; its result does not depend on any
unfinished parameter-ideal calculation.

## The degree-six coefficient is a single residue

The coefficient of ell^n in the polynomial trace of g is
-sum Res(g*dLambda/Lambda^(n+1)) at the Lambda poles. For
g=x*delta0Lambda and n=6 only O4 can contribute. Write
\[
x=z^{-3},\quad y=z^{-10}Y,\quad Y(0)=1,\quad
\frac{dx}{3y^2}=-z^{16}Y^{-2}\,dz,\quad
\Lambda=c z^{-4}+O(z^{-3}).
\]
In characteristic five Lambda'=c*z^{-5}+O(z^{-4}). Hence
\[
\frac{x\,\delta_0\Lambda\,d\Lambda}{\Lambda^7}
=-c^{-5}z^{-1}\,dz+O(1)\,dz.
\]
Negating the residue gives c^-5. Its nonvanishing follows from the
established exact pole order four, so no new parameter boundary is
discarded. The other infinity contributes degree at most three for
this multiplier, and every finite point contributes at most two.

Focused review: retained the actual locally split monic polynomial;
checked regularity at critical-coordinate infinity and both endpoint
types; kept the quadratic ramification in the vector-field pole bound;
and computed both leading residues including their signs. Only the
fixed two-jet coefficient identification uses exact arithmetic. The
larger top-coefficient matrix is a subsequent application, not a
premise of the local splitting or degree-bound arguments.
