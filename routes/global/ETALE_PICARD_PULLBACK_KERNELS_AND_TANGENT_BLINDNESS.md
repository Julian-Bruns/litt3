# Étale Picard pullback kernels and tangent blindness under refinement

Status: AUTHOR PROOF, NOT AUDITED.

Date: 2026-09-05.

This note records a scheme-theoretic calculation and its consequences for actual finite étale covers of smooth proper curves. It does not assert the existence of a common étale cover of prescribed endpoints. Every construction involving a correspondence begins with an actual supplied correspondence. In particular, the mixed p-rank-zero/ordinary discussion is conditional on such a seed correspondence and is not an existence result toward Litt3.

## 1. Conventions and statements

Let \(k\) be algebraically closed of characteristic \(p>0\). All curves below are smooth, proper, and connected over \(k\), and every cover is finite étale and nonempty. Write
\[
J_C=\operatorname{Pic}^0_{C/k},\qquad
r_C=\operatorname{p\!-\!rank}(J_C),\qquad
g_C=\dim J_C.
\]
For a finite abelian abstract group \(A\), let
\[
D(A)=\underline{\operatorname{Hom}}(A_k,\mathbf G_m)
\]
be the Cartier dual of its constant finite étale group scheme. Thus \(D(\mathbf Z/p^a)=\mu_{p^a}\), including its nonreduced scheme structure.

For a finite commutative group scheme \(T\), write \(T_p\) for its canonical p-primary factor and \(T^0\) for its identity component. A finite group scheme is called local-local if it and its Cartier dual are connected. Separability of a homomorphism of abelian varieties with finite kernel always means separability onto its image.

The main conclusions are:

1. For any connected finite étale \(f:Z\to X\), the exact kernel of \(f^*:J_X\to J_Z\) is \(D(A_f)\), where \(A_f\) is the group of the maximal abelian intermediate cover of \(X\) dominated by \(Z\). This applies to non-Galois covers and to degrees divisible by \(p\).
2. With \(b_f=\dim_{\mathbf F_p}\operatorname{Hom}(A_f,\mathbf Z/p)\),
   \[
   \operatorname{rank}d(f^*)=g_X-b_f,\qquad 0\le b_f\le r_X.
   \]
   In particular, \(r_X=0\) makes \(d(f^*)\) injective in every degree.
