# Continue here — genus-nine nonlinear atlas equations

Last updated: 2026-09-07, 10:37 CEST. Litt3 is UNSOLVED.

## Mandate and next action

User asleep: continue AFTER_ENUMERATION.md, do not pause or rearm the old
watcher. Preserve BOTH actual finite etale legs from the SAME projective
source. No whole genus-nine oper has been excluded. Small-cored and
coreless branches remain even after a hypothetical large-atlas exclusion.

CURRENT: extension-fibre geometry and Frobenius structure of the weak
genus-nine incidence; all positive-test robustness work is complete. Do NOT
redo enumeration, small test, or failed solver formulations. No whole oper
has been excluded. New positive results below are limitations, not exclusions.

HOT completed this hour:
- extension_fiber_geometry Version2 AUTHOR proof, main read and extended.
  Admissible fixed-W extension map U subset P31 -> P55 is scheme-theoretic
  locally closed immersion; normal bundle constant H1End0W rank24 (char!=2).
  Linear P31 intersection has LOCAL DIMENSION>=7 at admissible points, not
  just an expected count. Existence and smoothness remain UNPROVED.
  Exact dual normal map phi -> det(u,phi(u)) mod Jperp. Kernel dimensiond
  gives weak tangentdim7+d. No stability-only claim for the Bol quotient.
- Weak equations N(U,beta5)=0 on admissible locus are EXACT Frobenius
  preimage of classical linear section Z=f(U) intersect P(J^[5]). At a
  smooth codim24 weak point, transverse scheme length is5^24; this is NOT
  a count of distinct points or multiplicity of the FULL reduced atlas
  scheme. Original graph pilot already removes part of this phenomenon;
  merely taking roots of all variables reproduces its coefficient twist.
- Exact extension_projection_differential.sage/.json: one saved F25point,
  Nrank55, normalized extension derivative rank32/projective31, projection
  to E^[5]/J^[5] affine derivative rank24/projective23. Nonzero24minor saved.
  Thus projected ratios are NOT all fifth powers, even after common scalar.
  Point is NOT on weak incidence, so no special-fibre smoothness claim.
- Quadratic normal symbol B_U(h)=U² delta²h/2-U deltaU deltah+
  ((deltaU)²-P U²)h for h inkerQ. deltaB=0, pole<=320, actual fifthpower
  of f inL64. Its coefficient matrixV(U) gives Normal=V^T(S5)^T and
  Project=Qc5 V, with COEFFICIENT Frobenius crucial. Exact one-point
  check Normal annihilates independently solved full extension derivative;
  both ranks24. Research/EXTENSION_NORMAL_SYMBOL.md, script/JSON same
  extension_normal_symbol. No all-point rank theorem yet.

Previous completed positive-test work, do not repeat:
- bolza_prime_to_five_coreless_neighborhood Version2 AUDIT PASS. Every two
  endpoints in the prime-to5 etale commensurability class of C:v2=t6+3
  have an actual coreless common cover, both closures prime-to5. IncludesH.
  Primary arithmetic construction with controlled good reduction, NOT an
  arbitrary-two-map lifting theorem. Given endpoints descended only on
  specialfiber. Four exposition suggestions incorporated.
- hermitian_oper_noninvariance: actual CORED, BOTH GALOIS selfspan onH
  has unequal natural pulled rank2opers (t->-t quotient trick). Thus even
  strengthened universal natural-oper compatibility is false.
- cubic_genus_two_common_covers AUDIT PASS: parameterlambda family genus4
  source, both etaleGalois3 legs togenus2. Atlambda3, ordinary versus
  superspecial endpoints, Hom-zero. Bolza theorem also gives CORELESS
  commonspan between thispair, fromanother source. J'selliptic-split.
- picard_simple_common_cover AUDIT PASS: explicit F25 genus3 endpoints,
  BOTH Jabsolutelysimple and geometricHom-zero, actualsamegenus7source,
  twoGaloisetale3maps. Cored, bothp-rank2, NOTordinary. Exactfixed-pair
  verifier scripts/picard_cubic_common_cover_certificate.py andJSON same.
  Supersededsearch/code/datarecoverable /Users/julian/.Trash/litt3-cubic-exploration.98VZ95.
- Optionalgenus4balanced/unbalanced24trialsearch: no both-abssimplepair.
  Trial13minusordinaryabssimple, plus becomesabeliansurface squared over
  F25^3, diagnosed by exactHonda--Tate localinvariants. Note
  CUBIC_BALANCED_ORDINARY_SEARCH.md. No search running. If revisited,
  all24trials imposedALLsixbranchpointsF25-rational, an extra restriction;
  arbitrary coprime monic cubics A,B remove it. No general failure claimed.
- HOT: removing that restriction SUCCEEDED on FIRST arbitrary-cubic trial.
  ordinary_simple_common_cover: explicitgenus4pair BOTHJabssimple,
  p-ranks2/4 (oneordinary), geometricHom-zero, actualtwoGaloisetale3legs
  fromgenus10source. Wholefixedverifier/certificate saved under
  cubic_ordinary_common_cover_certificate.py/.json. Fresh major audit
  /root/ordinary_simple_pair_audit PASS; canonical promotion complete.
  No corelessassertion for thispair. This jointly defeats allthelisted
  Jacobian-onlycriteria, not thefixedpair or itsadditionalgeometry.

