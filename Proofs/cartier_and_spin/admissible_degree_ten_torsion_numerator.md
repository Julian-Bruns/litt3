# Finite regularity, endpoint projection and source exclusions

1 October 2026.
[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_torsion_numerator.md).
The inputs are the
[degree-ten support and coefficient reduction](../../Theorems/cartier_and_spin/admissible_degree_ten_eleven_reduction.md),
[uniform annihilator traces, version 6](../../Theorems/cartier_and_spin/admissible_annihilator_trace_vanishing.md)
and [nine-profile reduction](../../Theorems/cartier_and_spin/admissible_degree_ten_nonzero_profiles.md).
The complete concentrated constant-$v$ exclusion also uses the
[critical parity section, version 2](../../Theorems/cartier_and_spin/admissible_degree_ten_critical_parity_section.md).
The concentrated $(10,6)$ exclusion uses the
[critical quadratic incidence](../../Theorems/cartier_and_spin/admissible_critical_quadratic_incidence.md),
including its seven concentrated endpoint rows and its
zero-leading-critical endpoint exclusion.
The retained audited nonzero-first-moment reply supplies the literal
coefficient family; no settled coefficient enumeration is repeated.
The endpoint interpolation argument below does not assume unconcentrated
leading slopes.

The source-specific data and literal affine coefficient basis are retained
in the [audited reply](../../../litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited/REPORT.md).
Our new scripts and matrices use that literal basis. All parameters remain
geometric parameters over $k$; an exact test specialization over $K$ is
never interpreted as an enumeration of the geometric coefficient locus.

## Finite regularity and the seventy-coordinate space

Work in a split étale disk at a finite base point. Let $g_i\ge0$ be the
pole orders of the finite primitive $w_i$. Primitive content gives
$\sum_i g_i=\operatorname{ord}v$. Every coefficient of
$Q_i=v\prod_{j\ne i}(T-w_j)$ therefore has valuation at least $g_i$.
Away from $E$, $\chi_i$ is integral, and at a pole of $w_i$ it has
valuation $5g_i$. Thus $\chi_iQ_i$ has no pole away from $E$, including
over every zero of $v$.

At a selected finite endpoint, the five selected $\chi_i$ have at most
simple poles. Their $w_i$ have a common residue $c$, since
$w_i^5=-q_f$ in the residue field. Integral division by the monic
polynomial $T-w_i$ commutes with reduction, so all their $Q_i$ have
the same reduction $F_f\bmod r\,/(T-c)$. The sum of the residues of
$\chi_i$ is zero by $\operatorname{Tr}\chi=0$. Hence the possible
coefficient poles cancel in $U_f=\sum_i\chi_iQ_i$. This proves finite
regularity without inverting $v$ or a critical discriminant.

At infinity, a small interpolation term has coefficient pole at most
$d+(20-d)+(4-j)+1=25-j$. A big term with root pole $a_i\ge2$
has coefficient pole at most $35-6a_i-j\le23-j$. Thus
$A_j$ has pole at most $25-j$ for $j\le3$.
The top coefficient identities from trace interpolation give
$A_5=vm_4$ and $A_4=vm_5+s_4m_4$. Here
$m_5=\operatorname{Tr}u\in L_X(10O)$, since
$W^5=\phi-q_s$ and $m_0=0$.
In particular $A_4$ has pole at most $\max(d+10,m+6)\le20$.

For affine $c$, let $\Pi_n(c)$ be the affine polynomial part of $a^nc$:
use $a=(B_0-L_0)/y$, reduce to three $y$-components, and take polynomial
quotients by the required powers of $P=y^3$. Its discarded remainder
has pole at most 17. Indeed a remainder component is
$y^rR(x)/P^e$ with $\deg R<10e$, and its pole is at most $10r-3\le17$.

The parametrization is
\[
C_5=A_5,\qquad C_4=A_4,\qquad C_3=\Pi_1(A_4)+r_3,
\]
\[
C_2=-3\Pi_1(C_3)-\Pi_2(A_4)+r_2,
\]
\[
C_1=-2\Pi_1(C_2)-3\Pi_2(C_3)-4\Pi_3(A_4)+r_1,
\]
\[
C_0=-\Pi_1(C_1)-\Pi_2(C_2)-\Pi_3(C_3)
-\Pi_4(A_4)-\Pi_5(A_5)+r_0.
\]
These are the coefficients of $U_f(T+a)=U_s(T)$ in characteristic five.
The remainder bound proves sufficiency of $r_j\in L_X((25-j)O)$ for the
short bounds. Conversely these bounds determine each free $r_j$
successively, because each discarded remainder has pole at most 17.
The dimensions are $3+5+17+16+15+14=70$.

## Endpoint jets and exact projection

There is a stronger selected-cluster coefficient argument. On a split
étale finite disk let $I$ be the five selected sheets. Choose any integral
$C$ such that $V_i=W_i-C$ has order at least $k\ge1$ for $i\in I$,
and put $P_I(T)=\prod_{i\in I}(T-V_i)$ and
$Q(T)=\prod_{i\notin I}(T-V_i)$. The pole orders $g_i$ occur only on the
nonselected sheets. Primitive content gives
$\sum_{i\notin I}g_i=\operatorname{ord}v$.
Thus $vQ$ has integral coefficients, and for any nonselected $i$,
$vQ/(T-V_i)$ has coefficients of valuation at least $g_i\ge0$.

The interpolation numerator in the translated variable is
$U_s(T+C)=\sum_i\chi_i v\prod_{h\ne i}(T-V_h)$.
For selected $i$, the coefficient of $T^a$ in $P_I/(T-V_i)$ has
order at least $k(4-a)$. Since $\operatorname{ord}\chi_i=-1$,
the resulting coefficient of $T^j$ has order at least
$k(4-j)-1$: each convolution term uses $a\le j$, and $vQ$ is integral.
For nonselected $i$, $\chi_i$ is integral, and the coefficient of
$T^a$ in $P_I$ has order at least $k(5-a)$. Its contribution to
$T^j$ has order at least $k(5-j)$. Therefore, writing
$U_s(T+C)=\sum B_jT^j$,
\[
\operatorname{ord}B_j\ge k(4-j)-1\qquad(0\le j\le3).
\]
This permits arbitrary repeated leading slopes and $G$ poles in the
same fiber. It is a coefficientwise estimate and requires no
Vandermonde matrix or distinctness condition.

At every finite selected endpoint, $\phi_i$ and $q_s$ have order at
least three, so $W_i^5=\phi_i-q_s$ gives
$\operatorname{ord}W_i\ge1$. Take $C=0,k=1$ to obtain the universal
orders $3,2,1$ for $A_0,A_1,A_2$.
If all first slopes equal $c$, take $C=cr,k=2$, giving orders at
least $7,5,3,1$ for $B_0,B_1,B_2,B_3$.
The top coefficients $B_4=A_4$ and $B_5=A_5$ are integral.
Translating back with $\operatorname{ord}C\ge1$ gives at least
$4,3,2,1$ for $A_0,A_1,A_2,A_3$.

