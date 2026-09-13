# Partial Frobenius rooting and exhaustive quotient charts

Version2, 2026-09-13. A single feedback lemma now gives both rooted
atlas presentations. The bilinear quotient statement holds for every
odd characteristic and every positive power of Frobenius.

## Feedback lemma

Let k be perfect of characteristic p, q=p^a with a>=1, and let A(x,y),
B(x,y) be polynomial tuples, with B having as many components as y.
Write P^[-q] for coefficientwise qth roots of a polynomial tuple. If

    X: A(x,y^[q])=0,  y=B(x,y^[q])

is finite étale over k, then

    Y: A^[-q](v,b)=0,  b=B^[-q](v,b)^[q]

is finite étale and (v,b)->(v^[q],b) is an isomorphism Y->X. Moreover
Y is exactly the reduction of the raw substitution x=v^[q] in X.
The empty scheme is allowed. This does not justify rooting equations
of an arbitrary presentation without the displayed feedback form.

## Bilinear incidence and its charts

Assume p odd, lambda∈k^*, and let N,R be bilinear coordinate tensors
with U,b each having m coordinates. Suppose

    X: N(U,b^[q])=0,  R(U,b^[q])=b,  U.b=lambda

is finite étale. Put n=N^[-q], s=R^[-q], c=v.s(v,b), and
ell=lambda^(1/q). Then

    Xr: n(v,b)=0,  b=s(v,b)^[q],  c=ell

is isomorphic to X by U=v^[q], with b unchanged. For j=0,...,m−1 let

    Cj: n=0; b_h=s_h=0 (h<j); b_j=s_j=1;
        b_h=s_h^q (h>j); w*c=1.

These finite étale charts are the exhaustive disjoint strata of
Xr/mu_(q−2). Every geometric chart point has exactly q−2 normalized
lifts, a finite étale mu_(q−2)-torsor; these need not all be rational
over the coefficient field. A quotient chart imposes c!=0, not c=ell.
Earlier b coordinates and b_j may be substituted out, but their rooted
s equations must remain. No projective direction is omitted.

For q=p=5 and lambda=2 this recovers the full compact atlas presentation:
32 disjoint charts for every fixed genus-nine tensor, three normalized
lifts each. The actual genus-two positive example has11 directions and33
normalized lifts. These count presentations, not necessarily distinct
unmarked atlases. The theorem excludes no whole genus-nine oper or
common cover.

[Proof](../../Proofs/atlases/rooted_atlas_charts.md).
Independent bounded [audit](../../Research/audits/FROBENIUS_FEEDBACK_ROOTING_AUDIT_2026_09_13.md):
PASS, /root/audit_cyclic_unification, 2026-09-13, no blocking objections.
The original positive-test and tensor-export evidence remains unchanged.