3. For every actual \(g:Z\to Y\), an actual connected étale refinement \(Z'\to Z\) can be chosen so that the composite \(g':Z'\to Y\) satisfies
   \[
   \operatorname{rank}d(g'^*)=g_Y-r_Y.
   \]
   If \(Y\) is ordinary, this says \(d(g'^*)=0\). No second endpoint and no Hom hypothesis are needed for this assertion.
4. For an actual common cover \(Z\to X,Y\) with \(\operatorname{Hom}(J_X,J_Y)=0\), \(r_X=0\), and \(Y\) ordinary, the sum map
   \[
   \phi:J_X\times J_Y\longrightarrow J_Z,\qquad
   (L,M)\longmapsto f^*L+g^*M
   \]
   has
   \[
   \ker(\phi)_p=\ker(\phi)^0
      =\{0\}\times D((A_g)_p).
   \]
   The image-intersection contributes no p-primary group scheme in this mixed case. The ordinary leg's own kernel is the complete obstruction to separability.

All assertions are proved below. None has been independently audited in this note's creation workflow.

## 2. The exact kernel of one pullback

Choose a connected finite étale Galois closure \(q:W\to X\) of \(f:Z\to X\), with Galois group \(G\). Write \(Z=W/H\) for a subgroup \(H\subseteq G\). Define
\[
A_f
  =G^{\mathrm{ab}}/\operatorname{im}(H)
  =G/\bigl([G,G]\langle H\rangle^{\mathrm{normal}}\bigr).
\]
The associated intermediate cover is the maximal abelian Galois cover of \(X\) dominated by \(Z\). This description makes \(A_f\) independent of the chosen Galois closure, up to the canonical identification of that maximal intermediate cover.

For a non-Galois cover, \(\operatorname{Aut}_X(Z)=N_G(H)/H\) is generally different data. Its abelianization must not be substituted for \(A_f\).

**Theorem 2.1.** There is an isomorphism of finite group schemes
\[
\ker(f^*:J_X\to J_Z)\simeq D(A_f).
\]

**Proof.** Choose compatible \(k\)-points \(w_0\in W\), \(z_0\in Z\), and \(x_0\in X\), and use rigidified degree-zero line bundles to represent the Jacobian functors. For every \(k\)-scheme \(T\), a bundle whose pullback to \(W_T\) is trivial has a unique trivialization normalized at \(w_0\times T\).

Because \(W\) is proper and geometrically connected, with \(H^0(W,\mathcal O_W)=k\), cohomology and flat base change over the field \(k\) give
\[
\Gamma(W_T,\mathcal O_{W_T})
   =\Gamma(T,\mathcal O_T).
\]
This holds locally on arbitrary \(T\), including nonreduced \(T\), and therefore also identifies the unit groups.

Effective fpqc descent identifies line bundles on \(X_T\) with line bundles on \(W_T\) equipped with compatible descent data. Applied to a trivial bundle, the \(G\)-descent data are scalar units on \(T\). The cocycle condition says precisely that these scalars form a character
\[
\chi:G\longrightarrow\Gamma(T,\mathcal O_T^\times).
\]
Changing a trivialization by a scalar does not change \(\chi\). Conversely, every such character descends the trivial bundle to a line bundle on \(X_T\). Its geometric fibers have degree zero because their pullback to \(W\) has degree zero. The descent input is [Stacks Project, Proposition 35.5.2, effective fpqc descent for quasi-coherent sheaves](https://stacks.math.columbia.edu/tag/023T).

The pullback of this descended bundle to \(Z_T=W_T/H\) is trivial if and only if its \(H\)-descent character is trivial. Indeed, an equivariant isomorphism between the two trivial bundles would again be multiplication by a unit on \(T\), which cannot alter a scalar character. Thus the kernel functor is
\[
T\longmapsto
\{\chi:G\to\Gamma(T,\mathcal O_T^\times):\chi|_H=1\}
=D(A_f)(T).
\]
The argument is an identification on all test schemes, not just on \(k\)-points. It therefore proves the asserted scheme-theoretic kernel. \(\square\)

There is no appeal here to a prime-to-\(p\) character decomposition of a representation. In particular, characters valued in \(1+\epsilon k\) on nonreduced test schemes are retained.

## 3. All-degree tangent rank and separability

Let
\[
b_f=\dim_{\mathbf F_p}\operatorname{Hom}(A_f,\mathbf Z/p)
    =\dim_{\mathbf F_p}(A_f/pA_f).
\]
The second equality is equality of dimensions; the displayed vector spaces are dual, not canonically identical.

**Corollary 3.1.** For every connected finite étale \(f:Z\to X\),
\[
\boxed{\quad
\operatorname{rank}d(f^*)=
g_X-\dim_{\mathbf F_p}\operatorname{Hom}(A_f,\mathbf Z/p).
\quad}
\]
In particular,
\[
g_X-r_X\le\operatorname{rank}d(f^*)\le g_X.
\]

**Proof.** A tangent vector of \(D(A_f)\) at the identity is a character on \(k[\epsilon]/(\epsilon^2)\) reducing to \(1\), hence has the unique form
\[
a\longmapsto1+\epsilon\lambda(a),
\qquad
\lambda\in\operatorname{Hom}_{\mathbf Z}(A_f,(k,+)).
\]
Consequently \(\dim_k\operatorname{Lie}D(A_f)=b_f\). The tangent space of \(J_X\) is \(H^1(X,\mathcal O_X)\), of dimension \(g_X\), and taking the tangent space of a scheme-theoretic kernel gives the kernel of the differential.

Every homomorphism \(A_f\to\mathbf Z/p\) pulls back to a character of \(\pi_1^{\mathrm{ét}}(X)\), giving an injection
\[
\operatorname{Hom}(A_f,\mathbf Z/p)
\hookrightarrow H^1_{\mathrm{ét}}(X,\mathbf F_p).
\]
The latter vector space has dimension \(r_X\), proving the bound. The equality between this étale cohomology dimension and the p-rank, together with the Frobenius description of p-rank, is recalled in [M. Saïdi, On complete families of curves with a given fundamental group in positive characteristic, §2, p. 429](https://empslocal.ex.ac.uk/people/staff/ms220/Site/Publications_files/manuscripta.pdf). \(\square\)

**Corollary 3.2.** The following conditions are equivalent:

1. \(f^*\) is separable onto its image.
2. \(d(f^*)\) is injective.
3. \(D(A_f)\) is finite étale.
4. \(p\nmid |A_f|\).
5. \(f\) has no factorization through a connected étale \(\mathbf Z/p\)-cover of \(X\).

Indeed, \(f^*\) has finite kernel: the norm identity \(N_f f^*=[\deg f]\) suffices. A homomorphism with finite kernel is an isogeny onto its image and is separable precisely when its kernel is étale. The description of \(D(A_f)\), and the fact that a nontrivial finite abelian p-group admits a quotient \(\mathbf Z/p\), give the remaining equivalences.

**Corollary 3.3.** If \(r_X=0\), then every connected finite étale \(f:Z\to X\) induces a separable \(f^*\), with
\[
\operatorname{rank}d(f^*)=g_X.
\]
This conclusion does not require \(p\nmid\deg f\). It does not say that every cover of \(X\) has prime-to-\(p\) degree; it only excludes p-torsion in the maximal abelian intermediate-cover group \(A_f\).

## 4. Tangent blindness from actual étale refinement

The following construction starts with a single actual cover. It is independent of any mixed-endpoint question.

Let \(g:Z\to Y\) be a connected finite étale cover and put \(r=r_Y\). The maximal elementary abelian p-quotient of \(\pi_1^{\mathrm{ét}}(Y)\) is
\[
E_Y\simeq(\mathbf Z/p)^r.
\]
Let
\[
h:Y_p\longrightarrow Y
\]
be its connected finite étale Galois cover. When \(r=0\), this means the identity cover. The exponent \(r\) equals \(g_Y\) specifically when \(Y\) is ordinary.

Choose any connected component \(Z'\) of \(Z\times_Y Y_p\). Both projections from the fiber product are finite étale. Their restrictions to \(Z'\) are nonempty finite étale maps to connected curves, hence are surjective. In particular,
\[
a:Z'\longrightarrow Z
\]
is an actual connected finite étale refinement, and \(g'=g\circ a\) factors as
\[
Z'\longrightarrow Y_p\xrightarrow{h}Y.
\]

**Proposition 4.1.** This refinement satisfies
\[
\boxed{\quad
\operatorname{rank}d(g'^*)=g_Y-r_Y.
\quad}
\]

**Proof.** Theorem 2.1 applied to the Galois cover \(h\) gives
\[
\ker(h^*)=D(E_Y)\simeq\mu_p^r.
\]
Since \(g'\) factors through \(h\), this is a closed subgroup scheme of \(\ker(g'^*)\). Its Lie algebra has dimension \(r\), so the kernel of \(d(g'^*)\) has dimension at least \(r\). Corollary 3.1, applied to the actual finite étale cover \(g'\), gives the reverse bound. Thus its kernel has dimension exactly \(r\). \(\square\)

**Ordinary specialization.** If \(Y\) is ordinary, then \(r_Y=g_Y\), the chosen elementary abelian cover has group \((\mathbf Z/p)^{g_Y}\), and
\[
\mu_p^{g_Y}\subseteq\ker(g'^*),
\qquad
\boxed{d(g'^*)=0.}
\]
This full tangent annihilation needs no p-rank hypothesis on any other curve and no Hom-vanishing hypothesis.

**Correspondence specialization.** If an actual seed correspondence
\[
X\xleftarrow{f}Z\xrightarrow{g}Y
\]
is supplied, then \(f'=f\circ a\) is also finite étale, so \(Z'\) is an actual common cover of the same endpoints. Endpoint conditions such as \(\operatorname{Hom}(J_X,J_Y)=0\) are unchanged. If, in addition, \(r_X=0\), Corollary 3.3 gives
\[
\boxed{d(f'^*)\text{ injective}.}
\]
Thus, specifically under \(r_X=0\) and ordinarity of \(Y\),
\[
\operatorname{rank}d\bigl(f'^*+g'^*\bigr)=g_X,
\qquad
\ker d\bigl(f'^*+g'^*\bigr)
   =0\oplus H^1(Y,\mathcal O_Y).
\]

These statements construct refinements of a supplied seed. They do not construct such a seed for arbitrary endpoints and do not show that mixed p-rank-zero/ordinary common-cover pairs exist. If a positive-genus mixed seed exists, the construction gives an inseparable correspondence with those same endpoints.

## 5. Exact kernel of the two-leg map under Hom-vanishing

Now assume an actual correspondence \(X\xleftarrow{f}Z\xrightarrow{g}Y\) and
\[
\operatorname{Hom}(J_X,J_Y)=0.
\]
Set \(u=f^*\), \(v=g^*\), \(n=\deg f\), \(m=\deg g\), and
\[
U=\operatorname{im}u,\qquad V=\operatorname{im}v,\qquad
I=U\times_{J_Z}V.
\]
Here \(U,V\) are their image abelian subvarieties, whereas \(I\) always carries the scheme-theoretic intersection structure.

Let
\[
\phi=(u+v):J_X\times J_Y\to J_Z,\qquad K=\ker\phi.
\]

**Proposition 5.1.** The groups \(K,I\) are finite, and there is an exact sequence of finite commutative fppf group schemes
\[
\boxed{
0\longrightarrow D(A_f)\times D(A_g)
\longrightarrow K
\longrightarrow I
\longrightarrow0.
}
\]
Moreover,
\[
K\subseteq J_X[n]\times J_Y[m],
\qquad
[\gcd(n,m)]I=0.
\]

**Proof.** Principal polarizations and duality show that \(\operatorname{Hom}(J_Y,J_X)=0\) as well. Thus the cross-norm maps vanish:
\[
N_fv=0,\qquad N_gu=0.
\]
Applying the norms to \(uL+vM=0\) gives \([n]L=0\) and \([m]M=0\), as equalities of morphisms on \(K\). This proves the asserted finite-group-scheme containment, hence the finiteness of \(K\).

Define \(K\to I\) by \((L,M)\mapsto uL=-vM\). It has kernel \(\ker u\times\ker v\), identified by Theorem 2.1. It is fppf-surjective: every test-scheme point of \(I\) can fppf-locally be lifted through the isogenies \(J_X\to U\) and \(J_Y\to V\). Thus \(I\) is the finite quotient displayed above.

To check the annihilator directly, the identity
\[
uN_f|_U=[n]_U
\]
can be checked after the fppf-surjection \(u:J_X\to U\), where it is the norm identity. Since \(N_f|_V=0\), it follows that \([n]I=0\). Similarly \([m]I=0\), and Bézout gives \([\gcd(n,m)]I=0\). \(\square\)

It follows, without any p-rank assumptions, that
\[
\boxed{
\phi\text{ separable}
\iff
D(A_f),\ D(A_g),\ I\text{ are all finite étale}.
}
\]
One direction uses that subgroups and quotients of a finite étale group scheme are étale over \(k\); the other uses that an extension of finite étale group schemes is finite étale.

The ordinary intersections \(U(k)\cap V(k)\) do not detect nonreduced structure in \(I\). In particular, point-counting cannot replace the last étaleness condition.

## 6. The mixed p-rank-zero/ordinary case, including the intersection scheme

Assume now, in addition to the hypotheses of §5, that
\[
r_X=0,\qquad Y\text{ is ordinary}.
\]
The isogenies \(J_X\to U\) and \(J_Y\to V\) imply that \(U\) has p-rank zero and \(V\) is ordinary.

For completeness, p-rank invariance under isogeny can be seen without assuming a prime-to-\(p\) isogeny. If \(t:B\to C\) is any isogeny, the size of \(\ker t(k)\) is bounded independently of \(s\). Hence
\[
|B[p^s](k)|/|\ker t(k)|\le |C[p^s](k)|.
\]
Using \(|B[p^s](k)|=p^{s r_B}\), and an isogeny in the opposite direction, gives \(r_B=r_C\). A polarization similarly shows \(r_{B^\vee}=r_B\). The torsion duality used below,
\[
(B[p^s])^D\simeq B^\vee[p^s],
\]
is the standard compatibility between Cartier duality and dual abelian varieties; see [F. Oort, Abelian varieties over finite fields, §8.3](https://math.nyu.edu/~tschinke/books/finite-fields/submitted/oort).

**Lemma 6.1.** Every finite p-primary subgroup scheme \(T\subseteq U\) is local-local.

**Proof.** Choose \(s\) with \(T\subseteq U[p^s]\). Since \(r_U=0\), the finite scheme \(U[p^s]\) has a single geometric point and is connected, so its closed subgroup \(T\) is connected. Cartier duality makes \(T^D\) a quotient of \(U^\vee[p^s]\). The latter is connected because \(r_{U^\vee}=0\). A quotient of a connected finite scheme is connected. \(\square\)

**Lemma 6.2.** The p-primary part \(I_p\) of the scheme-theoretic intersection is trivial.

**Proof.** Suppose \(I_p\ne0\). Then \(S=I_p[p]\ne0\): for any nonzero finite commutative p-primary group scheme, the image of a last nonzero power of multiplication by \(p\) supplies a nonzero subgroup killed by \(p\). Lemma 6.1 shows that \(S\) and \(S^D\) are connected.

On the ordinary side,
\[
V[p]\simeq(\mathbf Z/p)^{\dim V}\times\mu_p^{\dim V}.
\]
Since \(S\) is connected and embeds in \(V[p]\), it embeds in the identity component \(\mu_p^{\dim V}\). Thus it is of multiplicative type, and \(S^D\) is finite étale. But \(S^D\) is also connected, hence trivial over the algebraically closed field \(k\). This contradicts \(S\ne0\), proving \(I_p=0\).

The ordinary p-torsion structure is recalled in [J. Achter and R. Pries, Superspecial rank of supersingular abelian varieties and Jacobians, introduction, p. 606](https://www.numdam.org/item/10.5802/jtnb.916.pdf); the equivalent characterization that the identity component of p-torsion is multiplicative applies to any ordinary abelian variety, as stated in [P. Deligne, Variétés abéliennes ordinaires sur un corps fini, §2, English translation](https://translations.thosgood.net/IM-8-1969-238.pdf). \(\square\)

**Theorem 6.3.** Under the stated mixed hypotheses,
\[
\boxed{
K_p=K^0=\{0\}\times D((A_g)_p).
}
\]
Consequently,
\[
\boxed{
\phi\text{ separable}
\iff g^*\text{ separable}
\iff p\nmid |A_g|
\iff g\text{ has no intermediate connected étale }\mathbf Z/p
\text{-cover of }Y.
}
\]
In addition,
\[
\ker d\phi=0\oplus\ker d(g^*),
\]
\[
\dim_k\ker d\phi
  =\dim_{\mathbf F_p}\operatorname{Hom}(A_g,\mathbf Z/p),
\]
\[
\operatorname{rank}d\phi
  =g_X+g_Y-\dim_{\mathbf F_p}\operatorname{Hom}(A_g,\mathbf Z/p).
\]
The inseparable degree of \(\phi\) onto its image is \(|(A_g)_p|\).

**Proof.** Corollary 3.3 makes \(D(A_f)\) prime-to-\(p\), and Lemma 6.2 makes \(I\) prime-to-\(p\). Taking the canonical p-primary factors in the exact sequence of Proposition 5.1 therefore identifies
\[
K_p=\{0\}\times D((A_g)_p)
\]
via the actual inclusion of the product kernel into \(K\). The right-hand side is connected, while the complementary prime-to-\(p\) factor of \(K\) is étale. Hence \(K^0=K_p\). Taking Lie algebras proves the tangent formulas. Finally, the degree of the connected kernel is the inseparable degree of an isogeny, giving the last assertion. \(\square\)

If only \(r_X=0\) is imposed and ordinarity of \(Y\) is dropped, Lemma 6.1 still proves that \(I_p\) is local-local. There is then a remaining finite local-local intersection obstruction. This note does not assert that it vanishes for arbitrary \(Y\).

## 7. Consequence for arguments using tangent directions

An étale morphism of curves need not give an injective pullback on Jacobian tangent spaces. The exact deficiency is \(b_f\), and it comes from multiplicative group schemes dual to abelian étale intermediate covers.

Even when the source refinement is entirely finite étale, it can annihilate all tangent directions contributed by an ordinary endpoint. This phenomenon already occurs in the one-leg calculation of §4. For a supplied mixed correspondence, the p-rank-zero endpoint's differential remains injective after the same refinement, and the exact mixed kernel calculation proves that no additional p-primary intersection has been silently discarded.

Thus a use of the two-leg map to transport all endpoint tangent directions must either verify the explicit separability condition on the ordinary leg or allow for the displayed kernel. This note supplies those kernel calculations; it does not settle the existence of mixed correspondences or any theta-intersection conclusion that requires further geometric input.

Author-proof status only. No independent audit has been performed.
