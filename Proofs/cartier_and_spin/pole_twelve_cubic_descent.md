# Pole twelve: a local character obstruction replaces the case analysis

Use the ACTUAL comparison in
[the statement](../../Theorems/cartier_and_spin/pole_twelve_cubic_descent.md).
Normalize its parameter t so that
\[
A(x_2)=\epsilon^4t^{-13}A(x_1),\qquad
\theta_2=\eta t^{16}\theta_1,\qquad \eta^3=\epsilon^{-17}.
\]
Both finite etale maps have the same jointly minimal smooth proper
source T. Thus M=k(T)=K_i(t), where K_i=k(x_i,y_i), and
N=k(x_1,x_2) contains t and y_2/y_1; [M:N] is one or three.

## Invariant norms and balanced endpoint germs

The parameter has twelve simple zeros and poles. The
[marked-divisor theorem](marked_divisor_relation_lattice.md)
makes both supported norms polynomials in their x-coordinates.
Their degree is four. Thus at each A-root alpha, a t-zero endpoint
has m_alpha branches on EACH cubic sheet, with sum m_alpha=4.

The self-contained modular part of
[the regular-form phase theorem](unbounded_modular_phase_balance.md)
makes their phase counts equal modulo five. Each count is at most
four, so equality is already integral. The same theorem derives
the actual two-jets directly from the normal form. At a fixed alpha,
all slopes are nonzero and lie in one scalar multiple of mu29,
and the second coefficient depends only on the slope, not the
cubic sheet. No short-phase or endpoint-label search is used.

The coefficient bound for the actual minimal polynomial is
L(min(j,12)O). Since L(12O)=span(1,x,x2,x3,x4,y), each leg's
equation, with Z=t or t^-1, is
\[
F_i(X,Y,Z)=F_{i0}(X,Z)+YH_i(Z),\qquad \deg H_i\le n-10.
\]
Here F_i is the actual monic irreducible polynomial of degree n
over K_i. We exclude a nonzero H_i at any occupied endpoint.
The argument does not transport character terms between the legs.

## The sheet-independent endpoint derivation

Fix alpha with m=m_alpha>0 and suppose H!=0. Put X=alpha+t z.
At a slope a, let C(z) be the monic polynomial of the m actual
slopes, counted with multiplicity, identical on the three sheets.
Writing rho3=P(alpha), their equations after division by t^m are
\[
\mathcal F_s(z,t)=E(z,t)+\rho\zeta^s t^\nu L(z,t),\qquad
E(z,0)=cC(z),\quad L(z,0)=h\ne0,\quad
\nu=\operatorname{ord}_0H-m>0,\quad c\ne0.
\]
These assertions retain the actual branches. Their local equations
are units times products of the distinct source germs. Substitution
X-alpha=t z sends the arguments of each Weierstrass unit to(0,0),
so its value at t=0 is constant in z. The common leading coefficient
comes from F(X,0), hence is independent of the cubic sheet.
If a slope has multiplicity r, evaluation at its common two-jet
gives ord H>=m+2r: r factors vanish to order at least three and
the other m-r to order at least one. This proves nu>0, including
repeated slopes. Since the character is YH(t), its leading
numerator h is constant in z.

The A identity expresses the opposite pole coordinate through z
by an invertible analytic change. The uncubed differential identity
gives a regular derivation
\[
\mathcal D=t\partial_t+J(z,t)\partial_z
\]
preserving every actual reduced branch factor. It is the same on
all three cubic sheets: the analytic ratio of the two cubic
coordinates is selected by the leading differential equation,
and simultaneous multiplication by zeta cancels in that ratio.
Its denominator has value three and is a unit.

For the needed two terms, let w0 be the analytic twelfth root
with w0(a)=1 and w0^12=(z/a)^29. Direct differentiation of
z=const*v^4 at t=0 gives
\[
J(z,0)=\frac{3z(w_0-1)}{1-3w_0},\qquad
J(a+h,0)=2h+\frac{2h^2}{a}+O(h^3).
\]
This calculation uses only inverses of2,3,12. J is needed locally
at each slope; no globally rational J or characteristic-zero
uniqueness argument is assumed.

## Two Fourier characters force an impossible slope polynomial

