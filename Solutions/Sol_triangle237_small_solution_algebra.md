# Proof: at most two actual normalized solutions after fixing the oper

Author /root,2026-09-11. Independent bounded audit PASS by
/root/audit_degree84_field_bound, including the recovery of omitted opens.
This result uses the existing census, not a new enumeration.

## 1. The retained pole guards recover every passport open

Write T=u^5. The existing cofactor theorem supplies horizontal solutions
H0,H1 of degree at most4 with gcd1 and Wronskian a nonzero constant times
F. Let D_i(T) be the u^4 coordinate of H_i*C^4 modulo u^5-T. At every
simple root r of C,

    D_i(r^5)=H_i(r)*C'(r)^4.

Thus C divides H0*D1(u^5)-H1*D0(u^5); call the quotient Astar.
Differentiating its numerator, the D_i(u^5) terms have derivative zero.
The Wronskian identity consequently gives

    Astar(r)=±c*F(r)*C'(r)^3 != 0.

The rank-five kernel argument of the cofactor theorem applies here using
only squarefreeness of C. Both A and Astar lie in that kernel: their
u^4-coordinate over k(T) vanishes, and their products with C are horizontal.
For Astar the u^4-coordinate cancels by its definition. Hence

    A/Astar belongs to k(u^5).

No primitivity of A or polynomiality of this ratio is assumed. At a root
r of C, Astar is a unit, so ord_r(A) is a nonnegative multiple of five.

Suppose A also vanished at r. Since C is simple and F,s are units there,
the passport sFA²-B³=C⁷ forces

    2*ord_r(A)=3*ord_r(B)<7.

Neither an even integer nor a multiple of three can equal7; if both were
greater than7 the equality would also be impossible. The only positive
possibility below7 is ord_r(A)=3,ord_r(B)=2, contradicting the multiple of
five. Therefore gcd(A,C)=1; the passport then gives gcd(B,C)=1.

Now q=sFA²/C⁷ has degree42, with no cancellation. Its displayed derivative
is nonzero, so q is separable. Its zero fiber has at most24distinct points
(the six roots of the binary F and18roots of A), its one fiber at most14,
and its pole fiber exactly6. Their contributions to ramification are at
least18,28,36. Their sum is82=2*42-2.

Riemann--Hurwitz forces equality everywhere, also excluding excess wild
different. Thus A,B are squarefree, A is disjoint from F, and every other
passport disjointness and tameness condition holds. Composing q with the
backup's hyperelliptic map gives the actual complete profile(2,3,7).
The horizontal equation fixes its dormant potential: the same nonzero
horizontal polynomial solves the pullback scalar equation and the one
for the specified P, so those potentials coincide.

These statements hold at every geometric point of the guarded
finite-type coefficient scheme. The omitted discriminants/resultants
are therefore units in its coordinate ring (a finite-type algebra over
a field is Jacobson). Thus this scheme equals the complete passport open,
not merely its reduction.

## 2. Fifteen equally sized fibers inside the42-class census

The backup has three geometrically distinct Frobenius conjugates. On
each, the five dormant opers form one Frobenius125 cycle; source
automorphisms fix them. Coefficient Frobenius permutes the fifteen
source/oper pairs transitively. Every pair therefore has the same number
N of actual normalized covers.

There is no multiplicity from identifying covers with rational functions:
Aut(C_alpha) is exactly the hyperelliptic involution group, and these
maps factor through its quotient. Thus it acts trivially on u and on q.
Each cover class gives a unique q in the fixed coordinate and unique
monic A,C, leading-minus-one B and scale s.

All fifteen fibers inject disjointly into the42 surviving hyperelliptic
classes in the existing complete census. Consequently15N<=42, so N<=2.
Frobenius_(5^15) fixes the source and chosen potential and permutes at most
two q-functions. Its square fixes each. Hence their coefficients, and
those of the uniquely normalized A,B,C,s, lie in F_(5^30).

## 3. The coefficient scheme has no infinitesimal thickness

Take an infinitesimal solution over k[epsilon]/epsilon². It supplies a
variation of the actual f:C_alpha->P1, with fixed branch values and
tame ramification orders. Locally at a point of index e, its variation
vanishes to order at least e-1. Therefore

    delta f belongs to H0(C_alpha,f*TP1(-Ram(f)))
             = H0(C_alpha,TC_alpha) = 0.

This is the usual differential identification for a separable tame map;
the local condition includes movement of each ramification point.
Thus delta q=0. The identity

    delta q/q=delta s/s+2delta A/A-7delta C/C

and the now established disjointness force delta A=delta C=0 by their
degree bounds and monic normalization, then delta s=0. The passport gives
delta B=0 because3 is invertible. Every inverse-guard variable is unique
and has zero variation as well.

Every geometric tangent space is zero. Together with the finite point
bound, this proves that the scheme is finite and geometrically reduced,
hence finite étale over K of rank at most two. Its four possible algebras
are the ones in the statement. A rank-two algebra is generated by any
nonconstant coordinate; all other coordinates are affine-linear in it,
and that coordinate satisfies a quadratic. This also gives the claimed
degree bound for a reduced degree-compatible Gröbner basis.

None of this bounds the size of a derivation of that basis from the
original generators. In particular the unsaturated C(0)-only necessary
system, bounded multiplier spans and timed-out computations retain their
previous unresolved status.
