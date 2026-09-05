# Focused audit: coreless Jacobian-orthogonal correspondence in characteristic five

**Verdict:** PASS — no breaking objection found in the combined proof.

**Date:** 2026-09-05.

**Auditor:** `/root/canonical_trace_algebra`.

**Scope and independence:** independent check of the arithmetic subgroup,
commensuration, composition/corelessness, and whole-diagram reduction arguments
in [the theorem](../CORELESS_HOM_ZERO_CORRESPONDENCE_IN_CHARACTERISTIC_FIVE.md).
The auditor authored the linked ordinary-partition computation. Its rerun and
formula review below are explicitly a **self-check**, not an independent audit
of that computational input. This is a bounded mathematical audit, not a
machine-checked formal proof or a literature-novelty certification.

The reviewed theorem's SHA256, before any later metadata-only edits, is
`dfbfd6033deae68dc5f10979674038b77a0eccbc1694a716e62ea9cdf3d0e105`.

## 1. Arithmetic identification and the actual genus-three curve

The arithmetic statements used are present in Girondo--Torres-Teigell--Wolfart,
*Shimura curves with many uniform dessins*, §§4 and 6, preprint pp. 11--12,
20--21: the maximal-order realization of the (2,3,7) group, absence of finite
quaternion ramification, the unipotent inverse-image realization of (7,7,7),
and the index-two inclusion in (2,7,14). Their prime-two example also gives
residue field F8. I checked the actual passages, including the explicit
upper-unipotent matrices, not merely the commensurability-class diagram.
[Author-uploaded primary text](https://www.researchgate.net/publication/225821698_Shimura_curves_with_many_uniform_dessins),
[published DOI](https://doi.org/10.1007/s00209-011-0889-4).

Independently, the map t^7 from y^2=t^7-1 has cyclic deck group C7 x C2,
branch indices 7, 2, 14, and degree 14. The abelianization of
Delta(2,7,14) is C14: eliminate the third generator to obtain C2 x C7.
Thus its deck kernel really is the commutator subgroup Gamma. The unique
index-two subgroup is Pi, and Gamma is normal of index seven in Pi.
This identifies the correct surface group; it does not substitute the Klein
quartic surface group, nor assume Gamma is congruence.

## 2. Strong approximation and both prime-to-five normal cores

Voight's Main Theorem 28.5.3 applies with S the archimedean places, since the
quaternion algebra is split at one real place. It gives density of rational
norm-one elements in the finite norm-one adeles.
[Primary theorem](https://link.springer.com/chapter/10.1007/978-3-030-56694-4_28).
The stated conditions constitute one nonempty restricted-product open set:
maximal-order units away from 2 and 7, the identity congruence neighborhood at
7, and a small determinant-one neighborhood of diag(2,1/2) at 2. There is no
need to prescribe an additional real neighborhood or invoke strong
approximation for the adjoint group.

At 2, the trace can have valuation -1. A determinant-one element with negative
trace valuation acts hyperbolically on the Bruhat--Tits tree; in particular
no nonzero power lies in a bounded subgroup.

Let O_2 be the local maximal order. For any fixed n, a sufficiently deep
principal congruence subgroup in SL2(O_2) lies in g^n SL2(O_2) g^-n.
Away from 2, g normalizes all conditions defining Pi, including the
unipotent condition at 7 because g reduces to the identity there. The global
principal 2^a subgroup is therefore contained in Pi intersect Pi_n and is
normal in Pi. Working in norm-one preimages before quotienting by signs,
its finite quotient embeds in SL2(O_2/2^a), whose order is

    8(8^2-1) 8^(3(a-1)) = 504 * 8^(3(a-1)).

Passing to a projective quotient can only decrease this order. Repeating in
Pi_n gives the other side. No factor five occurs.

The finite-group lemma in §4 is correct: R0 is normal in Gamma, S is normal
in R0 because Gamma' is normal in Pi', and R0/S embeds in Pi'/Gamma'.
The finitely many Gamma-conjugates of S are still normal in R0; their
intersection K is normal in Gamma, and R0/K embeds in the corresponding
product. Every index is prime to five. Symmetry supplies the second leg.
Thus these are **prime-to-five geometric Galois closures**, not merely
prime-to-five covering degrees.

## 3. High powers and every component of the specified composition

The finite-discrete-overgroup argument is valid. For Gamma_X of genus five,
the universal orientation-preserving orbifold area bound gives
[Lambda:Gamma_X] <= 84(5-1)=336. For each such index, the normal core has
bounded index in Gamma_X. There are finitely many possible cores, and the
normalizer of each is a finite extension of that core, leaving only finitely
many discrete overgroups Lambda.

The real normalizer of Gamma is a finite extension of Gamma and belongs to
its arithmetic commensurator. In the projective two-adic group it is bounded:
Gamma is integral there, and only finitely many cosets are added. Hence
Gamma_n=Gamma_m would force the loxodromic element g^(n-m) into a bounded
subgroup. The conjugates Gamma_n are therefore pairwise distinct.

If Gamma_n lies in a fixed Lambda, its index is fixed by covolume. A finitely
generated Lambda has finitely many subgroups of that index. Consequently
only finitely many n produce a discrete group generated by Gamma_X and
Gamma_n.

For the composition with W, the correct component indexing is by double
cosets

    Gamma_W \ Gamma / (Gamma intersect Gamma_n).

Representatives can always be selected from the fixed finite left-coset set
Gamma_W\Gamma (four elements here). The component group is precisely
Gamma_W intersect gamma_i Gamma_n gamma_i^-1. Its endpoint groups, expressed
on this common universal cover, are Gamma_X and
gamma_i Gamma_n gamma_i^-1. For every fixed representative the latter groups
are pairwise distinct. A finite union of exceptional n therefore works for
all components at once. The text's use of a fixed sufficient representative
set, rather than an equality with all left cosets, is appropriate.

A nonconstant common function would give an invariant meromorphic function
on the upper half-plane. Invariance under a nondiscrete group is impossible:
choose a regular point where the function has nonzero derivative; local
injectivity and a sequence of transformations approaching the identity force
those transformations to be the identity. Thus the asserted field
intersection is constant. This does not claim corelessness for all
components of unrestricted iterated Hecke correspondences.

## 4. The complete diagram at the prime five

The initial multiquadratic diagram has good reduction: its disjoint branch
sections have inertia of order two. At infinity only F3 has odd degree.
Neither the even-sign subgroup nor the all-sign involution intersects any
nontrivial inertia subgroup. The two quotient maps therefore stay étale,
with the stated genera and the same labeled targets after reduction.

For a chosen component Z0 of W x_Y V_n:

- Z0 -> W is a base change of the first leg of V_n; composing with the
  degree-two Galois W -> X gives a prime-to-five Galois closure over X.
- Z0 -> V_n is a component of a base change of the degree-four Galois
  W -> Y; composing with the second leg of V_n gives a prime-to-five Galois
  closure over Y.

Closure under such towers follows by taking conjugate Galois closures;
the resulting groups embed in wreath-product extensions of groups whose
orders are prime to five. Neither side is being inferred from the other.

Over a henselian DVR with good target model, prime-to-five specialization
identifies the geometric prime-to-five cover categories. A specialized cover
lifts to the whole proper model by the henselian finite-étale equivalence.
After a finite extension of the DVR, the generic identification and all
finite data descend. This proves the extension assertion used in the text.
[Stacks 58.30.3](https://stacks.math.columbia.edu/tag/0BUQ),
[Stacks 58.9.1](https://stacks.math.columbia.edu/tag/0A48).

Crucially, extend **both specified legs**, then identify their smooth proper
source models using the specified generic-fiber identity. Smooth genus-at-least-two
models are stable, so this identity extends uniquely.
[Stacks 109.24.2](https://stacks.math.columbia.edu/tag/0E97).
This preserves the actual pair of maps, not just an abstract source curve.
Geometric connectedness of the generic source persists in the proper smooth
family. Krishnamoorthy Lemma 4.10 now applies with all its hypotheses:
proper smooth geometrically integral families, finite étale arrows, and
hyperbolic source. It rules out a special-fiber core.
[Primary paper, p. 1188](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf).

Finally, the normalization in the compositum of the two endpoint fields is
an intermediate cover of either finite étale leg, hence itself étale over
both targets. It makes the joint map primitive without assuming primitivity
survives reduction.

## 5. Newton polygons and computational self-check

The Hermitian argument checks directly: in characteristic five,
t=-(U/W)^18 and y=(V/W)^63 satisfy y^2=t^7-1. The map is nonconstant and
extends between the smooth projective curves. The maximal Hermitian curve
over F_(125^2) has every Frobenius eigenvalue -125, and its Jacobian has
J(Y) as a quotient up to isogeny. Therefore Y is supersingular. Ordinary
and supersingular slopes are disjoint, so Hom(J(X),J(Y))=0.

I read and reran the entire scalar certificate with Sage 10.9:

    sage -python routes/global/SEVENTH_ROOT_BRANCH_PARTITIONS_ORDINARY_PAIR_FACTORS_CERTIFICATE.py

It exited successfully, reproducing all 210 passing partitions and the
three selected determinants. In the basis 1,zeta,...,zeta^5 their coefficient
vectors are respectively

    (4,1,2,2,1,4), (4,1,0,0,1,4), (4,4,0,3,4,3).

Phi7 is irreducible modulo five, so each displayed nonzero vector is a
nonzero field element. The formula uses the coefficients of f^2 at
5i-j; the actual Cartier matrix is obtained by coefficientwise fifth roots,
which preserves determinant nonvanishing. Infinity is omitted from the
branch polynomial and lowers its degree to 2g+1. Only scalar 1x1/2x2
determinants are used: no optimized extension-field matrix backend.

The certificate SHA256 is
`2efc2ebf9dbf0c305c3d0a93f3d91642f05805afe2ac0a33f2198cbbdd423922`.
As declared above, this computation remains an author self-check.

## Nonbreaking suggestions and exact verdict boundary

1. Add the two Stacks links 0A48 and 0E97 to §6 to make the
   cover-extension and same-source identification steps easier to check.
2. In §3, explicitly say that the SL2 congruence calculation is performed
   on norm-one preimages and then passed to projective groups.
3. In §6, optionally qualify Galois closures as geometric and mention
   henselizing/completing the chosen DVR before finite descent. This avoids
   confusing an uncontrolled arithmetic constant-field group with the
   prime-to-five geometric group actually used.

These are clarifications, not missing mathematical hypotheses. The audited
argument establishes the stated auxiliary existence theorem. It supplies no
result for the fixed pair 76, no simultaneous finite Galois envelope, no
positive deformation tangent, and no literature-novelty claim. No theorem
text or existing certificate was edited in this audit.
