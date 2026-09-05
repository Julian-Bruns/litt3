# Nonabelian packet and Schur-index domination bound

**Status: proved; independently audited PASS, 2026-09-04. The target
arithmetic input for its concrete application has also been checked.**

[Combined audit, with auditor and nonbreaking suggestions](audits/95_96_98_ALL_DEGREE_PACKET_CHAIN_AUDIT.md).
[Target arithmetic audit](audits/76_GENUS25_Y_ARITHMETIC_AND_SIGNED_RATIO_AUDIT.md).

File 95 excludes every abelian Galois cover of the first curve from
dominating the current genus-25 curve.  This note isolates the exact extra
factor for an arbitrary finite deck group.  It is the degree of one complex
irreducible representation, divided by its Schur index after adjoining the
endomorphism field of the target Jacobian.

The result is valid even when the characteristic divides the deck-group
order.  The map to the second curve need not be etale, Galois, or separable.

All curves below are smooth, projective, and geometrically connected over an
algebraically closed field \(k\).  Endomorphisms and simplicity are geometric.

## 1. Representation descent over an endomorphism field

Let \(H\) be a finite group and let \(\chi\) be a complex irreducible
character of \(H\).  Put

\[
             d=\chi(1),\qquad F=\mathbf Q(\chi).
\]

The field \(F\) is an abelian Galois extension of \(\mathbf Q\): all character
values lie in a cyclotomic field, whose Galois group is abelian.

Fix a number field \(K\subset\mathbf C\), put \(E=F\cap K\) and \(L=FK\),
and let

\[
                         e_K(\chi)
\]

be the Schur index of \(\chi\) over \(L\).  Thus the simple component of
\(L[H]\) belonging to \(\chi\) is a matrix algebra over a central division
algebra of degree \(e_K(\chi)\) over \(L\).  This convention accounts for
the possibility that extending scalars from \(F\) to \(L\) splits some or
all of the original Schur division algebra.

### Lemma 96.1 (exact descent dimension)

Let \(U\) be a finite-dimensional \(K\)-representation of \(H\).  Suppose
that \(U\otimes_{K}\mathbf C\) contains \(\chi\).  Then

\[
 \dim_K U\ \ge\ d\,e_K(\chi)[F:E].                     \tag{96.1}
\]

If \(U\) is irreducible and belongs to the \(K\)-simple component containing
\(\chi\), equality holds.

#### Proof

Because \(F/\mathbf Q\) is Galois,

\[
                         [L:K]=[F:E].                  \tag{96.2}
\]

The relevant simple component of \(K[H]\) has center \(L\).  Over \(L\) it
has the form

\[
                         M_{d/e}(\Delta),
       \qquad e=e_K(\chi),\quad [\Delta:L]=e^2.
\]

A simple module for this algebra has \(L\)-dimension

\[
                  {d\over e}\,[\Delta:L]=de,
\]

and hence \(K\)-dimension \(de[L:K]=de[F:E]\).  Every semisimple
\(K[H]\)-module containing \(\chi\) contains at least one such simple module.
This proves (96.1) and the equality statement. \(\square\)

Equivalently, after scalar extension to \(\mathbf C\), all
\([F:E]\) conjugates of \(\chi\) over \(E\) occur, each with multiplicity
divisible by \(e_K(\chi)\).  This is the character-theoretic form of the
same argument.

## 2. The arbitrary finite-group bound

### Theorem 96.2 (packet domination inequality)

Let

\[
                       q:D\longrightarrow X
\]

be a connected finite etale Galois cover with arbitrary finite deck group
\(H\).  Assume \(g(X)\ge2\), and set

\[
                  s=g(X)-1,\qquad A=J(Y),\qquad g=g(Y).
\]

Assume that \(A\) is simple and

\[
                       \operatorname{End}^0_k(A)=K
                                                               \tag{96.3}
\]

is a number field.  If there is a nonconstant morphism \(f:D\to Y\), then
one of the following holds:

1. \(g(Y)\le g(X)\); or
2. there is a nontrivial complex irreducible character \(\chi\) of \(H\)
   such that, for a compatible embedding \(K\subset\mathbf C\),
   
   \[
       g(Y)\le
       (g(X)-1)[\mathbf Q(\chi)\cap K:\mathbf Q]
       {\chi(1)\over e_K(\chi)}.                       \tag{96.4}
   \]

No tameness hypothesis on \(H\) is present in this theorem.

#### Proof

Choose a prime \(\ell\ne\operatorname{char}k\).  The free-action character
calculation of Lemma 95.2 gives

\[
 H^1_{\rm et}(D,\mathbf Q_\ell)
       \simeq \mathbf Q_\ell^{\oplus2}
            \oplus \mathbf Q_\ell[H]^{\oplus 2s}.      \tag{96.5}
\]

