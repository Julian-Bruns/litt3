# Complete exclusion of the degree-seven elliptic quotient

24 September 2026. This local continuation uses the boundary constants
and exact field from [the degree-six proof](degree_six_tensor_exclusion.md).
The new calculation retains both actual maps. Its statement is
[the degree-seven genus-one exclusion](../../Theorems/cartier_and_spin/degree_seven_genus_one_comparison_exclusion.md).

## The single common pole and normalization

The complete d=3 exclusion leaves comparison pole degree d=6.
The improved genus bound leaves \(g(S)=0\) or1. Assume g=1.
There is exactly one common point of the reduced divisors \(h_i^*O\).
On the simultaneous cubic quotient it gives one point Q at which
both x_i have pole order one. The minimal polynomial denominator
therefore has degree one. Q may be a ramification point of the
comparison double cover; that possibility is retained.

Use \(z=\Lambda s\) and \(\varepsilon=\delta\Lambda^3\), with the
normalizations in the boundary proof. The common pole value is
\(r\in\mu_{29}\). In a monic quartic model write
\[
F(z)=\frac{w}{z-r},\qquad w^2=B(z),\quad \deg B=4,\quad B(0)\ne0.
\]
The two functions have the form
\[
x_1=A(z)+b(z)F(z),\qquad z^3x_2=C(z)+d(z)F(z),
\]
where b,d have degree at most two and A,C have denominator z-r and
numerator degree at most four. Their exact poles at zero and infinity
are the same as before. The degree-at-most-two argument still forces
nonzero leading differences at the opposite ends. Consequently all
boundary choices belong to the219,188 previously certified orbits.

At Q the leading ratio \(\lambda=x_2/x_1\) satisfies
\(\lambda^4=\kappa^6s^{-13}\) and
\(\lambda^{17}=\kappa^{21}s^{-48}\). The latter follows from the
theta ratio, because x and theta have leading coordinate weights
-3 and17 at O. Dividing the second equality by the fourth power of
the first gives \(\lambda=\kappa^{-3}s^4\). In normalized coordinates
this gives two necessary residue identities:
\[
d(r)=\varepsilon r^7b(r),\qquad
c_{\rm num}(r)=\varepsilon r^7a_{\rm num}(r).
\]
Here a_num,c_num are the numerator polynomials of A,C.
At a ramified Q the latter identity is zero equals zero, while the
former still compares the leading order-one poles. No division by
the value B(r) is used.

## Equations from both ends

Use the boundary abbreviations
\[
(a,b,c,d,e,f,h,i,j,k)
 =(\alpha_i-\alpha_j,\alpha_k-\alpha_l,F_1,F_2,F_3,F_0,G_0,G_1,G_2,G_3).
\]
In this section lower-case letters are scalars; the two polynomials
b(z),d(z) remain explicitly functions. Write
\[
F=\rho(1+uz+vz^2+\cdots),\qquad
F=z+\ell+m/z+\cdots,\qquad T=\rho/\varepsilon\ne0.
\]
Comparison of the branch differences gives
\[
\begin{aligned}
c&=T(j-\ell h)+ua,&d&=T(i-\ell b)+uf,\\
e&=Th+uc+(v-u^2)a,&k&=f/T+\ell i+(m-\ell^2)b.
\end{aligned}
\]
The two polynomials themselves are
\[
\begin{aligned}
2\varepsilon b(z)&=a/T+(j-\ell h)z+hz^2,\\
2d(z)&=f/T+(i-\ell b)z+bz^2.
\end{aligned}
\]
The coefficient of z^2 in the polynomial
\(B(z)=(z-r)^2F(z)^2\), computed at zero and infinity, must agree:
\[
(\varepsilon T)^2\bigl(1-4ru+r^2(u^2+2v)\bigr)
 =\ell^2+2m-4r\ell+r^2. \tag{1}
\]

Let \(d_+,e_+,j_+,k_+\) be half the corresponding branch SUMS for
F2,F3,G2,G3. The rational functions A,C are determined by their
prescribed five endpoint coefficients. Evaluating their numerators
at r gives
\[
a_{\rm num}(r)=r^3(j_+/\varepsilon-e_+),\qquad
c_{\rm num}(r)=r^2(k_+-\varepsilon d_+).
\]
Thus the second common-residue condition is
\[
\varepsilon(r^8e_+-d_+)=r^8j_+-k_+. \tag{2}
\]
This supplies a condition from the branch averages, in addition to the
branch differences. It is essential to the new exclusion.

## Elimination with all exceptional cases retained

