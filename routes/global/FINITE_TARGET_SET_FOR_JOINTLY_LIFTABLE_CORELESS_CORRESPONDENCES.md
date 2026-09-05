# A finite target set for jointly liftable coreless correspondences

Date: 2026-09-05.

Status: proved consequence of primary theorems. The root agent proposed the finite-exception application; the gluing/cohomology agent checked the relevant primary statements and proofs and supplied the reduction argument below. Collaborative author verification, not an independent audit. No joint-lifting existence assertion is made.

## 1. The finite exceptional-set theorem

Fix a prime \(p\) and an integer \(g\geq2\). There is a finite set

\[
\mathcal E_{g,p}\subset \mathcal M_g(\overline{\mathbf F}_p)
\]

of geometric isomorphism classes with the following property. Suppose

\[
X\xleftarrow{f}Z\xrightarrow{h}Y
\]

is a correspondence of smooth projective connected curves over \(k=\overline{\mathbf F}_p\), both maps are finite étale, \(g(Y)=g\), and

\[
k(X)\cap k(Y)=k\qquad\text{inside }k(Z).
\]

If this entire diagram has a simultaneous smooth proper mixed-characteristic lift, with both lifted maps finite étale, then \([Y]\in\mathcal E_{g,p}\).

Here a lift means a diagram over a characteristic-\((0,p)\) DVR whose geometric special fiber is the given diagram. Completion and finite ramified base extension are permitted. The exceptional set depends only on \(g,p\), not on \(X\), either covering degree, or the genus of \(Z\). In particular, \(\mathcal E_{2,5}\) is finite. No ordinarity hypothesis is needed.

## 2. Finitely many complex arithmetic curves of fixed genus

A compact genus-\(g\) complex curve is uniformized by a torsion-free cocompact lattice in \(\operatorname{PSL}_2(\mathbf R)\), of hyperbolic covolume \(4\pi(g-1)\). Borel's Theorem 8.2 gives finiteness of conjugacy classes of arithmetic lattices of bounded covolume, including this real rank-one group. It is a theorem about all arithmetic lattices, not merely their commensurability classes. The relevant real case also appears explicitly in §8.1. [Borel, *Commensurability classes and volumes of hyperbolic 3-manifolds*, printed pp. 25–26](https://www.numdam.org/article/ASNSP_1981_4_8_1_1_0.pdf).

