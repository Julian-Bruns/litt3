# Ordinary bounded-exponent abelian covers of hyperelliptic curves

**Status:** independently audited **PASS**, 2026-09-05; no breaking
objection. Auditor: `/root/x_elliptic_quotient_maps`.
[Audit record](audits/GENERIC_HYPERELLIPTIC_BOUNDED_ABELIAN_COVERS_ORDINARY_AUDIT.md).
Authors: root and gluing_cohomology_rigidity.

This is a parameterized existence theorem for auxiliary curves, not a
claim about the fixed genus-25 curve of file 76. The proof keeps the
actual finite étale covers throughout the degeneration.

## Theorem

Let \(k\) be algebraically closed of characteristic \(p>2\), let \(g\ge2\),
and fix an integer \(N\ge1\) prime to \(p\).
There is a nonempty Zariski-open substack
\(\mathcal U_{g,N}\subset\mathcal H_{g,k}\) such that, for every
geometric curve \(C\) represented by this open, **every finite connected
étale abelian cover of \(C\) whose Galois group has exponent dividing
\(N\) is ordinary**. In particular \(C\) itself is ordinary.

The open has dimension \(2g-1\).
Over \(k=\overline{\mathbf F}_p\) it has points defined over finite
extensions of \(\mathbf F_p\), including points outside any prescribed
finite set of geometric isomorphism classes.

For \(p=5,g=25,N=8\), this gives a nonempty 49-dimensional hyperelliptic
open on which all connected cyclic étale covers of degrees \(1,2,4,8\),
and indeed all abelian exponent-eight covers, are ordinary.

## 1. A finite maximal cover encodes the whole condition

For a smooth proper connected curve \(C/k\) of genus \(g\), Kummer theory
identifies the characters of its maximal abelian exponent-\(N\) étale
quotient with

\[
                         \operatorname{Pic}^0(C)[N]
                              \simeq(\mathbf Z/N)^{2g}.
\]

Choose a basis of torsion line bundles \(L_1,\ldots,L_{2g}\) and
trivializations \(L_i^{\otimes N}\simeq\mathcal O_C\). Take the fiber
product of the associated Kummer torsors. This is a finite étale cover

\[
                        C_N\longrightarrow C
\]

with group \(\mu_N^{2g}\), of degree \(N^{2g}\).
It is connected: its direct-image algebra is the direct sum of the
distinct degree-zero line bundles indexed by all of \(J(C)[N]\);
only the trivial summand has a nonzero global section. Hence
\(H^0(C_N,\mathcal O_{C_N})=k\).
Its character map is an isomorphism onto \(J(C)[N]\), so every
connected abelian exponent-\(N\) cover is a quotient of \(C_N\).
Changing basis or trivializations does not change this maximal cover
up to \(C\)-isomorphism over the algebraically closed field.

If \(C_N\) is ordinary then all its intermediate covers are ordinary.
For an intermediate finite étale map \(C_N\to D\), its degree is prime
to \(p\). Pullback on \(H^1(\mathcal O)\) is therefore injective,
because trace composed with pullback is multiplication by the degree.
Frobenius commutes with pullback. Its injectivity on
\(H^1(C_N,\mathcal O)\) consequently implies injectivity, and hence
bijectivity, on \(H^1(D,\mathcal O)\).

Thus it suffices to prove that the single maximal cover \(C_N\) is
ordinary on a nonempty open.

## 2. An ordinary elliptic chain inside the hyperelliptic boundary

Choose \(g\) ordinary elliptic curves and join them in a chain,
identifying distinct two-torsion points at successive nodes.
The resulting connected stable curve \(C_0\) has genus \(g\), is of
compact type, and belongs to the stable hyperelliptic boundary.
The involutions on the elliptic components glue, and its quotient is
a chain of projective lines. All nodes are ramification points on both
branches.

This is the usual hyperelliptic clutching construction, valid in
characteristic different from two. In particular \(C_0\) admits a
one-parameter smoothing by smooth hyperelliptic curves, and the entire
family can be taken in the compact-type locus. Choose such a proper
stable family

\[
                    \mathcal C\longrightarrow\operatorname{Spec}R,
                       \qquad R=k[[t]],
\]

after a possible finite extension of the parameter, together with a
section through the smooth locus. Its special fiber is \(C_0\).
The special points used in the chain can all be chosen over finite
fields when \(k=\overline{\mathbf F}_p\).

