# Proof: intrinsic branch fibers give contact greater than 107/15

Version4,2 October2026. Computation-free proof. Version1 passed independent whole-argument [audit](../../Research/audits/BRANCH_FIBER_UNIFORM_CONTACT_GAP_AUDIT_2026_10_02.md). The [Version2 note](../../Research/experiments/oct02_global_extraction/AGGREGATE_MOVING_PAIR_BUDGET_AND_CONTACT_283_OVER_40.md) records the aggregate pair-valuation improvement. Version3 adds the two-support assertion. Version4 improves the infinity bound for three simple supports. The changed implications and constants passed a [focused extension review](../../Research/audits/BRANCH_FIBER_CONTACT_EXTENSION_REVIEW_2026_10_02.md). [Statement](../../Theorems/cartier_and_spin/branch_fiber_uniform_contact_gap.md).

## Actual short-contact source

Retain two actual finite étale maps $X\xleftarrow hS\xrightarrow gY$ from the SAME smooth connected projective source for MAIN, of degrees $n,8n$. Let $I\subset U\subset B_X$ be the original net and its degree-thirteen saturation, and let the actual first trace $J$ have rank four and degree one. Write $\rho=t/n=7+\epsilon$, and first assume $0\le\epsilon\le2/15$ with three distinct simple target defects. The at-most-two-support case is proved separately below. The accepted bound is $t\ge7n$.

Since $\rho<8$, the accepted short-contact theorem makes $J$ stable and its length-three Cartier defect cyclic everywhere. Take the actual connected one-leg Galois source $q:T\to Y$ of degree $8d$, with its actual conjugate maps $h_i:T\to X$ of degree $d$. Put $E=q^*J$, semistable of slope $2d$.

The source quotient-dual lines $D_i\subset E^*$ are saturated and have degree $-(2+\epsilon)d$. Their full generic span has rank four: a proper deck-invariant span of rank $s\le3$ has degree at least $-s(2+\epsilon)d>-8d$, while descent to a proper subbundle of stable $J^*$ forces degree at most $-8d$.

Distinct generic quotient directions correspond to distinct actual embedded $X$ fields by radical-field recognition. If their number is $N$, the actual field-stabilizer kernel gives a same-source finite étale replacement of degrees $(eN/8,eN)$, $e\in\{1,3\}$. In particular $8\mid N$ and MAIN effective quotient descent forces $N\ge10^7$. Every distinct direction has $8d/N$ raw representatives; equality of fields gives maps differing by the cubic automorphism, which preserves the finite branch divisor $R$ and infinity $O$. Thus the classification of representatives as branch, infinity or ordinary is well-defined for each distinct direction at a selected fiber point.

## A moving-flat bound valid in this interval

We recall the complete collision estimate needed here; it does not require equal-line splitting or a positive q0 trace.

For a generic projective line containing $m$ quotient directions, let $V\subset E^*$ be its saturated rank-two span. Then $-(4+2\epsilon)d\le\deg V\le-4d$. Its annihilator plane $H_V\subset E$ has degree at least $(4-2\epsilon)d$; its saturation in $B_T$ is contained in each actual source hyperplane belonging to that flat. The actual source-plane bound $\deg W\le81d/10$ gives its added saturation length at most $(41/10+2\epsilon)d$.

Each pair of distinct directions in the flat has a determinant collision divisor in $V$ of degree at most $2\epsilon d$. We will aggregate its valuation across every nonfull contact level, rather than spend its degree separately at each level.

At a cyclic defect of exponent $a$, write $B_T=E+R(t^{-a}v)$ with $v$ primitive. The actual contact of a primitive local quotient covector $\alpha_i$ is $c_i=\min\{a,v(\alpha_i(v))\}$. Let $b$ be the local added saturation length of $H_V$, equivalently the minimum, truncated at $a$, of the valuations of the evaluation map $V\to R$, $\alpha\mapsto\alpha(v)$.

At level $r\le a$, a flat with $b\ge r$ has all $m$ directions at contact level $r$. In every other flat, divide its evaluation by $t^b$; its nonzero residual map forces all level-$r$ directions into ONE fiber line. More precisely, choose a basis of $V$ with divided evaluation $(1,\psi)$ and write two covectors as $(u_i,w_i)$ and $(u_j,w_j)$. Then
\[
\det(\alpha_i,\alpha_j)=w_j(u_i+w_i\psi)-w_i(u_j+w_j\psi),
\]
so its valuation is at least $\max(0,\min(c_i,c_j)-b)$. This is the number of nonfull levels at which both directions occur. Thus each repeated level uses a distinct unit of pair determinant valuation.

