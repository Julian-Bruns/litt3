# Proof: Frobenius residue classes give linear-size exact matrices

[Statement](../../../Theorems/jacobians/theta_divisors/raynaud_genus_two_determinant.md).
Use the [exact-differential conventions](../../../Definitions/theta_cartier.md).

The Kummer-divisor assertion is [Tong, Propositions1.2.3.1 and1.2.3.3](https://arxiv.org/pdf/0712.2046),
including the line-bundle identification in the proof of1.2.3.3.
We use its notation Θ, Θ_class and Kum for this assertion; Tong's B is
the bundle B_{1,C} defined here. For a genus-two Kummer quartic,
H⁰(P³,O(2))→H⁰(Kum,O(2)) is an isomorphism, proving uniqueness of
the quadric in characteristic5. The coordinates below are those of
[Corte-Real Santos–Flynn, Section2, equations2.2–2.4](https://people.maths.ox.ac.uk/flynn/arts/art43.pdf),
with (Z0,Z1,Z2,Z3)=(k1,k2,k3,k4).

## 1. All powers without ordinarity

Set H=F^((p-1)/2). Inverse coefficient Frobenius takes the representative
D1 of M to a divisor D on C, cut out by U and the chosen sheet. Then
F_C^*M^m=O(pm D-2pm O). The full space of twisted canonical sections
is represented by

    (A+vB) eta/U^(pm), eta=du/v,
    deg A<=pm+1, deg B<=pm-2,                         (a)

with cancellation along pm iota(D). Indeed eta/U^(pm) has order
4pm+2 at O; the twist requires order at least2pm, so the numerator
has pole at most2pm+2. The semigroup<2,5> gives exactly(a).

Cartier acts separately on the invariant and anti-invariant parts under
v->-v. Since A/v=AH/v^p and U^(pm) is a pth power, exactness says

    [u^(pi+p-1)] AH=0 (0<=i<=m+1),
    [u^(pi+p-1)] B=0  (0<=i<=m-2).                  (b)

The second list is empty for m=1. No cancellation between the two
lists is possible: their Cartier images have opposite hyperelliptic
parities, and p is odd.

By [Joshi, Theorem1.1](https://comptes-rendus.academie-sciences.fr/mathematique/item/10.1016/j.crma.2004.02.019.pdf),
the exact-differential bundle B_{1,C} is stable of slope1. Hence
H¹(B_{1,C}(2mO^(1)))=0: its Serre dual has slope1−2m<0.
Twisting the Cartier sequence by O(2mO^(1)) therefore gives a surjection

    H⁰(C,ω_C(2pmO)) → H⁰(C^(1),ω_(C^(1))(2mO^(1))).

Its anti-invariant parts have bases u^j eta, 0≤j≤pm+1, and
z^i eta^(1), 0≤i≤m+1. Since p is odd, the involution eigenspaces split,
so this block is onto. Its coefficient rows are precisely the first
list in(b), with the usual Frobenius semilinearity. Thus its rank is
m+2 and dim S_m=(p−1)m for every smooth C.

The allowed B in(b) are exactly

    B=sum_(r=0)^(p-2) u^r B_r(u^p), deg B_r<m.

The etale square-root algebra modulo U1 has a UNIQUE lift to modulo
U1^m with the chosen sheet, even if U1 has a repeated root. Thus V_m
exists and is a unit. In the source coordinate u, the rational function
V_m(u^p)/H is the selected square root of F modulo U^(pm), since its
square is F^(1)(u^p)/H^2=F there and its initial sheet is correct.
The full cancellation condition in(a) is therefore

    AH-V_m(u^p)B=0 modulo U^(pm).                   (c)

Separate(c) by residues modulo p and use U^(pm)=U1(u^p)^m.
For each r=0,...,p-2 it says

    B_r=V_m^(-1) C_r modulo U1^m.

Such a B_r of degree<m exists exactly when the m coefficients of
degrees m,...,2m-1 vanish. It is then unique. The residue p-1 is
already zero by(b). This proves(P), including all m divisible by p.
It proves a bijection of section spaces (with the usual Frobenius
semilinear convention), not just a determinant vanishing implication.

The [matrix replay](../../../scripts/connections/check_theta_power_matrices.sage)
compares the compressed kernel with all original section and Cartier
equations, including reconstruction of its sections. Its96 cases use
p=3,5,7 and m=1,2,3,4, with ordinary and nonordinary curves and repeated
support. The rank argument above passed the bounded medium audit
/root/audit_extension_fiber_scope,2026-09-14; the explicit quadric retains
its original author-proof status.

## 2. The four-square matrix in characteristic five

Take p=5,m=1. Reducing each residue polynomial modulo z²−Sz+P gives

    L_r=c_r−P c_(r+10)−SP c_(r+15),
    H_r=c_(r+5)+S c_(r+10)+(S²−P)c_(r+15).

The cancellation equations(c) become L_r=q0 B_r and H_r=q1 B_r.
Since(q0,q1)≠(0,0), they determine B_r uniquely exactly when
q1 L_r−q0 H_r=0. This is the displayed matrix D, with the same kernel
as T_1. No rank hypothesis remains: Section1 gives dim S_F=4.

## 3. Symbolic quadric reduction for F_t

The source [raynaud_genus_two_determinant.sage](../../../scripts/genus_two/raynaud_genus_two_determinant.sage)
works over F5(t), constructs the four-dimensional S_F, and checks
its basis against the original Cartier matrix. It computes det D (75
terms), not a large polynomial-system Groebner basis.

For transparency, the reduction to Kummer coordinates is as follows.
Let F^(1) mod U1=r0+r1*z, put y=q1^2 and

    o=f_2^5+f_3^5*S+f_4^5*S^2+f_5^5*S*(S^2-P), y=w+o.

The Mumford identities are q0^2=r0+P*y and
2q0*q1=r1-S*y. The determinant is homogeneous of degree4 in(q0,q1).
Replace its five monomials q0^i*q1^(4-i), i=0,...,4, by

    y^2, (r1-S*y)y/2, (r0+P*y)y,
    (r0+P*y)(r1-S*y)/2, (r0+P*y)^2.

Call the resulting polynomial d(S,P,w). Put Delta=S^2-4P and

    K=Delta*y^2-(2S*r1+4r0)*y+r1^2,
    R=Res(U1,F^(1))=P product_(b=1,2,3,t^5)(b^2-S*b+P).

K is the usual quartic Kummer equation, and d is quadratic in w.
Writing d2=[w^2]d, the source verifies the polynomial identity

    Delta*(d-R*q)=(d2-R*q33)*K,                    (2)

where q=Q_t/[t^2(t+1)^4] and q33=[w^2]q. Division by R is done
factor by factor with explicit remainder checks; the remaining fit is
linear algebra for ten coefficients, checked against the original
polynomial. The literal ten polynomial coefficient arrays are frozen
in the source and checked, not inferred from numerical interpolation.

## 4. Why no boundary component is missed

The displayed basis denominators, rank minor, and Hasse--Witt determinant
are checked symbolically; they are nonzero for t not in F5. Thus the
chart criterion and(2) apply to every such specialization, not only the
generic parameter. On the open Mumford locus R Delta!=0, they identify
the support of Theta_B with the zero set of Q_t.

The removed divisors are the theta boundary, its translates by the five
finite Weierstrass classes (D contains a branch point), and the doubled
Abel curve (D is repeated). Every one of these irreducible curves
contains0 in the Jacobian. Ordinarity puts0 outside Theta_B. Also
kappa(0)=[0,0,0,1] and Q_t(kappa(0))=(t+1)^4!=0. Therefore neither
divisor has an irreducible component contained in the removed boundary.
Both supports are the closures of their restrictions to this open set,
so they agree everywhere. No inference about multiplicities is needed
for this continuation argument.

The [family singleton theorem](../torsion/family_singleton_root_exclusion.md)
uses this global support equation to settle the associated singleton
intersection, including its boundary points.
