# Proof: robust generation of an actual positive line trace

Version3,2 October2026. [Focused whole-implication review](../../Research/audits/POSITIVE_SINGLE_SECTION_TRACE_AUDIT_2026_10_02.md) PASS.
[Statement](../../Theorems/cartier_and_spin/actual_positive_single_section_trace.md).
No new calculation is needed.

## General degree and reduced-support criterion

Retain the TWO actual finite etale maps of degrees $n,\eta n$,
the source line subbundle L of degree a, and the section with reduced
zero support of degree b. Take the actual one-leg Galois closure
$q:T\to Y$, of degree $\eta d$, with conjugate actual maps
$h_i:T\to X$ of degree d. Its complete coefficient splits into
the lines $L_i=h_i^*L$ of degree ad. Their fibre maps into $q^*K$
are nonzero: they are subbundles of the ambient actual Cartier
bundle, so a fibre zero in K would give an ambient fibre zero.

Let N be the number of DISTINCT generic image lines. The full
actual deck group is transitive on them; every line has the same
raw-label multiplicity. At a point z remove a distinct line only
if every original section representative vanishes there. In the
original degree-$\eta n$ opposite fibre there are at most bn points
over the reduced support of s. Thus at most a fraction $b/\eta$
of raw labels vanish, and at most $Nb/\eta$ distinct lines are
removed after dividing by their common label multiplicity. Every
surviving line has a unit original section at z.

Let B be the deck-invariant collection of generic basis r-subsets
of these distinct lines. It is nonempty. Transitivity makes the
number of basis hyperedges incident with each vertex equal to
$r|B|/N$. The removed vertices consequently delete at most
$rb|B|/\eta$ basis hyperedges.

The determinant divisor for every generic basis has degree
$(\eta k-ra)d$. Summing over the full basis collection gives a
deck-invariant divisor. Its coefficient at z is at most its degree
divided by the etale fibre size $\eta d$, hence at most
$(k-ra/\eta)|B|$. This bounds the number of bases whose fibre
images collide at z. Therefore a basis which survives BOTH
deletion and collision exists whenever
\[
\frac{rb}{\eta}+k-\frac{ra}{\eta}<1,
\quad\text{equivalently}\quad
k<1+\frac{r(a-b)}{\eta}.
\]
Its unit original sections generate the whole K-fibre at z.
Nakayama's lemma and faithful flatness give $R=K$ everywhere.
The inequalities remain meaningful for every degree ratio: the
nonzero determinant forces $k\ge ra/\eta$, and the strict
criterion then implies $rb/\eta<1$ automatically. No positivity
of a merely formal surviving fraction is assumed.

Only the support size b enters deletion; multiplicities enter the
degree a and hence the determinant budget. The distinction is why
a section with a repeated zero can give exact raw generation.

## The actual raw line and its two infinity zeros

The original q0 exact form has primitive order eleven at infinity.
Its saturation therefore acquires exactly two Frobenius-target zeros
there. It has no other horizontal B-zeros, as established by the
[complete one-form bound](first_section_contact_strictness.md).
Its saturated line is $M=O_X(2O)$, and its raw section in M has
divisor $2O$. Source strong semistability and one-leg Galois splitting
give the actual trace K minimum slope at least one quarter.
Its rank cannot be one: a rank-one trace has positive integral degree,
whereas every line in the genus-two Cartier bundle has degree at most
zero by Frobenius adjunction.

Take the actual one-leg Galois closure $q:T\to Y$ of degree $8d$,
with its conjugate maps $h_i:T\to X$ of degree d. The actual
coefficient presenting K splits into the conjugate lines
$M_i=O_T(2H_i)$ of degree $2d$, where $H_i=h_i^*O$.
Their maps into $q^*K$ are everywhere nonzero as maps of fibres:
each $M_i$ is saturated in $B_T$, so a zero in $q^*K$ would give
a zero in that ambient bundle. The corresponding raw section is
a unit in $M_i$ away from $H_i$.

## Basis hyperedges and the infinity deletion

Let r be the rank of K and let N be the number of DISTINCT generic
image lines among the $M_i$. The deck group acts transitively on
these N lines. Use the FULL actual sheet labels initially; every
distinct line has the same stabilizer multiplicity. At a point
$z\in T$, declare a distinct line removed only if EVERY raw
representative has $h_i(z)=O$. For a fixed z, the images $h_i(z)$
are the actual points of the original genus-two fibre, with equal
sheet multiplicity. There are at most n infinity points in a fibre
of degree $8n$, so at most one eighth of the raw labels are infinity
labels. Division by the stabilizer multiplicity bounds the removed
distinct lines by $N/8$. Every surviving line has at least one
unit raw section at z. Coincident generic lines are never counted
as independent basis members.

