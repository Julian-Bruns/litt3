# Proof of actual degree-ten m9 critical irreducibility

Version1,2 October2026. The focused whole-argument
[independent pole-four audit](../../Research/audits/M9_SOURCE_POLE_FOUR_AUDIT_2026_10_02.md)
passed without numerical replay.
[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_critical_irreducibility.md).

The actual source, fixed curve and source equations are those of
[the source-critical theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_source_critical_fitting_reduction.md).
Its source-only small-root bounds leave poles three and four.
The separately audited
[pole-three theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_source_rational_critical_pole_three_exclusion.md)
excludes the former for every fourth moment. It remains to exclude
pole four. No numerator cancellation is assumed.

For a pole-four rational critical root, the finite numerators are
$N_c=Ky^2+C_4+\gamma y$ and $N_b=-2Ky^2+B_4+\beta_b y$,
where $\gamma$ is affine linear with NONZERO slope and $\beta_b$ is
constant. The source no-singleton theorem leaves an ordinary maximal
$B$-singleton. If it is unique, mark it $(r_0,y_0)$; the other two
fibers have maximal $C$-singleton sheets $(r_i,y_i)$. Then
$\beta_b=-2K_0y_0$ and
$B_0(r_0)=-2K_0y_0^2$, $B_0(r_i)=2K_i y_i^2-\beta_b y_i$.
The gap17 norm of this quadratic $B_0$ is EXACTLY the negative of the
pole-three gap norm. Its radical has six linear and four degree-twelve
factors over the selected-root field $\mathbf F_{5^8}$. The previous
boundary coprimalities are unchanged. Two or more $B$-singletons lie on
the degree-nine critical-value collision support; all six representatives
have NONZERO gap17, so that entire stratum is already excluded.
[Multiple-singleton script](../../scripts/oct02_m9_uniform_pole4_multiple_single_gap.sage).
[All six gap values](../../../litt3-computation-data/oct02_m9_uniform/pole4_multiple_single_gap.json).

For the unique-singleton support, direct source-e9 systems retain BOTH
gap17 and gap14, integrality of $e_f$ on every maximal $c_f$ pole, and
the short $e=0$ conditions outside every geometric short-$c$ zero stratum.
The two shifts of $C_4$ are unrestricted; in particular $\nu_c=0$ is
retained. Gap14 determines a $b$ shift on the moving line and does NOT
force $B_0$ into the fixed line spanned by $q$.

## Exact coverage of the four omissions

The raw $P,Z,q,q_3,A$ have coefficients in $\mathbf F_{25}$, and
Frobenius25 cycles the four roots of $A$. Calculations use the common
normalization $P=P_{raw}/p_*$, $Z=Z_{raw}/p_*$ with
$p_*=P_{raw}(s_*)$. Put $d^3=p_*^{25}/p_*$. The arithmetic action in
this fixed chart is
$x\mapsto x^{25}$, $y\mapsto d\,y^{25}$.
It transforms $a=Z/y$ by $a\mapsto d^2a^{25}$ and fixes the form of
the leading pencil, with $\lambda\mapsto\lambda^{25}$.
Consequently the short and finite $c,b$ scale by $d^2$, $e$ by $d^4$,
$B_4,C_4$ by $d^2$, $\beta_b,\gamma$ by $d$, and the two components
of $\eta_e=E_4+yE_1$ by $d^4,d^3$ respectively. Every pole, zero,
gap and selected-contact equation is preserved. The choice of cube root
$d$ changes this action only by the simultaneous cubic rotation.

For ANY marked support root and omission, a power of this action moves
the omission to $s_*$. The new support root belongs to one of the ten
irreducible factors over $\mathbf F_{5^8}$; a subsequent Frobenius
$5^8$ power fixes the omission and moves that root to the chosen factor
representative. A simultaneous cubic rotation fixes the distinguished
sheet to the chosen $y_0$. All nine relative sheets of the other critical
fibers are tested, and all three selected sheets in every fiber are
retained in the geometric zero-stratum test. Thus one representative of
each of the ten factors at ONE omission covers all four omissions and
all critical and selected marking choices. No independent rotation of a
selected fiber is assumed.

