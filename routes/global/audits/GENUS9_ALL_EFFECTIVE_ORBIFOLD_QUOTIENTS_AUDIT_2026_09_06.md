# Audit: all effective orbifold quotients of the fixed genus-nine curve

Date: 2026-09-06. Auditor: `/root/integral_jump_degree_bound_audit`.
Verdict: **PASS**, including the added coreless shared-one-form assertion.
No substantive objection or correction found.

Audited `Solutions/Sol_fixed_x_orbifold_bound.md`.
Checked the new self-fiber-product contact argument, uniform Cartier-zero
lemma, full signature split, and widened consequences. Retained inputs
were the checked contact/root extension, nonzero Cartier eigenform theorem,
two-primary W2 and two-branch calculation, cored refinement, bounded-atlas
finiteness, unique-clump classification, and simple-root/core theorem.
The relevant statements were read; their old large computations were not
rerun. No second-endpoint hypothesis was imported into the new bound.

## Full self-fiber product and contact count

Effectivity makes the generic stabilizer trivial, so the coarse map
`C->B` is finite separable of the same degree `n` as the atlas. The
scheme `C x_S C` is finite etale over `C` by both projections and hence
is a disjoint union of smooth projective curves. Its map to `C x_B C`
is finite: the isomorphism fibers are finite, and properness supplies
properness of the map. It is an isomorphism over the generic point of
`B`. Thus it is the normalization of the reduced coarse fiber product,
with distinct joint-image components. There is no multiplicity from
several copies of the same joint image.

For the whole reduced divisor `D`, including the diagonal and every
other component, normalized projection degrees total `n,n`. Writing
`s=g(C)-1`, etaleness gives `sum_i(g(D_i^nu)-1)=ns`. Adjunction with
the reducible normalization formula yields `delta(D)=D^2/2+ns`, and
Hodge index gives `D^2<=2n^2`. This does not require the normalization
to be connected or the maps to be Galois.

Both pulled-back differentials agree because they descend from the same
coarse rational differential. Above the `(2s)^2` ordered pairs of
simple zeros there are `2ns` normalized points in total. At each pair
the nonzero slopes have at most two values. Two different branches of
equal slope have contact at least `p-1`, since a first substitution
`t+c t^j` preserving a simple-zero form requires `j+1=0 mod p`.
For `r` branches the resulting lower bound is
`(p/4)r^2-((p-1)/2)r`. Summing and applying Cauchy--Schwarz gives
`delta(D)>=(p/4)n^2-(p-1)ns`. This count includes contacts between
different components. Comparison with the upper bound proves exactly
`n<=4p(g(C)-1)/(p-4)`. No division by the characteristic or by `n` is
used to descend forms or identify components.

## Uniform Cartier-zero forms

The block formulas imply that Cartier zero forces `M A=0` and `N B=0`.
The recorded invertibility of `N M^[5]` gives `rank M=3`, hence `A=0`,
also after extension to the algebraic closure. For nonzero `B` of degree
`b<=5`, infinity has positive order `16-3b`. Uniform multiplicity must
equal this order and divide 16, leaving only `(b,e)=(0,16),(4,4),(5,1)`.

An order-4 zero has a nonzero leading coefficient which survives Cartier,
so it cannot occur for a Cartier-zero form. A nonzero constant `B`
cannot lie in the kernel of `N`, since `N[0,0]=3a+4!=0`. Thus only
simple zeros remain. This proof neither assumes nor tries to prove that
all Cartier-zero forms have uniform zeros.

An independent short Sage matrix calculation confirmed
`rank M=3`, `det(N M^[5])=2a+3!=0`, and
`N*(1,0,0,0,0,0)=(3a+4,4a+2,0)`, with `a^2+4a+2=0`.

## Signature split and removal of Y

The positive-genus coarse cases give `n<=8` and `n<=32` as stated.
On coarse P1, two wild branch points would make the pullback of `dz/z`
regular and Cartier-fixed, with zero orders `delta-e>=5-2=3` at those
points. It is nonzero because the coarse map is separable. Additional
branch points introduce no poles. This contradicts the retained theorem
on all nonzero-eigenvalue forms on X, which has no hypothesis on Y.

With just one branch point, Hurwitz forces `delta>2e`. Pulling back
`dz` gives a nonzero exact regular differential with divisor
`(delta-2e)E`, with uniform positive multiplicity and no other support.
The new kernel lemma makes the zeros simple, and the whole-self-product
bound gives `n<=160`. The cases with extra tame points, including the
exceptional `(wild,2,2)` divisor obstruction, have exactly the numerical
bounds claimed. Equality `delta/e=2` is covered when another point exists
and is impossible when it is the sole point, so no boundary case is lost.

The remaining signature satisfies exactly the hypotheses of Sections 1--4
of the previously audited complete two-branch calculation: fixed X of
genus 9, one wild and one tame point, and `0<c<e`. After its preliminary
signature reduction, that proof uses only the atlas genus equation, local
ramification, and X's two-primary W2 obstruction. In particular it does
not use ordinary Y, Jacobian orthogonality, or vanishing shared forms.
It therefore supplies `n<=2240` or `n=112000,336000` in the present scope.

## Consequences, including the added assertion 3

The atlas bound `deg(X/S)<=336000` holds for every effective orbifold in
the statement. For any hyperbolic Y and jointly minimal cored span,
the retained refinement gives `M=[B:A intersect B]<=[<A,B>:A]`, hence
the same bound. Applying the retained bounded-atlas finiteness theorem
then gives finitely many isomorphism classes of cored partners in each
fixed genus. This uses an orbifold already furnished by the cored span.

For a coreless span, the degree-one intersection has dimension at most
one by the ratio-of-sections argument. If nonzero, its divisor has
uniform multiplicity by uniqueness of a clump. Cartier preserves this
line, so its generator descends to an eigenform on X with scalar possibly
zero. The new kernel lemma covers scalar zero; the retained eigenform
theorem covers nonzero scalar. Both force simple zeros on X, and equality
of pullbacks under etale maps forces simple zeros on Y as well. The
retained simple-root/core theorem then contradicts corelessness.
Assertion 3 is therefore valid without ordinarity of Y.

None of these conclusions excludes all coreless spans or asserts that
every span with arbitrary Y has zero shared one-forms. Higher-weight
invariants and the absence of any invariant remain outside assertion 3.
The author proof needed no mathematical edits; its header was linked to
this completed audit as requested.
