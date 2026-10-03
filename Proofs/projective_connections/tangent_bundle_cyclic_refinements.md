# Proof: one tangent bundle, two different choices of cyclic cover

[Statement](../../Theorems/projective_connections/tangent_bundle_cyclic_refinements.md).
## 1. Dormant tangent bundle and its stability

Choose a spin line L²=ω_C and let W be the determinant-trivial dormant
oper descent. The [Bol complex](dormant_bol_complex.md), specialized
to p=5 and twist N=L, identifies

    V_r=W⊗L^(1)=ker(F_*[ω_C² --D²−r--> ω_C^4]).

Here the right-hand expression uses relative Frobenius; it is the
coefficient twist of the cited absolute-Frobenius formula. In particular
V_r is independent of the chosen spin structure, is stable, has
det V_r=ω_(C^(1)), and commutes with étale pullback. Wedge is its
perfect canonical-valued alternating pairing. Linearization of
r''−3r²=0 identifies H0(V_r) with the actual dormant tangent space.

The oper jet bundle J¹(L^−1), tensored by the horizontal line
F^*L^(1)=L^5, is J¹(ω_C²). Thus F^*V_r has the regular scalar
connection (v,v')'=(v',rv), with jet sequence

    0→ω_C³→J¹(ω_C²)→ω_C²→0.

This identification uses only the canonical connection on the
Frobenius-pulled line; it also holds when the jet extension splits.

## 2. The rank-four bundle, including a split root torsor

Use the actual canonical torsor pi:C_s→C from
[etale_double_dormant_pairs](etale_double_dormant_pairs.md).
Its tautological q changes sign under the involution tau. The connection
rho=pi^*r+q is dormant on all components, with tau^*rho=pi^*r−q.
Define E_r=pi^(1)_*V_rho. It is locally free of rank4. For connected C_s,
its genus is2g−1 and chi(V_rho)=0. For the split torsor, the two summands
each have Euler characteristic zero. Wedge upstairs followed by étale
trace gives E_r a perfect omega_(C^(1))-valued alternating pairing:
étale-locally the double splits, and this is the direct sum of the two
wedge forms. Thus det E_r=omega_(C^(1))², chi(E_r)=0 and
deg(E_r)=4(g−1). These pairings commute with actual étale pullback.

The previously proved tangent factorization identifies H^0(E_r) with
T_nil(C,r): on a connected double this is the invariant part of two
exchanged dormant tangent summands; on the split double it is their
direct sum. The identification is natural. In particular, retaining
the FULL double torsor, instead of selecting a component before base
change, proves h^(1)*E_r=E_(h^*r) even when the torsor splits upstairs.

For a cyclic prime-to5 cover, its character decomposition on C^(1)
and projection formula now give(1) for either bundle. Character lines
are defined on C^(1); transporting the cover back through relative
Frobenius yields an actual cover of C. No identification of a torsion
line with its fifth power is needed. Covers may equivalently be described
by either character convention, since inversion permutes the labels.

## 3. Theta divisors and good subgroups

For any positive-rank vector bundle B on a smooth curve with chi(B)=0,
let D_B={L in J:h^0(B tensor L)>0}. Either D_B=J, or D_B is the support
of an effective ample theta divisor numerically rank(B)Theta. Indeed,
acyclicity at one twist forces semistability (a destabilizing subbundle
has positive Euler characteristic at every twist). The determinant of
an equal-rank two-term cohomology complex defines the divisor.
[Raynaud, Section1.8 and Proposition1.8.1](https://www.numdam.org/article/BSMF_1982__110__103_0.pdf)
give its class in arbitrary characteristic. Proposition1.6.2 also gives a proper theta
divisor for every semistable rank2 bundle of Euler characteristic zero,
so it applies to EVERY V_r, even when h^0(V_r)>0. No assertion that every rank4 bundle has
a proper theta divisor is being used.

[Raynaud, Lemma4.3.5 (Serre)](https://www.numdam.org/article/BSMF_1982__110__103_0.pdf)
says that a divisor D on a Jacobian admits an order-ell subgroup meeting
D only possibly at0 when ell!=p and ell+1>D·C_Abel.

## 4. Good subgroups, with an explicit bound

Apply Section3 to the finite collection B_i of tangent bundles. Each
D_i is a proper effective theta divisor: automatically for dormant r,
and by the explicit hypothesis for active r. It may contain0.
The sum D=sum D_i has class RTheta, where R=sum rank(B_i).
An Abel curve has intersection g with Theta, so D·C_Abel=Rg.
For every prime satisfying(2), Serre's lemma gives an order-ell subgroup
Lambda whose NONZERO points avoid every D_i. Formula(1) then leaves
exactly the identity-character contribution h^0(B_i), preserving each
defect. If all h^0(B_i)=0 the entire subgroup, including0, avoids D.
If the family is empty the assertion is immediate from any nonzero
order-ell line. This proof imposes no condition on the Jacobian or on k
beyond the stated algebraic closure and characteristic.

## 5. One section-growth theorem gives all bad refinements

For k=bar(F_5), apply the
[simultaneous section-growth theorem](../jacobians/ordinary_covers/prime_avoiding_section_growth.md)
to the finite collection B_i on C^(1). Its generating-locus hypothesis
is precisely the general condition in Section3. If J(C) is simple,
every positive-dimensional component of a proper theta locus generates
it; if the bad locus is all J, use J itself. Section3 above supplies a
nonempty divisor whenever the bad locus is proper. Formula(1) identifies
the resulting section growth with the actual tangent growth. Relative
Frobenius transports the cyclic covers back to C, preserving their
degrees, nestedness and character decompositions. This proves(3).

For the two-leg assertion work instead on C_0=Z_0^(1), with every
actual pulled-back bundle h^(1)*B_r from BOTH endpoints. If A is the
endpoint abelian subvariety and T its generating bad locus, then
\[
A_0=h^{(1)*}A,\qquad T_0=h^{(1)*}T
\]
satisfy the same hypothesis on C_0. Indeed
Nm_h h^*=[deg h] makes h^* finite onto its image, even when5 divides
deg h. Thus T_0 is irreducible and positive-dimensional. If T_0 lay
in a translate of a proper abelian subvariety of A_0, its inverse
image would be a finite union of translates of a proper abelian
subvariety of A. Irreducibility would put T in one of them, contradicting
its generating property. Every nonzero twisted coefficient section
remains nonzero under the actual finite surjective pullback, so T_0
lies in the bad-character locus of h^(1)*B_r.

Apply the same finite-family theorem ONCE on C_0 to all these bundles.
Its identity-character summands retain the entire original section
spaces on Z_0, and each new character adds at least one dimension.
Tangent functoriality from Sections1/2 proves(6), including an active
canonical double that splits on Z_0 or later. Relative Frobenius gives
actual cyclic covers Z_j→Z_0; composition preserves both original
finite etale maps from this SAME source. No endpoint tower, compositum,
Galois closure or division by a leg degree is needed. The finite prime
set is arbitrary; joint minimality and corelessness need not persist.

## 6. Recovering the connection and its canonical double from the bundles

The stable bundles V_r,V_s have equal slopes, so a nonzero morphism is
an isomorphism. Pull it back by Frobenius. Cartier descent gives a
horizontal isomorphism between the two scalar connections on
J=J^1(omega²). The subbundle omega³ is the unique maximal-slope line
in J: its quotient omega² has strictly smaller degree. Thus the
isomorphism preserves this line. Its maps on the subbundle and quotient
are constant nonzero scalars d and a, respectively, since C is projective.

In the local jet coordinates (v,v'), its matrix is consequently
A=[[a,0],[b,d]]. Put M_r=[[0,1],[r,0]], and likewise for s.
Horizontality means

    A'=M_s A−A M_r=[[b,d−a],[s a−d r,−b]].

The upper row forces b=0 and d=a; the lower left entry then forces
s=r. Conversely scalar maps are horizontal. This proves(4), including
the dimension claim, without any assumption that the jet extension is
nonsplit. Apply it on the common source using etale functoriality to
obtain(5). Equality after a further cover descends because pullback of
the regular quadratic difference f^*r_X−g^*r_Y is injective.

Now suppose the canonical double pi:T→C of an active r is connected.
Its deck transformation exchanges the two distinct dormant connections
r_+=pi^*r+q and r_−=pi^*r−q. Formula(4) shows that V_+ and V_− are
nonisomorphic stable bundles of the same slope. Etale base change gives

    pi^(1)*E_r=V_+ direct-sum V_−.

In particular E_r is semistable: a destabilizing subbundle would pull
back to one of this semistable direct sum. If E_r were not stable, a
proper saturated subbundle of equal slope would pull back to an
equal-slope subbundle of V_+ direct-sum V_−. Such a subbundle is one
of the summands. Indeed, in the category of semistable bundles of this
slope the two summands are nonisomorphic simple objects, so the subobjects
of their direct sum are precisely the sums of subsets. One can also
prove this by projecting to each summand and using stability. But the
deck involution exchanges the two summands, whereas a pulled-back
subbundle is invariant. This contradiction proves stability of E_r.
For a split torsor the displayed decomposition occurs already on C,
and E_r is polystable but not stable. The same argument on any actual
etale cover proves the asserted splitting test, even if its degree is
divisible by5 or its map is not Galois.

Finally suppose E_r is isomorphic to E_s for two active connections.
Choose a connected component of the fiber product of their canonical
double torsors. It is finite etale and surjects onto C, and both torsors
split there. The isomorphism therefore identifies two unordered pairs
of distinct stable dormant bundles. Uniqueness of the stable summands
and(4) identify the unordered pairs of dormant connections themselves.
Taking the midpoint, which is defined since2 is invertible, gives the
equality of the pulled-back r and s. The quadratic difference descends
this equality to C. The converse follows from the definition of E.
Apply the same argument on Z to obtain the two-leg active criterion.
