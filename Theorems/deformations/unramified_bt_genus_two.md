# Unramified rank-two coefficients force a common lift

Version5,3 October2026. Later binary height transfer makes every active
component an oper and extends the former ordinary and smallest-gap
profiles to all compatible unramified coefficients.

Let k be algebraically closed of characteristic p>2, and let
\(K/\mathbf Q_p\) be unramified of degree f, with integers
\(\mathcal O_K\). A rank-two \(\mathcal O_K\)-BT group is a full
p-divisible group of rational coefficient rank two and underlying
height2f.

Suppose C has genus two and such a group has nonconstant Newton
polygon, with generic slopes \((0,r/f)\), \(1\le r\le f\).
Its isogeny class contains a coefficient-linear model whose r active
Hodge eigenspaces are ALL lines of degree one with Kodaira--Spencer
isomorphisms. The active indices may change during the isogenies.
Every active crystalline component is an integral rank-two oper;
a component need not be Frobenius-stable.

Consequently, if an ACTUAL finite bi-étale span \(X\leftarrow Z\to Y\),
\(g(Y)=2\), carries rationally compatible rank-two K-isocrystals and
the one on Y has such a BT realization, the ORIGINAL span lifts
simultaneously over W(k). Compatibility on a connected finite étale
refinement also suffices. The given Y-oper lattice descends through
the other actual map by [oper rigidity](crystalline_oper_lifting.md).

## Common arithmetic local systems

Suppose the actual span is defined over a finite field and its endpoints
carry absolutely irreducible rank-two
\(\overline{\mathbf Q}_\ell\)-local systems, \(\ell\ne p\), with
trivial determinant, infinite image and isomorphic ARITHMETIC
pullbacks. Let E contain their Frobenius traces. If a completion
\(E_v/\mathbf Q_p\) is unramified and its crystalline companion is
not everywhere isoclinic, the original geometric span lifts over W(k).
Neither slope gap one nor an initial integral lattice is required.

It suffices that E be unramified at every place above p: infinite
image supplies a nonisoclinic companion somewhere. The
[ramified extension](ramified_rapoport_oper.md) covers every coefficient
place for the general lifting consequence. The completed selected-pair
application is in [the common coefficient theorem](../shared_tensors/common_companion_jump.md).
These criteria require a supplied common coefficient.

## Every coreless compatible coefficient has a reciprocal gap

Under the actual-span hypotheses above, suppose also that the rational
source comparison respects EVERY Frobenius arrow and the span is coreless.
Then
\[
r\mid f,\qquad a=f/r,\qquad
\delta=1/a,\qquad |S_Y|=p^a-1.
\tag{1}
\]
Here delta=r/f is the generic slope gap, and S is the unique clump.
Every exceptional Newton slope of the
normalized BT realization is \(1/(2a)\). All active oper reductions
are dormant if a>1 and have nonzero nilpotent p-curvature if a=1.
In the latter case every exceptional fiber is superspecial.

If the rational determinant is geometrically constant on BOTH
endpoints, as supplied by the arithmetic normalization, put
\[
\tau_C=\mathcal O_C(S_C)\otimes\omega_C^{-(p^a-1)/2},
\qquad C=X,Y.
\tag{2}
\]
These are two-torsion lines, satisfy \(\tau_C^r=\mathcal O_C\),
and have matching pullbacks on the actual source. If d is the primitive
common canonical weight and e its zero multiplicity, their profile is
\[
(d,e)=((p^a-1)/2,1)
 \quad\text{if }\tau_X=\tau_Y=\mathcal O;
\qquad (d,e)=(p^a-1,2)\quad\text{otherwise}.
\tag{3}
\]
In particular odd r forces the first profile. At r=1 this recovers the
smallest-gap profile; at r=f the clump has p-1 points. The cardinality,
exceptional slopes and curvature assertions require no determinant
triviality.

## The ordinary group has an intrinsic unique model

For a generically ordinary group G on a smooth proper curve, with at
least one nonordinary fiber, all f Hodge eigenlines have positive
degree. Intrinsic Frobenius untwisting gives nonzero Kodaira--Spencer.
In genus two its terminal model G0 has ALL Hodge degrees one and
ALL partial Kodaira--Spencer maps isomorphisms. Thus
\[
G\cong F_C^{b*}G_0,\qquad \deg L_i=p^b\quad\text{for every }i.
\tag{4}
\]
Every partial Hasse divisor of G0 is reduced of degree p-1.

Two generically ordinary rank-two \(\mathcal O_K\)-BT groups with
nonzero Kodaira--Spencer in the same coefficient-linear isogeny class
are isomorphic. The isomorphism identifies their FULL Dieudonné
crystals, including every Frobenius arrow and the integer action.
No abelian-scheme realization or polarization is assumed.

[Proof](../../Proofs/deformations/unramified_bt_genus_two.md).
