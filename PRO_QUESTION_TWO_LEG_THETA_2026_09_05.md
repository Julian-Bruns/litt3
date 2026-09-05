# A bounded question about two unramified maps and Raynaud theta

Please investigate the precise statement (R) below. The goal is a proof or an actual algebraic counterexample, not a solution of the full common-étale-cover problem. This prompt contains the relevant context; you do not have access to our research files.

## The question

Work over \(k=\overline{\mathbf F}_5\). All curves below are smooth, projective, and connected.

Let \(Y/k\) have genus \(2\) and be ordinary, meaning its Jacobian has \(5\)-rank \(2\). Let \(X/k\) be nonhyperelliptic of genus at least \(3\), with
\[
                         \operatorname{Hom}_k(J_X,J_Y)=0.
\]
No simplicity assumption on either Jacobian is imposed.

Suppose there are finite étale maps
\[
                         X\xleftarrow{\,f\,}Z\xrightarrow{\,g\,}Y
\]
such that:

* \(5\nmid\deg(f)\deg(g)\), with no upper bound on these degrees;
* \(k(Z)=f^*k(X)\,g^*k(Y)\) inside \(k(Z)\).

The second condition means the actual joint map \((f,g):Z\to X\times Y\) is birational onto its image. It is essential. Neither map is assumed Galois. The orders of their Galois-closure groups are allowed to be divisible by \(5\).

For a curve \(C\), let \(F_C:C\to C^{(1)}\) be relative Frobenius and set
\[
 B_C=\operatorname{coker}\bigl(\mathcal O_{C^{(1)}}\longrightarrow
                                      F_{C*}\mathcal O_C\bigr).
\]
Thus \(B_C\) has rank \(4\) and degree \(4(g(C)-1)\). Write \(f^{(1)},g^{(1)}\) for the Frobenius twists of the maps. Define the closed locus
\[
 D_{f,g}=\left\{(L,M)\in J(X^{(1)})\times J(Y^{(1)}):
 H^0\!\left(Z^{(1)},B_Z\otimes f^{(1)*}L\otimes g^{(1)*}M\right)
 \ne0\right\}.
\]

**(R): Must \(D_{f,g}\) be a proper closed subset?**

Equivalently, does at least one pair of degree-zero line bundles \(L,M\) make this cohomology group zero? Equivalently, is the image of \(f^{(1)*}+g^{(1)*}\) not contained in the Raynaud theta divisor of \(Z\)?

For generic \(N=f^{(1)*}L\otimes g^{(1)*}M\), both \(N\) and \(F_Z^*N\) are nontrivial, and the question is whether the natural Frobenius-induced map
\[
              H^1(Z^{(1)},N)\longrightarrow H^1(Z,F_Z^*N)
\]
is injective, hence an isomorphism. Both spaces then have dimension \(g(Z)-1\).

## Why this particular question helps

We already have a conditional theorem: properness of \(D_{f,g}\) allows independent abelian towers built from the two actual maps, using two distinct primes different from \(5\), to have an ordinary genuinely mixed Jacobian contribution after finite cutoffs. Here “mixed” is the isogeny component killed by averaging along either of the two tower directions. Its ordinarity, together with a proved map-descent criterion, forces every étale map from these rectangles to a hyperbolic curve whose Jacobian has no ordinary simple factor to descend to one of the two boundary directions.

Thus a proof of (R) supplies a specific missing hypothesis for an existing all-degree mechanism. A counterexample identifies an actual two-map obstruction that that mechanism must accommodate. This remains useful if we change \(X\) or choose a different ordinary genus-two \(Y\).

Even a proof of (R) would not resolve the common-cover problem: these controlled abelian rectangles are not known to exhaust the towers forced by arbitrary correspondences. Do not try to prove that further assertion here.

## Available results: use these rather than rederiving them

The following are existing working lemmas and checked literature inputs. You may use them; if you find a specific error in one that affects your argument, identify it explicitly.

1. **Full-Jacobian theta and étale base change.** Raynaud's theorem makes
   \[
       \Theta_C=\{N\in J(C^{(1)}):H^0(B_C\otimes N)\ne0\}
   \]
   a proper effective divisor. Étale base change gives
   \(B_Z\simeq f^{(1)*}B_X\simeq g^{(1)*}B_Y\).
   This does not automatically imply properness on a smaller abelian subvariety.

2. **The special pushforward family is generically stable.** Minimality of the joint map implies
   \[
                    E_M=f^{(1)}_*g^{(1)*}M
   \]
   is a stable degree-zero bundle on \(X^{(1)}\) for \(M\) in a nonempty open subset of \(J(Y^{(1)})\). A proof uses the Galois closure of \(f\): the pulled-back bundle splits into line bundles \(h_i^*M\), where the sheet maps \(h_i\) to \(Y^{(1)}\) are distinct. Their pullback homomorphisms on Jacobians are distinct, so the summands are pairwise nonisomorphic for generic \(M\); transitivity excludes a proper invariant slope-zero subbundle. Consequently
   \[
     H^0(B_Z\otimes f^{(1)*}L\otimes g^{(1)*}M)
       =H^0(X^{(1)},B_X\otimes L\otimes E_M).
   \]
   Mere stability is not a general theorem guaranteeing a theta divisor.

3. **The translated tangent map is already birational.** The map
   \(Z\to J_X\times J_Y\) obtained from the two Abel–Jacobi maps has translated tangent map given by
   \[
        f^*H^0(X,\omega_X)+g^*H^0(Y,\omega_Y)\subset H^0(Z,\omega_Z).
   \]
   This map to projective space is birational onto its image under our hypotheses. Canonical ratios recover \(k(X)\); writing \(k(Y)=k(t,y)\), \(y^2=P(t)\), cross-block differential ratios recover \(y\) as well as \(t\). Minimality then recovers \(k(Z)\). Separability alone was already automatic from either étale leg and is insufficient.

