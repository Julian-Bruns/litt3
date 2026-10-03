# Proof: normalize every positive-height source before lifting

[Statement](../../Theorems/deformations/ramified_rapoport_oper.md).
Write \(\mathcal H_i\) for the rank-two crystalline components at the
unramified embeddings, with coefficient DVRs \(A_i/W(k)\) of
ramification index e. Put \(E_i=\mathcal H_i/\pi\) and \(R_i=A_i/p\).
All integer actions, coefficient twists and actual F,V maps are retained.

## Coefficient freeness and the degree lemma

The coefficient crystal itself is locally free over its coefficient
ring on a smooth curve. Indeed, at a closed point of a formal smooth
lift the completed base ring is $B=W(k)[[t]]$, and a coefficient
component is a finite module over the regular local ring
$A_i[[t]]$. Its underlying $B$-module is free. Thus $(p,t)$ is a
regular sequence on it, so its depth over $A_i[[t]]$ is two.
Auslander--Buchsbaum makes it free; its rank is two by the rational
coefficient rank. This local calculation descends from completion.

For the isocrystal formulation, Newton specialization puts all normalized
slopes in [0,1]. The coefficient-preserving construction of
[Krishnamoorthy--Pál, Lemma5.8](https://arxiv.org/pdf/1809.02106)
supplies a Dieudonné lattice on the whole smooth curve; its excluded set
has codimension at least two. First sum a lattice under an integral basis
of \(\mathcal O_K\), then perform F,V saturation and reflexive hull.
These operations preserve the integer action. The depth argument above
gives coefficient freeness, without a Hodge-freeness hypothesis.

A positive line of degree d in a degree-zero reduced connection with
nilpotent p-curvature is horizontal, in which case p divides d by Cartier
descent, or has nonzero second fundamental form and d<=g(C)-1.
In genus two the latter is a degree-one oper. The same degree argument
over a constant coefficient thickening is proved in the special-case
section below.

## Positive source kernels across arbitrary component cycles

Start with the coefficient-free Dieudonné lattices $\mathcal H_j$
and put $E_j=\mathcal H_j/\pi$. Let $d_j$ be the valuation of
$\det F_j$. The relation $FV=p$ prevents horizontal determinant
zeros. The normalized determinant gives
$\deg E_j=p\deg E_{j-1}$; cycling makes every degree zero. The generic unit-root direction
makes every step primitive at the coefficient generic point:
otherwise the integral circuit would have positive smallest slope.
Consequently
\[
0\le d_j\le e,\quad \sum_jd_j=b,\quad
\pi^{d_j}\mathcal H_j\subset F_j(F^*\mathcal H_{j-1}),\quad
V_j(\mathcal H_j)\subset\pi^{e-d_j}F^*\mathcal H_{j-1}.
\tag{G1}
\]
The last two inclusions are the adjugate formula and hold everywhere.
A zero-height step is an actual integral isomorphism.

For $d_j>0$, its reduced kernel is $F^*N_{j-1}$, for a line
subbundle $N_{j-1}\subset E_{j-1}$ obtained by Cartier descent.
Write its saturated image and defect as
\[
\operatorname{im}\overline F_j=I_j(-D_j),\qquad
\deg I_j=-p\deg N_{j-1}+\delta_j,\quad \delta_j=\deg D_j.
\tag{G2}
\]
The saturated image is horizontal and has zero $p$-curvature,
as does the source quotient of the canonical Frobenius pullback.
Cartier descent of this line map gives $D_j=pD'_j$; in particular
$\delta_j\in p\mathbf Z_{\ge0}$.

For consecutive positive-height steps $j,k$, separated by $a-1$
zero-height steps, transport $I_j$ through those actual isomorphisms.
The generic unit-root direction makes its map to $E_{k-1}/N_{k-1}$
nonzero. If $\ell_j=\deg N_{j-1}$, its degree inequality is
\[
\ell_k\le p^a\ell_j-p^{a-1}\delta_j.
\tag{G3}
\]
Cycling these inequalities, whose total distance is $f$, proves
all $\ell_j\ge0$. If one were zero, all would be zero and every
defect would vanish. All the nonzero degree-zero line maps just
used would be isomorphisms everywhere. Every fiber would have a
unit-root direction; its other slope is fixed by the determinant.
This would make the Newton polygon constant. Therefore
\[
\ell_j>0\quad\text{at the source of every positive-height step}.
\tag{G4}
\]
No equality of the heights or absence of zero-height runs was used.

## Produce one oper in the actual isogeny class

If a positive line in some $E_j$ is nonhorizontal, the genus-two
degree lemma makes it an oper. Suppose this has not happened.
Every positive line in (G4) is then horizontal. Moving backwards
across a zero-height isomorphism, Cartier descent gives a positive
line in the preceding component. Repeating across each zero run
shows that every component has a positive horizontal maximal line
$L_j$. Uniqueness of a positive saturated line gives
$L_{j-1}=N_{j-1}$ at a positive-height step and
$F_j(F^*L_{j-1})=L_j$ at a zero-height step.

Make the simultaneous inverse-image modifications
\(\mathcal H'_j=\ker(\mathcal H_j\to E_j/L_j)\).
In a basis adapted to L_j this has basis (u,pi v). Horizontality
preserves the connection; topological quasi-nilpotence is inherited
by a lattice of finite index. Thus these are intrinsic subcrystals.
At a positive-height step the reduced $F_j$ kills its source line, so
it preserves these lattices. For Verschiebung use
\[
\operatorname{im}\overline V_j\subset
\ker\overline F_j=F^*L_{j-1},
\tag{G5}
\]
which follows from $F_jV_j=p$. Its image of the whole old target
already lies in the modified source. This works even when $d_j=e$;
divisibility of $V_j$ by $\pi$ is not needed. At a zero-height
step, both compatibilities follow from the isomorphism and the
equality of the lines. Both determinants change by one factor
of $\pi$, so the heights are unchanged. These integral F,V-crystals
realize full groups by
[Krishnamoorthy--Pál, Theorem5.7 and Definition5.1](https://arxiv.org/pdf/1809.02106).

Evaluate the fixed rational crystals on an arbitrary smooth proper Witt
lift, extended to the coefficient DVRs. Their characteristic-zero
connections are slope semistable as connections: every horizontal
subbundle has degree zero. These simultaneous inverse-image modifications
are Langton modifications by their positive maximal subconnections.
[Langer, Theorem5.1 and its proof](https://arxiv.org/pdf/1311.2794)
give termination. If no oper appeared, (G4) and zero-run descent would
supply a positive horizontal line in every component forever, a
contradiction. The resulting Dieudonné lattice therefore has an oper.
The auxiliary lift serves only to prove termination.

## Transfer height through nonoper components

Protect one oper component and label it $0$. Never modify an oper
component in the following procedure. If another component $j$
is not an oper and
\[
d_{j+1}>0,\qquad d_j<e,
\tag{G6}
\]
its positive kernel line $N_j$ is horizontal; otherwise it would
be an oper. Replace only this lattice by
\[
\widetilde N_j=\ker(\mathcal H_j\to E_j/N_j),\qquad
\mathcal H_j^+=\pi^{-1}\widetilde N_j.
\tag{G7}
\]
It is a lattice with connection in the same rational crystal.
All four affected integral maps are preserved:

- $F_j$ enters an enlarged target.
- $F_{j+1}(F^*\widetilde N_j)\subset\pi\mathcal H_{j+1}$ by
  the defining reduced kernel.
- $V_{j+1}$ enters an enlarged target.
- $V_j(\mathcal H_j)\subset\pi F^*\mathcal H_{j-1}$ by (G1)
  and $d_j<e$, so it remains integral after (G7).

Thus the actual height change is
\[
(d_j,d_{j+1})\longmapsto(d_j+1,d_{j+1}-1).
\tag{G8}
\]
If a new oper appears, protect it too. All earlier protected
components are unchanged.

For $f>1$, label incoming edges $1,\ldots,f$, with edge $f$
entering component0. Every permitted move has $1\le j<f$ and
decreases the nonnegative integer $\sum_{a=1}^f a d_a$ by one.
The process terminates with no permitted move at a nonoper
component. For $f=1$ no move is needed.

## Every positive edge leaves an oper

First, an outgoing edge of ANY positive height t from an oper has
zero defect. Its positive kernel is the unique oper line, of degree
one. At the next positive edge, (G3) gives
\[
0<\ell_k\le p^a-p^{a-1}\delta.
\tag{G9}
\]
Thus the p-divisible defect satisfies \(\delta<p\) and vanishes. The actual
elementary divisors are \((1,\pi^t)\) everywhere.

Now consider a terminal nonoper j with positive outgoing height.
No permitted move means its incoming height is e. Continue backwards:
every nonoper encountered has incoming height e until an oper is reached.
That oper's outgoing height-e edge has zero defect by (G9).
Its actual Hodge line exists modulo p. Here is the local curvature
calculation, valid in any genus. In an étale coordinate z with Frobenius
lift z^p, lift a source Hodge basis (u0,v0) with second fundamental
coefficient c dz. The target basis u=F(u0)/p, v=F(v0) satisfies
\[
\nabla u=c^p z^{p-1}v\,dz,\quad\nabla v=0\pmod\pi,
\qquad \psi(\partial_z)(u)=-c^pv,\quad\psi(\partial_z)(v)=0.
\tag{G9a}
\]
The first identity is horizontality divided by p; the other coefficients
have a factor p. The curvature identity uses (p-1)!=-1 and
\(\partial_z^p=0\). Since c is a unit for the source oper, the target
has nonzero nilpotent p-curvature with negative Frobenius-image kernel. Its positive outgoing kernel cannot
be horizontal; hence that target is an oper. Propagation along the
height-e chain contradicts the supposed terminal nonoper j.
EVERY positive-height edge therefore leaves an oper.

Conversely an oper cannot have zero outgoing height at termination.
Transport its degree-one line through the zero-height isomorphisms
to the next positive edge. It gives a positive line of degree p^a>1
inside that edge's oper source, whose maximal line degree is one.
This is impossible. Thus the operative components are exactly the
sources of positive edges.

## The whole outgoing kernel at every positive height

Let a positive edge of height t leave component i. Its elementary
divisors \((1,\pi^t)\) give a line kernel over the WHOLE ring
\(A_i/\pi^t\). It is horizontal for the canonical relative
Frobenius connection, since p=0 there. Relative Cartier descent
gives \(L_{i,t}\subset\mathcal H_i/\pi^t\). Frobenius acts on
the curve factor and fixes the constant nilpotent coefficients.

Equivalently, this is the inverse image of the ACTUAL Hodge filtration
under \(\mathcal H_i/\pi^t\cong\pi^{e-t}\mathcal H_i/p\).
Its reduction is the oper line. Nakayama makes its whole second
fundamental form an isomorphism.

For lifting choose an edge of maximum height s. Every constituent
Frobenius has height at most s, and its oper is supplied to precision
\(\pi^s\). The [Taylor estimate](frobenius_taylor_thickness.md) applies
because \((p-1)s>s\). The own-height oper at another edge need not meet
the global-cycle Taylor threshold. No divided powers on (pi^s)
are required.

## Ordinary, residue-degree-one and whole-modulo-p cases

In the ordinary case b=ef, every d_j=e. Once one component is an oper,
the height-e curvature propagation gives ALL of them. By (G9) every
step has elementary divisors (1,p), so every actual Hodge module is free
over A_i/p and every whole-modulo-p second fundamental form is an
isomorphism. This proves the ordinary conclusion without initially
free Hodge modules.

For f=1 the unique height is b. The same construction gives elementary
divisors (1,pi^b) and the whole line to precision pi^b.
If b<e, a basis adapted to that line gives u=F(u0)/pi^b, v=F(v0).
Horizontality makes the off-diagonal coefficient of nabla u divisible
by p/pi^b, and all other coefficients divisible by p. Both vanish
modulo pi, so the oper reduction is dormant.

The stronger whole-modulo-p conclusion from an initially FREE Hodge
module is also retained. Active Frobenius steps then have elementary
divisors (1,p); inactive steps are isomorphisms. Their reduced positive
kernel degrees follow from (G4). Intrinsic Frobenius untwisting of the
WHOLE horizontal Hodge filtration, by
[Lam, Lemma4.2](https://arxiv.org/pdf/2210.13563), preserves its freeness
and divides the positive total Hodge degree by p. The intrinsic
construction glues because it is the inverse image of the specified
Hodge filtration in the fixed crystal, agrees under crystalline transition
maps, and preserves F,V and the integer action. Lam's intrinsic identity
\(F(\mathcal H'^{(p)})=p\mathcal H\) gives the actual pullback relation.
It terminates with a nonzero whole second fundamental form.

To see that this form is an oper over the entire coefficient ring,
write $M_R=H_R/L_R$ and let
$\kappa:L_R\to M_R\otimes\omega_C$ be the second fundamental form.
For nonzero $\kappa$, choose the largest $s<e$ such that it lies in
$\pi^s\mathcal Hom(L_R,M_R\omega_C)$. Its leading coefficient is
a nonzero section of
\[
\mathcal Hom(L_0,M_0\omega_C).
\]
Here every associated graded piece for the coefficient filtration
is the reduced line bundle, up to a constant one-dimensional
factor. Since $\deg H_0=0$, its degree is $2g(C)-2-2d$.
Hence $d\le g(C)-1$.

If $\kappa\bmod\pi=0$, the reduced line is horizontal. Nilpotence
of the ambient $p$-curvature makes its restriction to this line
zero. Cartier descent therefore writes $L_0=F_C^*N$ for a line
bundle $N$ on the Frobenius twist of $C$. Thus $p\mid d$.
For $0<d\le g(C)-1<p$, this is impossible. In genus two the
reduced map is consequently nonzero between lines of the same
degree, so it is an isomorphism. Nakayama makes $\kappa$ itself
an isomorphism over $R_i$. This argument does not assume that a
nonzero map over a nonreduced ring has nonzero reduction.

It follows that this free-Hodge construction supplies an oper over ALL
of A_i/p, retaining its intrinsic Frobenius-pullback relation.

## A coreless actual comparison synchronizes every active interval

Assume the given source comparison respects every Frobenius arrow.
Call a component active when its outgoing height is positive, and let
m be their number. Between consecutive active sources j,i at cyclic
distance a_i, contract the intervening zero-height isomorphisms.
The actual map has elementary divisors (1,pi^t_j), where t_j is the
outgoing height of j. Its integral horizontal complement
\(\pi^{t_j}\mathcal F_i^{-1}\) gives modulo pi
\[
0\to F_C^{a_i*}(E_j/L_j)\to E_i
 \xrightarrow{\mathcal V_i}F_C^{a_i*}L_j\to0.
\tag{G10}
\]
Restrict to L_i. The resulting Hasse map has divisor of degree
p^(a_i)-1. Its zeros are simple: at a zero L_i is the kernel of the
complement, whose derivative on L_i is its oper second fundamental
form followed by the quotient isomorphism in(G10).

Descend EVERY active oper lattice through the other actual leg.
Faithful flatness descends the contracted maps and sequences. Their
nonempty reduced Hasse divisors are common on the ORIGINAL source.
For a coreless span, clump uniqueness forces equal supports, hence
equal a_i. Therefore
\[
m\mid f,\quad a=f/m,\quad |S_Y|=p^a-1,\quad
\frac1{ea}\le\delta=\frac b{ef}\le\frac1a,
\tag{G11}
\]
using \(m\le b\le em\). Unequal heights give no exceptional-isoclinicity
conclusion from the unramified two-step pairing argument.

## Determinant torsion gives the exact canonical profile

Suppose the rational determinant is geometrically constant on BOTH
endpoints. An active determinant lattice is constant up to a scalar
uniformizer power: on a smooth proper lift, its divisor inside the
rational trivial line is supported on the irreducible special fiber.
Its horizontal trivialization gives \(L_i^2\cong\omega_C\) for C=X,Y.
Put q=p^a and \(\tau_C=\mathcal O(S_C)\otimes\omega_C^{-(q-1)/2}\).
The common reduced Hasse divisor and(G10) give
\[
\mathcal O(S_C)=F_C^{a*}L_j\otimes L_i^{-1}
=\omega_C^{(q-1)/2}\otimes(L_j\otimes L_i^{-1}).
\tag{G12}
\]
Thus tau_C is two-torsion, independent of i, and its m-th power is
trivial on EACH endpoint. The squared Hasse sections are canonical
of weight q-1 with divisor 2S_C. Their source pullbacks differ by
a nonzero scalar on the proper connected source; normalize it to
make them an actual common section.

In the shared ring k[s], the primitive zero multiplicity divides two.
It is one exactly when BOTH tau_X and tau_Y vanish: then the unsquared
Hasse sections are canonical and can be matched by the same scalar
argument; conversely a primitive weight-(q-1)/2 section with divisor
S_C trivializes both tau_C. Otherwise the multiplicity is two.
The respective primitive weights are (q-1)/2 and q-1. Odd m kills
both torsion classes and forces the first profile.

## Preserve the actual span and lift over the ramified DVR

The preceding isogenies do not change the rational coefficient
crystal. The resulting component $\mathcal H_i$ is therefore an
integral lattice in the component of the originally specified
rational crystal on $Y$.

The actual source isomorphism identifies the rational endpoint
components. The stable-lattice descent part of
[crystalline oper lifting](crystalline_oper_lifting.md) descends
the oper lattice and its actual partial Hodge line through the other
leg. It uses a Galois closure of that leg only and then descends
back to the ORIGINAL source and maps.

The maximum-height construction supplies the whole line over
$A_i/\pi^s$ and bounds every integral Frobenius height by $s$.
The Frobenius Taylor criterion therefore lifts the original maps
together over $A_i$, without a ramification or residue-degree
restriction. In the whole-modulo-$p$ cases one may instead use
the original divided-power oper criterion.

The same conclusion descends from an étale refinement by the
marked refinement equivalence. For the main pair, its full
mixed-characteristic lifting exclusion permits arbitrary
ramification and therefore applies. Newton specialization puts
all slopes of a normalized rank-two isocrystal with generic gap
at most one in $[0,1]$. The coefficient-preserving lattice argument
above supplies its BT realization. Existence of a common rational
coefficient remains essential and is not supplied by the two maps.
