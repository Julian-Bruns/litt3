# The opposite endpoint bounds a prime-to-five defect image by short Frobenius strings

Version1,2026-09-10. Focused medium audit PASS,
/root/audit_frobenius_character_order. New argument combines both
actual etale maps; no source-degree bound or full lift is assumed.

Let X←f−Z−g→Y be actual finite etale maps of smooth projective connected
hyperbolic curves over k=bar(F5). Suppose:

- g is Galois of degree prime to5, and 5 does not divide deg f;
- admissible active nilpotent connections match on Z;
- r_Y is ordinary, the source defect is TWO, and r_X is nonordinary.

Let Gamma be the FAITHFUL image of the actual Y-deck group on the
two-dimensional defect space, and put d=3g(X)-3. Every element of
Gamma has order at most2 or an order dividing

                  5^ell-1 or 5^ell+1,  1<=ell<=d.

In particular |Gamma|<=max(48,4(5^d+1)). The kernel of the defect
action, and therefore deg(Z/Y), is not asserted to be bounded.

The reason is two-leg: normalized f-trace preserves a nonzero short
nilpotent Psi string from H1(X,T_X). On the actual cyclic deck
subgroups of g, the negative cohomology is a multiple of the regular
representation. Serre--Cartier duality and a character-graded string
give precisely the displayed congruence. Dimension2 alone does not
bound these character orders.

## Consequence for the unchanged main pair

For main genus-nine X and genus-two Y_t, the prime-to5 condition on f
follows from deg g=8 deg f. The actual intermediate

    T=Z/ker(Gal(Z/Y_t)→Gamma)

has genus at most4(5^24+1)+1<2^59. A nonzero X defect quadratic
descends to T, so phi_X²/s_X supplies an ACTUAL core for X←Z→T.
The atlas degree of X to its common orbifold is at most64. This does
not infer that the original X,Y_t span is cored.

The established bounded-atlas count, applied with B=64 and these
bounded-genus T, followed by bounded automorphism-quotient counts,
gives fewer than2^(2^800) possible genus-two curves Y. This is LESS
than the existing selection bound K. Frobenius avoidance therefore
excludes the ENTIRE stated prime-to5-Galois-Y/source-defect2/
nonordinary-X branch for the SAME main pair.

Combined with [the orbit bound](Thm_two_leg_defect_orbit_bound.md),
any remaining Galois-Y, source-defect2 match with nonordinary X must
have a NONTRIVIAL cyclic five-part acting TRIVIALLY on the defects.
Its prime-to5 projective image must still be a large cyclic or
dihedral group of order at least5250. No bound for that residual
case is proved: deg f is divisible by5 and normalized trace fails.

Ordinary-X, higher-defect, non-Galois, dormant and absent-connection
branches remain. The full common-cover problem is UNSOLVED.

[Proof](../Solutions/Sol_frobenius_defect_order_bound.md) ·
[Focused audit](../Research/audits/FROBENIUS_DEFECT_ORDER_AUDIT_2026_09_10.md).
