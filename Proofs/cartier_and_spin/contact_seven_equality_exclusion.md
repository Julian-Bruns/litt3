# Proof: contact-seven equality is impossible for MAIN

Version2,2 October2026. [Whole-branch independent audit](../../Research/audits/CONTACT_SEVEN_EQUALITY_AUDIT_2026_10_02.md) PASS; focused root review PASS. [Statement](../../Theorems/cartier_and_spin/contact_seven_equality_exclusion.md). The version includes the uniform bounded replacement for BACKUP as well as MAIN exclusion. Higher contact and the original common-cover problem remain open.

## The original span and its actual projective orbit

Retain two actual finite étale maps $X\xleftarrow hS\xrightarrow gY$ from the SAME smooth connected projective source for the selected genus-two partner, of degrees $n,8n$. Let $I\simeq O_X^3\subset U\subset B_X$ be the original net and its rank-three saturation of degree thirteen. Suppose its actual first trace $J\subset B_Y$ has rank four and degree one, and its contact with $h^*U$ equals $7n$. The numerical reduction applies to MAIN and BACKUP.

Take the connected Galois closure $q:T\to Y$ of this ONE actual $Y$ leg, of degree $8d$, with actual conjugate maps $h_i:T\to X$ of degree $d$. The [split-line equality reduction](../../Research/experiments/oct02_global_extraction/CONTACT_SEVEN_POLYSTABLE_LINE_REDUCTION.md) gives one or two isotypic types. The [two-block theorem](contact_seven_one_isotypic_type.md) makes the two-type case have $N=8$ and gives the actual replacement already. It remains to treat the one-type case
\[
E=q^*J\simeq A^{\oplus4},\qquad\deg A=2d.
\]
The local torsion $B_Y/J$ is cyclic everywhere, of total length three. The actual source quotient-dual lines
\[
D_i=(E/(E\cap h_i^*U))^*\subset E^*
\]
have degree $-2d$ and span rank four. Their distinct directions form a transitive deck orbit of size $N$, each with $8d/N$ raw representatives. Every generically independent subset is an integral direct summand: determinant zeros and semistability force equality of its degree with the sum of these equal-degree lines.

Fix an isomorphism $E^*\simeq A^{-1}\otimes k^4$. Each $D_i\simeq A^{-1}$ is then a CONSTANT projective point $p_i\in\mathbf P^3(k)$, because its four component maps are global endomorphisms of $A^{-1}$, hence constants on the proper connected curve $T$. The deck action acts by projective linear transformations on these directions: a deck transformation preserves the unique isotypic line class, and after an isomorphism of its pulled line with $A^{-1}$ its matrix entries are constants; scalar choices do not affect projective planes or their orbits. Thus all orbit incidences below are constant on $T$, although the inclusion $E\subset B_T$ still varies and has actual integral defects.

## The actual field orbit gives a replacement witness

Generic equality of quotient directions is generic equality of the source hyperplanes and, by their symplectic radicals, equality of the actual embedded $X$ fields. The accepted radical-field recognition therefore applies to their stabilizer. If $G=\operatorname{Gal}(T/Y)$ and $H$ stabilizes one field, then $[G:H]=N$. Its induced action on that field has order $e\in\{1,3\}$ inside $\operatorname{Aut}(X)=C_3$. Let $H_0$ be the kernel.

The actual intermediate curve $C=T/H_0$ retains BOTH finite étale maps to $X$ and $Y$, with
\[
\deg(C/X)=eN/8,\qquad\deg(C/Y)=eN.
\]
The $X$ map is descended from the actual map $T\to X$, and its étaleness is checked after the surjective étale cover $T\to C$; the $Y$ map is intermediate in the actual one-leg cover. No simultaneous closure is presumed. We will bound $N$ without a MAIN degree lower bound, and apply that lower bound only to this concrete actual replacement at the end.

## Contact levels are linear subsets of the constant orbit

At a cyclic defect of exponent $a$, write locally $B_T=E+R(t^{-a}v(t))$ with $v$ primitive in $E$. In the fixed $A^{\oplus4}$ frame, write $\alpha_i$ for a constant quotient covector. Its actual contact exponent satisfies
\[
c_i=\min\{a,v(\alpha_i(v(t)))\}.
\]
For an explicit check, use a cyclic Smith frame $E=(t^ae_1,e_2,e_3,e_4)$. If a source hyperplane has primitive ambient covector $f_i$, its restriction to $E$ is $t^{z_i}\alpha_i$ up to a local unit, where $z_i=\min\{a+v(f_{i,1}),v(f_{i,2}),v(f_{i,3}),v(f_{i,4})\}$ and $c_i=a-z_i$. When $z_i>0$ all three latter coefficients are divisible by $t$, so $f_{i,1}$ is a unit; the valuation of $\alpha_i(v)$ is exactly $c_i$. When $z_i=0$, truncation at $a$ yields $c_i=a$. This proves the formula, including infinity sheets.

For each $1\le r\le a$, the contact-level subset $\{p_i:c_i\ge r\}$ is therefore cut out by homogeneous linear conditions on the constant coordinates $\alpha_i$, the coefficients of $v(t)$ modulo $t^r$. It lies in a projective hyperplane already for $r=1$.

