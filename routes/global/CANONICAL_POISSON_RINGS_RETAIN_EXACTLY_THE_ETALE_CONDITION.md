# Canonical Poisson rings retain exactly the etale condition

Date: 2026-09-05. Author: root.
Status: Theorems 1 and 2 and the further addenda independently checked PASS by
/root/canonical_poisson_etale_finiteness_check, GPT-6 Astra medium,
2026-09-05.
[Audit record](audits/CANONICAL_POISSON_RINGS_RETAIN_EXACTLY_THE_ETALE_CONDITION_AUDIT_2026_09_05.md).
The further consequences are proved explicitly below.
This is an exact structural reformulation, not a common-cover
nonexistence theorem. No historical novelty is claimed.

Throughout, \(k=\overline{\mathbf F}_5\); the same arguments work over
any algebraically closed field, except the specifically positive
characteristic center statement. All curves are smooth, projective,
connected, of genus at least two. Put
\[
 R(X)=\bigoplus_{m\ge0}H^0(X,\omega_X^m).
\]

## 1. A bracket on all higher differentials

In an etale local coordinate \(x\), set
\[
 \{a(dx)^m,b(dx)^n\}
       =(n b\,da/dx-m a\,db/dx)(dx)^{m+n+1}.           \tag{1}
\]
This gives a canonical Poisson bracket of degree \(+1\) on \(R(X)\).
In particular it is bilinear, skew, satisfies Jacobi, and is a
derivation in each argument for the ordinary product.

Here is a characteristic-independent construction and verification.
Choose a nonzero rational differential \(u\), write \(da=D(a)u\),
and represent a rational \(m\)-differential as \(a u^m\). Then (1) is
\[
 \{a u^m,b u^n\}=(n bD(a)-m aD(b))u^{m+n+1}.          \tag{2}
\]
Changing the rational frame \(u\) adds logarithmic-derivative terms
which cancel in the displayed alternating expression. Alternatively,
on the punctured cotangent bundle use the canonical symplectic
bracket with sign convention \(\{\xi,x\}=1\), and represent
\(a(dx)^m\) by \(a\xi^{-m}\). Its Poisson bracket is exactly (1).
This proves Jacobi and the Leibniz rules in any characteristic.
Formula (1), with a regular etale coordinate, proves that brackets
of regular sections remain regular.

