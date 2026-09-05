# Arbitrary abelian deck rigidity over a rigid simple-Jacobian curve

## Status and purpose

**Status: proved; independently checked (PASS, 2026-09-04).**

[Audit record](audits/91_ARBITRARY_ABELIAN_DECK_RIGIDITY_AUDIT.md).

This note removes the prime-power restriction from Theorem 87.3.  If a
curve \(X\) has simple Jacobian and no automorphisms, then an etale Galois
cover of \(X\) with **any finite abelian deck group** has no additional
automorphisms.  The argument does not try to make the abelian group a Hall
or Sylow subgroup.  Instead it passes to a minimal overgroup and uses the
Frobenius-kernel theorem in a primitive coset action.

The result holds in every characteristic, including when the deck-group
order is divisible by the characteristic.

## 1. The minimal-overgroup theorem

### Theorem 91.1 (arbitrary abelian deck rigidity)

Let \(k\) be algebraically closed, let \(X/k\) be a smooth projective
curve of genus at least two with simple Jacobian, and let
\(D\to X\) be a connected finite etale Galois cover with finite abelian
deck group \(H\).  Put \(A=\operatorname{Aut}_k(D)\).  If

\[
                              N_A(H)=H,                              \tag{91.1}
\]

then

\[
                         \operatorname{Aut}_k(D)=H.                  \tag{91.2}
\]

In particular, (91.1), and hence the conclusion, holds whenever
\(\operatorname{Aut}_k(X)=1\).

#### Proof

The assertion is immediate when \(H=1\), so suppose \(H\ne1\).  The group
\(A\) is finite because \(g(D)\ge2\).  Notice also that an element
normalizing \(H\) descends to \(X=D/H\), with kernel \(H\).  Thus

\[
                    N_A(H)/H\hookrightarrow\operatorname{Aut}_k(X), \tag{91.3}
\]

which proves the last sentence of the theorem when
\(\operatorname{Aut}_k(X)=1\).

Suppose for contradiction that \(A>H\), and choose a subgroup \(M\le A\)
minimal subject to \(H<M\).  Hence \(H\) is maximal in \(M\), while
(91.1) gives \(N_M(H)=H\).

There is a finite separable map of degree greater than one

\[
                         X=D/H\longrightarrow D/M.                  \tag{91.4}
\]

If \(g(D/M)>0\), pullback gives a nonzero abelian subvariety of the simple
\(J(X)\), so it must fill \(J(X)\).  Riemann--Hurwitz then contradicts
the degree of (91.4), exactly as in Lemma 87.2.  Therefore

\[
                              D/M\simeq\mathbf P^1.                  \tag{91.5}
\]

Let

\[
              N=\operatorname{Core}_M(H),\qquad
              G=M/N,\qquad B=H/N.                                  \tag{91.6}
\]

The coset action of \(G\) on \(G/B\) is faithful and primitive.  Its point
stabilizer \(B\) is abelian and self-normalizing: an element normalizing
\(H/N\) lifts to an element \(m\in M\) with \(mHm^{-1}N=H\), hence
\(mHm^{-1}=H\) and \(m\in N_M(H)=H\).  It is nontrivial: if
\(B=1\), then \(H=N\triangleleft M\), contradicting \(N_M(H)=H<M\).

We claim that this primitive action is Frobenius.  If \(g\notin B\) and
\(1\ne c\in B\cap B^g\), abelianness gives

\[
                         \langle B,B^g\rangle\le C_G(c).             \tag{91.7}
\]

The left side strictly contains the maximal subgroup \(B\), so it is all
of \(G\).  Thus \(c\in Z(G)\).  But a central element that fixes one point
in a faithful transitive action fixes every point, and hence is the
identity, a contradiction.  Consequently

\[
                         B\cap B^g=1\quad(g\notin B),                 \tag{91.8}
\]

which is the Frobenius condition.

By the classical Frobenius-kernel theorem, the identity together with all
derangements in this action is a proper normal subgroup \(K\triangleleft G\),
and

\[
                              G=K\rtimes B.                           \tag{91.9}
\]

Let \(\widetilde K\) be the inverse image of \(K\) in \(M\).  We next show
that every point stabilizer for the action of \(M\) on \(D\) is contained
in \(\widetilde K\).

Indeed, \(N\subseteq H\) acts freely on \(D\).  Hence the map from any point
stabilizer \(M_z\) to \(G=M/N\) is injective.  If the image of a nonidentity
\(s\in M_z\) fixed a coset \(\bar mB\), for \(m\in M\), then

\[
                              s\in mHm^{-1}.                          \tag{91.10}
\]

Every conjugate of \(H\) acts freely on \(D\), so (91.10) contradicts
\(s(z)=z\).  Thus every nonidentity element in the image of \(M_z\) is a
derangement.  Frobenius' theorem places all of them in \(K\), proving
\(M_z\le\widetilde K\).

It follows that the residual quotient

\[
                  D/\widetilde K\longrightarrow D/M\simeq\mathbf P^1
                                                                         \tag{91.11}
\]

has trivial inertia at every point.  It is therefore a connected finite
etale cover, while (91.9) gives its nontrivial deck group

\[
                         M/\widetilde K\simeq B\ne1.
\]

This contradicts the triviality of the geometric etale fundamental group
of the projective line.  Hence \(A=H\), proving (91.2). \(\square\)

### External group-theoretic input