Next concrete action: use the exact normal/weak-Frobenius description to
seek a genuinely smaller reduced incidence computation or an all-chart
geometric constraint, before resuming the fixed-point equations. Check
the quadratic normal criterion against admissibility; do NOT infer it
at every point from generic rank. The two scalar verifiers now run in
under2seconds and use cached tensors; no large tensor rebuild is needed.
Weak dimension>=7 is proved at valid points; exactdim7/smoothness/nonempty
remain open. Rooting in U alone is NOT a shortcut: full projection has
maximal separable differential. Simultaneous all-variable root changes
only coefficient twist of the already-tried graph presentation.
No more fixed pairing/Hom-zero/absolute-simplicity-only exclusions; none of
these replaces two-map compatibility. Read AFTER_ENUMERATION for branches.

1. Full U-linear cancellation test COMPLETE, negative: all U_i[N64;R32]
   coefficient matrix3072x16896 has rank3063, kernel dimension9; every
   kernel vector has ZERO R coefficients. No bilinear consequence, including
   U.beta. The1024 U_iR_j classes are independent modulo the U_iN rows.
   Research/COMBINED_DEGREE7_SYZYGIES.md, script/JSON same stem.
2. TWO new bounded pilots COMPLETE WITHOUT BASIS:32off-diagonal inverse-
   cup seeds,180sec/1.298GiB,degree7; exact Frobeniusgraph (c=b5 retained)
   +24diagonal cubic seeds,180sec/2.136GiB,degree3. Same bound as oldnative;
   no demonstrated completion benefit. Forcedexit0 isNOTsuccess. Allsource
   hashes/seedcoefficients andgraph equivalence checked. See
   CANONICAL_ATLAS_SEEDED_NATIVE_PILOT.md and CANONICAL_ATLAS_GRAPH_NATIVE_PILOT.md.
3. No more solver variants on this evidence. Seek a structural reduction
   of the nonlinear parameter space. Constant tensor annihilators are
   PROVED unavailable in large genera; use actual positive tests to check
   every stronger proposed restriction. Allagentscompleted, nojobsrunning.

## New completed major chunks — all independently audited PASS

- genus_two_atlas_dynamics: ACTUAL genus-two positive test has exactly33
  reduced normalized atlas solutions. Four linear restrictions have
  original-ideal certificates; residual direction map conjugate to z->z^10.
  Eleven simple fixed directions, each three normalizations. Entire33dim
  algebra checked in all13 original equations, all charts/reconstruction.
  Counts normalized structures, NOT33 distinct unmarked curves/covers.
  scripts/genus_two_atlas_dynamics.sage; computations/genus_two_intrinsic_solutions.json.
  Canonical theorem links audit; do not open audit body without doubt.
- cartier_jet_tensor_surjectivity: GENERAL charp. If global quotient maps
  span length-p jets densely, full dual-Frobenius tensor is onto. Proof uses
  Cartier trace/Serre duality, NOT inseparable field trace. Stable intrinsic
  rank2 V with n=g-1>=p guarantees these jets at EVERY point. Thus char5/
  genus>=6 gives tensor rank12n for EVERY oper/twist. The genus-two constant
  annihilator shortcut CANNOT work on genus9.
- acyclic_atlas_towers: for EVERY sufficiently large prime ell!=5 there
  are actual cyclic etale covers C_ell->C of the genus-two test, genusell+1,
  H0(pullback V)=0 and tensor rank12ell. Torsion-line counting avoids proper
  cohomology locus; stability proved via pulled dormant oper, not presumed
  preserved by arbitrary etale pullback. Both acyclicity AND full tensor
  rank occur with real atlases in unbounded genus.

hermitian_genus_two_test (authorv2) supplies the source example:
H:X6+Y6+Z6=0, free C3xC3 inPSU, C=H/G:v2=t6+3. H0(V)=0 by
End(k3)/kId character invariants. All five reduced rank2 opers are actual
atlas opers:120 branch-Mobius symmetries act transitively. Small intrinsic
tensor separately audited PASS. No genus9 scalar/intrinsic coefficient-
basis comparison has been performed.

## Exact inverse-cup certificate, NOT an exclusion

Research/INVERSE_CUP_SEED_CERTIFICATE.md; script/JSON inverse_cup_seed_certificate.
Uses cached genus9 tensors, no rebuild. ALL576 entries verified exactly:

 (B Gamma)_(a,b)-delta_(a,b)*(U.R)/2 = sum c_(a,b,i,r) U_i N_r.

Hence B Gamma-I has ORIGINAL-IDEAL membership using these N multiples plus
delta/2[sum U_i(R_i-beta_i)+(U.beta-2)]. Degree7 overF25.
U_iN matrix2048x16896 rank2039. All576 homogeneous seeds independent.
Fullset6,724,943 terms; smallest subsets8/24/32/64/128 have respectively
28298/94426/130471/289555/775101 terms. Adding all may be inefficient.
697260 nonzero multipliers compactly encoded with verified roundtrip and
source hashes. Whole certificate~24sec/<700MB. The two bounded seeded/
graphpilots above showed no completion benefit. The U-linear test supplies no
shorter low-degree consequence; do not repeat it.

