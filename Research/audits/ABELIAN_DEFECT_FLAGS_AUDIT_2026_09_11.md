# Unequal abelian defect flags — focused audit

Verdict: **PASS**, with the inherited-input scope below. No coefficient
correction or mathematical gap was found in the proposed theorem.

Auditor: `/root/audit_abelian_defect_flags`. Date: 2026-09-11, 08:46 CEST.
This is a bounded mathematical and exact-arithmetic audit, not Lean
verification and not an audit of the original common-cover problem.

Audited pre-integration draft, now `Solutions/Sol_abelian_defect_flags.md`, SHA256
`aa7e9d4da0cad9ab977ace17185eed0ea7293fc359bf5f7af25f5c212af140b3`.

## Scope and inherited facts

The audit takes the scoped actual-cover conclusions of
`bad_double_abelian_a3_family`, `backup_active_double_germs`, and the
norm/base-change mechanism of `abelian_p_defect_node` as inputs. It
does not re-audit their full Picard matrix computations. The odd-defect
growth assertion of `symplectic_p_cover_section_growth` is used in its
stated symplectic-bundle form for the final nonabelian corollary; that
earlier growth assertion retains its existing author-prose status.

The new claims checked here are:

- the correct actual Artin--Schreier directions and maximal-character
  flag, including coefficient Frobenius;
- the symbolic anisotropy condition and its transport to all ten main
  branch pairs without changing the selected parameter;
- the allowed formal coordinate changes for unequal Frobenius powers;
- the three unequal-exponent colength cases, their flag dependence,
  and the resulting noncyclic/nonabelian lower bounds.

The result remains a one-leg actual-cover theorem. It neither supplies
a second endpoint map nor forces an arbitrary common source through
one of these doubles or abelian quotients.

## Actual cover and tangent identification

For an ordinary genus-three curve, the maximal abelian pro-five group
is Z5^3. Every finite abelian quotient is dominated by a balanced
quotient. Applying the established norm/base-change theorem on that
actual balanced cover gives the finite quotient of the same scalar
presentation. Thus the argument does not confuse arbitrary invariant
modules with actual defect cokernels.

A Smith-normal-form basis gives the ideal `(x^Q,y^P,z^R)` for the
specified finite quotient. The induced tangent map on the universal
character space is dual to the group quotient. In particular, the
subspace of maximal-order characters is genuinely

    image(Hom(G,Z/5^a) -> Hom(G,F5) -> H1_et(D,F5)).

When a=b>c, its dimension is two: homomorphisms from a smaller cyclic
factor into Z/5^a have image divisible by five and reduce to zero.
This proves that the stated flag is independent of invariant-factor
generators and is the flag used by the unequal-power coordinates.

Writing absolute Frobenius on H1(O_D) as `xi -> M xi^[5]`, the actual
AS classes satisfy `M xi^[5]=xi`. The audited Picard four-jet is on
D^(1), so its direction is `v=xi^[5]`. Consequently its fixed-vector
equation is `v=M^[5] v^[5]`, exactly as used in the draft. The deck
parameter is not raised to its fifth power. The truncated logarithmic
change has invertible linear term and does not change the nonzero
quadratic coefficient or a cyclic length less than five.

Three k-linearly independent fixed solutions exhaust the geometric
AS space: ordinarity gives its F5-dimension three. Finding such a basis
in F_(5^12) is therefore a completeness certificate, not an assumption
that all covers must have a preassigned field of definition.

## Independent finite replay

New independent script:
`scripts/audit_abelian_defect_flags.py`.

Replay:

    sage -python scripts/audit_abelian_defect_flags.py \
      --output Research/computations/abelian_defect_flags_audit.json

It completed with PASS in 0.281 seconds after startup. It imports
neither producer and does not use the stored Hessian for its plane
ranks. Specifically, it:

1. reconstructs the recorded F_(5^12), checks the embedded alpha,
   and verifies all twelve upstream jet-file hashes;
2. independently rebuilds the actual H1(O) Frobenius matrix from
   the coefficients of F^2 and S^2 in the Laurent basis;
3. verifies all three fixed basis vectors and their k-independence
   in every case;
4. checks all 372 actual cyclic directions, using the required fifth
   power before evaluating the audited quadratic scalar;
5. checks all 372 rational two-planes by direct polarization of that
   scalar, independently of the producer's Hessian matrix;
6. verifies exactly six base directions and one anti-invariant
   projective direction per original double;
7. independently clears and eliminates the two symbolic fixed-vector
   equations, reproducing the degree-76 numerator and denominator;
8. directly counts the monomial semigroup in all twenty balanced or
   unequal Q,R cases with Q,R in {1,5,25,125}, for s=2 and s=4.

Every cyclic quadratic is nonzero. In each branch case precisely the
original base plane has rank-one restriction; its other thirty planes
have rank two. In each mixed case all thirty-one have rank two.

The producer's complete 30-by-30 matrix replay is an additional check,
not the independent computation asserted in this audit. The independent
check uses the already audited scalar jets and establishes that all
their actual cyclic restrictions have order exactly two; the established
unit Schur block then suffices for the cyclic length.

