# Unequal abelian exponents: a flag-sensitive defect formula

Author proof, 2026-09-11. Fresh bounded audit PASS by
/root/audit_abelian_defect_flags, same date; no mathematical correction.
Report: Research/audits/ABELIAN_DEFECT_FLAGS_AUDIT_2026_09_11.md.
The inherited odd-defect growth lemma retains its author-prose status.
This is an actual one-leg theorem for both selected pairs, not an
exclusion of arbitrary common covers. Nothing here is Lean verified.

[Statement](../Theorems/Thm_abelian_defect_flags.md).

## Theorem

Take any of the twelve bad active doubles D->B at the backup, or any
of the ten branch-support bad active doubles over the selected
high-degree main genus-two partner. Set s=2 for the two extra mixed
backup pairs and s=4 for the remaining pairs. The completed actual
maximal-abelian pro-five defect relation has type UV+W^s.

For any connected finite etale abelian five-group cover T->D, write

    G=Z/5^a x Z/5^b x Z/5^c,    a>=b>=c>=0,
    Q=5^a, P=5^b, R=5^c.

These exhaust the possible groups because D is ordinary of genus three.
Then the actual indigenous defect is:

* a=b=c:  (7Q^2-3)/4 for s=4, and (3Q^2-1)/2 for s=2;
* a>b:    2PR;
* a=b>c:  2QR-(R^2+s-1)/s, except in the flag described next;
* the exception, only for s=4: 2QR when the two maximal-order
  characters reduce to the plane pulled back from the original B.

The same original genus-two endpoint is meant in that last condition,
not an arbitrary genus-two quotient of the genus-three curve.

Intrinsic description of the flag: the image of

    Hom(G,Z/5^a) -> Hom(G,F5) -> H1_et(D,F5)

is a two-dimensional plane when a=b>c. The first arrow is reduction
modulo five, and the second comes from the actual cover. Compare this
plane with h*H1_et(B,F5), where h:D->B is the original double. The
flag is independent of choices of invariant-factor generators.

In particular every nontrivial CYCLIC five-power cover has defect two.
Among rank-two exponent-five covers, thirty have defect nine and one
has defect ten in each branch case; all thirty-one have defect nine
in each extra mixed case. Every noncyclic five-group Galois cover has
defect at least nine, and every nonabelian one has defect at least ten.

The formula concerns every actual abelian cover, not merely towers
whose defining characters lie in one chosen coefficient field.

## 1. Actual quotient coordinates and what may be changed

Use the audited formal-cover presentation and the actual norm/base-change
theorem. The maximal abelian pro-five group of D is Z5^3. Its completed
group algebra is k[[e1,e2,e3]], and its negative-cohomology presentation
has five invertible blocks and one scalar relation f. Finite quotients
are obtained by tensoring this actual presentation, not by guessing a
new obstruction from the abstract quotient group.

Smith normal form over Z5 chooses a basis in which a specified quotient
has ideal

    I=(x^Q,y^P,z^R).

Changing the Z5 basis of the group gives the actual multiplicative
formal substitution e_i -> product_j(1+e_j)^(m_ij)-1. Its tangent map
has coefficients in F5. The quotient's tangent flag in the formal
Picard chart is the Artin--Schreier character flag described above.

Arbitrary formal coordinate changes do NOT preserve unequal-power
ideals. The proof below uses only these allowed transformations:

1. If Q>P>=R, change x while keeping y,z fixed. Any local invertible
   such substitution preserves I, since Q-th powers of all positive
   y,z monomials lie in (y^P,z^R); apply the inverse for equality.
2. If Q=P>=R, arbitrary changes of x,y keeping z fixed preserve I
   for the same reason. A further univariate invertible change of z
   preserves z^R.
3. If Q=P=R, I is the intrinsic Frobenius-power ideal and every
   formal coordinate change preserves it.

Multiplication of f by a unit does not change its quotient. All
splitting lemmas below are in characteristic not two and need only
division by units, not by five.

## 2. Actual rational cyclic directions are all quadratic

Write the formal Picard tangent basis as v/u,v/u^2,ell/u. If xi is an
Artin--Schreier class on D with coefficient vector in this basis, then

    M xi^[5]=xi

for the actual absolute-Frobenius matrix M on H1(O_D). In the twisted
Picard coordinates used by the audited jet, the vector is xi^[5], not
xi. The parameters of the deck group are not raised to fifth powers.

For a cyclic character the actual order-four transition is

    exp(chi^(1) log(1+e)) mod e^5.

