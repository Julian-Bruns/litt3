# Continue here — focus on the shared coreless obstruction

Updated 2026-09-10 00:22 CEST. The unmarked common-cover problem is UNSOLVED.
Preserve BOTH actual finite etale maps from the SAME projective source.

## Operating decision

Keep genus-nine X and high-prime-degree genus-two Y_t of
bounded_atlas_partner_finiteness. NOT the original genus25 Y; do not
assume J(Y_t) simple. A18 stays PARKED; no large solver runs.
LATEST USER: use the simplest failing case as a PLAYGROUND to discover
transferable mechanisms, not just to exclude that individual case.
Root tested the norm-zero pencil/plane transition, but did NOT choose
a degree4 exclusion prompt: singular plane incidence retains the gap.
Instead an ACTUAL genus2/F625 active pair with ordinary Jacobian and
EXACTLY one nonordinary tangent was found, proved by original scalar
identities and a rank2 11x3 matrix. Canonical
genus_two_active_critical_quartics v2 contains the formulas/proof;
scripts/nonordinary_active_playground.sage checks the connection/tangent
in0.096s; final full replay including the Serre functional took2.17s
after startup. Every assertion passed.
The revised PRO_SINGLE_OPER_W3_REQUEST now asks for the ONE intrinsic
Serre-pairing scalar deciding compatible W3 lifting of this pair, with
a REUSABLE Cech/residue recipe. It replaces the unsent universal N1
draft; no second prompt or request is outstanding. READY to paste.
Research/SMALL_CASE_PLAYGROUND.md records the attempted plane route,
the actual critical collision, and the all-degree prime-to5 trace
consequence of a nonzero epsilon. No W3 scalar has been computed.
The Serre functional is also explicit: in basis z^-3,z^-1,z with
z=u²/v and tangent frame eta^-1, it is (3t²+t+1,3t+4,3). This and the
generic quintic formula are supplied in the prompt. Only the ACTUAL
higher Hodge cocycle is unknown; another pairing/dimension reduction
would overlap known work. The pair's only symmetry is hyperelliptic,
acting trivially on quadratic forms, so symmetry supplies no vanishing.
Next independently: construct the canonical FL C2 and that cocycle,
not another dimension or root enumeration.

The smaller C_alpha backup now has FIVE remaining cored profiles, not six.
Both recent degree24 and degree48 Pro proofs are fully integrated/replayed.
LATEST USER: focus on the hardest obstruction SHARED by main and backup.
Pause backup-only cored-profile work. Degree84 Pro subsequently RETURNED:
155 classes, mass64,45survivors (42hyperelliptic and3primitive).
Full archive locally replayed in about6.013s SINGLEcore; regenerated all
tables and independently computed character mass, verified every witness.
No source-curve decision. No further backup computation started.
Research/DEGREE84_CENSUS_STATUS.md records exact evidence scope.
No Pro is running. Research/PRO_ACTIVE_W3_REQUEST.md RETURNED without a
verdict. Pro obtains barPsi(o3)=0 and a forced-canonical-Y3 necessity.
Stable-image containment is EQUIVALENT to o3=0, not a weaker next target.
The actual missing implication remains extension of f-descent to the
fixed source obtained by lifting g to canonical Y3. No W3 lift proved.
Root has now proved and medium-AUDITED the ALL-level necessity in
forced_canonical_witt_endpoint. Every EXISTING diagram uses canonical Y,
and its whole deformation functor equals fixed-Y descent. Its next
obstruction lies in ker barPsi with an exact endpoint/source-kernel
decomposition. No next-level existence or bound on e. The smaller next
Pro draft is Research/PRO_SINGLE_OPER_W3_REQUEST.md: evaluate the
intrinsic one-dimensional class on the explicit F625 pair, with a
reusable mechanism. The universal all-pairs version was superseded.
No actual two-leg construction is requested; draft has not been sent.
Previous user asked what backup catch-up requires; answer: finish five cored
profiles AND independently prove no fully liftable coreless span.
Shared genus-two/Witt machinery already applies to both. See
Research/CANDIDATE_PIVOT_DECISION.md; no pivot or solver restart authorized.
No pivot of endpoints or restart of A18.

## Last proved main steps — do not redo or weaken them

NEW two_leg_negative_extensions v2 is PROVED and focused medium-AUDITED:
- For EVERY m>=1, a common nonzero H1(omega^-m) class forces a clump.
- An ARBITRARY simultaneous W2 lift supplies a nonzero common J5 class
  via normalized FL extensions; no shared indigenous connection assumed.
  Consequently a no-clump span has FULL deformation ring k, not W/(5^e)
  with unknown e. It cannot lift even to W2, including after refinement.
