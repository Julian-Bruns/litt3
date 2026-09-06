# Focused audit: universal ppav Dirac existence and proposed uniqueness

Date: 2026-09-05.
Auditor: `/root/dirac_ppav_construction_independent_audit`.
Verdict: **PASS for the written existence theorem; PASS for the stronger uniqueness argument described below, with explicit nonbreaking precision requirements.** No theorem files were changed by this auditor.

Checked written revision:

- `routes/global/PPAV_VERSCHIEBUNG_DIRAC_SECTION_CONSTRUCTION.md`, SHA-256 `48ad8f5b689313ec1482e3bbcadf68ae49520741eaa9307532c1e413d9f76960`.
- Relevant duality source: `FINITE_FLAT_DIRAC_DUALITY_OBSTRUCTION_2026_09_05.md`, SHA-256 `351965e06ade7006efa04377d7b51a0a85639910f592c1782d81f09d891bbd47`.

The stronger uniqueness statement was supplied as a proposed extension in the audit assignment; it is not present in the checked existence revision. This report supplies a reviewable version of that argument. It is not an audit of a subsequently edited theorem file or a claim to have proved Litt3.

## Existence checks

Write `v=V_A:A^(p)->A`, `L1=M^(p)`, and `Q=(Phi_A M)^-1`. All Fourier functors use normalized Poincare bundles and consistent fiber rigidifications.

1. The transform of the quotient `e:M->k(0)` is a nonzero map `theta:Q^-1->O`. Full faithfulness guarantees nonvanishing even if the unique global section of `M` vanishes at zero. Confusing these two evaluation statements would invalidate the argument, but the written note distinguishes them correctly.
2. The isogeny identity `Phi_A v_* = hat(v)^* Phi_(A1)` is natural on morphisms. Here `hat(v)=F_(hat A)`, so applying it to `e^(p)` gives `Phi_A(v_*e^(p))=theta^p` under the same identifications that give `Phi_A(v_*L1)=Q^-p`. On the target, `v_*k(0)=k(0)` and normalized Poincare identifies its transform with `O`. No extra sum over the kernel enters this pushforward of the single skyscraper.
3. The global product `theta^(p-1)` has exactly the required source and target and factors `theta^p` through `theta`. Both transformed objects are degree-zero line bundles, so inverse full faithfulness gives an ordinary sheaf homomorphism, without a missing derived shift. Multiplication by `theta` is injective because the dual abelian variety is integral. This proves uniqueness after imposing the exact normalization `e h=v_*e^(p)`.
4. Finite-flat duality gives the line bundle `L1^-1 tensor v^*M tensor omega_v` with the displayed sign of `omega_v`. The fiber of the corresponding functional at zero is residue evaluation at the identity of the finite fiber. On each Artinian Gorenstein local factor, annihilation by the maximal ideal characterizes the socle; thus the functional gives precisely a nonzero identity socle and zero on all other components. This uses the perfect dualizing pairing, not the generally vanishing algebra trace.
5. Triviality of `omega_v` holds also for inseparable `v`: it is the tensor quotient of the two canonical line bundles. The pullback section in that quotient is not the differential pullback, which may vanish. The numerical computation using `v F=[p]`, `F^*M^(p)=M^p`, and injectivity of finite pullback on numerical classes is correct.

