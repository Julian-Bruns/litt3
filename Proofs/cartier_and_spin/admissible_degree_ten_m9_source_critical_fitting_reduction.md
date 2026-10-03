# Proof of the source-only m9 critical Fitting reduction

Version1,2 October2026. The focused whole-argument
[independent audit](../../Research/audits/M9_SOURCE_ONLY_FINITE_REDUCTION_AUDIT_2026_10_02.md)
passed without numerical replay.
[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_source_critical_fitting_reduction.md).

The actual source, infinity and root-coefficient inputs are those of
[the m9 rational-root theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_zero_moment_denominator_exclusion.md),
[the profile theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_nonzero_profiles.md),
and [critical parity](../../Theorems/cartier_and_spin/admissible_degree_ten_critical_parity_section.md).
Only their source-only restrictions are used; all arguments that impose
rho=0 or U(c)=0 are separated and are not inputs here.
The fixed-line leading cubic is squarefree and coprime to P,A,K.
The actual finite critical polynomial has affine coefficients.
All matrices below concern necessary coefficients on the ORIGINAL source.

Use the fixed curve, $P,A,Z,q_3$, and finite/short frames of the canonical
[m9 theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_zero_moment_denominator_exclusion.md).
Normalize the nonzero scalar leading coefficient away and put $\delta=q_3$.
Write $D_s=\delta(T-c)(T^2+bT+e)$ and $a=Z/y$. The sharper source
bounds $\delta_{1,s}=16$ and $\delta_{0,s}\le17$ imply, for $c$ of
pole three, $b$ of exact pole four and $e$ of pole at most five. This
follows directly from $\delta_0=-\delta ce$ and
$\delta_1=\delta(e-bc)$, independently of numerator cancellation.
The finite coefficients satisfy
\[
c_f=c+a,\qquad b_f=b-2a,\qquad e_f=e-a b_f-a^2.
\]
Normality makes $N_c=\delta c_f$, $N_b=\delta b_f$ and
$N_e=\delta e_f$ affine. The first two have normal forms
\[
N_c=K y^2+C_4+\gamma y,\qquad
N_b=-2K y^2+B_4+D_1y,
\]
where $Z\delta=PK+R$, $C_4,B_4$ have degree at most four and
$D_1$ has degree at most one. The usual gap-clearing argument, which
uses only $c$ and $b$ infinity bounds, says that both need all three
$q_3$ factors to clear their finite poles. Gauss content of $D_f$
forces their maximal pole supports to be disjoint. The fixed $K$ is
nonzero at all three roots, so each support has one or two sheets.
The three values $K(r)^3P(r)$ are distinct, and no three cubic-root
choices for the one-sheet $b$ support interpolate by a degree-one
$D_1$. Consequently $c$ has one-sheet support at exactly one root
$r_0$, and two-sheet support at the other two roots $r_1,r_2$.
These classification checks are unchanged source-only inputs of the
[fixed-line note](../../Research/experiments/oct02_m9_uniform/Q3_CANCELED_POLE_THREE_EXCLUSION.md); its quotient
and annihilator arguments are not used here.

Fix the $c$ pole sheet $y_c$ at $r_0$ and the $b$ pole sheets $y_i$
at $r_i$, $i=1,2$. Then $\gamma=K(r_0)y_c$ and the values
of $C_4$ are fixed at all three roots. Thus
$C_4=C_0+\delta(\mu_c+\nu_cx)$ with $\nu_c\ne0$.
Every possible selected zero set is an exact stratum of the nine
affine lines $\mu_c+\nu_c x(P)=-c_{\rm base}(P)$. There are
37 strata: empty, nine singletons and 27 two-element sets on distinct
fibers; no triple or same-fiber pair occurs. This covers geometric
parameters rather than sampling them over a finite field.

The $b$ polynomial is determined at $r_1,r_2$ by
$D_1(r_i)=-2K(r_i)y_i$. At $r_0$ we impose ONLY its necessary
vanishing at the $c$ pole sheet, namely
$B_4(r_0)=2K(r_0)y_c^2-D_1(r_0)y_c$. This retains both possible
one-sheet and two-sheet supports of $b$ on that distinguished fiber.
At $r_i$, $B_4(r_i)=-2K(r_i)y_i^2$. Therefore
\[
B_4=B_0+\delta(\mu_b+\nu_bx).
\]

