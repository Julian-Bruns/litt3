# Proof: detect ramified variation before lifting in p-adic steps

[Statement](../../Theorems/deformations/ramified_rapoport_oper.md).
Write $\mathcal H_i$ for the rank-two crystalline components indexed
by the unramified embeddings. Their coefficient DVRs $A_i/W(k)$
have ramification index $e$ and residue field $k$; put $R_i=A_i/p$.
The Frobenius maps cycle these components. All coefficient actions
are retained, including the uniformizer action.

## Ordinary groups: the coefficient lattice is free before its Hodge module is

First treat the ordinary assertion, without assuming Hodge freeness.
The coefficient crystal itself is locally free over its coefficient
ring on a smooth curve. Indeed, at a closed point of a formal smooth
lift the completed base ring is $B=W(k)[[t]]$, and a coefficient
component is a finite module over the regular local ring
$A_i[[t]]$. Its underlying $B$-module is free. Thus $(p,t)$ is a
regular sequence on it, so its depth over $A_i[[t]]$ is two.
Auslander--Buchsbaum makes it free; its rank is two by the rational
coefficient rank. This local calculation descends from completion.

Write $\overline H_i=\mathcal H_i/\pi$ and denote the Hodge
subbundle of $\mathcal H_i/p$ by $\mathrm{Fil}_i$. The latter is
an $\mathcal O_C$-subbundle even when it is not free over $R_i$.
Define the reduced Hodge line $L_i\subset\overline H_i$ by
\[
\pi^{e-1}L_i=
\mathrm{Fil}_i\cap\ker(\pi:\mathcal H_i/p\to\mathcal H_i/p).
\tag{O1}
\]
Here multiplication by $\pi^{e-1}$ identifies $\overline H_i$
with that ambient kernel, up to a constant unit. The intersection
is a saturated rank-one subsheaf: it has rank one at the ordinary
generic point, and both the Hodge quotient and the quotient by
this kernel in $\mathrm{Fil}_i$ are torsion-free. Thus (O1) is
an actual line subbundle, including at nonordinary points.

At the ordinary generic point the determinant of each crystalline
Frobenius step has valuation $e$ in $A_i$, namely that of $p$.
It has no horizontal zero or pole, since $FV=p$. Therefore its
determinant is locally $p$ times a unit everywhere. Reducing its
determinant after division by $p$ gives
$\deg\overline H_i=p\deg\overline H_{i-1}$, and hence all these
degrees are zero.

Reduction of the actual $F,V$ maps gives
\[
\overline F_i(F_C^*L_{i-1})=0,\qquad
\overline V_i(L_i)\subset F_C^*L_{i-1}.
\tag{O2}
\]
The first assertion follows from the defining Hodge kernel; the
second follows because Verschiebung maps into the Frobenius Hodge
filtration and commutes with $\pi$. The restrictions
$h_i:L_i\to F_C^*L_{i-1}$ are nonzero at the ordinary generic
point. If all were units at a geometric point, their cycle would
give a coefficient-rank-one unit-root part for $V$, hence slopes
$(0,1)$ for $F$. Thus some $h_i$ has a zero. Their degree
inequalities, as in (2) below, imply
\[
d_i:=\deg L_i>0\quad\text{for every }i.
\tag{O3}
\]
Each $L_i$ is consequently the unique positive maximal line of
the degree-zero rank-two bundle $\overline H_i$.

## A simultaneous modification stays inside the actual isogeny class

Suppose all the reduced lines $L_i$ are horizontal. Replace each
coefficient lattice by the inverse image
\[
\mathcal H'_i=
\ker(\mathcal H_i\longrightarrow\overline H_i/L_i).
\tag{O4}
\]
It is locally free, with basis $(e,\pi a)$ in a basis adapted to
$L_i$. Horizontality makes it a subcrystal. This can be checked
on any local formal lift: its connection preserves the inverse
image, and topological quasi-nilpotence is inherited by a lattice
of finite index. The construction is intrinsic and glues.