Receipt SHA256:
`c779fb7659e8bdfabe8440d1a63b258f6edaf3434b4aa87652b18f6d87dffa94`.
Input cyclic-direction receipt SHA256:
`f177cae3169218c9527e3e08e1153d710303da54845d1862d25324411d4e7f61`.

## Main symbolic condition and actual family transport

The displayed Frobenius matrix follows directly from the H1(O)
Laurent representatives: its invariant block is
`[[[u^4]F^2,[u^9]F^2],[[u^3]F^2,[u^8]F^2]]`, and its remaining entry
is `[u^4]S^2=t^2+2t+3`.

On the quadratic cone, Z=0 would force X=Y=0. Otherwise the two
possibilities are `X/Z=+-sqrt(2)/(t+1)`. Dividing the twisted fixed-vector
equations by the Z equation gives exactly the two displayed expressions
S5 and S1. Thus `S1^5-S5=0` is necessary. Its degree-76 nonzero numerator
and allowed denominator were independently reproduced. The selected
main parameter satisfies the stated degree bound.

The transport is geometric, not just an observed permutation of table
labels. The coordinate `z=1/(u-4)` identifies the five constant branch
points with F5. The omitted canonical infinity becomes z=0, and the
canonical bad pair {0,3} becomes {1,-1}. The stabilizer of 4 in
PGL2(F5) is the affine group `z -> az+b`. Its orbit consists exactly of
the ten records

    omitted point b, bad pair {b+a,b-a}, a!=0 modulo sign.

The actual four-Weierstrass zero divisor is transported at the same
time, so the intrinsic active connection formula transports the pair.
The actual etale double and its original genus-two map are transported
as well. Replacing t by this F5-fractional-linear function preserves
its field degree and does not select a new main parameter.

In each branch case the rank-two Hessian radical belongs to the base
plane but is not an F5-rational line, by cyclic anisotropy. If any
different F5-plane contained that radical, its intersection with the
base plane would make the radical rational. Therefore the base plane
is exactly the exceptional plane. A plane not containing the radical
has nondegenerate restriction because its projection to the
two-dimensional nondegenerate quotient is an isomorphism.

Optional strengthening, not needed for PASS: the degree-76 numerator
is sqrt(2) times a polynomial over F5. Its F5 factor degrees are
1,1,10,18,23,23. The draft's degree bound is therefore conservative.
This observation does not weaken its parameter-domain claim.

## Formal changes and all exponent lengths

The unequal-power ideal is not invariant under arbitrary formal
changes. The draft correctly restricts the changes:

- with Q>P, changing only x preserves the ideal, because every
  positive y,z monomial has Q-th power in `(y^P,z^R)`;
- with Q=P, changing x,y while keeping z fixed preserves it;
- an invertible univariate change of z preserves `(z^R)`;
- with Q=P=R, the ideal is intrinsic `m^[Q]`.

Applying the inverse changes proves equality of ideals, not just one
containment. Units multiplying f have no effect on the quotient.

For Q>P, relative one-variable splitting gives `x^2+g(y,z)`, g of
order at least two. In the remaining truncated coefficient ring,
`g^((Q-1)/2)=0` because Q>=5P and its minimum total degree exceeds
P+R-2. Thus x^Q imposes no extra relation and the length is 2PR.

For Q=P>R with nondegenerate plane, relative splitting and an allowed
univariate change give `xy+z^s`. The residual order is two in the
nondegenerate three-variable case and four in the rank-two A3 case.
In the latter case this is exactly the audited corrected radical
quartic, independent of which nondegenerate transverse plane is used.
Counting the semigroup with generators `(s,0),(0,s),(1,1)` gives

    2QR-(R^2+s-1)/s.

The same count at Q=R gives the two balanced formulas.

For Q=P>R with rank-one plane, relative splitting gives
`x^2+g(y,z)` with g in `(y^3,yz,z^2)`. Weights wt(y)=1, wt(z)=2
give minimum weight three in g, while the truncated ring has maximum
weight Q-1+2(R-1). The inequality
`3(Q-1)/2 > Q-1+2(R-1)` follows from Q>=5R. Therefore x^Q again imposes
no additional relation, and the length is 2QR. No assumption on
uncalculated higher coefficients was needed.

These arguments include R=1 and the identity cover at Q=P=R=1.
They prove all exponents; the finite tests are checks, not extrapolation.

## Nonabelian consequence and verdict

Every noncyclic finite five-group has a quotient (Z/5)^2. Its actual
intermediate source has defect nine or ten by the newly proved formula.
Pullback of sections gives the lower bound nine on the full source.
If the group is nonabelian, the cover above this intermediate is
nontrivial. Defect nine increases to at least ten by the inherited
odd symplectic-defect growth theorem; defect ten needs only monotonicity.
Thus the final lower bound ten is valid without assuming an arbitrary
second leg, a simultaneous Galois closure, or Jacobian ordinarity of
an indigenous connection.

All new arguments pass. Canonical promotion is appropriate with the
upstream evidence scopes retained, especially the author-prose status
of the odd-defect growth input. The common-cover problem remains open.