The field $\mathbf F_{5^{576}}$ suffices for a degree-twelve factor:
the marked root has degree96, the complementary quadratic degree192,
and the critical cubic sheet adjunction degree576. Linear factors use
$\mathbf F_{5^{48}}$. These are explicit fixed-curve parameter fields,
not Galois closures of either original source map.

The first degree-twelve prototype (factor6, omission0) completed in
15.11 seconds, with one gap-zero relative sheet pair and every source-e9
stratum inconsistent. Nine NEW factor representatives completed in
60.99 seconds aggregate wall time. Every factor has exactly one relative
critical pair satisfying gap17, with nonzero $\gamma$ slope, and EVERY
geometric source-e9 stratum is inconsistent. The completed prototype
was preserved and was not repeated. Six linear-factor calculations took
0.34--0.43 seconds each; the three new degree-twelve calculations took
13.41--14.80 seconds each.
On every completed support representative the marked fiber has TWO
maximal $c_f$ sheets and the selected affine-line arrangement has exactly
37 strata (empty, nine lines and27 cross-fiber pairs). This is an output
of the full test, not an assumption: one-sheet $c_f$ and larger or
coincident selected strata were allowed by the construction. All370
coefficient matrices have rank9 and all370 augmented matrices rank10.

[Script](../../scripts/oct02_m9_uniform_pole4_gap_source_prototype.sage).
[Prototype](../../../litt3-computation-data/oct02_m9_uniform/pole4_gap_source_factor06_omit00.json).
[All ten representatives](../../../litt3-computation-data/oct02_m9_uniform/pole4_gap_source_batch.json).

## What the source-e9 test imposes

Let $\gamma$ interpolate $K_i y_i$ at the two complementary roots.
Let $C_0(r_0)=-K_0y_0^2-\gamma(r_0)y_0$ and
$C_0(r_i)=K_i y_i^2$. Write
$B_4=B_0+\delta(\mu_b+\nu_bx)$ and
$C_4=C_0+\delta(\mu_c+\nu_cx)$. These are every possible degree-four
numerator with the required values. At the marked $B$-singleton fiber,
$c_f$ can have one OR two maximal pole sheets; the test evaluates
$N_c$ on all three sheets and retains its actual nonzero supports.
At the other two fibers its singleton sheets are $y_1,y_2$.

The unknowns of the affine source system are the seven coefficients
of $\eta_e\in L(13O)$ and $\mu_b,\nu_b$. Its fixed part is
$N_{e,0}=-\Pi_1(B_0+\beta_b y-2Ky^2)-\Pi_2(\delta)$,
and the two shift columns are $-\Pi_1(\delta),-\Pi_1(x\delta)$.
The rows are the source coefficient gaps17 and14, $N_e=0$ at every
maximal $c_f$ pole, and the SHORT $e=0$ at every selected point where
$c\ne0$. The latter row is precisely
$N_e+aN_b+a^2\delta=0$. All critical and selected fibers here are
simple and ordinary, and $\delta$ is a unit at each selected fiber.

For completeness the excluded selected points are determined
GEOMETRICALLY, rather than by enumerating values of $\mu_c,\nu_c$.
For each of the nine selected points the equation $c=0$ is the line
$\mu_c+s\nu_c=-c_0(s,y)$ in the affine parameter plane. Every zero
itinerary occurs in one of: the open complement; a distinct line
(including all coincident copies); or a nonparallel pair intersection
(including every additional concurrent line). The script constructs
these finitely many sets directly and tests the equations outside each.
It retains intersections with $\nu_c=0$, all coincidences and all
concurrences. The coefficient ranks and augmented ranks recorded for
every stratum differ, excluding solutions over the ALGEBRAIC CLOSURE.
The finite fields are fields of definition for the matrix entries,
not a restriction on the source coefficients.

## Repeated ordinary critical fibers

The fixed repeated-root equation is
$H=q_3'q-q_3q'=0$. Its four distinct roots give
$\delta=(x-r)^2(x-s)$ with $r\ne s$, and every such $\delta$ is
coprime to $P,A,K$. There is no triple critical root. At these parameters
$K(r)^3P(r)\ne K(s)^3P(s)$. These exact facts are retained in the
existing Hermite certificates and asserted in the new gap calculation.

