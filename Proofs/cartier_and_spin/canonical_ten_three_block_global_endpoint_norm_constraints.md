# Proof: global endpoint norms, Hermite jets and normalization budget

Version1, 3 October2026. [Fresh independent whole audit PASS, all eight checks](../../Research/audits/OCT03_GLOBAL_THREE_BLOCK_ENDPOINT_NORM_HERMITE_WHOLE_AUDIT_2026_10_03.md), with no required mathematical correction. This faithfully records the reviewed [research note](../../Research/notes/oct03_ten_hour/three_ten_blocks_global_source_next.md). See the [statement and actual-source hypotheses](../../Theorems/cartier_and_spin/canonical_ten_three_block_global_endpoint_norm_constraints.md). No numerical certificate is needed for this proof.

Write c=deg J=d−15, and L(mO)=H0(X,O_X(mO)). All endpoint functions below are identified with functions on the fixed X when taking that endpoint's norm. The two actual étale maps remain on C throughout.

## 1. The actual coordinate fields

Let F=k(x1,z). The quadratic q identity and k(C)=k(x1,x2,z) give [k(C):F]≤2. The element y1 satisfies y1³=P(x1) over F. Since k contains all cube roots of unity, a polynomial Y³−P(x1) either has a root in F and splits completely, or is irreducible of degree three. The degree of y1 over F is therefore one or three; it also divides [k(C):F]. Thus y1∈F and F contains the actual first endpoint field.

If [k(C):F]=2, characteristic five makes this quadratic extension separable. Its nonidentity involution ρ fixes z and the first endpoint field, so fixes theta1. The identity theta1=κz⁸theta2 makes theta2 invariant too. The accepted [scalar-one theta recognition](new_line_comparison_normal_form.md), applied to the actual finite étale maps h2 and h2∘ρ, makes these maps equal. Thus ρ fixes x2,y2, as well as x1,z. The index-one generation k(C)=k(x1,x2,z) then makes ρ the identity, a contradiction. Hence k(C)=k(x1,z). Interchanging the endpoint labels proves k(C)=k(x2,z)=k(x2,1/z).

This is the field argument of [the earlier nonsplit bridge proof, §6](canonical_ten_nonsplit_twenty_bridge_exclusion.md). It uses neither that proof's low-genus boundary nor Hom vanishing.

## 2. Both monic norms and their coefficient poles

Put v2=z and v1=1/z. The previous section gives k(C)=h_j*k(X)(vj), and the endpoint extension is separable of degree d. Therefore
\[
N_j(T)=\operatorname{Norm}_{k(C)/h_j^*k(X)}(T-v_j)
\]
is the minimal polynomial of vj: it is monic, irreducible and separable of degree d.

At a geometric endpoint point, étaleness and the algebraically closed residue field split the completed endpoint algebra into d copies of k((u)). Thus Nj is the product of T minus its d local root functions. Over O, fifteen roots have pole two: they are the branches D2 for v2 and D1 for v1. All other roots are regular. An elementary symmetric product of s roots therefore has pole at most 2 min(s,15). Summation cannot worsen the bound. Over a finite endpoint point every root is integral, because vj has no pole above it. There are no finite coefficient poles. Consequently
\[
n_{j,s}\in L(2\min(s,15)O).
\]
This concerns the actual whole extension, independently of any companion's finite local type.

## 3. Values, Hasse derivatives and the five-point balance

Fix a³=1. At endpoint O the product N2(a) has fifteen factors of order −2, ka factors of order four, and c−ka nonzero constant factors. Every leading coefficient is nonzero. Since this is a single product, its valuation is exactly
\[
\operatorname{ord}_O N_2(a)=-30+4k_a.
\]
Inversion preserves the common order four and exchanges the residual pole divisors. The same argument gives ordO N1(a^{-1})=−30+4ka.

