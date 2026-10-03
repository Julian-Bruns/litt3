# Proof: the genuine finite source of the original net extension

Version1, 3 October2026. [Statement](../../Theorems/cartier_and_spin/canonical_ten_original_net_genuine_source_extraction.md). The [independent audit](../../Research/notes/oct03_ten_hour/original_net_source_cohomology_audit.md) reviewed the complete new argument in [the frozen author draft](../../Research/notes/oct03_ten_hour/original_net_source_cohomology.md), SHA-256 `2491a17310f453e36d1f0fc15ff44d28947cdb51a8341a95a83e3196bc2430ad`. Its recorded dependency hashes are preserved. This proof extracts that argument; it does not incorporate an unreviewed native Cartier chart or a computation.

## 1. Actual hypotheses and accepted group inputs

Keep the original smooth projective $T$, BOTH actual finite étale legs $h:T\to X$ and $q:T\to Y$, the actual free $G$-torsor $q$, and the faithful canonical degree-ten carrier $\varphi:T\to\Gamma$. The ordinary genus-two $Y$, the relative twists $q_1:T_1\to Y_1$, the embedded stable rank-three degree-one $K\subset B_Y$, the integral $J\subset B_Y$ with $J/K=\mathcal O_{Y_1}$, and the nonzero actual $q_1$-killed $e_J$ are the theorem's hypotheses. None is reconstructed from a source-free bundle.

Ordinarity and $0\to\mathcal O_{Y_1}\to F_{Y*}\mathcal O_Y\to B_Y\to0$ give $H^0(B_Y)=0$: Frobenius on $H^1(\mathcal O_Y)$ is bijective. Consequently $H^0(K)=H^0(J)=0$. In particular the extension cannot split, consistently with the explicit nonzero-class hypothesis.

The accepted [weak-cover reflection proof](../quotient_geometry/local_actions/weak_cyclic_reflection_module_constraints.md) supplies generators $a,b,c$ of the ORIGINAL $G$, with $a,b$ of order five, $c$ the original tame involution, $abc=1$, and $b$ conjugate to $a^{-1}$. The accepted [no-prime-to-five quotient proof](canonical_degree_ten_prime_to_five_quotients.md) implies that every genuine finite character $G\to k^*$ is trivial. Thus every genuine representation has determinant one. The accepted [no-$A_5$/free-kernel proof](canonical_degree_ten_no_a5_quotient.md) excludes an actual $A_5$ quotient and says that any actual quotient $R$ of order greater than five has free kernel on $\Gamma$, retains both completed inertia types, and has $g(\Gamma_R)=|R|/20+1$.

## 2. Genuine simple modules of dimensions one, two and three

The only genuine simple module of dimension one is trivial. Let $U$ be simple of dimension $n>1$, and write $A,B,C$ for its matrices at $a,b,c$. They satisfy $A^5=B^5=C^2=I$, $ABC=I$, and determinant one.

For $n=2$, determinant one makes the semisimple involution $C$ scalar, $C=\pm I$. Hence $B=C^{-1}A^{-1}$, so $A,B,C$ preserve an $A$-eigenline. This contradicts simplicity. The negative scalar alternative also gives $B=-A^{-1}$ and $B^5=-I$, directly impossible.

For $n=3$, scalar $C$ is again reducible. Its non-scalar determinant-one pattern must be $1+(-1)+(-1)$. Therefore the repeated eigenvalue of $AB=C^{-1}$ in the accepted reflection theorem is EXACTLY $\rho=-1$. Its symmetric prime-field conclusion applies: $A,B$ are defined over $\mathbf F_5$, each has a regular $J_3$ block, and they preserve a nondegenerate symmetric form over $\mathbf F_5$. We do not import that theorem's different primitive-sixth-root Hermitian branch.

