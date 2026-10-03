# Proof of the actual m9 pure selected-kernel exclusion

ID: `admissible_degree_ten_m9_pure_selected_kernel_exclusion`.
Version1, 2 October2026. New sixteen-case finite branch; [focused root
review PASS](../../Research/audits/M9_PURE_SELECTED_KERNEL_REVIEW_2026_10_02.md). [Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_pure_selected_kernel_exclusion.md).

## Actual norm and source-local restrictions

Retain an actual primitive degree-ten m9 source, its annihilator and
BOTH original finite étale legs. Assume $\rho=0$, $m_5\in L_9$,
$B=0$, $n_0=\mu_1=0$, and $\mu_2=t\ell$, $\ell=a+bx$.
The [low-trace moment theorem](admissible_degree_ten_m9_low_trace_quadratic_moments.md)
gives $\mu_2\le12$ and the two infinity rows. The incidence is
$Q=-\delta_3t\ell$. The auxiliary critical normalization $C\to X$
has degree three, may ramify, and is never substituted for the actual
étale source.

Here $t$ may be chosen MONIC without losing an actual scalar.
The canonical [full coefficient reduction](admissible_degree_ten_eleven_reduction.md),
in its exact necessary equations, writes the monic root polynomial as
$F_b=(B^5+f)H_m+\kappa t^3/v$, with monic selected cubic $t$ and
$\kappa\ne0$. Its raw polynomial has constant term $\kappa t^3$.
Multiply the ENTIRE raw polynomial by $\kappa^{-1}$:
$v,S,D,U,Q,V_2$ are all multiplied by this same scalar.
Both sides of $U^2-FQ=DV_2$ are multiplied by $\kappa^{-2}$,
and $U(W)=uD(W)$ is preserved. This changes only the generator of
the primitive content and its polynomial presentation. The actual
$W,u,h,\rho,m_5$, both maps, all divisors and all pole bounds are
unchanged. Thus the computation fixes the raw constant to $t^3$
legitimately, retaining the later arbitrary nonzero leading coefficient
$\gamma$ of $\delta_3$.

If $\ell=0$, then $Q=0$, contrary to actual critical coprimality.
If $b=0$ and $a\ne0$, $\operatorname{Nm}Q(c)$ has infinity pole
$3(9+9)=54$, contrary to the ODD actual norm order of
[the sign-norm theorem](admissible_degree_ten_m9_critical_sign_norm_cone.md).
The pole-thirteen $\delta_2$ infinity row already excludes $b\ne0$
through its nonzero pole-twenty-one coefficient. It remains to treat
the half-integral stratum $\delta_2\le12$ with $b\ne0$.

The norm square class gives $[\delta_3\ell]=[C_{\rm sign}]$.
The right side has even divisor. A polynomial in $x$ has even divisor
on $X:y^3=P$ only if every polynomial root multiplicity is even,
since all finite ramification indices are one or three. Thus
$\delta_3\ell$ is a polynomial square, and the source sign class is
trivial. The accepted leading pencil is
$\delta_3\in\langle q,q_3\rangle$; it has no triple roots.
Therefore its ratio is one of the FOUR repeated parameters, each
double-plus-simple, and $\ell$ vanishes at its simple root.
The accepted repeated-pencil input in
[the source pole-three proof](admissible_degree_ten_m9_source_rational_critical_pole_three_exclusion.md)
says both roots have $P,A$ units. Hence $\delta_3$ is a unit at all
nine selected endpoints.

The identity now makes $F(c)t$ a square. At any selected endpoint,
$\bar F=T^5\bar H$, $\bar H(0)\ne0$, and
$\bar D=T(\bar\delta_3T^2+\bar\delta_2T+\bar\delta_1)$.
A nonzero simple critical residue lifts unramified; odd $t$ order
forces odd positive order of $F(c)$ and hence an exact double root
of $\bar H$. The ORIGINAL étale source supplies two actual Laurent
roots there. The accepted arbitrary-contact pair lemma forces the
critical value to have even order, a contradiction. Division by their
monic integral quadratic retains this argument even if $v$ vanishes
and other source roots have poles. Therefore no nonzero simple
critical residue is possible, and
$\delta_2(P)^2-4\delta_3(P)\delta_1(P)=0$ at all nine selected points.
The full local proof, including the permitted ramified critical pair,
is retained in
[the critical-boundary note](../../Research/experiments/oct02_m9_uniform/PURE_HALF_KERNEL_SELECTED_CRITICAL_BOUNDARY.md).

## Exact full-source character model