First, if $b_f$ is regular on BOTH complementary sheets at the repeated
fiber, its quadratic numerator has two full double zeros and therefore
$\beta_b^3\equiv-8K^3P\pmod{(x-r)^2}$. Since $\beta_b$ is constant,
the partial derivative $(K^3P)'(r)$ would vanish. The existing degree4/
degree13 Bezout certificate excludes this. This use requires full
regularity on both complements; a maximal singleton with a lower pole
on the third sheet is NOT discarded by this argument.

The maximal $b_f$ support is consequently classified as follows.
If the repeated fiber has two maximal sheets, the ordinary singleton
guaranteed by the source theorem is at $s$. If the repeated fiber has
one maximal sheet, then $s$ cannot also have one, since the common
constant $\beta_b$ would force the two unequal $K^3P$ values to agree.
At $r$ the complementary maximal $c_f$ support must be a singleton;
two maximal $c_f$ sheets would give precisely the forbidden two-sheet
$b_f$ regularity. This leaves exactly the following two profiles.

Put $y'=P'(r)y/(3P(r))$, with all derivatives taken on the ordinary
sheet, and use the unique quadratic Hermite polynomial with prescribed
value and derivative at $r$ and value at $s$.

* In profile A, $c_f$ has maximal singleton $c_r$ at $r$, and $b_f$
  has singleton $b_s$ at $s$. Set $\beta_b=-2K_s b_s$. Full regularity
  of $c_f$ on the two repeated complementary sheets gives
  $\gamma(r)=K_r c_r$ and
  $\gamma'=K'_r c_r+K_r c'_r$.
  The necessary $B_0$ data are
  $B_0(r)=2K_r c_r^2-\beta_b c_r$,
  $B_0'(r)=2K'_r c_r^2+4K_r c_r c'_r-\beta_b c'_r$, and
  $B_0(s)=-2K_s b_s^2$.
* In profile C, the repeated maximal $c_f,b_f$ singleton sheets
  $c_r,b_r$ are distinct, and the simple fiber has maximal $c_f$
  singleton $c_s$. Set $\beta_b=-2K_r b_r$ and let $\gamma$ interpolate
  $K_r c_r,K_s c_s$. The necessary $B_0$ data are
  $B_0(r)=-2K_r b_r^2$,
  $B_0'(r)=2K'_r c_r^2+4K_r c_r c'_r-\beta_b c'_r$, and
  $B_0(s)=2K_s c_s^2-\beta_b c_s$.

The derivative in each case is forced only by regularity of $b_f$ on
the maximal $c_f$ sheet. The third repeated sheet in profile C can
retain lower poles of either factor. NO condition on those lower poles
is used for the ensuing gap17 contradiction. Every possible $B_4$
differs from this Hermite $B_0$ by $\delta(\mu_b+\nu_bx)$; both shift
contributions to gap17 vanish identically.

Fix $c_r$ by simultaneous cubic rotation. Each of four parameters has
three profile-A relative sheets and six profile-C relative sheets.
The NEW36 gap values are ALL nonzero. This calculation took1.408 seconds
over the existing $\mathbf F_{5^{72}}$ field, and excludes the entire
repeated boundary without source-e matrices, selected contact equations,
or restrictions on $\gamma$ slope. It includes all coefficient drops.

[Hermite gap script](../../scripts/oct02_m9_uniform_pole4_repeated_source.sage).
[All36 gap values](../../../litt3-computation-data/oct02_m9_uniform/pole4_repeated_gap.json).
[Scoped two-sheet jet Bezout](../../../litt3-computation-data/oct02_m9_uniform/repeated_c_single_jet_obstruction.json).
The same Bezout applies to $\beta_b^3=-8K^3P$, because the nonzero
constant $-8$ does not change its derivative-zero support.

## Simple branch, selected-critical and K-zero boundaries

At a critical branch point with multiplicity $\ell$, minimal polynomial
$x$-clearing for both factors gives $h_c,h_b\ge3\ell-2$.
The Gauss bound $h_c+h_b\le3\ell$ forces $\ell=1$.
At a simple branch, avoiding an impermissible pole3 forces
$C_0(r)=B_0(r)=0$. With the ordinary $B$-singleton elsewhere,
$\beta_b\ne0$, so $b_f$ has pole2. Hence $c_f$ has pole at most1,
forcing $\gamma(r)=0$; the CRT formulas above extend by $y_i=0$.

