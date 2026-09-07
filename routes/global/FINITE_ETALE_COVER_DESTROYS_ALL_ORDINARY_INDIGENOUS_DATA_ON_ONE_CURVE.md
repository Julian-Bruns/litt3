# One finite etale cover destroys every ordinary nilpotent datum on a fixed curve

Author/root,2026-09-05. Audit PASS,/root/all_ordinary_data_killed_finite_cover_audit,
2026-09-05, for the seventy-object destruction theorem and its proof
in Sections1–3.
[Scoped verdict and qualifications](audits/ALL_ORDINARY_DATA_KILLED_ON_ONE_FINITE_ETALE_2_COVER_AUDIT_2026_09_05.md).
Consolidation2026-09-07 retains that scope; Sections4–5 are separately
AUTHOR-only counterexample/source comparison, not additions to the audit.
“Ordinary” means Mochizuki's nilpotent indigenous ordinariness, NOT
ordinary dormant opers. Curves and bundles in Sections1–4 are unmarked.

## 1. Exact audited theorem and complete pool

Over algebraically closed k of characteristic5, put X:y²=x⁵−x,
η=dx/y. There is a connected finite etale Galois2-group cover V→X
on which EVERY ordinary nilpotent indigenous PGL₂ bundle from X
becomes nonordinary, permanently under further connected etale covers.

There are exactly70 such objects:10 have degree2 killing witnesses
and the other60 have degree4 witnesses. This does NOT say V has no
ordinary indigenous bundles of its own, that V cannot lift, or that
two curves have no common cover.

The [complete unmarked quartic pool](GENUS_TWO_HYPERELLIPTIC_INDIGENOUS_INVARIANCE_AND_COMPLETE_UNMARKED_QUARTIC_POOL.md)
consists of70 ordinary normalized A with

    C₃(A⁴)=A, div(A)=2D, D reduced.

Ten are squares and60 nonsquares. Their square Hasse invariants are−A,
so distinct tensors give distinct projective objects. Completeness
uses the [primary deformation-data translation](CARTIER_EIGENFORMS_AS_MULTIPLICATIVE_DEFORMATION_DATA.md):
dormant objects have zero square Hasse invariant, hence zero induced
Frobenius on H¹(T_X), so are not ordinary here. Ordinary nilpotent
objects are admissible (Mochizuki II Proposition3.2); unmarked active
admissible data have no spikes and local signatures1 or3/2. Thus
their quartics have precisely the displayed divisor, and conversely.
The [inverse-character criterion](ORDINARY_INDIGENOUS_INVERSE_CHARACTER_CARTIER_CRITERION.md)
identifies ordinariness with bijectivity of T_A(q)=C₁(Aq).

The60 nonsquares form one automorphism orbit by the complete-pool
certificate. The10 squares correspond to conjugate pairs in
P¹(F₂₅)−P¹(F₅). The affine group x↦ax+b acts transitively on its
20 points; PGL₂(F₅) lifts to X. Naturality and unique quartic
normalization therefore make the10 squares one orbit too.

## 2. Actual degree2 and degree4 witnesses

For the square orbit take

    q₀=2(1+x+2x²)η², A=q₀²=(x⁴+x³+3x+4)η⁴.

The quadratic certificate gives normalization and ordinariness;
discriminant3 is nonsquare, proving the reduced divisor. The connected
etale double T:v²=u⁸−1→X, (x,y)=(u²,uv), represents{0,∞} in Pic(X)[2].
With ρ=du/v, η pulls back to2ρ and

    A_T=(u⁸+u⁶+3u²+4)ρ⁴,
    T_(A_T)(vρ²)=ρ C((u⁸+u⁶+3u²+4)du)=0.

No exponent is4mod5. The quadratic vρ² is nonzero and regular:
at finite branches ρ is a unit and v vanishes; at either infinity
ord(ρ)=2,ord(v)=−4. Automorphisms give witnesses for all10 squares.

For the nonsquare orbit take t²=2 and
A₀=(tx+3x²+3tx³)η⁴. The [full degree4/D8 certificate](D8_NONLINEAR_CARTIER_FAILURE_INVISIBLE_ON_QUADRATIC_SUBCOVERS.md)
proves that the smooth projective normalization of

    Y:v²=u⁸−1, z²=(u−1)(u−3t),
    Y→X: x=u²/(2u²+1), y=uv/(2u²+1)³

is connected etale of degree4 and genus5. It is a tower of actual
etale doubles followed by an automorphism, NOT a presumed common
Galois closure of two arbitrary maps. The nonzero regular quadratic

    (v/z)(u+2+4t)(du/v)²

lies in its kernel: before inverse Frobenius, the block is

    [3+2t  3+4t; 1+2t  2+2t]*(2+4t,1)^T=0.

The full scalar certificate proves the other blocks invertible and
kernel dimension1. Automorphism transitivity gives all60 witnesses.
The additional63-good-cover test retained there concerns a DIFFERENT
specified first-double map; it does not contradict this witness.

## 3. Finite-family destruction, with the actual source

Let C be smooth connected projective in characteristic5 and A₁,…,A_r
quartics. Suppose each has a connected finite etale C_i→C carrying
a nonzero regular quadratic q_i with T_(A_i|C_i)(q_i)=0.

Any connected component V of their fiber product is finite etale over
C. Its projection to each connected C_i is nonempty, open and closed,
hence surjective. Differential pullback is injective and Cartier
commutes with etale pullback. Thus ALL q_i remain nonzero kernel
vectors on the SAME V and on every further connected etale cover.

