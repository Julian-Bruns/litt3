# Proof: ternary monomial kernels and the actual transversal conductor

Version1, 3 October 2026. [Independent whole mathematical audit PASS](../../Research/audits/OCT03_TRIPLE_BLOCK_THIRTY_THIRTY_SIX_WHOLE_AUDIT_2026_10_03.md); its two required local text corrections are incorporated. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_triple_block_thirty_thirty_six_bridge_exclusion.md). The group argument below is integrated from the fresh independent [research note](../../Research/notes/oct03_ten_hour/triple_block_monomial_kernel.md); all mathematical steps needed here are supplied in this proof.

## Actual source and block hypotheses

Put F=k(t), E=k(B′), A=k(Γ), and L/F the normal closure of the SINGLE actual E/F extension. Its group M acts transitively on 3b sheets arranged in b triples, with b10 if d15 andb12 if d18. Set H=Gal(LA/A). The actual AE=T and degree-ten S10 monodromy give an H-orbit Δ of ten sheets. Intersections with the triple system form an H-invariant partition of the primitive ten-point action. Δ cannot be contained in one triple, so it meets ten distinct triples once. Thus its block action also induces S10.

For b10 the block group is exactly S10. For b12 the block action has an H-orbit of size ten and complement two. It is primitive: a block partition intersecting that orbit in singletons needs at least ten blocks, whereas a proper nontrivial block size on twelve points is at least two; an intersection containing all ten points needs a proper block of size at least ten, also impossible. The kernel of the H-action on the complementary two points has supported A10 image. The block group therefore contains a three-cycle and is A12 orS12.

Let K be the kernel of M's action on the b triples. Each of its coordinate projections is transitive on the triple. Indeed the full triple stabilizer acts transitively there, with image J=C3 orS3; the image of K is normal in J. If it is not transitive, it is trivial. J would then be a quotient of the block point stabilizer S9, A11 orS11. Those groups have no quotient C3 orS3, because their alternating subgroup is perfect and their remaining quotient has order at most two. This is a contradiction.

Consequently all hypotheses of the following finite-group lemma apply to the ACTUAL M, K and H. No presumed complement is inserted.

## Finite-group lemma

## Statement

Let $b\in\{10,12\}$, let $\Omega$ be the disjoint union of $b$ triples, and let
$M\leq S_3\wr G$ have block image $G$, where $G=S_{10}$ if $b=10$ and $G\in\{A_{12},S_{12}\}$ if $b=12$. Let $K$ be the kernel of the block action, assume that each coordinate projection of $K$ is transitive on its triple, and put
$V=K\cap C_3^b$, $B=\operatorname{image}(K\to C_2^b)$.
Identify $C_3^b$ with $W=\mathbf F_3^b$. Let $C=\mathbf F_3\mathbf1$ and $U=\{v\in W:\sum_i v_i=0\}$.

After independently relabeling the triples, exactly one of the following holds:

1. $V=C$, and every element of $M$ has the form
   $(i,x)\mapsto (g(i),\epsilon x+c)$
   with $g\in G$, $\epsilon\in\{1,-1\}$ and $c\in\mathbf F_3$. Consequently $M$ preserves the three blocks $\{(i,x):1\leq i\leq b\}$, one for each $x\in\mathbf F_3$, each of size $b$.
2. $U\leq V$. More precisely, $V=U$ or $V=W$ in these labels.

In the first alternative, $M$ actually contains the ordinary label-preserving $A_b$: the displayed global affine form is a conclusion about the actual subgroup, not just its abstract quotient. Conversely a second system of three blocks of size $b$ cannot occur in alternative 2.

Suppose further that an actual subgroup $H\leq M$ preserves a ten-element set $\Delta$ meeting ten distinct triples once and induces $S_{10}$ on it. In alternative 2:

