# Focused audit: the small wild A7 reduction

Verdict: PASS. No blocking objection or required mathematical repair.
Auditor: `/root/audit_a7_small_wild_reduction`.
Date: 2026-09-10.
Scope: Version 1 of
[the statement](../../Theorems/Thm_single_jump_a7_hermitian_reduction.md)
and [its proof](../../Solutions/Sol_single_jump_a7_hermitian_reduction.md),
including the actual orbifold identification and the backup degree 280
consequence. Prose and bounded exact arithmetic audit; not Lean verification.

The canonical `show` and `dependencies` records for
`completed_local_orbifold_rigidity` and
`backup_hermitian_atlas_exclusion` were checked. Their audited statements
are inputs here; their proof bodies and the 405-pair calculation were not
re-audited or rerun.

## Checks

1. **Fixed-base local normal form.** The actual orbifold atlas supplies
   the Galois extension before any use of numerical ramification. The
   inertia has cyclic wild subgroup of order 5 and cyclic tame quotient
   of order 4. Hilbert's formula gives `23=19+4j`, hence `j=1`.
   Restriction to the wild subgroup preserves the lower numbering.
   Over the fixed tame field `k((v))`, `t=v^4`, Artin--Schreier reduction
   removes all negative powers divisible by 5 and then the integral
   part. Algebraic closure and Hensel's lemma give surjectivity on
   `k[[v]]`; conductor 1 leaves exactly `y^5-y=a/v`, with `a!=0`.
   The valuation of y in L is -1. Thus `z=1/y` is a uniformizer and
   the displayed identity `t=a^4*z^20/(1-z^4)^4` is exact. No formal
   change of the coarse parameter is used in this reduction.

2. **Global alignment.** For two such extensions the sole constants
   in that identity are aligned by scaling the coarse coordinate t.
   With the wild point at 0 and the tame point at infinity this is an
   actual global automorphism of P1. The index 7 tame extension is
   unique over its fixed complete base. Consequently the inherited
   completed-local rigidity theorem applies to the full extensions,
   not just their different exponents. There is no remaining local
   coefficient or gluing parameter assumed away in this argument.

3. **Embedding and wild fixed points.** Independently opened
   [Montanucci--Zini, Theorem 2.1(vi)](https://arxiv.org/html/1804.03398v1#S2)
   and verified that it supplies A7 inside PSU(3,q) for p=5 and odd
   exponent n, including q=5. The explicit 125-element translation
   group preserves the displayed Hermitian equation; its matrices
   are unipotent of determinant 1, so it lies in PSU_3(5). Every
   nonidentity element fixes only infinity. The numerator valuations
   in the proof are -10 when a!=0 and -5 when a=0,b!=0; the denominator
   has valuation -12. Thus the local indices are 2 or 7 and the lower
   breaks are 1 or 6, also matching Theorem 2.3(8)--(9) of that source.

4. **Stabilizers and quotient.** In A7 the Sylow-five normalizer has
   order 20, centralizer order 5, and there are 126 Sylow subgroups.
   A point stabilizer on a smooth curve has a unique normal wild
   Sylow subgroup. This proves both `G_Q=N_G(P)` and the injectivity
   of the assignment from Sylow subgroups to their fixed points.
   Sylow conjugacy therefore gives exactly one wild orbit. The
   j=6 contribution alone exceeds `18/2520`, even at quotient genus 0.
   With j=1, Hurwitz forces genus 0 and tame contribution 6/7. Since
   each tame branch contributes at least 1/2, there is exactly one,
   of index 7. This establishes the claimed actual quotient model.

5. **Atlas composition and scope.** Subgroup inclusion gives
   representable finite etale quotient-stack maps of degrees 50 and 3,
   whether or not the smaller subgroup is normal. Composing the given
   curve atlas is legitimate in characteristic 5: these are constant
   finite etale groups. The genus-two degrees become 14000 and 42000,
   directly contradicting the inherited backup atlas exclusion.
   The argument preserves the actual endpoint atlas supplied by the
   cored span. It neither creates a simultaneous Galois closure nor
   treats an arbitrary rational map with matching indices as an atlas.

The standard-library replay `python3 scripts/check_a7_wild_profile.py`
returned PASS for every group count, conjugation multiplier and Hurwitz
identity. Its limited scope is correctly stated in the proof.

Optional wording clarification only: the choice `t=v^4` can be explained
by extracting a fourth root of a unit in the tame field, using Hensel's
lemma after choosing the root of its residue. This strengthens the
fixed-base explanation but requires no change to the argument or scope.
