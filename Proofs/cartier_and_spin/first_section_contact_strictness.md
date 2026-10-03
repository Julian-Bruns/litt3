# Proof: the fixed two-form net excludes sharp first contact

Version5,2 October2026. [Focused whole-argument review](../../Research/audits/FIRST_SECTION_CONTACT_BOUND_AUDIT_2026_10_02.md) PASS for Version4. The primary new bound is the stable-J argument after the zero-quotient helpers. The independent kernel-intersection, horizontal-closure and integral-splitting proofs are retained; no new calculation is used.
[Statement](../../Theorems/cartier_and_spin/first_section_contact_strictness.md).

## All geometric planes in the fixed original net

The original exact forms are $q_i\theta$, $\theta=dx/y^2$, where
$y^3=P(x)$ and the ascending coefficient codes are
\[
P=(11,22,18,5,19,20,15,16,9,22,1),
\quad q_0=(24,2,1),\quad q_1=(5,16,0,1),
\quad q_2=(5,20,0,0,8,1).
\]
The code $a+5b$ denotes $a+b\beta$ in $\mathbf F_{25}$,
$\beta^2=\beta+3$. The original image $I\simeq O_X^3$ has
saturation $U$ of rank three and degree thirteen. Its elementary
divisors are $(0,0,1)$ at the ten finite cubic branch points and
$(0,1,2)$ at infinity, and nowhere else.