For a deck orbit of $L$ flats, exact invariant fiber averaging therefore bounds the sum of all nonfull pair incidences over all supports and levels by $L\binom m2\epsilon/4\le Lm^2\epsilon/8$. There are at most $3L$ nonfull flat-level slots. Applying $k\le1+\sqrt{2\binom k2}$ and Cauchy--Schwarz globally, then dividing by $Lm$ using uniform generic point-flat incidence, bounds their aggregate contribution by $3/m+\sqrt{3\epsilon}/2$.

Exact deck-label/fiber-point averaging identifies the total contact with $\sum_{Q,r}|A_{Q,r}|/N=(7+\epsilon)/8$. The full-slot fractions sum to at most $41/80+\epsilon/4$ by the saturation-length bound. Consequently
\[
29/80-\epsilon/8\le3/m+\sqrt{3\epsilon}/2.
\]
For $\epsilon\le2/15$, the left side is at least $83/240$. Also $\sqrt{3\epsilon}\le\sqrt{2/5}<19/30$, so the last term is strictly less than $76/240$. Therefore $3/m>7/240$, and every GENERIC collinear flat satisfies $m<720/7<103$, hence $m\le102$.

## The intrinsic order-four line

At any point of $T^{(1)}$, the Cartier fiber has primitive-function classes of orders one through four. The one-dimensional subspace of primitive order four is intrinsic: if a source parameter changes by $u=a_1t+a_2t^2+\cdots$, then $[u^4]=a_1^4[t^4]$ in the Cartier fiber, since all terms of order at least five are multiples of the target uniformizer. Denote this line $F_4\subset(B_T)_z$.

At EVERY actual finite cubic branch sheet, the original three-section net has primitive orders $(1,4,7)$. Its fiber image therefore contains $F_4$. The order-seven column has zero fiber, while the order-four column gives precisely this intrinsic line. This assertion is invariant under each actual étale parameter identification; no equality of branch slopes or a choice of complete $X$ fibers is imposed.

At a cyclic Cartier defect, the fiber map $E_z\to(B_T)_z$ has one-dimensional kernel $k$. If a branch sheet occurs, $F_4$ lies in its image because that sheet's original $I_i$ lies in $E$. Thus the full preimage of $F_4$ in $E_z$ is a two-dimensional plane $L=\langle k,w\rangle$.

For a POSITIVE-contact branch direction, its quotient covector $\alpha_i$ annihilates $k$ in the fiber. It also annihilates its original-net lift of $F_4$, because it kills all of $I_i\subset E\cap h_i^*U$. That lift differs from $w$ only by an element of $k$, up to scalar. Hence $\alpha_i$ annihilates the entire SAME plane $L$. ALL positive-contact branch directions at the point lie in ONE projective line in $\mathbf P(E_z^*)$.

This is a fiber statement, not generic collinearity. Its force comes from the actual original branch net and its intrinsic highest primitive class.

## Branch contacts occupy many raw sheets

The source bound at a branch is independent of the target defect exponent. Indeed $I_i\subset L_i:=E\cap h_i^*U$, so $h_i^*U/L_i$ is a quotient of $h_i^*U/I_i$. The latter has branch Smith exponents $(0,0,1)$ and length one. Thus branch contact is at most ONE even when the cyclic target exponent is two or three. At ordinary finite sheets $I_i=h_i^*U$, so contact is zero. At infinity the source Smith exponents are $(0,1,2)$, and the contact quotient is cyclic as a submodule of $B_T/E$; a cyclic quotient of this source module has length at most two.

Across ALL selected defect fibers the infinity raw representative count is at most $d$, by the deck-label/fiber-point bijection with the reduced actual divisor $h_0^{-1}(O)$ of degree $d$. For three simple target defects every contact is at most the target exponent one. Infinity total contact is therefore at most $d$ in this support shape; the general bound $2d$ will suffice for the at-most-two-support case below.

The remaining branch contact has degree at least $(6+\epsilon)d$. Let $B_Q$ be the set of distinct generic directions with positive branch contact at the selected lift of $Q$, and write $b_Q=|B_Q|$. Branch contact is exactly ONE whenever positive, so
\[
\sum_Q b_Q/N\ge(6+\epsilon)/8.
\]
There are at most three defect support points. No repeated-level triple counting is used: a branch contributes only its single positive contact level, regardless of the target exponent $a(Q)$.

