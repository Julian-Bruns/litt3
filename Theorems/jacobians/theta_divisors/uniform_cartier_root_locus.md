# Uniform Cartier roots and their parameter spaces

Let C be a smooth genus-two curve over an algebraically closed field k
of characteristic5. Choose a Weierstrass point O, and write J1=Pic0(C^(1)), O1=F_C(O), V=F_C^*. A uniform
Cartier-zero tensor is a nonzero s in H0(C,omega^d), 5 not dividing d,
with div(s)=eD for a REDUCED divisor D of degree r, er=2d, and zero
eligible generalized Cartier image.

Necessarily r is1,2,or4 modulo5. Let a in{1,2,3} satisfy ar=2mod5,
and put j=(ar-2)/5. Consider

    T_r={(D,theta): D in Sym^r(C), V(theta)=[D-rO]}.

This is connected and projective, finite flat of degree25 over Sym^r(C).
If C is ordinary this map is etale. For r>=3, T_r is the smooth
projective bundle with fiber |rO+V(theta)| over J1.
Set M=O(jO1) tensor theta^a. Then

    omega_C tensor V(M)=O(aD).

Define Z_r by requiring that the SPECIFIED section with divisor aD
have zero twisted Cartier image in H0(C^(1),omega_(C^(1)) tensor M).
This is not merely the condition that some section be Cartier-zero.

A uniform Cartier-zero tensor with this D exists iff Z_r contains a
pair(D,theta) with theta of prime-to5 order. For a fixed D at most one
geometric lift has this property. Put h=gcd(r,2), d0=r/h, e0=2/h.
If n is the order of N=O(e0D)omega^(-d0)=V(theta)^e0, the minimal
tensor has weight d0 n and divisor e0 n D. Larger p-prime weights
give the same zero/nonzero test. Thus this removes the UNBOUNDED weight
from the geometric criterion for every prescribed reduced divisor.

For allowed r>=4, j>0 and Z_r is locally cut out by j+1 equations on
T_r. Every nonempty component meeting the reduced open locus therefore
has dimension at least r-j-1:

| r | a | j | lower dimension |
| --- | --- | --- | --- |
| 5k+1, k>=1 | 2 | 2k | 3k |
| 5k+2, k>=1 | 1 | k | 4k+1 |
| 5k+4, k>=0 | 3 | 3k+2 | 2k+1 |

The criterion removes the unbounded primitive weight for a prescribed
reduced divisor. It does not construct a shared tensor on an actual span.

Version4,2026-09-24.
[Proof](../../../Proofs/jacobians/theta_divisors/uniform_cartier_root_locus.md).
