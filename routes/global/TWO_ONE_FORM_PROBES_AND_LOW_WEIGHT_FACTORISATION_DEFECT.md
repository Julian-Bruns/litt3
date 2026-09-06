# Two one-form probes and low-weight factorisation defect

Date: 2026-09-05. Author: root. Status: author proof, not independently
audited. This strengthens the probe weights in the new cross-normalizer
theorem without changing its unresolved descent hypothesis.

Work over \(k=\overline{\mathbf F}_5\). Let
\[
                  X\stackrel f\longleftarrow Z
                            \stackrel g\longrightarrow Y
\]
be actual finite etale maps between smooth projective connected curves
of genus at least two. Inside the canonical Poisson ring \(S=R(Z)\),
put \(A=f^*R(X)\) and \(B=g^*R(Y)\). All memberships below refer to
these actual subspaces, not to abstractly isomorphic rings.

## 1. Two ordinary one-forms always provide nonzero bracket

There exist \(\beta,\gamma\in B_1\) with \(\{\beta,\gamma\}\ne0\).
Indeed, the canonical morphism of \(Y\) is separable onto its image:
it is an embedding if \(Y\) is nonhyperelliptic, and in the
hyperelliptic case it factors as a separable degree-two map followed
by the rational normal embedding. Characteristic five is important
for the latter separability statement.

Consequently not all ratios of one-forms have zero differential.
Choose \(\beta,\gamma\) with \(d(\beta/\gamma)\ne0\). The canonical
bracket formula gives their nonzero bracket. The same remains true
after the etale pullback to \(Z\).