For clarity, this does not use tame Chevalley--Weil.  If \(h\ne1\), its
graph is disjoint from the diagonal because \(H\) acts freely.  The etale
Lefschetz formula gives trace \(2\) on \(H^1\); at the identity, etale
Riemann--Hurwitz gives \(2g(D)=2+2|H|s\).  These are exactly the character
values in (96.5), including when
\(\operatorname{char}k\mid |H|\).  The fixed-point formula used here is
Milne,
[Lectures on Etale Cohomology, Theorem 25.1](https://www.jmilne.org/math/CourseNotes/LEC.pdf),
pp. 147--148.

Let \(W\) be a nontrivial rational irreducible packet of \(H\), represented
by a complex irreducible character \(\chi\).  Write

\[
             d=\chi(1),\qquad F=\mathbf Q(\chi),
\]

and let \(P_W\subset J(D)\) be the image, up to isogeny, of the corresponding
rational central idempotent in \(\mathbf Q[H]\).  There are
\([F:\mathbf Q]\) Galois conjugates of \(\chi\).  Each has multiplicity
\(2sd\) in (96.5).
Consequently

\[
                \dim P_W=s[F:\mathbf Q]d^2.             \tag{96.6}
\]

This computation is independent of the rational Schur index: a rational
simple module contains every Galois conjugate with that index, while its
multiplicity in (96.5) is divided by the same index.  Formula (96.6) is
therefore the exact rational-packet dimension.

The norm-pullback identity

\[
                             f_*f^*=[\deg f]
\]

shows that \(f^*:A\to J(D)\) has finite kernel.  This remains true when
\(f\) is inseparable.  Decompose \(J(D)\), up to isogeny, by the rational
central idempotents of \(\mathbf Q[H]\).  Its trivial packet is isogenous to
\(J(X)\).  If the projection of \(f^*A\) to that packet is nonzero, simplicity
of \(A\) makes \(A\) an isogeny factor of \(J(X)\), and hence
\(g(Y)\le g(X)\).

Assume this does not happen.  Some nontrivial packet \(P_W\) has nonzero
projection from \(A\).  Since \(A\) is simple, it is an isogeny factor of
\(P_W\).  Let the full \(A\)-isotypic part of \(P_W\) be

\[
                              A^m,
\]

up to isogeny.  It is preserved by \(H\): every \(h\in H\) sends a simple
factor isogenous to \(A\) to another such factor.  After choosing an
isogeny, the \(H\)-action therefore gives a \(K\)-linear representation

\[
                         H\longrightarrow
                         \operatorname{GL}_m(K),         \tag{96.7}
\]

because \(\operatorname{End}^0(A^m)=M_m(K)\).

Every complex constituent of (96.7) belongs to the rational packet \(W\).
Indeed, after extending scalars, the faithful action of
\(K\otimes\mathbf Q_\ell\) decomposes the Tate module of \(A^m\) into
nonzero summands obtained from (96.7) through embeddings of \(K\).  These
are \(H\)-subrepresentations of the \(W\)-part of (96.5).  Choose one
constituent \(\chi\) and embed \(K\) and its character field \(F\)
compatibly in \(\mathbf C\).  Lemma 96.1 gives

\[
                  m\ge d e_K(\chi)[F:F\cap K].          \tag{96.8}
\]

On the other hand, (96.6) gives the geometric dimension bound

\[
                mg\le \dim P_W=s[F:\mathbf Q]d^2.       \tag{96.9}
\]

Combining (96.8)--(96.9), and using
\([F:\mathbf Q]=[F:F\cap K][F\cap K:\mathbf Q]\), gives

\[
 g\,d e_K(\chi)[F:F\cap K]
       \le s[F:\mathbf Q]d^2,
\]

which is precisely (96.4). \(\square\)

## 3. Uniform forms

Put

\[
 K_{\rm ab}=K\cap\mathbf Q^{\rm ab},\qquad
 a_0=[K_{\rm ab}:\mathbf Q],
\]

inside a fixed algebraic closure.  For a finite group \(H\), define

\[
 b_K(H)=\max_{\chi\ne\mathbf1}{\chi(1)\over e_K(\chi)},
 \qquad
 b(H)=\max_{\chi\ne\mathbf1}\chi(1).                  \tag{96.10}
\]

### Corollary 96.3 (bounded character degree)

Under the hypotheses of Theorem 96.2, no connected finite etale Galois
\(H\)-cover of \(X\) admits a nonconstant map to \(Y\) if

\[
 g(Y)>\max\{g(X),\ a_0(g(X)-1)b_K(H)\}.                \tag{96.11}
\]

It is enough to replace \(b_K(H)\) in (96.11) by the larger and purely
group-theoretic number \(b(H)\).

#### Proof

The character field \(F\) is abelian, so
\(F\cap K\subseteq K_{\rm ab}\).  Thus (96.4) implies

\[
                    g(Y)\le a_0(g(X)-1)b_K(H).
\]

Theorem 96.2 gives the result. \(\square\)

### Corollary 96.4 (a bounded-index abelian subgroup)

Suppose \(H\) has an abelian subgroup \(B\) of index at most \(b\).  Then
no \(H\)-Galois etale cover of \(X\) dominates \(Y\) whenever

\[
                g(Y)>\max\{g(X),\ a_0b(g(X)-1)\}.       \tag{96.12}
\]

This conclusion is uniform in \(|H|\).

#### Proof

Every complex irreducible character \(\chi\) of \(H\) has degree at most
\([H:B]\).  Indeed, choose a linear constituent \(\lambda\) of
\(\chi|_B\).  Frobenius reciprocity puts \(\chi\) inside
\(\operatorname{Ind}_B^H\lambda\), whose degree is \([H:B]\).  Therefore
\(b(H)\le b\), and Corollary 96.3 applies. \(\square\)

## 4. The current genus-nine/genus-25 pair

Let \(X,Y/\overline{\mathbf F}_5\) be the curves of file
[76](76_EXPLICIT_BRANCH_RATIONAL_R3_REDESIGN.md).  Thus

\[
                           g(X)=9,\qquad g(Y)=25.
\]

File [95](95_ABELIAN_ETALE_TOWERS_AND_ENDOMORPHISM_FIELDS.md) proves that

\[
 K=\operatorname{End}^0 J(Y)
\]

is a degree-50 CM field and that every abelian subfield of \(K\) has degree
at most two.  Hence \(a_0\le2\).

### Corollary 96.5 (the exact surviving representation threshold)

If a connected finite etale Galois \(H\)-cover \(D\to X\) admits a
nonconstant map \(D\to Y\), then \(H\) has a nontrivial complex irreducible
character \(\chi\) satisfying

\[
                25\le16\,{\chi(1)\over e_K(\chi)}.     \tag{96.13}
\]

In particular:

- the abelian case is impossible, recovering Corollary 95.6;
- a degree-two constituent can survive only if its Schur index over
  \(K\mathbf Q(\chi)\) is one; and
- more generally, all deck groups for which
  \(\chi(1)/e_K(\chi)<25/16\) for every nontrivial \(\chi\) are excluded,
  regardless of their order.

#### Proof

Here \(s=8\), \(g(Y)>g(X)\), and
\([\mathbf Q(\chi)\cap K:\mathbf Q]\le2\).  Substitute these values in
(96.4). \(\square\)

### Corollary 96.6 (a genuine nonabelian range for the fixed target)

Keep the fixed genus-25 curve \(Y\), but let \(X_0\) be any curve of genus
three.  If a finite group \(H\) has an abelian subgroup of index at most
six, then no connected finite etale Galois \(H\)-cover of \(X_0\) admits a
nonconstant map to \(Y\).

More generally, for any \(g(X_0)\ge2\), the same conclusion holds for
groups with an abelian subgroup of index \(b\) whenever

\[
                           25>2b(g(X_0)-1).             \tag{96.14}
\]

The order of \(H\) is unrestricted.

#### Proof

Apply Corollary 96.4 with \(a_0\le2\).  For \(g(X_0)=3\) and \(b=6\),
the right side is \(2\cdot6\cdot2=24<25\); also \(25>3\). \(\square\)

## 5. Scope

Theorem 96.2 turns arbitrary nonabelian monodromy into one explicit finite
group invariant.  Unlike a degree-by-degree cover search, it is uniform in
the order of \(H\), and Corollary 96.4 applies to infinite classes of
nonabelian groups of bounded abelian index.

For the current pair, (96.13) is a necessary condition, not a complete
exclusion of nonabelian monodromy.  Groups with a sufficiently large
split-character constituent remain possible.  An arbitrary common cover
may therefore still have a nonabelian Galois closure over \(X\); this note
does not solve that remaining case.

Nor can one expect a hypothesis-free exclusion of all finite \(H\).  In
characteristic at least five, Bogomolov--Tschinkel prove that every
hyperelliptic curve \(X\) of genus at least two is *universal*: some finite
etale cover of \(X\) dominates any prescribed curve \(Y\).  Taking a Galois
closure still gives a finite etale Galois cover over \(X\), while the map to
\(Y\) is allowed to ramify.  See their Theorem 1.7 in
[*Unramified correspondences*](https://arxiv.org/abs/math/0202223).
Thus the force in Theorem 96.2 comes from the packet inequality, not from
hyperellipticity alone.