For a primary description of these boundary morphisms, see
Achter--Pries, *The p-rank strata of the moduli space of hyperelliptic
curves*, [Sections 2.4.1 and 2.4.4](https://arxiv.org/pdf/0902.4637),
especially the clutching map on labeled ramification points and its
iteration over a tree. No claim about a generic nonordinary p-rank
stratum is being used.

## 3. Extend the actual maximal torsor, including at the nodes

The relative identity Picard scheme

\[
                       J=\operatorname{Pic}^0_{\mathcal C/R}
\]

is an abelian scheme of relative dimension \(g\), since \(\mathcal C/R\)
is of compact type. The special fiber is the product of the \(g\)
elliptic Jacobians. For this standard compact-type fact and its use for
relative torsion, see Schröer, *The strong Franchetta conjecture in
arbitrary characteristics*,
[Section 2, proof of Lemma 2.2](https://www.math.uni-duesseldorf.de/~schroeer/publications_pdf/franchetta.pdf).

As \(p\nmid N\), \(J[N]\) is finite étale of rank \(N^{2g}\).
Because \(R\) is strictly henselian, it is constant. Thus a basis of
the special-fiber \(N\)-torsion extends to a basis over \(R\), and these
sections exhaust all geometric generic-fiber \(N\)-torsion as well.

Using the section of \(\mathcal C/R\) to rigidify line bundles, represent
this basis by \(L_1,\ldots,L_{2g}\) on \(\mathcal C\).
Their \(N\)-th powers have their rigidified trivializations.
Form the same fiber product of Kummer torsors on the entire family:

\[
                       \mathcal C_N\longrightarrow\mathcal C .
\]

It is finite étale even over the nodes. Indeed locally each factor is
given by \(z^N=u\) with \(u\) a unit; its derivative \(Nz^{N-1}\)
is a unit, including in a nodal local ring. Consequently
\(\mathcal C_N/R\) is proper flat with nodal special fiber and smooth
generic fiber.

The special fiber is connected. To see this with no connectedness
assumption hidden in specialization, note that any nontrivial
multidegree-zero line bundle on a connected curve of compact type has
no global section. A section nonzero on one component of degree zero
has no zeros there; compatibility across nodes propagates this to all
components and trivializes the line bundle. The special-fiber
character line bundles are distinct elements of \(J(C_0)[N]\), so
the direct-image algebra again has exactly one global section.
The same calculation on the geometric generic fiber proves its
connectedness and identifies it with the maximal cover of Section 1.

This construction extends the entire abelian torsor. It does not
assume that an arbitrary nonabelian cover of the generic fiber has
étale reduction.

## 4. Frobenius is bijective on the nodal special fiber

Write \(Z_0=(\mathcal C_N)_0\). The normalization of \(Z_0\) is a
disjoint union of smooth curves each mapping connected finite étale
to one of the elliptic components of \(C_0\).
Each is therefore an elliptic curve isogenous to an ordinary elliptic
curve, and is ordinary.

Let \(\Gamma\) be the connected dual graph of \(Z_0\), and let
\(\widetilde Z_v\) be its normalized components. The normalization
sequence gives a Frobenius-compatible exact sequence

\[
 0\longrightarrow H^1(\Gamma,k)
  \longrightarrow H^1(Z_0,\mathcal O_{Z_0})
  \longrightarrow\bigoplus_v
          H^1(\widetilde Z_v,\mathcal O_{\widetilde Z_v})
  \longrightarrow0.                                      \tag{1}
\]

On the graph term Frobenius is the coefficientwise map \(a\mapsto a^p\),
which is bijective because \(k\) is perfect.
On the last term it is bijective because all normalized components
are ordinary. It is consequently bijective on the middle term.

This is the precise generalized ordinarity needed in the argument.
One must not replace it by counting geometric \(p\)-torsion points
of a generalized Jacobian: its torus has trivial geometric
\(p\)-torsion, while the graph term in (1) contributes bijective
Frobenius on \(H^1(\mathcal O)\).

The sheaf \(R^1(\mathcal C_N/R)_*\mathcal O_{\mathcal C_N}\) is locally
free and commutes with base change. The linearization of Frobenius
is a map between vector bundles of equal rank. Its determinant is a
unit on the special fiber by (1), so it is nonzero on the generic
fiber. Hence the smooth geometric generic fiber of \(\mathcal C_N\)
is ordinary.
This proves the needed smoothing statement directly; no assertion
about semicontinuity of a differently defined semiabelian p-rank
is required.

## 5. A nonempty open, not only a formal or generic example

Étale locally on the hyperelliptic moduli stack, choose a marked
Weierstrass point and a full \(N\)-torsion frame.
These are finite étale auxiliary choices, and the marked point gives
the rigidification used above. The Kummer construction then provides
a family of maximal abelian exponent-\(N\) covers.
Ordinarity of its smooth fibers is an open condition, by the
Frobenius determinant.

The property is independent of the auxiliary choices: geometrically
the maximal cover is the same, and Section 1 identifies its
ordinarity with the intrinsic condition on all abelian exponent-\(N\)
covers. Thus these opens descend to a Zariski-open
\(\mathcal U_{g,N}\) on \(\mathcal H_g\).
Equivalently, the bad loci on a finite étale level chart are closed
and have closed image under its finite map.
The degeneration above shows that this open is nonempty.

Since the hyperelliptic moduli space is irreducible of dimension
\(2g-1\), the open has that dimension. It is a finite-type geometric
open, so over \(\overline{\mathbf F}_p\) it contains closed moduli
points defined over finite fields. Removing finitely many geometric
isomorphism classes leaves a nonempty open. After a finite extension
of their residue fields, those points are represented by actual
curves. This proves the final assertions of the theorem.

## Boundaries of the conclusion

- The exponent \(N\) is fixed in advance. Finitely many requested
  exponents can be combined by taking their least common multiple.
- The theorem does not produce a single
  \(\overline{\mathbf F}_p\)-curve for which every prime-to-\(p\)
  exponent works simultaneously.
- It does not cover arbitrary nonabelian étale covers or covers of
  \(p\)-divisible degree.
- It gives no ordinarity certificate for the fixed curve of file 76
  and makes no claim excluding coreless bi-étale correspondences.
- It needs neither absolute simplicity of the auxiliary Jacobian
  nor a Frobenius scalar condition.