Equations (O2) prove BOTH integral inclusions
\[
F_i(F_C^*\mathcal H'_{i-1})\subset\mathcal H'_i,
\qquad V_i(\mathcal H'_i)\subset F_C^*\mathcal H'_{i-1}.
\tag{O5}
\]
For the first, the reduction of $F_i$ kills $L_{i-1}$, so its
image lies in $\pi\mathcal H_i\subset\mathcal H'_i$. For the
second, use the second inclusion in (O2). The restricted maps
still satisfy $FV=VF=p$. Thus the new lattice is a Dieudonné
crystal, and gives an $\mathcal O$-linear group in the SAME
isogeny class. We use the equivalence on smooth characteristic-$p$
bases in [Krishnamoorthy--Pál, Theorem5.7 and Definition5.1](https://arxiv.org/pdf/1809.02106).
No quotient supported only at a bad point is being postulated.

These simultaneous modifications cannot continue indefinitely.
Choose any smooth proper lift of $C/W(k)$ and evaluate each fixed
rational coefficient crystal on its extension to $A_i$. This gives
an algebraic vector bundle with connection on a smooth proper
$A_i$-curve. Its characteristic-zero generic connection is slope
semistable: every horizontal subbundle has degree zero.
While all $L_i$ remain horizontal, (O4) is exactly the usual
Langton modification by the maximal destabilizing subconnection
in EVERY component. The connection version of Langton's algorithm
terminates; see [Langer, Theorem5.1 and its proof](https://arxiv.org/pdf/1311.2794).
If all lines stayed horizontal forever, any one component would
contradict this termination, since (O3) supplies a positive
destabilizing line at every stage. Hence eventually some reduced
second fundamental form is nonzero.

The arbitrary lift used to invoke termination is not a proposed
common lift. Every modification is the intrinsic operation (O4)
on the original characteristic-$p$ Dieudonné crystal.

## One nonhorizontal line forces all components to be free opers

Let $I_i$ be the saturation of the generic image of
$\overline F_i$ in $\overline H_i$. It is a horizontal line with
zero $p$-curvature. It differs generically from $L_i$, since
$\overline V_i(L_i)\ne0$ and $VF=0$ modulo $\pi$. Consequently
\[
\deg I_i\le-d_i<0.
\tag{O6}
\]
On the ordinary open set the Hodge module is free, so the ordinary
local curvature calculation in the
[unramified proof](unramified_bt_genus_two.md) applies integrally
before reducing modulo $\pi$: in a Hodge basis it uses
$F(e)/p,F(a)$ and gives $\psi_i(u)=-c^pv$, $\psi_i(v)=0$.
Here $c$ is the preceding reduced second fundamental form.
Thus a nonzero preceding form gives nonzero reduced $p$-curvature
whose generic kernel is $I_i$.

If $L_i$ were horizontal, nilpotence would make its rank-one
$p$-curvature zero, so it would lie in $I_i$, contradicting (O6).
Nonzero second fundamental form therefore propagates around all
embedding components. The degree bound on a genus-two curve
makes every $d_i=1$ and every reduced form an isomorphism.

It remains to justify Hodge freeness over the WHOLE ring $R_i$.
The reduced Frobenius factors through a nonzero horizontal line map
\[
F_C^*(\overline H_{i-1}/L_{i-1})\longrightarrow I_i.
\tag{O7}
\]
Both lines have zero $p$-curvature; the source has its canonical
connection, and the target inherits zero curvature from the
image of Frobenius. By Cartier descent, the zero divisor of (O7)
is $p$ times an effective divisor. On the other hand its degree is
\[
\deg I_i+p d_{i-1}=\deg I_i+p\le p-1
\tag{O8}
\]
by (O6). It must be zero. Therefore $\overline F_i$ has rank one
at EVERY point.

Locally its integral matrix has a unit entry, and its determinant
is $p$ times a unit. Elementary row and column operations give
diagonal entries $1,p$. The kernel modulo $p$ is accordingly a
free rank-one $R_i$-module, precisely the Frobenius pullback of
the Hodge filtration. Faithfully flat Frobenius descent proves
the required Hodge freeness. The full modulo-$p$ second fundamental
form is an isomorphism by Nakayama, since its reduction is one.

This proves the ordinary assertion without any initial Rapoport
condition. The final section below then lifts the original span.

For the $F$-isocrystal formulation, Newton specialization puts all
slopes in $[0,1]$. The coefficient-preserving lattice construction
of [Krishnamoorthy--Pál, Lemma5.8](https://arxiv.org/pdf/1809.02106)
therefore supplies a Dieudonné lattice on the whole smooth curve:
its exceptional set has codimension at least two. To retain
$\mathcal O_K$, first sum a lattice under a finite integral basis
of $\mathcal O_K$, then perform the $F,V$ saturation and reflexive
hull operations. They commute with the integer action. The local
depth argument above gives coefficient freeness, and no Hodge
freeness is required at this stage. This proves the stronger
formulation and, with arithmetic companion compatibility, its
stated local-system consequence.

## Arbitrary component cycles: positive kernels without Hodge freeness

We remove the freeness restriction for every positive generic gap.
This extends the returned two-component height transfer and uses
neither ordinariness of the curve nor dormant-section vanishing.

Start with the coefficient-free Dieudonné lattices $\mathcal H_j$
and put $E_j=\mathcal H_j/\pi$. Their degrees are zero. Let $d_j$
be the valuation of $\det F_j$. The relation $FV=p$ prevents
horizontal determinant zeros. The generic unit-root direction
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

## Produce an oper while preserving both maps

If a positive line in some $E_j$ is nonhorizontal, the genus-two
degree lemma makes it an oper. Suppose this has not happened.
Every positive line in (G4) is then horizontal. Moving backwards
across a zero-height isomorphism, Cartier descent gives a positive
line in the preceding component. Repeating across each zero run
shows that every component has a positive horizontal maximal line
$L_j$. Uniqueness of a positive saturated line gives
$L_{j-1}=N_{j-1}$ at a positive-height step and
$F_j(F^*L_{j-1})=L_j$ at a zero-height step.

Make the simultaneous inverse-image modifications (O4). At a
positive-height step the reduced $F_j$ kills its source line, so
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
of $\pi$, so the heights are unchanged.

These are exactly the connection Langton modifications used in
(O4). If no oper appeared, they would continue indefinitely with
positive horizontal maximal lines at every stage, by (G4) and
zero-run descent. Termination rules this out. Thus at least one
component becomes an oper.

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

Put $s=\max_jd_j>0$. An edge of height $s$ leaves an oper.
Otherwise its nonoper source, unable to make a move, forces
the preceding edge to have height $e$. If $s<e$ this is impossible.
If $s=e$, continue backwards through height-$e$ edges until reaching
a protected oper, within one circuit. This terminal-state argument
is independent of the number of coefficient components.

## The outgoing maximum gives the whole partial Hodge line

Let the chosen height-$s$ edge leave oper component $i$. Its source
kernel is the oper line $L_i$, of degree one. At the next
positive-height step, (G3) gives
\[
0<\ell_k\le p^a-p^{a-1}\delta_{i+1}.
\]
Thus $\delta_{i+1}<p$. It is $p$-divisible and therefore zero.
The outgoing reduction has rank one at every point. Its determinant
is $\pi^s$ times a unit, so its elementary divisors are
$(1,\pi^s)$ everywhere.

The kernel of this actual outgoing map modulo $\pi^s$ is a line
subbundle of $F^*(\mathcal H_i/\pi^s)$. It is horizontal for the
canonical relative-Frobenius connection, since $p=0$ on the
constant coefficient thickening $A_i/\pi^s$. Relative Cartier
descent gives $L_s\subset\mathcal H_i/\pi^s$. Relative Frobenius
acts on the curve factor and fixes the constant nilpotent
coefficients; it is not absolute Frobenius on that coefficient ring.

Equivalently, the same elementary divisors identify $L_s$ with
the inverse image of the ACTUAL Hodge filtration under
$\mathcal H_i/\pi^s\simeq\pi^{e-s}\mathcal H_i/p$.
Its Frobenius pullback is the true Hodge kernel modulo $p$.
Reduction of $L_s$ is $L_i$, so Nakayama makes its second
fundamental form an isomorphism over the whole thickening.

All steps have height at most $s$. The uniform
[Frobenius Taylor estimate](frobenius_taylor_thickness.md) makes
$n=s$ sufficient, since $(p-1)s>s$ for $p>2$. No divided powers
on $(\pi^s)$ are assumed. A common coefficient homothety places
the final lattices inside the initial ones if desired, without
changing heights or oper data.

## A totally ramified coefficient and the thickness supplied by its slope gap

Now let $f=1$ and let the generic slopes be $(0,a/e)$, with
$1\le a\le e$. Write $\pi$ for a coefficient uniformizer.
In the rational crystal set
\[
V_a=\pi^a F^{-1}.
\tag{T1}
\]
Newton specialization puts the slopes of $F$ in $[0,a/e]$,
so both $F$ and the inverse-Frobenius operator $V_a$ have
nonnegative slopes. The integral lattice construction used above
works with $V_a$ in place of $V$: its saturation is coherent, and
$FV_a=V_aF=\pi^a$ preserves $F$-stability. After reflexive hull,
it gives a coefficient-free lattice stable under both operators
on the whole smooth curve. Since $a\le e$, it is also stable
under the usual $V=pF^{-1}$ and thus realizes a full BT group.

Its determinant Frobenius is $\pi^a$ times a unit. The reduced
Hodge kernel $L$ defined as in (O1) is a positive line. To check
positivity here, use the generically nonzero map
$V_a|L:L\to F_C^*L$. At the generic point the two slope pieces
each have coefficient rank one, and $V_a$ is a unit on the
slope-$a/e$ piece. If this map were a unit everywhere, every
fiber would retain that slope and the complementary slope zero.
Nonconstancy supplies a zero; hence $(p-1)\deg L>0$.
The reduction of $F$ kills $F_C^*L$, and that of $V_a$ maps $L$
into $F_C^*L$. These inclusions can be checked at the generic
point and extended because the lines are saturated.

When $L$ is horizontal, its Langton modification is therefore
stable under $F,V_a$. Repeating this actual lattice construction
must terminate as before. The resulting line has nonzero second
fundamental form, and genus two forces its degree to be one.
The saturated reduced Frobenius image is a different negative
Cartier line. The defect calculation (O7)--(O8) applies unchanged:
the divisor is $p$-divisible with degree at most $p-1$, and vanishes.
Consequently the integral Frobenius has elementary divisors
\[
(1,\pi^a)\quad\text{at every point}.
\tag{T2}
\]

Here (T2) does not give a free Hodge line modulo $p$ when $a<e$.
It gives exactly the smaller initial thickening that is needed.
Identify $\mathcal H/\pi^a$ with
$\pi^{e-a}\mathcal H/p\mathcal H$ by multiplication by
$\pi^{e-a}$, and let $L_a$ be the inverse image of the ACTUAL
Hodge filtration under this identification. This makes sense
because the Hodge filtration is annihilated by $\pi^a$.
Indeed its Frobenius pullback is the kernel of $F$ modulo $p$;
(T2) identifies that kernel with a free line over $A/\pi^a$,
multiplied by $\pi^{e-a}$. Faithful flatness of $F_C$ then proves
that $L_a$ is a line subbundle of $\mathcal H/\pi^a$.

Its reduction is $L$, so its second fundamental form is an
isomorphism over the entire ring $A/\pi^a$, by Nakayama.
Equation(T2) supplies a SINGLE Frobenius of height $a\le e$ on
this component. The
[Frobenius Taylor theorem](frobenius_taylor_thickness.md) bounds
its $j$th Taylor coefficient below by $-a\lfloor\log_pj\rfloor$.
At a curve displacement of valuation $n\ge a$, every nonlinear
term therefore has valuation strictly greater than $n$.
The integral gluing and oper obstruction argument apply to the
full line $L_a$ just constructed. They give the simultaneous
lift for EVERY $a/e>0$ in this statement, without a divided-power
condition on $(\pi^a)$ or a hypothetical extension of its residue
line.

One further property of the construction is useful independently. If
$a<e$, take an integral basis $(e_0,b_0)$ adapted to $L_a$.
Then $u=F(e_0)/\pi^a$ and $v=F(b_0)$ are a basis by (T2).
For a local Frobenius lift $t\mapsto t^p$, horizontality shows
that the off-diagonal term of $\nabla u$ has factor $p/\pi^a$,
and all remaining terms have a factor $p$. Both are divisible
by $\pi$ when $a<e$. Thus $u,v$ are horizontal modulo $\pi$
and the reduced connection is dormant. This explains the earlier
boundary case of the crystal-only divided-power argument; the
Frobenius estimate now removes that threshold entirely.

## A nonzero form over a thickened coefficient field

First prove the degree lemma. Write $M_R=H_R/L_R$ and let
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

## Reduced partial Hasse maps have positive Hodge degrees

The freeness hypothesis permits a Hodge basis in each component.
At a rank-one component, strong divisibility gives an integral
basis of the next component of the form
\[
F(e)/p,\quad F(a),
\]
where $e$ lifts its Hodge generator. In particular the local
elementary divisors of this Frobenius step over $A_i$ are $(p,1)$,
not $(\pi,1)$. At a zero-Hodge component the step is an integral
isomorphism. These assertions also follow from the exact Hodge
and conjugate sequences of the Dieudonné crystal: both Hodge
modules are free over $R_i$, so the elementary Hodge bases lift.

Reduce modulo $\pi$. Write $H_i$ for the resulting rank-two bundle,
and $L_i,M_i$ for its Hodge subbundle and quotient. The conjugate
sequence gives $\deg H_i=p\deg H_{i-1}$, including the zero-Hodge
indices. Cycling implies $\deg H_i=0$ for all $i$.

Call a Hodge-rank-one index active. For consecutive active indices
$j,i$, let $a_i$ be their cyclic distance. Composing the intervening
zero-Hodge isomorphisms gives a Frobenius map with elementary
divisors $(p,1)$. Its complementary map $pF^{-1}$ yields the
reduced exact sequence
\[
0\longrightarrow F_C^{a_i*}M_j\longrightarrow H_i
\longrightarrow F_C^{a_i*}L_j\longrightarrow0.
\tag{1}
\]
The end terms have their Cartier connections, and the maps are
horizontal. In particular the reduced $p$-curvature is nilpotent.
Restrict the right arrow to $L_i$ to obtain
$h_i:L_i\to F_C^{a_i*}L_j$.

At the geometric generic point the slope-zero part has coefficient
rank one. After passing to its perfection, it splits from the
connected part. The latter supplies the Hodge line at every active
index, and the complementary map in (1) is invertible on it.
Thus every $h_i$ is generically nonzero.

If all $h_i$ were everywhere nonvanishing, the rank-one reductions
of the active Frobenius steps would compose nontrivially around
every cycle. Their iterates would retain a coefficient-rank-one
étale part in every fiber. The remaining coefficient-rank-one
part has slope $r/f$, by its dimension. Every fiber would then
have the generic Newton polygon, contrary to hypothesis.
Therefore some $h_i$ has a zero.

Put $d_i=\deg L_i$. The inequalities $d_i\le p^{a_i}d_j$ around
the active cycle, whose total distance is $f$, imply $d_i\ge0$.
If one degree were zero, all would be zero and every nonzero
$h_i$ would be nowhere vanishing. Consequently
\[
d_i>0\qquad\text{at every active index}.
\tag{2}
\]

## Untwist the whole Hodge filtration, then use the degree lemma

If the WHOLE Kodaira--Spencer map over the rings $R_i$ is zero,
apply intrinsic Frobenius untwisting. The construction in
[Lam, Lemma4.2](https://arxiv.org/pdf/2210.13563) takes the inverse
image of the Hodge filtration in the integral Dieudonné crystal.
It preserves the integer action and gives $G\simeq F_C^*G_1$
within its isogeny class. As explained in the
[unramified proof](unramified_bt_genus_two.md), this intrinsic
construction glues on a proper curve.

The freeness assumptions descend along the faithfully flat map
$F_C$, so they still hold for $G_1$. The active indices are permuted
and their reduced degrees divided by $p$. By (2), their positive
integer sum strictly decreases. Thus after finitely many steps
there is a nonzero component of the whole second fundamental form.

Apply the first section to that component. Its reduced Hodge
degree is positive, and (1) supplies nilpotent $p$-curvature.
The degree is one and the Hodge line is an oper over ALL of $R_i$.
This is stronger than obtaining an oper only modulo $\pi$.

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

The outgoing-maximum construction supplies the whole line over
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
