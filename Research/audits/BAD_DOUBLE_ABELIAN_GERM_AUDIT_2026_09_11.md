# Audit: the fixed bad-double abelian defect germ

Verdict: **PASS, at the specified specialization**. No coefficient
correction is required. The finite calculation also proves the stated
formal-type and balanced-tower consequences at this specialization, using
the established quotient/norm theorem for actual defect modules.

Auditor: `/root/audit_bad_double_abelian_germ`, 2026-09-11.
This is a bounded prose/code audit and exact computational replay, not
Lean verification. It does not establish a theorem uniform in the family
parameter or exclude a common-cover span.

## Scope and inspected evidence

The parameter satisfies `t^2+2=0`. The actual genus-three curve is the
etale double of the stated genus-two family with `kappa^2=u(u-3)`, carrying
the pulled-back active connection. The object being computed is the
special-fiber Hodge/defect module on abelian etale covers. It is **not**
the fixed-curve nilpotent-connection germ, nor a higher-Witt obstruction.

Inspected scripts:

- `scripts/bad_double_abelian125_module.sage`;
- `scripts/analyze_bad_double_abelian_relation.py`;
- their actual affine/Laurent and Artin--Schreier reductions in
  `bad_double_cyclic5_defect.sage` and
  `diagnose_bad_double_noninvariant_covers.sage`.

Receipts in `/Users/julian/Documents/litt3-computation-data/`:

- `bad-double-F25-universal125-20260911.json`;
- `bad-double-F25-universal125-analysis-20260911.json`;
- `bad-double-F25-31-quadratic-20260911.json`.

The universal receipt SHA256 is
`b6a1ce401453c127b06e950418a23e229a066904a9b55170e23c234d330d14dc`.
The coefficient field is
`F5[a]/(a^4+4*a^2+4*a+2)` and the recorded parameter is
`t=3*a+3*a^2+3*a^3`.

## Actual curve, cohomology, and six free columns

The invariant affine scalar module is the usual hyperelliptic function
ring. In the anti-invariant `kappa*eta^{-1}` tangent frame its scalar
module is `k[u]+(v/(u(u-3)))*k[u]`. At the two points over infinity the
local tangent scalar lattices have orders at least two and four,
respectively. This gives the six displayed cohomology representatives:
`z^-3,z^-1,z` in invariant parity and `z,z^2,z^3` in anti parity. The
finite-branch behavior of the two affine anti generators, `kappa` and
`v/kappa`, includes the apparent poles at `u=0,3`; they are regular
sections in the actual coefficient line.

The two invariant Frobenius-fixed classes and the nonzero anti-invariant
class are independent in `H^1_et(C,F5)`. The checked Frobenius ranks give
p-rank three, so they exhaust this space. Taking their compositum is an
actual connected degree-125 etale cover, of genus 251, not a sampled
Artin--Schreier equation. The affine right sides and infinity shifts
satisfy the Artin--Schreier coboundary identities; their remaining
infinity errors have the required regular orders in both parity parts.

Descending reduction in the three Artin--Schreier exponents is the
actual change `w_O=w_U-shift`. Its lower terms have exactly the signs
and binomial coefficients used in `reduce_multi`. Removing an affine
part in its `w_U` coefficient introduces no lower-component correction;
removing an infinity tail does introduce the displayed lower terms.
The triangular filtration and vanishing of negative-line `H^0` give all
750 cohomology coordinates.

The six top vectors with Artin--Schreier monomial
`w1^4*w2^4*w3^4` are free generators over
`R1=k[e1,e2,e3]/(e1^5,e2^5,e3^5)`: fourth differences in each variable
are `4!`, a unit. The tensor-product difference conversion is therefore
correct. Its entries lie in F5. Consequently the six computed columns
determine the whole linearized Hodge map; no missing coefficient
Frobenius is concealed in this conversion. The scalar Hodge rule is
`A*f^5`, with the anti component acquiring `u^2(u-3)^2` from
`kappa^5=kappa*[u(u-3)]^2`, precisely as implemented.

The constant six-by-six matrix has rank five. The five-by-five unit
minor may therefore be eliminated by the recorded finite geometric
series. Its length 13 is sufficient: the augmentation ideal of R1 has
nilpotence index 13. Thus the defect module is the actual cyclic module
`R1/(f1)`, with the recorded Schur generator, not merely a determinant
whose multiplicity might have been changed by omitted summands.

