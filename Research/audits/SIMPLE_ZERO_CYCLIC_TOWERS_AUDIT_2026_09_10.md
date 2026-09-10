# Focused audit: cyclic towers from a simple Frobenius zero

- Verdict: PASS for new Section 8 and the corresponding exact-cyclic-tower statement, version 4.
- Date: 2026-09-10.
- Auditor: /root/audit_simple_zero_towers.
- Mathematical blockers: none in the scoped new argument.
- Scope: Solutions/Sol_symplectic_p_cover_section_growth.md Section 8 and Theorems/Thm_symplectic_p_cover_section_growth.md, “Exact cyclic towers from a simple zero.” Sections 1–7 and the named canonical input theorems were accepted as inputs. This is a focused prose audit, not a full inherited-proof audit, new computational replay, or Lean verification.

## Actual semilinear operator

For R=k[e]/(e^q), the relevant coefficient automorphism takes fifth powers in k and fixes e. The stabilized kernel and image of the actual semilinear Psi are R-submodules and give an R-direct sum. Both summands are free because R is local Artinian and they are summands of a free module. Their reductions retain, respectively, nilpotence and bijectivity. The simple-zero hypothesis on the reduction therefore forces R-ranks 1 and D-1. In particular this is an operator decomposition, not a Smith row/column equivalence being used as conjugacy.

On the nilpotent line Psi=a sigma, each iterate has coefficient a sigma(a)...sigma^(j-1)(a). Since sigma fixes e and preserves units, the e-order is j times the e-order of a, truncated at q. Norm base change to the actual degree-five intermediate cover gives min(ord_e(a),5)=ell. The strict hypothesis ell<5 thus forces ord_e(a)=ell at every level. This proves the stated rank formula and nilpotence index.

The actual pulled-back downstairs kernel is the socle of that nilpotent free line: a nonzero multiple of e^(q-1). It belongs to the jth image precisely when j ell<=q-1. This correctly distinguishes injective pullback of a kernel vector from the potentially zero pullback on a cokernel. The Artin–Schreier argument for H2_et(C,Z/5)=0 and successive lifting of a cyclic character also justifies the existence of nested cyclic towers.

## Bad two-torsion twists and genuine directions

For F=E_r tensor L on the selected genus-two Y, the actual bad-twist table supplies h0(F)=h1(F)=1. Properness is translation of the proper theta divisor of E_r. The identity L^2=O preserves its omega-valued alternating pairing, and the nonzero canonical-double class kappa still preserves F and its theta divisor. These are exactly the bundle properties used in the inherited multiplicity argument; no identification of F with a different active connection is made.

Consequently the even theta equation and the reduced [2]Theta intersection argument apply to F itself. Multiplicity at least five would be at least six, giving local intersection at least 36 versus total 32 unless the divisors coincide; kappa-translation and the genus-two normalization exclude coincidence. The nonzero initial term of degree at most four misses at least two of the six genuine mu5 tangent directions. The single-entry cohomology complex over each entire nonreduced character subgroup gives ell<5. In an inversion-odd coordinate the invariant local equation is even, so the positive order is 2 or 4. This does not rely on theta properness in genus three.

The bad double and each selected cyclic cover are linearly disjoint. Decomposing along the actual degree-two map gives defect ell on their fiber product, because the untwisted ordinary summand remains zero under the cyclic five-cover. The inherited simple zero on the bad double then supplies the hypotheses of the abstract tower calculation.

## Actual two-leg refinement

The inherited Galois one-defect factorization has Z->C_L of degree prime to five, and Psi_Z has a simple zero. The fiber products Z_n over Y are connected by coprimality, and both original maps compose with the actual maps Z_n->Z.

The trace projector for Z_n->C_(L,n) commutes with Psi. Independently applying the actual Fitting argument on the two cyclic covers shows that their nilpotent summands each have k-dimension q. Injective pullback between these summands is therefore an isomorphism. The remaining source summand is bijective, giving the claimed identical defect ell and full rank formula on Z_n.

For the conditional nonzero mixed W3 difference, both ordinary canonical endpoint lifts induce individual source lifts above the same canonical W2 source. Naturality of the Hodge variation places their difference in ker Psi_Z; its pullback is the actual difference of the refined source lifts. Negative-tangent H1 pullback preserves its nonvanishing. The exact socle/image calculation therefore applies. Membership in each fixed finite iterate can eventually hold, while membership in the stable image fails at every finite level. This leaves both original maps intact and supplies no repair of the simultaneous deformation functor.

The audit proves no existence of a nonzero mixed difference and no common-cover exclusion. The actual mixed scalar remains undecided.

## Editorial observation outside the mathematical scope

At initial inspection the theorem header contained “Earlier growth statements are also author-checked, or Lean verified.” This apparent missing negation was reported to the author for correction; no Lean verification is supported by this audit. No theorem, proof, library, or continuation-state file was edited by the auditor.
