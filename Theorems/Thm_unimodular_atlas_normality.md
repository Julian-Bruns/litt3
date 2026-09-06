# A two-generator differential presentation and the exact local-normality gate

Let k be algebraically closed of characteristic p>0 and C a smooth
projective connected curve of genus g>=2. Choose integers E,m>=2 with
p|E, p not dividing m, and m|(E+1). Put c=(E+1)/m and delta=E+c.

A representable finite etale atlas C -> S to an effective orbifold with
coarse P^1, one wild branch of inertia E and different delta, and one
tame branch of order m gives regular tensors U,V of weights m,E such that

    div(U)=D_0, div(V)=D_infinity,
    D_0,D_infinity reduced and disjoint,
    nabla V=-delta U^c.

The connection is the canonical Frobenius connection on omega_C^E.
The coarse map is pi=U^E/V^m. Its degree is mE(2g-2), and the two
reduced fibers have respectively m(2g-2), E(2g-2) points. The canonical
ring of S is polynomial on U,V in weights m,E.

Conversely any such U,V define a separable map pi with ONLY two branch
values, ramification index E and different delta at every point over
zero, and tame index m at every point over infinity. This map is the
coarse map of a representable finite etale atlas to some effective
orbifold IF AND ONLY IF the completed extensions over zero are all
Galois and isomorphic over the SAME base field k((pi)). The tame
extensions over infinity are already mutually isomorphic Galois.

The quotient criterion is not implied by the indices, different,
connection identity, or polynomial section ring alone. It retains the
missing local Galois condition instead of declaring numerical matches
to be etale atlases.

For the prospective first large genus-nine signature, (p,m,E)=(5,7,1000),
one gets c=143, nabla V=2U^143, and deg(pi)=112000. This is an equivalence
of geometric conditions, not existence of U,V with the local-normality
property on the fixed curve. Verification: major audit PASS,
`/root/cored_ring_normality_major_check`, 2026-09-06; a nonbreaking
quotient-stack wording clarification was incorporated in the proof.

[Proof](../Solutions/Sol_unimodular_atlas_normality.md).
