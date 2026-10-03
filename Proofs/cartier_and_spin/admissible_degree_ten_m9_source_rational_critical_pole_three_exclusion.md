# Proof of source-only pole-three critical-root exclusion in degree-ten m9

ID: `admissible_degree_ten_m9_source_rational_critical_pole_three_exclusion`.
Version1,2 October2026.

2 October2026. Major completed branch; the focused
[independent audit](../../Research/audits/M9_SOURCE_POLE_THREE_AUDIT_2026_10_02.md)
passed. No fourth-moment, annihilator-numerator cancellation,
or irreducibility conclusion for the remaining pole-four profile is
claimed. All inputs and notation below belong to the ACTUAL degree10
m9 admissible source. The two original finite etale legs remain on
the same source; the argument does not replace them by arbitrary maps.

## Established normal form and source equations

Use the fixed curve $X:y^3=P(x)$ and fixed polynomials $Z,q,q_3,A$
in the
[audited source-critical theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_source_critical_fitting_reduction.md).
At infinity $x,y,a=Z/y$ have poles3,10,17. Let $c$ be a rational
root of the cubic critical factor, with infinity pole3. In short
coordinates write $D_s=\delta(T-c)(T^2+bT+e)$; then $b$ has EXACT
pole4 and $e$ has pole at most5. In finite coordinates
$c_f=c+a$, $b_f=b-2a$, $e_f=e-ab_f-a^2$.
The minimal polynomial $x$-denominator of BOTH $c_f,b_f$ is the full
degree3 polynomial $\delta$, with its actual multiplicities.
The source leading line permits
$\delta=q_3+\lambda q$, with finite $\lambda$; write
$Z\delta=PK+R$. The source normal form is
\[
N_c=\delta c_f=Ky^2+C_4+\gamma y,
\quad N_b=\delta b_f=-2Ky^2+B_4+D_1y,
\]
where $\gamma$ is constant, $D_1$ is affine linear, and $B_4,C_4$
have degree at most4. The source bounds force
$N_e=\delta e_f=\eta_e-\Pi_1(N_b)-\Pi_2(\delta)$,
$\eta_e=E_4+yE_1\in L(14O)$, a seven-dimensional unrestricted space.
The exact short identity is
\[
\delta e=E_4+y(E_1+T_\delta)+y^2H_{B_4},
\quad H_g=\operatorname{rem}(Zg,P)/P,
\quad T_\delta=\operatorname{rem}(Z^2\delta,P)/P.
\]
The source gap17 condition is
$[x^9]\operatorname{rem}(ZB_4,P)=0$.
At each selected point, actual contact gives $D_s(0)=0$;
when $\delta$ is a unit and $c\ne0$, this forces the SHORT $e=0$.

For any local critical point, if $h_c,h_b,h_e$ are finite-frame
pole orders, the integral quadratic factor and Gauss content give
$h_c+\max(h_b,h_e)\le\operatorname{ord}(\delta)$.
In particular maximal $c_f,b_f$ pole supports are disjoint.
On a $c_f$-max point, $e_f$ is regular, so $N_e$ vanishes to the
FULL local multiplicity of $\delta$ there.

The audited source theorem already excludes the entire no-ordinary-
$C$-singleton case, including repeated, branch, slope and selected
boundaries. Here a $C$-singleton means MAXIMAL pole support on exactly
one sheet of an ordinary critical fiber. Consequently every remaining
source has at least one such fiber; there $K,P$ are nonzero and
$\gamma=Ky_0\ne0$.

## The universal gap-only norm

First suppose $\delta$ is simple and has a UNIQUE ordinary
$C$-singleton fiber $r_0$, with its sheet $y_0$. At ordinary
complementary fibers $r_1,r_2$, $c_f$ has double maximal pole support
and $b_f$ has singleton maximal support $y_1,y_2$.
The finite CRT formula is
\[
D_1(r_i)=-2K_i y_i\quad(i=1,2),
\quad B_0(r_i)=-2K_i y_i^2\quad(i=1,2),
\quad B_0(r_0)=2K_0y_0^2-D_1(r_0)y_0,
\quad B_4=B_0+\delta(\mu_b+\nu_bx).
\]
Here $B_0$ is quadratic and $D_1$ is linear. The distinguished
fiber's $b_f$ support may have one OR two sheets; no extra support
restriction is imposed there.