Let B be the nonempty set of r-element subsets of distinct lines
which form a generic basis of $q^*K$. This is a deck-invariant
uniform hypergraph. Transitivity on vertices makes every vertex
incident with $r|B|/N$ basis hyperedges. Removing at most $N/8$
vertices consequently deletes at most $r|B|/8$ hyperedges. At least
$(1-r/8)|B|$ generic bases survive the infinity deletion at z.

For each generic basis, the determinant of its line map into
$q^*K$ is a nonzero section with zero divisor of degree
\[
\deg\det(q^*K)-\sum\deg M_i=(8-2r)d,
\]
because $\deg K=1$. Sum these determinant divisors over the FULL
deck-invariant basis set. The sum is invariant, and every actual
q-fibre consists of $8d$ etale points with equal coefficient in this
sum. Therefore its coefficient at any z is at most
\[
\frac{(8-2r)d|B|}{8d}=(1-r/4)|B|.
\]
This bounds the number of generic bases whose images collide at z,
with multiplicity retained. The surviving bases number at least
$(1-r/8)|B|$, strictly more than $(1-r/4)|B|$ for every positive r.
Hence some surviving basis remains independent at z. Its unit raw
sections generate $q^*K$ in that fibre. Nakayama's lemma gives
$q^*R=q^*K$ at EVERY point, and faithfully flat descent gives
$R=K$ integrally.

The numerical fractions are respectively: rank two has collision
budget one half and deletion at most one quarter; rank three has
budget one quarter and deletion at most three eighths; rank four
has zero collision budget and deletion at most one half. This is
an all-fibre count, not a finite-field point probe.

## Consequences for a degree-one original three-section trace

Raw q0 belongs to the original three-section image, so the equality
$R=K$ proves $K\subset J$ in the additional degree-one branch.
If rank K is two or three, $J/K$ has total degree zero. Its
torsion-free quotient is a quotient of the nef J and has nonnegative
degree; hence there is no torsion and it is a degree-zero bundle.
The [zero-quotient contact bounds](first_section_contact_strictness.md)
give respectively $t\ge11n$ and $t\ge9n$.

If rank K is four, equal degrees and inclusion give $K=J$ exactly.
For every a, Frobenius pullback of the actual presenting coefficient
has minimum slope at least $5^a/4$: it is the one-leg etale
pushforward of the line $F_X^{a*}M$ of degree $2\cdot5^a$.
Its quotient $F_Y^{a*}K$ has that same lower bound, while its average
slope is exactly $5^a/4$. Thus every Frobenius pullback is
semistable and J is strongly semistable.

## The full-rank branch is projectively finite etale

Suppose K has rank four and degree one, so $K=J$. On the ACTUAL
one-leg closure, any four generically independent source lines
$M_i=O_T(2H_i)$ have total degree $8d=\deg q^*J$. Their nonzero
determinant section has degree zero, so the direct sum maps
isomorphically to $q^*J$ INTEGRALLY.

For the fixed X, $\omega_X\simeq O_X(16O)$. Hence each actual
source line satisfies
\[
M_i^8\simeq\omega_T.
\]
Their ratios are genuine eighth-torsion lines on T; they do not arise
from replacing a supported contact divisor by complete fibres.
Trivializing these finitely many ratios by a tame finite etale
refinement gives
\[
q^*J\simeq M_T^{\oplus4},\qquad M_T^8\simeq\omega_T.
\]
Thus End(J) is etale-trivializable. On this cover the squared
determinant is $M_T^8=\omega_T$, proving that
$(\det J)^2\omega_Y^{-1}$ is itself etale-trivializable. No
triviality on the original endpoint is inferred.

Every other source q0 line becomes a constant direction in
$M_T^{\oplus4}$: it has the same degree, so a nonzero component to
one chosen summand is an isomorphism, and its maps to the common
line are scalars. Write its original section as $t_i v_i$, with
$v_i\in k^4$ constant and $\operatorname{div}t_i=2H_i$.
The canonical source form $\theta=dx/y^2$ has divisor $16O$,
so, up to nonzero scalar choices of the eighth-root isomorphisms,
\[
h_i^*\theta=t_i^8.
\]
The Frobenius adjunction of J becomes a map
$M_T^5\otimes k^4\to\omega_T=M_T^8$, or four sections of
$M_T^3$. Frobenius pulls the constant direction to $v_i^{[5]}$, so
its evaluation is
\[
\beta(v_i^{[5]})=q_0(x_i)t_i^3,
\qquad x_i=x\circ h_i.
\]
Indeed the raw q0 section is $t_i v_i$, and its differential
evaluation is $q_0(x_i)h_i^*\theta=t_i^5\beta(v_i^{[5]})$.
These identities retain the actual source maps and positive line
M; neither a shared finite coefficient nor a second-map descent is
supplied by the projective trivialization.

The argument does not put K inside J when $\deg K>1$. In that
larger-degree case saturation at the actual infinity sheets can
still add genuine lattice directions, so no conclusion about
strong semistability of J or a common finite coefficient follows.
