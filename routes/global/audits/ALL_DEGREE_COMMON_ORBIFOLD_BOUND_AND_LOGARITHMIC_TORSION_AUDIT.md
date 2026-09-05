# Audit: all-degree common-orbifold bound and logarithmic torsion

**Verdict:** **PASS**, with the scope and nonbreaking clarifications below.

**Auditor:** `/root/canonical_trace_algebra`

**Date:** 2026-09-05

## 1. Scope and conclusion

The three new texts reviewed in full are:

- [Multi-branch finite reduction](../MULTIBRANCH_WILD_ORBIFOLD_FINITE_REDUCTION.md).
- [Two-point nonweak reduction](../TWO_POINT_NONWEAK_ORBIFOLD_LOCAL_REDUCTION.md).
- [Logarithmic-differential torsion](../TWO_POINT_LOGARITHMIC_DIFFERENTIAL_TORSION.md),
  specifically its parameterized Theorem 1 and connected-Kummer argument
  in Sections 1–2.

The already audited ordinary-atlas local bound and weak two-point theorem
are accepted within their stated scope. File 13 was read and its
first-break Swan and tame-divisibility arguments checked. The existing
maximal-break audit supplies the common-residue lemma and its
$Q\le125$ consequence. The representation argument in Lemma 2 of the
nonweak note was also checked directly.

None of the three target proofs was authored by this auditor. Earlier
first-break computations and the order-$125$ and order-$3125$ refinements
by this auditor are not used to obtain the bound certified here.

The desired parameterized conclusion is sound:

Let $X/k$ have genus nine and absolutely simple nonordinary Jacobian, and
let $Y/k$ be ordinary of genus 25, with $k=\overline{\mathbf F}_5$.
For every smooth proper effective common orbifold $S$ with actual
representable finite étale maps from both curves, put
$n=\deg(X\to S)$. Then

$$
 n\le336000
$$

unless $S$ has one mixed wild point and one tame point with

$$
 P=5^q,\quad q\ge3,\quad
 e_{\rm wild}=3tP,\quad \epsilon=3P+9,\quad
 e_{\rm tame}=t,\quad n=6Pt,
$$

where $t\in\{2,4,8\}$ and $t=8$ requires odd $q$.
These are necessary exceptional rows, not claimed realizations.

The prescribed $p$-rank six of $X$ ensures nonordinarity but is not
otherwise needed in this bound. Neither special equations, automorphism
groups, hyperellipticity of $Y$, nor simplicity of $J(Y)$ are used.

**Further parameter scope checked:** genus 25 is also unnecessary.
The same degree bound and exceptional family hold for any ordinary
genus-$h$ curve $Y$, $h\ge2$, provided
$\operatorname{Hom}(J(X),J(Y))=0$. Any absolutely simple nonordinary
genus-nine $X$ supplies this Hom vanishing. The value $3n$ for the
second atlas degree is only computed, never used in the classification.
In general

$$
 \deg(Y\to S)=\frac{h-1}{8}\,n,\qquad
 \deg E_Y=\frac{h-1}{4}\quad\text{in the exceptional family}.
$$

Thus $h\not\equiv1\pmod4$ already rules out the exceptional family by
integrality. For $h\equiv1\pmod4$, the same cyclic-cover condition below
eliminates it. Genus zero or one cannot be an étale atlas of the positive
orbifold Euler number forced by genus-nine $X$.

Moreover, if all connected cyclic étale covers of $Y$ of degrees
$2,4,8$ are ordinary, the logarithmic theorem eliminates every
exceptional row. In particular the stronger condition that every
connected abelian étale cover of exponent dividing eight is ordinary
suffices.

This audit does **not** prove the generic existence of such a $Y$.
It also does not turn a coreless common cover into a common orbifold,
and does not solve the common-cover problem.

## 2. Completing the global case division

First, $\operatorname{Hom}(J(X),J(Y))=0$: a nonzero map from the
absolutely simple $J(X)$ would have finite kernel onto its image.
That image is an abelian subvariety of an ordinary abelian variety,
hence ordinary, contradicting isogeny invariance of ordinarity.

Let $B$ be the coarse curve of $S$. The coarse maps from the atlases
are finite separable. If $g(B)>0$, norm from $J(X)$ to $J(B)$ followed
by pullback to $J(Y)$ is nonzero: norm is surjective and pullback has
finite kernel, by the norm–pullback multiplication identity.
This contradicts the preceding Hom vanishing. Thus $B=\mathbf P^1$.

Effectivity makes the generic inertia trivial, so stack degree equals
coarse degree. Étale local charts give the same inertia order $e_i$ and
different $d_i$ at every point above a stacky point, without requiring
either coarse map to be Galois. Therefore

$$
e_i\mid n,\qquad
-2+\sum_i d_i/e_i=16/n,\qquad \deg(Y\to S)=3n.
$$

The last equality is for genus 25; for genus $h$ it becomes
$\deg(Y\to S)=(h-1)n/8$. None of the following case bounds uses it.

The ordinary atlas gives $d_i/e_i<2$ at every stacky point.

