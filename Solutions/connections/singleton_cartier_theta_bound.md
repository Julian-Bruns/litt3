# Proof: one fixed theta intersection replaces every torsion order

[Statement](../../Theorems/connections/singleton_cartier_theta_bound.md).
Author /root,2026-09-08. B_C is on C^(1), with conventions in
[theta_cartier](../../Definitions/Def_theta_cartier.md).

## 1. Connectedness and a point outside theta

Ordinarity makes V:J1->J an etale isogeny of degree p^2 and kernel
(Z/p)^2. Its pullback T->C along[2] times the Abel map is connected.
Here is the needed cohomological check, including the characteristic-p
part: the Abel map induces an isomorphism on H^1(O), compatible with
Frobenius. The Artin--Schreier sequence therefore gives an isomorphism
H^1_et(J,F_p)->H^1_et(C,F_p); surjectivity of x^p-x on k removes the
H^0 term. Multiplication by2 preserves this isomorphism. Thus no
nonzero character of ker V becomes trivial on C. The monodromy of
the pulled-back (Z/p)^2 torsor is the entire group. T is connected,
hence irreducible, smooth and proper. Etale Hurwitz gives genus p^2+1.

For an ordinary curve H^0(B_C)=0. Thus (O,0) does not belong to the
inverse image of Theta_B. Since T is irreducible, the theta section
does not vanish identically on it. Its restriction defines an effective
divisor, not a whole component.

The primary input is
[Raynaud, Sections1.8 and4.1](https://www.numdam.org/article/BSMF_1982__110__103_0.pdf):
Theta_B is the determinant divisor with the stated support and class
(p-1)Theta1. For ordinary C, existence already follows from vanishing
at0 and the equal-rank cohomology determinant. No claim about theta's
irreducibility, generic smoothness, or the geometry of a bad coset is used.

## 2. Exact degree and the forced contribution

Write Theta,Theta1 for the two principal polarization classes. The
polarized Frobenius/Verschiebung identities give V^*Theta=p Theta1.
Also the Abel curve has degree2 against Theta, so

    deg i^*Theta=4*2=8,
    p deg b^*Theta1=deg a^*i^*Theta=p^2*8.

Therefore deg b^*Theta_B=8p(p-1).

Every Weierstrass point P satisfies2P~2O. For nonzero M in ker V,
tensor the defining Frobenius sequence by M. Projection formula gives

    0->M->F_*(F^*M)->B_C tensor M->0.

Here F^*M=O_C, while H^0(M)=0 and H^0(O_C)=k. Thus
H^0(B_C tensor M) contains a nonzero section, and(P,M) is in the
effective theta pullback. There are six distinct such fibers and p^2-1
nonzero points in each. Each contributes at least one, with no
transversality assumption. Subtract them once to obtain R. Its degree is

    8p(p-1)-6(p^2-1)=2(p-1)(p-3).

The subtraction may leave residual multiplicity at a forced point.
In particular the argument has not proved sixteen distinct new points
when p=5. The p=3 bound is zero, consistent with the local impossibility
of a Cartier-zero one-form having zero order2mod3.

## 3. Exact correspondence with the root condition

For a tensor in(1), L=O(2P)omega_C^(-1)=i(P) has order dividing n.
The normalized nth-root cover is the associated prime-to-p Kummer
torsor (or a disjoint union of its connected components). The
tautological one-form has character L and divisor the pullback of2P.

There is a unique prime-to-p torsion M in J1 with F^*M=L: V is an
isomorphism on prime-to-p torsion, with inverse given using the other
Frobenius and inversion of multiplication by p on that torsion. On the
corresponding actual etale torsor, projection formula and the exact
Cartier sequence identify the character Cartier kernel with

    H^0(C^(1),B_C tensor M).

Equivalently this is the kernel of the twisted Cartier map on
H^0(C,omega_C tensor F^*M). The Frobenius twist and character are
transported together, not identified with their pth powers by convention.
Hence(1) implies(2).

Conversely, for a non-Weierstrass P, omega_C tensor F^*M=O(2P) has
exactly ONE independent section. Indeed the genus-two degree-two pencil
is the hyperelliptic pencil, and2P is not a fiber unless P is Weierstrass.
Its nonzero section has zero divisor exactly2P. Any nonzero section of
B_C tensor M maps injectively to that one-dimensional twisted canonical
space, so its generator is Cartier-zero on the actual torsor. If n is
the order of M, its nth power descends to the required s. This proves
the converse, retaining the actual etale root cover.

If P is Weierstrass, L=O. Its unique prime-to-p lift M under V is0,
which is outside Theta_B. Thus no Weierstrass point meets the root
condition, even though its OTHER, p-torsion lifts account for the forced
theta points. Dropping the prime-to-p requirement here would be wrong.

## 4. Application and scope

For an actual coreless span, the primitive canonical generator has
p-prime weight in characteristic5 by cartier_generator. If its clump
image on C_alpha is a single point P, the degree identity gives
div(s_C)=2dP. In the Cartier-zero branch, the canonical root construction
has Cartier-zero tautological form; this follows from the generalized
Cartier product rule, as in the retained Kummer normal-form proof.
The preceding equivalence applies with n=d. It produces at most16
points without restricting the prime factors or size of either leg degree.

The involution(P,M)->(iota P,-M) preserves T and its theta divisor:
iota acts by-1 on J, and Theta_B is symmetric since B_C is self-dual
for Serre duality. Away from Weierstrass points it has no fixed point.
Thus there are at most8 abscissas. Over F125 all constructions and the
forced divisor descend; a residual closed-point orbit has degree at
most the residual scheme length16. This does not imply a common
degree16 coefficient field. Distinct orbit lengths need not divide16.

This is a FINITE necessary endpoint test, not an exclusion. A surviving
prime-to5 point supplies genuine one-endpoint root data and shows why
such a test cannot alone settle that point. It never supplies the other
endpoint or the two maps from one source.