Let $\Pi_j$ be the affine polynomial part of multiplication by $a^j$,
using $y^3=P$. Since the short $\delta e$ has pole at most14,
every necessary $N_e$ has the form
\[
N_e=\eta_e-\Pi_1(N_b)-\Pi_2(\delta),\qquad \eta_e\in L_{14}.
\]
The seven-dimensional space $L_{14}$ is
$\langle1,x,x^2,x^3,x^4,y,xy\rangle$. The non-affine remainder
of $aN_b+a^2\delta$ has pole at most17. Its only term above14
is the degree-nine coefficient of $\operatorname{rem}(ZB_4,P)$,
giving the necessary linear equation
\[
\operatorname{rem}(ZB_4,P)_9=0.
\]
Indeed $a(-2Ky^2)$ and $aD_1y$ are already affine; the
$aB_4$ remainder is $y^2\operatorname{rem}(ZB_4,P)/P$,
with possible poles17,14,11,..., while $a^2\delta$ has
remainder pole at most seven. An affine summand cannot cancel
the gap17. No claim of sufficiency for source existence is needed.

There are exactly nine unknowns: seven coefficients of $\eta_e$
and $\mu_b,\nu_b$. At each of the five finite poles of $c_f$,
Gauss content forces $e_f$ regular, hence $N_e=0$. At every
selected endpoint where $c\ne0$, the actual source identity
$D_s(0)=0$ forces $e=0$. This identity holds through zeros of
$v$ and repeated specialized nonselected roots: the actual selected
root has $F'(W_i)$ order at least four and $\phi_i$ order three,
so $D(W_i)$ has positive order. See
[selected-contact proof](../../Proofs/cartier_and_spin/admissible_selected_quadratic_contact.md).
The endpoint row is exactly
\[
N_e(P)+a(P)N_b(P)+a(P)^2\delta(P)=0.
\]
All these are affine-linear in the nine unknowns, with fixed right
hand sides. Each actual selected-zero stratum omits only its own
$e=0$ rows. No trace or quotient coefficient is imposed.

The new source
[source-e probe](../../scripts/oct02_m9_uniform_source_e_probe.sage)
checks the augmented systems over $\mathbf F_{5^{24}}$, recording
the field modulus and coefficients. Simultaneous cubic rotation
covers all choices of $y_c$; Frobenius25 interchanges the two
quadratic $q_3$ roots. Two distinguished fibers, nine relative sheet
choices, four omissions and all37 geometric zero strata give72
records and2664 systems. EVERY coefficient matrix has rank nine
and EVERY augmented matrix rank ten. Thus every necessary system
is inconsistent over $k$, excluding the fixed-line rational root.
The new prototype took0.324s; the complete72-record batch took6.364s
on one core in Sage10.9. The first prototype also occurs once in
the complete batch; no old quotient or source certificate was replayed.
Evidence: [complete ranks](../../../litt3-computation-data/oct02_m9_uniform/source_e_q3_complete.json).
The compact selected-source minors below now give explicit nonzero witnesses for the fixed-line pole-three and pole-four branches; the original augmented systems and their provenance are preserved.

## Every small rational critical root is impossible

Any rational critical root regular at infinity or with pole at most one
forces $\delta_3\in k^*q_3$. The source-only sharper quadratic
coefficient gives $b=c+\delta_2/\delta$ of pole at most four.
The same minimum-clearing and fixed-$q_3$ classification therefore
applies: $c$ has a singleton pole fiber, with
$\gamma=K(r_0)y_c\ne0$. Its finite numerator has $C_4$ of degree
at most three, so $C_4=C_0+\delta\mu_c$. The non-affine short
remainder has pole at most eight before division by $\delta$;
the nonzero $\gamma y$ gives exact pole one for $c$. Thus a root
regular at infinity is already impossible. Since $bc$ has pole
at most five whereas $\delta_1$ has pole16, the equation
$\delta_1=\delta(e-bc)$ forces $e$ of exact pole seven.

Consequently $\eta_e\in L_{16}$, of dimension nine, and the
two free $b$ shifts give an eleven-variable source-e system.
The same gap17, five ordinary pole-value and complementary
selected $e=0$ rows apply. Its selected $c$ zeros are EXACTLY
the fibers of the nine values $-c_{\rm base}(P)$ under the
one-parameter $\mu_c$. Coincident values are grouped rather
than assuming generic distinctness. In all72 representatives
the nine values are distinct, giving ten strata (empty and nine
singletons); every corresponding system is inconsistent. The
[same new source](../../scripts/oct02_m9_uniform_source_e_probe.sage)
uses the separate option $\texttt{--small-root}$ with coefficient
bound16, and preserves the pole-three evidence unchanged.
The prototype took0.313s; the other71 representatives took4.657s,
reusing the saved prototype. Evidence:
[complete small-root systems](../../../litt3-computation-data/oct02_m9_uniform/source_e_q3_small_complete.json).
This excludes EVERY rational critical root of pole at most one
in the full moving pencil as well, since its leading line is
necessarily $q_3$. No condition on $U$ or $\rho$ is needed.

