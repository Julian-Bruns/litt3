# Proof: contact seven excludes two isotypic line types

Version1,2 October 2026. Computation-free proof; [independent whole-branch audit](../../Research/audits/CONTACT_SEVEN_TWO_TYPES_AUDIT_2026_10_02.md) PASS. [Statement](../../Theorems/cartier_and_spin/contact_seven_one_isotypic_type.md). The conclusion is that contact-seven equality has only ONE isotypic line type for the selected MAIN pair. The positive q0 saturation need not equal the original degree-one trace. The entire equality is now excluded by the separate [contact-seven theorem](contact_seven_equality_exclusion.md); the unmarked common-cover problem remains open.

## Actual setup and accepted inputs

Retain two actual finite étale maps $X\xleftarrow hS\xrightarrow gY$ from the same smooth connected projective source, of degrees $n,8n$. The selected genus-nine curve $X$ has the original net $I\simeq O_X^3$, its saturated hyperplane $U$ of degree thirteen, and old radical $\ell=U^\perp=O_X(-3O)$. Let $J\subset B_Y$ be the actual original first trace, of rank four and degree one. Assume its actual contact is $t=7n$.

Use the [split-line equality reduction](../../Research/experiments/oct02_global_extraction/CONTACT_SEVEN_POLYSTABLE_LINE_REDUCTION.md): on the connected actual one-leg Galois closure $q:T\to Y$, of degree $8d$, with actual conjugate maps $h_i:T\to X$ of degree $d$, the bundle $E=q^*J$ splits into four lines of degree $2d$. Every local Cartier defect is cyclic and their total length on $Y$ is three. Distinct quotient lines $Q_i=E/(E\cap h_i^*U)$ form a transitive orbit of size $N$, their duals span $E^*$, and $8\mid N$. Each distinct direction has $8d/N$ raw representatives. Equality of quotient directions is equivalent to equality of actual embedded $X$ fields, by the accepted old-radical recognition theorem.

Suppose there are TWO isotypic types. The actual intermediate étale double cover $\pi:Y'\to Y$ supplies
\[
\pi^*J=W_A\oplus W_B,\quad\operatorname{rank}W_A=\operatorname{rank}W_B=2,\quad\deg W_A=\deg W_B=1.
\]
The involution exchanges the blocks. Their pullbacks to $T$ are $A^{\oplus2},B^{\oplus2}$ for distinct degree-$2d$ lines. Each type has $N/2$ distinct quotient directions and $4d$ raw representatives, and spans its two-dimensional dual block. The actual type-A source hyperplanes contain the entire block $q^*W_B$, and conversely.

We also use two accepted local facts from the original net. Contact at an ordinary finite sheet is zero, at a finite cubic branch it is at most one, and at infinity it is at most two when the target defect is cyclic. At a cyclic double-or-higher defect, the occurrence of a branch sheet excludes every infinity sheet over that same opposite point. The last statement is the explicit primitive-order comparison: the branch hyperplane has orders $1,2,4$, while an infinity original column of order eight, divided by the base uniformizer, has order three and cannot lie in that hyperplane. It uses the first jet of the original inclusion, not only its fiber image. These facts are detailed in [the cyclic-defect proof](../../Research/experiments/oct02_global_extraction/CYCLIC_FIRST_TRACE_DEFECT.md).

## Saturated blocks have degree at most two