All following coefficients are SHORT coefficients and retain their
finite rational remainders. Put $d=\delta_3$, $R_d=\operatorname{rem}(Zd,P)$,
$S_d=\operatorname{rem}(Z^2d,P)$ and $R_{3d}=\operatorname{rem}(Z^3d,P)$.
Write
$\delta_2=a_4+yb_1+3y^2R_d/P$,
$\delta_1=c_5+yd_2+2y^2R_a/P+3yS_d/P$,
with $R_a=\operatorname{rem}(Za_4,P)$.
The half-integral bounds give
$\deg a_4\le4$, $\deg R_a\le8$, $b_1\in k$,
$\deg c_5\le5$, $\deg d_2\le2$.
The zeroth short coefficient is
$\delta_0=e_5+yf_2+R_{3d}/P+yR_{2a}/P+y^2R_c/P$,
where $R_{2a}=\operatorname{rem}(Z^2a_4,P)$,
$R_c=\operatorname{rem}(Zc_5-Z^2b_1,P)$,
$\deg e_5\le5$ and $\deg f_2\le2$.
These normal forms follow directly from finite affinity. Indeed
$\delta_{2,s}=\delta_{2,f}+3ad$ and
$\delta_{1,s}=\delta_{1,f}+2a\delta_{2,f}+3a^2d$,
where $a=Z/y$. The first proper remainder is $3y^2R_d/P$;
substitution in the second leaves $2y^2R_a/P+3yS_d/P$.
Its possible gap pole seventeen forces $[x^9]R_a=0$.
Next $\delta_{0,s}=\delta_{0,f}+a\delta_{1,s}-a^2\delta_{2,s}+a^3d$.
Reducing its proper characters modulo $P$ gives exactly
$R_{3d}/P$, $yR_{2a}/P$, $y^2R_c/P$; the remaining affine part
has the indicated degree bounds. Every short rational term is retained.
Selected $\delta_0=0$ gives three congruences
$Pe_5+R_{3d}\equiv Pf_2+R_{2a}\equiv R_c\equiv0\pmod t$.

The residual critical discriminant vanishes on all three sheets of
each selected fiber exactly when $G_0,G_1,G_2$ are divisible by $t$,
where
$G_0=P(a_4^2+b_1R_d-4dc_5)$,
$G_1=P(2a_4b_1-4dd_2)+4R_d^2-2dS_d$, and
$G_2=Pb_1^2+a_4R_d+2dR_a$.

The ORIGINAL constant source double jets are essential. Put
$J=(Q_{\rm fixed}-L_0^5)/t^3$, a polynomial unit modulo $t$.
Then $t^3/q_s=y^2P/J$. The short constant coefficient's proper
linear and quadratic characters are
$r_1=\operatorname{rem}(3Z^2c_5+Z^3b_1,P)/P$ and
$r_2=N_2/P^2$, with
$N_2=\operatorname{rem}(PZe_5+2PZ^2d_2+ZR_{3d}+Z^2S_d+Z^3R_d+Z^4d,P^2)$.
Its affine linear character has degree at most two, and its affine
quadratic character is the FIXED constant $\kappa_0=-1/(q_s)_7$.
For a primary check of the displayed proper characters, finite affinity
of $S_{f,0}$ gives
$s_0=S_{f,0}+a\delta_{0,s}-(a^2/2)\delta_{1,s}
+(a^3/3)\delta_{2,s}-(a^4/4)d$.
In characteristic five the three signed coefficients are $2,2,1$.
Its proper scalar character is $\operatorname{rem}(2Z^3a_4,P)/P$;
ordinary Euclidean division gives the displayed $r_1,N_2$ for the other
characters. All proper remainders contribute positive infinity poles
at most seventeen. The remaining affine part has scalar degree at most
six, linear-character degree at most three, and a constant quadratic
character.
In the fixed parameter $\tau=x^3/y$, $x,y$ have leading coefficients
one and no next term before order three. The numerator
$Q_{\rm fixed}-L_0^5$ has degree nineteen and leading coefficient
$[24]$, so $(q_s)_7=[24]$ and its pole-six coefficient is zero.
The MONIC $t^3$ has pole-twenty-seven coefficient one and no
pole-twenty-six term. The original source bound $F_s(0)\le25$ now
forces $\kappa_0=-1/[24]$ and makes the affine $yx^3$ coefficient
zero. This proves the degree-TWO linear-character bound used here.
Thus its selected double jets impose THREE linear-character
compatibilities (degrees three through five modulo $t^2$ of $r_1$
vanish) and SIX quadratic-character equations
$r_2+\kappa_0+P/J\equiv0\pmod{t^2}$.
The scalar character always interpolates, retaining only the free
$kt^2$ direction. These are the full nine constant-source compatibility
conditions, not a critical-only coefficient model.
The derivation is in
[the source-double-jet interface](../../Research/experiments/oct02_m9_uniform/PURE_HALF_KERNEL_SOURCE_DOUBLE_JETS.md).

