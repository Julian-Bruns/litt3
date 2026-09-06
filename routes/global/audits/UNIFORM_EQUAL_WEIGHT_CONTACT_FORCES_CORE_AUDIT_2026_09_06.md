# Audit: a uniform zero multiplicity equal to the weight forces a core

Date: 2026-09-06. Auditor: `/root/contact_bound_to_core_audit`.
Verdict: **PASS** for the primary deduction, including its extension to
every characteristic p>=5 below. The optional Cartier-fixed
simple-form deduction also passes, with the wild-different inequality
corrected below. No subagents were used.

## Inputs read

- [Contact bound](../../../Solutions/Sol_contact_degree_bound.md).
- [Etale root bound](../../../Solutions/Sol_etale_root_contact_bound.md).
- [Positive correspondence category and corelessness](../CORELESSNESS_AS_TRANSCENDENCE_IN_THE_POSITIVE_CORRESPONDENCE_CATEGORY.md).
- [Generic graph and unbounded primitive images](../CORELESS_GENERIC_GRAPH_FORCES_UNBOUNDED_PRIMITIVE_CORRESPONDENCES.md).
- [Fixed genus-nine uniform eigenforms](../../../Solutions/Sol_fixed_x_cartier_eigenforms.md).
- [Invariant generator and Cartier](../../../Solutions/Sol_cartier_generator.md).
- [Cored span to common orbifold](../../../Solutions/Sol_cored_orbifold_bridge.md).

The first two bounds and the fixed-curve exact eigenform calculation were
treated as the audited inputs specified in the assignment. This audit
checks the new deduction and its hypotheses, rather than rerunning the
genus-nine Groebner calculation or revisiting archived audits.

## Primary statement

Over an algebraically closed field of characteristic five, let
`X <- Z -> Y` be an actual finite bi-etale span of smooth connected
projective curves of genus at least two. Suppose nonzero regular weight-d
tensors have equal actual differential pullbacks and divisors `d D_X`
and `d D_Y`, with reduced divisors and `5` not dividing `d`. Then the span
has a core.

1. **Initial minimalization is harmless.** The normalization `Z0` of
   the joint image has endpoint compositum as its function field.
   Both maps remain etale by the intermediate-cover property. The
   endpoint intersection is unchanged. Equality of endpoint tensors
   descends because pullback of rational tensors along the finite
   separable map `Z -> Z0` is injective.

2. **Equality propagates on every path.** Use two formally labelled
   endpoint roles, including when the curves coincide. Assign `s_X` to
   every X role and `s_Y` to every Y role. Each edge or reversed edge
   equates these sections by actual differential pullback. Pulling to
   an alternating fiber product gives equality across successive
   edges and hence between the outer endpoints. This holds on every
   connected component, with no trace, averaging, cancellation, or
   numerical-equivalence argument. The same sections are used at
   every appearance of each endpoint; no scaling choices accumulate.

3. **Every joint image keeps the witness.** Every path component is
   finite etale over both outer endpoints. Its joint-image normalization
   is an intermediate etale cover. Injective separable pullback again
   descends the equality. Thus EVERY generated X-to-Y joint-minimal
   image preserves precisely the original `s_X,s_Y`. Their weight d
   and endpoint zero divisors remain unchanged. One need not choose
   primitive generators of the newly generated images.

4. **The quantifier is sufficient.** If the seed were coreless, Theorem
   1 of the generic-graph note produces infinitely many distinct
   joint-minimal integral images in the fixed product `X times Y`.
   No assertion that these images are themselves coreless is used.
   For a fixed embedding of `k(X)`, one fixed image accounts for at
   most its degree over X many endpoint embeddings, so infinite
   graph vertices do not merely count different paths to one image.

5. **Degrees really are unbounded.** A fixed proper curve has finitely
   many connected etale covers of bounded degree: its geometric etale
   fundamental group is topologically finitely generated. For each
   source C, the bounded-degree morphism scheme to the fixed hyperbolic
   Y is of finite type; at a separable map its tangent space is
   `H^0(C,h^*T_Y)=0`. The separable locus is therefore zero dimensional
   and has finitely many geometric points. Hence bounded leg degree
   permits only finitely many such images. Etale Riemann--Hurwitz
   ties the two degrees together.

