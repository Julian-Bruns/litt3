# Critical numerator coprimality in the actual m9 zero-moment sector

Version12,2 October2026. Retain an ACTUAL nontrivial admissible
degree-ten source in the $d=10,m=9$ profile, with short critical
cubic $D$, numerator $U$ and fourth annihilator moment
$\rho\in\langle1,x,x^2\rangle$.

If $\rho=0$, then $\gcd(D,U)=1$ over $k(X)$: there is NO
rational critical cancellation, including all infinity pole profiles
and all finite repeated, branch, endpoint and coefficient-drop
boundaries. This does not assert that $D$ is irreducible. The
critical cubic without numerator cancellation, the actual m9 profile
and the unmarked common-cover problem remain undecided.

Every rational critical root $c$ has infinity pole at most four,
and forces
\[
\delta_3\in\langle q,q_3\rangle,
\quad q=([13],[18],[24]),\quad q_3=([1],[22],[9],[1]).
\]
If $c$ is regular at infinity or has pole at most one, then
$\delta_3$ is proportional to $q_3$. These root restrictions do
not require function-field squarefreeness or numerator cancellation.
Any rational root additionally forces the SHORT coefficient bounds
$\operatorname{pole}_O\delta_2\le13$ and
$\operatorname{pole}_O\delta_1=16$. A rational root of pole two
is impossible.
Moreover $n_0=\operatorname{Tr}(u^2/\phi)$ belongs to $L_9$
whenever a rational critical root exists, without assuming $\rho=0$.

The independent
[squarefreeness theorem](admissible_degree_ten_m9_critical_squarefreeness.md)
supplies function-field squarefreeness on every actual m9 source.
If $\rho=0$, then
$\deg\gcd(D,U)\ne2$: the reduced critical denominator cannot
be linear. A canceled rational critical root of pole four is
also impossible when $\rho=0$, without a squarefreeness assumption.
Every canceled rational critical root of pole at most one is also
impossible when $\rho=0$, retaining the complementary critical
quadratic's half-integral infinity slopes and all vanishing trace
and numerator coefficient boundaries.

The two assertions concern different roots: in the degree-two-gcd
case, $c$ is the remaining UNCANCELED critical root; in the last
case the rational root itself is canceled by $U$.

In a hypothetical canceled-root case of pole three, write
$D=\delta_3(T-c)(T^2+bT+e)$. Then $b$ has exact pole four
and $e$ has pole at most five. Its quadratic trace
$n_0=\operatorname{Tr}(u^2/\phi)$ has exact pole nine,
and the affine regularizer $\eta_1$ of the short first quadratic
moment belongs to $L_{10}$, and $n_0$ is proportional to $q_3$.
In fact the SHORT second quadratic moment has infinity pole
at most11. Its affine regularizer $\eta_2$ belongs to
$L_{10}=\langle1,x,x^2,x^3,y\rangle$, and
$\eta_1\in\langle q,q_3,y\rangle$.
Thus these quadratic trace data have at most nine scalar
coordinates: one for $n_0$, three for $\eta_1$, and five for
$\eta_2$. This count concerns the trace data, not the source
or numerator coefficients, and does not assert realization.

In this canceled pole-three branch write $U=(T-c)p$. The
finite-frame cubic $p_f$ is affine, and its coefficients vanish
at least to the pole order of $c_f$ at every finite pole of that
root. Its SHORT coefficient bounds are
$\operatorname{pole}p_3=19$, $p_2\le20$, $p_1\le21$, $p_0\le22$.
The entire fixed-leading-line boundary $\delta_3\in k^*q_3$
is excluded: its finite pole itineraries and every geometric
endpoint-zero stratum give zero integral quotient space. This
retains all zeros of $v$, every omitted $A$ root, every cubic
sheet and arbitrary geometric root coefficients.

Uniformly in the entire leading-coefficient pencil, a canceled
pole-three root must vanish at AT LEAST THREE of the nine selected
finite endpoints. Every at-most-two selected-zero stratum is excluded,
including two zeros on one $x$ fiber. This retains repeated leading
cubic roots, cubic branch points, zeros at selected endpoints and all
finite critical pole-itinerary boundaries; it is not merely a generic
parameter exclusion.

Exactly three selected zeros not all on one selected $x$ fiber
are also impossible. This closes both the entire $1+1+1$ and
$2+1$ zero strata, retaining all leading-cubic and finite pole
boundaries. The proof uses nine exact kernel-map embeddings for
$1+1+1$, and eighteen exact seventh-power section spans of
codimension one for $2+1$. The latter bound every scheme-theoretic
kernel-map fiber by length two, including tangent multiplicities.
Separate strengthened contact tests exclude poles at selected
endpoints in both strata.

Moreover a canceled pole-three root cannot have maximal finite
pole support on exactly ONE cubic sheet over any unramified root
of its leading critical cubic. This initially retains repeated
critical roots and other branch fibers: a selected same-fiber zero
pair forces a squarefree ordinary critical parameter support, and
all its geometric strata are excluded by finite coefficient norms.
In particular the ENTIRE ordinary five-pole itinerary is excluded,
including every selected-zero set, omitted endpoint root and cubic
sheet choice. The argument uses
[the section-span clearing bound](section_span_clearing_degree_bound.md)
for small zero strata and
[the norm-minor obstruction](critical_denominator_norm_minor_obstruction.md)
after singleton evaluation in the remaining four-zero strata.

The complementary no-singleton branch is also impossible. Full
two-sheet local jets force
$\delta_\lambda\mid D_1^3+8K_\lambda^3P$, where $D_1$ has
exact degree one and $Z\delta_\lambda=PK_\lambda+R_\lambda$.
This retains repeated unramified roots. Branch multiplicities are
at most one; the gamma-zero branch is excluded by a selected-remainder
Bezout obstruction, and the other branch factors satisfy the same
cube congruence. Its exact parameter support has degree twelve,
with every leading-coefficient drop separately excluded. On its
two irreducible factors of degrees four and eight, universal
two-sheet coefficient content and minimum endpoint contact give
rank fifty on the fifty-dimensional quotient coefficient space,
for every omission and global cubic phase. Thus no pole-three
rational critical cancellation remains.

Degree-two critical gcds were excluded above. A degree-three gcd
would make the actual annihilator polynomial of degree at most one,
excluded by [the low-polynomial theorem](admissible_linear_annihilator_exclusion.md).
Hence the stated coprimality follows. The focused whole-branch
[independent audit](../../Research/audits/M9_FULL_RATIONAL_CANCELLATION_AUDIT_2026_10_02.md)
passed. No whole m9 profile or unmarked common-cover decision follows.

[Proof](../../Proofs/cartier_and_spin/admissible_degree_ten_m9_zero_moment_denominator_exclusion.md).