## Fixed-leading-line pole-four roots

Let $c$ have pole four and $\delta=q_3$. Then
$e=-\delta_0/(\delta c)$ has pole at most four and
$\delta_1=\delta(e-bc)$ forces $b$ of exact pole three.
Put $f=-b/2$, so $f_f=-b_f/2=f+a$ has numerator
$\delta f_f=Ky^2-B_4/2-D_1y/2$. It has the same constant
$y$ coefficient normal form as the preceding pole-three root.
The complementary $c$ has finite numerator
$Ky^2+C_4+\gamma_c(x)y$, where $\gamma_c$ is affine-linear
with nonzero slope. The separate clearing and Gauss arguments
still apply to the pair $f_f,c_f$.

The distinct fixed values $K(r)^3P(r)$ make $f_f$ singleton
at at most one critical fiber. If it were double at all three,
$c_f$ would be singleton at all three, and the affine-linear
values $\gamma_c(r)=K(r)y_c$ would contradict the already
checked three-cubic-root interpolation obstruction. Thus $f_f$
is singleton at exactly one fiber $r_0$, at a sheet $y_b$.
At the other two roots $c_f$ is singleton. Those two values
fix $\gamma_c(x)$, which automatically has nonzero slope because
their cubes are distinct. The $C_4(r_0)$ value imposes ONLY
vanishing at the $b$ pole sheet. Computing its actual residue
support retains either one or two $c$ poles there.
Both $C_4=C_0+\delta(\mu_c+\nu_cx)$ and
$B_4=B_0+\delta(\mu_b+\nu_bx)$ remain geometrically free.
No condition on $\nu_c$ is imposed: exact pole four comes from
the slope of $\gamma_c$. Allowing $\nu_b=0$ is a safe relaxation.

Now $\eta_e\in L_{13}$ has seven coefficients. The bound
$\delta e\le13$ requires BOTH remainder gaps17 and14 to vanish:
\[
\operatorname{rem}(ZB_4,P)_9=
\operatorname{rem}(ZB_4,P)_8=0.
\]
The remaining $a^2\delta$ remainder has pole at most seven.
All finite $c_f$ poles force $N_e=0$, and every selected point
outside the actual $c$ zero set forces the same $e=0$ row as
above. The [new pole-four source](../../scripts/oct02_m9_uniform_source_e_pole4.sage)
checks ALL512 subsets for feasibility in the two geometric
variables $\mu_c,\nu_c$ before testing its nine-variable
affine source-e system. Two distinguished fibers, nine relative
sheet choices and four omissions give72 representatives. Every
feasible zero set has size at most two and every system is
inconsistent. Prototype0.367s; the other71 representatives took
9.085s, reusing the saved prototype. Evidence:
[complete pole-four systems](../../../litt3-computation-data/oct02_m9_uniform/source_e_q3_pole4_complete.json).

The source-only root bounds already exclude poles above four and
pole two. The preceding small, three and four arguments exclude
all remaining rational roots on $\delta_3\in k^*q_3$. A reducible
cubic over $k(X)$ has a rational root, so its critical cubic is
IRREDUCIBLE. This conclusion holds for every fourth moment and
does not depend on numerator cancellation or a presumed source
realization from an abstract parameter point.

## Moving ordinary no-singleton extension under investigation

On a simple unramified moving $\delta=q_3+\lambda q$, with
$K$ nonzero at every root, suppose $c$ has two pole sheets at
each fiber. Then $b$ has one sheet, $y_b=-D_1/(2K)$, and
$\delta\mid D_1^3+8K^3P$. This source-only necessary congruence
has the already recorded primitive parameter support of degree twelve.
Its elimination coefficient-drop exclusions are purely algebraic.
However the cancellation proof's branch and selected-contact boundary
exclusions are not inherited. They remain separate here.
For an ordinary support representative, $B_0=-D_1^2/(2K)$ modulo
$\delta$, and $C_0=-D_1^2/(4K)+\gamma D_1/(2K)$ modulo
$\delta$. Selected $c$ zeros are linear equations in
$\gamma,\mu_c,\nu_c$, retaining $\nu_c\ne0$. Source-e content
at the six $c$ poles can be imposed in the cubic fiber algebra
without splitting critical roots. All selected-zero subsets and the
corresponding affine consistency systems must be retained.

The new [ordinary source-e test](../../scripts/oct02_m9_uniform_source_e_no_single.sage)
has now completed all eight parameter-factor/omission representatives.
It uses the already fixed field and normalization $Y=y/z$ with
$z^3=P(s_0)$, so $P$ is replaced by $P/P(s_0)$ and
$a$ by $(Z/P(s_0))/Y$. Normalize $c,b$ by $z^2$ and $e$
by $z^4$. The displayed $K$ is unchanged, and $D_1$ is the
previous normalized coefficient of $Y$. Arbitrary constants and
coefficients in the small Riemann--Roch spaces remain arbitrary
over $k$ under this nonzero scaling.