The previous exhaustive boundary certificate gives
\(\Delta=hi-bj\ne0\). Put
\[
\begin{aligned}
T_0&=hd-bc,&T_1&=ab-hf,\\
U_0&=jd-ic,&U_1&=ia-jf.
\end{aligned}
\]
The first two jet equations give
\(T=(T_0+T_1u)/\Delta\) and
\(T\ell=(U_0+U_1u)/\Delta\).
Substitute these in the first common-residue equation. Set
\[
\begin{aligned}
B_r&=b-r^7h,&P_r&=i-r^7j+rB_r,\\
q_0&=\Delta(f-r^7a)+r(P_rT_0-B_rU_0),&
q_1&=r(P_rT_1-B_rU_1).
\end{aligned}
\]
Every model requires \(q_0+q_1u=0\).
The verifier keeps the cases \(q_1=0\), vanishing recovered T,
and both coefficients of (2) zero as explicit unresolved cases until
tested. None occurs in the final surviving configurations.

On \(q_1\ne0\), write \(D=q_1,N=-q_0\), and
\[
P=T_0D+T_1N,\quad Q=U_0D+U_1N,\quad
T=P/(\Delta D),\quad\ell=Q/P,\quad u=N/D.
\]
The symbols P,Q in this paragraph are scalar expressions, not the
endpoint polynomial or the common point. Necessarily P is nonzero.
Define
\[
R_v=e\Delta D-hP-cN\Delta,\qquad
R_m=kP-f\Delta D-iQ.
\]
If a=0, the third jet equation requires \(R_v=0\); if b=0, the
fourth requires \(R_m=0\). The exact certificate excludes every
repeated-endpoint case with one of these conditions.

Otherwise a,b are nonzero. Put
\[
E_n=r^8j_+-k_+,\qquad E_d=r^8e_+-d_+.
\]
The certificate verifies that all unexcluded cases have \(E_nE_d\ne0\),
so \(\varepsilon=E_n/E_d\), and
\[
v=u^2+\frac{R_v}{a\Delta D},\qquad
m=\ell^2+\frac{R_m}{bP}.
\]
After clearing only the displayed nonzero denominators, (1) becomes
\[
bE_n^2P^4L-aE_d^2\Delta^3D^4R=0, \tag{3}
\]
where
\[
\begin{aligned}
L&=a\Delta(D^2-4rND+3r^2N^2)+2r^2R_vD,\\
R&=b(3Q^2-4rQP+r^2P^2)+2R_mP.
\end{aligned}
\]
All formulas use characteristic five, with no ordinary integer-mod25
arithmetic.

## The last726 configurations

Equation (3) vanishes for726 configurations. They are not discarded.
The single common pole means that the pole on the other quadratic
sheet cancels. This is also necessary at a ramified Q, where both
sides below vanish:
\[
a_{\rm num}(r)^2=B(r)b(r)^2. \tag{4}
\]
The same local coefficients give
\[
\begin{aligned}
B(r)&=r^3\{2\ell-r+(\varepsilon T)^2[-2u+r(u^2+2v)]\},\\
\varepsilon b(r)&=\tfrac12[a/T+(j-\ell h)r+hr^2],\\
\varepsilon a_{\rm num}(r)&=r^3(j_+-\varepsilon e_+).
\end{aligned}
\]
Direct exact substitution contradicts (4) in every one of the726
cases. In particular no squarefreeness test or forbidden division
by B(r) hides a ramified common-pole case.

## Exhaustiveness and verification

For each of the219,188 normalized two-end orbit representatives, all29
values of r were checked, for6,356,452 configurations. This may repeat
a full quadruple orbit when the first three phase exponents have a
stabilizer, but omits none. The final exclusion counts are:

| Necessary condition that fails | Configurations |
| --- | ---: |
| Repeated zero-endpoint jet | 1,547,440 |
| Repeated infinity-endpoint jet | 1,170,672 |
| Quartic coefficient equation (3) | 3,637,614 |
| Opposite-sheet cancellation (4) | 726 |
| Unresolved denominator or other case | 0 |

The three-byte record for each configuration stores its stage, a
nonzero field coordinate, and that coordinate's value. Complete
generation and full replay both passed. The certificate SHA256 is
179ecf4197057aaba8857ce2912d2f754e9e1ae71592205f99b25d28bb854fc2.
It occupies19,069,356 bytes before compression and lives in
[the local evidence directory](../../../litt3-computation-data/degree_six_actual_return_20260924/local).

The source [degree7_genus1_boundary.cpp](../../scripts/arithmetic/degree7_genus1_boundary.cpp)
uses the unchanged verified finite-field engine from the previous
reply. A separate [reference verifier](../../scripts/arithmetic/verify_degree7_genus1_reference.py)
reduces the two field moduli in the opposite order. It independently
checks every one of the726 final-stage cases, plus a deterministic
selection of other exact records. The
[symbolic audit](../../scripts/arithmetic/audit_degree7_genus1_formulas.py)
checks the jets, common residues, equation (3), and the independently
cleared form of (4). Their logs and exact scope accompany the certificate.
The supplementary checks do not replace exhaustive replay.

No arbitrary model coefficient was restricted to a finite field.
Every actual model forces the finite boundary choices and the scalar
equations above; exceptional denominator cases were checked explicitly.
The resulting contradiction excludes genus one. The rational-quotient
case has degree-three branch-difference polynomials instead of degree
two; it is now excluded by its own
[separate proof](degree_seven_rational_comparison_exclusion.md).