The same factorization bounds the source critical coefficients without
assuming any next-slope distinctness. The coefficient of $T^j$ in
$F'(T+C)=P_I'(T)vQ(T)+P_I(T)(vQ)'(T)$ has order at least $k(4-j)$
for $j\le3$. Since
$\phi_s(T+C)=T^5+C^5+q_s$ has constant coefficient of exact order three,
and no terms of degrees one through four, $F'=\phi_sD_s$ gives
\[
\operatorname{ord}[T^j]D_s(T+C)\ge k(4-j)-3
\qquad(0\le j\le3).
\]
Its cubic coefficient is $4s_4$, so
$k\le\operatorname{ord}_P s_4+3$. The nonzero affine function
$s_4\in L_X(12O)$ has total zero degree at most twelve; hence $k\le15$.
For a unit $s_4(P)$ the bound is $k\le3$. This gives a finite contact
stratification, including the possibility that all second slopes still
coincide.
The independent [critical parity section theorem](admissible_degree_ten_critical_parity_section.md)
gives the stronger global constraint: $\Delta/t^5\in L_X(160O)$ and
each complete-cohort contact contributes at least $20(k_P-1)$ to its
zero divisor. Hence $\sum_P(k_P-1)\le8$, so $k_P\le9$.

For all nine finite endpoints they are exactly
$t^3\mid y^5A_0$, $t^2\mid y^4A_1$ and $t\mid y^3A_2$,
componentwise. The powers of $y$ are units at these endpoints.

[annihilator_projection.py](../../scripts/oct01_nonzero_source/annihilator_projection.py)
constructs these 54 scalar rows on the seventy coordinates.
The lower 54-by-62 matrix has rank 53. Its cokernel is one-dimensional;
evaluation on the top columns depends only on $A_4$ and gives the
bilinear functional $\ell(vm_5+s_4m_4)$.
The exact $m_5$ coefficient matrix on the polynomial part of $v$
has rank four. The $m_4$ matrix on $(p_1,p_2,p_3,p_4)$ has rank three,
with its first three columns independent. Their joint zero locus gives
exactly the displayed exceptional $v,s_4$ coefficients.
Otherwise the total rank is 54 and the numerator dimension is 16;
on that exceptional locus the total rank is 53 and the dimension is 17.

The universal cluster argument means that no finite endpoint rows are
omitted, even in a concentrated case. The original weaker argument
omitted one endpoint and found rank 48, giving a covering space of
dimension 22; those experimental ranks remain in the certificate as
historical evidence, but that enlarged space is no longer needed.

The concentrated case imposes the four additional coefficient conditions
$[r^3]A_0=[r^2]A_1=[r]A_2=[1]A_3=0$.
The exact calculation
[concentrated_endpoint_projection.py](../../scripts/oct01_nonzero_source/concentrated_endpoint_projection.py)
evaluates them on $V_0$ at each of the nine geometric endpoints.
Every resulting 4-by-9 matrix has rank four:
[concentrated_endpoint_projection.json](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/concentrated_endpoint_projection.json).
Thus the lower rank increases from 53 to 57. Its cokernel remains the
original one-dimensional cokernel with four appended zeros, so the top
compatibility functional and its exceptional locus are unchanged.
The full numerator dimensions become 12 and 13, respectively.

The full shifted $k=2$ conditions improve this further. Put $C=cr$ with
the actual common first slope $c$. After the ordinary nine-endpoint
constraints, the additional conditions on the fixed lower $V_0$ are
the ten rows
\[
(j,n)=(0,3),(0,4),(0,5),(0,6),(1,2),(1,3),(1,4),
(2,1),(2,2),(3,0),
\]
where the row means $[r^nT^j]U_s(T+cr)=0$.
Their entries are polynomials of degree at most three in $c$.
[shifted_concentrated_projection.py](../../scripts/oct01_nonzero_source/shifted_concentrated_projection.py)
constructs the exact 10-by-9 matrices at all nine endpoints in one
common cubic extension. Each matrix has maximal-minor ideal equal to
the unit ideal: its first two maximal minors have degrees ten and nine,
and polynomial multipliers of degrees eight and nine give the literal
identity one. Thus these matrices have rank nine for every geometric
first slope, including every zero of either individual minor.

The matrices, minors and polynomial unit identities are retained in
[sheet 0](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/shifted_concentrated_projection.json),
[sheet 1](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/shifted_concentrated_projection_sheet1.json)
and [sheet 2](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/shifted_concentrated_projection_sheet2.json).
An independent Gaussian determinant calculation at 28 distinct slope
values verifies the two determinant polynomials: the coarse degree bound
is $9\cdot3=27$, so these comparisons establish polynomial identities.
It then literally multiplies the retained Bezout rows to obtain one.
[verify_shifted_concentrated_minors.py](../../scripts/oct01_nonzero_source/verify_shifted_concentrated_minors.py)
executed all 504 comparisons successfully; its outcomes are in
[the verification certificate](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/shifted_concentrated_minors_verification.json).
This is unisolvence verification of a polynomial identity, not a bounded
slope search.

If two numerators with the same eight top coordinates satisfy the
concentrated jets, their difference belongs to $V_0$ and to the kernel of
this full-rank matrix. It is therefore zero. Thus the top-coordinate
projection is injective, giving dimension at most eight. The original
nonzero compatibility functional further bounds it by seven except on
the displayed exceptional $v,s_4$ locus. These are upper bounds only;
the remaining shifted compatibility may lower them further.

That remaining compatibility is explicit. Use the fixed independent
53 rows and 53 columns of the ordinary lower matrix to choose a linear
particular numerator for each pair $A_5\in L_X(16O)$, $A_4\in L_X(20O)$.
There are nine and twelve monomial coordinates, respectively. If the
ordinary cokernel condition $\ell(A_4)=0$ holds, this particular numerator
satisfies all ordinary endpoint jets. Its full concentrated extra rows
form a 10-vector $E(c)$ polynomial in the common first slope.
Let $M(c)$ be the fixed 10-by-9 lower matrix, and define
$w_i(c)=(-1)^i\det M_{\widehat i}(c)$ by omitting row $i$.
The literal cofactor identity gives $w(c)^TM(c)=0$.
The retained unit identity makes $w(c)$ nonzero at every slope, so
\[
E(c)\in\operatorname{im}M(c)\quad\Longleftrightarrow\quad
w(c)^TE(c)=0.
\]
Thus exactly one further polynomial linear compatibility suffices;
the lower completion is unique. No first-slope denominator is needed.