Let $W$ be any constant two-dimensional subspace of the original
three-section space, with nonzero covector $c=(c_0,c_1,c_2)$, and
let $E_c$ be its saturation in $U$, equivalently in $B_X$.
The rational covector gives $U/E_c=O_X(D_c)$, containing the image
$O_X$ of $I$. At a cubic branch $r$ it has a simple pole unless
$c$ annihilates the original lost direction. The first two primitive
rows at that branch are proportional to $(q_i(r))$ and
$(q_i'(r))$ modulo a multiple of the first row. Thus, after transporting
through the SAME relative Frobenius, annihilation is exactly
\[
\sum_i c_i^5\,v_i(r)=0,
\quad
v=(q_1q_2'-q_2q_1',\ q_2q_0'-q_0q_2',\ q_0q_1'-q_1q_0').
\]
The fifth-power coefficient transport matters for the frame, but
$c\mapsto c^5$ is a bijection on ALL geometric covectors; its zero
coordinates are unchanged.

At infinity the primitive orders of the three original columns are
$11,8,2$. Dividing the first by the square of a Frobenius-target
uniformizer and the second by that uniformizer gives independent
saturated orders $1,3,2$. Therefore the pole order of the covector
on $U$ is exactly
\[
a(c)=2\ (c_0\ne0),\quad
a(c)=1\ (c_0=0,c_1\ne0),\quad
a(c)=0\ (c_0=c_1=0).
\]
If $z(c)$ is the number of branch roots annihilated above, then
\[
\deg E_c=13-\deg D_c=3+z(c)-a(c).
\]

The NEW bounded computation
[source](../../scripts/oct02_global_kernel_net_degree_gate.sage)
and [exact certificate](../../../litt3-computation-data/oct02_global_kernel_net_degree_gate/certificate.json)
prove the following finite facts in $\mathbf F_{5^8}$:

- $P$ has ten distinct roots, and all ten loss vectors $v(r)$ are nonzero.
- All forty-five pairs of loss vectors are independent.
- Their forty-five normalized pair-annihilators are distinct, each
  annihilates precisely its defining two roots, forty-four have
  $a=2$, and the remaining one has $a=1$.

These facts cover geometric covectors over the ENTIRE algebraic
closure: a covector annihilating at least two roots is the unique
projective annihilator of one of those pairs. All other covectors
have $z\le1$ and hence $3+z-a\le4$. The forty-five pair cases have
degrees three or four. Consequently
\[
\deg E_c\le4\quad\text{for every geometric constant two-form plane}.
\]
The certificate records the finite-field modulus, embedded $\beta$,
all roots and loss vectors, and the forty-five exact covectors and
their annihilation supports. It uses no field arithmetic table or
geometric parameter sampling. The producer's assertions check the
complete pair independence and direct annihilation counts; its
executed output is forty-five distinct covectors, forty-four degree
three cases and one degree-four case. All arithmetic ran on one
thread. An initial JSON serialization error was corrected and the
successful run serialized the complete certificate; the calculation
made no assumption from that failed output.

## Actual kernel intersections give the uniform contact bound

The [stable Frobenius kernel](cartier_generated_frobenius_hn.md)
$\mathcal H_X=\ker(F^*U\to\omega_X)$ has rank two, degree forty-nine,
and stays semistable after etale pullback. Take the actual one-leg
Galois closure $q:T\to Y$, of degree $8d$, with conjugate actual maps
$h_i:T\to X$ of degree $d$. Put $r=t/n$.

The complete first trace $q^*J$ is globally generated: its actual
finite etale presenting coefficient splits into trivial summands.
Its Frobenius evaluation is surjective onto $\omega_T$. Indeed every
fiber of the original degree-$8n$ genus-two leg has a non-infinity
sheet, since the whole infinity pullback has degree only $n$.
At every finite point the original exact forms already evaluate onto
the canonical line. Thus
\[
\mathcal A_J=\ker(F_T^*q^*J\to\omega_T)
\quad\text{has rank three and degree }40d-16d=24d.
\]

Let $\mathcal H_i=h_i^*\mathcal H_X$ and
$\mathcal H_i'=\mathcal H_i\cap\mathcal A_J$.
The latter has the SAME generic plane as $\mathcal H_i$, because
$\mathcal A_J$ and the full Cartier evaluation kernel both have the
same generic rank-three fiber. It is saturated in $\mathcal A_J$.
Flat Frobenius pullback preserves the original contact intersection,
so $F^*(h_i^*U\cap q^*J)$ has degree $65d-5rd$.
Its evaluation image is $\omega_T(-D_i)$ for an effective divisor;
retaining this possible zero contribution gives
\[
\deg\mathcal H_i'=49d-5rd+\deg D_i\ge(49-5r)d.
\]
No false equality of kernel loss and five times contact loss is used.

For distinct generic planes their intersection line consequently has
degree at least
\[
\deg(\mathcal H_i'\cap\mathcal H_j')
\ge2(49-5r)d-24d=(74-10r)d.
\]
The planes cannot all be identical: their saturations in the full
Cartier kernel would then be the identical $\mathcal H_i$, descending
with impossible degree $49/8$. In a three-dimensional generic space,
a family of distinct two-planes either has a common line, or THREE
of its pair-intersection lines are independent. For the latter
assertion choose two planes with intersection $M_{12}$ and a third
not containing that line; its intersections with the first two span
the third plane, while $M_{12}$ lies outside it.

Suppose $r<33/5$. Then $74-10r>8$. Three independent intersection
lines would inject into the rank-three bundle $\mathcal A_J$ with
total degree strictly greater than $24d$, impossible. Hence all
the generic kernel planes have a common line. Saturate it inside
$\mathcal A_J$, obtaining $M$. This is deck invariant and descends
to a line $M_Y$ on $Y$, of integral degree $m$. Its lower bound
$\deg M>8d$ gives $m\ge2$. It lies in every saturated
$\mathcal H_i$, whose semistability gives
$\deg M\le49d/2$, hence $m\le49/16$ and
\[
m=2\quad\text{or}\quad m=3.
\]

Take the smallest canonical-connection-stable generic subspace of
$F_Y^*J$ containing $M_Y$, and saturate it in $F_Y^*J$.
Cartier descent identifies the resulting horizontal subbundle as
$F_Y^*W$ for a saturated subbundle $W\subset J$. This also lies
in every actual $F^*h_i^*U$, which is horizontal and saturated in
the full Frobenius Cartier bundle. Its rank cannot be one: $m=2,3$
is not divisible by five. Rank three would make all the generic
$h_i^*U$ equal; their saturation would descend with impossible
degree $13/8$. Thus its rank is two.

Evaluation on this nonzero subobject is nonzero, by Frobenius
adjunction for the inclusion $W\subset B_Y$. Its evaluation kernel
is exactly $M_Y$, since $M_Y$ is already saturated in $F_Y^*J$.
Write its image as $\omega_Y(-D)$, $D$ effective. The second
fundamental map of $M_Y$ in its rank-two horizontal closure is
nonzero, and gives
\[
m\le4-\deg D,\qquad
5\deg W=m+2-\deg D.
\]
For $m=2$, the first inequality forces $\deg D\le2$, and the second
integer lies between two and four, contradicting divisibility by five.
For $m=3$, the inequalities force $D=0$ and $\deg W=1$.
Stability of $B_Y$ makes this degree-one plane saturated in $B_Y$.
It lies inside all the actual $h_i^*U$.

Now $J/W$ has rank two and degree zero. It is globally generated
after the same one-leg etale closure, hence its pullback is $O_T^2$.
Each original three-section image $h_i^*I\simeq O_T^3$ maps to it
by a constant matrix of generic rank one. Its constant two-dimensional
kernel has saturation exactly $q^*W$ in $B_T$. Etale pullback
preserves saturation, so this is the pullback of a geometric constant
two-form plane on $X$, whose degree must be
\[
\deg(q^*W)/\deg h_i=8d/d=8.
\]
This contradicts the complete net bound $\deg E_c\le4$ above.
Consequently $r<33/5$ is impossible, proving the stated uniform
contact bound.

At the boundary a common line may have degree one. Its horizontal
closure has $\deg D=3$ and $\deg W=0$, with Frobenius grades $1,-1$
and nonzero second fundamental map an isomorphism. Here W is
saturated in J; saturation in the WHOLE $B_Y$ is not automatic.
The following quotient argument excludes this common-line boundary
without assuming that extra property. The subsequent integral
splitting excludes the noncommon triangle as well.

## One-form saturation and zero-quotient contact bounds

For a nonzero constant original form $q\theta$, write
$q=c_0q_0+c_1q_1+c_2q_2$. The three displayed derivatives have
distinct degrees one, two and three and nonzero leading terms;
thus $q'\ne0$ for every nonzero combination. At an ordinary finite
point a horizontal B-zero requires form order at least five. Since
$\deg q\le5$, this forces a fifth-power polynomial and $q'=0$,
impossible. Form order four is itself forbidden by Cartier-zero
exactness. Therefore there are no ordinary finite B-zeros.

At a cubic branch a root of multiplicity k has primitive order
$3k+1$. Multiplicity three is forbidden by exactness, because the
leading form order nine is congruent to four modulo five.
Multiplicity five again forces $q'=0$. Multiplicity two contributes
one horizontal zero, and multiplicity four contributes two. For
$c_2\ne0$ the finite contribution is at most two and the infinity
primitive order two contributes zero. For $c_2=0,c_1\ne0$ the
polynomial degree is three, so the finite contribution is at most
one; the infinity primitive order eight contributes one. Finally
$q_0$ is squarefree, with discriminant code23, and its primitive
infinity order eleven contributes two. Hence
\[
\deg\operatorname{Sat}_{B_X}(k\cdot q\theta)\le2
\quad\text{for every geometric original one-form line}.
\]

Let Q be a degree-zero vector-bundle quotient of J, and let E be its
kernel. The SAME one-leg closure makes $q^*Q$ trivial: it is a
globally generated degree-zero bundle. Thus $\deg E=1$.
Rank $Q\ge3$ is impossible, since E would have rank at most one,
contrary to stability of $B_Y$ of slope one.

If $\operatorname{rank}Q=1$, each original constant map
$h_i^*I=O_T^3\to q^*Q=O_T$ has rank one. It cannot vanish: the
conjugate maps have equal rank and together generate $q^*J$.
The rank-two intersection $q^*E\cap h_i^*U$ is generated
generically by its constant two-dimensional kernel, so its degree
is at most $4d$ by the full net bound. Its quotient in $q^*E$ is
torsion-free, because $h_i^*U$ is saturated in $B_T$. This line,
of degree at least $8d-4d=4d$, injects into
$q^*J/(q^*J\cap h_i^*U)$, of degree $rd-5d$. Therefore $r\ge9$.

If $\operatorname{rank}Q=2$, its kernel E is a degree-one plane
saturated in $B_Y$: stability bounds a rank-two saturation's degree
strictly below two. Each original constant matrix has rank two.
Rank one would make its constant two-form kernel saturate to
$q^*E$ of degree $8d$, contrary to the net bound $4d$.
Its one-dimensional constant kernel has saturation degree at most
$2d$ by the one-form bound. The line
$q^*E/(q^*E\cap h_i^*U)$ consequently has degree at least $6d$
and injects into the same quotient of degree $rd-5d$. Thus $r\ge11$.
This proves both zero-quotient bounds with the actual unsaturated
J retained throughout.

## Stability of the actual J gives the stronger bound seven

Suppose $r<9$. The zero-quotient bounds exclude every degree-zero
vector-bundle quotient of J. The bundle J is nef: after the actual
etale closure it is globally generated. It is also stable of slope
one quarter. Indeed a destabilizing subline would have degree at
least one, impossible in the stable $B_Y$ of slope one. A
destabilizing rank-two or rank-three subbundle would have integral
degree at least one, so its quotient would have nonpositive degree.
Nefness excludes negative degree, and degree zero was just excluded.

Etale pullback preserves semistability. Thus $g^*J$ on the ORIGINAL
source has slope $2n$, and its rank-three subbundle
$L=h^*U\cap g^*J$ has degree at most $6n$. Since
$\deg L=13n-t$, this gives $t\ge7n$. The complementary case
$r\ge9$ already satisfies that bound. Consequently the bound seven
holds in every covering degree, with no hypothesis on the generic
kernel-plane configuration.

At $r=7$ the subbundle L has the SAME slope as $g^*J$.
Stability of J does not force stability after an arbitrary etale
pullback, so an equal-slope subbundle or splitting here is not an
automatic contradiction. This boundary remains open.

## A common degree-one kernel line forces contact at least nine

Suppose the common descended kernel line has degree one. Its
horizontal closure is a rank-two degree-zero bundle W saturated in
J and contained in every actual source U, as above. Put $Q_0=J/W$;
it has rank two and degree one. It is nef after the same etale cover,
being a quotient of the globally generated $q^*J$.

If $r<9$, the rank-one zero-quotient bound excludes a degree-zero
line quotient of J. Therefore $Q_0$ is stable: a destabilizing
subline would have degree at least one and quotient of nonpositive
degree; nefness forces degree zero, yielding the excluded quotient
of J. Etale pullback preserves semistability, so $q^*Q_0$ has
slope $4d$.

But $L_i=q^*J\cap h_i^*U$ contains $q^*W$ as a saturated
subbundle, and the line $L_i/q^*W\subset q^*Q_0$ has degree
$(13-r)d>4d$. This contradicts semistability. Thus $r\ge9$ in
the common degree-one kernel-line branch. In particular the common
line at $r=33/5$ is excluded. No saturation of W in B was used.
The next argument treats the noncommon triangle at that boundary.

## The noncommon triangle equality forces an impossible horizontal summand

Suppose $r=33/5$ and the generic kernel planes have no common line.
Choose three planes whose pair-intersection lines are independent.
Each line has degree at least $8d$, whereas their ambient
$\mathcal A_J$ has degree $24d$. Their direct sum consequently
maps isomorphically to $\mathcal A_J$: its determinant divisor has
nonnegative degree, forcing each line to have degree exactly $8d$
and the divisor to be zero. Write the resulting decomposition as
\[
\mathcal A_J=M_{12}\oplus M_{13}\oplus M_{23},
\qquad\deg M_{ij}=8d.
\]
This bundle is polystable of slope $8d$. Every actual kernel plane
$\mathcal H_i'$ has degree at least $16d$; polystability bounds it
by $16d$. Thus every one has degree exactly $16d$ and its evaluation
zero divisor $D_i$ is zero.

Put $V_i=F_T^*(h_i^*U\cap q^*J)$, a horizontal rank-three
subbundle of $\mathcal E=F_T^*q^*J$. At equality its degree is
$32d$, its kernel of evaluation is $\mathcal H_i'$, and its
evaluation surjects onto $\omega_T$, of degree $16d$. Therefore
\[
N_i=\mathcal E/V_i\simeq\mathcal A_J/\mathcal H_i'
\quad\text{is a line of degree }8d.
\]
For the three chosen planes, each kernel plane is exactly the direct
sum of its two pair-intersection lines. Their quotient maps
$\mathcal E\to N_1\oplus N_2\oplus N_3$ hence restrict to an
isomorphism on $\mathcal A_J$. This gives an INTEGRAL global
splitting, not merely a splitting of generic vector spaces:
\[
\mathcal E=\mathcal A_J\oplus\Omega,
\qquad \Omega\simeq\omega_T.
\]
For EVERY conjugate index i, the quotient map
$\mathcal E\to N_i$ vanishes on $\Omega$, since
$\operatorname{Hom}(\omega_T,N_i)=0$ by degrees $16d>8d$.
Thus all horizontal $V_i$ contain $\Omega$. Their generic
intersection is exactly this line: inside $\mathcal A_J$ their
planes have no common line. Consequently $\Omega$ itself is
horizontal, being the saturated intersection of horizontal
subbundles.

The splitting complement is unique because
$\operatorname{Hom}(\omega_T,\mathcal A_J)=0$; equivalently its
description as the intersection of the full actual deck orbit makes
it deck invariant. It descends through the SAME etale map q to a
horizontal line in $F_Y^*J$, whose evaluation is an isomorphism
onto $\omega_Y$. Cartier descent identifies it with $F_Y^*K$ for
a line bundle K. But then
\[
5\deg K=\deg\omega_Y=2,
\]
impossible. This excludes the noncommon equality triangle.

The common-line equality was excluded above. Combined with the
strict-below-bound argument, this proves $r>33/5$ on the ORIGINAL
source, without any claim that the remaining larger contacts or the
unmarked problem are decided.

## A separate direct proof excluding the former equality sector

On the ORIGINAL source put $L=h^*U\cap g^*J$. It is saturated in
$g^*J$: its quotient embeds in the line bundle $B_S/h^*U$.
Thus $g^*J/L$ is a rank-one bundle, a quotient of the finite etale
coefficient presenting $J$. Such a quotient has nonnegative degree.
Since $\deg U=13$, $\deg J=1$, one obtains
\[
0\le\deg(g^*J/L)=8n-13n+t=t-5n.
\]
This proves $t\ge5n$ with the actual unsaturated trace $J$ retained.

Suppose equality holds. Take a connected Galois closure $q:T\to Y$
of the ONE genus-two leg, of degree $8d$, with its actual conjugate
maps $h_i:T\to X$ of degree $d$. Etale flat pullback preserves
the intersection and its length, so each
$L_i=q^*J\cap h_i^*U$ has degree $8d$, and $q^*J/L_i$ has degree
zero. The pullback $q^*J$ is globally generated: the actual
coefficient $g_*O_S^3$ splits into trivial summands on this closure,
and its complete image is precisely $q^*J$. Therefore every such
degree-zero line quotient is $O_T$.

Let $r=h^0(T,(q^*J)^\vee)$. All its global dual sections give a
surjection $q^*J\to O_T^r$. Indeed a nonzero dual section gives
a nonzero map to $O_T$, whose image is globally generated and
therefore is the whole $O_T$. If an independent collection became
dependent at one point, a nonzero constant combination would vanish
there, contradicting this surjectivity. Its kernel $E_T$ has degree
$8d$ and rank $4-r$. The construction is deck invariant, hence
descends to $E_Y\subset J$, of degree one. Every $L_i$ contains
$E_T$ because it is the kernel of one of the global dual sections.

There is at least one dual section, so $\operatorname{rank}E_Y\le3$.
Rank zero is impossible by its positive degree. Rank one is
impossible because $B_Y$ is stable of slope one, and saturating
$E_Y$ would give a line of degree at least one in $B_Y$.
If its rank were three, $r=1$ and all $L_i$ would be the same
kernel. Thus all the generic $h_i^*U$ would coincide. They are
saturated in $B_T$, so they would be the same bundle and descend
through $q$, of impossible degree $13/8$ on $Y$. Consequently
\[
\operatorname{rank}E_Y=2,\qquad\deg E_Y=1.
\]
The saturation of this plane in $B_Y$ still has degree one: stability
of $B_Y$ bounds a rank-two subbundle's degree strictly below two.
Hence $E_Y$ itself is saturated in $B_Y$.

## A constant original two-form plane of impossible degree

For each actual conjugate map $h_i$, the original three-section
image $h_i^*I\simeq O_T^3$ maps to the trivial rank-two quotient
$q^*J/E_T=O_T^2$. This is a constant matrix on the proper connected
curve $T$. Its generic rank is one: its generic image before this
quotient is $h_i^*U$, which contains $E_T$ and has rank three.
Its kernel is therefore a CONSTANT two-dimensional subspace of
the ORIGINAL three-form space.

The saturation of that constant two-space inside $B_T$ is exactly
$E_T$, since $E_T$ is saturated and the kernel generates it
generically. Etale pullback preserves saturation. It follows that
$E_T=h_i^*E_c$ for a geometric constant two-form plane on $X$.
Comparing degrees gives
\[
d\deg E_c=\deg E_T=8d,\qquad\deg E_c=8,
\]
contradicting the exact bound $\deg E_c\le4$. Equality $t=5n$ is
therefore impossible by this independent special-case argument.
The preceding kernel-intersection proof strengthens this to the
uniform strict original-source bound $t>33n/5$.

No two-leg simultaneous closure, presumed X-descent of a Y-section,
or marked admissible line was used. The common-cover question and
degree-one contacts strictly above $33n/5$ remain open.