This bracket is already present in Enriquez--Odesskii,
*Quantization of canonical cones of algebraic curves* (2002),
[Proposition 1.1 and Section 2.4.1](https://arxiv.org/html/math/0112148).
Their paper is stated in characteristic zero. The elementary formulas
above and proofs below supply the characteristic-five statements used
here; their quantization results are not being imported.

## 2. Ring maps preserving the bracket are actual separable maps

**Theorem 1.** Differential pullback gives a bijection between

- nonconstant separable morphisms \(f:C\to X\); and
- injective, degree-preserving, unital Poisson \(k\)-algebra maps
  \(\phi:R(X)\to R(C)\).

In particular no arbitrary choice of differential multiplier, and
no purely inseparable curve map, supplies an extra such ring map.

**Proof.** A separable curve map injects rational differential spaces
by pullback, sends regular pluriforms to regular pluriforms, and
preserves products and (1) by the chain rule. The terms differentiating
the differential multiplier cancel in the alternating expression.
This proves the forward direction, even for ramified maps.

For the converse, invert all nonzero homogeneous elements. The
homogeneous localization of the full canonical section ring is
\[
          k(X)[u,u^{-1}],\qquad \deg u=1,               \tag{3}
\]
where its degree-one part is the line of rational differentials.
To justify this without assumptions on the canonical map in degree
one, sufficiently high powers of \(\omega_X\) are very ample.
Ratios of their sections generate \(k(X)\), and a nonzero global
one-form supplies \(u\). This yields (3). The Poisson bracket extends
uniquely to the localization by the quotient rule.

The injection \(\phi\) therefore yields a field embedding
\(\iota:k(X)\hookrightarrow k(C)\), and sends
\[
                         u\longmapsto h v
\]
for a nonzero rational differential \(v\) on \(C\) and
\(h\in k(C)^\times\). The embedding \(\iota\) determines a unique
nonconstant map \(f:C\to X\): rational maps from a smooth projective
curve to a projective smooth curve extend everywhere.
Write \(da=D_X(a)u\), and \(db=D_C(b)v\). Preservation of
\(\{a,u\}=D_X(a)u^2\) gives
\[
       hD_C(\iota a)=h^2\iota(D_Xa),\qquad
       D_C(\iota a)=h\iota(D_Xa).                      \tag{4}
\]
There is an \(a\) with \(D_Xa\ne0\), so (4) forces \(df\ne0\);
the curve map is separable. Equation (4) also says exactly that
\(f^*u=hv\). It follows by multiplication that \(\phi\) is actual
differential pullback in every weight. Uniqueness is clear. \(\square\)

For example, multiplying every degree \(m\) image by \(c^m\) would
preserve products, but the bracket has degree \(+1\). Equation (4)
forces \(c=1\) for an otherwise fixed map. This explains why the
bracket retains the differential normalization.

## 3. Module finiteness detects the missing etale condition

**Theorem 2.** Under Theorem 1, the following are equivalent:

1. The curve map \(f:C\to X\) is finite etale.
2. \(R(C)\) is a finite module over \(\phi(R(X))\).
3. The subspace \(\phi(H^0(X,\omega_X^3))\) has no base point on \(C\).

**Proof.** A nonconstant map of projective smooth curves is finite.
If \(f\) is etale then \(\omega_C=f^*\omega_X\), and projection formula
identifies the graded ring \(R(C)\), as module, with
\[
 \bigoplus_{m\ge0}
       H^0(X,f_*\mathcal O_C\otimes\omega_X^m).
                                                               \tag{5}
\]
For a coherent sheaf and an ample line bundle its section module
is finite over the full section ring. This standard finite-generation
fact can be checked after a sufficiently high Veronese power, using
Serre vanishing and the section-module construction on a projective
embedding. Hence (1) implies (2).

Conversely, suppose \(df\) has a zero at \(q\in C\). Every positive
degree differential pullback vanishes at \(q\). Thus evaluation at
\(q\), in each weight, annihilates the ideal
\[
              I=\phi(R(X)_+)R(C).
\]
But \(\omega_C^N\) is globally generated for arbitrarily large \(N\),
so evaluation supplies nonzero quotients of \((R(C)/I)_N\) for all
such \(N\). This quotient is infinite-dimensional over \(k\).
If \(R(C)\) were finite over \(R(X)\), tensoring with
\(R(X)/R(X)_+=k\) would instead make \(R(C)/I\) finite-dimensional.
This contradiction shows that (2) forces \(df\) to have no zeros.

A finite separable map of smooth curves is flat; its differential
has no zeros exactly when it is etale. This uses the actual
different divisor and covers wild ramification as well.

Finally \(\omega_X^3\) is globally generated. Its pullback by the
differential vanishes simultaneously precisely at the zeros of
\(df\). Thus (3) is equivalent to (1). \(\square\)

**Corollary 3 (exact common-cover formulation).** The curves \(X,Y\)
have a common finite etale cover if and only if there is a smooth
projective curve \(C\) whose canonical Poisson ring admits two
degree-preserving injective Poisson maps
\[
                     R(X)\longrightarrow R(C)
                         \longleftarrow R(Y)
                                                               \tag{6}
\]
such that \(R(C)\) is finite as a module over each image.

The same \(R(C)\) must serve both maps. Replacing it by an arbitrary
graded algebra, omitting the Poisson bracket, or retaining only
extensions of fraction fields is not the assertion.

## 4. A finite set of low-weight compatibility checks

The canonical ring of a genus-at-least-two curve is generated as an
algebra in degrees at most three in arbitrary characteristic; see
[the checked canonical-ring note](CANONICAL_RING_GENERATORS_DO_NOT_DETERMINE_TRACE_REALIZATIONS.md).
Choose homogeneous algebra generators \(s_i\), with \(\deg s_i\le3\).
For a candidate graded algebra homomorphism \(\phi\), bracket
preservation is equivalent to the finite list
\[
                 \{\phi(s_i),\phi(s_j)\}
                         =\phi(\{s_i,s_j\})             \tag{7}
\]
for all pairs of generators. Each identity has weight at most seven.
Indeed the difference of the two brackets is a biderivation relative
to \(\phi\). Vanishing on generator pairs extends by the Leibniz
rules and linearity to every pair of polynomials in those generators.

This statement concerns a genuine algebra homomorphism whose defining
ring relations are already satisfied. It does not say that traces in
weights at most seven determine every higher trace. Traces are not
algebra homomorphisms. Finiteness or the base-point test in Theorem 2
is also still required.

Thus the higher differential structure has a finite algebraic
description and finitely checkable derivative compatibility, even
though the possible target curves and module ranks remain unbounded.

## 5. Characteristic-five center: a genuine structural difference

**Proposition 4.** The Poisson center of \(R(X)\) is
exactly \(R(X)^5\), the subring of fifth powers. The ring is finite
over that center, of generic rank \(25\). No global freeness claim
is made at the vertex of the canonical cone.

**Proof.** Fifth powers are central by the Leibniz rule. Conversely,
the center is graded, since the bracket has a fixed degree.
A central homogeneous element can be written \(a u^m\) in (3).
It remains central after localization. Bracketing with
\(b\in k(X)\) in (2), and choosing \(D_Xb\ne0\), forces \(5\mid m\).
Bracketing with \(u\) then forces \(D_Xa=0\). The kernel of a
nonzero derivation of a smooth one-variable function field over
perfect \(k\) is \(k(X)^5\). Hence
\[
                       a u^m=(c u^{m/5})^5
\]
as a rational pluriform. Because the left side is regular, every
valuation of its rational fifth root is nonnegative. The root
therefore belongs to \(R(X)\). For sums of homogeneous components
use additivity of fifth powers. This proves the center claim.

The finitely generated \(k\)-algebra \(R(X)\) is finite over its
fifth-power subring: monomials with generator exponents below five
span it, since \(k\) is perfect. Its fraction field has
transcendence degree two and fifth-power index \(5^2\), proving the
generic rank. \(\square\)

Passing to these centers in (6) gives the Frobenius-twisted version
of the same two embeddings, not a smaller common-cover problem.
The rank \(25\) is universal for the individual canonical rings;
it does not bound the degree of one curve's ring inside another's.

## 6. Strategic value and present limitation

This answers a structural weakness of representations by traces:
multiplication plus the bracket retains actual differential pullback,
and module finiteness retains exactly the etale hypothesis. No Galois
assumption or simultaneous lifting has entered.

It does not establish a restriction on two finite Poisson embeddings
into the same canonical ring. Such a restriction, specialized to our
chosen pair but stable under finite module extension, is the missing
application. Merely restating the existence problem in (6), or noting
finite generation over the center, is not a nonexistence proof.