[concentrated_top_compatibility.py](../../scripts/oct01_nonzero_source/concentrated_top_compatibility.py)
computes this new form on the 21 top-function coordinates at all nine
endpoints and verifies the cofactor annihilation identities. Its
coefficient polynomials have degree at most thirteen. The explicit forms
and linear particular numerators are in
[concentrated_top_compatibility.json](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/concentrated_top_compatibility.json).

After eliminating one ordinary-functional coordinate, the polynomials
of the new form generate the unit ideal at every endpoint. The same is
true of its five columns corresponding to
$A_4\in yL_X(10O)=\langle y,xy,x^2y,x^3y,y^2\rangle$.
All eighteen polynomial unit identities are generated and literally
verified by
[concentrated_top_unit_identities.py](../../scripts/oct01_nonzero_source/concentrated_top_unit_identities.py),
with exact multipliers in
[concentrated_top_unit_identities.json](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/concentrated_top_unit_identities.json).
The first assertion proves independence of the two forms on the full
21-coordinate top-function space for every slope.

For the exceptional source locus, $v=c_y y$ with $c_y\ne0$, the
new compatibility is therefore nonzero on the five $m_5$ coordinates,
even though the ordinary compatibility vanishes on all eight actual
top coordinates. It removes at least one of those eight coordinates.
This sharpens the exceptional concentrated bound to seven. Off the
exceptional locus the ordinary compatibility already gave seven.
Where the two forms remain independent after substituting the actual
eight top coordinates, the dimension is exactly six. Their restricted
rank-drop loci remain part of the problem.

## The concentrated constant-v chart

Impose $(d,m)=(0,12)$ and concentration at one finite endpoint with
coordinates $(x_0,y_0)$. In the homogeneous source-coordinate order
$(\kappa,p_1,p_2,p_3,p_4,p_y,r_1,\ldots,r_7,c_0,c_1,c_2,c_3,c_y)$,
the cyclic characters are
$(1,1,1,1,1,2,0,0,2,2,2,2,2,0,0,0,0,1)$.
Use normalized coordinates $\widetilde z_i=y_0^{e_i-1}z_i$ and
first-slope parameter $\eta$, so the short root has linear term
$t'(x_0)\eta(x-x_0)/y_0$.

[concentrated_source_ranks.py](../../scripts/oct01_nonzero_source/concentrated_source_ranks.py)
forms the thirteen polynomial concentration rows together with the
infinity-profile rows and $c_1=c_2=c_3=c_y=0$.
Polynomial Euclidean row operations give rank 17 and pivot columns
1 through 17 at each of the three finite $x$-roots. All pivots except
the $c_0$ pivot are constant units. That pivot has the exact equation
$H(\eta)\widetilde c_0+R(\eta)\kappa=0$, with $H$ monic squarefree
of degree 18 and $R$ of degree 27. The literal identity
$aH+bR=1$ excludes every $H=0$ slope when $\kappa=1$.
Back substitution gives $\widetilde z_i=n_i(\eta)/H(\eta)$,
$n_0=H$, $n_{13}=-R$, $n_{14}=\cdots=n_{17}=0$ and
$\deg n_i\le29$. The script independently substitutes this tuple
into every original source row. The actual chart requires
$H R n_4\ne0$: $R\ne0$ retains the degree-ten leading coefficient,
and $n_4\ne0$ retains the exact pole twelve of $s_4$.
The source model and the Bezout identity are in
[concentrated_d0_source_family.json](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/concentrated_d0_source_family.json),
generated by
[concentrated_d0_source_family.py](../../scripts/oct01_nonzero_source/concentrated_d0_source_family.py).

Substitute these source numerators into the two top compatibilities and
clear the common factor $H$. This gives a two-by-eight polynomial
matrix in $\eta$. At every one of the nine endpoint choices its 28
maximal minors generate the unit ideal. The complete matrices, minors
and literal polynomial Bezout multipliers are in
[concentrated_d0_top_rank.json](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/concentrated_d0_top_rank.json),
produced by
[concentrated_d0_top_rank.py](../../scripts/oct01_nonzero_source/concentrated_d0_top_rank.py).
Therefore the restricted top forms have rank two at every geometric
slope. Unique lower completion proves that the necessary numerator
space has dimension exactly six throughout the valid source domain.

At $\eta=1$, for the zeroth cubic sheet at each of the three finite
$x$-roots, the exact quadratic test below has 21 symmetric-square
columns and 72 trace auxiliary columns. Forty-five separable evaluated
fibers give a 135-by-93 matrix of rank 93 in each case. Thus these
three sources have no nonzero necessary numerator, and nonvanishing
maximal minors exclude nonempty dense opens of the one-parameter
concentrated charts. These are exact probes, not a claim at all slopes.
The matrices and source tuples are in
[the first-root probe](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/concentrated_d0_quadratic_root145049_eta1.json),
[the second-root probe](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/concentrated_d0_quadratic_root211895_eta1.json)
and [the third-root probe](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/concentrated_d0_quadratic_root211959_eta1.json),
generated by
[concentrated_d0_quadratic_probe.py](../../scripts/oct01_nonzero_source/concentrated_d0_quadratic_probe.py).
These earlier probes are retained as scoped evidence. The following
independent parity obstruction excludes the entire concentrated chart,
including their closed trace-rank and evaluation-denominator loci.

Clear $H$ in the whole raw source pair, $\widehat F=HF$ and
$\widehat D=HD$. Their coefficients have $\eta$-degree at most 29, so
$\widehat\Delta=\operatorname{Res}_{10,3}(\widehat F,\widehat D)$
has degree at most $3\cdot29+10\cdot29=377$ and equals
$H^{13}\Delta$. Put $\widehat C=\widehat\Delta/t^5$.
The critical parity theorem gives $C=\Delta/t^5\in L_X(160O)$
with even divisor for every actual source. At a valid parameter $H$
is a nonzero scalar, so $\widehat C$ has the same property. Its norm
to the $x$-line is a polynomial square up to a nonzero scalar, hence
a square over $k$. Concentration forces order at least 20 at the
chosen endpoint. Therefore
\[
N(x,\eta)=\operatorname{Nm}_{k(X)/k(x)}(\widehat C)/(x-x_0)^{20}
\]
is a polynomial square of $x$-degree at most 140. This argument retains
the possible nontrivial sign two-torsion class on $X$: only its norm to
$\mathbf P^1$, whose degree-zero Picard group is zero, is squared.

For each finite $x$-root, the exact resultant was reconstructed from
416 distinct parameters on a certified root-of-unity coset in $K$,
all avoiding $H n_{13}n_4=0$. Cubic pseudo-remainders and a
three-by-three multiplication determinant compute the raw resultant;
fourteen independent scalar resultant evaluations check this formula.
Inverse Fourier reconstruction, forward replay of all samples and
vanishing of coefficients beyond degree 377 certify the polynomial
identity at every geometric parameter. This is a degree-bounded
interpolation certificate, rather than a parameter search.
The division by $t^5$ has zero remainder in every curve-ring component.