Exactly
$[x^9]\operatorname{rem}(Z\delta,P)
=[x^9]\operatorname{rem}(Z\delta x,P)=0$.
Thus the source gap17 is the fixed linear condition
$\mathfrak g(B_0)=[x^9]\operatorname{rem}(ZB_0,P)=0$,
independent of both $b$ shifts and all selected contact choices.
Take its norm through the EXPLICIT critical sheet parameter cover
$y_i^3=P(r_i)$, then descend by complementary-root symmetry.
Set $\lambda=-q_3(r_0)/q(r_0)$. The resulting rational function
$G(r_0)$ has numerator degree162 and denominator degree126 over
the selected-root field $\mathbf F_{5^8}$.
The exact numerator factors are six linear cubes and four degree12
cubes. Its radical $g$ has degree54.

This is a necessary source support; it is independent of the
selected zero itinerary. The norm was computed directly, and its
identity with the common factor of the first J111 minors was checked
exactly. The complementary quadratic coefficient is zero.
Every denominator factor is supported on $q(r_0)=0$ or the critical
discriminant. The numerator is coprime to the latter and to the
branch, selected-critical and $K$-zero supports.

Sources/evidence:
[norm algorithm](../../scripts/oct02_m9_uniform_source_e_J111_norm.sage),
[direct gap norm](../../../litt3-computation-data/oct02_m9_uniform/source_e_J111_case00_gap.json),
[denominator and boundary support](../../../litt3-computation-data/oct02_m9_uniform/uniform_gap_support_boundaries.json).
This is a cover of fixed-curve root/sheet PARAMETERS, never a
presumed simultaneous Galois closure of the original source maps.

## All ordinary selected itineraries

If two selected SHORT $c$ zeros occur in one fiber, the entire case
is excluded by the
[new source-e selected-double proof](../../Research/experiments/oct02_m9_uniform/SOURCE_SELECTED_DOUBLE_EXCLUSION.md).
Its degree10 supports $E_s$ and four first-jet boundary exclusions
were already exact inputs; eighteen NEW source-e9 systems exclude
all remaining geometric scalar strata. No canceled-root quotient
space or fourth-moment hypothesis is used.

Otherwise each selected fiber has at most one zero. Enlarge the
actual zero set to one chosen point in each of the three selected
fibers. Dropping the additional $e=0$ equations is a valid relaxation.
Call their coordinates $(s_i,z_i)$, and put
$\ell_i=1/\prod_{j\ne i}(s_i-s_j)$.
The two complementary $e=0$ sheets over $s_i$ give
$E_1(s_i)=z_iH_{B_4}(s_i)-T_\delta(s_i)$.
Their compatibility with degree1 $E_1$ is the affine-linear row
\[
\sum_i\ell_i z_iH_{B_4}(s_i)
-\sum_i\ell_iT_\delta(s_i)=0.
\]
Interpolate $\widehat E_1$ through the first two such values.
Finite integrality at the two $c_f$ poles over $r_j$, $j=1,2$,
after subtracting the two sheet equations, gives the exact rows
\[
g_j=\widehat E_1(r_j)+T_\delta(r_j)
-y_jH_{B_4}(r_j)=0.
\]
They follow from the actual finite $N_e$ equation; no remaining
$E_4$ coefficient appears. All three displayed rows are affine in
the unrestricted two shifts $\mu_b,\nu_b$.
Hence their augmented3-by3 determinant is zero, regardless of
any coefficient-rank drop. Replace $g_1,g_2$ by their sum and
$(g_1-g_2)/(r_1-r_2)$ to make complementary symmetry explicit.

Compute the norm of this determinant MODULO the universal radical
$g(r_0)$, without any parameter resultant. For all nine exact
selected phase orbits its norm remainder has Bezout gcd1 with $g$.
Thus no actual marking satisfies both necessary source equations.
Different individual norm phases only enlarge the necessary support;
a unit gcd still excludes a compatible common marking.