In the algebra $k[x,Y]/(\delta,Y^3-P)$, regularity of $e_f$
on the two $c$ pole sheets is equivalent to the six linear rows
\[
K(N_e)_1+\tfrac12D_1(N_e)_2=0\pmod\delta,
\qquad K^2(N_e)_0-\tfrac14D_1^2(N_e)_2=0\pmod\delta.
\]
Here subscripts denote $Y$ coefficients, and $K$ is a unit modulo
$\delta$. These relations say $N_e$ is supported on the one
remaining sheet $Y_b=-D_1/(2K)$ at every root. The gap17 row
and endpoint rows are exactly those above, giving the same nine
unknowns. Independently, a chosen subset $J$ of the nine selected
endpoints is compatible with $c=0$ only if its equations in the
three variables $\gamma,\mu_c,\nu_c$ are consistent and admit
$\nu_c\ne0$. This is decided by ordinary augmented rank and
the direction of the affine solution space; no finite-field
enumeration of these variables occurs. For each such $J$, impose
$e=0$ at its complement. Requiring only the zeros in $J$, rather
than excluding additional zeros, is a safe relaxation. An actual
zero set necessarily appears among these subsets.

ALL512 subsets are checked in each representative. Exactly127
are feasible, each of size at most three. For EVERY feasible
subset the source-e system is inconsistent. The first new
prototype took0.594s; the other seven new representatives took
3.166s in one sequential batch, with the prototype reused from
its saved record. Evidence:
[complete ordinary source-e ranks](../../../litt3-computation-data/oct02_m9_uniform/source_e_no_single_complete.json).

The primitive parameter support factors have degrees four and eight
over $\mathbf F_{25}$. Frobenius25 moves a parameter and the omitted
$A$ root jointly; one parameter root and all four omissions cover
the joint orbits for each factor. Diagonal cubic rotation covers
the three cube-root slopes of $D_1$. These are exactly the same
algebraic parameter/symmetry inputs as the cancellation proof, but
no cancellation-derived exclusion of zero strata is used. All512
subsets replace those exclusions here. Thus this proves the entire
ordinary simple no-$c$-singleton pole-three source branch is empty,
independently of $U$ and $\rho$.

Repeated unramified roots satisfy the same FULL-jet cube congruence:
the analytic quadratic $b$ numerator vanishes modulo $(x-r)^\ell$
on both maximal $c$ pole sheets, giving
$D_1=-2K y_b\pmod{(x-r)^\ell}$ and hence the cube congruence
with full multiplicity. The primitive support is coprime to the
discriminant of $\delta$, so this extends the no-singleton exclusion
to that boundary. At a branch point the clearing and Gauss bounds
force multiplicity one and the pole pairs $(h_c,h_b)=(1,2)$ or
$(2,1)$, or $(1,1)$. For $\gamma\ne0$, the pair is $(2,1)$ and $D_1(r)=0$,
so the same cube congruence holds and its support is coprime to
$\operatorname{Norm}_\delta P$. The remaining source-only boundary
was $\gamma=0$ at a simple branch root, with $h_c=1$ and $h_b\le2$.
The cancellation proof's selected-zero argument was not inherited.
Instead, a new source-e probe closes this boundary directly.

At a branch point use $y$ as uniformizer, so $\operatorname{ord}\delta=3$.
The minimum clearing and Gauss bounds force $C_4(r)=B_4(r)=0$,
$K(r)\ne0$ and $h_c=1$. The coefficient $D_1(r)$ can initially
vanish or not; both are retained. Gauss permits $e_f$ a pole of
order two, so the ONLY necessary row imposed at that point is
$N_e(r,0)=0$. Requiring $e_f$ regular would be incorrect here.
At each remaining ordinary fiber, $\gamma=0$ and $K\ne0$ make
the $c$ numerator vanish on at most one cubic sheet. It cannot
have pole on all three sheets because $b$ needs a pole there.
Thus $c$ has exactly two pole sheets, $b$ exactly one, and the
two values of $D_1$ fix its affine-linear polynomial. Its branch
value is not restricted further. Interpolate $B_0,C_0$ by their
zero values at the branch root and their usual two ordinary
values, then retain both polynomial shifts of $B_4$ and $C_4$.