The image lies in $\operatorname{SO}_3(\mathbf F_5)\simeq\operatorname{PGL}_2(\mathbf F_5)$. One can see the identification by its faithful action on the isotropic conic of a nondegenerate ternary form: after a hyperbolic basis choice the conic $XZ=Y^2$ has parametrization $[s:t]\mapsto[s^2:st:t^2]$, and the determinant-normalized symmetric-square action realizes every projective parameter transformation. The determinant-square quotient of $\operatorname{PGL}_2(\mathbf F_5)$ has order two. Its restriction to our image is trivial by the actual no-prime-to-five quotient theorem. Thus the image is a subgroup of $\operatorname{PSL}_2(\mathbf F_5)\simeq A_5$ containing an element of order five.

Its possible orders are $5,10,15,20,30,60$. The orders $15,20,30$ would give permutation actions of the simple $A_5$ of degrees $4,3,2$, impossible by orders. Order ten has a normal Sylow-five subgroup and a nontrivial order-two quotient. Order five has no nontrivial simple module in characteristic five. Order sixty would be the excluded actual $A_5$ quotient. Hence no such simple three-dimensional module exists. We have proved
\[
U\text{ genuine simple nontrivial}\quad\Longrightarrow\quad\dim U\ge4.
\]
This is a statement about genuine representations of the actual $G$, not about the original positive coefficient multiplier.

## 3. Stability of finite simple sources and integral evaluation

For a genuine module $M$, actual torsor descent gives $E_M$ with $q_1^*E_M=M\otimes\mathcal O_{T_1}$, hence degree zero. It is semistable: a positive-degree subbundle would remain positive after finite étale pullback and contradict semistability of the trivial bundle.

If $M=U$ is simple, $E_U$ is stable. A proper degree-zero subbundle would pull back to a degree-zero subbundle of the trivial bundle. Such a subbundle on a connected proper curve is constant. Indeed its determinant has a nonzero coordinate in a trivial exterior-power bundle; degree zero makes that coordinate invertible, and all resulting Grassmannian coordinates are regular functions, hence constants. Descent then makes this constant subspace $G$-invariant, contrary to simplicity.

The same proof applies at every relative Frobenius height. The corresponding actual torsor trivializes the pullback, with descent representation the Frobenius twist of $U$. Frobenius is an automorphism of $k$, so its twist remains simple. Thus $E_U$ is strongly stable. This uses no positive scalar line or choice of its fifth root.

Now let $0\ne U\subset H^0(T_1,q_1^*K)$ be a genuine simple submodule. It cannot be trivial, since an invariant section descends to $H^0(Y_1,K)=0$. Put $m=\dim U\ge4$. Evaluation descends to a nonzero $E_U\to K$. Its image $I$ is locally free on the smooth curve. If its rank is one or two, it is a proper quotient of stable degree-zero $E_U$, so $\deg I>0$. The saturation of $I$ inside stable rank-three degree-one $K$ has degree at most zero: for ranks one and two stability gives degrees strictly below $1/3$ and $2/3$, respectively. This is a contradiction.

The image therefore has rank three. Since $m\ge4$, it remains a proper quotient of $E_U$, so $\deg I\ge1$. As a full-rank subsheaf of $K$ it has degree at most one. The torsion length of $K/I$ is zero, proving the integral surjection $E_U\twoheadrightarrow K$.

Its kernel $D_U$ has rank $m-3$ and degree $-1$. A proper nonzero rank-$s$ subbundle of this kernel is a proper subbundle of stable degree-zero $E_U$, hence has integral degree at most $-1$ and slope at most $-1/s<-1/(m-3)$. This proves stability; a line kernel is automatic. Since $\det E_U$ is the trivial character line, $\det D_U=(\det K)^{-1}$.

## 4. The actual orbit extension and exact pushout