6. **The contradiction uses a fixed number.** The root bound applies
   to every image from point 4, independently of corelessness, and
   gives `deg(C/Y) <= 20 d (g(X)-1)` and the symmetric bound.
   Here d is the weight of the ORIGINAL witness, fixed once and for
   all. No weight-independent theorem is needed. This contradicts
   point 5 and proves the statement.

There is no dependence on ordinary genus two, finiteness of cored
images, or `Hom(JX,JY)=0`. The deduction does not extend the root bound
to other ratios of zero multiplicity to weight.

### Checked extension to every characteristic p>=5

For simple one-forms, the parameterized contact theorem has `n=2` and
`m=p-1`. Its inequality becomes

    ((p-4)/4) a b <= p t,

so the leg bound is `b <= (4p/(p-4))(g(X)-1)` and symmetrically for a.
For `p` not dividing d, the root torsors are still etale. Every step
of the compatible-components proof of the root theorem is independent
of the characteristic except its simple-form bound. Substituting the
new constant gives

    b <= (4p/(p-4)) lcm(hX,hY) (g(X)-1)
      <= (4p/(p-4)) d (g(X)-1).

The propagation and finiteness proof above now applies verbatim. Thus
the primary core theorem is valid for all p>=5 with p not dividing d.

## Fixed genus-nine/genus-twenty-five consequence

In the coreless primitive weight-one branch, the existing intersection
and clump results supply a uniform common one-form and its Cartier
eigen-equation. Ordinary Y forces nonzero eigenvalue. The audited
genus-nine theorem forces simple zeros. The primary statement therefore
excludes that entire branch; `M<=160` is superseded there by nonexistence.

Likewise, the branches `(d,e)=(2,2)` and `(4,4)` are excluded, upgrading
the former `M<=320` and `M<=640` statements in those specified coreless
branches. Nothing here excludes `(2,1)`, `(4,2)`, all positive-weight
intersections, or the branch with no positive common tensor.

## Optional cored Cartier-fixed simple-form statement

The following proof gives the stronger general statement: in
characteristic p>=5, a cored span preserving a nonzero Cartier-fixed
regular one-form all of whose zero orders are strictly less than p-2
has positive-genus coarse core. For p=5, zero orders at most two suffice.

Suppose the span has a core and preserves a nonzero regular one-form
with only simple zeros, Cartier-fixed on the endpoints. Then the coarse
core B has positive genus.

Use the simultaneous refinement W from the common-orbifold proof:
`W -> X,Y` are Galois etale, with groups A and H, and let
`G=<A,H>`. The common pulled-back form alpha is invariant under A and H,
hence under G. Since `k(W)/k(W)^G` is finite separable Galois, invariant
rational differentials descend: `alpha = pi^* beta` for a nonzero rational
one-form beta on `B=W/G`. Naturality of Cartier and injective pullback
give `C(beta)=beta`.

A Cartier-fixed rational differential has poles of order at most one.
This follows directly from the local Cartier series: a pole of order
m>1 maps to a pole of strictly smaller order (or is killed at its
leading term), contradicting fixedness.

If beta had a simple pole at b, then for w above b,

    ord_w(alpha) = -e_w + delta_w,

where delta_w is the different exponent. At an unramified or tame
point, `delta_w=e_w-1`, giving order -1, incompatible with regularity.
At a wild point, let I_1 be the first lower ramification group. Then

    delta_w >= (e_w-1) + (|I_1|-1),
    delta_w-e_w >= |I_1|-2 >= 3.

This contradicts the fact that alpha has only simple zeros, since W
is etale over the endpoints. Therefore beta is regular and nonzero,
so `g(B)>=1`.

In characteristic p, the last bound is `delta_w-e_w>=p-2`. Etale
pullback preserves all zero orders, proving the stronger statement
just given under the strict upper bound on those orders.

The proposed intermediate estimate `delta_w-e_w>=e_w-2` is not valid
for general inertia with a tame factor. The displayed estimate using
`|I_1|` is the correction and supplies exactly the needed contradiction.

Consequently `Hom(JX,JY)=0` excludes such cored spans as well: a
positive-genus common core gives a common nonzero Jacobian isogeny
factor. This includes all cored Cartier-fixed spans with zero orders
less than p-2. Combined with the primary theorem at d=1, this excludes every
span preserving an actual shared Cartier-fixed regular one-form with
only simple zeros under that Hom-vanishing assumption. It does not
assert that an arbitrary shared one-form is Cartier-fixed or has
simple zeros.
