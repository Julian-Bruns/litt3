# Proof: the filtration obstruction is exactly the curve obstruction

[Statement](../../Theorems/deformations/crystalline_oper_lifting.md).
All crystals and special-fiber markings are fixed throughout.

## One square-zero Witt step

Put $M=H/L$ and $T_C=\omega_C^{-1}$. The second fundamental form is
equivalently an isomorphism
\[
\kappa:T_C\xrightarrow{\sim}\mathcal Hom(L,M).
\tag{1}
\]
Suppose that a smooth marked curve $C_n/W_n$ and a line $L_n$ in the
evaluation $H_n$ of the crystal have been constructed. Consider
$W_{n+1}\to W_n$, whose kernel is the one-dimensional $k$-module
$I=p^nW_{n+1}$.

A lift of $C_n$ exists because its obstruction lies in
$H^2(C,T_C)\otimes I=0$. Its marked isomorphism classes form a torsor
under $H^1(C,T_C)\otimes I$. On any such lift $C_{n+1}$ the crystal
has a specified vector-bundle evaluation $H_{n+1}$: the embedding
$C\hookrightarrow C_{n+1}$ has the canonical divided powers on $(p)$.
Lifting the line $L_n$ is the section-lifting problem for the smooth
relative flag scheme of $H_{n+1}$. Its obstruction is
\[
o(C_{n+1},L_n)\in H^1(C,\mathcal Hom(L,M))\otimes I.
\tag{2}
\]
If it vanishes, its line lifts form a torsor under the corresponding
$H^0$. These assertions also follow directly by choosing local lifted
generators of $L_n$ and projecting their overlap differences to $M$.

