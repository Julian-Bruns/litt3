# Proof: a uniform gap above contact seven

Version2,2 October2026. Computation-free proof with independent whole-argument
[audit PASS](../../Research/audits/DEGREE_ONE_UNIFORM_CONTACT_GAP_AUDIT_2026_10_02.md).
[Statement](../../Theorems/cartier_and_spin/degree_one_uniform_contact_gap.md).
Aggregate quadruple counting strengthens the uniform interval to $\epsilon\le1/200$.
No positive q0 trace, projective monodromy, or line splitting is assumed.

## Actual source and the short-contact interval

Retain the selected MAIN span $X\xleftarrow hS\xrightarrow gY$, with both actual finite étale maps from the same smooth connected projective source, of degrees $n,8n$. Let $I\subset U\subset B_X$ be the original net and its rank-three saturation of degree thirteen; let its actual first trace $J\subset B_Y$ have rank four and degree one. The accepted contact theorem gives $t\ge7n$. Write
\[
\rho=t/n=7+\epsilon,
\]
and assume for contradiction $0\le\epsilon\le1/200$.

The accepted short-contact results make $J$ stable whenever $\rho<9$. Its local Cartier defects are cyclic whenever $\rho<8$. For the latter assertion, if the Smith maxima have sum at most two, the integral old-radical map has zero-divisor degree $(24-\rho)d$ and is bounded by $8d$ times that sum, forcing $\rho\ge8$. The total defect length is three. These are actual source restrictions, not a replacement of finite étale maps by separable maps.

Take the connected one-leg Galois closure $q:T\to Y$ of degree $8d$, with its actual conjugate maps $h_i:T\to X$ of degree $d$. Put $E=q^*J$, semistable of slope $2d$. The actual quotient lines
\[
Q_i=E/(E\cap h_i^*U)
\]
have degree $(2+\epsilon)d$, and their dual lines $D_i\subset E^*$ are saturated, of degree $-(2+\epsilon)d$.

Their complete generic span has rank four. Indeed its saturation is deck invariant and descends to a subbundle of $J^*$. If its rank were $s\le3$, choose $s$ independent actual lines to obtain degree at least $-s(2+\epsilon)d>-8d$. But stability of $J^*$ makes every proper subbundle have integer degree at most minus one, so its pullback has degree at most $-8d$, a contradiction.

The distinct generic quotient directions form a transitive configuration of $N$ points in the projective three-space over $k(T)$. Equality of quotient directions means equality of actual source hyperplanes, hence of embedded $X$ fields by old-radical recognition. Their field stabilizer kernel gives an actual same-source finite étale replacement of degrees $(eN/8,eN)$, $e\in\{1,3\}$. Thus $8\mid N$ and the accepted MAIN witness-degree lower bound forces $N\ge100000$. Each distinct direction has $8d/N$ raw representatives. The proof uses this very weak explicit consequence of the much larger bound $(335999!)^2$.

## The cyclic local ledger and exact averaging

At a cyclic defect of exponent $a$, write $B_T=E+R(t^{-a}v)$ with $v$ primitive in $E$. The primitive local quotient covector $\alpha_i$ has contact
\[
c_i=\min\{a,v(\alpha_i(v))\}.
\]
To check this, use $E=(t^ae_1,e_2,e_3,e_4)$ and a primitive ambient source covector $f_i$. Its restriction has minimum coefficient valuation $z_i$, and $c_i=a-z_i$. If $z_i>0$, primitiveness makes the first coefficient of $f_i$ a unit, giving $v(\alpha_i(v))=c_i$; if $z_i=0$, the truncation gives $c_i=a$. This argument permits moving $\alpha_i$, infinity contact two, and every cyclic support shape.