Thus its scalar relation modulo e^5 is the audited Picard four-jet
evaluated at xi^[5] log(1+e). This identifies actual covers, not just
arbitrary k-rational lines in a quadratic cone.

### All twelve backup cases

`scripts/backup_bad_double_cyclic_directions.py --matrix-replay` solves
the Frobenius-fixed equations over F_(5^12). In every case it produces
three F5-linearly independent solutions which are also k-independent.
Ordinarity gives dim_F5 H1_et(D,F5)=3, so these already exhaust the
geometric Artin--Schreier space. No assumption that every cover was
originally defined over this field is needed for completeness.

For all 31 projective directions in every one of the twelve cases,
the quadratic coefficient is NONZERO. All 372 full 30-by-30 twisted
cohomology presentations independently have cokernel dimension two;
these rank checks use all matrix coefficients, not just the Schur
scalar. The total after startup is about 1.5 seconds. Exactly seven
directions are invariant under the original double's deck involution:
six are pulled back from B and one has the negative character.

The same calculation enumerates all 31 rational two-planes. In each
branch case exactly one has restricted Hessian rank one, and it is
precisely h*H1_et(B,F5). The other thirty have rank two. In each
mixed case all thirty-one have rank two. The exact fixed bases,
directions, planes, field embedding and input hashes are saved in
Research/computations/backup_bad_double_cyclic_directions.json.

### A symbolic test covering the same main parameter

It suffices first to take the canonical branch pair

    R=u(u-3), S=(u-1)(u-2)(u-t), A=(t+1)^2 G.

In the stated H1(O) basis its actual Frobenius matrix is diag(M_B,E),
where

    M_B=[[A0,B0],[C0,D0]],
    A0=3t^2+4t+1, B0=3t+3,
    C0=3t^2+3t,   D0=t^2+4t+3,
    E=t^2+2t+3.

The normalized quadratic scalar is

    3(t^5-t)X^2+4(t^5-t)/(t+1)^2 Z^2.

Suppose a nonzero actual cyclic direction lies on its zero cone.
If Z=0, then X=0, and the first Frobenius equation forces Y=0
because B0!=0. This is impossible. Otherwise choose a in F25 with
a^2=2. After choosing one of the two signs, set

    X/Z=c0=a/(t+1),     Y/Z=s0.

The fixed-vector condition on the TWISTED Picard vector is
v=M^[5]v^[5]. Dividing its first two rows by its last row gives

    s0^5=(E^5 c0-A0^5 c0^5)/B0^5=:S5,
    s0=(C0^5 c0^5+D0^5 S5)/E^5=:S1.

Hence S1^5-S5 must vanish. The opposite sign negates both expressions
and gives the same zero set. Exact arithmetic shows its nonzero
numerator has degree 76 over F25, and its denominator is supported
only at (t+1)(t^2+2t+3)=0. Its coefficient norm is a nonzero degree-152
polynomial over F5. These claims are algebraic identities, not a
sampling or parameter-degree heuristic.

Consequently every t of degree greater than 76 over F25 has NO
quadratic-zero actual cyclic direction on this double. The selected
main parameter already satisfies this. In particular the conclusion
does not ask for a changed main parameter.

The twenty elements of PGL2(F5) fixing the missing constant branch
point 4 preserve {0,1,2,3,infinity}. Their action carries this one bad
branch pair to all ten table entries, with t replaced by a fractional
linear function of t. The finite permutation check is explicit in
`scripts/check_abelian_defect_flags.py`. Degree over F25 is unchanged,
and the four-branch active connection is carried along by its actual
quartic zero divisor and the intrinsic projective-connection formula.
Thus all ten main pairs have the same cyclic anisotropy property.

For any branch pair the Hessian has rank two and its radical lies in
the two-dimensional base plane. It contains no rational cyclic line
by the preceding argument. Two distinct F5-planes intersect in an
F5-line. Therefore only the base plane can contain the radical; its
restriction has rank one, and every other plane has rank two.

## 3. Unique largest cyclic exponent

Suppose Q>P. The x-axis is an actual cyclic direction, so the x^2
coefficient of f is nonzero. The one-variable formal splitting lemma,
keeping y,z fixed, replaces f by

    x^2+g(y,z),       g in (y,z)^2.

It is an allowed coordinate change by Section 1. Over
A=k[[y,z]]/(y^P,z^R), this relation gives a free rank-two module with
basis 1,x. Since Q is odd,

    x^Q=(-g)^((Q-1)/2)x.

