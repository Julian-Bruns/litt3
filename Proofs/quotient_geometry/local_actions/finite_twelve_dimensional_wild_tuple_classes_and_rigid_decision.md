# Proof: the rigid twelve-dimensional multiplicative reflection dichotomy

Version1, 3 October2026. See the
[statement](../../../Theorems/quotient_geometry/local_actions/finite_twelve_dimensional_wild_tuple_classes_and_rigid_decision.md).
The frozen [six-row source table](../../../Research/notes/oct03_ten_hour/eight_module_twelve_source_scott_euler_and_rigid_sectors.md)
has [fresh independent PASS](../../../Research/notes/oct03_ten_hour/eight_module_twelve_source_scott_euler_and_rigid_sectors_audit.md).
The frozen [reflection decision](../../../Research/notes/oct03_ten_hour/eight_module_twelve_rigid_multiplicative_reflection_decision.md)
has separate independent
[exclusion PASS](../../../Research/notes/oct03_ten_hour/eight_module_twelve_rigid_multiplicative_reflection_exclusion_audit.md)
and [existence PASS](../../../Research/notes/oct03_ten_hour/eight_module_twelve_rigid_multiplicative_reflection_existence_audit.md).
Their original pinned inputs are unchanged. The existence audit
clarifies that all FOUR roots \(\lambda^4=-1\) work, as stated here.
Canonical extraction fidelity is pending.

## Scott and the exact candidate partitions

The tame centralizer dimension is \(7^2+5^2=74\). Scott's inequality
on \(\operatorname{End}(k^{12})\), with its two one-dimensional
irreducible intertwiner spaces, gives
\[
2c_A+74\le12^2+2=146,\qquad c_A\le36.
\tag{1}
\]
The wild partition has block lengths at most FIVE. Its centralizer
dimension is the sum of squares of the column lengths. At least
THREE blocks are necessary, and FIVE or more blocks give centralizer
at least THIRTY-EIGHT. For a given block count the
remaining nonincreasing FOUR column lengths sum to \(12-b\).
If \(b\ge5\), their balanced minimum is at least
\(25+2^2+2^2+2^2+1^2=38\); for larger \(b\) the bound increases.
If \(b\le2\), five columns sum to at most TEN.

For THREE blocks, the allowed column vectors are
\((3,3,3,3)\), \((3,3,3,2,1)\), \((3,3,2,2,2)\).
For FOUR blocks, they are
\((4,3,3,1,1)\), \((4,3,2,2,1)\), \((4,2,2,2,2)\).
These yield exactly the SIX preliminary rows
\(4^3,5+4+3,5+5+2,5+3+3+1,5+4+2+1,5+5+1^2\).
The independent table audit verifies this finite hand list; no
enumeration was run. Section below excludes \(4^3\), leaving FIVE.

For an irreducible triple the product-map differential has cokernel
the scalar common centralizer. Since \(5\nmid12\), the scalar line
is complementary to trace-zero matrices. The fixed-class product
fiber modulo simultaneous conjugacy is smooth of dimension
\[
12^2+2-(2c_A+74),
\]
giving the displayed \(12,8,8,4,0\) indices. The zero index alone
does not prove existence.

## General-field reflection input and the exact-class dictionary

