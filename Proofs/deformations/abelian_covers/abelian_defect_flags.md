# Proof: the character flag selects the abelian defect length

[Statement](../../../Theorems/deformations/abelian_covers/abelian_defect_flags.md).
For a bad double D→Y, write the cover group as
C_(5^a)×C_(5^b)×C_(5^c), a≥b≥c, and put Q=5^a,P=5^b,R=5^c.
The formal scalar relation has type UV+W^s, with s=4 on branch pairs
and s=2 on the two mixed backup pairs. The work is to identify which
rational cyclic directions and planes meet its quadratic degeneracy.

## 1. Actual quotient coordinates and what may be changed

Use the formal-cover presentation and the
[actual norm/base-change theorem](abelian_p_defect_node.md).
The maximal abelian pro-five group of D is Z5^3. Its completed
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
Picard chart is the Artin--Schreier character flag used in Section 3.

The [shared length lemma](frobenius_truncated_hypersurfaces.md)
allows changing the largest-exponent coordinates while fixing smaller
ones. Balanced ideals are intrinsic Frobenius powers. We will apply
only those changes after identifying the actual character flag.

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

### The twelve backup cases: coefficient spans

For a quadratic q over a finite extension K/F5, expand its coefficients
in an F5-basis of K. Let W(q) be the F5-span of the resulting quadrics.
For v∈F5³, q(v)=0 exactly when every member of W(q) vanishes at v.
This turns rational anisotropy into linear algebra on six coefficients.

The [verifier](../../../scripts/deformations/check_abelian_defect_flags.py) reconstructs
the actual Frobenius matrix from the Laurent basis, solves its fixed
space over F_(5^12), and checks a k-independent fixed basis of dimension3.
Its first two vectors come from B; the third has negative deck character.
Apply the actual quadratic jet to the fifth powers of this basis.
In monomials x²,y²,z²,xy,xz,yz its coefficient span is one of

    A=⟨x²,y²,z²,xy⟩,
    B=⟨x²,y²+3z²,xy⟩,
    C=⟨x²+3xy,y²+2xy,z²+4xy⟩.

Each has no common nonzero F5-zero. For B, x=0 and y²=2z²;
for C, xy=0 forces all squares to vanish, while xy≠0 gives
x=2y and z²=2y². Both use that2 is nonsquare. A is immediate.
Thus every actual rational cyclic direction has nonzero quadratic
coefficient and defect2; no direction enumeration is needed.
The deck-stable directions are the six lines in the base plane and
the single negative-character line.

If H is the Gram matrix, the determinant on a rational plane with
normal n is a nonzero F5-square multiple of n^T adj(H)n. This
Cauchy–Binet identity also holds for singular H. The coefficient span
of that dual quadratic is ⟨x²,y²,xy⟩ in every branch case, and A
in both mixed cases. Hence the only degenerate branch plane is z=0,
the original base plane; all mixed planes are nondegenerate. The
branch restriction has rank1, since anisotropy rules out rank0.

The [compact certificate](../../../Research/computations/abelian_defect_flag_foundations.json)
records these spans and input hashes for all twelve cases. A
[bounded audit](../../../Research/audits/QUADRATIC_COEFFICIENT_SPAN_AUDIT_2026_09_13.md)
checks the span criterion and adjugate-plane identity.

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

Hence S1^5−S5 must vanish. The opposite sign gives the same zero set.
Since a^5=−a, its numerator is a times a polynomial P(t) over F5;
no coefficient norm is needed. The exact certificate gives deg P=76,
with irreducible factor degrees1,1,10,18,23,23. The denominator is
supported on (t+1)(t²+2t+3)=0. Thus every parameter of degree>23
over F5 has no quadratic-zero actual cyclic direction. The selected
main parameter is included. Also gcd(P,t³+t+1)=1, independently
confirming the canonical branch case at the backup parameter.

The family transport is explicit without a permutation census.
The coordinate z=1/(u−4) identifies the five constant branch points
with F5; their stabilizer acts by z→az+b, a≠0. The canonical omitted
point and bad pair are (0,{1,−1}); their orbit is
(b,{b+a,b−a}), giving all ten branch records. This transports the
quartic divisor, its intrinsic active connection and the original double.
The transformed parameter is an F5-fractional-linear function of t,
so its F5-degree is unchanged. All ten specified branch pairs therefore
have the same cyclic anisotropy for degree>23. The actual generic A3
module only requires Delta≠0, which holds throughout this range.

For any branch pair the Hessian has rank two and its radical lies in
the two-dimensional base plane. It contains no rational cyclic line
by the preceding argument. Two distinct F5-planes intersect in an
F5-line. Therefore only the base plane can contain the radical; its
restriction has rank one, and every other plane has rank two.

## 3. Apply the shared length formulas to the actual flag

When Q>P, the x-axis is a rational cyclic direction, so its quadratic
coefficient is nonzero. The shared lemma gives length 2PR.

When Q=P>R, the maximal-character plane is intrinsically

    image(Hom(G,Z/5^a)→Hom(G,F5)→H1_et(D,F5)).

On a nondegenerate plane, relative splitting leaves residual order s:
order2 in the nondegenerate three-variable case, and the audited
corrected radical order4 in the branch case. The shared formula is
2QR−(R²+s−1)/s. In the balanced case it applies directly to the
formal type, giving the two displayed quadratic expressions in Q.

A degenerate rational plane has rank one. Since Q≥5R, the shared
weighted-degree argument gives length 2QR independently of higher
terms. Section2 identifies exactly this plane with the pullback from
the original genus-two endpoint in each branch case; it is absent in
the mixed cases. This proves every row of the statement, including
R=1 and the trivial balanced cover.

## 4. Low-defect nonabelian consequences

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

## 5. Retained exact evidence

The coefficient-span verifier passes all twelve cases and the symbolic
factorization in0.312s. It uses the independently audited Picard jets;
it does not reconstruct their full cohomology presentation.
The original [audit](../../../Research/audits/ABELIAN_DEFECT_FLAGS_AUDIT_2026_09_11.md),
[receipt](../../../Research/computations/abelian_defect_flags_audit.json) and
[replay](../../../scripts/deformations/audit_abelian_defect_flags.py) retain the independent
372-direction/372-plane checks and twenty semigroup counts. Their
original fixed-basis and plane data also fix the actual Heisenberg
cover inputs. These remain verification evidence; the current proof
uses the coefficient spans and the shared length lemma.

The all-exponent proof is the shared length lemma, not extrapolation
from the finite tests. The nonabelian lower bound uses the inherited
symplectic odd-defect growth result with its author-prose scope.
