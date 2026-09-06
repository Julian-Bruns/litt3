# Global routes

For the current structural investigation, read [update.md](../../update.md)
and its linked frontier. The numbered index below describes the earlier
root-stack route; it is not the current work plan. The
[Igusa counterexample note](IGUSA_TANGO_COUNTEREXAMPLE_AND_RETAINED_SECTION_BOUNDARY.md)
records the latest correction to the Tango route.

The historical root-stack target is visibility of every representable finite étale
self-correspondence of

`S=P^1_{\bar F_5}(31,31,31)`

under the quotient `pi_0:S -> S_0=P^1(2,3,62)`. No active file proves this
target.

## What is now proved in this route

- [File 14](14_PROOF_LIFT_THROUGH_Y.md) proves that the smooth projective
  curve `Y:y^31=x(x-1)` has genus `15` and that
  `Y -> S=[Y/mu_31]` is a representable finite étale torsor.
- [File 10](10_PROOF_SELF_CORRESPONDENCE.md) proves the quotient signature,
  the canonical-degree obstruction, and the following conditional theorem:
  **if visibility holds, any curve sharing a finite étale cover with `Y` has
  genus congruent to `1` modulo `7`; in particular its genus is not `3`**.
  Its descent argument is complete and uses uniqueness of
  2-isomorphisms between dominant maps to an orbifold with trivial generic
  inertia.
- [File 13](13_PROOF_LOCAL_RAMIFICATION.md) gives complete proofs of the
  wild-excess identity, a generalized first-break Swan divisibility theorem,
  the tame-character constraint, the exact leading-commutator lemma, and the
  summation-by-parts divisibility.
- [File 11](11_PROOF_OVER_ORBIFOLD_CLASSIFICATION.md) proves the local
  fiber/different formulas and that a finite over-orbifold has at most one
  wild point.

Here an “orbifold curve” always has trivial generic stabilizer. Omitting that
condition permits generic gerbes and invalidates the over-orbifold claims.

## Open global route

The over-orbifold route still has five missing inputs (the first four feed
the conditional classification, and the fifth is the correspondence bridge):

```text
weak wild exclusion (calculation absent) ------------+
non-weak wild exclusion (tables/scripts absent) -----+
complex commensurator (reference absent) ------------+--> strong
tame specialization/overgroup theorem ---------------+    classification
                                                           (conditional)
                                                                 |
simultaneous finite-envelope bridge (open) ----------------------+--> visibility
```

[File 12](12_PROOF_PROFINITE_ORBIFOLD_GROUP.md) deliberately separates the
unverified complex Fuchsian maximality statement from the missing
characteristic-`5` specialization theorem. Prime-to-`5` covering degrees do
not, on the present evidence, give a simultaneous lift of both maps in a
self-correspondence.

[File 10](10_PROOF_SELF_CORRESPONDENCE.md) proves that the quotient
construction works **if** one first has a finite cover simultaneously Galois
for both legs. The existence of that cover is not proved and must not be
inferred from the two separate Galois closures.

## Reading by purpose

| Purpose | Read |
| --- | --- |
| Cyclic curve and final conditional consequence | `14`, then `10` through `PROP-CONDITIONAL-COMMON-COVER` |
| Profile-extraction route | Task 01 and the profile-4 route; do not load `11`–`13` |
| Local wild constraints | `13` |
| Over-orbifold bookkeeping and exact remaining wild gaps | `13`, then `11` |
| Complex/tame external input | `12` |
| Correspondence-to-over-orbifold bridge | final section of `10` |

The global route uses no active CAS certificate in this checkout. The absent
arithmetic eliminations and external theorem inputs listed in
[`MISSING_INPUTS.md`](../../MISSING_INPUTS.md) remain genuine evidence gaps.
