# Degree-two Kummer dictionary audit

Verdict: **PASS**, with no mathematical correction required within the
stated geometric scope. Auditor: `/root/audit_degree2_kummer_dictionary`.
Date: 2026-09-11. This is a bounded prose/arithmetic audit, not Lean
verification or an exclusion of the degree-two/common-cover problem.

Reviewed inputs: [construction](../../Solutions/Sol_cyclic_trigonal_kummer_carriers.md),
[checker](../../scripts/check_degree2_kummer_carrier.py), and the existing
[audited A4/Prym proof](../../Solutions/Sol_backup_degree_two_prym_reduction.md).
The hypotheses used throughout are algebraically closed characteristic5,
squarefree degree10 F, and the smooth projective normalization of
X:y^3=F(x).

## Findings

1. **The bounds cover every nonzero geometric two-torsion class.**
   Riemann–Roch supplies D effective of degree9 in L+9O. A function with
   divisor2D−18O lies in the displayed10-dimensional L(18O): the pole
   orders3i+10j give precisely x^0,…,x^6 and y,xy,x²y. Its norm has even
   divisor, is polynomial of degree≤18, and is therefore R² with degR≤9.
   Q=0 forces P³ square and hence P square, giving the trivial class.
   Conversely, a square root of P+Qy would have no finite poles and pole
   order≤9 at O, so belongs to k+ kx+ kx²+ kx³. Thus Q≠0 proves
   nontriviality, with no generic-divisor assumption.

2. **The odd-gcd condition is necessary and sufficient, including the
   boundary.** At each finite branch point and infinity there is exactly
   one place above the base point, with residue degree1. The norm
   valuation equals the valuation of f there, so R² forces even parity.
   At a finite nonbranch point let m=min(ordP,ordQ). If the orders differ,
   all three valuations equal m. If they agree, the three distinct
   nonzero values of y allow cancellation on at most one sheet. At
   least two valuations therefore equal m, and the norm makes the sum
   even. All three are even exactly when m is even. This proves the
   stated condition g_odd|F; repeated common factors, branch common roots,
   and smaller pole orders introduce no missing case.

3. **The quartic is the actual A4 quotient.** For an admissible solution,
   the three nonzero Kummer classes form the rank2 orbit supplied by
   1+rho+rho²=0. Thus the square-root extension is connected V4 over X.
   The choices a0a1a2=R admit the order3 lift ai↦ai+1. The four even-sign
   sums are distinct: an equality would force two ai to agree up to
   sign, whereas their squares differ by a nonzero multiple of Qy.
   Their orbit has size4 and stabilizer C3. Direct expansion gives
   z⁴+4Pz²+2Rz+2P², its discriminant3(R²−P³)², and the stated translated
   cubic resolvent. Since U→X is etale, only the original eleven tame
   inertia groups occur. Each acts as(3,1); Riemann–Hurwitz gives
   2g−2=−8+22=14. The genus8 carrier and its Prym isogeny therefore agree
   with the previously audited construction. No R→B map follows.

4. **Residue coordinates and all three Q charts are complete on
   geometric points.** The reduced algebra k[x]/F is a product of fields.
   At each factor P³=R² has the unique solution P=S²,R=S³, with S=R/P
   when P≠0 and S=0 otherwise. The representatives have degS<10;
   since degP≤6 and degR≤9, taking remainders loses neither polynomial.
   Killing coefficients7,8,9 of S² modF and imposing the full norm
   identity gives exactly the bounded triples. For d=degQ∈{0,1,2},
   require higher coefficients zero and normalize the degree-d
   coefficient by choosing c²q_d=1. The action
   (S,P,Q,R)↦(cS,c²P,c²Q,c³R) preserves the represented double cover.
   No claim of scheme isomorphism at cusp points or a finite/injective
   enumeration of these coordinates is needed or established.

## Executed checks

The supplied checker with `--genus` passed independently, including
normalized genus8, in1.125s. Separate Sage computations tested the
following triples over F5. In every row F=(R²−P³)/Q³ was verified
squarefree of degree10. CRT reconstruction of S recovered both P and R
in every row, including where P vanishes modulo F.

| Case | P | Q | R | Criterion / normalized quartic genus |
| --- | --- | --- | --- | --- |
| Odd common factor at a branch point | x⁶+x² | x | x⁹+4x⁵+x⁴+x² | Pass /8 |
| Even common factor away from branching | x²(x⁴+1) | x² | x³(x⁶+x⁴+2) | Pass /8 |
| Smaller infinity pole, order10 | x³+1 | 1 | x⁵+x+1 | Pass /8 |
| Odd common factor away from branching | x⁶+x | x | x⁹+2x² | Fail /9 |

The rejected last example has
F=2x¹⁰+4x⁸+2x⁵+4x+4 and gcd(P,Q)=x with F(0)=4. It confirms that
the norm equation alone includes ramified doubles: the local test is
essential before treating a surviving norm point as an etale carrier.

Objections: none to the stated dictionary. Fixed-X solution enumeration,
the1533 carrier representatives, their Jacobian-factor test, and the
original same-source common-cover exclusion remain unperformed by this
construction and this audit. No theorem/library/source file was changed.
