# Proof: tiny Cartier blocks, including the unavoidable bad doubles

[Statement](../../Theorems/genus_two/genus_two_active_twists.md).
Author proof,2026-09-09–13. Affine and split reductions have a bounded audit.

## 1. The twist block is the actual nilpotent tangent operator

For an active normalized quartic s, the induced infinitesimal Verschiebung
has, up to a nonzero constant, the kernel of t↦C_1(s t) on regular quadratic
differentials. This follows from the square-Hasse/Cartier formula in
Mochizuki II2.11–2.13 and Definition3.1, as explained and source-checked in
[the inverse-character note](../../routes/global/ORDINARY_INDIGENOUS_INVERSE_CHARACTER_CARTIER_CRITERION.md).
It commutes with actual etale pullback.

On the connected etale double Y_R with kappa²=R, the anti-invariant
quadratic space is exactly

    kappa eta²,  u kappa eta²,  (v/kappa) eta².             (1)

Here deg R is1 or2. To check completeness and regularity, let the second
involution change v to-v while fixing kappa. Each of its two eigenspaces
in the anti-kappa quadratic space consists respectively of rational
multiples over k(u) of kappa eta² and (v/kappa)eta². At every finite
branch point a pole in that rational coefficient would lower the order
by at least2, whereas the displayed factors have order0 or1. At other
finite points no pole is allowed either. Thus the coefficients must be
polynomials. At infinity their orders are4-deg R and deg R-1, giving
polynomial degree at most1 and0, respectively. This proves (1), including
the case in which infinity belongs to the two-torsion branch pair.

Write s=A eta^4. For the first two basis vectors the scalar coefficient
of the input six-tensor is A u^j kappa/v^6. Extract the fifth power
(kappa/v²)^5: the remaining polynomial is A S²u^j. For the third vector
extract (1/(kappa v))^5: the remaining polynomial is A R². Their degrees
are at most13 and8, respectively. Cartier therefore gives exactly the
stated2x2 and1x1 blocks, preserving the two characters. This derives the
test from the actual double, not from an unrelated bundle.

## 2. Split data need no twist enumeration

The [critical-quartic theorem](../../Theorems/genus_two/genus_two_active_critical_quartics.md)
gives fifteen four-branch data, sixty fiber data and ten split active
data. Each split tangent bundle is V_d1⊕V_d2 for two distinct dormant
connections, by [tangent-bundle splitting](../../Theorems/connections/tangent_bundle_cyclic_refinements.md).
The critical-quartic count proves H0(V_d⊗L)=0 for every dormant d and
every L∈Pic(Y)[2]. Hence all twists of all ten split data are ordinary.
This uses only the independent count theorem and the direct sum.

## 3. Fourteen affine orbits give all nonsplit twists

Use z=1/(u−4), a=1/(t−4). The branch set is F5∪{a}, and the
[affine isomorphisms](../../Theorems/genus_two/prime_field_branch_family.md)
act on ordered pairs (nonzero Hasse root class, nonzero twist class).
There are fourteen orbits. Representatives can be described without
geometric root choices:

| Root class | Twist classes |
|---|---|
| {0,1} | {a,0}, {a,2}, {a,3}, {0,1}, {0,2}, {0,3}, {0,4}, {2,3}, {2,4} |
| {a,0} | {a,0}, {a,1}, {0,1}, {1,2}, {1,−1} |

Indeed the stabilizers of the root classes are respectively z↦1−z
and F5× acting by scaling. Their listed orbits cover all225 ordered
nonzero class pairs. The trivial twist is already ordinary by the count
theorem; it is not included in this list.

Work over F5(t), retaining h for a fiber datum
A=K(h)R0(u)(u−h)². For each representative the
[exact verifier](../../scripts/genus_two/check_genus_two_active_twists.py) forms

    Res_h(J, det(M2)·M1),

where M2 and M1 are the two Cartier blocks from Section1. All fourteen
resultants are nonzero polynomials in F5[t]; their irreducible factors
have degree at most9. Their exact coefficients, factors and orbit sizes
are in the [certificate](../../Research/computations/genus_two_affine_twist_certificate.json).
Thus no geometric root of J gives a bad twist when the parameter degree
is>9. There is no specialization-to-generic inference here.

For the branch datum A=c0 S0 the2x2 determinant is nonzero in every
representative, with irreducible factors of degree at most2. The product
with the scalar has the same bound, except for the representative
({a,0},{1,−1}), whose scalar is identically zero. In u coordinates this
is R0=u−t, R=u(u−3). With G=u(u−1)(u−2)(u−3),

    A=(t+1)²G,       [u⁴] A R²=0.

Its2x2 block is invertible, so its twisted tangent dimension is exactly1.
The affine orbit consists precisely of

    ({a,b}, {b+c,b−c}),       b∈F5, c∈F5×/{±1}.

Actual curve isomorphisms transport connections, root classes and their
twisted tangent spaces. They also preserve the distinction between
four-Weierstrass support and a nonbranch hyperelliptic pair. Since the
transformed parameter has the same degree, the fourteen representative
tests apply to every pair on every curve in the stated locus. This gives
five exceptional branch data with two bad twists each and no other bad
data. The two twist pairs are disjoint and their union complements
{a,b}, so their classes sum to the Hasse root class.

The [bounded audit](../../Research/audits/GENUS_TWO_AFFINE_TWISTS_AUDIT_2026_09_13.md)
checks the symmetry and split-bundle reductions; the exact factorization
is supplied by the executable certificate.

## 4. From the table to actual unbounded covers

Let E_r be the functorial tangent bundle on Y^(1) in
[ordinary_source_partner_finiteness](../../Theorems/common_covers/ordinary_source_partner_finiteness.md).
Its L-twisted sections are the just-computed tangent kernels; on an actual
etale cover its pulled-back sections test ordinary status there.

First take a Galois cover q:W→Y with normal5-group P and elementary
abelian2-quotient A2. The intermediate cover T=W/P→Y decomposes its
function algebra into the degree-zero two-torsion character lines H.
Projection formula gives

    H0(T^(1),E_r|T^(1)) = direct-sum_(L in H) H0(Y^(1),E_r tensor L).

The trivial summand vanishes because r is ordinary. Thus T is ordinary
exactly when H contains none of the table's bad classes.

For W→T, the regular representation of P in characteristic5 has a
filtration with trivial factors. Galois descent gives a filtration of
its pushed-forward structure sheaf with factors O_T. Tensoring by E_r
shows that vanishing downstairs implies vanishing upstairs. Conversely,
any nonzero section downstairs pulls back injectively. This proves the
claimed equivalence for Galois q, without division by its degree.

For a non-Galois intermediate cover, ordinary status on W descends by
section injectivity. If the intermediate cover itself trivializes a bad
line, it dominates the corresponding bad double, so nonordinariness
persists. A bad line on the Galois closure alone supplies no converse.

Finally apply ordinary-source partner finiteness to the ACTUAL common
source whenever the sufficient criterion holds. This retains both maps
and gives finiteness for that monodromy subclass. It says nothing about
general simple factors or the remaining nonordinary joint sources.