## Finite linear elimination and one univariate parameter

Fix one repeated leading ratio and write $d=\gamma d_0$, $\gamma\ne0$.
For each selected omission, the following FIXED linear maps are
invertible: the six-by-six map for $c_5$, given by selected $R_c=0$
and the three $r_1$ compatibilities, and the nine-by-nine map for
$(e_5,d_2)$, given by selected $Pe_5+R_{3d}=0$ and the six $r_2$
equations. Their right sides give
$c_5=b_1C_*$ and $d_2=D_*+\gamma D_{d_0}$.
The remaining $f_2$ interpolates uniquely and is irrelevant to
$G_0,G_1,G_2$.

Normalize $a_4=\gamma A$, $b_1=\gamma b$, and let $\mathcal A$ be
the FOUR-dimensional polynomial space $\deg A\le4$,
$[x^9]\operatorname{rem}(ZA,P)=0$.
The map $L:\mathcal A\to k[x]/(t)$,
$L(A)=AR_{d_0}+2d_0\operatorname{rem}(ZA,P)$, has rank three in
all sixteen cases. Choose $A_*$ with $L(A_*)=-P$ and a generator
$A_K$ of its kernel; $A_K$ is NOT divisible by $t$.
Then $G_2=0$ gives $A=b^2A_*+uA_K$.

Put
$V=R_{d_0}-4d_0C_*$,
$K=-4d_0D_{d_0}+(4R_{d_0}^2-2d_0S_{d_0})/P$, and
$T_*=4d_0D_*$ in $k[x]/(t)$.
If $b=0$, $G_0$ forces $u=0$; $G_1$ would then say
$K=\gamma^{-1}T_*$. The two vectors are linearly independent in
all sixteen exact cases, excluding this boundary.

If $b\ne0$, write $u=b^2z$, $Z_*(z)=A_*+zA_K$,
$w(z)=Z_*(z)^2\bmod t$, and $h=\gamma^{-1}$.
The remaining equations are
$b^3w(z)+V=0$ and $2b^3Z_*(z)+K-hT_*=0$ in $k[x]/(t)$.
Choose an index $j$ with $V_j\ne0$; necessarily $w_j(z)\ne0$.
Eliminating $b^3$ gives the three polynomials
$V_jw_i-V_iw_j$.
Eliminating $h$ gives the pair polynomials
$T_{*,i}(-2V_jZ_{*,k}+K_kw_j)
-T_{*,k}(-2V_jZ_{*,i}+K_iw_j)$.
Every polynomial has degree at most TWO in the SINGLE variable $z$.
In each of the sixteen cases their nonzero members have gcd ONE.
The certificate supplies their exact coefficient rows and iterated
Bézout coefficients whose sum of products is exactly one. Thus no
geometric $z$, $b$ or $\gamma$ can satisfy the necessary source equations.

## Exact evidence and verification

The NEW one-core source is
[oct02_m9_pure_half_source_jet_linear.sage](../../scripts/oct02_m9_pure_half_source_jet_linear.sage).
The complete sixteen-case certificate is
[pure_half_source_double_jet_elimination.json](../../../litt3-computation-data/oct02_m9_uniform/pure_half_source_double_jet_elimination.json).
It records the finite-field modulus and embedding of the fixed
$\mathbf F_{25}$ coefficients, every repeated ratio and selected
omission, both fixed determinants, the rank-three map, $A_*,A_K$,
$V,K,T_*$, every univariate equation and its Bézout coefficients.
The field $\mathbf F_{5^{24}}$ contains the four repeated parameters
and all selected roots; cubic sheets need not be chosen because all
three characters are retained simultaneously.

The script checks every linear solution identity, both invertibilities,
the rank-three gap map, $A_K\not\equiv0\pmod t$, the $b=0$ vector
independence and every exact Bézout identity before writing a case.
All sixteen cases completed in 1.227 seconds with Sage10.9 on one CPU
core, with OMP/BLAS/MKL thread counts fixed to one and a thirty-second
hard bound; no GPU or multivariable Gröbner computation was used.
Verification consists of running this NEW source or reconstructing its
fixed maps and checking the stored Bézout identities in its recorded
field. No prior settled program is a required numerical replay.

This proves only the pure selected-kernel exclusion. If $\delta_3$ has
selected zeros, vanishing $n_0,\mu_1$ alone need not imply
$\mu_2\in tL_3$: for example the necessary divisor pattern
$\delta_3=(x-s)d_2$, $t=(x-s)t_2$, $\mu_2=t_2d_2$ can have
$\delta_3\mu_2/t$ square without $t\mid\mu_2$.
This is an explicit retained boundary, not an asserted actual source.
Nonzero first-moment pairs and the full m9 existence question remain open.