Use the arbitrary-field equivalence, Theorem1.7, and simple dimension
inequality, Lemma5.1, of
[Crawley--Boevey--Shaw](https://arxiv.org/pdf/math/0404186).
At a loopless vertex with parameter \(q_v\ne1\), reflection is a
category equivalence preserving simples, with
\[
x'_v=\sum_{w\sim v}x_w-x_v,\qquad
q'_v=q_v^{-1},\qquad q'_w=q_wq_v\ (w\sim v).
\tag{2}
\]
Other entries stay fixed. At \(q_v=1\), a simple of vector
\(x\ne\epsilon_v\) must have \(2x_v\le\sum_{w\sim v}x_w\).
These inputs are proved before the paper's characteristic-zero
section; neither its characteristic-zero generic criterion nor a
class-closure sufficiency result is used.

For each matrix choose spectral list \(1,\ldots,1\) on its
unipotent arm, and \(\lambda,-\lambda\) on the tame arm. Successive
images of \(\prod_{\ell=1}^j(D_i-\xi_{i\ell}I)\) give a strict
flag with dimensions the successive ranks. Inclusions \(\psi_{ij}\)
and restrictions \(\phi_{ij}=D_i-\xi_{ij}I\) satisfy
\[
D_i=\xi_{i1}I+\psi_{i1}\phi_{i1},\qquad
\phi_{ij}\psi_{ij}-\psi_{i,j+1}\phi_{i,j+1}
=(\xi_{i,j+1}-\xi_{ij})I.
\]
Scaling inclusions by \(\xi_{ij}^{-1}\) gives the multiplicative
relations with \(q_o=\lambda^{-1}\), \(q_c=-1\), and all other
parameters ONE. The center relation is exactly \(ABC=I\).
An irreducible matrix tuple gives a simple flag representation by
propagation of a subrepresentation's invariant central space.

Conversely, a simple module of positive central dimension is strict:
propagating an arm-inclusion kernel vector outward yields a nonzero
subrepresentation with central space ZERO; applying the dual argument
gives surjective reverse maps. On each unipotent arm, the nilpotent
powers factor through chains of these inclusions and surjections,
so their ranks are EXACTLY the prescribed arm dimensions. On the tame
arm the distinct degree-two spectral polynomial and its exact rank
give the prescribed multiplicities. A common invariant matrix space
propagates to a subrepresentation, giving matrix irreducibility.
This direct dictionary is valid in characteristic FIVE. It is the
elementary exact-class part of Lemma8.3, not the later characteristic-zero
existence theorem.

Put \(q_v=\lambda^{r_v}\), with \(r_v\) read modulo EIGHT.
Initially \(r_o=7,r_c=4\), all other entries ZERO. Reflection sends
\(r_v\) to \(-r_v\), and adds its old value to each neighbor.

## Sixteen reflections exclude three four-blocks

The star graph has arms of lengths THREE, THREE and ONE. In the
order \(o;a_1,a_2,a_3;b_1,b_2,b_3;c\), its initial vector is
\[
(12;9,6,3;9,6,3;5).
\]
Reflect successively at
\[
o,a_1,b_1,o,a_2,b_2,a_1,b_1,o,a_3,b_3,a_2,b_2,a_1,b_1,o.
\tag{3}
\]
Every current reflected exponent is SEVEN; every positive Cartan
pairing is ONE. The independently hand-checked full SIXTEEN-row
certificate is in the frozen exclusion audit. The terminal vectors are
\[
x=(8;6,4,2;6,4,2;5),\qquad
r=(1;0,0,0;0,0,0;0).
\]
Here the tame leaf has parameter ONE, dimension FIVE and adjacent
dimension EIGHT. A simple there would require \(10\le8\), impossible.
Equivalently the leaf relation gives a zero composite
\(k^5\hookrightarrow k^8\twoheadrightarrow k^5\), whose injectivity
and surjectivity force that same dimension inequality. Since every
earlier reflection was an equivalence, no original irreducible
\(4+4+4\) tuple exists.

## Thirty-six reflections construct the surviving rigid row

Use arms of lengths FOUR, FOUR and ONE, with initial vector
\[
(12;8,5,2,1;8,5,2,1;5).
\]
The following exact chain is grouped only to make its certificate
readable. Entries in each row are in matching order.

| Steps | Vertices | Current parameter exponents | Positive Cartan pairings |
|---|---|---|---|
|1--4|\(o,a_1,b_1,o\)|\(7,7,7,7\)|\(3,2,2,1\)|
|5--9|\(a_2,b_2,a_1,b_1,o\)|\(7,7,7,7,7\)|\(2,2,1,1,1\)|
|10--14|\(c,o,a_1,b_1,o\)|\(1,2,2,2,2\)|\(3,2,2,2,2\)|
|15--18|\(a_2,b_2,a_1,b_1\)|\(2,2,2,2\)|\(1,1,1,1\)|
|19--22|\(a_3,b_3,a_2,b_2\)|\(1,1,1,1\)|\(1,1,1,1\)|
|23--26|\(a_4,b_4,a_3,b_3\)|\(1,1,1,1\)|\(1,1,1,1\)|
|27--31|\(c,o,a_1,b_1,o\)|\(3,5,4,4,3\)|\(1,1,1,1,1\)|
|32--36|\(a_2,b_2,a_1,b_1,c\)|\(4,4,3,3,5\)|\(1,1,1,1,1\)|

All dimensions stay nonnegative, and the final vector is \(\epsilon_o\).
The final complete exponent vector is
\[
(0;5,7,3,0;5,7,3,0;3),
\]
so the central parameter is ONE. The existence audit contains the
independently hand-checked full THIRTY-SIX-row certificate and all
full-dimension checkpoints.

Start with the vertex simple at that terminal parameter vector.
All reflected parameters were nontrivial, so reverse the equivalences.
This gives a simple module of the INITIAL vector. The direct strict
dictionary produces an irreducible exact-class triple, with
\(A,B\) of wild partition \(5+3+3+1\) and \(C\) of tame multiplicities
SEVEN and FIVE. All parameters and the initial vertex simple are
defined over \(\mathbf F_{25}\). The explicit reflection functors
use linear kernels/idempotents and invertible scalar parameters,
and commute with scalar extension. Reversing over that field thus
gives a geometrically simple module, and hence a geometrically
irreducible matrix triple over \(\mathbf F_{25}\).

The FIVE block makes the nilpotent fourth power nonzero, while its
fifth power is zero. Therefore \(A,B\) have exact order FIVE.
Their determinants are ONE; the tame determinant is
\(\lambda^{12}(-1)^5=1\). Thus all three matrices lie in \(SL_{12}\).
All FOUR choices of primitive eighth root have identical exponent
calculations, and so all work.

## Rigidity and the original-source specialization

In the surviving rigid row,
\(c_A+c_B+c_C=36+36+74=146=12^2+2\).
For any two irreducible triples in these exact classes, apply Scott
to their inter-tuple Hom module. The opposite invariant Hom dimensions
sum to at least TWO. A nonzero intertwiner between irreducible
modules is an isomorphism, giving simultaneous conjugacy. This
physical-rigidity argument is valid in characteristic FIVE and does
not identify the generated group.

If the IRREDUCIBLE ORIGINAL larger-source hypotheses are also supplied, use the
[native budget](../../cartier_and_spin/canonical_ten_larger_source_native_sections_and_relation_budget.md).
For \(n=12\), \(m=3\), its formula becomes
\(\chi=(15-j)/2-b_4-2b_5\), with \(h\le b_3+b_4+b_5\).
Substitution in the FIVE rows gives exactly the statement's table
and its two exact \(h\)-values. Euler zero does not imply vanishing
of sections. The two sign labels refer to the GENUINE paired original
tame action; changing a projective eigenvalue label does not change
an actual Euler calculation.

The abstract existence proof has supplied no same-generated-group
inverse conjugacy, exact original multiplier, full generated image,
primitive geometry, paired line or characteristic-five curve.
No original endpoint map is transferred. Both original étale legs
remain on SAME original source whenever the source corollary is used.