The canonical-morphism and generation statements are the classical
arbitrary-characteristic results recorded in
[Voight--Zureick-Brown, Chapter 2](https://jvoight.github.io/articles/stacky-canonical-rings-final-fixederrata.pdf);
see also [the local generation note](CANONICAL_RING_GENERATORS_DO_NOT_DETERMINE_TRACE_REALIZATIONS.md).

## 2. Fixed probes detect the exact descent defect

For a positive integer \(m\) not divisible by five, define
\[
 \mathcal D_m:A_m\longrightarrow
      (S_{m+2}/B_{m+2})\oplus(S_{m+2}/B_{m+2}),\qquad
 \alpha\longmapsto
       \bigl([\{\alpha,\beta\}],[\{\alpha,\gamma\}]\bigr).
                                                               \tag{1}
\]

**Theorem 1.** One has
\[
                  \ker\mathcal D_m=A_m\cap B_m.         \tag{2}
\]
In particular the rank is
\[
          \operatorname{rank}\mathcal D_m
                 =\dim A_m-\dim(A_m\cap B_m).           \tag{3}
\]

**Proof.** The homogeneous reconstruction identity, specialized to
two probes of weight one, is
\[
 m\alpha\{\beta,\gamma\}
      =\beta\{\alpha,\gamma\}
                          -\gamma\{\alpha,\beta\}.      \tag{4}
\]
This follows directly from the local bracket formula; the terms
containing the derivative of \(\alpha\) cancel.
If (1) vanishes, (4) places \(\alpha\) in \(\operatorname{Frac}(B)\).
The ring \(S\) is finite over the normal canonical ring \(B\), so
its element \(\alpha\) is integral over \(B\); thus \(\alpha\in B_m\).
One can equally descend its regularity along the surjective etale
map \(g\). Conversely, if \(\alpha\in B_m\), internal Poisson closure
puts both brackets in \(B_{m+2}\). This proves (2),(3). \(\square\)

If the span is coreless, each common homogeneous component has
dimension at most one, since the ratio of two nonzero elements
would lie in \(k(X)\cap k(Y)=k\). Hence
\[
                  \operatorname{rank}\mathcal D_m
                               \ge h^0(X,\omega_X^m)-1.
                                                               \tag{5}
\]
More exactly, when the intersection is \(k[s]\) with
\(\deg s=d>0\), this rank is \(h^0(X,\omega_X^m)-1\) if \(d\mid m\),
and \(h^0(X,\omega_X^m)\) otherwise. If the intersection is \(k\),
the latter value holds for every positive \(m\) prime to five.

## 3. Degree-five test for every target, degree-three test in the
nonhyperelliptic case

**Corollary 2.** Choose homogeneous algebra generators of \(A\),
in weights at most three. The following are equivalent:

- \(f\) factors through \(g\) by a finite etale map \(Y\to X\);
- \(\mathcal D_m\) vanishes on each chosen generator of weight \(m\).

All required mixed brackets have weights at most five. If \(X\) is
nonhyperelliptic, choose a basis of \(A_1\), which generates \(A\).
Then just \(2g(X)\) cubic-bracket membership tests suffice.

**Proof.** All generator weights are prime to five, so Theorem 1
puts them in \(B\) exactly under the stated tests. Thus the tests
are equivalent to \(A\subseteq B\). Canonical Poisson reconstruction
then gives the factor map \(Y\to X\); because both original maps
are etale, so is that factor map. The converse is pullback and
internal bracket closure. The sharper generator statement for
nonhyperelliptic curves is Max Noether's theorem. \(\square\)

This is a cover-degree-independent test. Its application is still
conditional: two actual maps need not pass it.

If \(\operatorname{Hom}(J(X),J(Y))=0\), they cannot pass it, because
a nonconstant map \(Y\to X\) would induce a nonzero Jacobian
homomorphism. Thus (1) supplies explicit witnesses of failure of
factorisation; it does not contradict a non-factoring common cover.

## 4. Trace vanishing is weaker, with an exact comparison

Suppose \(\operatorname{Hom}(J(X),J(Y))=0\). The correspondence action
on one-forms is then zero:
\[
                 \operatorname{Tr}_g(\alpha)=0
                              \quad(\alpha\in A_1).
                                                               \tag{6}
\]
Indeed it is the cotangent action of the zero Jacobian
correspondence, with pullback and trace in the indicated direction.
Etale trace commutes with a Hamiltonian from \(B\), so
\[
 \operatorname{Tr}_g\{\alpha,\beta\}
   =\{\operatorname{Tr}_g\alpha,\beta\}=0,\qquad
 \operatorname{Tr}_g\{\alpha,\gamma\}=0.                 \tag{7}
\]
Thus the cubic defects can be represented by trace-zero sections.
Equations (7) do not say that the sections belong to \(B_3\).

If \(5\nmid\deg g\), the trace-zero subspace and \(B_3\) intersect
trivially. Moreover \(A_1\cap B_1=0\): for a common form
\(\alpha=g^*\delta\), (6) gives \((\deg g)\delta=0\).
Consequently \(\mathcal D_1\) has rank exactly \(g(X)\), and every
nonzero source one-form has a nonzero, genuinely non-descending
cross-bracket with at least one of the two probes.

The same conclusion \(A_1\cap B_1=0\) holds if \(5\nmid\deg f\),
using trace on the opposite leg. If both degrees are divisible by
five, this argument does not supply that intersection vanishing.

These rank assertions show why trace compatibility alone cannot
force the factorisation needed for a contradiction. They do not
bound the dimension of the ambient trace-zero spaces uniformly.

## 5. Why one probe is not an individual descent test

The use of two probes is substantive. Let \(Y\) be any curve of
genus at least two, and choose a nontrivial order-three line bundle
\(L\) on \(Y\). Let \(g:Z\to Y\) be its connected cyclic etale
trivializing cover. Riemann--Roch gives a nonzero
\(\sigma\in H^0(Y,\omega_Y\otimes L)\), since this space has
dimension \(g(Y)-1\). Its pullback, under the torsor trivialization,
is a nonzero one-form \(\alpha\) on \(Z\) with a nontrivial deck
character. In particular \(\alpha\notin B_1\).

But \(\beta=\alpha^3\) belongs to \(B_3\), and
\[
                         \{\alpha,\beta\}=0.
 \]
So one nonzero probe can entirely miss an individual non-descending
one-form on an actual finite etale cover. No second leg to a
prescribed curve is claimed by this example.

## 6. Strategic consequence

The two-probe criterion turns all-degree factorisation into low-weight
mixed-bracket containment without any degree bound or Galois
assumption. The independent structural target is now to control
these mixed terms using the specific two endpoint curves.

The known hypotheses instead already force nonzero defects in many
cases. No theorem here forces the needed containments. One must not
promote a finite test for factorisation into a theorem that every
common cover factors.
