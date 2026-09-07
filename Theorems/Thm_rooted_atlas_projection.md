# The atlas parameters embed in the second coordinate space

Use the actual compact atlas tensors and the rooted charts of
`rooted_atlas_charts`. In chart j write b_h=0 for h<j, b_j=1, and
let b denote the q=31-j remaining coordinates. Put

    H_j(b) v = d_j

for the 64 equations n(v,b)=0 followed by s_h(v,b)=0 (h<j)
and s_j(v,b)=1. Thus H_j has 32 columns and d_j is a constant
column. The analogous assertion holds in any dimension where the
swapped-pencil kernel is one-dimensional at every actual solution.

1. At every geometric atlas point, H_j(b) has column rank 32.
   Projection of the finite reduced chart to A^q_b is a closed
   immersion. In particular its elimination ideal in k[b] is radical,
   and v and the admissibility inverse are polynomial functions on its
   finite coordinate algebra. This is NOT a generic-rank assertion about
   H_j on the whole parameter space.

2. Let J in k[b] define a finite reduced algebra A, and suppose its
   equations are verified necessary consequences of the chart. Then
   the entire chart can be recovered by the following finite-algebra
   operations, without polynomial solving in the 32 v variables:

   - On each field factor of A, solve H_j(b)v=d_j by linear algebra.
     Discard an inconsistent factor or one with rank less than 32.
   - On a remaining factor evaluate b_h-s_h(v,b)^5 for h>j and
     c=v.s(v,b). Retain precisely the factors with all residuals zero
     and c nonzero, and put w=c^-1.

   The resulting graph is exactly the chart, including all geometric
   points over extensions of the coefficient field. Each such point
   still has three normalized lifts; no multiplicity or extension-field
   solution is lost. Factoring A is one implementation, not a hypothesis
   that its points are rational over the original field.

3. A verified pure-b polynomial consequence g^(5^e) may be replaced
   by g when testing geometric points. For the full reduced atlas
   ideal this is also ideal membership, not merely equality of zero
   sets. The fifth-root operation includes roots of coefficients.

This supplies an exact endpoint for linear-in-v elimination. It does
NOT prove that bounded-degree pure-b consequences define a finite
algebra, that the chart is empty, or that a selected maximal minor
stays nonzero. Those are computational tasks, not missing hypotheses
to suppress.

Status: author proof, 2026-09-07. No separate audit claimed.
[Proof](../Solutions/Sol_rooted_atlas_projection.md).