The nine orbits are the27 choices of selected sheets at a fixed
omission, modulo the simultaneous cubic rotation. Frobenius25 cycles
the four omissions, after the common frame normalization. Only the
simultaneous rotation is used, not an independent rotation of one
selected fiber. Prototype0 took5.94 seconds. Eight NEW representatives
took65.67 seconds aggregate wall time, sequentially with15-second
per-case and80-second aggregate wall caps. All nine were completed.

Evidence:
[nine J111 norms](../../../litt3-computation-data/oct02_m9_uniform/source_e_J111_batch.json).
An earlier independent
[selected cross-fiber pair proof](../../Research/experiments/oct02_m9_uniform/ORDINARY_SOURCE_PAIR_SUPPORT_EXCLUSION.md)
is preserved as a useful exact specialization; the J111 relaxation
now includes its empty/single/pair cases.

## Multiple singleton fibers

Two ordinary $C$-singleton fibers require equal values of $K^3P$,
since both equal $\gamma^3$. The discriminant of the three critical
$K^3P$ values has degree22 in $\lambda$. Dividing by the degree4
critical discriminant gives the square of a degree9 polynomial,
with irreducible factors of degrees3 and6 over $\mathbf F_{25}$.
This support is coprime to the critical-repeat, branch, selected-
critical and $K$-zero supports. On BOTH exact parameter strata the
three critical values have groups of sizes2 and1; no triple equality
occurs.

At the two singleton roots $r_i$, $y_i=\gamma/K_i$ is fixed by a
choice of cube root $\gamma$. At the third root $r_2$, choose the
complementary $b_f$ sheet $y_2$. Retain the arbitrary slope
$\alpha$ in
$D_1=-2K_2y_2+\alpha(x-r_2)$.
Then $B_0=B_{00}+\alpha B_{01}$ by CRT, whereas $C_0$ is independent
of $\alpha$. Use the seven $\eta_e$ coefficients, two $b$ shifts,
and this EXTRA unrestricted slope: ten unknowns.
Impose gap17, $N_e=0$ at the two singleton and two third-fiber
$c_f$ poles, and short $e=0$ outside the COMPLETE geometric selected
$c$-zero set. Enumerate all affine-line and intersection strata of
$\mu_c,\nu_c$ with $\nu_c\ne0$.

All24 representative source-e10 systems are inconsistent on every
stratum. Coverage is two irreducible parameter factors, all three
third $b$ sheets and all four omissions; diagonal cubic rotation
normalizes $\gamma$. Frobenius covers each parameter factor's other
roots. The saved $\mathbf F_{5^{72}}$ field contains all these roots
and sheets. Prototype0.658 seconds; the other23 took6.865 seconds
under a15-second hard cap.

Sources/evidence:
[G collision support](../../scripts/oct02_m9_uniform_critical_G_collision.sage),
[exact support factors](../../../litt3-computation-data/oct02_m9_uniform/critical_G_collision_support.json),
[new unrestricted-slope source systems](../../scripts/oct02_m9_uniform_source_e_multiple_single.sage),
[all24 systems](../../../litt3-computation-data/oct02_m9_uniform/source_e_multiple_single_complete.json).

## Repeated critical roots

Every repeated pencil parameter is represented by a root of
$q_3'q-q_3q'$, degree4. The four exact parameters give a double
root $r$ and a different simple root $s$; there is no triple root.
All four have $P,K,A$ units and UNEQUAL $K^3P$ values at $r,s$.
At the repeated root maximal support has size1 or2: size3 cannot
be disjoint from the nonempty maximal $b_f$ support.

If $c_f$ has singleton maximal support and $b_f$ has both
complementary maximal sheets, Gauss makes $c_f$ regular on both,
forcing $\gamma^3\equiv K^3P\bmod(x-r)^2$. Its first jet contradicts
the exact degree4/13 Bezout identity in the
[properly scoped jet ingredient](../../Research/experiments/oct02_m9_uniform/REPEATED_C_SINGLE_JET_OBSTRUCTION.md).
Singleton MAXIMAL support alone is not sufficient for that jet
condition; the tied singleton case is retained below.

The two remaining profiles are:

- repeated $c_f$ double / $b_f$ single, with simple $c_f$ single;
- repeated tied $c_f,b_f$ single maximal supports on DIFFERENT
  sheets, with a lower $c_f$ pole on the third sheet, and simple
  $c_f$ double / $b_f$ single.