The only external group theorem used above is Frobenius' theorem that, in
a finite Frobenius permutation group, the identity and the derangements
form a normal subgroup.  A concise exact statement is given at the start of
Paul Flavell, *A Note on Frobenius Groups*, J. Algebra **228** (2000),
367--376
([author PDF](https://web.mat.bham.ac.uk/P.J.Flavell/research/publications/frobenius.pdf)).
The original theorem is due to Frobenius (1901).  No nilpotence theorem for
the Frobenius kernel and no classification of finite groups is used here.

## 2. Consequences for common covers

### Corollary 91.2 (equal-genus Galois uniqueness)

Under the hypotheses of Theorem 91.1, suppose that \(D\to X\) has finite
abelian deck group and that \(D\to Y\) is any connected finite etale
Galois cover, where \(g(Y)=g(X)\).  Then \(Y\simeq X\), and the two deck
groups in \(\operatorname{Aut}(D)\) are equal.

#### Proof

Theorem 91.1 identifies \(\operatorname{Aut}(D)\) with the deck group
\(H\) over \(X\).  Thus the deck group \(H_Y\) over \(Y\) is a subgroup of
\(H\).  The etale genus formulas and \(g(Y)=g(X)\ge2\) give

\[
 |H|(g(X)-1)=g(D)-1=|H_Y|(g(Y)-1),
\]

so \(|H_Y|=|H|\), hence \(H_Y=H\) and \(Y=D/H_Y=D/H=X\). \(\square\)

### Corollary 91.3 (simple-Jacobian Galois uniqueness)

Under the hypotheses of Theorem 91.1, let \(Y/k\) be any smooth
projective curve of genus at least two with simple Jacobian.  Suppose that
\(D\to X\) is finite etale Galois with abelian deck group and that
\(D\to Y\) is any finite etale Galois map.  Then

\[
                              Y\simeq X,
\]

and the two deck groups in \(\operatorname{Aut}(D)\) are equal.

#### Proof

As in Corollary 91.2, Theorem 91.1 gives
\(\operatorname{Aut}(D)=H\), where \(H\) is the deck group over \(X\), and
the deck group \(H_Y\) over \(Y\) satisfies \(H_Y\le H\).  Since \(H\) is
abelian, this inclusion produces a finite etale map

\[
                         Y=D/H_Y\longrightarrow D/H=X.              \tag{91.12}
\]

If its degree were greater than one, pullback \(J(X)\to J(Y)\) would have
nonzero abelian-subvariety image.  Simplicity of \(J(Y)\) would force it to
fill \(J(Y)\), while Riemann--Hurwitz would then contradict the degree,
as in Lemma 87.2.  Thus (91.12) has degree one,
\(H_Y=H\), and \(Y\simeq X\). \(\square\)

### Corollary 91.4 (no Galois common cover with a hyperelliptic curve)

Assume in addition that \(\operatorname{char}k\ne2\), and let \(Y/k\) be
hyperelliptic of genus at least two.  There is no smooth connected curve
\(D\) with finite etale Galois maps

\[
                         D\longrightarrow X,
                 \qquad D\longrightarrow Y                           \tag{91.13}
\]

if the deck group over \(X\) is finite abelian.  No hypothesis on the
second deck group is needed.

#### Proof

Theorem 91.1 makes \(\operatorname{Aut}(D)\) equal to the abelian deck
group over \(X\).  Hence the deck group of \(D\to Y\), being a subgroup of
\(\operatorname{Aut}(D)\), is automatically abelian.

Choose a Weierstrass point of \(Y\).  The hyperelliptic involution acts by
inversion on the full abelianized etale fundamental group based there.
It therefore preserves the kernel defining the abelian cover \(D\to Y\)
and has a nontrivial lift fixing a chosen point above the Weierstrass point.
This contradicts (91.2), because every nonidentity element of the etale
deck group over \(X\) acts freely. \(\square\)

### Remark 91.5 (precise boundary)

The theorem controls abelian Galois presentations in arbitrary composite
degree.  It does not address a non-Galois cover of \(X\), nor a Galois
cover whose deck group is nonabelian.  Corollary 91.4 likewise requires
both maps in (91.13) to be Galois; abelianness of the second deck group is
then a conclusion, not an assumption.

The naive Sylow or normal-complement approach genuinely has less scope.
Here is a purely group-theoretic warning.  Let \(V=\mathbf F_5^2\) carry
the irreducible two-dimensional reflection representation of \(S_3\), put

\[
                         A=V\rtimes S_3,
\]

and, for a transposition \(t\), let \(L\subset V\) be its \(+1\)-eigenline.
Then

\[
                         H=L\times\langle t\rangle\simeq C_{10}
\]

is abelian, core-free, and self-normalizing in \(A\).  Indeed, projection
to \(S_3\) puts a normalizing element over
\(N_{S_3}(\langle t\rangle)=\langle t\rangle\), while the translation part
must lie in \(L\) by the \(+1/-1\) eigenspace decomposition.

Nevertheless \(H\) has no normal complement.  Such a complement would have
order \(15\); its unique Sylow-five subgroup would be characteristic in the
complement, hence normal in \(A\), and would give an \(S_3\)-invariant line
in the irreducible \(V\), a contradiction.  The minimal-overgroup/Frobenius
argument in Theorem 91.1 is therefore doing essential work rather than
hiding a general transfer theorem.
