# Proof: contact-seven equality has three distinct simple defects

Version1,2 October2026. Computation-free proof; [focused independent review](../../Research/audits/CONTACT_SEVEN_EQUALITY_AUDIT_2026_10_02.md) PASS. [Statement](../../Theorems/cartier_and_spin/contact_seven_reduced_defect.md). The separate [full equality exclusion](contact_seven_equality_exclusion.md) has now closed the three-simple survivor; this proof preserves the independently reviewed triple-saturation bound. The original common-cover problem remains unsolved.

Retain the actual same-source MAIN span and degree-one first trace $J$ with contact $7n$. Use the actual one-leg closure $q:T\to Y$ of degree $8d$, its conjugate actual maps $h_i:T\to X$ of degree $d$, and $E=q^*J$. The [one-type equality theorem](contact_seven_one_isotypic_type.md) gives $E=A^{\oplus4}$, $\deg A=2d$. The actual quotient-dual lines are $A^{-1}$ times a deck-transitive set of $N$ distinct constant points $p_i\in\mathbf P^3$. They span rank four; $8\mid N$. Every generically independent set of these lines is an integral direct summand, by the equal-slope determinant argument. The cyclic Cartier defect divisor has total degree three.

The stabilizer-kernel quotient of the actual one-leg source gives a same-source finite étale witness of $X$ degree $eN/8$, $e\in\{1,3\}$. Effective MAIN quotient descent therefore forces $N\ge400$: otherwise that actual degree is at most $147$, far below the accepted bound $(335999!)^2$. This is an actual witness comparison, not an assertion about the original source degree alone.

Write $c_i(z)$ for the source contact exponent at a point over a cyclic defect of exponent $a$. In a cyclic Smith model, an additional generator of $B_T/E$ is $t^{-a}v(t)$ with $v$ primitive in $E$. If the constant quotient covector for $p_i$ is $\alpha_i$, then
\[
c_i(z)=\min\{a,v(\alpha_i(v(t)))\}.
\]
Indeed, in the Smith frame $E=(t^ae_1,e_2,e_3,e_4)$, the source primitive covector $f_i$ restricts to $t^{z_i}\alpha_i$, with $z_i=a-c_i$. If $z_i>0$, its first coefficient is a unit and $v(\alpha_i(v))=c_i$. If $z_i=0$, the truncation at $a$ gives the same result. Thus for each $1\le r\le a$, the set of directions with $c_i\ge r$ is cut out by homogeneous linear conditions on their CONSTANT coordinates, obtained from the first $r$ coefficients of $v(t)$.

Choose one lift $z_Q$ of each defect point. Deck labels and fiber points are bijective, so
\[
\sum_Q\sum_i c_i(z_Q)=7d,
\]
where the inner sum has $8d$ raw representatives, each distinct direction occurring $8d/N$ times. Therefore the normalized sum of distinct contact levels is
\[
\sum_Q\sum_{r=1}^{a(Q)} |\{i:c_i(z_Q)\ge r\}|/N=7/8.
\]
The sum of all $a(Q)$ is three.

## No projective line contains nine quotient directions

Let a projective line contain exactly $m\ge2$ of the quotient points, and let $V\subset E^*$ be its saturated rank-two span. Then $V\simeq A^{-1\,\oplus2}$ and its annihilator $H_V\subset E$ is $A^{\oplus2}$, of degree $4d$. The saturation $\overline H_V$ inside $B_T$ lies integrally in each actual source hyperplane whose quotient direction belongs to this projective line. The accepted source Frobenius-kernel estimate from the preceding theorem therefore gives
\[
\deg\overline H_V\le81d/10,\qquad
\operatorname{length}(\overline H_V/H_V)\le41d/10.
\]

Take the deck orbit of this projective line, of size $M$. Each orbit line contains $m$ quotient points and every quotient point belongs to exactly $\delta$ orbit lines; hence $Mm=N\delta$. At a fixed contact level $(Q,r)$, let $F$ orbit lines have all their $m$ points in the level set. Any other orbit line has at most ONE point in the level set, because the level conditions are linear and its points are distinct. Double counting incidences gives, with $f=F/M$,
\[
|\{i:c_i\ge r\}|/N\le f+(1-f)/m\le f+1/m.
\]