Choose one lift $z_Q$ of each original defect point. Raw deck labels biject with the points of the $q$ fiber for one fixed actual map. Consequently
\[
\sum_Q\sum_{r=1}^{a(Q)}|A_{Q,r}|/N=(7+\epsilon)/8,
\qquad A_{Q,r}=\{i:c_i(z_Q)\ge r\},\qquad\sum_Qa(Q)=3.
\]
Here the sets use the $N$ distinct GENERIC directions, whether their fibers happen to collide. Raw multiplicity $8d/N$ has been included before normalization. The same deck bijection converts degrees of any deck-invariant divisor multiset into fixed-fiber multiplicity averages by division by $8d$ as ordinary rational counting, not division of a trace map in characteristic five.

## Moving rank-two flats contain at most eleven directions

Take a generic projective line containing $m\ge2$ generic quotient directions. Let $V\subset E^*$ be their saturated rank-two span. Determinant zeros of two independent $D_i$ and semistability give
\[
-(4+2\epsilon)d\le\deg V\le-4d.
\]
Its annihilator plane $H_V\subset E$ has degree $8d+\deg V\ge(4-2\epsilon)d$. Its saturation $\overline H_V$ in $B_T$ is contained in each actual $h_i^*U$ whose direction belongs to the flat. The independently reviewed source-plane bound $\deg W\le81d/10$ therefore gives
\[
\operatorname{length}(\overline H_V/H_V)\le(41/10+2\epsilon)d.
\]
That source bound follows from the nonzero Frobenius evaluation of $W$, its kernel line of degree at most $49d/2$ inside the accepted stable source kernel, and its image of degree at most $16d$.

Each pair of distinct generic directions in this flat has determinant collision divisor in $V$ of degree
\[
\deg V+2(2+\epsilon)d\le2\epsilon d.
\]
The line inclusions are primitive in $V$ because both $D_i$ and $V$ are saturated in $E^*$, so fiber coincidence is counted by this nonzero determinant divisor.

Take the deck orbit of the flat, of size $L$. Each flat has $m$ generic directions, and every generic direction belongs to the same number $\delta$ of these flats, with $Lm=N\delta$. At one contact level $(Q,r)$, let $fL$ flats have local annihilator saturation length at least $r$. Such flats have ALL their $m$ points in $A_{Q,r}$.

For every other flat, all its positive-level fiber directions collide in one fiber line. This is the key moving-vector point: if its local saturation length is $b<r$, divide the evaluation map $V\to R$, $\alpha\mapsto\alpha(v)$, by $t^b$. Its residual map is nonzero. Every $D_i$ with $c_i\ge r$ has its nonzero fiber in the one-dimensional kernel of that residual map, regardless of its moving first jet. No constant coefficient assertion is made.

The sum of the pair-collision divisors over the flat orbit is deck invariant and has degree at most $L\binom m2 2\epsilon d$. At the selected fiber point, its number of colliding pairs is at most $L\binom m2\epsilon/4\le Lm^2\epsilon/8$. If a nonfull flat has $k$ level points, its $\binom k2$ pairs all collide. Since $k\le1+\sqrt{2\binom k2}$, Cauchy--Schwarz gives the exact incidence estimate
\[
|A_{Q,r}|/N\le f+(1-f)/m+\sqrt\epsilon/2
\le f+1/m+\sqrt\epsilon/2.
\]

Summing the full-flat fractions over all three contact levels is the mean annihilator saturation length divided by $8d$, at most $41/80+\epsilon/4$. Therefore
\[
(7+\epsilon)/8\le41/80+\epsilon/4+3/m+3\sqrt\epsilon/2,
\]
or $29/80-\epsilon/8\le3/m+3\sqrt\epsilon/2$. If $m\ge12$, the right side is strictly less than $1/4+3/28=5/14$, because $\sqrt\epsilon<1/14$. The left side is at least $579/1600>5/14$. This contradiction shows that every GENERIC projective line has at most ELEVEN quotient directions.

## Aggregate fiber contacts force a large generic plane

Every generic independent quadruple of the $D_i$ has determinant divisor in $E^*$ of degree exactly $4\epsilon d$. Sum over all independent quadruples, a deck-invariant set of size $T_4$. The SUM of the numbers of independent quadruples in ALL three contact-level subsets is at most $\epsilon T_4/2$.

