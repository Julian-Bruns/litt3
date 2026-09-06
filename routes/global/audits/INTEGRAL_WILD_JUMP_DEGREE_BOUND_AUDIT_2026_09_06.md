# Audit: integral wild jumps and the cored degree bound

Date: 2026-09-06. Auditor: `/root/integral_jump_degree_bound_audit`.
Verdict: **PASS**. No substantive mathematical or certificate defect found.

Audited `Solutions/Sol_integral_jump_bound.md` and
`INTEGRAL_WILD_JUMP_CARRY_CERTIFICATE.py`. Read the retained single-jump
theorem, cored-signature reduction, and their prior audit for dependencies.
The fixed-pair eigenform theorem and existence of the simultaneous cored
Galois refinement remain inputs, not newly audited here. No proof files
were edited.

## Ramification and the general bound

- The upper numbering is correctly that of `L/L^P`, with `P=I_1`.
  Lower subgroup compatibility gives `P_i=I_i` for positive lower indices.
  Thus `c+1=sum_{j>=1}(|P_j|-1)`. On an upper interval after cumulative
  rank `a_i`, inverse Herbrand has slope `p^a_i`, giving contribution
  `(q-p^a_i)(u_(i+1)-u_i)`. This proves formula (2), including its
  telescoped version, for every wild group with the stated jumps; no
  character decomposition or abelian assumption is used. For comparison,
  the positive upper parameters for the full inertia extension are those
  for `P` divided by `t`, so substituting that numbering would be wrong.
- Hasse--Arf applies to abelian `P` over the equal-characteristic complete
  local field with algebraically closed residue field. This generality
  is explicitly confirmed in [Kedlaya, Remark 4.4.13](https://kskedlaya.org/cft/sec_filtration.html).
  Abelianity is sufficient for the hypothesis, not required by the proof.
- Bounds (3)--(7) check. More explicitly, with `s=p^a_(r-1)<=q/p`,
  `c+1 >= (q-s)U+s-1 >= (q-q/p)U+q/p-1`. This supplies a transparent
  justification of (4). When `m0>=t0`, positivity of `c-q` and (3) give
  (5). When `m0<t0`, `w>=2` implies `m0<D`, while `w=1` gives the
  stated decreasing-ratio bound. The bound in (6) also covers `m0<D`.
  The substitution bounding `U` is valid for every prime `p>=3`.
- For bounded `q`, `t0<=c+1` and `c>=q-2>0` bound `m0` as stated.
  The expression `(q+vD)/(v m0-q)` decreases on its positive domain;
  the least integer in that domain is at most `q+1`, with denominator
  at least one. Therefore `c<=q+(q+1)D`. The divisor conditions then
  bound `t0,g0` and the actual atlas degree `n`.

## Unbounded-rank completeness and termination

The carry recursion is a complete numerical sieve for (8), not a local
realizability claim. For any solution, repeatedly dividing (8) by `p`
forces the initial `p|E` and every prescribed congruence. A positive
`Delta` records exactly a filtration break; zero changes fill all ranks
between breaks, including initial and final rank gaps. Conversely,
reversing the recurrence from an endpoint reconstructs (8) and a unique
strictly increasing jump/rank list. The code preserves all these paths
and does not prune paths merely because an earlier endpoint exists.

There is no concealed rank cutoff: `E>0`, all carries stay positive,
and `B=2m0 U+D` bounds both the initial carry and all successors.
At most `U-1` positive changes occur; each of the at most `U` runs of
zero changes has length at most `floor(log_p B)`. Including the initial
rank gives exactly the safe bound (9). The finite branching and this
depth bound prove termination. Combined with the single-jump theorem,
this establishes an effective bound for arbitrary fixed `h,p` in scope.

## Independent numerical replay and local exclusion

The supplied certificate passed. A separately written exact implementation
enumerated positive jump changes directly and grouped all possible rank
gaps using the valuation of the current numerator: initial ranks range
from `1` through `v_p(E)`, and after a positive change a gap ranges from
`1` through `v_p(R+m0 Delta)`. It used no imposed rank bound and did not
import the supplied implementation. Both enumerations produced:

| D | M | U | States | Multi-jump tuples |
|---|---|---|---|---|
| 1 | 1 | 2 | 0 | 0 |
| 2 | 2 | 3 | 1 | 0 |
| 4 | 5 | 6 | 8 | 0 |
| 8 | 11 | 11 | 71 | 1 |
| 16 | 23 | 21 | 1271 | 0 |

Total: **1351 states**, sole tuple
`(D,m0,t0,q; filtration; c)=(8,1,3,25; ((1,1),(2,4)); 83)`.
The maximum visited ranks in the nonempty cases were `1,4,6,14`.

The local exclusion is valid: the first lower jump is `1` and
`|I_1/I_2|=5`. Its leading-coefficient image is a nonzero one-dimensional
`F_5` subspace of the residue field. A linearized tame generator acts
on that image by multiplication by its primitive eigenvalue or its
inverse. Stability forces this eigenvalue into `F_5^*`, hence `t|4`.
But the tuple requires `3=t0|t`, a contradiction. This is stronger than
the generic tame congruence and requires no assumption on the remaining
wild filtration.

## Consequence and suggestions

For `h=16,p=5`, every realizable integral-upper-jump case is single-jump;
the retained theorem consequently gives **q=5 and n<=2240**. The cored
signature reduction excludes the other large-degree signatures and gives
`M<=n` for jointly minimal spans. Therefore a jointly minimal cored
candidate with `M>2240` must have a nonintegral upper jump of `L/L^{I_1}`,
and its wild inertia must be nonabelian. This does not exclude all cored
candidates or any coreless candidates, and does not bound redundant
source refinements.

Only an expository suggestion: display the `s=p^a_(r-1)` inequality above
when explaining (4), since an upper bound on the sum of the earlier
coefficients alone is not a lower-bound argument. The required relation
to the final coefficient makes the existing claimed inequality correct.