If all Galois closures have groups in a class closed under products
and subgroups, choose their connected compositum instead. Its group
is a subgroup of the product. Here each degree2 closure is C₂, and
each degree4 tower closure embeds in C₂ wr C₂, of order8. Hence
the compositum is a2-group cover, proving Section1.

A finite endpoint pool therefore cannot ensure that some member
stays ordinary on every source. This does not decide a compatible
ordinary datum on an unknown minimal common source. There is no
conflict with [Galois5-group preservation](TWISTED_CARTIER_ETALE_COVERS_AND_SIMPLE_MONODROMY_FACTORS.md):
these witnesses have2-group monodromy.

## 4. Two good covers with no good common refinement — author only

Keep the square A=(x⁴+x³+3x+4)η⁴. Call an actual cover π:C→X
good if T_(π^*A) is bijective. The doubles adjoining sqrt(x(x−1))
and sqrt(x−1) are BOTH good; their connected degree4 fiber product
and EVERY further connected etale refinement are bad.

The [double-cover calculus, Section2](D8_NONLINEAR_CARTIER_FAILURE_INVISIBLE_ON_QUADRATIC_SUBCOVERS.md)
proves that, for F=a+bx+cx²+dx³+ex⁴ and an ordinary base, the standard
double is good iff c≠0 and3(a²+e²)−bd≠0, and gives the GL₂(F₅)
transformation formula. Applying it to this F gives:

| Branch pair | Matrix | Coefficients, increasing degree | c | Determinant |
|---|---|---|---|---|
| {0,1} | (1,0;1,1) | (4,4,3,1,4) |3|2|
| {1,∞} | (1,1;0,1) | (4,0,4,0,1) |4|1|
| {0,∞} | identity | (4,3,0,1,1) |0|3|

These exact scalar expansions can be replayed after loading the
scalar functions in that certificate:

```python
for g,expected,c0,d0 in [
    ((1,0,1,1),[4,4,3,1,4],3,2),
    ((1,1,0,1),[4,0,4,0,1],4,1),
    ((1,0,0,1),[4,3,0,1,1],0,3)]:
    a,b,c,d=g; D=(a*d-b*c)%5; F=[0]*5
    for i,fi in enumerate([4,3,0,1,1]):
        p=pmul(ppow([b,a],i),ppow([d,c],4-i))
        for j,v in enumerate(p): F[j]=add(F[j],mul(D*D%5,mul(fi,v)))
    aa,bb,cc,dd,ee=F
    determinant=add(mul(3,add(mul(aa,aa),mul(ee,ee))),neg(mul(bb,dd)))
    assert F==expected and cc==c0 and determinant==d0
print("Two good doubles, bad product character: exact scalar checks PASS.")
```

The two nonzero distinct Pic(X)[2] classes are independent, so their
fiber product is connected degree4. It contains
sqrt(x(x−1))/sqrt(x−1)=sqrt(x), hence dominates the bad T of Section2.
Every further cover retains its explicit kernel vector. Every common
refinement OVER X factors through this fiber product and is bad.

Equivalently, in G=C₂×C₂, coefficient modules1,χ₁,χ₂ are good
but χ₁χ₂ is bad. Thus the exact good-module Serre subcategory is
not tensor-closed, and goodness is not simply factoring through a
quotient of π₁. This is not a common-cover obstruction: the two good
curves already have the displayed common etale cover.

## 5. Bounded primary-source comparison — author only

[Hoshi, characteristic3, Corollary5.4/TheoremC](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1811revised.pdf)
already gives individual destruction on EVERY smooth proper
genus≥2 curve in characteristic3. The finite-family argument then
gives simultaneous destruction for any finite list; that formal
step is not new content of Section1.
His [February2022 Theorem2.4/Corollary2.6](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1918revised.pdf)
also treats pointed curves and tame maps, still at3.

That proof trivializes the2-torsion Hasse defect, then uses a
nonordinary-Jacobian cover. Its local kernel argument (Claim2.4.A)
forces vanishing at supersingular points from a second-derivative
identity. The corresponding fourth-derivative implication is false:
φ=t,δ=ψ=1 gives (φ²δψ)''''=0 but ψ(0)=1. Also the Hasse invariant
has weight(p−1)/2; dividing a quadratic gives a one-form at3 but
not at5. These are failures of THAT mechanism, not disproofs of
every possible general characteristic5 destruction theorem.

There is a concrete failure of its trivial-defect/Jacobian equivalence:
our10 square quartics have trivial Hasse defect and ordinary indigenous
bundles, while Cartier on H⁰(X,ω_X) is zero. Indeed coefficients
of(x⁵−x)²=x¹⁰+3x⁶+x² at exponents4,3,9,8 vanish. Raynaud's
[nonordinary-cover theorem, Theorem2](https://doi.org/10.1023/A:1001840726893)
holds at5, with solvable prime-to-p Galois monodromy, but alone cannot
replace the missing indigenous/Jacobian equivalence.

[Borne, Section2.5, Definition2.10/Lemmas2.11–2.12](https://arxiv.org/pdf/math/0204088)
is a precedent for simple-representation tests of ordinary Jacobians
and normal p-group comparisons, not a theorem about this fixed quartic.
Our exact coefficient proof is independent; its lack of tensor closure
and its nonlinear D8 failure are explicit above.

The honest comparison is an explicit characteristic5 analogue on ONE
curve with2-group monodromy. Its substantive inputs are the complete70
objects and their degree2/4 witnesses. The bounded checked literature
does not establish publication priority or exclude a broader theorem.
Nothing here proves nonliftability or a missing common etale source.