Standard Fourier inputs were checked against [Mukai's primary paper](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/BDBEBAC584BE15236C2D62C383A34245/S002776300001922Xa.pdf/duality-between-d-x-and-with-its-application-to-picard-sheaves.pdf), Theorem 2.2, Example 2.6, and the isogeny and line-bundle formulas of Section 3. The morphism-specific Frobenius calculation above is the author deduction, obtained from naturality and base-field compatibility, rather than a theorem attributed verbatim to Mukai.

## Stronger uniqueness: complete audited argument

Fix `M` as above. Suppose `T` is any line bundle on `A1` numerically equivalent to `L1^(p-1)` and admits a socle-Dirac section `s`. Define the exact residual bundle

`R = v^*M tensor omega_v tensor T^-1`.

Then `R` is numerically equivalent to `L1`, hence is ample and principal. Because `k` is algebraically closed, its Frobenius is an automorphism. Base-field twisting is therefore an equivalence: there is a line bundle `M'` on `A` with `(M')^(p)=R`, and `M'` is numerically equivalent to `M`. This is inverse base-field twisting, not extraction of a tensor-power root and not descent along the relative Frobenius morphism of `A`.

Finite duality turns `s` into `h:v_*R->M`. After rigidifying `R` at zero, the socle-Dirac condition implies

`e_M h = c v_*e_R`, for some `c in k^*`.

Indeed the functional induced by a nonzero socle at the identity is annihilated by the identity maximal ideal, hence is a nonzero scalar multiple of residue evaluation; it vanishes on all other factors. Maps to the skyscraper factor through this fiber, so the fiber assertion is exactly the asserted equality of sheaf maps.

Put `Q'=(Phi_A M')^-1`, with evaluation section `theta'`. Fourier transformation gives a morphism

`u:(Q')^-p -> Q^-1` satisfying `theta u = c (theta')^p`.

Let `D=div(theta)` and `D'=div(theta')`. The equality implies `D <= p D'` and consequently `Supp(D) subset Supp(D')`. Both divisors are reduced. This arbitrary-characteristic fact is supplied by Jordan--Keeton--Poonen, [*Unique Factorization of Principally Polarized Abelian Varieties*, Theorem 3.1](https://arxiv.org/html/1602.06811v1#S3): for a theta divisor over a separably closed field, all irreducible-component multiplicities are one, and its components are geometrically reduced. The theorem and its positive-characteristic proof were read in the primary arXiv text.

Also `D` and `D'` have the same numerical class. One explicit justification avoids any appeal to numerical Fourier transforms: since `M' tensor M^-1` lies in `Pic^0(A)` and `M` is principal, `M'` is a translate of `M`; Fourier transformation turns translation into a degree-zero tensor twist, so `Q'` and `Q` are numerically equivalent.

Reducedness and support inclusion give `D'-D >= 0`. This effective divisor is numerically trivial, so it is zero: a nonzero effective divisor has strictly positive intersection with the `(g-1)`st power of an ample divisor (for `g=1`, positive degree). Therefore `D'=D`, giving `Q'=Q` as line bundles. Full faithfulness then gives `M'=M`. Recovering the residual identity yields

`T = L1^-1 tensor v^*M tensor omega_v` up to isomorphism.

Finally, in this particular bundle the normalized Dirac morphism is unique by the multiplication argument in the existence construction. Rescaling the nonzero residue scalar shows that all nonzero Dirac sections are proportional. Thus there is a unique effective Dirac divisor across this whole numerical class, not merely uniqueness of its line-bundle representative.

## Nonbreaking objections and scope boundaries

- Include `omega_v` in `R`, or explicitly choose its global trivialization before dropping it. Calling it a constant line does not make a specified identification canonical.
- Explain inverse base-field twisting when writing `R=(M')^(p)`; interpreting this notation as a tensor power would be a serious error.
- State the reducedness input with the arbitrary-characteristic source above. Complex analytic decomposition or characteristic-zero singularity results alone would not suffice.
- Support inclusion alone is not enough. The proof must retain reducedness and numerical equality, then kill the effective numerical-zero difference by ample intersection.
- Normalize fibers coherently or state the Fourier equalities up to a nonzero scalar; either is sufficient for divisor existence and uniqueness.
- The argument is for the Verschiebung isogeny and the associated full scheme-theoretic socle-Dirac condition. It does not assert the same Fourier-power identity for every maximal isotropic isogeny.
- The relation to Tong's precise question and any claim of novelty require separate formulation/literature checks. The proof above is a new deduction in this workspace, not an attribution to Tong and not a resolution of Litt3.