For simple distinct critical roots, the CRT and gap formulas have
denominators only on $q(r_0)=0$ or the critical discriminant. The cubic
sheet algebra $y_i^3=P(r_i)$ remains FINITE FLAT at a branch point.
If any marked sheet makes gap17 zero, its finite-flat multiplication
norm is zero. Thus the universal norm numerator is a necessary equation
also on the simple branch boundary. Its exact coprimality with the
branch support excludes this case. Its coprimality with the selected-
critical support likewise excludes selected-critical fibers without
invoking $e=0$ there. Multiple ordinary singletons are confined to the
critical-value collision support, itself coprime to both boundaries,
and their six gap values were already nonzero.

At a simple ordinary $K$-zero, both finite numerators are at most linear
in $y$. Minimal full denominator clearing forces each to be nonzero on
at least one sheet; a nonzero linear function has maximal pole support
on at least TWO sheets. The two supports intersect, contradicting the
Gauss inequality. At a branch $K$-zero the affine polynomial part has
order at least3 and the $Ky^2$ term at least5. Minimal clearing for
$b_f$ requires $\beta_b\ne0$ (pole2); the complementary Gauss bound
forces $\gamma(r)=0$, so $c_f$ is regular, contradicting its full
minimal clearing. Repeated $K$-zeros are absent on the explicit four
repeated parameters.

All denominator and numerator support facts used here are in the
[exact prior boundary certificate](../../../litt3-computation-data/oct02_m9_uniform/uniform_gap_support_boundaries.json).
The pole-four norm coefficient arrays are the exact NEGATIVES of the
pole-three numerator arrays, with identical denominator arrays; thus
these support coprimalities apply unchanged.

## Coverage and remaining problem

The fixed $\lambda=0$ line was already excluded for every rational root
by the source-critical theorem. Its moving no-ordinary-$B$-singleton
branch was also excluded there, including all local boundaries. A
remaining pole-four root therefore has an ordinary $B$-singleton.
Simple unique singleton fibers are excluded by all ten source-e9
factor representatives; multiple simple singleton fibers by all six
collision gaps; repeated roots by the scoped jet argument and all36
Hermite gaps; branch, selected-critical and $K$-zero boundaries by the
local and finite-flat arguments just given. No rational pole-four root
remains.

Together with the independently audited source-only small-root and
pole-three exclusions, this proves irreducibility of the actual m9
critical CUBIC for every fourth moment, with no numerator cancellation
assumption. An irreducible cubic in characteristic5 is separable.
The existence of an actual source with this irreducible critical cubic,
the entire m9 sector, degree ten and the unmarked common-cover problem
remain unresolved.

## Full denominator and nonzero critical quadratic

Since $D$ is irreducible, a nonconstant $\gcd(D,U)$ would be $D$.
Then $U/D$ is a polynomial of degree at most two, representing the
ACTUAL annihilator $u$ on its original primitive source. The
[low-polynomial exclusion](../../Theorems/cartier_and_spin/admissible_linear_annihilator_exclusion.md)
contradicts this. Thus $\gcd(D,U)=1$ for EVERY $\rho$, strengthening
the previously known zero-fourth-moment coprimality.

The exact
[critical incidence](../../Theorems/cartier_and_spin/admissible_critical_quadratic_incidence.md)
gives $U^2-FQ=DV_2$. The actual source is separable and $F'=\phi D$,
so $\gcd(F,D)=1$. In the critical cubic field both $U$ and $F$ are
nonzero and therefore $Q=U^2/F\ne0$. Since $\deg Q\le2<\deg D$,
the polynomial $Q$ itself is nonzero. These are necessary conditions
on an existing source, not a realization or an exclusion of that source.

Proof provenance: the reviewed source-only pole-four proof is retained
at [the experiment note](../../Research/experiments/oct02_m9_uniform/POLE_FOUR_GAP_SOURCE_SUPPORT.md).
All certificates remain in the sibling computation-data store.