At ka=5 both functions have exact pole ten. The semigroup ⟨3,10⟩ gives
\[
L(10O)=\operatorname{span}_k\{1,x,x^2,x^3,y\}.
\]
The y coefficient is nonzero, since every polynomial of degree at most three in x has pole at most nine. Hence Nj(tj(a))=Aj,a y+gj,a(x), Aj,a≠0 and deg gj,a≤3.

At a full value the actual Q-fiber 2Aa+Ba gives the exact source divisor
\[
\operatorname{div}_C(z-a)=4J_a+\pi^*B_a-2D_2.
\]
Its reciprocal counterpart is
\[
\operatorname{div}_C(1/z-a^{-1})=4J_a+\pi^*B_a-2D_1.
\]
Norm pushes principal divisors along the relevant actual endpoint map. The five common points contribute 20O, and the fifteen residual pole points contribute −30O. Thus in both orientations
\[
\operatorname{div}_X N_j(t_j(a))=(h_j)_*(\pi^*B_a)-10O.
\]
The pullback π*Ba retains the weight two of a fold; no reduction of this divisor is taken.

For a monic product ∏i(T−vi), its rth Hasse derivative at t is the sum of products omitting r factors. At the full value a, the smallest possible valuation for 0≤r≤5 occurs by omitting r of the five order-four factors, giving −10−4r. Omitting any other factor gives a larger valuation. All finite local roots are integral, so the derivative still has no finite pole. Therefore
\[
N_j^{[r]}(t_j(a))\in L((10+4r)O)\qquad(0\le r\le5).
\]
No factorial division is used. For r1 the nominal bound is fourteen, a gap of ⟨3,10⟩. Hence L(14O)=L(13O), and the first Hasse derivative lies in L(13O).

Use one endpoint parameter u on both copies of X. On the five common branches over a write
\[
z-a=b_Pu_2^4+O(u_2^5),\qquad b_P\ne0.
\]
Only terms omitting one of these five factors can contribute a pole-fourteen coefficient in N2^{[1]}(a). Their common nonzero factors multiply the fourth elementary symmetric polynomial e4 of the five bP, up to a common sign. Because
\[
e_4(b_P)=\left(\prod_P b_P\right)\sum_P b_P^{-1},
\]
absence of that pole is exactly the necessary balance ΣP∈Ja bP^{-1}=0. Lower-order terms cannot change this equation. Five equal nonzero bP satisfy it in characteristic five; this is a consistent leading-jet example, not a global source construction.

## 4. Exact common phase and redundancy of the second balance

On P∈Ja write u1=λP u2+…. The accepted ratio-one common x-leading comparison, with x having pole three, gives λP³=1. The leading coefficient of theta in u is the same on the two copies, and theta has order sixteen. Pullback therefore contributes the power λP^{17}, including the differential. The original exact identity gives
\[
\lambda_P^{17}=\kappa a^8.
\]
Reducing powers using λP³=a³=κ³=1 gives λP²=κa² and λP=κ²a. Thus λP is one constant λa on the entire full fiber.

