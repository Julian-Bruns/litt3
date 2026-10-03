# Proof: the exact fourth-root Cartier gate and its finite family transfer

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_degree_forty_wild_spin_carrier_exclusion.md). Nonsquare-branch implication passed [independent whole review](../../Research/audits/CANONICAL_DEGREE_FORTY_WILD_NONSQUARE_AUDIT_2026_10_03.md). No census, Bol determinant, or ordinarity calculation is repeated. Both original endpoint maps remain onT.

## The actual profile forces an exact-order-four norm

Use the accepted [actual two-point quotient Picard presentation](../quotient_geometry/local_actions/two_point_wild_orbifold_picard_group.md). Write the reduced branch divisors Dw,Dt and the coarse lineU. The genuine relations and canonical line are
\[
20D_w=8D_t=U,\qquad K=3D_w-D_t.
\]
The arbitrary invariant generators of weights SEVEN, EIGHT and TWENTY have zero divisorsDw+Dt,4Dw,4Dt. Normalize their actual Y functions H,F,G so that
\[
H^4=FG,\qquad\beta=G^2/F^5=H^8/F^7.
\]
Here β is the actual coarse coordinate, wild pole and tame zero. The distinguished wild position has uniform index TWO throughout its spin-map fiber and is excluded by the accepted actual mixed-fiber theorem. Thus the distinguished stabilizer is ONE or EIGHT. At two distinct wild points R1,R2, disjoint fromP, one has
\[
\operatorname{div}F=4R_1+4R_2-8P.
\]
The pole triples(H,F,G) atP are(7,8,20) and(5,8,12), respectively.

If F were a square inY, β would be a square. The actual subfield Γ(√β)⊂T is connected of degree TWO overΓ, since ΓY=T and Γ∩Y=B for the faithful action. The pulled β has valuations−20 and+8 onΓ, so this quadratic cover is étale. Its inertia orders become10 and4, and its wild different becomes23−20+10=13. All original sections, the primitive coefficient and genuinely canonical line remain. This gives a real structural reduction, but the earlier asserted exclusion of that smaller profile depends on a faulty finite-origin substitution in the degree-ten proof. It is therefore NOT used as an exclusion here.

Assume F is nonsquare, as required in this scoped theorem. The divisor above shows that the ACTUAL cover Y' with u⁴=F is étale and connected of degree FOUR. Indeed its associated divisor class [R1+R2−2P] has exact order FOUR: order dividing TWO would make F a square over the algebraically closed constant field. Its ordinarity follows from accepted maximal exponent-four ordinarity, although the argument below does not infer an obstruction merely from ordinarity.

Set v=H/u. Then v⁴=G andβ=v⁸/u²⁰. In characteristic five,
\[
d\beta=3v^7\,dv/u^{20}.
\]
At each of the eight points ofY' over R1,R2, u has order ONE, v is a unit, and ord(dβ)=23−40=−17, so dv has order THREE. At the four points aboveP, the ordinary and distinguished-tame towers give dv pole FOUR in both cases. It is a unit elsewhere: the unramified tame points contribute order SEVEN to dβ and v has simple zeros there. With divσP=2P this proves
\[
dv=c u^3\sigma_P,\qquad c\ne0.
\]
Cartier exactness, u³=(u³)⁵/F³, and F^-3=F^-5F² imply
\[
C(F^2\sigma_P)=0.
\]
This is the new gate, rather than the previously accepted C(FσP) gate. The differential here is meromorphic; no regular-ordinarity shortcut is used.

## The exact saved norm dictionary and the fresh calculation

For BACKUP choose the exact field
\[
\mathbb F_{5^6}=\mathbb F_5[\rho]/(\rho^6+\rho^4+4\rho^3+\rho^2+2),
\quad\alpha=1+4\rho+2\rho^2+\rho^3,
\quad\alpha^3+\alpha+1=0.
\]
Let Φ=u(u−1)(u−2)(u−3)(u−α). The previously completed and verified finite four-torsion algebra supplies15 nonzero two-torsion representatives E, the products of ONE or TWO finite branch factors, and16 exact halves each. Its saved four parameters c0,c1,q0,q1 satisfy
\[
C^2E-\Phi/E=Q^2,\quad C=c_0+c_1u,
\quad Q=q_0+q_1u+q_2u^2,
\]
where q2=2 fordegE1 and q2=c1 fordegE2. Their actual norms are
\[
F=A+By,\quad A=C^2E+\Phi/E,\quad B=2C,
\quad A^2-B^2\Phi=Q^4.
\]
These are all240 exact-order-four classes, not a newly enumerated subset. The original saved certificate and independent no-solver verification are retained at [four-torsion data](../../../litt3-computation-data/legacy_workspace_computations/backup_genus_two_four_torsion.json) and [verification](../../../litt3-computation-data/backup-cored-audit-20260911/four_torsion_verify.json). Their norm identity is the elementary square of(CE+y)/√E; its zeros have multiplicity FOUR at the chosen degree-two half-divisor. The Bol coefficients in that old record are unused.

For a finite Weierstrass origin w, put z=1/(u−w), y'=y z³. Replacing F by z⁴F changes its divisor from4D−8O to4D−8w. Its polynomial form is
\[
\Phi_w(z)=z^6\Phi(w+1/z),\quad
A_w=z^4A(w+1/z),\quad B_w=zB(w+1/z),
\quad\sigma_w=dz/y'.
\]
At infinity use the original polynomials. Translation by2(w−O) permutes the exact-four-torsion classes, so all240 saved norms at every origin give complete coverage there.