- Genus2: the first FL instability n>=0 gives a reduced clump of size
  5^(n+1)-1, intrinsic active at n0, intrinsic dormant at n>=1.
- New m-secant hypersurface bounds dim J_m<=1 whenever all common
  extension bundles are semistable, in particular for m<=clump size.
  Combining this with independent FL/Frobenius tangent classes proves:
  EVERY W2-liftable coreless genus2 span has J1=0. Its ring is W/(5^e),
  e>=2 or infinity; for main endpoints e is finite. This includes
  dormant W2-liftable spans, not merely the earlier ALL-active branch.
These arguments reach isolated spans; they still do NOT exclude them.

1. joint_tangent_clump_dormancy v3 is proved and AUDITED. A nonzero shared
   curve tangent gives compatible pointed extensions0->O->E->omega.
   Normalized strong semistability would force an actual core. First
   Frobenius instability instead gives a clump, and genus2 forces a
   regular dormant oper. The distinguished horizontal section identifies
   this oper with EXACTLY the intrinsic r_s of the common tensor.
   Thus ALL-active spans (including ten split exceptions of old v2) and
   no-clump spans have T_joint=0. Only the positive-clump intrinsic-DORMANT
   branch might have a nonzero joint CURVE tangent.
   Version4 AUTHOR additions: the projection divisor Delta is REDUCED,
   so primitive(weight,zero order) is exactly((5^n-1)/2,1) or(5^n-1,2).
   Pointed Frobenius^n compatibility forces branch contact I=0 mod5^n
   off Delta and I=2 mod5^n on Delta. Both bounds are locally SHARP:
   explicit formal models retain contact2 at Delta. No global cover
   is constructed by those models. The root-contact budget therefore
   still fails exactly at the clump; do not claim a local improvement.

2. NEW genus_two_joint_tangent_conic is proved and fresh medium-audited,
   PASS /root/audit_joint_tangent_conic. EVERY coreless span with genus2
   endpoint has dim T_joint<=1. In P H1(T_Y)=P2 the bicanonical evaluation
   conic is forbidden: its extension has saturated degree1 line
   omega(-Q), hence normalized extension of degree0 lines, stronglySS
   at EVERY Frobenius stage. Every projective line meets the conic.
   A lone OFF-CONIC tangent is still allowed. Applies to main AND backup;
   no Hom-zero, ordinariness, degree, or no-clump assumption.

3. pointed_frobenius_dormant_model (author proof) identifies first
   instability at n via the ACTUAL quotient jet connection:
       F^(n-1)*E = V_r tensor omega^((5^(n-1)-1)/2) tensor tau,
       tau in Pic[2].
   At n1 a section contradicts all known Pic2 dormant-tangent vanishings.
   Version2 additionally proves F²E semistable for EVERY nonsplit pointed
   extension on C_alpha AND current high-degree Y. The exact48chart
   cohomology test and Koszul parameter-degree transfer are written out.
   First instability now n>=3, with a48-dimensional positive section
   space. No ALL-height strongSS claim. Fresh medium audit of NEW
   Sections5--8 PASS /root/audit_height2_frobenius_transfer, no blockers;
   independent full replay22.1591s. Earlier model inputs not re-audited.

## Exact remaining main obstruction

Joint deformation ring is a quotient of W(k)[[z]] in EVERY branch.
No-clump gives EXACTLY k. ANY W2-liftable branch is rigid and gives
W(k)/(5^e); finite e for main by intrinsic nonliftability, e>=2.
No upper bound on e or W3 lift is known. A remaining one-tangent dormant
branch MUST fail to lift to W2. That does not imply5=0 in its full ring:
W[[z]]/(z²-5,5²) illustrates the abstract distinction. Positive-dimensional
vertical deformation is not yet excluded.
No-cored/no-full-mixed-characteristic-lift results already apply to main
pair and do not depend on A18 or backup. Shared curve tangent is NOT a
source dormant/indigenous deformation defect.

## Next concrete actions

