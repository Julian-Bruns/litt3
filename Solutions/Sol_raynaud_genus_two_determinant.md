# Proof: Frobenius residue classes give linear-size exact matrices

[Statement](../Theorems/Thm_raynaud_genus_two_determinant.md).
Author /root2026-09-08. This retains actual twisted sections and includes
the full H0 kernel, rather than just their norms. Version2 adds all
powers in odd characteristic and the principal-theta companion.

## 0. The parameterized calculation

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

The first list has full rank m+2. Here is a uniform ORIGINAL rank minor,
not a dimension estimate. Take coefficient columns

    0, 1, (p+3)/2, (p+3)/2+p, ...,
                                      (p+3)/2+(m-1)p.

In the last m rows the first two columns vanish. The remaining m-square
block is upper triangular with diagonal1 because H is monic of degree
5(p-1)/2. The upper-left2-square block is

    [[H_(p-1),H_(p-2)],[H_(2p-1),H_(2p-2)]],

the Hasse--Witt matrix. It is invertible by ordinarity. Consequently
dim S_m=(pm+2)-(m+2)=(p-1)m. The allowed B in(b) are exactly

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

For(V) replace(a) by functions (A+vB)/U^p representing
H0(O(O) tensor V(M)). The numerator has pole at most2p+1, hence
deg A<=p and deg B<=p-2. There is NO Cartier condition. Cancellation
is still AH-V1(u^p)B=0 modulo U^p. Its residue p-1 gives the first
two rows of E; the other residues give
L_r=q0 B_r, H_r=q1 B_r. Since(q0,q1)!=0, these equations determine
B_r uniquely iff q1 L_r-q0 H_r=0. This proves(V) without discarding
a rank stratum. Ordinarity is not needed for this companion assertion.

The small diagnostic [check_theta_power_matrices.sage](../scripts/check_theta_power_matrices.sage)
compares the compressed matrices with the FULL original section and
Cartier equations, using explicit original-matrix kernel replay. Its
48 tests use p=3,5,7, m=1,2,3,4, and include repeated support;
they ran in about0.49 seconds on one core. It also compares the
principal-theta companion with its original section equations. These
finite tests supplement the preceding proof; they do not prove(P).

## 1. Complete section spaces and sheetwise cancellation

Take inverse coefficient Frobenius of the reduced Mumford divisor of M
to obtain D on C, with U=u^2-s*u+pi and V=v0+v1*u. Thus
S=s^5,P=pi^5,q0=v0^5,q1=v1^5 and F_C^*M=O(5D-10O).
A twisted canonical section is uniquely represented as

    (A+vB)eta/U^5, eta=du/v, deg A<=6, deg B<=3,

provided its numerator vanishes along5iota(D). Indeed eta/U^5 has
order22 at O, and the required twist imposes order at least10 there;
the numerator may have pole at most12. This gives exactly the stated
eleven-dimensional space by the pole semigroup<2,5>. Cancellation at
the other sheets is the only remaining regularity condition.

Since gcd(U,F)=1 and V^2=F modulo U, the function V^5/F^2 modulo U^5
is the unique lifted square root of F agreeing with V modulo U:
its square is V^10/F^4=F modulo U^5. This also works for repeated U.
Hence the sheetwise condition is exactly

    AF^2-V^5 B=0 modulo U^5.                       (1)

The Cartier-zero condition is A in S_F, because Bdu is exact and
A/v=AF^2/v^5. No condition on a norm replaces(1).

## 2. Four residue classes, not ten independent jet equations

Put z=u^5. The quotient relation is z^2-Sz+P=0. For A in S_F,
AF^2 has no coefficients in degrees4,9,14. Its reduction modulo U^5
therefore has, for r=0,1,2,3, the coefficient pair

    L_r=c_r-P*c_(r+10)-S*P*c_(r+15),
    H_r=c_(r+5)+S*c_(r+10)+(S^2-P)*c_(r+15)

at u^r and u^(r+5). Equation(1) is exactly

    L_r=q0 B_r, H_r=q1 B_r.

The pair(q0,q1) is nonzero since U1 is coprime to F^(1). Thus B_r
exists uniquely precisely when q1 L_r-q0 H_r=0. This is the matrix
in the theorem. A=0 also forces B=0. We have a bijective linear
description of the entire twisted Cartier kernel, proving its dimension
and theta-membership claims, including valid repeated Mumford divisors.

## 3. Symbolic quadric reduction for F_t

The source [raynaud_genus_two_determinant.sage](../scripts/raynaud_genus_two_determinant.sage)
works over F5(t), constructs the FULL four-dimensional S_F, and checks
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
Writing d2=[w^2]d, the source verifies the EXACT polynomial identity

    Delta*(d-R*q)=(d2-R*q33)*K,                    (2)