Here multiplicity is essential when several levels occur at the same point. In the cyclic Smith frame, the first coefficient of a primitive quotient covector has valuation at least its contact exponent. Hence the quadruple determinant has valuation at least the minimum of the four contact exponents. That minimum is exactly the number of contact levels containing all four directions. Deck-invariant averaging of determinant multiplicities therefore gives the asserted sum bound, with no factor of three. In particular the total is at most $\epsilon N^4/48$.

Let $M$ be the maximum number of generic quotient directions on any generic projective plane. Every subset of $a$ directions has at least $a(a-1)(a-11)/6$ independent triples: its collinear triples are at most $3\binom a2$, by the eleven-point line bound and unique line through each pair. Each such triple has at least $(a-M)_+$ choices of a fourth point outside its plane, and each independent quadruple is counted exactly four times. Thus the subset has at least
\[
\bigl(a^3-12a^2\bigr)(a-M)_+/24
\]
independent quadruples; a negative lower bound is harmless for small $a$.

Write the three contact-level cardinalities as $a_1,a_2,a_3$, including empty levels if necessary, and put $x_j=a_j/N$, $\mu=M/N$, $p=(7+\epsilon)/24$. Their sum is $3p$. The error terms satisfy $12a_j^2(a_j-M)_+\le12N^3$, so the aggregate bound gives
\[
\sum_{j=1}^3 x_j^3(x_j-\mu)_+\le\epsilon/2+36/N.
\]
The function $x\mapsto x^3(x-\mu)_+$ is convex on $x\ge0$: it is zero up to $\mu$, has an upward derivative jump there, and has second derivative $6x(2x-\mu)>0$ above $\mu$. Jensen therefore gives $3p^3(p-\mu)_+\le\epsilon/2+36/N$.

If $\mu\ge p$, then $\mu>1/4$ already. Otherwise $p\ge7/24$ and $p^3>3/125$ imply
\[
\mu\ge p-\frac{\epsilon/2+36/N}{3p^3}
>\frac7{24}-\frac{1/400+36/100000}{9/125}
=\frac{907}{3600}>\frac14.
\]
Thus a generic plane contains MORE than one quarter of all quotient directions. Since $M>11$, a plane attaining $M$ is spanned by its configuration points.

## Generic plane orbit descent and incidence

Let $R$ be the deck orbit size of a generic plane attaining $M$. Its saturated rank-three subbundle of $E^*$ has degree in
\[
[-(6+3\epsilon)d,-6d],
\]
by three independent quotient lines and semistability. It descends integrally through its actual deck stabilizer to the intermediate étale cover of $Y$ of degree $R$. Its degree downstairs is an integer in
\[
[-(6+3\epsilon)R/8,-6R/8].
\]
For $R=1,2,3$ this interval contains no integer whenever $\epsilon<2/3$. Hence $R\ge4$. This replaces equality's exact divisibility $4\mid R$; no constant plane or line splitting is presumed.

Every generic orbit plane contains $M$ generic points. Every point belongs to the same number $\delta$, with $RM=N\delta$. Since $M/N>1/4$ and $R\ge4$, the integer $\delta$ is at least two. Distinct generic planes share at most eleven points, because they intersect in a generic projective line. Pair-plane incidence gives
\[
N\delta(\delta-1)\le11R(R-1)<11R^2.
\]
Use $\delta-1\ge\delta/2$ and substitute $\delta=RM/N$ to obtain $M^2<22N$. Therefore
\[
N<22\cdot16=352,
\]
contradicting $N\ge100000$.

The assumed entire interval $7\le t/n\le7+1/200$ is excluded. Thus the MAIN degree-one first trace satisfies $t>(1401/200)n$. The proof uses semistability of the actual short-contact pullback, moving quotient lines, their actual determinant collision divisors, cyclic local torsion, and the actual source-plane bound. It does not use a positive q0 trace, constant projective directions, strong semistability, or a simultaneous Galois closure.

Contacts above this uniform gap, first trace of larger degree, and the unrestricted common-cover problem remain unresolved.