- With zero stacky points, the Euler expression is negative.
- With one stacky point, it is still negative by $d/e<2$.
- With no wild points and positive Euler expression, the standard tame
  signature inequality is $\delta\ge1/42$, hence $n\le672$.
  This is an elementary numerical inequality, not a Hurwitz theorem
  requiring a Galois atlas.
- The audited weak two-point result has $Q\le20$ here, hence $Q=5$.
  Even without using its exact table, $c\mid4$, $a\le12$, $t\le4/c$,
  and $16/D\le16$ give the harmless bound $n\le3840$.
- The new multibranch and nonweak notes handle every other case.

For completeness, the tame inequality follows by the number $r$ of
branch points. If $r\ge5$, $\delta\ge1/2$; if $r=4$ and $\delta>0$,
then $\delta\ge1/6$. For $r=3$, order the inertia orders.
The smallest positive value of $1-1/e_1-1/e_2-1/e_3$ occurs for
$(2,3,7)$ and is $1/42$: the cases with $e_1\ge3$ or $e_2\ge4$
give larger positive lower bounds. Allowing orders divisible by five
in this numerical estimate only makes it more inclusive.

Thus there is no omitted one-point, positive-coarse-genus, or tame-only
case that could escape the stated absolute bound.

## 3. Multibranch calculation

The exact identity

$$
 16=(w+c-2)n+\sum_i x_iA_i-\sum_j y_j
$$

uses $x_i=n/e_i$, $A_i=\epsilon_i-1\ge3$,
$A_i\equiv3\pmod4$, and $y_j=n/t_j\le n/2$.
All inequalities in the note have the correct direction.

The exceptional small checks were repeated:

- For $w\ge3$, the only inequality survivor is $w=3,c=0,n=5$.
  All inertias are then pure of order five and weak, giving
  $16=14$, a contradiction.
- For $w=2,c=0$, exact enumeration of
  $x_1A_1+x_2A_2=16$ with $A_i\ge3$ and $A_i\equiv3\bmod4$
  gives only $(x_1,A_1;x_2,A_2)=(3,3;1,7)$, up to ordering.
  The two resulting degree sets are disjoint.
- If $w=2,c\ge1$, then $n\le20$.
- If $w=1,c\ge3$, then $n\le26/(c-2)$.
- If $w=1,c=2$, then either $n\le78$ or both tame orders are two.
  In the latter case $xA=16$, incompatible with $A\equiv3\bmod4$.
- The pure-wild two-point case gives $n\le160$.

These steps depend only on actual local chart data and the audited
ordinary-atlas estimate. No global Galois envelope is introduced.

## 4. Nonweak two-point calculation

### Exact normalization

Starting from
$n=r_wQm=r_tN$ and $16=r_w(\epsilon-1)-r_t$,
division by $d=\gcd(r_w,r_t)=\gcd(r_w,16)$ gives the stated coprimalities.
Comparison of five-adic valuations gives $r_t=dQc$ with $5\nmid ac$.
Then $m=ct,N=at$; the local divisibility $m\mid\epsilon$ gives
$\epsilon=cL$ and $t\mid L$. The equations

$$
 ch=a+D,\qquad aL=Q+h,\qquad D=16/d
$$

follow exactly. Nonweakness implies $\epsilon\ge Q+3$, giving
$Q(c-a)\ge2a-D$. In particular $a\ge D$ forces $h=1$.

### The unbounded-looking $h=1$ branch really is bounded

Parity gives $D=1$ and odd $a$.
The first-break exceptions reduce exactly to $(a,Q)=(1,5)$ and
$(3,5)$. In every remaining case the first break is one.

For $H=5^{\lceil s/2\rceil}$, the two decisive divisibilities are

$$
 c\mid5^s-1,\qquad H\mid2c-1,\qquad c=a+1\text{ even}.
$$

Writing $2c=Hu+1$ gives $u\equiv3\bmod4$ and $u\ge3$.
With $\kappa=1$ for even $s$ and $\kappa=5$ for odd $s$,
the integer

$$
 v=\frac{2(\kappa u^2-1)}{Hu+1}
$$

is positive and less than four. Its quadratic discriminant factors as

$$
 (W-vH)(W+vH)=8\kappa(v+2),
$$

which gives $H<12\kappa$. Thus only $s=1,2,3$ remain; the finite
divisor check gives precisely $s=2,c=8$.
This is a genuine all-degree reduction, not a bounded search over $s$.

Then $a=7$, $q\equiv3\bmod6$, and the audited maximal-break inequality
gives $Q\le125$. Therefore $Q=125$, and the third finite row and its
$t=1,3$ possibilities follow. Its maximum coarse degree is
$112000\cdot3=336000$.

### The $h\ge2$ branch

Now $1\le a<D\le16$, and the finite constant list is complete.
An independent integer-only enumeration reproduced exactly

$$
\begin{gathered}
(2,1,3,1),\ (4,3,7,1),\ (8,1,3,3),\\
(8,3,11,1),\ (8,7,15,1),\ (16,3,19,1),\\
(16,7,23,1),\ (16,11,3,9),\ (16,11,27,1),
\end{gathered}
$$

