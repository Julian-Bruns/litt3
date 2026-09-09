# Joint tangent, clump, and dormancy audit

Verdict: PASS for the core theorem and UNIQUE-ACTIVE application;
BLOCKING SCOPE CORRECTION required for version 1's ALL-ACTIVE application.
Auditor: /root/audit_joint_tangent_clump.
Date: 2026-09-09.

Scope: version 1 of `Theorems/Thm_joint_tangent_clump_dormancy.md` and
`Solutions/Sol_joint_tangent_clump_dormancy.md`, together with the necessary
marked-extension, correspondence, and projective-connection conventions.
The continuation files were read without taking over their research tasks.
Canonical statements and dependencies were checked for the one-clump,
connection-spectrum, and simultaneous-deformation inputs. This audit does
not independently re-audit those previously recorded theorems, prove the
original common-cover problem, or constitute Lean verification. No theorem,
proof, library, or continuation status was changed by the auditor.

## Blocking and nonblocking objections

Blocking objection to the original application: version 1 asserts that
the unique-active hypothesis applies to the active branch of the selected
pair, and consequently claims `W(k)/(5^e)` for every active match. This
does not follow. `fixed_x_nonzero_cartier_profiles` permits `(d,e)=(2,1)`
on this pair. By `coreless_connection_spectrum`, that common quadratic
gives an affine connection pencil containing an active midpoint AND two
dormant companions. The new tangent construction can then produce one of
those companions without contradiction. The original all-active rigidity
and ring assertions must be narrowed to UNIQUE-ACTIVE matches.

This issue was identified by the parent after my initial PASS. The initial
verdict overlooked that application sentence; it is superseded by this
qualified verdict. No blocker was found in the shared-tangent-to-clump,
genus-two dormancy construction, or unique-active implication itself.

The correction has a concrete endpoint formulation. For an active match,
if either endpoint's Hasse root class is nonsplit, the common quartic
cannot have a shared quadratic square root; the recorded spectrum then
gives the unique-active case. If BOTH endpoint classes split, choose
quadratic roots on each endpoint. Their actual pullbacks have equal
squares and hence differ by a constant sign on connected Z; adjusting
that sign makes the quadratic common. The active connection then has
two common dormant companions. By the recorded
`genus_two_active_critical_quartics` theorem for the selected Y, all 75
nonsplit active Y choices are covered by the rigidity conclusion. Its
10 split choices are exceptions only when the matching X choice is also
split. This is a scope statement, not an existence assertion for any
of those matches. The 75/10 endpoint count is an existing theorem input,
not a computation independently audited here.

Two optional clarifications would make the proof easier to reuse. In the
finite-field boundedness sentence, keep the rank explicitly fixed (rank two
here). In the trace-free normalization sentence, an explicit permitted
square root is `F*(theta_i^(5^(n-1))) = theta_i^(5^n)`, with its canonical
Frobenius connection; tensor by its inverse. An arbitrary square root
without its compatible connection should not be substituted. The draft's
projective construction already avoids that ambiguity, so neither point
blocks the result.

## Scoped proof observations

1. **Frobenius does not kill the pointed extension.** The exact sequence
   with `B = im(d)` is on the Frobenius twist, and `B` embeds in
   `F_*omega_C`. After tensoring by `omega^(-a)`, the possible kernel on
   H1 is controlled by sections of `omega_C^(1-5a)`, which vanish for
   every `a >= 1`. Iterating with `a = 1, 5, 25, ...` establishes exactly
   the nonsplitting used later. Frobenius twists or semilinearity do not
   change injectivity. Negative-line H1 injectivity for actual etale
   pullback is a separate, recorded input and is not inferred by a trace
   divided by the degree.

2. **The finite-field input has the required characteristic-p scope.**
   I independently read Deninger--Werner, Theorem 18 and its proof on
   printed pages 573–574. Part (c) and Frobenius functoriality give a finite
   etale cover trivializing an iterate of a strongly semistable degree-zero
   bundle. Descent to a finite field applies to both normalized bundles;
   increasing to one common absolute-Frobenius exponent is legitimate.
   This uses the finite-field theorem, not the mixed-characteristic
   lifting results elsewhere in that paper.
   [Primary source](https://www.numdam.org/item/ASENS_2005_4_38_4_553_0.pdf).

3. **The two projective frames really synchronize.** Write the originally
   embedded fields as `K_X, K_Y` inside `K_Z`. Their maximal unramified
   extensions in the chosen separable closure coincide: an etale cover
   above Z composes to an etale cover of either endpoint, while any
   endpoint cover becomes etale over Z by base change. Thus the displayed
   groups act on one field L and fix the original endpoint embeddings.
   Endpoint trivializing covers admit a connected common finite etale
   refinement of Z. On that proper connected curve, two projective
   trivializations differ by a morphism to affine `PGL_2`, hence a constant.
   Separate endpoint Galois trivializing covers then supply finite
   projective monodromy in this same frame. No common finite Galois
   closure for both legs, or matching theta characteristics, is assumed.
   Since `k = bar(F5)`, the two finite matrix sets lie in one finite
   subfield and generate a finite subgroup. This last step would not
   hold over an arbitrary algebraically closed field.

4. **The invariant is a nonconstant actual common function.** The pointed
   subline is preserved under both endpoint descent actions, so its
   coordinate t transforms by those constant matrices. Its nonconstancy
   follows from a basepoint-free pair of sections of the positive-degree
   pulled-back theta power: a constant ratio would trivialize that line
   bundle. A nonconstant invariant in `k(t)^H` remains nonconstant in L
   and belongs to both original fixed fields. The contradiction with
   corelessness is therefore valid. It is not a statement merely about
   abstract isomorphism classes or one endpoint.

5. **First instability gives an actual clump.** Etale HN descent and
   pullback identify the first unstable index and maximal line on both
   endpoints and Z. Projection to the quotient is nonzero by positivity;
   a nowhere-zero projection would split the Frobenius-pulled extension.
   Its effective nonempty divisor therefore pulls back identically by
   both legs, with saturated support. This proves the first conclusion
   even when the first unstable index is zero.

6. **Genus two gives precisely the oper equality.** A nonsplit extension
   on Y is semistable, so the common index satisfies `n >= 1`. A horizontal
   maximal line for the canonical zero-p-curvature connection would
   descend by Cartier to a line destabilizing the preceding iterate.
   Its second fundamental map is consequently nonzero. The integer
   inequalities `5^n < deg(N_Y) <= 5^n + 1` force equality, and the map
   is an isomorphism of line bundles. Etale pullback of the canonical
   connection and uniqueness of the HN line transfer that isomorphism
   first to Z and then faithfully to X. The claimed degree and square
   identities follow. The resulting projective connections are regular
   dormant opers, and they match as actual pullbacks. Regularity follows
   from the everywhere invertible second fundamental map.

7. **The stated consequences retain their scope.** The projection divisor
   on Y has degree `5^n - 1`. Its constant multiplicity follows because
   multiplicity level sets are themselves clumps and the recorded
   one-clump theorem allows only one. A unique active common connection
   cannot coexist with the dormant match constructed from a nonzero joint
   curve tangent. Thus both the no-clump and the specified unique-active
   branches have zero joint curve tangent. Here UNIQUE-ACTIVE is essential:
   the version 1 claim covering every active match is not certified; see
   the blocking scope correction above. Given the recorded deformation
   and nonliftability inputs, their rings are `W(k)/(5^e)` with finite
   positive e, and the existing active W2 lift gives `e >= 2`. None of
   this implies that the source oper defect vanishes, that e is bounded,
   that W2 lifts extend to W3, or that a common span cannot exist.