Choose one actual lift $z_Q$ of each original defect point. The raw deck labels biject with all points of $q^{-1}(Q)$ for a fixed actual map, so the ONE-map contact degree gives
\[
\sum_Q\sum_{r=1}^{a(Q)}|\{i:c_i(z_Q)\ge r\}|/N=7/8,
\qquad\sum_Q a(Q)=3.
\]
Here $i$ in the displayed cardinalities ranges over the $N$ distinct directions; the multiplicity $8d/N$ of their raw representatives has been retained before normalization. This is an exact counting bijection, not division of a characteristic-five trace map.

## Every projective line contains at most eight orbit points

We include the complete flat argument, so the remainder does not depend on the subsidiary double-defect exclusion.

Let a projective line contain $m\ge2$ orbit points. Its rank-two bundle span $V\subset E^*$ is $A^{-1\,\oplus2}$ and its annihilator plane $H_V\subset E$ is $A^{\oplus2}$, of degree $4d$. The saturation $\overline H_V$ in $B_T$ lies inside every actual $h_i^*U$ whose quotient point belongs to that line.

Any rank-two subbundle $W\subset h_i^*U$ satisfies $\deg W\le81d/10$. Indeed its Frobenius evaluation is nonzero by adjunction on a nonzero line in $W\subset B_T\subset F_*\omega_T$. The kernel is a line inside the pulled stable rank-two Frobenius kernel of $U$, of degree at most $49d/2$. The image has degree at most $16d$. Thus $5\deg W\le49d/2+16d=81d/2$. Consequently
\[
\operatorname{length}(\overline H_V/H_V)\le41d/10.
\]

Take the deck orbit of the projective line, of size $L$. Each has $m$ orbit points and every quotient point lies on $\delta$ orbit lines, with $Lm=N\delta$. At one contact level let $F$ of these lines have all $m$ points in the level set. Every other orbit line meets that linear level set in at most one point. Double counting gives, with $f=F/L$,
\[
|\{i:c_i\ge r\}|/N\le f+(1-f)/m\le f+1/m.
\]
An orbit line has all its points at level $r$ exactly when its two-dimensional span annihilates $v(t)$ modulo $t^r$, exactly when its annihilator plane saturation gains length at least $r$. The local saturation length is the minimum, truncated at $a$, of the valuations of two spanning constant covectors. Summing all levels and using deck-invariant fixed-fiber averaging therefore bounds $\sum_{Q,r}f$ by $(41d/10)/(8d)=41/80$. The total three contact levels give
\[
7/8\le41/80+3/m,
\]
so $m\le240/29<9$. Thus EVERY projective line contains at most EIGHT quotient points.

## A large hyperplane orbit is impossible

Suppose $N\ge192$. One of the three counted contact levels contains at least $7N/24$ quotient points. This is more than eight points; its span cannot be a projective line. It lies in a projective hyperplane and hence spans exactly one such hyperplane $H$. Let $M$ be the number of ALL quotient points on $H$, so $M\ge7N/24$.

Let the deck orbit of $H$ have size $R$. Every orbit hyperplane contains exactly $M$ points, and transitivity of quotient points gives a constant incidence number $\delta$ with $RM=N\delta$.

Crucially, $4\mid R$. The corresponding rank-three constant subbundle $A^{-1}\otimes H\subset E^*$ has degree $-6d$ and is preserved integrally by its deck stabilizer. It descends through the ACTUAL intermediate étale cover $T/\operatorname{Stab}(H)\to Y$, of degree $R$. Its degree downstairs is $-6d/(8d/R)=-3R/4$, an integer. Therefore $R$ is a positive multiple of four. As $M/N\ge7/24>1/4$, the integer $\delta=RM/N$ is at least two.

Distinct orbit hyperplanes intersect in a projective line, so they share at most eight quotient points. Count pairs of incident hyperplanes at each quotient point:
\[
N\delta(\delta-1)\le8R(R-1).
\]
Since $\delta\ge2$, its left side is at least $N\delta^2/2$. The right side is strictly less than $8R^2$. Substituting $\delta=RM/N$ gives $M^2<16N$. But $M\ge7N/24$ then gives
\[
N<16(24/7)^2=9216/49<189,
\]
contradicting $N\ge192$. Thus $N<192$; since $8\mid N$, the one-type orbit has $N\le184$.

The two-type case has $N=8$, while the one-type case has $N\le184$. In both cases the actual stabilizer-kernel replacement $C$ has
\[
\deg(C/X)=eN/8\le69,\qquad\deg(C/Y)=eN\le552,
\quad e\in\{1,3\}.
\]
The bounded replacement retains both actual finite étale maps from the SAME smooth connected source and applies to BACKUP as well as MAIN. For MAIN, effective quotient descent requires every such actual witness to have $X$ degree greater than $(335999!)^2$, contradicting this bound. Thus its entire contact-seven equality is excluded in every original degree, retaining all cyclic Smith support shapes, infinity contacts, and five-divisible degrees.

For MAIN the result is the strict inequality $t>7n$, not a uniform claim $t\ge8n$. For BACKUP it is only the actual bounded-replacement reduction. Higher contact, larger positive traces, and the original unrestricted common-cover problem remain unresolved.