The [new branch probe](../../scripts/oct02_m9_uniform_source_e_branch.sage)
uses ALL ten roots of $P$ to obtain
$\lambda=-q_3(r)/q(r)$. The fixed $P$ factors as $1+1+4+4$
over $\mathbf F_{25}$, and all its roots lie in the recorded
normalization field. Every resulting $\delta$ is checked squarefree,
with $\gcd(\delta,P)$ of degree one and coprime to $A$ and $K$.
Thus all coincident, repeated-other-root and selected-critical
boundaries in this finite branch support are explicitly absent;
no generic-open assumption hides them. A simultaneous cubic
rotation fixes $\gamma=0$ and covers the first ordinary $b$ sheet.
Three relative second-sheet choices and all four omissions give
120 representatives. The five necessary pole rows consist of four
ordinary $c$ poles and the branch value row, retaining the allowed
$e_f$ pole two.

For each representative ALL512 selected-zero subsets are decided
by the two-variable affine equations in $\mu_c,\nu_c$, with
$\nu_c\ne0$. Exactly37 are feasible, each of size at most two.
The gap17 row and complementary selected $e=0$ rows give an
inconsistent nine-variable source-e system for EVERY feasible
subset. The full new batch took26.954s on one core under a45s
hard alarm. Evidence:
[complete branch ranks](../../../litt3-computation-data/oct02_m9_uniform/source_e_gamma_zero_branch.json).
Neither $U$ nor $\rho$ enters any row. This closes the gamma-zero
branch boundary independently of numerator cancellation.

If $K$ vanished at an ordinary critical root, both nonzero
numerators would have degree at most one on that three-sheet
fiber and their required maximal pole supports would overlap.
For $\gamma=0$ the $c$ numerator is constant and is either
nonzero on all three sheets or gives no pole; either violates
the separate minimum clearing and Gauss conditions. At a branch
root with $K=0$ and $\gamma=0$, its vanishing constant term
would give $c_f$ no pole, again violating minimum clearing.
With $\gamma\ne0$, its pole two forces $b_f$ at most pole one;
the vanishing branch constants and $D_1(r)=0$ then give no $b_f$
pole when $K=0$. Thus the $K=0$ boundary is impossible directly.

The primitive cube support is coprime to both its critical
discriminant and branch norm, and the remaining branch support
has just been exhausted. Therefore the ENTIRE pole-three rational
critical-root branch with NO unramified one-sheet maximal $c$
support is excluded on an actual source, without any annihilator
cancellation or fourth-moment hypothesis. The moving one-sheet
branch remains undecided.

## Moving pole four with no ordinary b-singleton

For a rational root $c$ of pole four, the source coefficient bounds
give $b$ of exact pole three and $e\le4$. In the finite numerators
the coefficient $\gamma_c(x)$ of $y$ in $N_c$ is exact degree
one, and the coefficient $\beta$ of $y$ in $N_b$ is constant.
Suppose $b_f$ has no one-sheet maximal pole support on an
ordinary critical fiber. Gauss and the separate minimum clearing
force $b_f$ maximal on two sheets and $c_f$ maximal on the
remaining single sheet. Its two numerator zeros imply, with
full jets at repeated ordinary roots,
\[
\delta\mid\gamma_c^3-K^3P.
\]
This is the SAME algebraic cube parameter support after substituting
$D_1=-2\gamma_c$. The primitive degree-twelve factors and their
drop/discriminant/branch/selected/K Bezouts are source-only inputs.

On the simple ordinary support write
$Y_c=\gamma_c/K$ in the critical fiber algebra. Then
$C_0=\gamma_c^2/K\pmod\delta$, and
\[
B_4=B_{00}+\beta B_{01}+\delta(\mu_b+\nu_bx),\qquad
B_{00}=2\gamma_c^2/K,\quad B_{01}=-\gamma_c/K\pmod\delta.
\]
The seven $\eta_e\in L_{13}$ coefficients, two polynomial shifts
and arbitrary $\beta$ give TEN unknowns. Both gap17 and14 rows
are imposed. The three critical $c$ pole rows are represented by
\[
K^2(N_e)_0+K\gamma_c(N_e)_1+\gamma_c^2(N_e)_2=0\pmod\delta.
\]
All512 selected $c$ zero subsets are decided in the arbitrary
two-variable shifts of $C_4$; no slope constraint is imposed,
since $\gamma_c$ itself supplies pole four. The
[new ordinary source](../../scripts/oct02_m9_uniform_source_e_pole4_no_single.sage)
checks all eight factor/omission representatives and every feasible
subset, obtaining inconsistent systems throughout. Prototype0.419s;
seven remaining NEW records1.832s. Evidence:
[ordinary pole-four systems](../../../litt3-computation-data/oct02_m9_uniform/source_e_pole4_no_single_complete.json).