A. Push the NEW first-Witt/clump dichotomy toward an actual exclusion.
   No-clump special-fiber-only spans and finite-height rigid W2 spans
   still survive. The ORIGINAL FL-connection local test is now CLOSED:
   contact2 survives together with that connection AND its later
   Frobenius oper line. Research/FL_CONTACT_TWO_BOUNDARY.md proves this
   for all positive heights by two z-adic contractions. Exact12-case
   replay0.146846s, n1--3, mod z69/269/1269, confirms all identities.
   These are FORMAL models, not actual projective spans or Witt lifts.
   Do not ask Pro for a false stronger local contact bound.
   CURRENT all-level necessity is COMPLETE, focused medium audit PASS
   /root/audit_forced_canonical_witt. Full twisted previous-flow input,
   etale naturality, canonical MF-tower comparison and Artinian functor
   statement checked. LSYZ Prop5.2 and Mochizuki III2.5--2.8/3.3--3.4
   are the precise source inputs. Next mathematical distinction:
   epsilon(X,rX) in coker Psi_X is the connecting image of actual o3;
   when it vanishes, remaining mismatch is in ker Psi_Z/ker Psi_X.
   PRO_SINGLE_OPER_W3_REQUEST now targets ONLY the explicit corank-one
   F625 pair, after the latest playground instruction. Its scalar
   <rho,phi> is unknown; nonzero coker is not nonzero obstruction.
   K-Y-Z arXiv2005.00579v1
   Thm6.4 still assumes its compatible locus nonempty, so gives no
   answer. Source checked this turn. No new existence result extracted.
   Do not infer full lifting from a mod-p periodic Higgs/de Rham flow.
B. Backup-only degree84 source comparison and hyperelliptic/wild-profile
   work PAUSED. The census answer does not remove a case. Bounded archive
   replay COMPLETE; do not drift into45source models.
C. The focused height2 audit PASSED and is integrated. The written
   transfer uses Koszul degree3c-2 and a Macaulay maximal minor of
   T-degree<=binom(3c,2)cB<=597246, with c<=13,B=62. Thus parameter
   degree>600000 suffices. Correct implicit equation is
   U=1+c1 z²U+...+c5 z^10U^5 for U=(1/u)/z². Do not reuse the erroneous
   preliminary w0 equation or the abandoned resultant bound408642.
   No blind height3 escalation: seek an all-height/two-leg mechanism.

## Completed computations

Degree48: triangle238_frobenius_factor_obstruction. ALL77 arrays check;
84844-node native regeneration0.126s matches byte-for-byte. Character
mass477/16 computed independently by MN and abacus on147273 partitions.
Integrated verifier3.733s.54classes violate Aut=C2,21 force actual smaller
source maps,2remaining contradict moduli Frobenius orbit3. Receipt:
Research/computations/triangle238_verification.txt. No new whole-proof audit.

Low-height script scripts/pointed_frobenius_theta_diagnostic.sage --height2
--all: consolidated SINGLE-process replay22.252s on ONEcore. All16 Pic2
labels x3 disjoint projective charts, BOTH parity blocks, explicit Bezout
identities, corrected univariate xgcd, and precision assertions pass.
Receipt Research/computations/pointed_frobenius_height2_verified.jsonl.
Four superseded preliminary logs removed; no useful evidence lost.
No computation or agent running.

A18:28,990 distinct, length29,375 COMPLETE; replay13.08s. Zero WHOLE atlas
representatives excluded.67quiet jobs only3 F25 reps:51boundedduals,
4inconclusive,4caps,1unit,7weakpoints. Four later60s normalized tests
timed out. No restart absent a new demonstrated mechanism.
Metadata computations/atlas_research_checkpoint_metadata.json.

## Backup and preserved failures

Backup tame: degree2(2^6),84(2,3,7).
Backup wild:(120,20,27,3),(240,40,47,6),(280,20,23,7).
The degree2 map ACTUALLY exists as the hyperelliptic map; needs a BOTH-leg
exclusion, never ask for endpoint-only nonexistence. BACKUP_CANDIDATE
owns this changing list.405atlas pairs already solved/audited.
CORED_FORMALIZATION_REQUEST/MAP ready, not Lean-implemented; main
no-cored proof needs none of these backup computations.

- Refinement preserves the WHOLE joint deformation ring, cannot repair it.
- Ordinary endpoint != ordinary source; no automatic compatible higher
  BT data or lift. Nilpotent nonordinariness != dormant nonreducedness.
- J7/ramified_root_contact_core solved. Spectral/Tango-only claims have
  actual coreless counterexamples; direct Cartier-crystal defect vanishing
  unavailable. Do not restart them.
- Endomorphism packets exclude broad groups; arbitrary large alternating
  actions survive. Small-cover Hecke success uses an ACTUAL genus2
  hyperelliptic involution, not automatic on general main-leg closures.

## Resources and resumption

No ordinary agents. A fresh medium audit of a major uncertain theorem is
allowed; conic and height2 audits COMPLETE. Quiet4worker (~3actualcores)
ceiling, no simultaneous sustained runs. No chat/CLI wakeups/browser Pro.
Hourly marker must be DETACHED; never wait on its worker.
Read canonical statements first; audit bodies only for a concrete doubt.
