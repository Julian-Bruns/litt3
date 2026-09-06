# Étale theta images and global generation after quotient twisting

Date: 2026-09-05. Status: NEW GENERAL THEOREMS, author proof, not independently audited.

All varieties are over an algebraically closed field. The arguments hold in arbitrary characteristic. No existence of common étale covers, properness of restricted Raynaud theta, or solution of Litt3 is asserted.

## 1. Norms along arbitrary isogenies

**Lemma.** Let \(u:B\to A\) be an isogeny of degree \(a\), and let \(M\) be a line bundle on \(B\). Then
\[
u^*\operatorname{Nm}_u(M)\equiv M^{\otimes a}.
\]
Here \(\equiv\) means numerical equivalence. If \(M\) is ample, its norm is ample. No separability assumption is required.

**Proof.** An isogeny is finite locally free. Its norm line bundle is
\[
\operatorname{Nm}_u(M)=\det(u_*M)\otimes\det(u_*\mathcal O_B)^{-1}.
\]
Formation of this norm commutes with base change. See [Stacks, Norms, Lemma 31.18.6](https://stacks.math.columbia.edu/tag/0BD2) for the finite locally free norm and its arbitrary base change property.

Put \(K=\ker u\), with its full finite group scheme structure. Identify
\[
B\times_A B\simeq B\times K,
\qquad (b,k)\longmapsto(b,b+k).
\]
Writing \(q:B\times K\to B\) for projection and \(s(b,k)=b+k\), base change gives
\[
u^*\operatorname{Nm}_u(M)=\operatorname{Nm}_q(s^*M).
\]
For each closed point \(k\in K\), filter its local Artin algebra by a composition series. Its residue field is the ground field. Tensor this filtration with \(s^*M\); pushing along \(q\) produces a filtration whose successive quotients are \(t_k^*M\), repeated
\(\ell_k=\operatorname{length}\mathcal O_{K,k}\) times. Determinants are multiplicative in such filtrations. The analogous denominator contributes a constant one-dimensional vector space, hence a trivial line bundle. Consequently, as line-bundle classes,
\[
u^*\operatorname{Nm}_u(M)\simeq
\bigotimes_{k\in K(k)}(t_k^*M)^{\otimes\ell_k}.
\]
Each translate is algebraically equivalent to \(M\), and \(\sum_k\ell_k=a\). This proves the claimed equivalence, retaining every nonreduced multiplicity. If \(M\) is ample, the displayed tensor product is ample; ampleness descends through a finite surjective morphism, proving the last assertion. \(\square\)

## 2. The theta polarization on an étale Picard image

Let \(f:Z\to X\) be a connected finite étale cover of smooth proper connected curves, of degree \(d\). Choose line bundles \(T_X,T_Z\) representing the canonical principal polarizations on their Jacobians. Put
\[
A=\operatorname{im}(f^*:J_X\to J_Z),\qquad
u:J_X\to A,\qquad L_A=T_Z|_A.
\]
Let \(C_f\) be the abstract finite abelian group of the maximal abelian intermediate cover of \(X\) dominated by \(Z\), and set \(a=|C_f|\).

**Theorem.** The isogeny \(u\) has degree exactly \(a\), the integer \(a\) divides \(d\), and the ample line bundle
\[
N=\operatorname{Nm}_u(T_X)
\]
satisfies
\[
L_A\equiv N^{\otimes(d/a)}.
\]
If \(d/a\ge2\), every \(L_A\otimes\alpha\), \(\alpha\in\operatorname{Pic}^0(A)\), is globally generated. If \(d/a\ge3\), every such twist is very ample. In particular, every cover which is not an abelian Galois cover has globally generated induced theta on its Picard image, including all its algebraically trivial twists.

**Proof.** The scheme-theoretic kernel theorem in [Étale Picard pullback kernels, Theorem 2.1](ETALE_PICARD_PULLBACK_KERNELS_AND_TANGENT_BLINDNESS.md) gives
\(\ker u=D(C_f)\), whose length is exactly \(a\). Thus \(\deg u=a\), including in characteristic dividing \(a\).

More explicitly, choose a Galois closure with group \(G\) and write \(Z=W/H\). Put \(R=[G,G]\langle H\rangle^{\mathrm{normal}}\). Then
\[
d=[G:H],\qquad a=[G:R],\qquad d/a=[R:H].
\]
This proves divisibility. It also proves that \(a=d\) precisely when \(R=H\), namely when \(H\) is normal and \(G/H\) is abelian. This is precisely the condition that \(f\) itself be an abelian Galois cover; no assertion about the automorphism group of a non-Galois cover is used.

Compatibility of the canonical Jacobian polarizations with pullback and norm gives
\[
u^*L_A\equiv T_X^{\otimes d}.
\]
Indeed, the polarization homomorphism of \((f^*)^*T_Z\) is the composite of the dual of \(f^*\), the canonical polarization of \(J_Z\), and \(f^*\). Under the canonical principal polarizations the dual map is \(N_f\), and \(N_f f^*=[d]\). Thus its polarization homomorphism is \(d\lambda_{T_X}\).

The norm lemma gives \(u^*N\equiv T_X^{\otimes a}\), so, with \(m=d/a\),
\[
u^*(L_A\otimes N^{-m})\equiv0.
\]
Numerical pullback by a finite surjective map is injective: testing on a curve downstairs and a curve above it, the projection formula multiplies the degree by a positive integer. Hence \(L_A\equiv N^m\).

On an abelian variety a numerically trivial line bundle lies in \(\operatorname{Pic}^0\). Thus \(L_A\otimes\alpha=N^m\otimes\beta\) for some \(\beta\in\operatorname{Pic}^0(A)\). Since \(N^m\) is ample, its polarization isogeny is surjective on geometric points. Every such twist is therefore a translate of \(N^m\). The classical powers theorem for ample line bundles on abelian varieties gives global generation for \(m\ge2\) and very ampleness for \(m\ge3\). These statements hold in every characteristic. For the classical very ampleness statement see [Milne, Abelian Varieties, Chapter I, §6](https://www.jmilne.org/math/CourseNotes/AV.pdf); the global generation statement also follows directly from the M-regularity criterion cited below, applied to \(N\) and \(N^{m-1}\). \(\square\)

The degree-one case \(m=1\) is outside these sufficient bounds; the theorem does not claim failure of global generation for abelian covers. Zero-dimensional Jacobians cause no exception: their line bundles are generated and very ample.

## 3. Global generation from a generated restriction and an ample quotient twist

The following statement holds for any ample line bundle, so the principal polarization hypothesis is unnecessary.

**Theorem.** Let \(J\) be an abelian variety, \(A\subseteq J\) an abelian subvariety, and \(\pi:J\to Q=J/A\) the quotient. Let \(T\) be an ample line bundle on \(J\). Suppose \(T|_A\) is globally generated. For every ample line bundle \(D\) on \(Q\) and every \(P\in\operatorname{Pic}^0(J)\), the line bundle
\[
T\otimes\pi^*D\otimes P
\]
is globally generated.

**Proof.** Write \(F=T\otimes P\) and \(E=\pi_*F\). The restriction \(T|_A\) is ample. Every algebraically trivial twist of an ample line bundle is a translate of it, because its polarization homomorphism is a surjective isogeny. The hypothesis therefore implies that all twists of \(T|_A\) are globally generated.

Each geometric fiber of \(\pi\) is a translate of \(A\). After identifying such a fiber with \(A\), its restriction of \(F\) is \(T|_A\) tensored with an algebraically trivial line bundle. It is consequently ample and globally generated, and has no higher cohomology. Cohomology and base change now gives
\[
R^i\pi_*F=0\quad(i>0),
\qquad E\text{ locally free},
\qquad E\otimes k(q)\simeq H^0(\pi^{-1}(q),F|_{\pi^{-1}(q)}).
\]
The relative evaluation map \(\pi^*E\to F\) is surjective: its restriction to each geometric fiber is the usual surjective evaluation map, so its cokernel vanishes by Nakayama.

For every \(\gamma\in\operatorname{Pic}^0(Q)\), projection formula and Leray give
\[
H^i(Q,E\otimes\gamma)
\simeq H^i(J,T\otimes P\otimes\pi^*\gamma)=0\qquad(i>0).
\]
The last equality is the index-zero theorem for ample line bundles on an abelian variety, valid in arbitrary characteristic. Thus \(E\) satisfies IT(0), hence is M-regular. The ample line bundle \(D\) also satisfies IT(0). [Pareschi–Popa, Regularity on abelian varieties I, Theorem 2.4](https://people.math.harvard.edu/~mpopa/papers/abv1.pdf) implies that \(E\otimes D\) is globally generated. Their background conventions on printed p. 5 explicitly allow any algebraically closed field; this theorem has no characteristic-zero hypothesis.

Pull back the evaluation of \(E\otimes D\), and compose with relative evaluation tensored by \(\pi^*D\). Both arrows are surjective:
\[
H^0(Q,E\otimes D)\otimes\mathcal O_J
\twoheadrightarrow \pi^*(E\otimes D)
\twoheadrightarrow F\otimes\pi^*D.
\]
This proves the assertion. \(\square\)

In particular, take \(J=J_Z\), \(T=T_Z\), and \(A=f^*J_X\). If \(f\) is not an abelian Galois cover, Section 2 verifies the restriction hypothesis. Every ample quotient twist \(T_Z\otimes\pi^*D\otimes P\) is therefore globally generated. This conclusion concerns these line bundles and their complete linear systems only; it does not identify them with a separately constructed restricted Raynaud theta linear system.
