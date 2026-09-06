# Cored canonical ring and exact local-normality gate: major audit

Verdict: PASS within the stated hypotheses. No breaking objection found.

Auditor: `/root/cored_ring_normality_major_check` (fresh bounded agent).
Date: 2026-09-06.

Scope: the complete statements and proofs of
[cored_ring_and_marking_spectrum](../../Theorems/Thm_cored_ring_and_marking_spectrum.md)
and [unimodular_atlas_normality](../../Theorems/Thm_unimodular_atlas_normality.md).
This is an independent prose audit, not formal verification. The retained
cored-orbifold bridge is an input; its simultaneous etale refinement and
generated-group construction were inspected, but its cited external core
theorem was not independently re-proved. No prior audit bodies were read.
The optional stratified-contact proof is outside this verdict.

## Principal checks

1. On the same simultaneous etale refinement W, the endpoint spaces are
   respectively A- and B-invariants. Their intersection is exactly the
   invariants of G=<A,B> in every weight, including in characteristic
   dividing the group orders. This uses descent, not exactness of taking
   invariants. The rational differential valuation is
   e ord(beta)+d delta, which gives precisely the displayed floor formula
   and respects multiplication. The proof has not silently replaced the
   actual two-leg condition with a one-leg condition.

2. An equal reduced pullback divisor on W has its natural G-equivariant
   ideal, so it descends to a reduced effective Cartier divisor on [W/G].
   Conversely every such divisor gives compatible endpoint divisors.
   A branch residual gerbe has degree 1/e; reduction prevents repeating
   it. Thus the subset formula, unrestricted number of ordinary points,
   and minimum nonzero marking degree are exact. No Picard torsion
   hypothesis is needed for this divisor statement.

3. For the unimodular signature the rays (m,m+1), (E,delta) have
   determinant 1. Their cone is the entire regular-monomial region.
   Consequently the asserted polynomial canonical ring follows, with
   generators of weights m and E. The pulled-back valuations are exactly
   (1,0) at the zero fiber and (0,1) at the infinity fiber.

4. The canonical Frobenius connection exists on omega^E since p divides
   E. From mc=E+1 one obtains m delta=1 in k, and the connection identity
   yields d pi=U^delta/V^(m+1), a nonzero rational one-form. The divisor
   of pi is E D_0-m D_infinity. At zero the derivative order is delta;
   at infinity differentiating 1/pi gives order m-1. Elsewhere the
   derivative is a unit. Thus the converse establishes exactly the
   stated separable two-branch coarse map and local different data.

5. The local-normality condition is both necessary and sufficient; it
   is not merely a necessary numerical test. For the global normal
   closure N of L/k(t), its completion at a fixed base place is generated
   by all completed conjugates of L. If the completions of L are mutually
   base-field-isomorphic and Galois, every image in a fixed separable
   closure is the same field, so that compositum adds nothing. Conversely
   if N/L is etale, all its completed extensions over L are trivial:
   the residue field is algebraically closed. Every completed L field
   is then a completed N field, hence Galois and mutually isomorphic
   over the base completion. Over infinity the tame degree-m extension
   is unique and cyclic; off the branch locus the extensions are trivial.

6. With H=Gal(N/L), the resulting W -> C is etale exactly when H acts
   freely. In that case C=[W/H] -> [W/G] is a representable finite etale
   atlas with the prescribed coarse map. For necessity from an existing
   effective orbifold atlas, take its Galois closure in the finite-etale
   covering category. It is a scheme since it covers C etale, and its
   generic field is the ordinary field-theoretic normal closure: the
   generic stabilizer of the effective orbifold is trivial. This justifies
   the converse use of a Galois closure without assuming an etale global
   normal closure before the local criterion is proved.

## Exact arithmetic

An independent integer enumeration of the displayed dimensions through
weights 7000 and 21000, together with rational degree calculations, gave:

| (m,E,delta) | canonical degree | first nonzero weight | first dimension >=2 | smallest endpoint marking |
| --- | --- | --- | --- | --- |
| (7,1000,1143) | 1/7000 | 7 | 7000 | 112 |
| (21,3000,3143) | 1/21000 | 21 | 21000 | 112 |

The proof's inequalities give these minima without a search cutoff.
Both minima 112 exceed the genus-nine canonical size 16. For the first
signature c=143, -delta=2 in characteristic five, and the coarse degree
is 112000, as stated.

## Nonbreaking clarification and scope boundary

The phrase “C -> [W/G] is etale ... exactly when H acts freely” should be
read as saying that the quotient map [W/H] -> [W/G] comes from the scheme
C=W/H exactly when H is free. Before freeness is known, a canonical map
from the coarse scheme C to that stack has not been constructed. The
later argument already uses the correct interpretation, so this wording
does not invalidate the theorem.

Neither section ring nor differential identity proves local normality.
The two large signatures and the required tensors with mutually
isomorphic Galois completions remain prospective. The audit proves no
existence of an atlas, no exclusion of these signatures, and no solution
of the unmarked common-cover problem.
