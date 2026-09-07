# Maximal Tango descent without a Galois hypothesis

**Status: audited PASS, 2026-09-05; no breaking objections.**
Auditor: `/root/x_elliptic_quotient_maps`. The audit covers this theorem
and its required input chain, not every claim in files 111--113. The
auditor previously contributed finite-group examples in file 112 that
are not used here. One optional exposition suggestion concerns explicit
fpqc descent of the subbundle property.
[Audit record](audits/115_POSITIVE_RANK_PRESERVING_TANGO_DESCENT_AUDIT.md).

Main theorem and Frobenius-root proof: `/root`. Separate
verification of normalized-norm connection descent and its combination
with files 111--113: `/root/gluing_cohomology_rigidity`.

This is the selected result of the second three-route comparison.
It removes the Galois hypothesis for covers preserving positive p-rank.
It does NOT assume that a Galois closure preserves p-rank. Files
111--113 are retained pending an audit of the combined theorem.

Throughout, k is algebraically closed of odd characteristic p, and
curves are smooth, projective and connected. Write gamma(C) for the
p-rank. The prime-to-p root lemma below works also in characteristic
two and with p-rank zero.

## 1. The all-degree theorem

Use the relative Frobenius F_C:C -> C^(1), and set

\[
 B_C^1=\ker\bigl(\operatorname{Car}:F_{C*}\omega_C
                               \longrightarrow\omega_{C^{(1)}}\bigr).
\]

A maximal Tango structure on C is an embedded line subbundle L of
B_C^1 whose adjoint F_C^*L -> omega_C is an isomorphism. Denote its
set by Tan(C). This is exact maximality, not equality with a
floor-rounded integer bound. Equivalently, a structure is represented
by a rational exact differential xi with div(xi) = pD.

### Theorem 115.1

For every connected finite etale map f:D -> X such that

\[
                         \gamma(D)=\gamma(X)>0,
\]

pullback induces a bijection

\[
                 \boxed{\operatorname{Tan}(X)
                           \xrightarrow{\sim}\operatorname{Tan}(D).}
                                                               \tag{115.1}
\]

No condition is imposed on the degree, on the monodromy group, or
on the p-rank of the Galois closure.

In particular, a finite etale cover of a positive-p-rank curve cannot
acquire its first maximal Tango structure without increasing p-rank.

## 2. Frobenius roots descend through rank-preserving prime-to-p covers

The structural input here is more general than canonical bundles.

For a line bundle M on C, let Root_C(M) be the set of isomorphism
classes of line bundles L on C^(1) with F_C^*L isomorphic to M.
An isomorphism is not part of the set; changing it by a global scalar
does not affect its associated connection or embedded canonical line.

### Lemma 115.2

Let f:D -> X be finite etale of degree n prime to p, with
gamma(D) = gamma(X), possibly zero. For every line bundle M on X,
the natural pullback map is bijective:

\[
 \operatorname{Root}_X(M)\xrightarrow{\sim}
                    \operatorname{Root}_D(f^*M).        \tag{115.2}
\]

In particular, the right side is nonempty if and only if the left
side is nonempty.

#### Proof

The Frobenius square for a finite etale map is Cartesian. Consequently
finite-flat norm and its base-change compatibility give

\[
 F_X^*\operatorname{Nm}_{f^{(1)}}(L_D)
 \simeq\operatorname{Nm}_f(F_D^*L_D)
 \simeq\operatorname{Nm}_f(f^*M)
 \simeq M^{\otimes n}                                   \tag{115.3}
\]

for every L_D in Root_D(f^*M).

Choose integers u,v with un + vp = 1. If N is the norm of L_D,
define a line bundle on X^(1) by

\[
                   L_0=N^{\otimes u}\otimes(M^{(1)})^{\otimes v}.
\]

Negative tensor exponents mean dual powers. Since
F_X^*(M^(1)) is canonically M^p, equation (115.3) gives

\[
                              F_X^*L_0\simeq M.          \tag{115.4}
\]

Thus existence of an upstairs root implies existence downstairs.

Now let

\[
 K_C=\ker\bigl(F_C^*:\operatorname{Pic}^0(C^{(1)})(k)
                                   \to\operatorname{Pic}^0(C)(k)\bigr).
\]

As recalled in file 111, this is an elementary abelian p-group of
order p^gamma(C). Equivalently, it is the geometric kernel of
Verschiebung on the Jacobian. Pullback K_X -> K_D is injective:
if f^(1)*T is trivial, then taking norms gives T^n trivial, while
T^p is trivial and gcd(n,p) = 1. Since the two groups have equal
finite cardinality, pullback is an isomorphism.

When nonempty, each root set in (115.2) is a torsor under its K_C,
and pullback respects those torsor actions. Existence (115.4) and
the isomorphism K_X -> K_D prove both surjectivity and injectivity
of (115.2). \(\square\)

### Corollary 115.3

Under the hypotheses of Lemma 115.2, pullback induces a bijection
Tan(X) -> Tan(D).

#### Proof

Use omega_D = f^*omega_X. Every upstairs maximal Tango line has
a unique root class L_X downstairs by Lemma 115.2. Choose an
isomorphism F_X^*L_X -> omega_X. Adjunction supplies its embedded
line in F_X*omega_X. Its pullback is the specified embedded line
upstairs: after identifying the roots, the two isomorphisms upstairs
differ only by a scalar, since H^0(D,O_D) = k.

The Cartier operator commutes with etale pullback. Therefore the
downstairs line lies in its kernel if and only if the upstairs line
does; the reverse implication uses faithful flatness of f^(1).
This proves surjectivity on Tango structures, and uniqueness of
the downstairs root proves injectivity. \(\square\)

