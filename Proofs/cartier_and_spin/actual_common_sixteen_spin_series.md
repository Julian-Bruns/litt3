# Proof: actual étale spin refinement, basepoint freedom, and index eight

Version1,2 October2026. Computation-free scoped proof; focused whole-argument review PASS. [Statement](../../Theorems/cartier_and_spin/actual_common_sixteen_spin_series.md).

## Construct an actual refinement

Begin with the connected Galois closure $q_0:T_0\to Y$ of the ONE actual genus-two leg of the given source. It is an actual finite étale cover. The original $X$ map pulls back and its deck conjugates are actual finite étale maps $h_i:T_0\to X$ of the same degree $d_0$, while $\deg q_0=8d_0$. Their canonical identities give
\[
(h_i^*O_X(O))^{16}\simeq\omega_{T_0}.
\]
Thus every ratio $h_i^*O_X(O)\otimes(h_0^*O_X(O))^{-1}$ is sixteen-torsion. Characteristic five is prime to sixteen, so each such line is trivialized by its actual finite étale Kummer torsor. Take the fiber product of the finitely many torsors and a connected component. Then take its Galois closure over $Y$. These are actual finite étale constructions; the latter is a further closure of the one chosen leg and is not a presumed simultaneous Galois closure of the original two legs.

Call the resulting cover $q:T\to Y$ and write its degree as $8d$. Every pulled original conjugate $h_i:T\to X$ has degree $d$. The new deck group maps the projection to $T_0$ to a deck conjugate projection, because $T_0\to Y$ was Galois. Consequently it permutes precisely these pulled actual $X$ maps, with repetitions allowed. Their infinity lines are all isomorphic by construction. Put $L=h_0^*O_X(O)$; then $\deg L=d$ and $L^{16}\simeq\omega_T$.

Each actual reduced divisor $h_i^*O$ supplies a canonical nonzero section $u_i$ of its line, and chosen line isomorphisms place them in $H^0(T,L)$. Their span $W$ is independent of the choices up to the evident constant rescalings. Since any two sections with the same effective divisor differ by a nonzero constant on a smooth projective connected curve, the deck group permutes their projective lines.

## Basepoint freedom uses the actual free deck orbits

Let $D_{\rm base}$ be the common zero divisor of all $u_i$. Their deck permutation makes it $G$ invariant. It is bounded by any one reduced divisor $h_i^*O$, so $\deg D_{\rm base}\le d$. But $q$ is an actual connected Galois étale cover, and over the algebraically closed field its deck group acts freely on geometric points. A nonzero invariant effective divisor has degree at least $|G|=8d$. Therefore $D_{\rm base}=0$, and $W$ generates $L$ everywhere.

This argument counts actual free point orbits. It is not an abstract finite-group concentration claim or an assumption that a common cover is Galois on both original legs.

## The determinant cancels the scalar cocycle

The isomorphism class of $L$ is $G$ invariant. Choose isomorphisms $\phi_g:g^*L\to L$; their compositions differ by scalar constants $c(g,h)$. The induced projective action on $W$ has the same scalar cocycle. Write $r=\dim W>0$. The line
\[
L^r\otimes(\det W)^*
\]
has the induced $G$ linearization: the scalar cocycle from $\phi_g^r$ is canceled by that from the dual determinant action. Ordinary tensor symmetry supplies the cocycle identity, so this is actual torsor descent data. It descends through $q$ to a line on $Y$.

Its degree upstairs is $rd$, since the constant determinant factor has degree zero. Hence the downstairs degree is $rd/(8d)=r/8$, an integer. This proves $8\mid r$ and $r\ge8$. The projective coefficient space and the positive line are not separately descended as common bundles to both endpoints.

Under $L^{16}\simeq\omega_T$, the section $u_i^{16}$ has the same divisor $16h_i^*O$ as the actual pulled theta form $h_i^*(dx/y^2)$. Their ratio is constant. Absorb its sixteenth root into $u_i$, using algebraic closedness, to obtain the asserted common identification.

## Additional actual contact-eight jet constraint

Under the hypotheses of the noncyclic contact-eight branch-fiber theorem, every point of $q^{-1}(Q)$ is a finite branch point for every $h_i$. The original-net fiber images coincide with one plane spanned by an order-one primitive column and the intrinsic order-four line $F_4$.

In a common local parameter $t$, $x_i-a_i$ has order three. Choose an original-net polynomial $f_i$ with $f_i(a_i)\ne0$; the primitive-order-one column guarantees one exists. Then $f_i(x_i)=f_i(a_i)+O(t^3)$. The associated differential $f_i(x_i)h_i^*\theta$ agrees with a constant multiple of $h_i^*\theta$ through coefficient order two. The $F_4$ column evaluates to coefficient order three. Consequently the common primitive plane gives
\[
\theta_i/\theta_j=\lambda_z+O(t^3).
\]
Since $\theta_i/\theta_j=(u_i/u_j)^{16}$ and sixteen is invertible in characteristic five, $u_i/u_j$ also has constant jets through order two. All $u_i$ are nonzero at these branch points. Thus any linear combination in $W$ vanishing at one such point vanishes there to order at least three.

A nonzero section of $L$ has zero divisor of degree $d$, so it vanishes at at most $d/3$ of the $8d$ actual points of $q^{-1}(Q)$. This proves the hyperplane density at most $1/24$, counting labeled points even when their projective evaluations coincide. The evaluation functionals span $W^*$, since otherwise a nonzero section would vanish on the entire fiber, with zero degree at least $24d>d$. Choose $r-1$ independent evaluation functionals and a nonzero section in their common kernel. It vanishes at these $r-1$ points to order at least three, so $3(r-1)\le d$, proving $r\le d/3+1$.

The general spin series and this additional jet constraint remain implications of an assumed actual common cover. They supply no common-cover construction or exclusion by themselves.