We need the effect on (2) of changing the curve lift. Choose an affine
cover and identify the two lifts on each open. Their overlap gluing
differs by $1+p^n\delta_{ij}$, for a Čech cocycle of vector fields.
The crystal identifies its two evaluations by its Taylor isomorphism.
Modulo the square-zero ideal this is
$1+p^n\nabla_{\delta_{ij}}$. On a local generator of $L$ its component
in $M$ is $p^n\kappa(\delta_{ij})$. Thus the difference of the two
obstructions is, with consistent Čech signs,
\[
o(C'_{n+1},L_n)-o(C_{n+1},L_n)
=H^1(\kappa)([\delta]).
\tag{3}
\]
Only the linear Taylor term contributes here. This uses the fixed
crystal, not a freely chosen lift of a connection. Since $p>2$, it
also agrees with the canonical divided-power Taylor comparison in
the first Witt step.

By (1), exactly one curve-lift class kills (2). The line lift is unique
because $H^0(\mathcal Hom(L,M))=H^0(T_C)=0$. The same vanishing removes
marked infinitesimal curve automorphisms. This proves existence and
uniqueness of the next marked curve-line pair.

## Induction and algebraization

Starting at $C_1=C$, iterate the preceding argument. The crystal is
available at every Witt precision, so its evaluations and Taylor maps
remain specified at every step. There is no separate choice of a
crystal or connection at higher precision. This gives the unique
compatible formal curve and line. With only a $W_m$-crystal the identical
argument stops at $m$.

The relative canonical bundle is ample because $g(C)\ge2$. Formal
existence therefore algebraizes the formal curve. Its crystal evaluation
is a compatible system of vector bundles, and formal GAGA algebraizes
it and its line subbundle. The resulting algebraization is smooth and
proper. Uniqueness is meant relative to the fixed special-fiber marking
and fixed crystal, not relative to an arbitrary lift of the bundle.

This is the filtration part of the deformation mechanism in
[Xia, Sections3--4](https://arxiv.org/pdf/1303.2954), but the Čech
calculation shows explicitly that a rank-two integral crystal suffices.
No Frobenius-stable summand and no group realization were used.

## Both actual maps

For a finite étale map $D\to C$, lift the cover over the unique curve
lift just constructed and pull back the crystal and its lifted line.
The pulled-back second fundamental form is again an isomorphism,
because $\omega_D$ is the pullback of $\omega_C$. Uniqueness identifies
this curve lift with the one obtained directly from the crystal-line
pair on $D$.

Apply this to the two maps of the actual span. Their endpoint lifts
give two marked lifts of the source, each carrying a lift of its SAME
specified crystal-line pair. Uniqueness identifies those sources and
puts both finite étale maps on that one curve. The marked identifications
are unique and hence compatible at all Witt levels.

If compatibility is supplied only after an étale refinement, use
[the marked refinement equivalence](etale_refinement_deformations.md)
to descend the lifted diagram to the original source. This preserves
the original endpoint maps. No simultaneous Galois closure is assumed.

## A rationally compatible lattice descends from one endpoint

First observe that an oper reduction $(H,\nabla,L)$ is stable as
a bundle with connection. Any saturated horizontal line $B\subset H$
differs from $L$, since its second fundamental form is zero while
that of $L$ is an isomorphism. Projection to $M=H/L$ is therefore
nonzero, so
\[
\deg B\le\deg M=\frac{\deg H}{2}-(g(C)-1)<\mu(H).
\tag{4}
\]
This remains true after any finite étale pullback, which is again
an oper. Also $L$ is the unique maximal-degree line subbundle:
any other line maps nontrivially to $M$ and has strictly smaller degree.

Let $\mathcal H_1,\mathcal H_2$ be two lattices in the same rank-two
isocrystal, with oper reductions of equal degree. Multiply their
rational identification by the smallest power $p^a$ which gives
an integral morphism of crystals. Such a bound exists by
quasi-compactness. Its mod-$p$ reduction is a nonzero horizontal map.
A nonzero horizontal map between the stable connections (4) of the
same slope is an isomorphism: a rank-one map would have a positive-slope
quotient of the source inside a negative-slope subobject of the target.
A full-rank map is an isomorphism because its determinant is a nonzero
section of a degree-zero line bundle. Nakayama, at every Witt level,
now gives
\[
\mathcal H_2=p^a\mathcal H_1
\tag{5}
\]
inside the isocrystal, with a choice of sign for $a$ according to
the direction of the identification.

Now pull the given oper lattice from $Y$ to a connected Galois closure
$W\to X$ of the single finite étale map $Z\to X$. Use the given
rational isomorphism to view that lattice, denoted $\mathcal H_W$,
inside the pullback of $\mathcal E_X$. The latter has its actual
Galois descent datum. For every deck transformation $\gamma$, both
$\gamma^*\mathcal H_W$ and $\mathcal H_W$ are oper lattices and
their reductions have equal degrees. Equation(5) gives
\[
\gamma(\mathcal H_W)=p^{a(\gamma)}\mathcal H_W.
\]
The rational descent datum is a genuine cocycle. Hence $a$ is a
homomorphism from the finite deck group to $\mathbf Z$, and is zero.
Thus the lattice itself, not merely its homothety class, is invariant.
Effective finite étale descent gives an integral crystal on $X$.
The unique maximal line in its oper reduction descends as well.

On the original source its pullback is the specified lattice from
$Y$, by faithfully flat descent from $W$. The two endpoint oper
lattices are now integrally compatible, so the preceding lifting
argument applies. This uses a Galois closure of ONE leg only;
the two endpoint maps and the original common source remain the
objects eventually lifted. No division by the deck-group order occurs.

## A nonreduced characteristic-p base removes the ramification restriction

Let $A/W(k)$ and $R=A/p$ be as in the extended statement. Work with
the base divided powers on $(p)$, not on a uniformizer ideal.
For $A_n=A/p^n$, every square-zero step has kernel
\[
p^nA/p^{n+1}A\simeq R.
\]
The construction in (1)--(3) works over $R$ itself: deformations of
the smooth curve $C_0/R$ across this step are controlled by
$T_{C_0/R}$, and lifting its line is controlled by
$\mathcal Hom(L,H/L)$. The specified oper map identifies these
two sheaves. Their $H^0$ vanishes, by filtering $R$ by powers of
its maximal ideal and using $H^0(T_C)=0$ on the reduced fiber.
There is no $H^2$ on a curve.

The Taylor comparison remains linear. For a change $p^n\delta$,
the $j$th term has coefficient valuation at least
$nj-v_p(j!)\ge n+1$ for $j\ge2$, $n\ge1$, $p>2$.
Thus it disappears modulo $p^{n+1}$, independently of the
ramification index of $A$. The first term gives exactly the
Kodaira--Spencer map over $R$. Induction, compatibility with finite
étale maps, and algebraization proceed as above.

Here is the coefficient construction in detail. A crystal with
$A$-coefficients on $C/W(k)$ is locally free of rank two over
$\mathcal O_{C/W}\otimes_{W(k)}A$. Pull it back along
$C_R\to C$ and $\operatorname{Spec}A\to\operatorname{Spec}W(k)$.
On a divided-power thickening $U\hookrightarrow T$ over $A$,
the pulled-back object has the two actions of $A$, one from the
base and one from the coefficients. Tensor by
\[
\mathcal O_T\otimes_{W(k)}A\longrightarrow\mathcal O_T,
\qquad b\otimes a\longmapsto ba.
\]
Local freeness makes this a rank-two crystal on $C_R/A$. Its
evaluation on $C_R$ is exactly the original mod-$p$ coefficient
bundle, viewed as a bundle on $C_R$. Therefore an oper line over
the full ring $R$ provides the required initial data. This uses
crystalline base change and does not attempt to put divided powers
on $(\pi)$ when ramification makes that impossible.

For rational one-endpoint descent, apply the earlier stable-lattice
argument modulo $\pi$, replacing the scaling $p^a$ by $\pi^a$.
The two special-fiber connections still have equal degree and
oper lines, hence are stable. Nakayama gives uniqueness up to
homothety, and the finite deck group's homomorphism to $\mathbf Z$
vanishes. The lattice descends with its coefficient action.

Its oper line over $R$ descends too. Its reduction is the unique
maximal line and is deck-invariant. For a fixed bundle on the
constant thickening $C_R$, two lifts of that line differ, at each
successive nilpotent step, by a section of
$\mathcal Hom(L,H/L)\simeq T_C$. This space is zero. Thus the
given line over $R$ is the unique such lift and is invariant.
Effective étale descent gives the full modulo-$p$ oper on the
other endpoint. Apply the just-proved construction over $A$.

## The exact sufficient thickness for the coefficient line

Suppose instead that the initial line is supplied on the constant
curve over $R_a=A/\pi^a$, with $1\le a\le e$ and $(p-1)a>e$.
The ideal $(\pi^a)$ in $A$ has its canonical divided powers
$\gamma_j(x)=x^j/j!$. Indeed
\[
v_\pi((\pi^a)^j/j!)=aj-e v_p(j!)
\ge a+(j-1)\left(a-\frac e{p-1}\right).
\tag{6}
\]
They are integral, preserve the ideal, and tend to zero with $j$.
They extend the usual divided powers of $(p)$, since $a\le e$.
Pulling the coefficient crystal back along $C_{R_a}\to C$ and
identifying the two coefficient actions therefore gives a crystal
on $C_{R_a}/A$ for this divided-power base.

Lift successively from $A/\pi^n$ to $A/\pi^{n+1}$, starting at
$n=a$. For a change $\pi^n\delta$, every Taylor term of degree
$j\ge2$ has valuation strictly larger than $n$, by (6) with $n$
in place of $a$. Thus its linear term is again exactly the reduced
Kodaira--Spencer map. The curve and line obstruction spaces on
each step are identified by this isomorphism on the reduced curve.
The earlier vanishing, uniqueness and algebraization arguments apply.
This proves the stated sufficient precision and its compatibility
with both actual étale maps.

At equality $(p-1)a=e$, the divided powers are still integral and
compatible with $(p)$, although they are not topologically nilpotent.
This is an allowed divided-power base at every finite coefficient
precision: the crystalline site requires $p$ nilpotent in the
thickening, not eventual vanishing of its individual divided powers;
see [Stacks, Definition60.5.2](https://stacks.math.columbia.edu/tag/07HM).
The pulled-back crystal and its evaluations therefore still exist.

Suppose in addition that the reduced connection is dormant.
The only nonlinear Taylor terms at the first step which can have
valuation exactly $a$ have $j=p^r$ for $r\ge1$: Legendre's formula
gives valuation $a s_p(j)$, where $s_p(j)$ is the base-$p$ digit sum.
In a local étale coordinate, dormancy gives
$\nabla_{\partial_t}^{p}=0$ modulo $\pi$, since
$\partial_t^p=0$. Thus every coefficient
$\nabla_{\partial_t}^{p^r}$ is divisible by $\pi$. These remaining
terms vanish modulo $\pi^{a+1}$ as well. The Taylor series is
well defined by the crystal's topological quasi-nilpotence;
see [Stacks, Section60.17](https://stacks.math.columbia.edu/tag/07J7).
The first comparison is consequently linear in this case too.
All later steps have $n>a$ and satisfy the strict inequality.
This proves the stated boundary extension with dormancy.

An arbitrary chosen lift of a mod-$\pi$ line is not being supplied:
the oper on the entire $R_a$-curve remains an input. Without
dormancy the critical Taylor coefficients have not been eliminated.

## Frobenius gives a stronger transport bound

When the fixed coefficient lattice has integral Frobenius height
$b\le e$, or belongs to a finite Frobenius cycle with this uniform
height bound at every step, the
[Frobenius Taylor theorem](frobenius_taylor_thickness.md) gives
$v_\pi(T_j)\ge-b\lfloor\log_pj\rfloor$ in every component.
An initial oper to precision $\pi^a$ therefore suffices whenever
$(p-1)a>b$, regardless of the ratio $a/e$.
That proof constructs the integral evaluations on all curve
deformations of the specified initial thickening using convergent
Taylor gluing. Their first comparison is the same map (3).
Thus the previous obstruction, descent and algebraization argument
applies unchanged. This is an additional Frobenius hypothesis, not
an improvement asserted for arbitrary coefficient crystals.

## Scope of the initial data

The deformation space is that of the line inside the evaluation of a
FIXED crystal; varying the crystal would invalidate (3). The target
in (1) is a line, so $H^1(\kappa)$ is an isomorphism, not merely
injective. A rank-$2r$ crystal with a rank-$r$ Hodge bundle does not
satisfy this argument just because one matrix entry is nonzero.
Its actual compatible rank-two summand is what will be used below.
The integral and finite-precision hypotheses are explicit; no claim
about realizing a bare BT1 group as a $W_m$-crystal is made here.