At a branch root the earlier clearing/Gauss inequality still forces
critical multiplicity one. If $\beta\ne0$, then $b_f$ has pole
two and $c_f$ must have pole one, forcing $\gamma_c(r)=0$.
The branch therefore also satisfies the cube congruence, which
is excluded by the branch norm Bezout of its primitive support.
The same conclusion applies if $\gamma_c(r)=0$ with $\beta=0$.
In the only remaining case $\beta=0$, $\gamma_c(r)\ne0$,
the pole pair is $(h_c,h_b)=(2,1)$ and Gauss permits $e_f$
a pole of order one. Hence the necessary branch conditions are
\[
(N_e)_0(r)=(N_e)_1(r)=0.
\]
These require order at least two of $N_e$ and do NOT require
$e_f$ regular. The new branch code also retains the possible
$\gamma_c(r)=0$ stratum by imposing only its constant row,
permitting $e_f$ a pole of order two.

For each of the ten branch parameters, the two ordinary $c$
singleton sheets fix the affine-linear $\gamma_c$. Interpolate
$C_0$ from its zero branch value and its two $K Y_c^2$ ordinary
values, and $B_0=2C_0$. Retain both free shifts in each polynomial.
The [new branch source](../../scripts/oct02_m9_uniform_source_e_pole4_branch.sage)
checks120 representatives, each all512 subsets, with all37 feasible
subsets of size at most two. EVERY nine-variable system is
inconsistent. No slope drops occur. The critical cubics are all
simple with a single branch root and coprime to $A,K$; all these
finite boundary checks are explicit. Executed one-core time25.584s
under a45s hard alarm. Evidence:
[complete pole-four branch systems](../../../litt3-computation-data/oct02_m9_uniform/source_e_pole4_branch.json).

The $K=0$ boundary is impossible directly: at an ordinary critical
root both necessary numerator supports would overlap, and at a
branch root either $c$ has no pole or its pole two forces $b$
regular. Both violate the separate minimum clearing conditions.
Thus the ENTIRE rational pole-four branch with no unramified
one-sheet maximal $b_f$ support is source-only excluded. The
remaining pole-three and pole-four rational roots lie in the
moving pencil and have an ordinary singleton in the pole-three
member of the pair $(c,-b/2)$.

## Compact selected-source matrix

Use the fixed curve $y^3=P$, $a=Z/y$, leading
$\delta=q_3+\lambda q$, and $Z\delta=PK+R$. Suppose a rational
critical root has pole three or four. Its complementary coefficients
satisfy $\delta b_f=-2Ky^2+B_4+D_1y$, and
$\delta e_f=\eta_e-\Pi_1(\delta b_f)-\Pi_2(\delta)$.
In both profiles $\eta_e=E_4(x)+yE_1(x)$, with
$\deg E_4\le4$, $\deg E_1\le1$. Write
\[
B_4=B_0+\delta(\mu_b+\nu_bx),\qquad
H_B=\operatorname{rem}(ZB_4,P)/P,\qquad
T_\delta=\operatorname{rem}(Z^2\delta,P)/P.
\]
The exact SHORT identity is
\[
\delta e=E_4+y(E_1+T_\delta)+y^2H_B.
\]
The non-affine remainders have PLUS signs: this follows by adding
$a\delta b_f+a^2\delta$ back to the finite coefficient.
The gap17 coefficient of $\operatorname{rem}(ZB_4,P)$ must vanish;
pole-four roots require gap14 to vanish as well.

Assume the selected $c$ zero set consists of at most two points on
distinct selected $x$ fibers. It is safe to enlarge it to a two-point
set $J=\{(s_1,z_1),(s_2,z_2)\}$ on distinct fibers: we then
omit extra $e=0$ rows, so an actual source remains feasible. Let
$s_0$ be the third selected root of $A$. At $s_0$ the quadratic
in $y$ vanishes on all three sheets, hence
$H_B(s_0)=0$, $E_1(s_0)=-T_\delta(s_0)$ and $E_4(s_0)=0$.
At $s_i$, $i=1,2$, it vanishes on the two sheets other than $z_i$,
hence
\[
E_1(s_i)=z_iH_B(s_i)-T_\delta(s_i),\qquad
E_4(s_i)=z_i^2H_B(s_i).
\]
The three $E_4$ values can always be interpolated by degree four.
The three $E_1$ values must interpolate by degree one. Put
$\ell_i=\prod_{j\ne i}(s_i-s_j)^{-1}$ and $z_0=0$.
The necessary compatibility is
\[
\sum_{i=0}^2\ell_i z_iH_B(s_i)=
\sum_{i=0}^2\ell_iT_\delta(s_i).
\]