## 3. Connection interpretation and the exact failed shortcut

The preceding lemma also has a useful differential proof. It explains
why the p-rank hypothesis is essential to the argument.

Regular zero-p-curvature connections on a fixed line bundle form,
when nonempty, an affine torsor under the F_p-vector space

\[
 V_C=\{\beta\in H^0(C,\omega_C):\operatorname{Car}(\beta)=\beta\},
 \qquad \dim_{\mathbf F_p}V_C=\gamma(C).
\]

Suppose f:D -> X is finite etale of degree n prime to p, and a
dormant connection is given on omega_D = f^*omega_X. In an etale
local splitting over a base coordinate x, write its coefficients
as a_1,...,a_n in the frame dx. Put

\[
                            \bar a=\frac1n\sum_i a_i.    \tag{115.5}
\]

This is the normalized norm connection on omega_X. The coordinate
change rule is preserved, since all coefficients transform by the
same affine rule. Its p-curvature is zero: with partial = d/dx,
one has partial^p = 0 on the separable function field and

\[
 \bar a^p+\partial^{p-1}\bar a
       =\frac1n\sum_i(a_i^p+\partial^{p-1}a_i)=0.        \tag{115.6}
\]

Here 1/n belongs to F_p. The difference between the original
connection and the pullback of its normalized norm is therefore
a Cartier-fixed regular differential delta on D with trace zero.
Pullback V_X -> V_D is injective. When the p-ranks agree, it is
an isomorphism; thus delta = f^*beta. Its trace is n beta, so
delta = 0. The connection itself descends.

Without equality of ranks, the trace-zero space has dimension
gamma(D) - gamma(X). It need not vanish. Moreover averaging alone
does not preserve the Tango condition, even when each conjugate
connection satisfies it. In characteristic five the condition is
the nonlinear equation

\[
 P_4(a)=a^4-a^2a'+3(a')^2+4aa''-a'''=0.
\]

The supporting note
[Tango norm defect and connected affine counterexample](TANGO_NORM_DEFECT_AND_CONNECTED_AFFINE_COUNTEREXAMPLE.md)
gives both the exact trace defect and a connected affine etale
double-cover example where each original conjugate is Tango but
its normalized norm is not. That example is NOT asserted to be
projective or to have a p-rank-one compactification.

## 4. Completion of the all-degree proof

Let gamma(D) = gamma(X) = r > 0.

If r >= 2, the [rank-preservation bound, Section 4](112_P_RANK_ONE_NONGALOIS_FACTORIZATION.md)
says that deg(D/X) is prime to p.
Corollary 115.3 immediately proves (115.1).

Suppose r = 1. The [rank-one factorization, Section 3](112_P_RANK_ONE_NONGALOIS_FACTORIZATION.md) gives

\[
                        D\longrightarrow E\longrightarrow X,
\]

where D/E has degree prime to p and E/X is cyclic Galois of
p-power degree. All three curves have p-rank one. By Corollary
115.3, Tan(E) -> Tan(D) is bijective.

It remains to use the rank-one p-group descent of file 111.
For clarity, its mechanism is the following. The space of dormant
canonical connections on E, if nonempty, is an affine F_p-line.
The local Tango equation has degree p-1 with nonzero leading
coefficient along that line. Thus

\[
                         |\operatorname{Tan}(E)|\le p-1.
\]

The p-group Aut(E/X) acts on this finite set. Every orbit has
p-power size; since the entire set has fewer than p elements,
each structure is fixed. Its embedded line or its canonical
connection then descends along the actual etale torsor E/X.
Cartier-zero descends by faithful flatness. Pullback is injective
for embedded structures. Hence Tan(X) -> Tan(E) is bijective.

Composing the two bijections proves Theorem 115.1. \(\square\)

The argument never takes the Galois closure of D/E. In particular,
it does not need the unproved assertion that a rank-preserving
prime-to-p cover has a rank-preserving Galois closure.

## 5. Consequences and application boundaries

### Corollary 115.4 (rank growth is necessary)

If gamma(X) > 0, Tan(X) is empty, and D -> X is finite etale
with Tan(D) nonempty, then gamma(D) > gamma(X).

Indeed p-rank cannot decrease under a finite separable map of
smooth projective curves: the base Jacobian is an isogeny factor
of the upstairs Jacobian. Equality is excluded by Theorem 115.1.

If p does not divide g(X) - 1, then Tan(X) is automatically
empty. Thus the same strict-growth conclusion applies.

### Optional rank-one genus-nine source

For the optional curve X_1 in
`P_RANK_ONE_GENUS9_ALTERNATIVE_SOURCE.md`, one has p=5,
g(X_1)-1=8, and gamma(X_1)=1. Every rank-preserving finite etale
cover of X_1 has no maximal Tango structure, regardless of its
degree or whether it is Galois.

This strictly improves the p-group-only statement of file 111.
It still does not exclude a common cover whose rank has grown.
X_1 is not the fixed source in file 76.

### The actual fixed pair

The fixed genus-nine X has rank 6 and the fixed genus-25 Y is
ordinary, of rank 25. A common cover Z necessarily has rank at
least 25, so its X-leg is NOT rank-preserving. Theorem 115.1
therefore gives no contradiction for that pair. Neither original
genus-minus-one (8 or 24) is divisible by 5, so neither original
curve has a maximal Tango structure to pull back directly.

The theorem is a parameterized structural result for possible
future optimization of the curves, not a new excluded common
degree for the fixed pair.

### What remains to extend

The open issue has become genuine p-rank growth, not the missing
Galois-closure reduction. A full common-cover obstruction needs a
quantitative or geometric restriction on that growth while
retaining both actual etale maps from the same projective curve.
Theorem 115.1 does not supply such a restriction.