Every term of that power of g has total degree at least Q-1. But A
has no monomial of degree above P+R-2. The strict exponent inequality
gives Q>=5P>P+R-1, so x^Q is already zero. It imposes no additional
relation. The length is exactly 2PR.

## 4. Two equal largest exponents, transverse flag

Now Q=P>R and the restricted Hessian on the x,y plane is nondegenerate.
The relative two-variable splitting lemma, with z unchanged, gives

    xy+h(z).

Its critical residual has order s: this follows directly from the
nonzero determinant when s=2, and from the already audited corrected
radical quartic when s=4. A univariate unit change of z, including
an s-th root of its unit factor, makes h(z)=z^s. All coordinate
changes preserve (x^Q,y^Q,z^R) by Section 1.

Use k[[x,y,z]]/(xy-z^s)=k[[xi^s,zeta^s,xi*zeta]]. Monomials correspond
to pairs (i,j)>=0 with i=j modulo s. The retained ones satisfy

    i<sQ, j<sQ, and (i<R or j<R).

Writing R=sm+1 (since 5^c is 1 modulo both 2 and 4), the excluded
square has residue counts Q-m-1 once and Q-m on the other s-1
residue classes. Subtracting its matching-residue count from sQ^2
gives exactly

    2QR-(R^2+s-1)/s.

The same count with Q=R is the balanced formula; in that case every
formal coordinate change is allowed and no flag condition is needed.

## 5. Two equal largest exponents, degenerate flag

Suppose Q=P>R and the plane Hessian has rank one. An allowed linear
change of x,y followed by one-variable splitting gives

    f=x^2+g(y,z),     g in (y^3,yz,z^2).

No higher vanishing or special choice of a quartic is assumed here.
Give y weight one and z weight two. Then every term of g has weight
at least three, while every surviving monomial in
k[[y,z]]/(y^Q,z^R) has weight at most Q-1+2(R-1). Since Q>=5R,

    3(Q-1)/2 > Q-1+2(R-1).

Thus g^((Q-1)/2)=0 and again x^Q imposes no additional relation.
The length is 2QR. The rational-plane calculation identifies this
case exactly with the original base plane in each branch example;
it does not occur in either mixed backup example.

## 6. Low-defect nonabelian consequences

Every noncyclic finite five-group P has a quotient (Z/5)^2. Pull back
the actual connection to that intermediate curve. The formula gives
defect nine or ten, so every actual P-cover has defect at least nine.
If P is nonabelian, the cover above this abelian intermediate is
nontrivial with five-group Galois group. When the intermediate defect
is nine, the existing symplectic odd-defect growth theorem makes it
at least ten upstairs; when it is ten, monotonicity suffices. Thus
every nonabelian P-cover has defect at least ten.

For each bad double, the only defects below nine in a nontrivial
five-group Galois cover are consequently the value two, on cyclic
covers. This does not assert that every general common source
factors through such a double or has such a Galois group.

## 7. Tests and remaining scope

The generic anisotropy polynomial, all twenty parameter transformations,
and thirty unequal-power quotient lengths with nonlinear higher terms
are checked by `scripts/check_abelian_defect_flags.py`. The tests include
Q=125,R=25, retain the unequal-power ideal in its actual coordinate
order, and take about thirty seconds. The proof of all exponents is
Sections 3--5, not extrapolation from those finite tests.

The exact formulas do not determine semilinear iterated ranks for
arbitrary higher-rank groups. For cyclic covers the existing simple-zero
tower theorem does apply, now with ell=2 in EVERY cyclic direction.

An independent audit reconstructed all twelve H1(O) matrices directly
from the defining polynomials, checked all 372 actual cyclic directions
and 372 plane restrictions by direct polarization, and independently
eliminated the generic fixed-vector equations. It also checked twenty
balanced and unequal semigroup counts. Its script and receipt are
`scripts/audit_abelian_defect_flags.py` and
`Research/computations/abelian_defect_flags_audit.json`.

The family transport has an intrinsic description: z=1/(u-4) identifies
the five constant branch points with F5. The stabilizer of 4 acts as
z -> az+b, a!=0. The canonical omitted point and bad pair become
(0,{1,-1}); their orbit consists of (b,{b+a,b-a}), all ten records.
Thus this is transport of the actual divisor and original double.
No higher Hodge obstruction, full-tower descent, common-connection
existence, or new arithmetic-curve exclusion is asserted.
