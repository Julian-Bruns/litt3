# Proof of actual pair-critical parity and one m9 trace hyperplane

ID: `admissible_degree_ten_m9_critical_sign_norm_cone`.
Version3, 2 October2026. The new actual pair-collision implication has
passed a focused independent conceptual check; no numerical replay.
[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_critical_sign_norm_cone.md).
Use the accepted actual-source
[critical irreducibility](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_critical_irreducibility.md)
and [quadratic incidence](../../Theorems/cartier_and_spin/admissible_critical_quadratic_incidence.md).
No generic necessary-model witness is used in this proof.

## Exact binary discriminant and the single actual etale leg

Retain the ORIGINAL actual degree-ten m9 source $h:S\to X$, its raw
primitive polynomial
$F=v\phi^2+\phi S+t^3$, with $\phi=T^5+q$, and $F'=\phi D$,
where $D$ is the established irreducible separable critical cubic.
Let $C\to X$ be its normalization, and put $c=T\bmod D$.
The source has $t$ exact infinity pole9 and $\delta_3$ exact pole9.

Let $\Delta_F$ be the BINARY degree-ten discriminant. The actual
degree of $F'$ is eight, not nine. The usual padded resultant formula
$\Delta_F=(-1)^{45}v^{-1}\operatorname{Res}_{10,9}(F,F')$
therefore equals, up to the square constant sign,
$\operatorname{Res}_{10,8}(F,F')$: padding the derivative by one
degree multiplies its actual resultant by $v$.
Since $F\bmod\phi=t^3$ and $\phi$ is monic of degree five,
$\operatorname{Res}(F,\phi)=t^{15}$. Multiplicativity gives
$\Delta_F=\text{(square constant)}\,t^{15}\delta_3^{10}
\operatorname{Nm}_{C/X}F(c)$.

At EVERY point of $X$, the actual etale source splits after completion
as ten copies of its completed local field. The ten primitive root
functions are thus distinct meromorphic Laurent series in that field.
The identity
$\Delta_F=v^{18}\prod_{i<j}(w_i-w_j)^2$
shows that $\Delta_F$ is a local square, in particular has even order.
Its GLOBAL square class need not be trivial: it is the unramified
sign character of this single actual degree-ten permutation cover.
Nothing asserts that this character is trivial or descends through
the second map. No common Galois closure of the two maps is invoked.

Consequently $\operatorname{Nm}_{C/X}F(c)$ has O-order of ODD parity,
because $t$ has pole nine while the discriminant and $\delta_3^{10}$
have even orders. The exact actual incidence $U(c)^2=F(c)Q(c)$
forces $\operatorname{Nm}_{C/X}Q(c)$ also to have odd O-order.
More globally,
$[\operatorname{Nm}Q(c)/t]=[\Delta_F]$ in $K^*/K^{*2}$.
The norm of $Q(c)$ is affine by finite-critical trace integrality,
so the displayed quotient has even divisor and retains the sign
two-torsion ambiguity. This norm relation alone does not decide it.

The exact accepted dependency is
[critical parity](../../Theorems/cartier_and_spin/admissible_degree_ten_critical_parity_section.md):
it already proves $C_{\rm sign}=\operatorname{Res}_{10,3}(F,D)/t^5$
has even divisor and represents the unramified sign line. Since
$\operatorname{Nm}F(c)=\operatorname{Res}(F,D)/\delta_3^{10}$,
the odd infinity parity and
$[\operatorname{Nm}Q(c)/t]=[C_{\rm sign}]$ follow directly.
Thus the preceding discriminant calculation explains the normalization
but is not a new required verification of that settled foundation.

## Universal two-hyperplane consequence on the pole-fourteen branch

Assume $\delta_2$ has EXACT pole14. Use a local uniformizer and put
$B=(\delta_2)_{14}\ne0$, $C_0=(\delta_1)_{16}$,
$M=(\mu_1)_{12}$ and $N=(n_0)_{10}$; the subscript denotes the
coefficient of that pole, and $C_0$ may be zero.
The short critical quadratic is
$Q=v\rho^2-\delta_3\mu_2-\delta_2\mu_1-\delta_1n_0
-(\delta_3\mu_1+\delta_2n_0)T-\delta_3n_0T^2$,
with moments of pole at most10,12,14, and $\rho$ at most6.

At the high critical root of pole five, $F$ has exact pole60.
Since its infinity point is unramified and $Q=U^2/F\ne0$ there,
the EXACT order of $Q$ is even, allowing both poles and zeros.

If $C_0\ne0$, the other two critical roots have poles two and
at most one. The pole-two root has leading value
$c_2\sim-\delta_1/\delta_2$.
Substituting in the displayed quadratic gives its pole26 coefficient
$-BM$: the $-\delta_1n_0$ constant term cancels the leading
$-\delta_2n_0c_2$ term. At the remaining root the pole26 coefficient
is $-BM-C_0N$, since its terms involving $T$ have pole at most25.
All other constant terms have bounds23 or22. Hence if both coefficients
are nonzero, the two low critical values each have exact pole26.

If $C_0=0$, Newton's polygon bounds BOTH low roots by pole $3/2$.
When $M\ne0$, the constant term $-\delta_2\mu_1$ of pole26
strictly dominates every other term at both roots; hence both values
again have exact pole26. The possible quadratic infinity ramification
is retained: its one point then has LOCAL order minus52, contributing
minus52 to the norm, not minus26. The same contribution occurs when
the two points are unramified.

Thus, if $M$ and $BM+C_0N$ are both nonzero, the low roots contribute
an even norm order, and so does the high root. This contradicts the
proved odd norm order. Every ACTUAL pole-fourteen m9 source therefore
satisfies
$M(BM+C_0N)=0$.
This is a union of TWO homogeneous hyperplanes in the fifteen trace
auxiliaries. It is uniform in $\rho,m_5$, all lower critical-coefficient
drops, selected finite boundaries and quadratic infinity ramification.
No endpoint jet or source-only rank assumption was used to obtain it.

## Actual pair collisions select a single hyperplane

We strengthen the preceding cone using the ACTUAL source roots at $O$.
The local fact needed is elementary and retains arbitrary pair contact.
Let $R=k[[\tau]]$, with characteristic different from two. Suppose
$r_1,r_2,c\in R$ have the same residue, $r_1\ne r_2$, and
$f(Z)=(Z-r_1)(Z-r_2)G(Z)$, where $G\in R[Z]$, $G(c)$ is a unit
and $f'(c)=0$. Put $h=(r_1+r_2)/2$, $d=(r_1-r_2)/2$ and $s=c-h$.
Then $2sG(c)+(s^2-d^2)G'(c)=0$.
Writing $a=\operatorname{ord}d>0$, a value
$0<\operatorname{ord}s<2a$ makes the first summand have strictly
smaller order than the second, since
$\min(2\operatorname{ord}s,2a)>\operatorname{ord}s$.
Thus $\operatorname{ord}s\ge2a$, including $s=0$, and
$\operatorname{ord}f(c)=2a$ is even. The proof does not divide by
$G'(c)$, a root difference or a critical discriminant.

Suppose $C_0\ne0$. The three critical slopes5,2 and at most1 are
distinct and of width one, so all three infinity points are unramified.
For $c_2$, normalize the source coordinate by $z=\tau^2T$.
The five big source roots all have pole two: their pole orders are
at least two and sum to ten in this $(d,m)=(10,9)$ profile.
The five selected roots have poles at most one. The polynomial
$\tau^{30}F(\tau^{-2}z)$ is integral with unit leading coefficient
and reduction $z^5H(z)$, where
$H(z)=v_{10}z^5+(s_3)_{14}z^3+(s_2)_{16}z^2+e_{20}$.
The last coefficient is the pole20 coefficient of $vq+s_0$ and need
not be assumed nonzero for the argument. Since
$B=3(s_3)_{14}$ and $C_0=2(s_2)_{16}$, the nonzero leading value
$z_0=-C_0/B$ of $\tau^2c_2$ is the unique nonzero zero of
$H'=z(3(s_3)_{14}z+2(s_2)_{16})$. It is simple, so
$H''(z_0)\ne0$.

If $H(z_0)\ne0$, $F(c_2)$ has exact pole30 and even order.
If $H(z_0)=0$, its multiplicity in $H$ is EXACTLY two. Exactly two
actual normalized Laurent roots have residue $z_0$; all eight other
roots have a different residue. Factoring out this pair leaves
$G\in R[z]$ with $G(\tau^2c_2)$ a unit. The normalized polynomial
has derivative zero there, because $F'(c_2)=\phi(c_2)D(c_2)=0$.
The local fact gives
$\operatorname{ord}F(c_2)=-30+2\operatorname{ord}(r_1-r_2)$,
again even. This uses the actual Laurent splitting, not a presumed
splitting of an arbitrary necessary polynomial. The roots are distinct
as Laurent functions because the original source is primitive and
separable. The established coprimality ensures all critical values
in the square identity are nonzero.

Consequently both the high critical value of $Q$ and $Q(c_2)$ have
even order. The norm has odd O-order, so its remaining small critical
value has odd order. Its possible pole26 coefficient is
$-BM-C_0N$. This coefficient must vanish. For $C_0=0$ the previous
cone already gives $M=0$, yielding the same equality. Thus EVERY
actual pole-fourteen source satisfies the single hyperplane
$BM+C_0N=0$.

If $C_0\ne0$ and $M=0$, this forces $N=0$. Put
$L=(\mu_1)_{11}$ and $E_0=(\delta_0)_{17}$. The exact critical
relation rewrites the quadratic value as
$Q(c_2)=v\rho^2-\delta_3\mu_2-(\delta_2+\delta_3c_2)\mu_1+
\delta_0n_0/c_2$.
On $M=0$ its pole25 coefficient is
$-BL-(B/C_0)E_0N$; all other terms have poles at most23 or22.
Even order forces $C_0L+E_0N=0$, and hence $L=0$ when $N=0$.
No independence from the existing moment-gap equations is claimed.

## Consequences for the one-coordinate trace model

Before taking the pole14 trace consequences, extend the hyperplane
necessity to the entire remaining m9 profile. The established
[five-sheet leading-cohort restriction](../../Theorems/cartier_and_spin/admissible_degree_ten_nonzero_profiles.md)
has at least four distinct big leading residues. The normalized
$H=v_{10}z^5+(s_3)_{14}z^3+(s_2)_{16}z^2+e_{20}$ could have only
one geometric root if both middle coefficients vanished. Thus
$(B,C_0)\ne(0,0)$. If $B=0$, $C_0\ne0$, and the critical slopes
are4,3,at most1 when $\delta_2$ has pole13, or7/2,7/2,at most1
when it has pole at most12. The half-integral pair is a tame
index-two point; the small point is unramified in both cases.

At either large critical root $r>2$, all actual source roots have
poles at most two. Therefore $vT^{10}$ strictly dominates $F$ there,
and the local order is $-e(10+10r)$, EVEN since $er$ is an integer.
The corresponding local orders of $Q=U^2/F$ are even. The odd norm
therefore forces odd order at the small point. Its pole26 coefficient
is $-C_0N$, all other terms having poles at most25. Hence $N=0$,
and the hyperplane $BM+C_0N=0$ holds on this boundary as well.

In fact $M=0$ there too. If $\delta_2$ has pole13, evaluate the exact
rewriting
$Q(c)=v\rho^2-\delta_3\mu_2-(\delta_2+\delta_3c)\mu_1+
\delta_0n_0/c$
at the pole-three root. Since $N=0$, the last term has pole at most23,
and the first two have poles at most22 and23. The remaining term has
pole25 coefficient $-(\delta_2)_{13}M$; a nonzero coefficient would
give an odd order, contradicting the even critical-square order.
If $\delta_2$ has pole at most12, the index-two point has
$\delta_3c$ of base-normalized pole25/2, strictly above $\delta_2$.
When $M\ne0$ the product with $\mu_1$ gives LOCAL pole49.
The last term has base-normalized pole at most45/2, and the first
two at most22 and23, so no cancellation is possible. This again
contradicts even order. Thus $B=0$ forces $M=N=0$ uniformly.
No splitting into base Laurent roots was asserted for the ramified
pair, and local orders were not divided by its ramification index.

The following dimension and affine-line consequences retain the
condition $B\ne0$, where the five infinity rows have been proved.

On the rank-fourteen affine trace locus, write
$M=M_0+\theta M_1$ and $N=N_0+\theta N_1$.
Unless the whole affine line lies in the proved hyperplane,
its linear equation yields at most ONE explicit candidate trace parameter.
The line-contained alternatives are retained, as are the existing
rank-drop supports and all subsequent square-class and exact quotient
conditions. This does not prove that this linear functional is nonzero
on every actual trace line or generically in the necessary coefficient model.

There is also a UNIFORM dimension improvement before imposing finite
selected equations. The hyperplane has dimension fourteen.
The five explicit independent infinity
columns of the pole-fourteen reduction all satisfy $M=N=0$:
they have $n_0=0$, $\eta_1=\ell$ or the fixed degree-two $q$, or
$\eta_1=0$, $\eta_2=xy,x^4,y$. Hence the infinity map still has
rank five on this hyperplane. For every fixed source,$\rho,m_5$,
the hyperplane together with the five infinity equations gives an empty
set or ONE affine space of dimension NINE, instead of ten. The nine
selected equations and the exact source identity can cut them further;
no uniform independence of those remaining rows is asserted.
The hyperplane really has codimension one: take $n_0=0$ and
$\eta_1=x^4-\kappa$, with
$\kappa=[x^9]\operatorname{rem}(Zx^4,P)/[x^9]Z$.
The denominator is nonzero for the fixed $Z$, this column satisfies
the only remaining gap equation, and it has $M\ne0,N=0$.

On the homogeneous $\rho=0,m_5\in L_9$ boundary, nonzero trace
parameters require the source-dependent kernel direction itself to
lie in this hyperplane. This condition is INDEPENDENT of $v$ and stronger
than the previous leading-content relation in the sense that it is a
new restriction on the critical coefficient data. Its properness or
rank has NOT been computed. The sign character is NOT presumed trivial,
and the original actual two etale maps and global divisor conditions
remain necessary.

## Fixed rank-five columns and the general-degree norm formula

For the claimed dimension nine, the first-three model and gap formulas
are those explicitly given in
[the square-pencil proof](admissible_degree_ten_m9_critical_square_pencil_finite_support.md).
With $n_0=0$, valid $\eta_1,\eta_2$ have
$\mu_1=\eta_1$, $\mu_2=\eta_2-2R_1\eta_1$,
and their remaining gap condition is
$[x^9]\operatorname{rem}(Z\eta_1,P)=0$.
The fixed $\ell=x+[12]$ has that coefficient zero and
$[x^8]\operatorname{rem}(Z\ell,P)=\beta\ne0$.
The fixed $q=(13,18,24)$ has $R_1q$ of exact gap pole11.
These fixed remainder inputs are recorded respectively in
[the leading-plane certificate](../../../litt3-computation-data/oct02_m9_uniform/source_pole14_leading_plane.json)
and [the accepted m9 denominator proof](admissible_degree_ten_m9_zero_moment_denominator_exclusion.md).
Consequently $\eta_1=\ell$ or $q$, $\eta_2=0$ give distinct top
poles23 and20 in
$Q(c)-v\rho^2=2\delta_3R_1\eta_1+\delta_1\eta_1/c+
\delta_0\eta_1/c^2$.
The reciprocal terms have bounds14 and17 respectively.
Taking $\eta_1=0$, $\eta_2=xy,x^4,y$ gives
$Q(c)-v\rho^2=-\delta_3\eta_2$, with top poles22,21,19.
Thus these five allowed columns form a triangular jet matrix with
nonzero diagonal. All have $M=N=0$, proving the asserted restricted
rank five without a source sweep.

There is a reusable actual-degree norm formula behind this specialization.
In the general admissible setting of
[critical parity](../../Theorems/cartier_and_spin/admissible_degree_ten_critical_parity_section.md),
let $n$ be the primitive source degree and let $D=\mathscr H'$
have ACTUAL positive degree $d\le n-6$ and leading coefficient $a_d$.
When its critical algebra is separable and the relevant norms nonzero,
the formal-degree resultant satisfies
$\Delta_{\rm formal}=v^{n-6-d}a_d^n\operatorname{Nm}_D F(c)$.
The accepted parity section is
$C_{\rm sign}=\Delta_{\rm formal}/(t^5v)$, with even divisor.
Its square-class consequence is
$[\operatorname{Nm}_D F(c)]
=[C_{\rm sign}]+[t]+(n-d-7)[v]+n[a_d]$.
Any nonzero critical-square incidence imposes the same class on
$\operatorname{Nm}_D Q(c)$.
This explicitly retains derivative-degree drops and their leading
coefficient factors. For $n=10,d=3$, both extra terms have even
exponent, giving precisely the norm relation used above.