Define $H_0=\operatorname{rem}(ZB_0,P)/P$,
$H_\mu=\operatorname{rem}(Z\delta,P)/P$ and
$H_\nu=\operatorname{rem}(Z\delta x,P)/P$.
For a pole-three root, the entire selected-source compatibility
and gap17 have the TWO-unknown, THREE-row augmented matrix
\[
\mathcal H_J=
\begin{pmatrix}
H_\mu(s_0)&H_\nu(s_0)&-H_0(s_0)\\
\sum\ell_i z_iH_\mu(s_i)&\sum\ell_i z_iH_\nu(s_i)&
\sum\ell_i(T_\delta(s_i)-z_iH_0(s_i))\\
[x^9]\operatorname{rem}(Z\delta,P)&
[x^9]\operatorname{rem}(Z\delta x,P)&
-[x^9]\operatorname{rem}(ZB_0,P)
\end{pmatrix}.
\]
An actual source requires $\det\mathcal H_J=0$. This conclusion
does not use the critical $e_f$ pole rows or $U$. For pole four,
append the analogous degree-eight remainder row; every three-by-three
minor of the resulting four-by-three matrix must vanish.

The [compact source](../../scripts/oct02_m9_uniform_source_e_compact_minors.sage)
verified all27 cross-fiber pairs in all72 fixed-line representatives
for EACH root pole three and four:3888 nonzero three-by-three minors.
For pole four the same degree-nine gap determinant is nonzero throughout;
its extra degree-eight row is unnecessary for this finite reduction.
The field coordinates and selected row indices are explicit in
[compact selected minors](../../../litt3-computation-data/oct02_m9_uniform/source_e_compact_selected_minors.json).
The initial combined run completed pole three in4.993s but hit a10s
hard alarm during pole four before its profile checkpoint. The repaired
source saves each case separately and skips all completed records.
Only missing pole-four compact minors were completed, in5.146s;
no original augmented rank or saved pole-three minor was replayed.

## Symbolic sheet-cover coefficients

On the degree81 ordinary cover, choose distinguished $r_0,y_0$
and unordered $r_1,y_1$, $r_2,y_2$, with
$\delta(r_i)=0$, $y_i^3=P(r_i)$.
For a pole-three root, its constant $y$ coefficient is
$\gamma=K(r_0)y_0$. Let $D_1$ be the affine-linear interpolant
of $-2K(r_i)y_i$ for $i=1,2$. The quadratic polynomial $B_0$
is the interpolant of
\[
B_0(r_0)=2K(r_0)y_0^2-D_1(r_0)y_0,\qquad
B_0(r_i)=-2K(r_i)y_i^2\ (i=1,2).
\]
For a pole-four root use the distinguished sheet of $f=-b/2$
instead: $D_1=-2K(r_0)y_0$ is constant, and $B_0$ is $-2$
times the interpolant with values
$K(r_0)y_0^2$ and
$-K(r_0)y_0y_i-K(r_i)y_i^2$ at the other two roots.
These formulas give the small matrix exactly over the sheet cover,
with no free source parameter remaining in its entries. All remaining
unknown source coefficients were eliminated or relaxed legitimately.

The only finite denominators are root differences. Multiplying the
last column by the base discriminant
$\mathfrak d(\lambda)=\prod_{i<j}(r_i-r_j)^2$ clears them.
The Vandermonde itself changes sign under the complementary-root
swap, so it is inappropriate as an element of the unordered degree81
cover; it can instead be used on the ordered degree162 cover.


## Finite ordinary sheet cover

Delete the finite parameter support where $\delta$ has a repeated
root, meets $P$ or $A$, or meets $K=\operatorname{quo}(Z\delta,P)$.
These supports are finite because none occurs at $\lambda=0$.
Delete also the support where two of the three values
$G(r)=K(r)^3P(r)$ coincide. It is finite: the discriminant of
$\operatorname{Res}_x(\delta,t-K^3P)$ is nonzero at zero.
The polynomial is monic of degree three in $t$, so no leading
coefficient boundary is suppressed. Denote the remaining open
parameter line by $T$.

Over $T$, the ordered cover of three critical roots $r_i$ and
their cubic sheets $y_i^3=P(r_i)$ is finite etale of degree
$6\cdot27=162$. Its quotient interchanging positions one and two
(the complementary fibers) is finite etale of degree81. Call it
$B\to T$: position zero is distinguished; the other two are
unordered. Let $\overline B$ be the normalization of the parameter
line in the total finite etale algebra. It is a finite cover of
degree81, possibly disconnected; every component maps surjectively
and every component meets the ordinary fiber $\lambda=0$.
No connectedness or simultaneous source Galois closure is assumed.
This is only an auxiliary parameter cover of the fixed curve's
three-sheet fibers, not a replacement for the original source.

