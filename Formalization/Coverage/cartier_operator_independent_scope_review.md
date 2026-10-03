# Independent scope review of the intrinsic Cartier construction

Reviewed by the Cartier/spin owner on 3 October2026, independently of the
shared-tensor author's implementation. This is a mathematical source review;
the author's focused Lean trust checks are recorded separately.

The reviewed modules are `Solutions.SharedTensors.CartierBinomialPrimitive`,
`CartierFrobeniusDifferential` and `RationalCartierLogarithmic`, together with
the literal operator definition and the required exact-extraction expansion.

Reviewed source SHA256 values, respectively:
`aaef2bd963f5e543204dd9de5a80710bb8c1bf04c16ad201d4cc086871495469`,
`c56c06d20c5ceac976ddd10e19af55b7c32ddf8395f25ce3f51c48f7f27e64ea`,
`7cb4f4c913f728d4009370691c84a9cf901b2f17d29d89962579bcc9b7052b53`.

The binomial primitive uses every mixed term with index i<p-1. Its only
denominator is i+1, which satisfies 0<i+1<p. The actual characteristic
criterion p divides n exactly when its cast is zero proves each denominator
nonzero; there is no division by p and no enumeration of specific primes.
The ordinary binomial successor identity gives the two derivative terms.
The two finite sums omit exactly the pure a and pure b terms, respectively,
so their derivative is the entire additive defect. This works uniformly at
p=2 as well. The primitive lemma itself has no primality hypothesis: all
nonempty ranges still give the required denominator inequality, while the
degenerate p=0 range has an additive differential identity. Prime
characteristic is explicitly imposed on the subsequent Cartier modules.

For an actual full `PowerPBasis` over the literal Frobenius-image subfield,
and an actual base derivation D normalized by D(t)=1, the composite
C(a^(p-1)D(a)) is proved additive from the displayed exact primitive.
Its product rule follows from ordinary Leibniz and actual p-th
semilinearity of coefficient extraction. It kills the actual base-ring
image. These checked identities construct a genuine derivation; neither
additivity nor a Cartier characterization is assumed. The new derivation
is normalized at t, and the complete p-basis expansion then proves its
equality with D on every field element. This equality is the substantive
Frobenius-differential identity used by the logarithmic step.

For every nonzero a, the literal identity
a^(-1)D(a)=(a^(-1))^p a^(p-1)D(a) and p-th semilinearity give logarithmic
fixedness. The a=0 case is treated separately and is the harmless inverse
zero convention; it does not claim that zero is a field unit. The proof
does not assume logarithmic fixedness, perfectness of the full function
field, or separability. It uses the already constructed actual extraction
map and the just-proved derivation equality.

`intrinsicRationalCartier` is an actual additive map on the literal
universal differential module. Its input is an actual full p-basis and an
actual rank-one K-linear coordinate on that module normalized at t. The
coordinate's injectivity transfers the coefficient calculation to actual
universal differentials. Each field of the `RationalCartierOperator`
structure is proved: p-th semilinearity, killing all exact forms, and
fixing every logarithmic form. No project theorem is inserted as an
axiom or assumed conclusion.

The exact scope of these three modules is therefore accepted. Constructing
the full p-basis and the normalized rank-one coordinate in an arbitrary
perfect-base, finitely generated transcendence-degree-one function field
is a separate actual existence bridge. These three modules do not assume
or prove endpoint field recovery, compatibility of unrelated field
inclusions, or a common-cover existence/exclusion statement.