Because the ACTUAL $q_1$ kills $e_J$, the pulled-back sequence has a splitting. Choose its actual section $t\in H^0(T_1,q_1^*J)$ with constant quotient one. Put $Z=\langle Gt\rangle_k$ and $Z_0=Z\cap H^0(T_1,q_1^*K)$. The quotient map gives an exact sequence of genuine finite modules
\[
0\longrightarrow Z_0\longrightarrow Z\longrightarrow k\longrightarrow0.
\]
Its cocycle is $g\mapsto gt-t$. Invariants in $Z$ or $Z_0$ would descend to sections of $J$ or $K$, so both invariant spaces vanish. A splitting would give an invariant lift of one; thus the sequence is nonsplit and $Z_0\ne0$.

The finite nonzero $Z_0$ has a simple submodule $U$. Part3 shows that this actual $U$ already generates $q_1^*K$ integrally. Any other nonzero $G$-submodule of $Z_0$ likewise contains a simple submodule, hence generates $q_1^*K$. Adding $t$ generates $q_1^*J$ at every point because its quotient is one. This assertion concerns the bundle $J$, and still holds at a fiber where $J\to B_Y$ loses rank.

Descend the evaluations. They give integral surjections $E_{Z_0}\to K$ and $E_Z\to J$ commuting with the quotient identifications with $\mathcal O_{Y_1}$. The snake lemma identifies their kernels, say $D$. The diagram is a pushout: quotienting $E_Z$ by $D\subset E_{Z_0}$ gives $J$, and quotienting $E_{Z_0}$ by $D$ gives $K$, with the same quotient $\mathcal O_{Y_1}$. Thus the image of the finite extension class is EXACTLY the original $e_J$.

For completeness, its cocycle stays nonzero after inclusion into $H^1(G,H^0(T_1,q_1^*K))$. The actual torsor Cartan--Leray sequence gives an injection from this group into $H^1(Y_1,K)$, and sends the cocycle $gt-t$ to the nonzero $e_J$. This is the coherent net class; it is unrelated to an annihilator's lift into $F_{Y*}\mathcal O_Y$.

The common kernel has rank $\dim Z-4$ and degree $-1$. It is stable although $Z$ need not be simple. Semistability of $E_Z$ excludes positive-degree subbundles of $D$. A degree-zero subbundle pulls back to a constant subspace of $Z$ evaluating identically to zero. That contradicts the defining inclusion of $Z$ into actual global sections of $q_1^*J$. Every nonzero proper subbundle of $D$ therefore has integral degree at most $-1$, and the same slope comparison as in part3 proves stability. Its determinant is $(\det J)^{-1}=(\det K)^{-1}$. The nonzero kernel has rank at least one, so $\dim Z\ge5$.

## 5. The minimum orbit dimension forces both long wild lifts

Suppose $\dim Z=5$. Then $\dim Z_0=4$, and its simple socle has dimension at least four, so $Z_0$ is simple. Its tame involution has determinant one and an even number of negative eigenvalues. The scalar alternatives make $B=C^{-1}A^{-1}$ reducible, and the negative scalar also violates $B^5=1$. Thus tame multiplicities are $2+2$ on $Z_0$, hence $3+2$ on $Z$.

The dual exact sequence is $0\to k\to Z^*\to Z_0^*\to0$. Since $Z_0^*$ has no invariants, $\dim(Z^*)^G=1$, while $Z^G=0$. Scott's elementary inequality, which applies to this reducible $Z$, gives
\[
\operatorname{rank}(a-1)+\operatorname{rank}(b-1)+\operatorname{rank}(c-1)
\ge2\dim Z-\dim Z^G-\dim(Z^*)^G=9.
\]
Inverse conjugacy makes the two wild fixed-space dimensions equal, say $f$. The tame rank is two, so $2(5-f)+2\ge9$, forcing $f=1$. Each wild matrix is a single $J_5$ block; its unique invariant hyperplane is $Z_0$, on which it is $J_4$. A split restriction of our extension would instead have $J_4\oplus J_1$ and two fixed vectors. Consequently its restriction is nonzero on BOTH original cyclic-five subgroups.

