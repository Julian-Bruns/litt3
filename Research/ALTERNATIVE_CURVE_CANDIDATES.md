# Alternative curve families and computable priorities

2026-09-07, `/root/alternative_curve_candidates_max`. Bounded research
report; the active fixed pair and the live computation are unchanged.
The original unmarked common finite-etale-cover problem is UNSOLVED.

Three explicit small-genus families merit testing as replacements for Y
while retaining the existing genus-nine X. They give substantially smaller
Hermitian atlas systems. A fourth, impractical but computable parameter
selection eliminates every cored span without A18. Every proposal leaves
the unrestricted coreless problem open.

The calculations below are exact author checks, not an independent audit
or Lean verification. No candidate is asserted to be a counterexample.

## 1. Three families, with explicit ordinary simple seeds

All equations denote their smooth projective models over bar(F5).

**A. Ordinary genus two:**

    C_t: v^2 = u(u-1)(u-2)(u-3)(u-t),   t not in {0,1,2,3,4}.

Its Hasse--Witt matrix, in the coefficient convention
H_ij=[u^(5i-j)]f(u)^2, is

    [-2t^2-t+1    -2t^2-2t]
    [  -2t-2      t^2-t-2 ],       det H = 3(t+1)^4.

Thus every allowed parameter is ordinary; this is an identity, not a
genericity assertion. A concrete seed is t=alpha, where
alpha^3+alpha+1=0 over F125. This cubic is irreducible over F5.
The seed has an absolutely simple geometric Jacobian, as checked below.
For joint arithmetic with X/F25, its displayed model is over F_(25^3).

**B. Ordinary plane quartics:**

    Q_t: U^4+V^4+W^4+U^3 V+V^3 W+t U W^3 = 0.

Keep precisely the smooth parameters with
(t+1)(t^2-t+2) nonzero. Writing a=(2,1,1),(1,2,1),(1,1,2), the matrix
H_ab=[U^(5a_1-b_1)V^(5a_2-b_2)W^(5a_3-b_3)]Q_t^4 is

    [ -t+2   2t-1    2t  ]
    [   2    -t+2   2t-1 ]
    [ -t^3+2   2    -t+2 ],
    det H = -(t+1)^3(t^2-t+2).

The parameter t=0 gives a smooth ordinary nonhyperelliptic genus-three
seed Q_0 over F5 with absolutely simple geometric Jacobian. The
homogeneous ideal of its three partial derivatives has dimension zero,
so it has no projective singular point. The same smoothness check passes
at t=1,2. No claim that every allowed member has trivial automorphism
group or simple Jacobian is made.

**C. Genus five, retaining access to the existing small-divisor sieve:**

    D_t: v^2 = u^11+u^7+u^2+u+t.