An orbit line counted in $F$ has its full rank-two span annihilating $v(t)$ modulo $t^r$. This is equivalent to the corresponding annihilator plane saturation acquiring length at least $r$: its local added length is the minimum, truncated at $a$, of the valuations of two independent constant covectors spanning that line. Thus summing all $f$ over contact levels is the average added saturation length divided by $8d$. Deck invariance identifies fixed-fiber averages with the global degree, and the preceding bound gives
\[
\sum_{Q,r} f\le(41d/10)/(8d)=41/80.
\]
Consequently $7/8\le41/80+3/m$, so $m\le240/29<9$. Every projective line contains at most EIGHT quotient directions. This argument permits several points on a line and overlapping deck-orbit lines; no partition or irreducibility assumption on that orbit is used.

## Independent triples have a strict intersection budget

Every independent triple of quotient covectors has an annihilator line $H\simeq A\subset E$, of degree $2d$. Its saturation $\overline H$ in $B_T$ has degree at most $16d/5$ by nonzero Frobenius adjunction into $\omega_T$. Its added length is therefore at most $6d/5$.

At a contact level $(Q,r)$, the independent triple acquires saturation length at least $r$ exactly when all its three directions have $c_i\ge r$. Sum this statement over ALL independent triples, a deck-invariant set. If $T$ is their total number and $T_{Q,r}$ counts independent triples entirely in that level set, fixed-fiber averaging gives
\[
\sum_{Q,r}T_{Q,r}\le(6d/5)/(8d)\,T=3T/20.
\]
In particular $\sum_QT_{Q,1}\le3T/20$.

For any subset of $s$ quotient directions, its collinear triples are at most $2\binom s2$. Indeed each pair belongs to one projective line; on a line with $m\le8$ selected points, $\binom m3=(m-2)\binom m2/3\le2\binom m2$. Summing over lines gives the bound. Hence its number of independent triples is at least
\[
\binom s3-2\binom s2=s(s-1)(s-8)/6.
\]
Also $T\le N^3/6$.

## A cyclic double point and a separate simple point are impossible

Suppose the cyclic defect is $2Q+P$ with $Q\ne P$. If a finite branch sheet occurs over $Q$, the accepted primitive-order lemma excludes all infinity sheets there. Every positive contact at $Q$ and $P$ has exponent one. Let $s,u$ be the numbers of positive-contact DISTINCT directions at their fixed lifts. The raw averaging identity gives $s+u=7N/8$.

The independent triples in these two contact sets number at least
\[
\bigl(s^3+u^3-9(s^2+u^2)+8(s+u)\bigr)/6
\ge\bigl(343N^3/2048-441N^2/64\bigr)/6.
\]
Here $s^3+u^3\ge(s+u)^3/4$ and $s^2+u^2\le(s+u)^2$. For $N\ge400$ this exceeds $3N^3/120$, because
\[
343/2048-3/20=179/10240,qquad
(441/64)/(179/10240)=70560/179<400.
\]
It therefore exceeds $3T/20$, contradicting the triple budget.

If no finite branch sheet occurs over $Q$, only infinity contributes contact there, with exponent at most two and at most $d$ raw representatives. Thus its total contact is at most $2d$. The simple point must contribute at least $5d$, so its positive-contact distinct set has $s\ge5N/8$. Its independent triples number at least $(s^3-9s^2)/6\ge(125N^3/512-9N^2)/6$. For $N\ge400$ this again exceeds $3N^3/120\ge3T/20$, since $125/512-3/20=241/2560$ and $9\cdot2560/241<400$. This closes the no-branch case, including every infinity exponent and mixed higher jet.

## The singleton triple is also impossible

For completeness the same triple budget excludes a cyclic triple at one point, independently of the older singleton-defect proof. Its contact $7d$ forces a branch sheet, since infinity alone gives at most $2d$. The branch then excludes infinity and all contacts have exponent one. Its positive-contact set has $s=7N/8$. The preceding independent-triple lower bound exceeds $3T/20$ for $N\ge400$, already by the weaker $s\ge5N/8$ estimate. Thus the singleton cyclic triple cannot occur.

This independent argument excludes all cyclic defect patterns except THREE DISTINCT SIMPLE points. The separate full equality theorem closes that survivor too. Neither theorem constructs a common coefficient or closes the original unmarked problem.