For any such polynomial model, expand F²=R+Sy with R=A²+B²Φ and S=2AB. Since1/y=Φ²/y⁵, the vanishing test is EXACTLY
\[
C(F^2\,dz/y)=0
\iff [z^{5i+4}](R\Phi^2)=0\text{ and }[z^{5i+4}]S=0\text{ for every }i\ge0.
\]
The two summands lie respectively in the y^-1 and constant sectors, so they cannot cancel. In these models the even indices are4,9,14 and the odd index is4. The source [fresh gate script](../../scripts/genus_two/oct03_n40_four_torsion_cartier_gate.sage) reads the saved norm parameters and evaluates only these new coefficients. The [new certificate](../../../litt3-computation-data/oct03_n40_four_torsion_cartier_gate.json) stores every coefficient, the source hash, exact field, origin and class indices. All1440 rows have a nonzero coefficient; there are ZERO survivors.

Execution used SageMath10.9, with OMP, OpenBLAS and MKL threads allONE, and completed in under ONE second. An initial JSON serialization failure was repaired with integer encoding; the successful run used the identical mathematical inputs. There was no numerical replay of old determinants or ordinarity.

## Closedness of the intrinsic gate

Over the smooth parameter line S=SpecF5[t,1/(t(t−1)(t−2)(t−3))], the exact-four-torsion scheme is finite étale. For each of the SIX Weierstrass sections P and each exact-four-torsion class τ, the degree-two class τ+2P has a unique effective divisor D. This follows from the genus-two Abel map Sym²Y→Pic²Y: its sole exceptional fiber is the canonical class, whereas τ+2P differs from it by the nonzero order-four class τ. Thus D varies properly, including repeated divisors or divisors meetingP.

The norm divisor4D−8P is principal. Its norm determines a line of nonzero sections ofO(8P), varying regularly in the corresponding projective bundle. The unique differential line with divisor2P varies regularly too. Squaring the norm and applying relative Cartier gives a homogeneous coefficient map into a fixed-pole vector bundle. Its zero locus is therefore closed on the finite torsion scheme. Properness shows that its parameter image is closed. The empty BACKUP fiber proved above rules out any dominant component. Hence its parameter support is finite.

This argument does not discard boundary classes by an affine coprimality condition. In particular a putative dominant polynomial component cannot escape the BACKUP specialization through a degenerate norm presentation.

## An explicit finite support bound

For the two selected endpoints, the accepted small-Abel-torsion exclusions imply that the effective D is reduced and disjoint from all Weierstrass points. Indeed D=2R would give8(R−P)=0, and D=R+W would give4(R−W)=0; any non-Weierstrass R contradicts the accepted non-Weierstrass eight-torsion exclusion. A divisor consisting of Weierstrass points has order at most TWO. Thus its norm presentation lies in the usual open locus Q of degree TWO, squarefree and coprime toΦ.

Every such exact half has the displayed norm form. One can see completeness without an elimination program: write its norm as A4+B1y and its hyperelliptic norm as a scalar Q⁴. After rescaling, factor
\[
(A-Q^2)(A+Q^2)=B^2\Phi.
\]
The disjoint squarefree branch factors allocate a nonzero two-torsion subset E of size ONE or TWO after taking the complementary subset when necessary. The linear B permits only one nonconstant square factor, giving C of degree at most ONE and C²E−Φ/E=Q². The alternatives with the empty branch subset are squares and have order at most TWO. This gives the15 branches of the saved halving presentation.

For each of15 subsets and SIX choices of origin, take variables(t,c0,c1,q0,q1), the FOUR halving equations and the Cartier coefficient equations above. All are polynomial after the stated coordinate change. The halving equations have total degree at most THREE. The Cartier equations have total degree at most26: E andΦ/E have parameter degree at mostONE; A has total degree at mostTHREE before changing origin. For w=t, multiplication byz⁴ and substitutionw+1/z raise this bound toSEVEN, while Φw has parameter degree at mostSIX and Bw total degree at mostTWO. Therefore (A²+B²Φ)Φ² has total degree at most26; the odd sector has smaller degree. Fixed origins and infinity satisfy the same upper bound.

Affine Bézout bounds the number of irreducible components of each such variety in five variables by26⁵. A component meeting the actual norm open locus cannot dominate the t-line by the preceding proper specialization argument. Its parameter is therefore constant. Taking all90 systems bounds the bad selected-parameter support by
\[
90\cdot26^5.
\]
The equations and all branch choices are F5-stable. The selected MAIN parameter has prime degree larger than this bound, so cannot lie in this support. Its norm gate is impossible, just as for BACKUP. Combined with the forced Cartier identity, the nonsquare-F branch of canonical profile(40,20,8,23) is excluded on BOTH endpoints with both original maps unchanged.

## Retained dependency failure and a genuine square-gate survivor

At the moving origin P=t set s=1+t and z=1/(u−t). The transformed quintic is
\[
\Phi_P=z-sz^2+s^2z^3-s^3z^4+(s^4-1)z^5,
\qquad\Phi_P'=(1+sz)^3.
\]
The degree-ten proof's substitution of its triple-root criterion incorrectly replaced f3³=f2² by f3³=f2²f1. Thus the asserted finite-origin contradiction is false atP=t; the square branch cannot be discarded through that dependency. In fact for s≠0, F=(z+1/s)⁴ satisfies C(F²σP)=0, since ΦP'σP is exact and F² differs from a fifth-power multiplier times(z+1/s)³. This is a genuine surviving NECESSARY square-class gate, not an actual common-cover construction.