Keep t nonzero and gcd(f_t,f_t')=1. The Hasse--Witt determinant is
3t^3. The parameter t=1 is a smooth ordinary genus-five seed over F5
with absolutely simple geometric Jacobian. This family retains a useful
part of X's W_3 torsion method that A and B lose.

### Exact seed certificates

Here P(T) is the characteristic polynomial of q-Frobenius. Point counts
are for q,q^2,...,q^g, including all points at infinity.

| Seed | q | Point counts |
| --- | ---: | --- |
| C_alpha | 125 | 118, 15926 |
| Q_0 | 5 | 5, 27, 119 |
| D_1 | 5 | 6, 30, 129, 578, 2976 |

    P_C = T^4-8T^3+182T^2-1000T+15625
    P_Q = T^6-T^5+T^4-3T^3+5T^2-25T+125
    P_D = T^10+2T^8+T^7-10T^6-28T^5-50T^4
          +25T^3+250T^2+3125.

All three polynomials are irreducible over QQ. Exact factorization of
Res_T(P(T),P(zT)) gave the following (degree, multiplicity) list after
the diagonal factor (z-1)^(2g):

    C_alpha: (4,1), (4,2)
    Q_0:     (6,1), (12,2)
    D_1:     (10,1), (40,2).

Every listed factor is irreducible and noncyclotomic. Thus no ratio of
distinct Frobenius roots is a root of unity. Every positive Frobenius
power still has 2g distinct, transitively permuted roots and irreducible
characteristic polynomial. This proves simplicity over every finite
extension and hence geometric simplicity. Each seed therefore also has
geometric Hom-zero with J(X), by absolute simplicity and different
dimensions. These facts do not exclude a common cover.

To replay the last exact check in Sage, insert any displayed polynomial:

```sage
R.<T> = QQ[]
P = T^6-T^5+T^4-3*T^3+5*T^2-25*T+125
assert P.is_irreducible()
S.<z> = QQ[]
A.<U> = S[]
p = A(P.list())
Rratio = S(p.resultant(p(z*U)))
print([(f.degree(), e, f.is_cyclotomic()) for f,e in Rratio.factor()])
assert Rratio.valuation(z-1) == P.degree()
```

The hyperelliptic counts use 1+sum_u(1+chi(f(u))). For Q_0 the affine
count at W=1 is supplemented by the roots of 1+v^4+v at infinity;
[0:1:0] is not on the curve. D_1's point counts also independently
agree with Sage/PARI's hyperelliptic Frobenius polynomial.

## 2. Scores that measure actual tests, not probabilities

For a proposed partner Y of genus h<9, any common effective orbifold S
has rational coarse curve: a positive-genus quotient of X would give a
positive-dimensional abelian subvariety of J(X), forcing its genus to
be nine, whereas it is also a quotient of Y and has genus at most h.
No simplicity assumption on Y is needed for this step.

Write N=deg(X/S) and n=deg(Y/S). The two actual atlas maps give

    n=(h-1)N/8,
    d_h=8/gcd(8,h-1),
    d_h divides N,
    every stabilizer order e_i divides gcd(N,n)=N/d_h.       (1)

In particular every reduced branch fiber on X has degree N/e_i>=d_h.
These are common-ORBIFOLD degrees. They are not the degrees of an
individual component of X x_S Y or of an arbitrary common source.

The checked [X-quotient proof](../Solutions/Sol_fixed_x_orbifold_bound.md),
Section 3, gives N<=2240 or N in {112000,336000}; tame targets satisfy
N<=672. Thus A has n=N/8, B has n=N/4, and C has n=N/2. The two large
targets, if present, give Y-side degrees respectively
(14000,42000), (28000,84000), and (56000,168000).

For a fixed tame N, enumerate e_i>=2 dividing N/d_h, with 5 not
dividing e_i, and retain only

    sum_i (1-1/e_i) = 2+16/N.                             (2)

This is a finite integer computation. It counts possible numerical
signatures, not covers or realizable local extensions. Root's small
cored exclusion for the fixed genus-25 Y is not silently transferred.

For Hermitian atlases on a genus-g endpoint with 5 not dividing g-1,
the library gives S_(g-1) oper scheme length and 3^(2g) torsion lines:

    S_0=2, S_1=5, S_j=5S_(j-1)-5S_(j-2),
    raw budget = S_(g-1) * 3^(2g),
    variables = 8(g-1), equations = 12(g-1)+1.              (3)

The raw budget is an upper bound for distinct oper--torsion pairs before
symmetry, not a runtime estimate. One reuses the oper list across all
torsion lines. Nontrivial twists remain in every count.

| Computational priority | Hermitian test endpoint | Raw budget | Variables / equations | Tame rows from (1)-(2) | Minimum X-side fiber |
| --- | --- | ---: | ---: | ---: | ---: |
| 1 | C_alpha, genus 2 | 405 | 8 / 13 | 24 | 8 |
| 2 | Q_0, genus 3 | 10935 | 16 / 25 | 40 | 4 |
| 3 | D_1, genus 5 | 10333575 | 32 / 49 | 67 | 2 |
| Current comparison | X, genus 9, paired with Y_25 | 11380476864375 | 64 / 97 | 117 | 1 |

For A the displayed common coefficient field has degree three over F25;
for B and C it has degree one. This moderates A's size advantage without
removing it. Actual coefficient fields of the opers, torsion lines, and
their symmetry orbits must be recorded before forecasting computation.

The tame counts include endpoint gonality (2,3,2, respectively; degree
on the lower-genus endpoint), but precede the additional trace-pencil
and torsion tests. For the current fixed pair the already proved N<=8
exclusion removes 23 of its 117 raw rows, leaving 94 at this stage.

The tradeoff in the final column is substantial. A and B make X's
W_3 branch-fiber test unavailable for every signature. For C, an inertia
e=N/2 produces a reduced degree-two fiber. If N is a power of two,
E=lcm(e_i) is a power of two and the canonical torsion multiplier
A e=(16E/N)e=8E is also a power of two. The existing
W_3(X,O)[2^infinity]={0} then forces that reduced degree-two divisor
to be linearly equivalent to 2O, impossible on the trigonal X.
This kills four of C's raw rows: one at N=4, two at N=8, one at N=16.
Some also fail other tests; the count is not additive across sieves.

The [new cubic torsion bound](../Theorems/Thm_cyclic_cubic_low_abel_torsion.md)
likewise provides a computable finite check when the actual multiplier
has the appropriate primary support: W_3[3^infinity] is killed by9
and rational over F_(25^12). It does not turn mixed-primary multipliers
into pure-primary ones, or exclude the remaining exact9-torsion.

A reproducible count for the tame column is:

```python
for label,d,m0 in [('g2',8,2),('g3',4,3),('g5',2,2),('old',1,3)]:
    count=0
    for m in range(m0,672//d+1):
        weights=[m-m//e for e in range(2,m+1)
                 if m%e==0 and e%5!=0]
        target=2*m+16//d
        dp=[0]*(target+1); dp[0]=1
        for w in weights:
            for j in range(w,target+1): dp[j]+=dp[j-w]
        count+=dp[target]
    print(label,count)
```

These vectors justify the order A, B, C for a small computation. C is
the better comparison when testing the existing low-divisor mechanism.
None provides a numerical probability of being a counterexample.

### Portability to coreless clumps

The same minimum support size applies to an ASSUMED clump, not just
orbifold branch fibers. If its reduced images have sizes r_X,r_Y, the
actual etale maps give deg(f)r_X=deg(g)r_Y, while Riemann--Hurwitz gives
8deg(f)=(h-1)deg(g). Hence (h-1)r_X=8r_Y, so d_h divides r_X.
For h=2,3,5 the minimum nonempty X-image size is8,4,2, respectively.
Thus the current W_3 and small-clump root-weight methods do not reach
any clump for the genus-two or genus-three partners. Genus five retains
the size-two test. No clump existence is inferred by this calculation.

Keeping X preserves its atlas-degree bound, torsion theorems and
one-form exclusion, and all general same-source correspondence,
canonical-ring, Cartier and intrinsic atlas results. Fixed-Y arithmetic
and its genus-specific exclusions do not transfer. A smaller-endpoint
atlas calculation would need fresh coefficient tensors and torsion
data, not a new proof of the intrinsic criterion. The high-degree
parameter construction in Section3 needs no such atlas computation
to avoid all cored spans. Every option still leaves coreless spans open.

## 3. A parameter avoiding every cored span

The count and parameter-selection argument are now independently audited
and integrated into version2 of
[`bounded_atlas_partner_finiteness`](../Theorems/Thm_bounded_atlas_partner_finiteness.md).
Use its statement and proof; the duplicate derivation was removed here.

For the fixed X, take q=25, g=9, B=336000 and h=2, so M=42000 in that
theorem. Its deterministic prime-degree prescription gives an ordinary
genus-two partner with NO CORED common finite-etale cover, independently
of A18 and including all twists and small cases. The prescription is
astronomically impractical. It does not assert absence of coreless spans
or simplicity of the constructed Jacobian, and the active fixed pair
has not been replaced.

## 4. Disqualifiers, boundaries, and the next bounded experiment

Reject a proposed pair as a counterexample as soon as a genuine common
source with two everywhere etale maps is constructed. Merely finding
a Hermitian atlas on one endpoint has a narrower consequence: it defeats
that endpoint's non-atlas test, without supplying a common cover with
the other selected endpoint.

The library's `cubic_genus_two_common_covers`,
`picard_simple_common_cover`, `ordinary_simple_common_cover`, and
`nonliftable_hermitian_atlas_family` rule out using ordinarity, simple
Hom-zero Jacobians, or a nontrivial cubic character alone as an
obstruction. Known parameter relations yielding actual covers should
be screened; membership in a family that contains some positive spans
does not by itself disqualify a curve paired with this X.

The old optional y^2=x^19+x^14+1 source was found in the inventory and
read. Its p-rank-one certificate does not reduce the genus-nine atlas
size or supply a new unrestricted two-map obstruction. Replacing X by
it would also lose the current X-specific quotient and torsion proofs.

The near-match in Krishnamoorthy was checked in the primary paper:
the proof of Theorem9.6 compares two already existing clumps via the
finite invariant Picard group and uniqueness of invariant section
lines. Question9.7 asks for existence of the first clump/invariant
pluricanonical form. Example3.19 also permits positive-characteristic
families of coreless correspondences. None supplies a degree-independent
Frobenius-period bound for arbitrary coreless partners.
[Primary source, Sections3 and9](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf).

If a small alternative experiment is chosen, prepare the complete
intrinsic atlas equations for C_alpha, including all81 cubic torsion
lines and the complete oper scheme of length five, with actual coefficient fields
and symmetry orbits recorded. This is a proposed bounded next task;
no such run or implementation change was started here. For a theoretical
reduction to a purely coreless pair, the required count and parameter
argument have now passed audit and are registered as noted in Section3.

References inspected by metadata/show/dependencies include
`fixed_x_orbifold_bound`, `bounded_atlas_partner_finiteness`,
`cored_orbifold_bridge`, `cored_quotient_torsion_sieves`,
`two_primary_w3`, `cyclic_cubic_low_abel_torsion`,
`dormant_rank_two_candidates`, `hermitian_atlas_extension_criterion`,
`intrinsic_atlas_incidence`, and the listed positive examples. Only
proofs needed for the argument were opened; no audit body was opened.