Since every reduced factor is preserved,
D mathcalF_s/mathcalF_s is regular near each actual slope.
Fourier projection in zeta preserves this regularity. Put
R=h/(cC). Its first nontrivial character, at t^nu, is
\[
L_\nu=\nu R+J(z,0)R'.
\]
At a slope of multiplicity r, R has pole order r, so its leading
Laurent coefficient forces nu=2r modulo five. Since1<=r<=m<=4,
all slope multiplicities at this root are the same integer r.
Thus C=D^r, where D is monic squarefree of degree d=m/r<=4.

Write R=A_a h^-r+B_a h^(-r+1)+... at a root a of D.
The next Laurent coefficient in L_nu is2B_a-2rA_a/a. For r>=2
regularity makes it zero. For r=1, the second cubic character at
order2nu is exactly -R L_nu, so regularity gives the same conclusion.
Indeed the original equation has only invariant and first character:
expanding D(W)/(1+W), W=rho*zeta^s*t^nu*L/E, the second character
first occurs as -W D(W); its next occurrence has order at least5nu.
No other term contributes at order2nu.

Therefore B_a/A_a=r/a. Expanding h/(cD^r) independently gives
B_a/A_a=-r sum_(b!=a)1/(a-b). Since r!=0 in characteristic five,
\[
aD''(a)+2D'(a)=0\quad\text{at every root},\qquad
zD''+2D'=0.
\]
The last polynomial has degree at most d-1. Its leading coefficient
is d(d+1), forcing d=4. The lower coefficients then force
D=z4+constant. Its four distinct nonzero roots have ratios in mu4,
whereas actual slopes have ratios in mu29. As mu4 intersect mu29
is{1}, this is impossible. Hence H_1=H_2=0.

## Cubic quotient and preservation of both actual maps

With H_i=0 the same irreducible minimal polynomial is defined over
k(x_i), and M/k(x_i,t) is the actual cyclic cubic extension adjoining
y_i. Its generator fixes t and scales theta_i by zeta. The normal
form then makes theta of the other map proportional to its conjugate.
[Theta recognition](new_line_comparison_normal_form.md) fixes the
other x-coordinate too. Thus the generator fixes N, and [M:N]=3.
Consequently N=k(x_1,t)=k(x_2,t)=k(x_1,x_2).

The quotient S has deg t=4 and deg x_i=n. Its invariant minimal
polynomial lies in the same Newton triangle as in
[low-pole reconstruction](new_line_low_pole_reconstruction.md);
counting interior points gives g(S)<=3n-21. The contact bound
gives12<=n<=186. Neither bound entered the character exclusion.

Conversely, take the reconstruction data in the statement with
k(S)=k(u,v)=k(u,t)=k(v,t) and the stated degrees and ramification.
The noncube condition makes the normalization y3=P(u) connected.
Its maps (u,y),(v,ry) both have degree n. At a cubic branch value,
the local index over X is e/gcd(3,e)=1 for e=1 or3; elsewhere it is
one by hypothesis. Thus both maps are everywhere etale, including
infinity. The differential equation gives theta2=eta t16 theta1,
and the A equation gives proportional tensors.

The joint endpoint fields generate k(S)(y). They are distinct:
equality would differ by an automorphism of X, whose cubic group
fixes x, forcing u=v and then t constant. The theta divisors give
div t=h2*O-h1*O, so its pole degree on T is12. This proves actual
two-map reconstruction, not only necessity of the equations.

The quartic parameter field has normal closure of degree dividing24.
Adjoining the cube roots of its at most four conjugates of P(u)
adds an abelian3-group of order dividing3^4. The resulting normal
closure has solvable group of order dividing1944, prime to five.
It can ramify over T and is not a simultaneous etale refinement.

## Evidence and later scope

The later endpoint-character mechanism replaces the old transported
character congruence and all three norm-pattern cases. Their source
algorithms are deleted completely. Original proofs, source hashes and
finite certificates remain in
[the external provenance](../../../litt3-computation-data/endpoint_phase_before_hindsight/)
and [the original reply](../../../litt3-computation-data/structural_norm_replies_20260924/extracted/comparison_delta12/).
The only new arithmetic execution reconstructs the five small
determinants of the independent phase foundation; no old certificate
is replayed. Actual maps, repeated phases and geometric scalars remain.

The [later complete pole-twelve theorem](pole_twelve_complete_exclusion.md)
excludes the quartic branch as well. This descent lemma supplies its
index-three input and does not extract a shared tensor from an
arbitrary unmarked common cover.