Let $R$ be the image on $Z_0$, and $N$ the kernel. If $N$ acts trivially on $Z$, the entire extension factors through $R$ and gives a nonzero $H^1(R,Z_0)$ class with the same two nonzero restrictions. Otherwise, after choosing a linear lift of one, elements of $N$ act as translations $v(n)\in Z_0$. The map $v:N\to(Z_0,+)$ is a homomorphism with nonzero finite elementary-five image $A$. Conjugation makes its $k$-span an $R$-submodule, so simplicity makes that span all of $Z_0$. Therefore $\dim_{\mathbf F_5}A\ge4$ and $|A|\ge625$.

The actual image on $Z$ is a finite affine quotient $\widehat R$ with $1\to A\to\widehat R\to R\to1$. We do not assume it splits. Part6 proves the actual étale carrier and p-rank consequences for this case as well.

## 6. General detector and actual affine carrier geometry

The nonsplit orbit extension gives $H^1(G,Z_0)\ne0$. If a short exact sequence has vanishing $H^1$ for both its submodule and quotient, its long exact sequence gives vanishing for the middle module. Induction on a composition series therefore produces a simple composition factor $S$ with $H^1(G,S)\ne0$. This $S$ need not be the socle $U$ used in evaluation; no evaluation of $S$ onto $K$ is claimed.

If $S=k$, then $H^1(G,k)=\operatorname{Hom}(G,k_{\rm add})\ne0$. A nonzero linear functional on its finite nonzero $\mathbf F_5$ additive image gives an ACTUAL $C_5$ quotient of $G$. Absence of prime-to-five quotients does not exclude it.

Otherwise put $m=\dim S\ge4$, $R=\operatorname{im}(G\to GL(S))$ and $N=\ker(G\to R)$. Inflation--restriction gives
\[
0\to H^1(R,S)\to H^1(G,S)\to\operatorname{Hom}(N,S_{\rm add})^R.
\]
For a chosen nonzero class, a zero restriction gives nonzero $H^1(R,S)$. A nonzero restriction gives the actual finite affine image of a cocycle,
\[
\widehat R=\operatorname{im}\bigl[g\mapsto(\rho(g),\xi(g))\bigr],
\qquad A=\xi(N)\ne0.
\]
Here $A$ is elementary-five, its $k$-span is an $R$-submodule, and simplicity gives $|A|=5^r$ with $r\ge m$. This constructs a quotient of the actual original group; it does not realize an arbitrary abstract affine group by a curve.

The nontrivial simple image $R$ has order greater than five. Indeed groups of order at most five are either prime-to-five quotients, excluded here, or five-groups, whose characteristic-five simple modules are trivial. Apply the accepted actual free-kernel theorem to $R$ and $\widehat R$. Both original inertia groups inject into them; their intersections with $A$ are trivial. Quotienting the original $\Gamma$ by the two kernels gives the connected actual $A$-Galois map $\Gamma_{\widehat R}\to\Gamma_R$. It is étale because every stabilizer upstairs injects into $R$. The retained signature gives $g(\Gamma_R)=|R|/20+1$.

A connected elementary-five cover with $|A|=5^r$ supplies $r$ independent characters in $H^1_{\rm et}(\Gamma_R,\mathbf F_5)$. Their independence follows from surjectivity of the actual monodromy onto $A$. This cohomology space has dimension the p-rank; hence $f_5(\Gamma_R)\ge r\ge m$. In part5 the same argument uses $m=4$.

These quotient curves do not replace $T$ and do not descend either original endpoint map. The finite sources extracted here are genuine degree-zero sources, not the paired projective positive coefficient sources. The alternatives above, including the actual $C_5$ quotient and linear-image cohomology, remain unexcluded. No marking, annihilator lifting, ordinary trace preservation or unmarked common-cover decision follows.