Expansion of the reciprocal and change from u2 to u1 give
\[
1/z-a^{-1}=b'_P u_1^4+\cdots,\qquad
b'_P=-a^{-2}b_P\lambda_a^{-4}.
\]
Consequently
\[
\sum_P(b'_P)^{-1}=-a^2\lambda_a^4\sum_Pb_P^{-1}
=-a^2\lambda_a\sum_Pb_P^{-1}.
\]
The first-leg balance is precisely the second-leg balance multiplied by a nonzero constant. There is no independent phase-partition equation. This computation concerns common infinity and does not equate finite endpoint points from their x-coordinates.

## 5. The shared nonzero y-scalar ratio

Keep the actual monic norm values, without separate rescaling. Let Rj be the product of the fifteen nonzero leading pole coefficients of vj in the corresponding endpoint parameter, and let Cj(a) be the leading coefficient of Nj(tj(a)), whose pole is ten. For the second endpoint,
\[
C_2(a)=R_2\left(\prod_{P\in J_a}b_P\right)
\prod_{\gamma\ne a}(a-\gamma)^{k_\gamma}.
\]
The fifteen minus signs on pole factors and five minus signs on zero factors cancel. All products over γ range over γ³=1, with zero multiplicities allowed.

At the first endpoint the zero factors a^{-1}−v1 have leading coefficients +a^{-2}bP λa^{-4}. The fifteen pole factors supply one minus sign. Each remaining common constant factor transforms by
\[
a^{-1}-\gamma^{-1}=-\frac{a-\gamma}{a\gamma}.
\]
Dividing the two leading products gives
\[
\frac{C_1(a)}{C_2(a)}
=(-1)^{c-4}\frac{R_1}{R_2}\lambda_a^{-20}
a^{-10}a^{-(c-5)}\prod_{\gamma\ne a}\gamma^{-k_\gamma}.
\]
Since λa^{-20}=λa and restoring the omitted five copies of γ=a gives
\[
\prod_{\gamma\ne a}\gamma^{-k_\gamma}
=a^5\prod_\gamma\gamma^{-k_\gamma},
\]
this simplifies to
\[
\frac{C_1(a)}{C_2(a)}
=(-1)^{c-4}\frac{R_1}{R_2}\lambda_a a^{-c}
\prod_\gamma\gamma^{-k_\gamma}.
\]
Every factor except λa a^{-c}=κ²a^{1−c} is independent of the full value a and is nonzero. The leading coefficient of y is identical in the chosen parameter on both copies of X. Since the x-polynomial terms have smaller pole than y, C1(a)/C2(a)=A1,a/A2,a. We obtain
\[
\frac{A_{1,a}}{A_{2,a}}=K a^{1-c},\qquad K\in k^\times.
\]
For d30, c15 and a^{1−c}=a. For d25, c10 and a^{1−c}=1. The respective comparisons of three, two or one full values follow. This constrains the scalars in the actual global norm packets, not the six independently normalized cubics by themselves.

## 6. Simultaneous Hermite filtrations

For d30 let H(T)=T³−1. Its three roots are distinct constants, and H'(a)=3a²≠0. Each leg has three full values; inversion only permutes this root set. The remainder Vj of Nj modulo H is obtained by interpolation from its three values, all in L(10O). Its coefficients therefore lie in L(10O).

Write Nj=H Rj+Vj. At each root a,
\[
N_j^{[1]}(a)=3a^2R_j(a)+V_j^{[1]}(a).
\]
Both the left side and the last term lie in L(13O). Therefore Rj(a) lies in L(13O), and its interpolated remainder Uj modulo H has coefficients there. Dividing once more gives
\[
N_j=H^2S_j+HU_j+V_j,\qquad\deg_T U_j,\deg_T V_j\le2.
\]

Repeated division by the constant-coefficient monic H gives the unique finite expansion Nj=Σr H^r Vj,r, degT Vj,r≤2. Near each root, H is an invertible formal coordinate in T−a with linear term 3a². Its coefficients and its inverse-coordinate coefficients are constants in k. Successive H-coordinate coefficients are therefore constant linear combinations of Hasse jets up to the current order. Inductively, lower jets already lie in the currently asserted larger pole space. Interpolation at the three roots yields the successive coefficient bounds
\[
L(10O),\ L(13O),\ L(18O),\ L(22O),\ L(26O),\ L(30O)
\]
for r0 through r5. Fourteen is the sole gap among the nominal bounds 10,14,18,22,26,30. For r≥5 the coefficientwise L(30O) bound on Nj suffices: division by monic H with constant coefficients preserves that bound. This proves the full stated filtration. Monicity and every individual n_{j,s} bound remain in force.

For d25 profile(5,5,0), let a,b be the two full source values and use Hj=(T−tj(a))(T−tj(b)). Its two roots are distinct and its derivatives there are nonzero. The same interpolation and first-derivative argument proves the twice-division form with degree-at-most-one L10/L13 remainders. For profile(5,3,2) there is only one full value. The other exact value poles are 30−12=18 and 30−8=22. Thus only one full L10/L13 pair is available; no three-full interpolation is used in either d25 profile.

## 7. Birational images and the normalization-defect budget

For either leg let Wj be the integral image of (hj,vj):C→X×P1. Coordinate generation makes its function field k(C), so the smooth C is its normalization. Its projection to X has degree d; its projection to P1 has degree thirty, because the pole divisor of vj has degree thirty.

Put V={point}×P1 and F=X×{point}. There is no mixed numerical class from P1, and Wj is numerically 30V+dF. On X×P1,
\[
V^2=F^2=0,\quad V\cdot F=1,\quad
K=16V-2F.
\]
Thus Wj²=60d and Wj·K=16d−60. Adjunction gives
\[
p_a(W_j)=1+\frac{60d+16d-60}{2}=38d-29.
\]
Subtracting g(C)=8d+1 gives total normalization defect 30d−30.

Étaleness of hj makes every normalized branch over every endpoint point a smooth graph over its endpoint parameter. At vj=infinity use 1/vj. Hence the delta at a multibranch image point is the sum of the pairwise intersection contacts, with no individual-branch defect.

Over O the fifteen pole branches all meet at vj=infinity. Their reciprocals vanish to order two, so each pair has contact at least two, contributing at least 2 binom(15,2)=210. At the distinct finite critical surface points, the ka common branches agree through order three, so each pair has contact at least four. Their combined contribution is at least 4 Σa binom(ka,2). These groups are at distinct surface points and their contributions add. Therefore
\[
\delta_{\mathrm{fin},j}\le30d-30-210-4\sum_a\binom{k_a}{2}.
\]
For d30 the total defect is 870 and the infinity lower bound is 330, giving 540. For d25 profile(5,5,0), the total is 720 and the lower bound is 290, giving 430. For profile(5,3,2) the lower bound is 266, giving 454. Equal leading coefficients can increase infinity contacts, so these are upper bounds, not equalities. The consistent equal-bP leading-jet example does not by itself exceed the total available budget.

## 8. Finite discriminants and the surviving global gap

Let Δj=discT Nj. Separability makes it nonzero. Over a finite endpoint point the local roots vi are integral formal functions in the split completed étale algebra, and
\[
\operatorname{ord}_u\Delta_j
=2\sum_{i<l}\operatorname{ord}_u(v_i-v_l).
\]
Roots are distinct as formal functions because Nj is separable. When two root values differ at the endpoint point, their summand is zero. When they agree, their summand is precisely the contact of the two smooth graph branches at their common surface image. Grouping by image points over that endpoint point gives twice their total delta. Every finite valuation is therefore nonnegative and even, and summing yields
\[
\deg\operatorname{div}_{\mathrm{fin}}(\Delta_j)=2\delta_{\mathrm{fin},j}.
\]
Equivalently, finite discriminant zeros measure the index of the order generated by vj inside its étale normalization. The argument retains the whole norm algebra, not just companion values.

Local squares and even divisor do not force a global square in k(X). A nontrivial two-torsion divisor class can define an unramified quadratic character even though k is algebraically closed. The [accepted S10 sign double](canonical_ten_whole_block_exact_phase_tame_congruence.md) belongs to the actual π-normal closure over Q. That normal closure has not been identified with either endpoint normal closure, and no identification of its character with Δj is made.

All results above are necessary conditions on the actual common source. The d25/d30 exclusion or existence question remains open. An irreducible polynomial meeting the coefficient, Hermite, scalar and discriminant restrictions still needs reconstruction of the second endpoint in the SAME algebra, with its actual finite étale map and exact q/theta comparison. Ordinary diagonal nontrivial phases and centered folds remain, and no finite source-index-four exclusion or automatic weighted-trace identity is promoted to a new obstruction.