## General frontier — canonical statement IDs

- intrinsic_atlas_incidence: audited COMPLETE criterion for every tau^3=O
  and stable normalized V: I alpha=p*D(alpha),ell=1, D actualdualFrobenius.
  Dimensions4n,4n,12n; finite/reduced, possiblyempty. Genus9:64vars/97eqs,
  including nonacyclic V/alltwists. Noauxiliarya,b,lambda.
- theta_open_atlas_projection: author proof. On {H0(V_alpha)=0} inP(B),
  FULL12n x4n pullback matrix injective, uniquely recoversp. ForacyclicV
  all atlases lie here, zeros rank8n quotient-bundle section onP^(4n-1).
  Nonacycliccases remain in fullsystem. NOTsquare-polar inversion.
- cohomological_bezout: audited mixed(3n+h0V)-square resultant matrix;
  acyclicquadraticblock inverse to cupmatrix.
- compact_etale_atlas_system/resultant_gradient_atlas: audited untwisted
  N_U beta5=0,R_U beta5=beta,U.beta=2. Gradient of reduced degree48
  resultant. canonical_atlas_system.json saved tensor.
- inverse_cup_atlas_system: author equivalent B(U)Gamma=I24 and
  beta_i+Tr(Gamma partial_iB)=0. Gamma linearbeta5; normalization follows.
  No badquotientchart omitted. Newcertificate gives explicit original-
  ideal identities for its degree7 first equations.
- twisted_bol_complex: author exactorder2/order3 complex foralltau;
  dual source H1(W theta^-1 tau), NOTtau^2. Intrinsictheorem closes
  all-torsion formulation gap, not emptiness.

## Failed genus-nine shortcuts — do not repeat

Saved all32 basis tensors should be reused.
- One entireprojective U-line excluded inclinfinity, NOTallP31.
- Universaletaimage sieve stabilizesJ32. N/J alone has24dim invalid
  family U vanishing4P; normalization/invertiblecup essential.
- Cupinvertible does NOT imply old32x32polarH invertible: exacttwo-line
  coprime determinants detHdegree32/detCupdegree24.
- No constant rightpairing symmetrizes/skew-symmetrizes allNforms.
- No degree-one LEFTGAMMA syzygies(rank3072), no degree-oneWronskiansyzygy.
  Full U-linear test above now ALSO fails to give any consequence.
- HessiansDelta/logDelta genericallyfullrank32; R_U fullrank32 atfive
  samples; no blanketnilpotence/commuting simplification.
- Previousrestricteddegree7 rootansatz fails: combined96x96 block at
  originalUindices1,2,3 det a+1; deletingU0 stillrank96, no row-supported-
  only-U0 tensor. Notallpossible higher consequences.
- Both old fullsolverpilots stopped WITHOUTbasis/certificate/checkpoint:
  msolve111sec/4.023GiB; nativeGF25Singular180sec/1.318GiB degree7.
  ForcedSingular exit0 NOTmathematicalsuccess.
- Frobenius-Steiner nearbyliterature doesnotproveemptiness; PGUinvariance
  ofHermitianoper doesnotimplyuniquenessupstairs. Rank4symmetriccube
  uniqueness automaticforallrank2opers.

## Enumeration, remaining branches, operations

Enumeration COMPLETE/audited:28990distinct=55mult8+28935simple,total29375.
18 symmetryreps only UNTWISTED. Reproduce sage scripts/export_oper_basis.sage
--normalized. Raw4.5GBbasis external:
/Users/julian/Documents/litt3-computation-data/normalized_oper_msolve.gb.
No need reread. List/multiplicities complete_oper_solutions.json.

AFTER_ENUMERATION.md: largePSU; allPGU3torsionchoices; small-cored<=2240;
corelessindependentmajor gap. Generalorbifoldbound alreadyproved. Ordinary
genus2target couldavoidallcoredpartnersexistentially ALREADY inlegacy, but
stillleavescoreless. No simultaneousGalois/lifting, universalTango=>core,
ordinarity-as-commensurability, orforcedsharednonconstanttensor.

Obsolete smallsolver/prototypes recoverable:
/Users/julian/.Trash/litt3-genus-two-pilot.pOxZIW.
Minimal fourcertificate script andfull exactdynamics replace them;
no legacyaliases. All agentscurrentlycompleted.

Failed atlas solver/export prototypes and their exact inputs retired to
/Users/julian/.Trash/litt3-atlas-pilots.sucrLn. Logs/status/export metadata
remain in computations; saved old paths are historical, not active recipes.
Keep export_canonical_atlas_system.sage (mathematical tensor construction)
and inverse_cup_seed_certificate.sage (exact identities), neither obsolete.

Hourly nonpollingreminder cell282 dueabout10:37CEST; update.md last10:37.
Oldsolver/CLIwatcherOFF. NoPro requestremainingauthorized.