In the first profile, $D_1$ and $B_0$ have their full value and
first jet determined by regularity of $b_f$ on the two repeated
$c_f$-max sheets. In the second, $D_1$ is determined by its values
at $r,s$, $B_0'$ by $b_f$ regularity on the repeated $c_f$-max sheet,
and $C_0'$ by $c_f$ regularity on the repeated $b_f$-max sheet.
Use the unique degree2 Hermite polynomials with these value/jet
data and the simple-fiber value. Retain both unrestricted $b$
shifts and all seven $\eta_e$ coefficients.

For profile one, impose value AND first jet of $N_e$ on both
repeated $c_f$ poles, plus its value at the simple singleton.
For profile two, impose value and first jet at the repeated
$c_f$-max point, its value at the lower third-sheet pole, and its
values at the two simple-fiber $c_f$ poles. The lower pole is
nonzero: otherwise the scoped singleton jet would apply.
These are five source-e conditions in each profile, with gap17
and all actual selected contact rows. The geometric selected
strata are again enumerated exactly, retaining $\nu_c\ne0$.

All144 NEW systems are inconsistent. Coverage is all four repeated
parameters, three relative-sheet choices in profile one and six
in profile two, and all four omissions, after diagonal cubic
normalization. The native field $\mathbf F_{5^{72}}$ is required:
the repeated cubic root orbit's sheets lie over $\mathbf F_{5^{18}}$,
while selected sheets lie over $\mathbf F_{5^{24}}$. Its exact
irreducible modulus is saved. Prototype0.740 seconds; other143
took38.227 seconds under a45-second hard cap.

Source/evidence:
[Hermite and source jets](../../scripts/oct02_m9_uniform_source_e_repeated.sage),
[complete144-case ledger](../../../litt3-computation-data/oct02_m9_uniform/source_e_repeated_complete.json).

## Simple branch, selected-critical and K-zero boundaries

At a simple ordinary $K$-zero fiber, $N_c,N_b$ are linear in the
three distinct $y$ residues. Each nonzero numerator is nonzero on
at least two sheets. Neither numerator may vanish on all sheets,
by the full minimal denominator. Thus their maximal supports
intersect, contradicting Gauss. This excludes such a fiber.

At a branch fiber with critical multiplicity$\ell$, full minimal
denominators give $h_c,h_b\ge3\ell-2$. Gauss gives
$6\ell-4\le3\ell$, hence $\ell=1$.
At a simple branch, since some ordinary singleton exists,
$\gamma\ne0$. Then $C_4(r)=0$, $h_c=2$, and Gauss forces
$B_4(r)=D_1(r)=0$, $h_b=1$. If $K(r)=0$, every term of $N_b$
has order at least3, making $b_f$ regular and contradicting its
minimal denominator. Thus branch $K$ is nonzero.
The linear $D_1$ cannot vanish at two distinct branch roots.

There is at most one branch critical fiber. If both other ordinary
fibers were singletons, the multiple-single support would meet
the branch support, excluded by its exact gcd. Otherwise the
unique-singleton CRT formulas extend with $y_{\rm branch}=0$,
$D_1(r_{\rm branch})=B_0(r_{\rm branch})=0$.
The explicit sheet algebra may become nonreduced there, but is
finite flat and its norm remains regular. The CRT coefficients
have poles only at the critical discriminant; their exact norm
denominator check confirms this. Therefore an actual gap zero
would make the uniform gap numerator zero. Coprimality with the
branch support contradicts this.

The same regular-CRT argument handles a simple selected-critical
fiber. No inference from $D_s(0)$ to $e=0$ at that fiber is needed:
the universal gap-only norm uses no selected equations. Multiple
singletons there are excluded by the G-collision/selected support
gcd; unique singleton is excluded by the gap numerator/selected
support gcd. This does not misuse a rational norm numerator at
repeated critical roots: those were independently excluded above.

These cases exhaust the source's rational critical root of
infinity pole3. Together with the prior fixed-line and small-root
source bounds, a remaining rational critical root can only have
infinity pole4. The critical cubic is not yet proved irreducible.

The original reviewed argument and its integration provenance are retained in
[the source experiment note](../../Research/experiments/oct02_m9_uniform/SOURCE_POLE_THREE_EXCLUSION.md).