in the order $(D,a,h,c)$.
The inequality $Q(c-a)\ge2a-D$ disposes of the claimed rows.
The two additional finite rows have $Q=5$ and break two.

The only remaining constants are
$(D,a,h,c)=(8,1,3,3)$. They give
$\epsilon=3Q+9,m=3t,N=t,n=6Qt$.
For $q\ge2$, first-break Swan divisibility forces $b=1,s\le2$;
the tame factor three then forces $s=2$.
Consequently $q=2$ is impossible, and for $q\ge3$,
$t\mid\gcd(8,Q+3)$ gives the stated exceptional choices.
The $q=1$ instances have $n\le240$ and are finite.

All finite rows were checked again in exact rational
Riemann–Hurwitz arithmetic. Their maximum is $336000$.
This audit does not require that any finite numerical row be realized.

Lemma 2's central-character proof also checks: an irreducible packet
over a nontrivial character of $G_B$ has degree squared at most
$5^{q-j}$, and conductor
$u(1+(\epsilon+B)/5^q)$ is integral. The stated valuation bound follows.
It is an additional condition, not needed for the global degree bound.

## 5. Logarithmic torsion and the actual connected cover

Theorem 1 is valid for arbitrary $C$ under its displayed local hypotheses.
Writing $D=F-RPE$, uniform fibers give

$$
 \operatorname{div}(v\circ f)=tD,\qquad
 \operatorname{div}(\eta)=(RP+c-1)E-F,\qquad
 \eta=\frac1t\,d\log(v\circ f).
$$

The map $f$ is separable, so $\eta\ne0$.
These formulas prove the asserted torsion line, canonical identity,
degree of $E$, and holomorphic $t$-differential directly.

If the line $\mathcal L=\mathcal O(D)$ is trivial, a rational function
$h$ with divisor $D$ satisfies $v\circ f=\lambda h^t$.
Then $dh=h\eta$ has divisor $(c-1)E$, and is nonzero and holomorphic.
Cartier kills this exact differential, so an ordinary $C$ cannot
have $\mathcal L=0$.

For the connectedness claim, let $s=\operatorname{ord}(\mathcal L)$.
Over algebraically closed $k$, Kummer theory identifies
$H^1(C,\mu_t)$ with $\operatorname{Pic}(C)[t]$.
The normalized Kummer cover $u^t=v\circ f$ therefore has $t/s$
components, each cyclic étale of degree $s$.
Equivalently, choose $a$ with divisor $sD$; since
$v\circ f=\lambda a^{t/s}$, each component has equation
$u^s=\lambda' a$ for a suitable nonzero constant.

On that component,

$$
 du=u\,\pi^*\eta,\qquad
 \operatorname{div}(u)=\pi^*D,\qquad
 \operatorname{div}(du)=(c-1)\pi^*E.
$$

The étaleness of $\pi$ is essential to the differential-divisor
pullback and is satisfied here: all valuations of the Kummer radicand
are multiples of $t$, and $t$ is prime to $p$.
Thus $du$ is a nonzero exact holomorphic differential on the actual
connected cover. Its degree is $s$, not necessarily $t$.

For the exceptional family, $R=3,c=9,t\mid8$.
Applied to an ordinary genus-25 $Y$, this produces a connected
nonordinary cyclic étale cover of degree $s\in\{2,4,8\}$.
This implication uses only Sections 1–2, not the special
hyperelliptic or superelliptic corollaries later in the note.

## 6. Nonbreaking clarifications and reviewed versions

1. The phrase “the equation defines a finite étale Kummer scheme” should
   be read as its **normalized Kummer cover over $C$**. Since its
   radicand is a rational function with poles, it is not literally a
   single affine polynomial equation over every point of $C$.
   The local normalization argument and all subsequent conclusions
   are correct.

2. The multibranch note's “entire remaining numerical condition” means
   its displayed Riemann–Hurwitz identity and basic divisibilities,
   not a complete characterization of realizable local actions.
   Its own scope warnings make this distinction explicit.

3. A few displayed formulas contain literal “qquad” without a backslash.
   These are rendering defects, not mathematical changes.

4. The existing “fixed curves” introductions do not conceal fixed-model
   input in the proofs audited here. The main logarithmic theorem is
   parameterized; its later special-curve corollaries are not needed
   or certified as part of this audit.

SHA-256 hashes of the proof files before adding audit-only metadata:

| File | SHA-256 |
| --- | --- |
| Multibranch reduction | `a9bd93b672ecc53d361efbe66f36f3f6d95e20554d2f9e986fde341f29784c87` |
| Nonweak two-point reduction | `2acd67802ae3ab2c29fd73fd0b176fab1dc3bd54a6acdc1efce71a0c5ac30297` |
| Logarithmic torsion | `72f120a4a19a94afedb63ccae6ad3ca981fed36f5ac9e6c90115c50d75599429` |

Only scoped audit status/link metadata was authorized for insertion in
the three proof files. No mathematical text is changed by this audit.