- For $b=10$, the $M$-orbit of $\Delta$ is one affine augmentation hyperplane, two distinct such hyperplanes, or all $\mathbf F_3^{10}$. Its size is respectively $3^9$, $2\cdot3^9$, or $3^{10}$. When $V=U$ only the first two possibilities occur; when $V=W$ the last occurs.
- For $b=12$, its orbit is the set of all ten-element partial transversals: exactly $\binom{12}{10}3^{10}=3,897,234$ elements.

The subgroup $H$ is needed for the precise $b=10$ orbit assertion. The dichotomy itself, and the $b=12$ orbit assertion, only need the other hypotheses.

## Conventions and one standard presentation

Write each triple as $\mathbf F_3$, so that its $S_3$ acts by $x\mapsto\epsilon x+t$. Then the wreath product is
$W\rtimes(\{\pm1\}^b\rtimes G)$.
For a permutation $g$ use $(gw)_i=w_{g^{-1}i}$. Thus an element $(u,s,g)$ acts on transversal labels by $w\mapsto u+s(gw)$, where $s$ is a coordinate sign vector. Its linear image will be denoted $D\leq\{\pm1\}^b\rtimes G$; the kernel of $M\to D$ is exactly $V$. The kernel of $D\to G$ is $B$.

The sole presentation input is Carmichael's presentation, in the following explicit form: for $n\geq4$,
$A_n=\langle t_1,\ldots,t_{n-2}\mid t_i^3=1,\ (t_it_j)^2=1\ (i\ne j)\rangle$,
where $t_i=(i,n-1,n)$. This is stated as equation (3.1), page 397, of R. M. Guralnick, W. M. Kantor, M. Kassabov and A. Lubotzky, *Presentations of finite simple groups: a computational approach*, JEMS 13 (2011), 391–458, [primary paper](https://ems.press/content/serial-article-files/31768), DOI 10.4171/JEMS/257. All further group/module/cocycle arguments are supplied below.

We also use the elementary facts that $A_n$ is transitive on ordered pairs of distinct letters for $n\geq4$, and that $A_n$ is perfect for $n\geq5$. The first follows by correcting the parity of any chosen permutation using a transposition on two unused letters. For the second, every 3-cycle is a commutator: on five distinct letters, the involutions $(a b)(d e)$ and $(b c)(d e)$ have a 3-cycle as their product, and their commutator is its square. The 3-cycles generate $A_n$.

## 1. Nonconstant binary kernel forces the full ternary kernel

Every coordinate projection of $V$ is nonzero. Indeed, a transitive subgroup of $S_3$ contains a 3-cycle. Lift that 3-cycle to $k\in K$ in the chosen coordinate. Then $k^2\in C_3^b$, since squaring kills every coordinate sign, and its chosen coordinate is still a nontrivial 3-cycle. Hence $k^2\in V$ proves the assertion.

For each coordinate let $\chi_i:B\to\{\pm1\}\subset\mathbf F_3^\times$ be its sign character. Equality of these characters gives a $G$-invariant equivalence relation on the coordinates: conjugation by an element of $M$ permutes the coordinate signs of $K$ by its block permutation. Since $G$ is primitive, either all characters coincide or they are pairwise distinct. The first case says precisely $B\leq\{\mathbf1,-\mathbf1\}$.

In the other case, $V$ is invariant under the diagonal action of $B$. Since $|B|$ is a power of two, the character operator
$E_i=|B|^{-1}\sum_{\beta\in B}\chi_i(\beta)\,\beta$
is defined over $\mathbf F_3$. Character orthogonality shows that it projects $W$ onto its $i$th coordinate line, because the $\chi_i$ are pairwise distinct. The nonzero coordinate projection of $V$ therefore implies $\mathbf F_3 e_i\leq V$ for every $i$. Consequently $V=W$.

For the remainder assume $B\leq\{\mathbf1,-\mathbf1\}$.

## 2. Exact normalization of the signed linear image

Let $D_A$ be the preimage of $A_b$ in $D$. It is a central extension of $A_b$ by $B$, which is trivial or the global sign group of order two. This extension splits for an elementary support reason.

For each Carmichael generator $t_i=(i,b-1,b)$ choose its unique order-three lift $\widetilde t_i\in D_A$. If $B=1$, the sole lift has order three. If $B$ has order two, multiplying a lift by the global negative sign changes its cube by that sign, so exactly one of the two lifts has cube one. An order-three signed permutation has positive sign at every fixed coordinate. Therefore $\widetilde t_i$ is the identity, including its sign, outside the three letters of $t_i$.

The square $(\widetilde t_i\widetilde t_j)^2$ lies in $B$. Outside $\{i,j,b-1,b\}$ the product is the identity, so its square has positive sign there. Since there is such a coordinate, this square cannot be the global negative sign. It is the identity. Carmichael's presentation now supplies a subgroup $J\cong A_b$ projecting isomorphically onto $A_b$, and $D_A=B\times J$.

The complement $J$ is unique: two complements in this central direct product differ by a homomorphism $A_b\to B$, and perfectness makes that homomorphism trivial. In particular $J$ is normalized by all of $D$.

We next normalize $J$ by coordinate signs. Its action on the line at coordinate 1 has a scalar character on the point stabilizer $A_{b-1}$. This character is trivial because the stabilizer is perfect. For each coordinate $i$, transport $e_1$ by an element of $J$ taking 1 to $i$. The resulting signed basis vector $f_i\in\{e_i,-e_i\}$ is independent of the transporter: any two transporters differ by an element of that point stabilizer. Moreover $J$ permutes the $f_i$ without signs. Relabeling each triple by the corresponding sign therefore makes $J$ the ordinary $A_b$.

Every $d=(s,g)\in D$ normalizes this ordinary $A_b$. Conjugation by $d$ of an ordinary $a\in A_b$ has block permutation $gag^{-1}$ and coordinate sign vector
$s\,(gag^{-1}s)^{-1}$.
It must again be ordinary. Thus $s$ is fixed by all of $A_b$, so $s$ is constant. We have proved
$\{1\}\times A_b\leq D\leq\{\pm1\}_{\mathrm{global}}\times G$
after independent sign relabeling. This proves the required signed normalization without assuming a split $S_{10}$ complement.

## 3. The ternary submodule dichotomy

Now $V$ is an ordinary $A_b$-invariant subspace of $W$, and every coordinate projection of $V$ is nonzero. If it consists of constant vectors, it is $C$.

Otherwise choose $w\in V$ and distinct $i,j$ with $w_i\ne w_j$. Among the remaining $b-2\geq8$ coordinates there are distinct $k,l$ with $w_k=w_l$, because there are only three field values. The even permutation $a=(i j)(k l)$ gives
$aw-w=(w_j-w_i)(e_i-e_j)$.
Thus $e_i-e_j\in V$. Ordered-pair transitivity of $A_b$ gives every difference $e_r-e_s$, which span $U$. Therefore $U\leq V$, and its codimension one implies $V=U$ or $W$.

This proof includes the modular case $b=12$, where $C\subset U$. There are no further subspaces to classify.

## 4. Removing the affine obstruction when $V=C$

Put $Q=W/C$. As $M\to D$ has kernel $C$, each $d\in D$ has a uniquely defined translation class $c(d)\in Q$. The multiplication law gives the 1-cocycle identity
$c(de)=c(d)+d c(e)$.
We prove directly that this cocycle is a coboundary, first over $A_b$ and then over $D$.

### Elementary permutation-module cocycle fact

If a group $P$ acts transitively on a finite set $X$, and $c:P\to F^X$ is a cocycle, its $x_0$ coordinate on the stabilizer $P_{x_0}$ is a homomorphism to the additive group of $F$. If that homomorphism is zero, the cocycle is a coboundary.

Indeed, choose $g_yx_0=y$ and put $a_y=c(g_y)_y$. For $g\in P$, the elements $gg_y$ and $g_{gy}$ differ on the right by an element of $P_{x_0}$. The zero stabilizer homomorphism gives
$c(gg_y)_{gy}=c(g_{gy})_{gy}$.
The cocycle identity then yields $c(g)_{gy}=a_{gy}-a_y$. Thus $c(g)=a-ga$. This argument also verifies transporter independence. In particular cocycles into a transitive permutation module vanish up to coboundary when the point stabilizer is perfect.

### Vanishing for the quotient module $W/C$

Let $n=b$, $P=A_n$ and $R=A_{n-1}$ fixing coordinate $n$. As an $R$-module, $Q$ is naturally the ordinary permutation module on the other $n-1$ coordinates: represent a class by the unique vector with coordinate $n$ equal to zero. Its point stabilizer is $A_{n-2}$, which is perfect. The preceding fact allows us to modify the cocycle by a coboundary so that $c|_R=0$.

Take $t=(n-2,n-1,n)$ and $L=R\cap tRt^{-1}$, fixing $n$ and $t(n)$. For $l\in L$, the two expressions $lt=t(t^{-1}lt)$ and the cocycle identity imply
$l c(t)=c(t)$.
Every $L$-fixed class in $Q$ has a representative which is constant on the other $n-2$ coordinates. To see this without any exactness assumption, if $w$ represents the class then $lw-w$ is constant; at coordinate $n$, which $l$ fixes, this difference is zero, so $lw=w$. The natural $A_{n-2}$ action is transitive on the remaining coordinates. Subtracting a global constant, we can therefore write
$c(t)=[a e_n+d e_{t(n)}]$.
Since $t^3=1$, the cocycle identity gives $(1+t+t^2)c(t)=0$. In this representative its norm is $a+d$ at each of the three letters of $t$ and zero outside. Because there are coordinates outside this triple, its class is zero only if $a+d=0$. Hence
$c(t)=[a e_n-a e_{t(n)}]=[a e_n]-t[a e_n]$.
The vector $[a e_n]$ is $R$-fixed. Subtracting this coboundary kills $c(t)$ while keeping $c|_R=0$. Finally $R$ and $t$ generate $A_n$: they contain all Carmichael generators $(i,n-1,n)$ by conjugating $t$ with $R$. This proves $c|_{A_n}=0$ after a single total coboundary adjustment.

There are no nonzero $A_n$-fixed vectors in $Q$. If $[w]$ is fixed, each 3-cycle changes $w$ by a constant; a coordinate outside that 3-cycle shows the constant is zero. Since 3-cycles generate $A_n$, $w$ is constant and $[w]=0$.

For $d\in D$ and $a\in A_n$, compare $ad=d(d^{-1}ad)$. As the cocycle is zero on $A_n$, these identities give $a c(d)=c(d)$. The preceding invariant calculation gives $c(d)=0$. We have proved $c=0$ on all of $D$ after translation relabeling of the individual triples.

Consequently every element of the actual $M$ has constant translation and global sign, as asserted in alternative 1. Since the full constant translation group is in $M$, it also contains the zero-translation lift of every $d\in D$, in particular the ordinary $A_b$. The three horizontal label sets are the required second block system.

### The alternatives are exclusive

Suppose there is any second system of three blocks of size $b$. On an original triple, some $v\in V$ acts as a 3-cycle. If its action on the second blocks is trivial, the whole triple is in one second block; otherwise its action cycles the three second blocks and the triple meets each once. Transitivity on original triples makes this incidence type uniform.

If all original triples are contained in second blocks, those second blocks give a nontrivial $G$-invariant partition of the original triples, contrary to primitivity. Thus every original triple meets every second block once. The action of the elementary abelian group $V$ on the second three blocks has image of order at most three, and is faithful: an element in its kernel fixes each original-triple/second-block intersection, hence every sheet. Therefore $\dim V\leq1$. This excludes $U\leq V$, whose dimension is $b-1\geq9$.

## 5. Exact transversal orbits

If $V=W$, independent translations give every assignment on any specified support. As $G$ is transitive on the required supports, all the stated complete or partial transversals occur. This deals also with the nonconstant-$B$ case from section 1.

Assume $V=U$. Section 2 makes every linear part a global sign times a permutation, so every element of $M$ acts on coordinate sums by
$\sigma\mapsto\epsilon\sigma+\sum_i u_i$.
The $V$-orbits of complete transversals are exactly the hyperplanes of fixed sum.

For $b=10$, preservation of the complete transversal $\Delta$ by $H$ and the induced $S_{10}$ action imply that $H$ projects onto $G=S_{10}$. Therefore $M=KH$ and $M\Delta=K\Delta$. The translation kernel of $K$ is $U$, and $K/U\cong B$ has order at most two. Thus $K\Delta$ consists of one or two entire sum hyperplanes. If $B$ is trivial it is one; if $B$ has order two, its nontrivial element acts on sums as an affine reflection, producing one hyperplane when it fixes the sum of $\Delta$ and two otherwise. There is no unproved assertion that $H$ is an $S_{10}$ complement.

For $b=12$, projection $U\to\mathbf F_3^S$ is surjective for every ten-coordinate support $S$: specify those ten coordinates arbitrarily, choose one omitted coordinate to cancel their sum, and set the other omitted coordinate to zero. Thus $V$ is transitive on all assignments on each support. Both $A_{12}$ and $S_{12}$ are transitive on ten-subsets (equivalently two-subsets), so the $M$-orbit is the full set of partial transversals. This conclusion is independent of a chosen complement and does not require additional information about the action of $H$ on the two omitted triples.


## The small-kernel alternative is impossible on the actual source

The first alternative gives three blocks of size b. Since H's primitive ten-point orbit cannot meet ten different blocks in a system of only three blocks, Δ is contained in one large block. Its distinguished-sheet block field R0 is therefore actual inside E∩A.

For b10 this is exactly the [audited three-ten-block configuration](canonical_ten_three_ten_blocks_disjoint_infinity_exclusion.md), which is excluded. Its proof uses uniqueness of that cubic field, the actual free t→−t involution, and the opposite actual X norm on the forced uniform double fiber.

For b12, E/R0 has degree12. Its induced group is primitive and contains supported A10 by the same ten-plus-two argument, hence is A12 orS12. The complement-two-subset field Z lies inside A. Its normal closure over E is étale: the point stabilizer A11 orS11 acts faithfully on two-subsets avoiding the distinguished sheet, while EZ⊂AE=T is étale over E. Therefore its inertia groups are semiregular on twelve sheets. The subset fixed fraction is at most binom(6,1)/binom(12,2)=1/11, and the termwise different comparison gives
\[
u_Z\ge (10/11)u_E+(1/11)(2g(R_0)-2),
\]
where all u are normalized over R0. The actual ratios are uE=48 anduA=24, and 2g(R0)−2≥−2, so uZ≥478/11>24, contradicting Z⊂A. This is also a special case of the [arbitrary-base small-complement theorem](canonical_ten_small_complement_arbitrary_base_exclusion.md).

## The actual large-kernel resolvent and its hidden own-triple kernel

It remains that the normal ternary group V contains augmentation. Let Ψ=MΔ and R=L^{M_Δ}. The actual H fixes Δ, so R⊂A and ER⊂AE=T. Its degree over F is D=|Ψ|. For b10, D is3^9,2·3^9 or3^10; for b12, D=binom(12,10)3^10=3897234.

Choose the distinguished E-sheet p∈Δ. Let C_p be the kernel of the M_p-action on its orbit of Δ. This action may fail to be faithful: a swap of the other two sheets of p's own triple can be invisible. Precisely, C_p is supported only on those two sheets, hence has order at most two.

To verify the support assertion, V_p contains the augmentation translations with p-coordinate zero. For b10 this subgroup freely varies each of the other nine coordinates while keeping their sum zero, so the M_p-orbit of Δ contains enough complete transversals through p to detect every sheet in every other triple. For b12, this subgroup projects surjectively onto arbitrary labels on any nine other selected triples, using the two omitted triples to adjust the sum. The block point stabilizer A11 orS11 is transitive on nine-subsets of the other eleven triples; every such block permutation lifts to M_p, since a ternary translation adjusts the chosen p-sheet. Thus its orbit contains all partial ten-block transversals through p and likewise detects every sheet outside p's own triple. Explicitly, for every outside sheet q the intersection of all these transversals containing q is exactly {p,q}: any further coordinate can be varied or omitted, compensating its change in another available coordinate. An element fixing every transversal and p must therefore fix q. Only the two unselected sheets in p's own triple remain.

The normal closure of ER/E inside L is L^{C_p}. It is étale over E because ER/E is an actual intermediate of the finite étale T/E. For every conjugate E-sheet q, conjugating this actual finite étale extension gives the corresponding étale L^{C_q}/E_q. No simultaneous endpoint closure is used.

For any inertia group I of L/F this implies
\[
I\cap M_q\subset C_q\qquad\text{for every sheet }q.
\]
If a nonidentity element of I fixes p, it lies in C_p and is supported on the other two sheets of that triple. Choose q in another triple. It also fixes q, so it lies in C_q, with disjoint support. This forces identity, a contradiction. Hence all inertia groups act semiregularly on Ω; so do all their lower ramification subgroups. This conclusion uses all conjugate actual étale legs, rather than claiming the transversal action is initially faithful on each point stabilizer.

## Fixed transversals and the wild-safe conductor contradiction

Let g be a nonidentity inertia element, of order e. Semiregularity gives equal sheet cycles of length e. Consider a block cycle of length ell. If an invariant transversal selects that cycle, its chosen sheet is fixed by the return map g^ell, so it has g-orbit length ell. This must equal e. Thus every selected block cycle has length e; the return map is then identity and gives three choices per selected cycle.

For b10 complete transversals select every block. A fixed transversal therefore needs all block cycles to have length e, with e dividing10. Its count is at most3^(10/e)≤3^5. Since D≥3^9, its fixed fraction is at most1/81.

For b12 partial transversals select exactly ten blocks. A fixed one needs e dividing ten and36, hence e2. A semiregular involution cannot fix an odd triple, so its block permutation consists of six two-cycles. Choosing five cycles and one of three sheet choices on each gives
\[
\#\operatorname{Fix}_\Psi(g)\le\binom65 3^5=1458,
\qquad 1458/D=1/2673<1/81.
\]
All other element orders fix no resolvent point.

Thus every nonidentity element of each inertia subgroup fixes at most D/81 resolvent points. Burnside gives, for any such subgroup B of order bI,
\[
1-\#(\Psi/B)/D\ge(80/81)(1-1/b_I).
\]
The normalized codimension on the original sheet set is exactly1−1/bI. Applying this inequality term by term to the ordinary permutation Artin conductor gives
\[
\frac{\deg\operatorname{Diff}(R/F)}D
\ge\frac{80}{81}\frac{\deg\operatorname{Diff}(E/F)}{3b}.
\]
All lower-ramification weights are nonnegative; the argument includes wild-five inertia at n30 and does not compute characteristic-five invariant dimensions.

The retained E genus ratio is16, so its normalized different over the rational F is18. Hence
\[
\frac{2g(R)-2}D\ge-2+18(80/81)>8.
\]
But the actual separable R⊂A gives that ratio at most (2g(A)−2)/[A:F]=8. This contradiction excludes the large kernel and completes both triple-block exclusions.