Writing $\widehat C=\sum_{j=0}^2 C_jy^j$, every coefficient of
$y_0^jC_j$ descends exactly to $K$, with a full finite-field coordinate
roundtrip. Also $P/y_0^3\in K[x]$. Thus its norm is in $K[\eta,x]$.
An exact Kronecker calculation with $x$-width 161, larger than every
$x$-degree in every norm term, gives norm degree 160 and parameter
degree 1131. Division by $(x-x_0)^{20}$ has zero remainder.

Reverse this degree bound by $\Lambda(T)=T^{140}N(1/T)$. If
$N$ is a square, including when its degree drops, then
$\Lambda=S^2$ for $\deg S\le70$. In characteristic five,
$\Lambda^{63}=S\,S^{125}$, so its coefficients at degrees 71 through
124 vanish. Let $f_{71},f_{72}$ be the first two such coefficients and
$J=H n_{13}n_4$. At each root the exact certificates give
\[
\deg f_{71}=\deg f_{72}=71253,\quad
\deg g=7917,\quad a f_{71}+b f_{72}=g,\quad gQ=J^{273}.
\]
The computed gcd is monic and nonzero. A common zero of the two tails
therefore lies on $J=0$, whereas the actual source domain has $J\ne0$.
This excludes every valid parameter. The two-tail condition need not
characterize squares; its necessity already proves the exclusion.

All source columns, $H,n_i$ and $\eta$ are over $K$. The original
coordinates are $y_0^{1-e_i}n_i/H$. A generator of
$\operatorname{Gal}(K(\rho)/K)$ therefore conjugates the entire raw
pair $(\widehat F,\widehat D)$ to the next sheet at the same parameter,
including its leading content and constant $\kappa Ht^3$ term.
The descended norm is fixed by this action. The same tail certificate
therefore covers all three cyclic sheets without a source rescaling or
parameter change. The norm-square argument and this whole-pair transfer
each passed an independent focused review.

The three exact completion indices are
[145049](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/concentrated_d0_norm_square_tails_145049.json),
[211895](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/concentrated_d0_norm_square_tails_211895.json)
and [211959](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/concentrated_d0_norm_square_tails_211959.json).
Each matching `.sobj` file retains both tails, gcd, Bezout multipliers
and power quotient; the matching symbolic norm and interpolated
resultant retain the preceding coefficients and samples.
The [focused literal identity check](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/concentrated_d0_focused_identity_checks.json)
also retains an original-source-row witness for $H\widetilde c_0+R\kappa=0$
at each root and verifies the new tail identities without replaying
settled coefficient enumeration. Reproduction uses
[the interpolation script](../../scripts/oct01_nonzero_source/concentrated_d0_critical_interpolation.sage),
[exact descent and norm](../../scripts/oct01_nonzero_source/concentrated_d0_critical_fast_norm.sage),
[the square-tail script](../../scripts/oct01_nonzero_source/concentrated_d0_norm_square_tails.sage)
and [the focused verifier](../../scripts/oct01_nonzero_source/verify_concentrated_d0_certificates.sage).
The [experiment note](../../Research/experiments/oct01_nonzero_source/CONCENTRATED_D0_NORM_EXCLUSION.md)
records the staged calculation and domain checks. Sage 10.9 and one
OMP/BLAS/VECLIB thread were used; all raw outputs remain outside the
workspace.

The complete matrices, kernels, cokernel, exceptional functional and all
nine omitted-point ranks are in
[annihilator_endpoint_projection.json](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/annihilator_endpoint_projection.json).
The geometric nine-point matrix uses one cubic extension
$\rho^3=[6]$ and has the same rank as the quotient-ring construction.

## Complete concentrated d10,m6 exclusion

Assume an actual source on $(d,m)=(10,6)$ has a concentrated selected
finite endpoint. We first retain $s_4(P)\ne0$; the critical incidence
theorem excludes its zero boundary on this profile. No condition on
the fifteen-row trace determinant will be imposed.

The full concentrated source rows and Newton coefficient rows form an
eighteen-coordinate homogeneous polynomial system in the geometric
first slope $\eta$. At each of the three finite $x$-root types its
exact polynomial row identities reduce the source, after fixing its
nonzero scale, to a two-column family with one further free coordinate
$\lambda$. A degree-seven polynomial $H$ is the only source denominator.
The original rows give
\[
Hc_3+C c_y+R\kappa=0,\qquad H\mid C,\qquad aH+bR=1.
\]
Consequently $H=0$ is impossible when the source scale $\kappa\ne0$.
The first thirteen entries of the free $c_y$ column vanish. In particular
the short critical polynomial is independent of $\lambda$.
These are exact original-row identities, verified independently by
[the source-boundary verifier](../../scripts/oct01_nonzero_source/verify_concentrated_d10m6_source_boundary.py)
and [its certificate](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/concentrated_d10m6_source_boundary_verification.json).
The family construction is
[concentrated_d10m6_source_family.py](../../scripts/oct01_nonzero_source/concentrated_d10m6_source_family.py).

Fix a selected sheet $y_0$ and put $Y=y/y_0$, $T=y_0w$. The complete
transformed raw source, including leading content and constant term,
is defined over $K=\mathbf F_{5^8}$ at fixed $\eta,\lambda$. Its
polynomial denominator-cleared form has constant contribution $Ht^3$;
the source, derivative and numerator are scaled compatibly by $H$.
If $\phi_0=y_0^5\phi$, its derivative is $\phi_0D_{\rm new}$ with
$D_{\rm new}=y_0^{-6}D(T/y_0)$. The descended curve is
$Y^3=P/y_0^3$. Thus the raw pair, and every resulting coefficient
equation, transfer to the three cyclic sheets at the SAME parameters.
No scalar content, source scale or slope change is suppressed. The
three $x$-root types are computed separately. The literal descent is
rebuilt by
[twisted_concentrated_setup.py](../../scripts/oct01_nonzero_source/twisted_concentrated_setup.py)
and
[twisted_d10m6_incidence_setup.sage](../../scripts/oct01_nonzero_source/twisted_d10m6_incidence_setup.sage).

The concentrated numerator has eight top coordinates $z$, followed
by a unique lower completion and two compatibility forms. Let $J$ be
their polynomial $2\times8$ matrix. The three minors of its
$2\times3$ fourth-moment block have degree35 and generate the unit
ideal in $K[\eta]$. A saved unimodular Hermite identity supplies a
right inverse and primitive kernel for that block. Together with the
other five top coordinates, these give an $8\times6$ polynomial
matrix $B$, of $\eta$ degree35 and $\lambda$ degree1, whose columns
form a free kernel basis of $J$ at EVERY $\eta,\lambda$.
Hence $z=Bq$ for a unique six-coordinate vector $q$. An actual
nonzero $u$ requires $q\ne0$. The exact identities are computed by
[the global kernel script](../../scripts/oct01_nonzero_source/twisted_d10m6_global_top_kernel.sage)
and saved separately at roots145049,211895,211959.

