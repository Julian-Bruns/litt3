# Unimodular two-branch rings and the local-normality obstruction

Author: `/root`, 2026-09-06. Status: major independent audit PASS,
`/root/cored_ring_normality_major_check`, 2026-09-06. The nonbreaking
quotient-stack wording clarification is incorporated below.
[Audit record](../Research/audits/CORED_RING_AND_LOCAL_NORMALITY_MAJOR_AUDIT_2026_09_06.md).
Canonical statement: [unimodular_atlas_normality](../Theorems/Thm_unimodular_atlas_normality.md).

## 1. The entire abstract canonical ring has two generators

Put the wild branch at t=0 and the tame branch at infinity. The
[cored ring valuation calculation](Sol_cored_ring_and_marking_spectrum.md)
also applies to any given effective orbifold with a curve atlas. Its
weight-d monomial basis consists of t^(-a)(dt)^d with

    (m+1)d/m <= a <= delta d/E.

The two primitive lattice rays are (m,m+1) and (E,delta). They have
determinant

    m delta-(m+1)E = mc-E=1.

Thus they are an integral basis of Z^2. Every lattice point of their
closed positive cone is a nonnegative INTEGER linear combination of
the rays: its unique real cone coordinates are integers because the
basis is unimodular. Consequently the section ring is exactly k[U,V],
with coarse tensors

    U=(dt)^m/t^(m+1),        V=(dt)^E/t^delta.

This is a direct two-dimensional lattice calculation, not an inference
of stack existence from its section ring. The general literature and
its precise scope are recorded in
[the source screen](../Research/WILD_CANONICAL_RING_SOURCE_BOUNDARY_2026_09_06.md).

Pull back along an actual atlas C -> S. At a zero-fiber point, the
orders of U,V are -E(m+1)+m delta=1 and -E delta+E delta=0.
At an infinity-fiber point they are zero and
m(delta-2E)+E(m-1)=1. Off those fibers both are nonvanishing. Hence
their divisors are exactly the two reduced fibers, and are disjoint.

Since p|E, the connection satisfies

    nabla V=-delta (dt)^(E+1)/t^(delta+1)=-delta U^c.

Here mc=E+1 and (m+1)c=delta+1. Also
U^E/V^m=t because m delta-(m+1)E=1. This proves the forward identities.

## 2. Reconstructing the separable coarse map, without claiming an atlas

Suppose U,V have the stated simple disjoint divisors and connection
identity on C. The quotient pi=U^E/V^m is a rational function, since
its weight is zero. In a local differential frame, differentiation and
p|E give

    d pi = -m U^E V^(-m-1) nabla V
         = m delta U^(E+c)/V^(m+1)
         = U^delta/V^(m+1).

The last equality holds because m delta=1 in k. This is a nonzero
rational one-form, so pi is separating. Its divisor is E D_0-mD_infinity;
therefore its degree is E deg(D_0)=mE(2g-2).

At D_0 its ramification index is E and d pi has order delta. At
D_infinity its ramification index is m and d pi has order -(m+1).
Elsewhere both pi and its differential are nonzero and finite, so there
is no ramification. For an arbitrary finite separable local curve map,
the different exponent is the order of the derivative of a target
uniformizer. This gives delta over zero. Over infinity it gives
-(m+1)+2m=m-1, as required for tame ramification.

This calculation uses no normality of the completed field extension.
The next step is essential and must not be suppressed.

## 3. Precisely when the coarse map is an etale orbifold atlas

Let L/k(t) be the function-field extension just constructed and take its
global Galois closure N/k(t), with smooth projective curve W and group G.
Write H=Gal(N/L), so C=W/H. There is a representable finite etale map
[W/H] -> [W/G]. Its source is identified with the SCHEME C exactly
when H acts freely on W, equivalently when W -> C is etale. Before
this freeness is established we do not write a map C -> [W/G].

Fix a place b of k(t), choose a separable closure of its completion K,
and embed all completed extensions of L at places above b into it.
The corresponding completed extension of N is the compositum of all
these fields and their K-conjugates. This follows from generating N
by all global conjugates of L and then completing; the embeddings into
the local separable closure give exactly these completed conjugates.

If all the completed extensions over b are K-isomorphic Galois fields,
their embedded copies coincide: a normal extension has just one image
inside the fixed separable closure. Their compositum is that same field.
The completion of N/L is consequently trivial at every point over b.
Conversely, if W -> C is etale, its completed extension at every point
is trivial because the residue field is algebraically closed. Every
completion of L over K equals a completion of the Galois N/K. They are
thus Galois and mutually K-isomorphic.

Away from the two branch values all completions of L are trivial over
K. Over infinity, the tame totally ramified degree-m extension of k((1/t))
is unique up to base-field isomorphism and is cyclic: a unit has an mth
root and k contains all mth roots of unity. Thus the criterion reduces
exactly to mutual Galois isomorphism at zero.

If the criterion holds, W -> C is etale, H acts freely, and
C=[W/H] -> [W/G] is representable finite etale. Conversely an effective
orbifold atlas has a Galois closure in its finite-etale covering category,
whose coarse function field is this same normal closure N; its map to
C is etale. This proves necessity as well as sufficiency.

The statement allows the original atlas to be non-Galois. What it
requires is local normality and agreement at every branch, not global
normality of L/k(t), and not just common ramification numbers.

## 4. Characteristic-five test and the next unresolved task

For m=7,E=1000, c=143 and delta=1143, the connection coefficient
-delta is 2 in F5. The fixed genus-nine curve would have U with 112
simple zeros and V with 16000 simple zeros, and the exact coarse map
pi=U^1000/V^7. Its local-normality requirement remains unproved and
is not removed by this presentation.

The source ring is unusually simple, but it forgets the local Galois
action. In particular this reduction does not import a cyclic wild
root-stack construction for the prospective nonabelian inertia group
of order125. Any next obstruction must use the local normality/identical
extension condition or another actual-atlas consequence.