Let $V_A,V_B$ be the saturations of $W_A,W_B$ inside $B_{Y'}$. Their degrees agree under the involution; write them as $1+p$ with an integer $p\ge0$.

For any actual type-A map, the pullback of $V_B$ is contained integrally in $h_i^*U$. Indeed the smaller $q^*W_B$ is contained, and $h_i^*U$ is saturated inside $B_T$. The same holds with the types reversed.

Every rank-two subbundle $V\subset h_i^*U$ has
\[
5\deg V\le (49/2+16)d=81d/2.
\]
To prove this, apply Frobenius and the actual evaluation $F^*h_i^*U\to\omega_T$. The rank-two subbundle cannot evaluate identically to zero. Choose a nonzero line subbundle in it; its inclusion into $B_T\subset F_*\omega_T$ has nonzero adjoint $F^*L\to\omega_T$, which factors through the displayed evaluation. Its kernel is a line in the pulled stable Frobenius kernel and has degree at most $49d/2$ by étale-pullback semistability. Its image has degree at most $\deg\omega_T=16d$. Sum these degrees. The accepted kernel input is [the generated Frobenius HN theorem](../../Theorems/cartier_and_spin/cartier_generated_frobenius_hn.md).

Since $\deg(T/Y')=4d$, the contained pulled block has degree $4d(1+p)$. The inequality gives $20(1+p)d\le81d/2$, so $p\le1$.

## Pure fibers consume saturation degree

At a cyclic defect point of exponent $a$ on $Y'$, write the local inclusion as
\[
B_{Y'}=(W_A\oplus W_B)+R(t^{-a}v),\qquad v=v_A+v_B\text{ primitive in }W_A\oplus W_B.
\]
The added length on saturating block $A$ is $b_A=\min\{a,v(v_B)\}$ and on block $B$ is $b_B=\min\{a,v(v_A)\}$. At most one is positive. If the fiber kernel line lies in block $A$, then $b_A\ge1$; call this a pure fiber. If its two block components are nonzero, both lengths vanish; call this a mixed fiber. Higher mixed jets can make $b_A<a$ even when the fiber is pure; no full-exponent purity is presumed.

At each original point of $Y$, its two lifts have conjugate positive lengths in opposite blocks. Therefore $p$ equals the sum of these positive lengths over original defect points. Since $p\le1$, at most ONE original defect point has a pure fiber. All other support points have mixed fibers.

## Exact counts of contact directions

Generic independence of equal-degree quotient-dual lines is preserved in every fiber. Indeed their direct sum injects into its saturated span in semistable $E^*$; equality of slopes forces the determinant divisor to vanish. Thus the $N/2$ distinct quotient lines within each rank-two block give $N/2$ distinct directions in every fiber.

At a cyclic defect, positive contact is equivalent to the quotient covector annihilating the one-dimensional kernel of $E\to B_T$ in the fiber. For an explicit check, in a Smith frame $E=(t^ae_1,e_2,e_3,e_4)$ and a source hyperplane primitive covector $f$, let $z=\min\{a+v(f_1),v(f_2),v(f_3),v(f_4)\}$. The quotient covector in $E^*$ is $t^{-z}(t^af_1,f_2,f_3,f_4)$ and the contact is $c=a-z$. Its first coordinate vanishes in the fiber exactly when $c>0$; if $c=0$, primitiveness forces $f_1$ to be a unit.

At a mixed fiber, each block contributes at most ONE distinct positive-contact direction. The total number of positive-contact raw representatives is at most $16d/N$. At a pure fiber, one block contributes all $N/2$ directions and the active block at most one, giving at most $4d+8d/N$ positive-contact representatives.

These fixed-point raw counts sum to the contact of ONE actual map, without an additional covering-degree factor. For each original support point $Q$, select $z_Q\in q^{-1}(Q)$. If $c_i(z_Q)$ are the contact exponents for the $8d$ raw deck-conjugate maps, the deck action bijects those labels with the points of $q^{-1}(Q)$ for one fixed actual map $h_0$. Hence
\[
\sum_Q\sum_{i\text{ raw}}c_i(z_Q)=\deg C_0=7d.
\]
The same bijection makes the number of infinity raw representatives at $z_Q$ equal to $|h_0^{-1}(O)\cap q^{-1}(Q)|\le d$. Thus the following support-by-support counts compare directly to $7d$. This is a bijection of actual sheets, not division by a trace-degree scalar.

## Exhaustion of the length-three cyclic supports

If the support is one cyclic triple point, absence of a branch leaves only infinity contact, of total at most $2d<7d$. Presence of a branch excludes infinity and makes every nonzero contact exponent one. Even a pure fiber then contributes at most $4d+8d/N\le5d<7d$. Thus this support is excluded without using a separate singleton-triple theorem.

If the support is a cyclic double point and a separate simple point, there is at most one pure point. If a branch occurs at the double point, infinity is excluded and every nonzero contact at both points has exponent one. The total contact is at most
\[
(4d+8d/N)+16d/N=4d+24d/N.
\]
If no branch occurs at the double point, its entire contact is at most $2d$, and the simple point contributes at most $4d+8d/N$. Thus the total is at most $6d+8d/N$. For $N\ge16$ both bounds are strictly below $7d$.

If the support is three separate simple points, at most one is pure and the total contact is at most
\[
(4d+8d/N)+2(16d/N)=4d+40d/N<7d\qquad(N\ge16).
\]

Consequently the two-type branch forces $N=8$.

## The remaining size eight produces an actual small witness

Let $G=\operatorname{Gal}(T/Y)$ and let $H$ stabilize one embedded $X$ field. By the accepted radical-field recognition, $[G:H]=N=8$. Its action on that field has image in $\operatorname{Aut}(X)=C_3$, of order $e\in\{1,3\}$. Let $H_0$ be the kernel. The actual intermediate smooth curve $C=T/H_0$ has BOTH finite étale maps $C\to X$ and $C\to Y$, with
\[
\deg(C/X)=eN/8=e\le3,\qquad\deg(C/Y)=eN\le24.
\]
Étaleness of the descended $X$ map is checked after the actual étale source cover $T\to C$; the $Y$ map is an intermediate of the actual étale Galois cover. This is not a presumed simultaneous closure.

For MAIN, [effective quotient descent](../../Theorems/curve_arithmetic/genus_two_quotient_descent.md) excludes every actual witness of $X$ degree at most three (indeed gives the much stronger lower bound $(335999!)^2$). Therefore its two-isotypic-type contact-seven branch is excluded.

For any partner without that low-degree exclusion, the proved output is the conditional bound $N=8$ and the actual common witness of degrees $(e,8e)$, $e\in\{1,3\}$. For MAIN, contact-seven equality now has only one isotypic type, so $\operatorname{End}(J)$ is finite-étale-trivializable. This does not force the positive q0 saturation trace to have degree one, construct a common coefficient on the original endpoints, or exclude the remaining one-type equality branch.