4. **Known sufficient cases of properness.** If the Galois-closure group of either leg has commutator subgroup a \(5\)-group, its permutation bundle has a filtration by torsion line bundles. A finite union of translates of the endpoint Raynaud divisor then proves properness even on that one axis. More generally, for an abelian subvariety \(A\subset J_C\), ordinarity of \(J_C/A\) implies \(A^{(1)}\not\subset\Theta_C\), by Raynaud's Dirac property on the connected local part of the Verschiebung kernel. Reproving either case is not new progress on (R).

5. **What genus two provides.** For ordinary genus-two \(Y\), every irreducible component of \(\Theta_Y\) is ample; in particular it contains no translate of a positive-dimensional abelian subvariety. This does not require \(J_Y\) to be simple. It controls fixed-prime-support abelian towers over \(Y\), but by itself says nothing about an arbitrary restricted theta divisor on \(Z\).

6. **The actual singular joint image has an adjoint-Cartier description.** Put \(S=X\times Y\), let \(C\subset S\) be the joint image, and let \(\nu:Z\to C\) be its normalization. If \(\mathcal A\subset\mathcal O_S\) is the inverse image of the conductor ideal, then
   \[
    0\to\omega_S\to\mathcal A\omega_S(C)\to (j\nu)_*\omega_Z\to0.
   \]
   In local coordinates with equation \(H(x,y)=0\), Cartier on residues is
   \[
       \mathcal C_Z(h\,dx/H_y)=T_{xy}(H^4h)\,dx/H_y,
   \]
   where \(T_{xy}\) selects monomials whose two exponents are \(4\bmod5\), divides the shifted exponents by \(5\), and takes fifth roots of coefficients. Intrinsically the output lies on the Frobenius twist. Both étale projections imply each completed branch is \(y=\phi_i(x)\), with \(\phi_i'\) a unit, and the conductor in the normalization is \(H_y\overline{\mathcal O}_C=H_x\overline{\mathcal O}_C\). The resulting adjoint Cartier map is sheaf-surjective; generic surjectivity on global twisted sections remains unproved.

## Counterexamples and shortcuts already checked

One-leg restricted theta can be identically bad: Raynaud's finite-monodromy representations without theta divisors supply such examples. They are not counterexamples to (R) unless an actual second étale map satisfying all the hypotheses is constructed.

In particular, replacing a source \(Z_0\) by a further étale cover \(Z\to Z_0\) and composing both old maps violates minimality when the refinement has degree greater than one. Two automorphism-conjugate quotient maps have isomorphic targets, so they do not meet the genus-two/nonhyperelliptic target conditions here.

Formal local models do not settle the global question. Even the complete differential ratios do not determine conductor Frobenius: in characteristic \(5\), the three branches
\[
       x,\qquad x+x^4,\qquad x+2x^4+\varepsilon x^5
       \quad(\varepsilon=0,1)
\]
have identical pairwise contact orders and differential ratios, but the rank of Frobenius on their length-\(12\) normalization quotient is respectively \(3\) and \(4\). This is only a local test, not a global counterexample.

Do not infer nonvanishing of the restricted determinant section from its ample numerical class. Do not replace the two maps by unrelated Galois closures. A result for the geometric generic curve does not automatically apply to every curve over \(\overline{\mathbf F}_5\).

## Relevant primary sources

* Raynaud, *Sections des fibrés vectoriels sur une courbe*, Theorem 4.1.1:
  https://www.numdam.org/article/BSMF_1982__110__103_0.pdf
* Raynaud, *Revêtements des courbes en caractéristique p>0 et ordinarité*, Compositio Math. 123 (2000), especially Theorem 17 and Corollary 18:
  https://www.cambridge.org/core/services/aop-cambridge-core/content/view/16AB72912D3CE32BFC5D012B1025A8E4/S0010437X00000440a.pdf/revetements-des-courbes-en-caracteristique-pandgt0-et-ordinarite.pdf
* Tong, *Diviseur thêta et formes différentielles*, §1.2.7 for the Dirac property and Corollary 4.2.3.3 for ordinary genus two:
  https://arxiv.org/pdf/0712.2046
* Kudo–Harashita, Theorem 2.2 and §6, formula (6.1), for normalization adjoints and Cartier:
  https://arxiv.org/pdf/2203.11801
* Schwede, *F-adjunction*, Proposition 7.2, Remark 7.3, and §8:
  https://msp.org/ant/2009/3-8/ant-v3-n8-p03-s.pdf

Use further literature if helpful, but inspect the actual hypotheses and relevant proof. Pareschi's *Gaussian maps and generic vanishing I*, Theorem 1.5 (https://arxiv.org/pdf/1401.7442), is not already a solution: its usual generic-vanishing conclusion is different from this Frobenius-injectivity statement, and its embedding/normality hypotheses require care for our singular joint image.

## Requested result

Lead with your verdict on (R). Give a complete checkable proof, or a global algebraic counterexample with all hypotheses and \(D_{f,g}=J(X^{(1)})\times J(Y^{(1)})\) verified. A construction theorem with a complete existence proof is acceptable; explicit equations are not mandatory.

If you cannot settle (R), distinguish what you have newly proved from the supplied results and state the exact remaining implication. A partial theorem should cover an unbounded-degree class beyond the sufficient cases already listed; a proposed extra hypothesis without a proved consequence is not a result. Do not expand the task to solving Litt's problem or merely provide a research plan.