Keep all fifteen quadratic trace coordinates $n$ INDEPENDENT.
The critical quadratic incidence theorem gives
\[
U^2-FQ\equiv0\pmod D,
\quad Q=(v\rho^2-\delta_3n_2-\delta_2n_1-\delta_1n_0)
-(\delta_3n_1+\delta_2n_0)T-\delta_3n_0T^2.
\]
Here the finite-frame regularizers are retained in the functions
$n_j$; short moments are not presumed affine regular. At each of the
eight other endpoints retain its ordinary constant-coefficient row.
At the concentrated endpoint retain four constant-coefficient jets,
two linear-coefficient jets and one quadratic-coefficient jet.
These give fifteen equations $Mn+B_0\rho^2=0$.
Although $\det M$ has degree87 and its allowed exceptional part has
degree57, NEITHER polynomial is inverted.

Cubic pseudo-reduction is polynomial in the leading critical
coefficient $a=\delta_3$: use $a^3\operatorname{rem}_D U$ and
$a^8\operatorname{rem}_D F$, and clear products by $a^2$.
The resulting identity is $a^{10}\operatorname{rem}_D(U^2-FQ)$.
Its633 curve-coefficient equations, sixteen multiplied numerator
compatibilities and fifteen endpoint equations form a
$664\times51$ polynomial matrix. There are36 top products and15
independent traces; its exact parameter degrees are154 in $\eta$
and2 in $\lambda$. The
[matrix source](../../scripts/oct01_nonzero_source/twisted_d10m6_incidence_matrix.sage)
uses a certified degree-bounded polynomial encoding. A
[separate ordinary curve-arithmetic verifier](../../scripts/oct01_nonzero_source/verify_twisted_d10m6_uncleared_compact.sage)
recomputes ALL51 critical columns and all compatibility and endpoint
entries at $\eta=1,\lambda=2$. Each of the three inputs agrees and
has rank51. This bounded comparison checks arithmetic conventions;
global exclusion follows from the exact polynomial identities below.

Substitute $z=Bq$ and discard only the identically-zero compatibility
equations. The unknowns are21 symmetric products $q_iq_j$ and15
trace coordinates. Store every complete polynomial-in-$\lambda$
equation as one vector: six slots per product and three per trace,
giving171 columns. Original equations and their $\lambda$ multiples
are allowed. Additional $\lambda^2$ multiples use ONLY endpoint
equations; all their coefficients fit the same slots, with exact
overflow-zero assertions. A single equation is never split into
separate necessary equations for its $\lambda$ coefficients.

Select175 of these complete equation vectors over $K[\eta]$.
Selecting a subset weakens the necessary system. Exact row subtraction,
swapping and nonzero constant scaling preserve its module. Every
row division is recorded and is supported on the explicitly retained
units
\[
H\,a_2\,s_4(P),
\]
where $a_2\ne0$ is the exact $m=6$ coefficient. The source boundary
and zero-leading-critical endpoint boundary are already excluded.
There is no division by $v$, the critical discriminant or the trace
determinant. The native source and
[exporter](../../scripts/oct01_nonzero_source/export_native_d10m6_module.sage)
verify100 field multiplication comparisons and eight independent
Sage/NTL polynomial arithmetic fixtures through degree511.

Leading-position row reduction leaves140 nonzero rows with distinct
leading positions and maximum $\eta$ degree49. The predictable-degree
property therefore gives exact polynomial normal forms in this row
span. For EACH of the21 constant product targets $e_{ij}$ the saved
certificate gives
\[
\operatorname{NF}(f e_{ij})=0,\qquad f=cH^2,\quad c\in K^\times.
\]
These are membership identities in the localized module of ORIGINAL
complete equation vectors. Evaluation at the actual $\eta,\lambda$
therefore yields $f(\eta)q_iq_j=0$. Since $H(\eta)\ne0$, the six
diagonal identities force $q=0$, contradicting nonzero $u$.
This applies at every parameter, including EVERY slope with $\det M=0$.
No conclusion is inferred from finitely many slopes or a generic rank.

The exact operation stream, selected original rows, reduced basis and
scalar target certificates are retained outside the workspace. The
[extractor](../../scripts/oct01_nonzero_source/extract_native_module_certificate.py)
checks all21 saved zero normal forms. Independent Sage/NTL arithmetic
checks all six diagonal targets, distinct leading positions,
$f=cH^2$ and exact divisibility by the square of the stated unit
product; see
[the verifier](../../scripts/oct01_nonzero_source/verify_native_module_targets.sage).
The three independent compact certificates and verification records are:

| Endpoint root | Exact target certificate | Independent diagonal verification |
|---|---|---|
|145049|[certificate](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/native_uncleared_module_145049/small_certificate.json)|[verification](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/native_uncleared_module_145049/independent_ntl_verification.json)|
|211895|[certificate](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/native_uncleared_module_211895/small_certificate.json)|[verification](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/native_uncleared_module_211895/independent_ntl_verification.json)|
|211959|[certificate](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/native_uncleared_module_211959/small_certificate.json)|[verification](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/native_uncleared_module_211959/independent_ntl_verification.json)|

Each adjacent directory retains the full input and operation stream.
The sequential
[reproduction pipeline](../../scripts/oct01_nonzero_source/run_concentrated_d10m6_root.sh)
uses one calculation core with OMP/BLAS/VECLIB pinned to1.
The first root used the polynomial-quotient leading-position reduction;
the later two used its equivalent monomial shift/scale implementation.
Their native times were580,128,128 seconds respectively; all three
have the same exact certificate degree and scope. During the third
matrix construction, Sage's preparser converted the requested zero
exit code into a Sage integer, causing a nonzero process exit AFTER
all matrix data and assertions were saved. The exit-code conversion
was fixed and the pipeline resumed at the next stage; no successful
matrix calculation was replayed.
The
[experiment note](../../Research/experiments/oct01_nonzero_source/CONCENTRATED_D10_M6_INCIDENCE.md)
retains the superseded determinant-open certificate and failed dense
elimination attempts as provenance.

### The m3 boundary is included by a reduced-unit certificate

The concentrated source family above is defined by the $m\le6$
coefficient equations. Its Newton bounds on the five large pole-two
branches are identical for $m=3$ and $m=6$; the $m=3$ equations add
only the vanishing of the quadratic coefficient $a_2$ of $s_4$.
The source normalization and global top kernel never invert $a_2$.
However the original native certificates above divided twelve
original rows by powers of $a_2$. They do not, by themselves,
specialize to that boundary.

