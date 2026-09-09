# Arithmetic genus-two reduction bound — independent audit

- **Verdict:** PASS, with nonbreaking clarifications below.
- **Auditor:** `/root/audit_arithmetic_reduction_bound` (fresh bounded independent audit).
- **Date:** 2026-09-09.
- **Scope:** the user's returned Pro argument that the geometric characteristic-five potential-good-reduction classes of all compact arithmetic complex genus-two curves number less than `2^2000000`. This audit does not cover its application to a particular Litt3 pair, simultaneous lifting, or a formal Lean proof.
- **Blocking issues:** none found.

## Checked argument

The square subgroup is the kernel of the maximal elementary-abelian-two quotient of a genus-two surface group, so its index is exactly 16, its quotient curve has genus 17, and its hyperbolic area is `64*pi`. Taking the inverse image of the surface group in `SL_2(R)` does not change its projected square subgroup. Takeuchi's definition of “derived” is containment with finite index in an order's norm-one group, not merely commensurability. Enlarging that order to a maximal order therefore gives the required actual containment. The printed final remark on p.609 supplies precisely the square-subgroup theorem. [Takeuchi, §§1,3](https://www.jstage.jst.go.jp/article/jmath1948/27/4/27_4_600/_pdf/-char/en).

The norm-one covolume is normalized correctly: `8*pi*d^(3/2)*zeta_F(2)*P/(4*pi^2)^n`. It agrees with the formula used by Macasieb (and recovers area `pi/3` over Q for the split maximal order). The bound applies to the containing norm-one group even though the original genus-two group need not itself be derived. [Macasieb, §2, equation (3)](https://arxiv.org/pdf/0803.1519).

The crucial discriminant constant was checked visually on printed p.210 of Odlyzko, rather than relying on broken PDF text extraction. Theorem 1(5) states

`D >= 58.6^r1 * 21.8^(2*r2) * exp(f2 - 70)`.

Here `f2` is a positive linear combination of the explicitly positive `Z_j(s)` at real `s>1`. This theorem is unconditional; the zero-free-region assumption belongs to the separately stated Theorem 2. Hence `d >= 50^n*exp(-70)` for totally real fields is valid. [Odlyzko, Theorem 1(5)](https://www.jstage.jst.go.jp/article/tmj1949/29/2/29_2_209/_pdf/-char/en). The inspected rendering is temporarily at `/tmp/litt3-audit-odlyzko-page2.png`; the primary PDF, not that temporary path, is the durable reference.

The ensuing inequalities are valid with substantial slack. In fact the displayed argument gives `n<57`; retaining `n<=64` is harmless. It gives `d<=2^258`, `P<=2^387`, and finite quaternion discriminant norm at most `2^838`.

The elementary count of fields is sound. Minkowski's upper product bound for the successive minima of the sup-norm cube is `product(lambda_i)<=sqrt(d)`, and each minimum is at least one by the nonzero integral norm. The resulting n independent elements need not be an integral basis: they are a Q-basis, which is all the hyperplane-avoidance argument needs. At most `binom(n,2)` proper hyperplanes cannot cover the indicated coefficient grid. The resulting primitive integral element has conjugates bounded by `2^147`, so its monic minimal polynomial has integer coefficients of absolute value below `2^10000`. Thus the stated `2^700000` field count is an overestimate, not an underestimate.

The ideal-count estimate `A_F(M)<=M^2*zeta_F(2)<2^n*M^2` follows directly by summing norms to the power -2; the Euler factors give `zeta_F(2)<=zeta(2)^n`. Norm-two prime ideals contribute at most `2^n`; every remaining ramified prime norm q satisfies `q<=(q-1)^2`. The quaternion ramification and split-real-place counts therefore cover every possibility. For indefinite quaternion algebras the type number divides the narrow class number. This is exactly the relevant Eichler condition, since there is a split real place. [Chan, Theorem 6.11 and Corollary 6.14](https://wkchan.faculty.wesleyan.edu/files/2019/04/quaternion-2012.pdf). Minkowski's ideal argument bounds the ordinary class number as claimed; `h_F^+<=2^n*h_F` is safe. The extra factor two covers the two orientations of the real realization.

The final group counts also hold. The compact signature and area bound imply `4*h+s<=68`, hence at most 68 generators. Coset actions bound index-j subgroups by `(j!)^68`. The universal compact orbifold lower area gives index at most 1344. Counting every subset of the genus-17 automorphism group overcounts its subgroups and hence all genus-two quotients. The exponents `710000 + 1010000 + 2000 = 1722000 < 2000000` leave ample room.

Galois stability extends from congruence Shimura curves to all the counted curves by the actual common finite étale span and its conjugate. The congruence input is supported by Kucharczyk's Proposition 5.3, Theorem 5.4, and the finite-level paragraph following it: conjugation permutes the split real places and again produces a quaternionic congruence curve. [Kucharczyk, pp.228–229](https://content.algebraicgeometry.nl/2018-2/2018-2-007.pdf). Descent of finite étale covers and of the finite automorphism quotient makes the span definable over Qbar. Thus no noncongruence classes are omitted.

For reductions, fix one embedding of Qbar into Q5bar. Its image is precisely the elements of Q5bar algebraic over Q, so any automorphism of Q5bar over Q5 preserves it. Any other Qbar embedding has the same image and differs by a global automorphism. The residue map from the local absolute Galois group onto `Gal(F5bar/F5)` is surjective. Consequently other places and residue identifications are already accounted for by the globally conjugate complex classes. Stable-model uniqueness makes geometric potential good reduction at the fixed place single-valued. This proves the asserted cardinality comparison with the complex list.

## Nonbreaking suggestions

1. When using an algebraically closed base-extension theorem for finite étale covers, cite the exact base-extension result (or SGA1), rather than only the broad Stacks §58.9 pointer: that section prominently discusses proper henselian specialization. The mathematical descent step is standard and valid, but the cited location should be sharpened.
2. Explicitly say `Gamma^2` means the subgroup generated by squares, not the set of individual squares, and distinguish it from the inverse-image subgroup in `SL_2(R)`.
3. State the residue exact-sequence argument above when claiming that all residue conjugates are counted. This prevents an unnecessary unproved bound on the degree of a field of moduli from entering the proof.
4. No smaller arithmetic classification, congruence hypothesis, or new numerical computation is needed for this count. The stronger exponent `2000000` passes; weakening to the requested `2^1000` exponent is unnecessary.
