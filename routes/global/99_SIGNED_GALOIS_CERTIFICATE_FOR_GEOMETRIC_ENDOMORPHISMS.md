# A signed Galois certificate for geometric endomorphisms

**Status: proved; independently audited PASS, 2026-09-04.**

[Audit of the root-ratio argument and the genus-25 arithmetic input](audits/76_GENUS25_Y_ARITHMETIC_AND_SIGNED_RATIO_AUDIT.md).

This gives a parameterized replacement for the absolute-simplicity input
used in the current application of files 95--98. It does not assume
ordinarity, and does not use a separate absolute-simplicity criterion.

## 1. Full reciprocal Galois group prevents torsion ratios

### Theorem 99.1

Let \(A/\mathbf F_q\) be an abelian variety of dimension \(n\ge3\).
Suppose its Frobenius polynomial \(P(T)\) has \(2n\) distinct roots,
partitioned into reciprocal pairs \(\{\alpha_i,q/\alpha_i\}\), and
its splitting-field Galois group in this action is

\[
                         W_n=(C_2)^n\rtimes S_n.
\]

Then:

1. the ratio of any two distinct roots of \(P\) is not a root of unity;
2. \(A\) is absolutely simple;
3. \(\operatorname{End}^0_{\overline{\mathbf F}_q}(A)=K=\mathbf Q(\pi)\),
   a field of degree \(2n\), where \(\pi\) is Frobenius; and
4. \(K\cap\mathbf Q^{\rm ab}=\mathbf Q\).

#### Proof

Suppose first that \(\alpha/\beta\) is a root of unity for distinct
roots in the same reciprocal pair. Then \(\alpha^2/q\) is a root of
unity.

If instead \(\alpha\) and \(\beta\) belong to distinct reciprocal
pairs, the full signed group contains an automorphism \(\tau\) that
switches only the pair containing \(\alpha\). It fixes \(\beta\).
Writing \(\zeta=\alpha/\beta\), we obtain

\[
                    \frac{\zeta}{\tau(\zeta)}
                         =\frac{\alpha^2}{q}.
\]

Again \(\alpha^2/q\) is a root of unity.

In either case, transitivity of \(W_n\) makes \(\gamma^2/q\) a root
of unity for every root \(\gamma\) of \(P\). Therefore all roots
lie in \(\sqrt q\,\mu_N\) for some positive integer \(N\).
The splitting field is contained in
\(\mathbf Q(\sqrt q,\mu_N)\), an abelian extension of
\(\mathbf Q\). This contradicts the nonabelian group \(W_n\).
This proves (1).

For each \(m\ge1\), Frobenius over \(\mathbf F_{q^m}\) has
characteristic polynomial

\[
                        P_m(T)=\prod_{P(\gamma)=0}(T-\gamma^m).
\]

Its roots remain distinct by (1), and the splitting-field Galois
group acts transitively on them. Hence \(P_m\) is irreducible over
\(\mathbf Q\), of degree \(2n\). In particular, \(A\) remains
simple over every finite extension, and is absolutely simple.

For a simple abelian variety over a finite field, the characteristic
polynomial is a power of the minimal polynomial of Frobenius; the
exponent is the degree of its endomorphism division algebra over its
center. Here that exponent is one for every \(m\). Thus

\[
           \operatorname{End}^0_{\mathbf F_{q^m}}(A)
                    =\mathbf Q(\pi^m)=\mathbf Q(\pi)=K.
\]

The middle equality follows from the full degree \(2n\). Every
geometric endomorphism is defined over a finite extension, proving (3).

Finally, the subgroup fixing \(\pi\) is a signed-letter stabilizer
in \(W_n\). Lemma 98.2 proves that its fixed field \(K\) has no
nontrivial abelian subfield. This gives (4). \(\square\)

## 2. Consequence for arbitrary covering degrees

### Corollary 99.2

Suppose \(Y/\mathbf F_q\) has genus \(n\ge3\) and its Jacobian
Frobenius polynomial satisfies Theorem 99.1. Let \(X\) be any curve
over \(\overline{\mathbf F}_q\) with \(2\le g(X)<n\).

If an etale cover of \(X\) admits a nonconstant map to \(Y\), then
the monodromy group of that cover has an irreducible complex character
of degree at least

\[
                          \left\lceil\frac{n}{g(X)-1}\right\rceil.
\]

More precisely, the Schur-index version of (98.7) holds. In particular,
no abelian monodromy is possible.

#### Proof

Apply Theorem 99.1 and Theorem 96.2 after taking the Galois closure of
the etale cover over \(X\). This closure remains etale over the
original source; its composite map to \(Y\) exists, whether or not
that map is etale. \(\square\)

## 3. The current arithmetic dependency is now checked

The linked independent audit reran the genus-25 part of file 76 in
Sage 10.9. It checked the curve equation, smoothness, genus, splitting
of all finite hyperelliptic branch points over \(\mathbf F_{125}\),
and equality of the computed Frobenius polynomial with the displayed
\(T^{25}Q_Y(T+5/T)\). It also reran the short signed-group certificate
in file 98.

Thus the geometric endomorphism-field and absolute-simplicity inputs
for the genus-25 target are independently checked. The audit did not
cover the genus-nine curve or its separate number-field computations;
the new results above do not require those inputs.