Reuse the SAME raw matrix and global kernel, and allow row division
only on $H s_4(P)$, removing $a_2$ from the unit polynomial.
This new pass is performed separately at all three root types.
Each still gives140 distinct leading positions, maximum eta degree49,
and all21 identities $\operatorname{NF}(cH^2e_{ij})=0$.
Independent Sage/NTL arithmetic verifies all six diagonal targets
and exact scalar/support identities. Thus the proof now applies
when $a_2=0$ as well. Every actual concentrated $m=3$ source belongs
to this family, and its zero-$s_4(P)$ endpoint boundary is already
excluded by the same canonical critical incidence theorem.
This proves the entire concentrated $(10,3)$ chart impossible;
the new certificate also independently covers $(10,6)$.

| Endpoint root | Reduced-unit exact certificate | Independent verification |
|---|---|---|
|145049|[certificate](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/native_smallcritical_module_145049/small_certificate.json)|[verification](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/native_smallcritical_module_145049/independent_ntl_verification.json)|
|211895|[certificate](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/native_smallcritical_module_211895/small_certificate.json)|[verification](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/native_smallcritical_module_211895/independent_ntl_verification.json)|
|211959|[certificate](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/native_smallcritical_module_211959/small_certificate.json)|[verification](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/native_smallcritical_module_211959/independent_ntl_verification.json)|

The domain change is reproducible by
[prepare_small_critical_domain.py](../../scripts/oct01_nonzero_source/prepare_small_critical_domain.py).
The literal original row-divisor inventory is retained alongside
each certificate. The reduced-unit native times were135,141,140
seconds, on one calculation core. No successful large matrix
construction was replayed for this changed domain claim.

## The exact quadratic trace equations

Let $K_j=\operatorname{Tr}(w^j u^2)$ for $0\le j\le2$ in the finite frame.
Every actual source has affine $\eta_0,\eta_1,\eta_2$ satisfying
\[
\eta_0\in L_X(20O),\quad\eta_1\in L_X(32O),\quad
\eta_2\in L_X(44O),
\]
\[
K_0=\eta_0,\qquad vK_1=\Pi_1(v\eta_0)+\eta_1,
\]
\[
v^2K_2=
2\Pi_1(v\eta_1)+2\Pi_1\bigl(v\Pi_1(v\eta_0)\bigr)
-\Pi_2(v^2\eta_0)+\eta_2.
\]
Here $v^jK_j$ is finite regular even at $G$, since multiplication by
$v^j$ removes the poles of $w^j$. In the short frame, $u^2$ has pole
at most 20 and the largest surviving $W$ pole is $12-d$.
Thus $v^j\operatorname{Tr}(u^2W^j)$ has pole at most $20+12j$.
Writing $a^nc=\Pi_n(c)+r_n(c)$, the first regularized difference is
$v\operatorname{Tr}(u^2W)+r_1(v\eta_0)$.
The second differs from $v^2\operatorname{Tr}(u^2W^2)$ by
\[
2r_1(v\eta_1)+2r_1\bigl(v\Pi_1(v\eta_0)\bigr)-r_2(v^2\eta_0).
\]
These have the asserted bounds. The 72 auxiliary coordinates have
dimensions $12+24+36$. In particular these claims do not assert that
the raw finite-frame moments $K_j$ lie in $L_X((20+12j)O)$.

For the evaluated equations one may compute in the degree-ten algebra:
$u=U_f/D_f$, and $F_f$ is separable at every retained test fiber.
This gives exact equations quadratic in the numerator coordinates and
linear in the 72 trace auxiliaries. Evaluation at any chosen base
fiber is a necessary consequence of the global identities.

## Source-independent product identity and open exclusion

Let $V_0$ be the fixed nine-dimensional lower space with $m_4=m_5=0$
and all nine finite endpoint jets. The exact full-coefficient calculation
in [lower_product_space.py](../../scripts/oct01_nonzero_source/lower_product_space.py)
gives multiplication rank 44 on its 45-dimensional symmetric square.
The subspace $\{g\in V_0:xg\in V_0\}$ has dimension two. For a basis
$g,h$, the entire kernel is $g(xh)-h(xg)$. Its symmetric matrix has rank
four. These assertions are coefficient identities, not sampled traces:
[lower_numerator_product_space.json](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/lower_numerator_product_space.json)
retains the matrix and the four generators.

The fixed space has the following intrinsic geometry. Let
$D_{\rm fin}=\operatorname{div}_0t$, so $D_{\rm fin}\sim9O$, and work
inside $k(X)[T]_{\le1}$. Define a rank-two bundle $\mathcal A_0$ by
local bases $(r,T)$ at the nine endpoints, $(1,T+a)$ at all other
finite points, and $(1,r_OT)$ at infinity. Here $r,r_O$ are local
parameters. The first finite basis imposes the actual short-coordinate
jet; the other finite basis imposes finite-frame regularity, including
at the poles of $a$. These are genuine lattice bases with invertible
transition matrices, so define a locally free bundle.
Its constant intersection and leading-coefficient quotient give
\[
0\to\mathcal O_X(-D_{\rm fin})\to\mathcal A_0
\to\mathcal O_X(-O)\to0.
\]
Put $\mathcal A=\mathcal A_0(9O)$. Then its constant line is trivial
and its quotient is $\mathcal O_X(8O)$. The bundle
$\mathcal E=\mathcal O_X(25O)\otimes\operatorname{Sym}^3\mathcal A_0$
has endpoint bases $(r^3,r^2T,rT^2,T^3)$, finite bases
$(1,T+a,(T+a)^2,(T+a)^3)$ elsewhere, and the exact short pole bounds
$25-j$ at infinity. It therefore has exactly the defining local
conditions of $V_0$. Also
\[
\mathcal E\simeq\mathcal O_X(-2O)\otimes\operatorname{Sym}^3\mathcal A,
\quad
\operatorname{gr}_j\mathcal E
=\mathcal O_X((25-j)O-(3-j)D_{\rm fin})
\simeq\mathcal O_X((8j-2)O).
\]
Its degree is forty and rank four, giving Euler characteristic eight.
The established nine-dimensional section space hence has $h^1=1$;
the single endpoint obstruction is a genuine cohomology cokernel.