where q=Q_t/[t^2(t+1)^4] and q33=[w^2]q. Division by R is done
factor by factor with explicit remainder checks; the remaining fit is
linear algebra for ten coefficients, checked against the original
polynomial. The literal ten polynomial coefficient arrays are frozen
in the source and checked, not inferred from numerical interpolation.

The resulting calculation takes about0.13s on one core. Specializing
t=alpha, alpha^3+alpha+1=0, it agrees up to scalar with the FIFTH
POWERS of the independently constructed backup_raynaud_quadric
coefficients. This checks the Frobenius convention as well as the formula.

## 4. Why no boundary component is missed

The displayed basis denominators, rank minor, and Hasse--Witt determinant
are checked symbolically; they are nonzero for t not in F5. Thus the
chart criterion and(2) apply to every such specialization, not only the
generic parameter. On the open Mumford locus R Delta!=0, they identify
the SUPPORT of Theta_B with the zero set of Q_t.

The removed divisors are the theta boundary, its translates by the five
finite Weierstrass classes (D contains a branch point), and the doubled
Abel curve (D is repeated). Every one of these irreducible curves
contains0 in the Jacobian. Ordinarity puts0 outside Theta_B. Also
kappa(0)=[0,0,0,1] and Q_t(kappa(0))=(t+1)^4!=0. Therefore neither
divisor has an irreducible component contained in the removed boundary.
Both supports are the closures of their restrictions to this open set,
so they agree everywhere. No inference about multiplicities is needed
for this continuation argument.

The formula describes the whole theta support for the parameter family.
It does not decide its intersection with V(M)=2[P-O] away from the
Weierstrass points. Only the previously specialized alpha case has the
complete three-chart exclusion. The prime-to5 condition for actual
canonical etale roots remains necessary if any other fiber has survivors.

## 5. The explicit principal-theta companion cubic

Apply(V) with p=5 and the SAME F_t and Kummer coordinates as above.
The source [verschiebung_genus_two_cubic.sage](../scripts/verschiebung_genus_two_cubic.sage)
constructs the six-square determinant directly, without choosing a
kernel for its first two rows. It has85 terms and degree4 in(q0,q1).
Make the same five replacements as in Section3, obtaining d_V(S,P,w).
There is a cubic E_t, below, satisfying the ORIGINAL polynomial identity

    Delta*(d_V-R E_t)=([w^2]d_V-R*[w^2]E_t)*K.      (3)

Thus on R Delta!=0, E_t=0 iff V(M) is in principal theta. This is
a chart identity; no unsupported conclusion at R Delta=0 is needed.
The exact symbolic construction and frozen-coefficient replay take
about0.13 seconds on one core.

Here E_t=sum e_(a,b,c) S^a P^b w^c; all omitted coefficients are zero.

| (a,b,c) | e_(a,b,c) |
| --- | --- |
| (0,0,0) | 3t^6(t^3+2t^2+t+3)(t^3+2t^2+4t+2) |
| (0,0,1) | 3(t+1)t^2(t^2+t+1)^2 |
| (0,0,2) | 3(t+1)(t+2) |
| (0,1,0) | (t+1)t^3(t^6+4t^5+3t^4+t^3+3t^2+4t+1) |
| (0,1,1) | 3(t+1)(t^2+4t+1) |
| (0,2,0) | 4(t+1)^2(t^3+2t^2+t+4)(t^3+4t^2+3t+4) |
| (0,2,1) | t+1 |
| (0,3,0) | 3t(t+1) |
| (1,0,0) | 3(t+1)t^6(t^2+t+1)^2 |
| (1,0,1) | 4t^2(t+1)^2(t^2+4t+1) |
| (1,0,2) | 4(t+1) |
| (1,1,0) | 3(t+1)t^5(t^2+4t+1) |
| (1,1,1) | 2t(t+1) |
| (1,2,0) | (t+1)t^2 |
| (2,0,0) | (t+1)(t+3)t^6 |
| (2,0,1) | 4(t+1)t^2 |

This is useful for the generic singleton question WITHOUT claiming its
answer. Reparametrize a pair V(M)=2[P-O] by

    N=3M-Fr_J([P-O]), M=2N, V(N)=[P-O].

The identities use V Fr_J=[5]. They are mutually inverse because
Fr_J V=[5] too. Thus the desired condition is theta_B(2N)=0 on
V^(-1)(principal theta). Equation(3) supplies the second locus and(P)
with m=2 supplies the first by an eight-square determinant. Both use
the same actual N, not unrelated Jacobian data. Removing branch points
from P and accounting for Mumford boundaries are STILL required for a
complete intersection exclusion; no such exclusion is proved here.
