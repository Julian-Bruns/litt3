# Proof: ordinary shared sources give finite partner sets

[Statement](../../Theorems/projective_connections/ordinary_source_partner_finiteness.md).
Author /root,2026-09-09. The canonical-double part of the supplied Pro
answer was already proved in the library and is not repeated here.
The source ordinariness hypothesis is retained throughout.

## 1. Lift the SAME compatible source

An infinitesimal deformation on a fixed curve is r+epsilon phi with
phi a regular quadratic. Finite etale pullback preserves the nilpotent
equation and injects regular quadratics. Thus T_nil(C,r_C) injects into
T_nil(W,r_W), and likewise for B, without dividing by a map degree.
Source ordinariness therefore implies endpoint ordinariness.

Put R=W(k). For an ordinary nilpotent pair, Mochizuki's ChapterIII
Theorem3.2 constructs its canonical lift over R. Lift the finite etale
cover a to the canonical lift of (C,r_C), and pull back its connection.
Existence and uniqueness of this finite etale lift follow from
[Stacks Lemma58.9.1](https://stacks.math.columbia.edu/tag/0BQC): finite
etale covers of a proper scheme over a henselian local ring are
equivalent to those of its closed fiber. The cover degree is unrestricted.

Crucially, [Mochizuki III Corollary3.5](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf)
(printed p.115) says that a pullback-compatible log-admissible morphism
with ORDINARY UPPER REDUCTION is canonical on one side if and only if
it is canonical on the other. Our log structures are trivial and the
lifted morphism is finite etale. Therefore the lifted source is the
canonical lift of (W,r_W). Apply the same argument to b and the
canonical lift of (B,r_B). Uniqueness in Theorem3.2 identifies the two
lifted source pairs using their specified identification on the special
fiber. This produces an actual finite etale span over R with one fixed
lift of (C,r_C), not just two unrelated lifts of W.

Source check: Theorem3.2 and Corollaries3.3–3.5 were read in the original
paper, and the Corollary3.5 page was rendered and visually checked.
Its proof invokes the ordinary canonical-lift/MF-connection criterion
and compatibility of Frobenius with log-etale pullback. There is no
prime-to-five degree condition. There IS an upper ordinariness condition;
ordinary endpoint reduction alone does not justify this argument.

## 2. Finiteness and specialization

Over the algebraic closure of Frac(R),
[Mochizuki, Correspondences on Hyperbolic Curves, Theorem4.2](https://www.kurims.kyoto-u.ac.jp/~motizuki/Correspondences%20on%20Hyperbolic%20Curves.pdf)
gives finitely many genus-h common-etale-cover partners of the fixed
lifted C. Its statement and proof were read directly. It applies over
any algebraically closed characteristic-zero field, without a bound
on either witnessing degree.

Two smooth proper special-fiber curves of genus>=2 whose lifted
geometric generic fibers are isomorphic must themselves be isomorphic.
Indeed a generic isomorphism is defined over a finite extension of
Frac(R); after passing to its valuation ring, both smooth proper
models are stable, and
[uniqueness of stable models](https://stacks.math.columbia.edu/tag/0E8C)
extends the isomorphism across the closed fiber. Thus the finite generic
partner list bounds the special partner list for fixed r_C.

The [nilpotent scalar theorem](nilpotent_scalar_model.md) gives a
finite fixed-curve nilpotent scheme of length5^(3g(C)−3). Take the finite
union over its geometric points to allow r_C to vary. This adds no
ordinary-pullback claim: only points having an ordinary common source
contribute. For the displayed genus-two family, the
[affine branch-family theorem](../curve_arithmetic/prime_field_branch_family.md) gives
at most twenty parameters per geometric class. The parameter set is
therefore finite as well.

## 3. The monodromy test

The [tangent-bundle theorem](tangent_bundle_cyclic_refinements.md)
gives (1), compatibly with EVERY actual finite etale pullback and with
splitting of the canonical double. Its interpretation by the dormant
pair is [the canonical-double theorem](etale_double_dormant_pairs.md),
Sections1–2. No new proof or extra ordinary hypothesis is concealed here.

Let T→C be the finite etale Galois closure of the actual leg, with
group G as in the statement. Over k in characteristic5, a simple G-module
has nonzero P-invariants because P is a5-group. Normality makes its
P-invariants G-stable, so P acts trivially on the entire simple module.
The simple modules therefore factor through A; since A is abelian of
prime-to-five exponent N, they are characters of order dividing N.
Filter the regular G-module by simple factors. Exact Galois descent
along the actual torsor gives a filtration of the associated bundle
pi_*O_(T^(1)) by degree-zero line bundles in Pic(C^(1))[N]. This is
descent, NOT an averaging argument in the modular group algebra.

Tensor the filtration with E_(r_C). Hypothesis(2) and the long exact
sequence in H^0 show every successive extension has no sections.
Projection formula gives H^0(T^(1),pi^*E_(r_C))=0. Injection under
T→W then proves(1). Apply the first part of the theorem.

Finally, normalization in the actual joint field is intermediate in
each finite etale leg, hence all resulting maps are finite etale.
Compatible connections descend by injectivity of quadratic pullback.
The same injectivity proves the final ordinary-witness equivalence and
the persistence of nonzero tangent vectors under further refinement.
