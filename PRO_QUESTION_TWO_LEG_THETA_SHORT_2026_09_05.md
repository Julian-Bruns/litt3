# Two-leg Raynaud-theta properness

Prove or disprove the following auxiliary claim. You have no access to our research files; the relevant established inputs are supplied below.

## Precise claim

Let \(k=\overline{\mathbf F}_5\). Let \(X,Y,Z\) be smooth projective connected curves, with \(Y\) ordinary of genus \(2\), \(X\) nonhyperelliptic of genus at least \(3\), and \(\operatorname{Hom}_k(J_X,J_Y)=0\). Neither Jacobian is assumed simple.

Suppose \(f:Z\to X\) and \(g:Z\to Y\) are finite étale, \(5\nmid\deg(f)\deg(g)\), and
\[
                        k(Z)=f^*k(X)\,g^*k(Y).
\]
Thus the actual joint map is birational onto its image. Degrees are unbounded; neither map is assumed Galois, and Galois-closure group orders may be divisible by \(5\).

For relative Frobenius \(F_C:C\to C^{(1)}\), put
\[
 B_C=F_{C*}\mathcal O_C/\mathcal O_{C^{(1)}}.
\]
Must there exist \(L\in J(X^{(1)})\), \(M\in J(Y^{(1)})\) such that
\[
 H^0\!\left(Z^{(1)},B_Z\otimes f^{(1)*}L\otimes g^{(1)*}M\right)=0?
 \tag{R}
\]
Equivalently, is the image of \(f^{(1)*}+g^{(1)*}\) not contained in the Raynaud theta divisor of \(Z\)? For generic \(N=f^{(1)*}L\otimes g^{(1)*}M\), this asks whether \(H^1(Z^{(1)},N)\to H^1(Z,F_Z^*N)\) is injective.

## Motivation and scope

This supports an investigation of Litt's Problem 3: whether every two smooth projective curves of genus at least two over \(\overline{\mathbf F}_5\) have a common finite étale cover. We seek possible obstructions, without assuming a negative answer.

A proved conditional theorem already uses (R) to make the mixed Jacobian contribution ordinary in independent two-prime abelian towers built from \(f\) and \(g\). A map-descent theorem then controls maps to targets whose Jacobians have no ordinary simple factor. Proving (R) would activate this mechanism; disproving it would identify a genuine limitation. Neither outcome alone resolves Litt's problem: these abelian towers need not exhaust arbitrary correspondence towers. Your task is (R).

## Established inputs: do not spend the answer rederiving these

* Raynaud's \(\Theta_C=\{N:H^0(B_C\otimes N)\ne0\}\) is a proper divisor on the full Jacobian. Étale base change gives \(B_Z\simeq f^{(1)*}B_X\simeq g^{(1)*}B_Y\).
* Minimality implies \(E_M=f^{(1)}_*g^{(1)*}M\) is stable of degree zero for generic \(M\). Projection formula rewrites the group in (R) as \(H^0(X^{(1)},B_X\otimes L\otimes E_M)\).
* The translated tangent map of \(Z\to J_X\times J_Y\), defined by \(f^*H^0(\omega_X)+g^*H^0(\omega_Y)\), is birational onto its image.
* Properness is already proved if either leg's Galois-closure group has commutator subgroup a \(5\)-group. It also follows if the quotient of \(J_Z\) by the abelian image of \(f^*+g^*\) is ordinary.
* Every irreducible component of \(\Theta_Y\) is ample for ordinary genus-two \(Y\), even when \(J_Y\) is not simple.
* For the singular joint image \(C\subset X\times Y\), normalization adjunction and the usual residue-Cartier formula are available. Both étale projections give conductor \(\mathfrak c=H_x\overline{\mathcal O}_C=H_y\overline{\mathcal O}_C\) locally for \(C=(H=0)\). Sheaf-surjectivity of the adjoint Cartier operator is known; generic surjectivity on global twisted sections is not.

These are working lemmas you may use. Flag a specific error if you find one. Neither stability, tangent-map birationality, nor an ample numerical theta class is by itself a proof of (R).

## Essential safeguards and sources

One-leg restricted theta can be identically bad by Raynaud's constructions. Such a cover is not a counterexample without a second actual étale leg and the stated minimality. Refining an old common source and composing both maps destroys minimality. Formal local examples and geometric-generic-curve results do not settle this statement over \(\overline{\mathbf F}_5\).

Relevant sources: [Raynaud's theta theorem, Theorem 4.1.1](https://www.numdam.org/article/BSMF_1982__110__103_0.pdf); Raynaud, *Revêtements des courbes en caractéristique p>0 et ordinarité*, Compositio Math. 123 (2000), Theorem 17 and Corollary 18; [Tong, §1.2.7 and Corollary 4.2.3.3](https://arxiv.org/pdf/0712.2046). Search further literature as useful, checking the actual hypotheses and relevant proof.

Lead with your verdict and give a complete proof or a global algebraic counterexample satisfying every hypothesis. If unresolved, distinguish new proved results from the supplied inputs and isolate the exact remaining implication. A partial theorem should cover an unbounded-degree class beyond the cases already listed. Do not substitute a research plan or an attempt to solve all of Litt's problem.
