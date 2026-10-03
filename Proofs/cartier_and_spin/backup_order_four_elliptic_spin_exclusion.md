# Proof: all actual BACKUP elliptic reflections lack CM by Q(i)

[Statement](../../Theorems/cartier_and_spin/backup_order_four_elliptic_spin_exclusion.md). [Independent focused whole-branch review: PASS](../../Research/audits/BACKUP_ORDER_FOUR_ELLIPTIC_SPIN_AUDIT_2026_10_02.md). This new arithmetic test uses the [already reviewed complete reflection geometry](main_order_four_elliptic_spin_exclusion.md), not the older ordinary exponent-four certificate.

## Coverage of every actual reflection

For any ACTUAL connected cyclic étale four-cover Y′→BACKUP, the hyperelliptic lift gives a D8 cover of the rational hyperelliptic base. One reflection quotient E0 is elliptic. In the actual a=4 carrier, f+fj gives a NONZERO separating isogeny E0→E′ of degree≤48, and j(E′)=1728.

Every E0 is represented by the following finite list. Its genus-three étale-double intermediate is determined by one of the fifteen unordered pairs of the six BACKUP Weierstrass points. In a base coordinate sending that pair to0 and∞, let z_l² be the images of the other four branch points. The elliptic reflection's four branch points select exactly one root from each pair {+z_l,−z_l}. Modulo common sign there are exactly eight selections. Hence fifteen times eight monic quartic models cover every actual E0; possible repetitions cause no gap. This is a necessary complete list of quotients of actual covers, not a claim that every listed quartic supplies an original common source.

## Exact field and executed certificate

Use K=F5[a]/(a⁶+a⁴+4a³+a²+2), of cardinality15625, and α=a³+2a²+4a+1. The script checks α³+α+1=0 and that a has multiplicative order15624. The six branch points are0,1,2,3,α,∞. All required squared-root values lie in F125, so their square roots lie in K.

For a pair {p,q} with q finite use x=(u−p)/(u−q), whose value at∞ is1. For q=∞ use x=u−p. Each square root is normalized by the lexicographically smaller of its coefficient vectors and its negative, then the first selected root has fixed positive sign and the other three run over ALL eight sign triples. Distinct squared roots and selected roots are explicitly checked.

For each selected root set the monic quartic H(u)=∏_(l=1)^4(u−r_l) has two K-rational points at infinity. The source computes the exact count
\[
\#E_0(K)=15625+2+\sum_{x\in K}\chi(H(x)),\qquad
t_0=15626-\#E_0(K),
\]
where χ is the quadratic character, with χ(0)=0. Its table is built from every power of the checked primitive generator a; all15625 field elements and characters are covered. Hasse's bound is checked on every row. The cross-ratio j-value is also stored. Duplicate j-values have identical trace squares, as checked in the executed run; twists cannot change the quadratic endomorphism field.

The [reproducible source](../../scripts/genus_two/backup_order_four_reflection_cm.sage) was executed using SageMath10.9 with OMP_NUM_THREADS=OPENBLAS_NUM_THREADS=MKL_NUM_THREADS=VECLIB_MAXIMUM_THREADS=NUMEXPR_NUM_THREADS=1. The complete [certificate](../../../litt3-computation-data/oct02_backup_order_four_reflections/reflection_cm.json) records the field, parameter, pair and sign choices, squared and selected roots, quartic coefficients, j-values, point counts, traces and discriminants. Its completed result is120 rows,118 distinct j-values,120 ordinary models, zero supersingular models and ZERO Q(i) candidates. Runtime was1.2941seconds on the leased single calculation core. The first completed point-count pass could not serialize Sage Integer metadata; after fixing that concrete output failure, the successful pass produced the retained certificate. No old certificate was replayed.

For an ordinary elliptic curve over K, the geometric endomorphism algebra is the imaginary quadratic field Q(√(t0²−4·15625)). In particular it is Q(i) exactly when the negative discriminant is minus an integer square. Every retained row has5∤t0 and a negative discriminant whose negative is NOT an integer square. Therefore NO listed reflection quotient is geometrically isogenous to ordinary j1728, whose geometric endomorphism field is Q(i). An isogeny would identify their rational geometric endomorphism algebras.

## The actual carrier contradiction and remaining scope

The actual a=4 carrier supplies precisely an elliptic reflection E0 in this complete list and an actual separating isogeny to E′ of j1728. The field mismatch contradicts that isogeny, regardless of its degree. Hence the ENTIRE BACKUP a=4 branch is excluded. Earlier actual source arguments exclude a=2 and a=1; the accepted exponent-six ordinarity excludes a=3 and6. No elliptic normalized spin image remains on BACKUP. Genus zero was already excluded by the first-jet/Hurwitz comparison, so every such actual normalized image has genus at least two.

The original source and its two actual finite étale endpoint maps remain those retained by the carrier extraction throughout this contradiction. Nothing identifies a common quotient atlas for the higher-genus images; the original unmarked common-cover problem is UNSOLVED.