In a pole-three root case, the already source-only excluded
no-singleton branch forces a singleton pole at some ordinary
critical fiber. Since the three $G$ values are distinct, there is
at most one. Its $c$ sheet and the two complementary $b$ sheets
give a point of $B$. The source normal forms reconstruct
$\gamma,D_1,C_0,B_0$ as rational functions there. The remaining
$c$ freedom is $C_4=C_0+\delta(\mu_c+\nu_c x)$,
$\nu_c\ne0$, and the remaining $b$ freedom has two analogous
polynomial shifts.

For a pole-four root put $f=-b/2$, of exact pole three. Its
finite numerator has a constant $y$ coefficient, whereas the
root $c$ has a degree-one $y$ coefficient. The same distinct-$G$
argument makes $f$ singleton at at most one critical fiber. If
it is double at all three, then $c$ is singleton at all three
and the three values $K(r_i)y_i$ must interpolate by an
affine-linear polynomial in $r_i$. On the ordered degree162
sheet cover, the degree-two interpolation coefficient is a
rational function. It is nonzero at ALL points over zero by
the fixed cubic-root interpolation check. Its zero support
therefore has finite image on the parameter line. Include
that image in the exceptional support. Away from it, $f$ is
singleton exactly once, and again gives a point of $B$.
The root's selected-zero equations in $\mu_c,\nu_c$ have no
nonzero-slope condition here: its pole four comes from the
already nonzero slope of its $y$ coefficient.

## Selected-zero exceptional support

Fix one of the four omitted $A$ roots. At each of the remaining
nine selected points, $c=c_{\rm base}+\mu_c+\nu_c x$.
For each pair on the same selected $x$ fiber, include the zero
support of $c_{\rm base}(P)-c_{\rm base}(Q)$ on $B$. Each
function is nonzero at every point of the zero-parameter fiber:
the fixed-line small-root check shows all nine pole-three base
values are distinct, and the pole-four subset check has exactly
the27 cross-fiber pairs and no same-fiber pair. Thus every such
support has finite image.

For a triple on three distinct selected $x$ fibers, include the
zero support of the determinant with rows
$[1,x(P),c_{\rm base}(P)]$. That determinant is nonzero at every
point over zero. For pole three the fixed-line result checks
all $\nu_c\ne0$ and the small-root check rules out any triple
at $\nu_c=0$; for pole four all $\nu_c$ were checked directly.
Hence these supports also have finite images. Any triple with
two points on one fiber lies on a pair coincidence support;
three points on one fiber do too. Outside their finite union,+every actual selected $c$ zero set has size at most two.


## Proper finite compact Fitting support

On the ordinary degree81 cover, for each omission and cross-fiber pair
use the three-by-three augmented matrix above. Its determinant is a
rational function which is nonzero at EVERY point above lambda=0,
by the complete fixed-line compact certificate and exact symmetry
coverage. Multiplying its last column by the leading-cubic
discriminant clears all finite denominators from the interpolation
formulas. Its norm in the total degree81 finite algebra is consequently
a polynomial in lambda, nonzero at zero. This holds componentwise
even if the cover is disconnected: every component meets the ordinary
zero-parameter fiber, and no component has identically zero determinant.
The norm's zero support contains the image of every actual compatible
source in that selected-zero stratum. No degree estimate for this norm
is asserted here, and it has not been expanded or factored.

Likewise clear the denominators of each selected pair-coincidence and
triple-concurrency function before taking its norm. All such functions
are nonzero at every point over zero, so each norm is a nonzero
polynomial, nonvanishing there. The ordered cubic interpolation section
has the same property and may be retained as a finite boundary
overrelaxation. Add the explicit leading discriminant, branch, selected,
K-zero and G-value-collision resultants, each nonzero at zero.
There are only finitely many omissions, pairs, triples and profiles,
so the union Sigma of these polynomial zero supports is finite and
does not contain zero.

Every actual reducible critical cubic has a rational root. The source-only
root bounds and fixed-line arguments reduce it to a moving pole-three
or pole-four root. The completed no-singleton exclusions give an
ordinary singleton in the pole-three member of (c,-b/2); outside the
explicit finite boundary and coincidence/interpolation supports it
therefore corresponds to the ordinary sheet cover. If its selected
zero set has size at least three or a same-fiber pair, the concurrence
or coincidence norm contains its parameter. Otherwise enlarge its
zero set to a cross-fiber pair. The compact selected-source matrix
must have zero determinant, and its norm contains the parameter.
This proves the stated source-only finite reduction for every rho.

The support uses a SINGLE compact determinant per pair. It does not
replace a common-minor ideal by a gcd of individual norms, which can
have false support from different points in one fiber. The matrix
and norm conditions here remain necessary relaxations; no exceptional
parameter has been proved to realize an actual source. Neither
irreducibility of the whole moving critical pencil nor a full m9 or
common-cover exclusion follows.