## Independent triple collisions contradict this branch mass

For any generic independent triple of quotient lines, its saturated rank-three span $V_3\subset E^*$ has degree at most $-6d$. Its determinant collision divisor has degree at most $3\epsilon d$, from the degree sum of the three source lines. At a selected point all three positive-contact branch covectors lie in the same fiber projective line just proved. Since $V_3$ is saturated in $E^*$, its fiber embeds in $E_z^*$, so their determinant vanishes in $V_3$ there.

Sum these determinant divisors over ALL generic independent triples, a deck-invariant collection of size $T_3$. Fixed-fiber averaging over all selected support points gives
\[
\sum_Q T_3(B_Q)\le(3\epsilon/8)T_3\le(3\epsilon/8)N^3/6.
\]
Each support point is counted once. Distinct points give disjoint selected $q$ fibers, and their multiplicities are bounded by the total determinant degree.

With the generic line bound 102, a set of $b$ generic directions has at least $b(b-1)(b-102)/6$ independent triples. Indeed collinear triples are at most $(100/3)\binom b2$, by the unique line through each pair. Use the weaker lower bound $(b^3-103b^2)/6$, harmless even when negative.

Their sum is at least $(6+\epsilon)N/8$. Convexity of cubes and the crude error bound $\sum b_Q^2\le3N^2$ give
\[
\sum_Q T_3(B_Q)\ge\frac{N^3}{6}\left(\frac{(6+\epsilon)^3}{4608}-\frac{309}{N}\right).
\]
The difference $f(\epsilon)=(6+\epsilon)^3/4608-3\epsilon/8$ decreases on this interval, since $f'(\epsilon)\le3\cdot49/4608-3/8<0$. At its right endpoint,
\[
f(2/15)=17/243000>309/10^7.
\]
Thus for $N\ge10^7$ the lower triple count is strictly greater than $(3\epsilon/8)N^3/6$, contradicting the determinant collision budget.

Therefore the entire interval $7\le t/n\le107/15$ is excluded for three distinct simple target defects. The proof preserves both actual finite étale maps, moving quotient maps and covering degrees divisible by five. It does not assume a positive q0 trace or finite projective monodromy.

## The stronger bound for at most two supports

Suppose the length-three defect has at most TWO supports and instead assume $0\le\epsilon\le3/20$. All source, semistability, quotient-line and actual field-stabilizer arguments above remain valid, since $\rho<8$; the weaker $N\ge10^6$ suffices here. The aggregate moving-flat estimate has left side at least $11/32=44/128$. Since $\sqrt{3\epsilon}\le\sqrt{9/20}<43/64$, its square-root term is strictly less than $43/128$. Thus $3/m>1/128$, so $m<384$; use the weaker line cap384.

The general infinity contact bound $2d$ gives $\sum b_Q\ge(5+\epsilon)N/8$, now spread across at most two sets. Their triple collisions still satisfy $\sum T_3(B_Q)\le(3\epsilon/8)N^3/6$. The line cap gives $T_3(B_Q)\ge(b_Q^3-385b_Q^2)/6$. Two-slot cubic convexity and $\sum b_Q^2\le2N^2$ yield
\[
\sum_Q T_3(B_Q)\ge\frac{N^3}{6}\left(\frac{(5+\epsilon)^3}{2048}-\frac{770}{N}\right).
\]
The difference $f_2(\epsilon)=(5+\epsilon)^3/2048-3\epsilon/8$ is decreasing on $[0,3/20]$, since $f_2'(\epsilon)\le3\cdot36/2048-3/8<0$. At the endpoint,
\[
f_2(3/20)=171127/16384000>770/10^6.
\]
The lower triple count therefore exceeds its upper bound throughout the interval, proving $t>(143/20)n$ for at most two target supports. The [scoped development note](../../Research/experiments/oct02_global_extraction/TWO_SUPPORT_CONTACT_143_OVER_20.md) records this extension separately. Together with the three-simple result and the accepted noncyclic bound $t\ge8n$, this proves the unrestricted degree-one MAIN bound $t>(107/15)n$.

Contacts above these gaps, target noncyclic defects allowed at contact at least eight, larger first-trace degree, and the original common-cover problem remain unresolved.