Since $x$ has only its order-three pole at infinity,
$H^0(\mathcal E(-3O))=\{q\in V_0:xq\in V_0\}$ has dimension two.
There is no section of $\mathcal E(-6O)$: such a nonzero $q$ would
give independent $q,xq,x^2q$ and the nonzero rank-three product
relation $q(x^2q)-(xq)^2$, contradicting the unique rank-four kernel.
Independence follows from transcendence of $x$ in the integral
polynomial ring. The finite flat trigonal map has
$x^*\mathcal O_{\mathbf P^1}(1)=\mathcal O_X(3O)$.
Its pushforward has rank twelve and degree $8-12=-4$.
Projection formula and splitting on $\mathbf P^1$ now determine it:
the vanishing at twist minus two and dimension two at twist minus one
give two $\mathcal O(1)$ summands; the total section dimension nine
gives five $\mathcal O$ summands; the five remaining negative summands
have total degree minus six and are four $\mathcal O(-1)$ and one
$\mathcal O(-2)$. This proves the asserted splitting. The two positive
summands supply the pencils $(g,xg),(h,xh)$ and their Segre quadric,
with five additional coordinate vertex directions. This is a statement
about the raw section system, not about a further source-dependent
trace quotient.

Let $W_0\subset V_0$ be the five-dimensional kernel of the four extra
concentrated rows at one endpoint. The retained matrix of the raw
rank-four quadric, multiplied on the left by those extra rows, has rank
two at each endpoint. In particular the quadric's support is not
contained in $W_0$. A symmetric tensor belongs to
$\operatorname{Sym}^2W_0$ only if its associated matrix has image in
$W_0$; the unique raw multiplication relation fails this condition.
Therefore the multiplication map on $\operatorname{Sym}^2W_0$ is
injective and has rank 15. This claim concerns only the fixed lower
subspace; no full 12/13-dimensional trace injectivity is inferred.

The exact source specializations tested by
[quadratic_torsion_probe.py](../../scripts/oct01_nonzero_source/quadratic_torsion_probe.py)
are $(d,m,\mathrm{seed})=(10,3,1),(10,3,2),(0,12,1)$.
Their necessary numerator spaces have dimension 16. Evaluation at
100, 100 and 110 retained finite fibers gives matrices of respectively
300, 300 and 330 rows on 136 quadratic and 72 trace coordinates.
In each case the trace-auxiliary rank is 72 and the full rank is 207.
The unique kernel is the rank-four raw product identity just described.
Its raw polynomial vanishing is separately checked in every certificate.

[extract_open_minors.py](../../scripts/oct01_nonzero_source/extract_open_minors.py)
extracts explicit 207-by-207 minors from these retained matrices. Their
determinants are the nonzero $K$-codes 222214, 354034 and 44891:
[quadratic_trace_open_minors.json](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/quadratic_trace_open_minors.json).
The complete specialized matrices are retained alongside that file.

For each of the two Newton coefficient charts, use the audited affine
linear $S$ incidence and its nonzero exact-pole forms, together with the
independent affine linear $v$ coefficients. These charts are irreducible.
The total endpoint matrix has constant rank 54. Choose a pivot minor
nonzero at the recorded source specialization; the resulting numerator
basis is rational on that pivot open. Use the recorded test fibers and
restrict further to the denominator open where $v$ and $D_f$ are invertible
in each degree-ten evaluated algebra. The retained 207-by-207 minor is
then a rational function of the source coefficients. Its recorded nonzero
value shows that its numerator, after clearing denominators, is not the
zero polynomial.

On the resulting nonempty open, the whole test kernel has dimension one,
since the fixed product identity exists for every source and the minor
forces rank 207. Its symmetric rank remains four: its four generators
$g,xg,h,xh$ are independent in the fixed $V_0$ subspace. A nonzero
Veronese square has symmetric rank one, so no nonzero actual $U_f$ can
belong to this kernel. This excludes that coefficient open. It leaves
the minor's closed zero locus, pivot/evaluation boundaries and all other
Newton charts fully included. Concentration is retained within the
universal 16/17-dimensional spaces.

## Formal norm identity and scope

The divisor of the norm of $u$ is $10B^*-100O$, so
$\operatorname{Nm}(u)=ct^{10}$, $c\ne0$.
Since $U_s(W)=uD_s(W)$,
$\operatorname{Res}_{10,5}(F_s,U_s)=v^5\operatorname{Nm}(U_s)$ and
$\operatorname{Res}_{10,3}(F_s,D_s)=v^3\operatorname{Nm}(D_s)$.
Their quotient proves the stated identity. Formal degree five retains
the correct $v$ factor even when the actual degree of $U_s$ drops.

