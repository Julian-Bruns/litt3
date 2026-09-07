# Proof: cofinal saturation of inherited Raynaud theta directions

[Statement and audit metadata](../Theorems/Thm_raynaud_cofinal_saturation.md).
This is a consequence of Raynaud's theorem, not a new literature result.

## 1. One no-theta representation saturates every old direction

Raynaud's Theorem2 supplies a connected étale G-torsor q:W→C,
where G is solvable of order prime to p, depending only on p and g(C),
and a representation ρ through G having no theta divisor.
Proposition1(5) identifies this with the required Jacobian containment.

Explicitly, k[G] is semisimple. Some simple constituent S of ρ has

    H⁰(C^(1), B_C⊗E_S⊗L)≠0 for EVERY L∈J(C^(1))(k).         (1)

Otherwise the intersection of the finitely many generic-vanishing
opens for the constituents would make ρ good. For the selected S,
generic nonvanishing extends to all L by semicontinuity.
The regular representation contains S; projection formula and the
canonical étale identity B_W=q^(1)*B_C give the theorem's nonvanishing.
The fixed group G gives its degree bound.

## 2. Cofinality retains both actual maps

A connected finite étale refinement T→W injects global sections
under pullback, so nonvanishing persists. Given any connected
V→C, a component of V×_C W is finite étale and surjective over both
factors, giving a refinement of V with this property. Alternatively,
apply Section1 to V, saturating even all directions in J(V^(1));
that last map can be chosen prime-to-p solvable Galois.
The total cover of C in a prescribed refinement need not be prime to p.

For the actual span X←f—C—g→Y, every
f^(1)*L⊗g^(1)*M lies in J(C^(1)). Apply the preceding cofinality.
The composite maps from the SAME new source remain finite étale;
no one-leg Jacobian substitute is used.

The refinement factors through C, so it need not be jointly minimal
as a two-endpoint presentation. This does not refute generic vanishing
on jointly minimal spans or on enlarged parameter spaces upstairs:
Θ_W remains proper in the FULL J(W^(1)). It does disprove cofinal
generic vanishing on the fixed inherited endpoint directions.
The [cyclic-tower boundary](../routes/global/CYCLIC_TOWER_NEW_ORDINARITY_AND_FIXED_SUPPORT_BOUNDARY.md)
retains the distinct almost-everywhere tower statement and unbounded-defect examples.

## Primary source and exact scope

[Raynaud, Revêtements des courbes en caractéristique p>0 et ordinarité](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/16AB72912D3CE32BFC5D012B1025A8E4/S0010437X00000440a.pdf/revetements-des-courbes-en-caracteristique-pandgt0-et-ordinarite.pdf),
Compositio123(2000),73–88: Theorem2(ii),p.76 and Proposition1(5),p.75.
Theorem17 and Corollary18,p.85 construct the bad representation from
a divided polarization and a line in B_C. The proof on pp.85–86 first
uses a prime-to-p cyclic cover, then induces the representation.
Remark20(1),p.86 explicitly gives the bad regular representation.
The assertion is for EVERY genus≥2 curve, not only a generic curve.