## Independent replay and arithmetic checks

The auditor independently re-executed all six Laurent columns at
precision 360 instead of 320, with a 350-second alarm and single-threaded
numeric libraries. It completed in 223.946 seconds. The parameter,
coefficient modulus, all six complete columns, and the entire Schur
relation agree exactly with the original receipt. Laurent precision is
propagated by the series arithmetic; each needed final coefficient is
requested at available finite precision. The explicit exact-Laurent
coefficient helper avoids the previously identified out-of-range PARI
indexing issue.

The existing relation-analysis script was also independently replayed.
It reproduces all 31 quotient comparisons modulo `s^3`, Hessian rank two,
vanishing corrected cubic, the quartic below, and defect 43. These 31
comparisons verify the quadratic restrictions, not all higher terms of
the cyclic relations; no stronger coverage is claimed.

The active field here is F625. Its default matrices and their
`apply_map` results are `Matrix_generic_dense`, as checked at runtime.
A product with coefficients outside F5 agrees with an entry-by-entry
product. The separate known custom-F25 optimized-backend error is avoided
by the explicit generic matrices in the initial field calculation. The
rank and transverse analysis themselves explicitly request generic
matrices. Thus that error does not invalidate this receipt.

## The quartic is genuinely transverse-corrected

The quadratic radical is generated by
`(1,2*a+4*a^3,0)`. After substituting `y -> y+(2*a+4*a^3)*x`, write
the quadratic part as `h*y^2+j*z^2`, with `h,j` nonzero. If the cubic
coefficients of `x^2*y,x^2*z` are `b,c`, the independently derived
quartic after transverse elimination is

    [x^4]f - b^2/(4h) - c^2/(4j).

This direct formula agrees with the script's iterative critical-graph
calculation. In the recorded coordinates:

    raw radical-line quartic = 2*a^3+4*a^2+4*a+1;
    corrected radical cubic = 0;
    corrected radical quartic = 3*a^2+3*a != 0.

The raw line restriction is therefore not the calculation being used.
Multiplication by the full recorded f1 on the 125-dimensional group
algebra has cokernel dimension 43, also reproduced in the audit.

## Why the finite jet proves the fixed formal and balanced statements

Use the already established actual quotient/norm base-change theorem
for the source and target negative cohomology modules. On every higher
balanced abelian cover with group `(Z/q)^3`, `q=5^n`, these modules are
free of rank six and reduce, modulo the fifth powers of the three deck
parameters, to the computed elementary-abelian map. Lifting its unit
minor gives a scalar Schur presentation. Its generator reduces to f1
up to a unit and permitted changes of bases. Equivalently one may choose
compatible free bases in the maximal abelian tower and take the inverse
limit, producing a scalar formal relation in `k[[e1,e2,e3]]`.

The ideal `(e1^5,e2^5,e3^5)` contains no term of total degree at most
four. Hence the computed four-jet determines the quadratic rank and the
first nonzero radical term of every such formal lift. Changing its
generator by a unit does not change the rank or nonvanishing assertion.

The formal splitting lemma in characteristic five eliminates the two
nondegenerate transverse directions, leaving a one-variable series
whose leading term is the nonzero quartic above. A fourth root of its
unit factor exists formally because four is invertible. Over the
algebraically closed coefficient field the transverse quadratic splits.
The resulting formal hypersurface is therefore

    k[[u,v,w]]/(u*v+w^4).

For balanced q, the ideal generated by q-th powers of parameters is
intrinsic: it is the Frobenius-power ideal of the maximal ideal and is
preserved by every formal coordinate change. Thus the defect is the
colength of `(uv+w^4,u^q,v^q,w^q)`. A standard monomial count gives

    q + 2*sum_{j=1}^{q-1} min(q,4j) = (7*q^2-3)/4,

since `q=5^n` is congruent to one modulo four. This gives 43, 1093,
27343 for q equal to 5, 25, 125. The expression is a proof for every n,
not an extrapolation from these checks.

This reasoning is specific to the stated specialization. It does not
identify the exceptional parameter locus in the family, provide an
unbalanced-abelian formula, prove higher-Witt compatibility, or create
the missing second map of a common-cover span. Those claims require
additional work.