There is also an exact surface formulation: Belolipetsky–Gelander–Lubotzky–Shalev, Corollary 1.4 and its proof, count arithmetic Riemann surfaces of genus \(g\); the proof identifies them with these torsion-free lattices. Their §5.3 proves the required finite upper bound. [*Counting arithmetic lattices and surfaces*, Corollary 1.4, printed p. 2198; proof and §5.3, pp. 2218–2219](https://annals.math.princeton.edu/wp-content/uploads/annals-v172-n3-p17-p.pdf).

Thus there is a finite list \(C_1,\ldots,C_s\) of complex arithmetic curves of genus \(g\). No congruence condition on their uniformizing groups is imposed. One must not substitute Wang's lattice finiteness theorem here: its standard statement excludes \(\operatorname{PSL}_2(\mathbf R)\).

For completeness, passing from a maximal-lattice finiteness statement to all lattices would also suffice. If \(\Gamma\subset\Lambda\) and \(\Lambda\) is maximal, then its covolume is at least \(\pi/21\), so

\[
[\Lambda:\Gamma]\leq84(g-1).
\]

Each finitely generated \(\Lambda\) has finitely many subgroups of bounded index. This is the subgroup-counting passage made in the cited proof. Thus neither nonmaximal lattices nor arbitrarily complicated noncongruence subgroups create a loophole.

### Definition over a number field, including noncongruence curves

Each \(C_i\) has a model over a number field. Here is the descent argument rather than an assumption of congruence. Its lattice \(\Gamma\) is commensurable, after conjugation, with a torsion-free congruence lattice \(\Lambda\) defining a quaternionic Shimura curve over \(\overline{\mathbf Q}\). Choose a finite-index subgroup \(\Delta\subset\Gamma\cap\Lambda\) normal in \(\Gamma\). The curve uniformized by \(\Delta\) is a finite étale cover of the Shimura curve for \(\Lambda\), hence descends to \(\overline{\mathbf Q}\): finite étale covers are unchanged by extension between algebraically closed characteristic-zero fields. Its finite group of deck transformations over \(C_i\) also descends, since the automorphism scheme of a genus-at-least-two curve is finite and all its geometric points are already defined over the algebraically closed base. Taking the quotient gives a \(\overline{\mathbf Q}\)-model of \(C_i\), which spreads to a number field.

This agrees with the terminology and descent statement in Krishnamoorthy's Remarks 3.11 and 3.14: “Shimura” here includes arithmetic curves arising from noncongruence finite-index subgroups. [*Correspondences without a core*, printed pp. 1180–1181](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf).

## 3. A fixed characteristic-zero curve has finitely many geometric good reductions at \(p\)

Fix one number-field model \(C/L\) of genus at least two. For each of the finitely many places \(v\mid p\), choose a stable model after a finite extension \(L'_v/L_v\). Its residue field \(\kappa_v\) is finite. If its stable special fiber is smooth, put into a set \(\mathcal R_p(C)\) all base changes of that fiber along embeddings \(\kappa_v\hookrightarrow k\). If it is singular, this place contributes nothing.

The set \(\mathcal R_p(C)\) is finite, and it contains every smooth geometric reduction of any curve geometrically isomorphic to \(C\), including reductions obtained after ramified extension or from a twist.

Indeed, take any such smooth model over a DVR. Complete the DVR. After a finite extension of its fraction field, the generic-fiber isomorphism is defined, the field \(L\) embeds, and this embedding determines a place \(v\mid p\). After one more finite extension, compare the smooth model with the base change of the chosen stable model at \(v\). Smooth proper genus-at-least-two models are stable. Uniqueness of the stable model extends the generic isomorphism and identifies their geometric special fibers. It also shows that a singular stable reduction cannot become smooth after further extension. Stable reduction and this uniqueness hold over DVRs; no restriction on the ramification of the comparing extension is needed. [Stacks Project, Lemma 109.24.2 and Theorem 109.24.3](https://stacks.math.columbia.edu/tag/0E8C).

There is a small but important bookkeeping point: different embeddings of a finite residue field into \(k\) may give Frobenius-conjugate curves that are not isomorphic as \(k\)-curves. We include all those finitely many embeddings. We do not assert a single \(k\)-isomorphism class per number-field place without fixing the residue embedding.

## 4. Applying the joint-lifting theorem

For a simultaneous lift as in §1, Krishnamoorthy's Lemma 4.14 says that a core on the generic fiber would produce a core on the special fiber. The geometric generic correspondence is therefore coreless; Proposition 3.8 allows extension of the field. The characteristic-zero arithmeticity theorem quoted as Theorem 3.10 then makes its targets arithmetic. Corollary 4.15 is precisely this argument for Witt-vector lifts. Since Lemma 4.14 is stated for an arbitrary DVR, the same proof applies to the mixed-characteristic DVRs allowed here. [Krishnamoorthy, Theorem 3.10, printed p. 1180; Lemma 4.14 and Corollary 4.15, pp. 1189–1190](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf).

Consequently the geometric generic fiber of \(Y\) is one of the finitely many \(C_i\). For a fraction field too large to embed in \(\mathbf C\), first descend the finite diagram to a finitely generated characteristic-zero subfield and use Proposition 3.8; an embedding of that subfield into \(\mathbf C\) gives the same conclusion about its geometric moduli point.

Now define

\[
\mathcal E_{g,p}=\bigcup_{i=1}^{s}\mathcal R_p(C_i).
\]

Section 3 proves that this is finite and contains the special fiber \(Y\). This proves the theorem.

## 5. Scope for the common-cover problem

The theorem is genuinely about the two maps on the same source. Separate liftability of \(X,Y,Z\), separate lifting of the two covers with possibly different source liftings, a \(W_2\)-lift, or vanishing of a first-order obstruction does not supply the required simultaneous mixed-characteristic lift.

If another argument gives, for a fixed \(X\), a finite set of genus-two partners admitting a cored correspondence, its union with \(\mathcal E_{2,5}\) is still finite. A partner outside that union admits neither a cored correspondence nor a jointly mixed-characteristic-liftable coreless one. This combination remains conditional on that separate cored-partner finiteness theorem.

The remaining case is a coreless correspondence with no such joint lift. Nothing here excludes it or asserts that it lifts. This note does not solve the general common-étale-cover problem or bound the degrees of nonliftable coreless correspondences.

Related local boundary: [Ordinary genus-two coreless lifting boundary](ORDINARY_GENUS_TWO_CORELESS_LIFTING_BOUNDARY.md).