The complementary reduced divisor is $E'=h^*B^*-E$. Since
$\operatorname{div}(t)=B^*-10O$, the function $u'=t^2/u$ has
$\operatorname{div}(u')=2E'-10H$. Scalar normalization of
$\operatorname{Nm}(u)=ct^{10}$ to $c=1$ is legal over the algebraically
closed field: multiply $u$ by a scalar whose tenth power is $c^{-1}$.
Then both $u$ and $u'$ have norm $t^{10}$.

Write $a_j=e_j(u_1,\ldots,u_{10})$ and
$a_j'=e_j(u_1',\ldots,u_{10}')$. Their functions are affine regular.
At infinity, each has five sheets with pole ten and five with pole eight.
Consequently the $j$th characteristic coefficient has pole at most $10j$
for $j\le5$, and at most $8j+10$ for $j\ge5$. In particular the stated
low coefficient spaces and $a_5\in L_X(50O)$ apply.
The reciprocal elementary-symmetric identity gives
\[
a_{10-j}=t^{10-2j}a_j'\quad(0\le j\le10),\qquad a_5=a_5'.
\]
This proves the displayed form of the monic characteristic polynomial
$M(Z)=\prod_i(Z-u_i)$.

With $\Delta=\operatorname{Res}_{10,3}(F_s,D_s)$, formal degree-five
resultants give
\[
\operatorname{Res}_{10,5}(F_s,U_s-ZD_s)
=v^5\operatorname{Nm}(D_s)\prod_i(u_i-Z)
=v^2\Delta M(Z).
\]
This identity has no division by $v$, $t$ or $\Delta$.
For a separable primitive candidate with $\gcd(F_s,D_s)=1$,
the same norm calculation shows that an identity of this form forces
$M$ to be the characteristic polynomial of $U_s(W)/D_s(W)$.
Its monic coefficients are affine regular, so that function is integral
over every affine local ring on $X$ and finite regular on the normalization.
The constant coefficient is $t^{10}$, and the reciprocal form forces the
characteristic polynomial of $t^2/u$ to have the same affine coefficients
with $a_j,a_j'$ interchanged. Thus $u'$ is finite regular as well.
At each finite point outside $B^*$ both functions are units; at an endpoint
their orders lie between zero and two. These conclusions do not identify
which five sheets have order two. The selected reduced divisor and actual
everywhere étaleness remain separate requirements.

All computed spaces are covering necessary spaces. No candidate is
asserted to have primitive irreducible polynomial, connected everywhere
étale normalization, genus 81 or the required nontrivial divisor class.
The actual existence question remains open.

## One middle coefficient assigns the complete annihilator divisor

We first record a local lemma valid in any characteristic. Let $R$ be a
strictly henselian DVR with uniformizer $r$ and let an étale source split
into $n$ sheets. Select a set $I$ of $e$ sheets. Suppose
\[
\operatorname{ord}\varphi_i=a>\ell\quad(i\in I),\qquad
\operatorname{ord}\varphi_i\le0\quad(i\notin I).
\]
Suppose $q_i,q_i'$ are integral, their products have order $\ell$ on
every sheet, and $\operatorname{ord}\prod_iq_i=\ell e$.
Then $0\le\operatorname{ord}q_i\le\ell$. Let
$c_R$ have order $-\sum_{i\notin I}\operatorname{ord}\varphi_i$.
The single mixed coefficient
\[
C_e=c_R[z^e]\prod_i(\varphi_i+zq_i)
=c_R\Bigl(\prod_i\varphi_i\Bigr)e_e(q_i/\varphi_i)
\]
has order exactly $\sum_{i\in I}\operatorname{ord}q_i$.
Indeed all selected ratios have strictly negative order and all other
ratios have nonnegative order. Among the products of $e$ ratios,
the product of precisely the selected ratios is the unique term with
smallest valuation. Any different subset replaces at least one negative
valuation by a nonnegative one, strictly increasing the sum.
There is therefore no leading cancellation, even when $e$ is divisible
by the characteristic. The factor $c_R$ removes exactly the nonselected
$\varphi$ pole contribution.

Consequently $\operatorname{ord}C_e\ge\ell e$ is equivalent to
$\operatorname{ord}q_i=\ell$ on every selected sheet and
$\operatorname{ord}q_i=0$ on every other sheet. The first conclusion
follows from the individual upper bound; the second follows from the
norm order and individual nonnegativity. This local assertion permits
poles of $\varphi$ on any nonselected sheets.

Return to degree ten, and assume the characteristic identity has already
been imposed on an actual primitive étale source with the prescribed
$\phi$ divisor. It forces $u=U_s(W)/D_s(W)$ and $u'=t^2/u$ to be finite
regular and to have norm $t^{10}$. The same coefficient bounds force each
to have pole at most ten on every infinity sheet: multiplying its monic
characteristic polynomial by the appropriate powers of a uniformizer
makes it monic integral. This argument applies also to $u'$ by swapping
the low coefficient sets. In particular neither function is zero.

Let
\[
B_5=v^5[z^5]\operatorname{Nm}(\phi+zu)
=t^{15}e_5(u_i/\phi_i).
\]
At a finite selected endpoint, $\operatorname{ord}t=1$,
$\operatorname{ord}\operatorname{Nm}u=10$ and
$0\le\operatorname{ord}u_i\le2$.
The five selected $\phi_i$ have order three; every other $\phi_i$ has
order zero or $-5g_i$. Primitive content gives
$\operatorname{ord}v=\sum g_i$, so $c_R=v^5$ is precisely the correction
in the lemma. Therefore
\[
\operatorname{ord}B_5
=\sum_{\text{selected }i}\operatorname{ord}u_i.
\]
Divisibility by $t^{10}$ forces all five selected orders to be two and
all other orders to be zero. Outside the selected endpoints, $t$ is a
unit and the finite regular functions $u,u'$ are units. This recovers the
whole finite part of the prescribed divisor, including fibers that also
contain $G$ poles.

At infinity take a uniformizer $r$ and put
$\widehat u=r^{10}u$, $\widehat u'=r^{10}u'$ and
$\widehat\phi=r^{10}\phi$. Both hatted $u$ functions are integral;
their product $r^{20}t^2$ has order two and
$\operatorname{Nm}(\widehat u)$ has order ten.
The five selected sheets have $\widehat\phi$ order three. A big sheet
with $W$ pole $a_i=2+g_i$ has $\widehat\phi$ order $-5g_i$.
Here $\sum g_i=10-d$, so the correction in the lemma has order $50-5d$.
Rescaling the mixed norm multiplies its coefficient by $r^{100}$,
while $\operatorname{ord}v^5=-5d$. Hence the corrected coefficient has
valuation
\[
150+\operatorname{ord}_O B_5.
\]
If $B_5=t^{10}b_5$ with $b_5\in L_X(50O)$, then
$\operatorname{ord}_O B_5\ge-140$. The lemma forces
$\widehat u$ to have order two on each selected sheet and zero on each
big sheet. Thus $u$ has pole eight and ten, respectively, exactly as
required by $\operatorname{div}u=2E-10H$.

Conversely, for that prescribed divisor the same unique leading term
argument gives divisibility of $B_5$ by $t^{10}$ at all nine finite
endpoints. At other finite points the coefficient $B_5$ is regular:
each mixed norm term can have total $\phi$ pole at most
$5\sum g_i$, canceled by $v^5$, and $u$ is integral.
At infinity $\chi=u/\phi$ has pole one on the five selected sheets
and is integral on every big sheet. Thus $e_5(\chi)$ has pole at most
five. Since $B_5=t^{15}e_5(\chi)$, its pole is at most 140.
It follows that $b_5=B_5/t^{10}$ is affine regular with pole at most
50, as asserted.

Finally the formal degree-eight norm calculation gives
\[
\operatorname{Res}_{10,8}(F_s,\phi_sD_s+zU_s)
=v^8\operatorname{Nm}(D_s)\operatorname{Nm}(\phi+zu)
=v^5\Delta\operatorname{Nm}(\phi+zu).
\]
Taking its middle coefficient gives precisely the displayed polynomial
identity. Its quotient interpretation is used only in the function
field, where $\Delta\ne0$; its polynomial form retains every boundary
zero. This proves the stated equivalence on an already actual source.
Nontriviality can then be retained by one exact differential open:
$T=E-G-4H$ is principal if and only if $\phi u$ is a fifth power.
Indeed $\operatorname{div}(\phi u)=5T$, and any constant factor has a
fifth root over $k$. For a function field over perfect $k$ in
characteristic five, the kernel of the differential is precisely its
fifth-power subfield. Thus $T$ is nontrivial if and only if
$d(\phi u)\ne0$. This is also the nonvanishing of the regular
Cartier-fixed logarithmic differential
$3\,d\log u-2\,d\log\phi=3\,d\log(\phi u)$.

For an explicit field calculation let $\delta=d/dx$, acting on the base
coefficient functions, and write $F=F_s$, $U=U_s$, $D=D_s$ and
$\phi=T^5+q_s$. The source derivation has
$\delta W=-\delta F/(\phi D)$ and $\delta\phi=\delta f$.
Therefore $d(\phi u)\ne0$ is equivalent to nonvanishing modulo $F$ of
\[
\phi D\bigl((\delta U)D-U\delta D\bigr)
-(U_TD-UD_T)\delta F+UD^2\delta f.
\]
This is a field identity, so its cleared nonvanishing test does not
discard individual boundary points. It is linear in $U$ and the
derivatives of its coefficients. Actual source realization and
everywhere étaleness remain separate.
