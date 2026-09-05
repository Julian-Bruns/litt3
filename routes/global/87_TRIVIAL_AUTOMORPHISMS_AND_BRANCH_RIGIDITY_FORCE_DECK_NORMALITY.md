# Trivial automorphisms and branch rigidity force deck normality

## Status and purpose

**Status: proved; independently audited (PASS after proof simplification,
2026-09-04).**

[Audit record](audits/ODD_PRIME_DECK_NORMALITY_UNDER_RIGID_BRANCH_AUDIT.md).

This note gives two degree-independent deck-rigidity theorems and a
common-cover consequence.

The first is the strongest and cleanest.  If \(J(X)\) is simple and
\(\operatorname{Aut}(X)=1\), then every connected etale Galois cover of
\(X\) with abelian \(\ell\)-group deck group has no automorphisms beyond
its deck group.  This holds in every characteristic, including
\(\ell=\operatorname{char}k\), and in arbitrarily large abelian
\(\ell\)-power degree.

The second treats a base curve with
\(\operatorname{Aut}(X)=C_\ell\).  For a cyclic degree-\(\ell\) etale
cover, rigidity of the branch set of
\(X\to X/\operatorname{Aut}(X)\) still forces the deck group to be normal.
The proof needs no genus congruence and works in every characteristic.

These statements concern automorphisms of one cover.  They do not assert
that arbitrary distinct common-cover presentations are conjugate.

They do, however, exclude a whole class of common covers: a curve satisfying
the first theorem cannot share a cover with a hyperelliptic curve when both
covering maps are Galois, the first deck group is an abelian
\(\ell\)-group, and the second deck group is abelian.

## 1. Two elementary lemmas

### Lemma 87.1 (normalizer injection)

Let \(D\to X\) be a connected finite Galois cover of smooth projective
curves with deck group \(H\).  Then

\[
 N_{\operatorname{Aut}(D)}(H)/H
             \hookrightarrow \operatorname{Aut}(X).                 \tag{87.1}
\]

#### Proof

An automorphism normalizing \(H\) preserves the invariant field
\(k(D)^H=k(X)\), and hence descends to \(X\).  The kernel consists of the
automorphisms of \(D\) over \(X\), which are exactly \(H\). \(\square\)

### Lemma 87.2 (a simple Jacobian permits no proper positive-genus quotient)

Let \(X\) have genus at least two and simple Jacobian.  If

\[
                         f:X\longrightarrow Q
\]

is a finite separable morphism of degree greater than one, then
\(g(Q)=0\).

#### Proof

If \(g(Q)>0\), pullback \(f^*:J(Q)\to J(X)\) is nonzero and has finite
kernel, because \(f_*f^*=[\deg f]\).  Simplicity of \(J(X)\) makes its
image all of \(J(X)\), so \(g(Q)\ge g(X)\).  Riemann--Hurwitz, including
its effective different in positive characteristic, gives

\[
 2g(X)-2\ge \deg(f)\bigl(2g(Q)-2\bigr)
             \ge\deg(f)\bigl(2g(X)-2\bigr),
\]

which is impossible for \(\deg(f)>1\). \(\square\)

## 2. The trivial-automorphism theorem in arbitrary abelian
\(\ell\)-power degree

### Theorem 87.3 (absolute deck rigidity)

Let \(k\) be algebraically closed, let \(X/k\) be a smooth projective
curve of genus at least two, and assume

\[
                  J(X)\ \text{is simple},\qquad
                  \operatorname{Aut}(X)=1.                            \tag{87.2}
\]

Let \(D\to X\) be a connected finite etale Galois cover whose deck group
\(H\) is a nontrivial finite abelian \(\ell\)-group, for any prime
\(\ell\).  Then

\[
                         \operatorname{Aut}(D)=H.                     \tag{87.3}
\]

This remains valid when \(\ell=\operatorname{char}k\).

#### Proof

Put \(A=\operatorname{Aut}(D)\).  This is a finite group because
\(g(D)\ge2\).  Lemma 87.1 and (87.2) give

\[
                              N_A(H)=H.                               \tag{87.4}
\]

Choose an \(\ell\)-Sylow subgroup \(P\le A\) containing \(H\).  A proper
subgroup of a finite \(\ell\)-group is strictly contained in its
normalizer.  Thus \(H<P\) would imply

\[
                         H<N_P(H)\le N_A(H)=H,
\]

a contradiction.  Hence \(P=H\).  In particular \(P\) is abelian and

\[
                         P\subseteq Z(N_A(P)).
\]

Burnside's normal \(\ell\)-complement theorem supplies a normal subgroup
\(R\triangleleft A\), of order prime to \(\ell\), such that

\[
                   A=R\rtimes P,\qquad A/R\simeq P=H.                 \tag{87.5}
\]

Suppose \(A>H\).  The inclusion \(H<A\) gives a finite separable map

\[
                         X=D/H\longrightarrow D/A
\]

of degree greater than one.  Lemma 87.2 makes \(D/A\simeq\mathbf P^1\).

Every \(\ell\)-Sylow subgroup of \(A\) is conjugate to \(H\), and hence
acts freely on \(D\).  Therefore no point stabilizer for the \(A\)-action
has order divisible by \(\ell\).  Its image in \(A/R\simeq H\) is
trivial.  It follows that the quotient map

\[
                         D/R\longrightarrow D/A\simeq\mathbf P^1
\]

is a connected finite etale Galois cover with nontrivial deck group
\(H\).  This is impossible because the projective line over an
algebraically closed field has no nontrivial connected finite etale
cover.  Hence \(A=H\). \(\square\)

### Remark 87.4

The abelian hypothesis is used exactly once: it places the Sylow subgroup
inside the center of its normalizer, which is the hypothesis of Burnside's
normal-complement theorem.  The proof does not extend as written to a
nonabelian \(\ell\)-group.

## 3. A branch-rigid \(C_\ell\)-base theorem

### Theorem 87.5 (deck normality over a cyclic automorphism quotient)

Let \(\ell\) be any prime, and let \(X/k\) be a smooth projective curve
of genus at least two with simple Jacobian.  Suppose

\[
 \operatorname{Aut}(X)=C_\ell,\qquad
 X/\operatorname{Aut}(X)\simeq\mathbf P^1.                            \tag{87.6}
\]

Let \(\mathcal B\subset\mathbf P^1\) be the reduced branch set of this
quotient map and assume

\[
 \operatorname{Stab}_{\operatorname{PGL}_2(k)}(\mathcal B)=1.        \tag{87.7}
\]

For every connected etale cyclic cover \(D\to X\) of degree \(\ell\),
its deck group \(H=C_\ell\) is normal in \(\operatorname{Aut}(D)\).
This holds without assuming \(\ell\ne\operatorname{char}k\).

#### Proof

Put \(A=\operatorname{Aut}(D)\), and choose an \(\ell\)-Sylow subgroup
\(P\le A\) containing \(H\).  Set

\[
                              Q=N_P(H).
\]

Lemma 87.1 gives

\[
                         Q/H\hookrightarrow\operatorname{Aut}(X)=C_\ell.
                                                                         \tag{87.8}
\]

Suppose first that \(P>H\).  The strict-normalizer property for finite
\(\ell\)-groups gives \(H<Q\).  Equation (87.8) therefore forces

\[
                         |Q|=\ell^2,\qquad Q/H=C_\ell.
\]

The last group is all of \(\operatorname{Aut}(X)\), so

\[
                         D/Q=X/\operatorname{Aut}(X)\simeq\mathbf P^1.
                                                                         \tag{87.9}
\]

The branch set of \(D\to D/Q\) is exactly \(\mathcal B\), because
\(D\to X\) is etale.

If \(Q<P\), the strict-normalizer property applied once more gives
\(Q<N_P(Q)\).  The nontrivial group \(N_P(Q)/Q\) acts faithfully on
\(D/Q\simeq\mathbf P^1\) and preserves the branch set \(\mathcal B\).
This contradicts (87.7).  Hence \(P=Q\), and \(|P|=\ell^2\).

The same branch-set argument in the full group gives \(N_A(P)=P\):
indeed, \(N_A(P)/P\) acts faithfully on \(D/P=D/Q\) and preserves
\(\mathcal B\).  If instead \(P=H\), then

\[
                   N_A(P)/P\hookrightarrow\operatorname{Aut}(X)=C_\ell.
\]

The group on the left has order prime to \(\ell\), since \(P\) is
Sylow, and is therefore trivial.  We have proved in all cases that

\[
                  |P|\in\{\ell,\ell^2\},\qquad
                  P\ \text{is abelian},\qquad N_A(P)=P.              \tag{87.10}
\]

Burnside's normal \(\ell\)-complement theorem now supplies

\[
                  A=R\rtimes P,\qquad R\triangleleft A,\quad
                  \ell\nmid|R|.                                     \tag{87.11}
\]

Let \(G\) be the normal closure of \(H\) in \(A\), and put
\(R_0=G\cap R\).  Since \(A/R\simeq P\) is abelian, every conjugate of
\(H\) has the same image \(H\) in this quotient.  Thus

\[
                         G/R_0\simeq H=C_\ell.                         \tag{87.12}
\]

Suppose that \(H\) is not normal, so \(G>H\).  The map

\[
                         X=D/H\longrightarrow D/G
\]

has degree greater than one; Lemma 87.2 gives
\(D/G\simeq\mathbf P^1\).  Equation (87.12) says that \(H\) is an
\(\ell\)-Sylow subgroup of \(G\).  All such Sylow subgroups are conjugate
to \(H\), and hence act freely on \(D\).  Every point stabilizer for the
\(G\)-action therefore has order prime to \(\ell\), so its image in
\(G/R_0=C_\ell\) is trivial.  Consequently

\[
                         D/R_0\longrightarrow D/G\simeq\mathbf P^1
\]

is a nontrivial connected finite etale \(C_\ell\)-cover.  This is
impossible.  Hence \(G=H\), which proves \(H\triangleleft A\).
\(\square\)

### Corollary 87.6

Under the hypotheses of Theorem 87.5,

\[
              \operatorname{Aut}(D)/H
                    \hookrightarrow\operatorname{Aut}(X)=C_\ell.
\]

In particular, \(\operatorname{Aut}(D)\) is an abelian \(\ell\)-group
of order \(\ell\) or \(\ell^2\).

#### Proof

Once \(H\) is normal, Lemma 87.1 applies with
\(N_{\operatorname{Aut}(D)}(H)=\operatorname{Aut}(D)\).  The order bound
follows, and every group of order at most \(\ell^2\) is abelian.
\(\square\)

### Remark 87.7 (exact use of branch rigidity)

The proof uses the full triviality of the stabilizer in (87.7).  If
\(P>H\), it first excludes a larger \(\ell\)-group normalizing
\(N_P(H)\), and then excludes any further automorphism normalizing the
resulting Sylow group.  Merely ruling out order-\(\ell\) symmetries does
not eliminate the possible prime-to-\(\ell\) part of the latter
normalizer.

For the genus-nine order-three redesign of file 76, absolute simplicity
and the cyclic order-three automorphism are available.  To apply
Theorem 87.5 one must still verify both
\(\operatorname{Aut}(X)=C_3\) and the exact projective stabilizer of the
eleven-point branch set of its cubic quotient.  Neither condition is
assumed here.

## 4. A common-cover consequence

### Theorem 87.8 (no abelian--Galois common cover with a hyperelliptic curve)

Let \(k\) be algebraically closed of characteristic different from \(2\).
Let \(X/k\) and \(Y/k\) be smooth projective curves of genus at least two.
Assume

\[
 J(X)\ \text{is simple},\qquad \operatorname{Aut}(X)=1,
 \qquad Y\ \text{is hyperelliptic}.                                \tag{87.13}
\]

There is no smooth connected curve \(W\) with finite etale Galois maps

\[
                u:W\longrightarrow X,\qquad v:W\longrightarrow Y       \tag{87.14}
\]

such that the deck group of \(u\) is an abelian \(\ell\)-group for some
prime \(\ell\), and the deck group of \(v\) is abelian.  The trivial group
is allowed in either condition.

#### Proof

Let \(H\) be the deck group of \(u\).  If \(H\ne1\), Theorem 87.3 gives

\[
                         \operatorname{Aut}(W)=H.                     \tag{87.15}
\]

If \(H=1\), then \(W=X\), so (87.15) still holds by
\(\operatorname{Aut}(X)=1\).  In either case every nonidentity
automorphism of \(W\) acts without fixed points.

Let \(\iota\) be the hyperelliptic involution of \(Y\), choose a
Weierstrass point \(y_0\), and choose \(w_0\in v^{-1}(y_0)\).  Relative to
these base points, \(\iota\) acts by inversion on
\(\pi_1(Y,y_0)^{\mathrm{ab}}\).  One way to see this in every positive
characteristic different from \(2\) is to use the Abel--Jacobi map

\[
       Y\longrightarrow J(Y),\qquad y\longmapsto [y-y_0].             \tag{87.16}
\]

It identifies the abelianized etale fundamental group of \(Y\) with the
etale fundamental group of \(J(Y)\).  Since
\(y+\iota(y)\sim2y_0\), (87.16) intertwines \(\iota\) with \([-1]\) on
the Jacobian.  This includes the etale \(p\)-primary part when
\(p=\operatorname{char}k\).

Because \(v\) is an abelian Galois cover, its based subgroup is the kernel
of a finite quotient of \(\pi_1(Y,y_0)^{\mathrm{ab}}\).  Inversion
preserves this kernel.  The covering-space lifting criterion therefore
gives a unique lift

\[
                            \widetilde\iota:W\longrightarrow W
\]

with \(\widetilde\iota(w_0)=w_0\).  It is an involution: its square is the
base-point-preserving lift of the identity of \(Y\), hence is the identity.
It is nontrivial because it descends to the nontrivial involution \(\iota\),
and it has the fixed point \(w_0\).  This contradicts (87.15), since every
nonidentity element of the etale deck group \(H\) is fixed-point-free.
\(\square\)

### Remark 87.9 (scope)

Theorem 87.8 is degree-independent but is not an answer for arbitrary common
covers.  Its lifting step uses that \(W\to Y\) is an abelian Galois cover,
and Theorem 87.3 uses that \(W\to X\) is Galois with abelian
\(\ell\)-power deck group.  Neither conclusion is available for a general
non-Galois presentation or an arbitrary nonabelian Galois closure.

## 5. Exact application to the genus-nine redesign

Let \(X\) be the genus-nine curve in (76.1), and let
\(\rho:X\to\mathbf P^1_x\) be its displayed cyclic cubic map.

### Proposition 87.10

For this curve,

\[
                         \operatorname{Aut}_k(X)=C_3,                 \tag{87.17}
\]

generated by the deck transformation of \(\rho\).  Moreover, the reduced
eleven-point branch set of \(\rho\) has trivial stabilizer in
\(\operatorname{PGL}_2(k)\).

#### Proof

Let \(P_X\) be the degree-18 Frobenius polynomial in Proposition 76.2 and
put \(K=\mathbf Q(\pi)\), for a root \(\pi\) of \(P_X\).  That proposition
proves

\[
 [K:\mathbf Q]=18=2\dim J(X),\qquad
 \mathbf Q(\pi^n)=K\quad(n\ge1).                                    \tag{87.18}
\]

Honda--Tate's dimension formula first gives
\(\operatorname{End}^0_{\mathbf F_{25}}J(X)=K\).  Every geometric
endomorphism is defined over a finite extension, and applying the same
formula to \(\pi^n\), using (87.18), gives

\[
                    \operatorname{End}^0_kJ(X)=K.                    \tag{87.19}
\]

The discriminant calculation in Proposition 76.2 excludes every possible
root of unity in \(K\) except those of orders \(1,2,3,6\).  The cubic deck
transformation supplies a primitive cube root, so

\[
                              \mu(K)=\mu_6.                            \tag{87.20}
\]

The Torelli action embeds \(\operatorname{Aut}(X)\) into the
polarization-preserving units of \(\operatorname{End}J(X)\).  Under
(87.19), the Rosati involution is complex conjugation.  Hence every such
unit has absolute value one in every complex embedding and is a root of
unity by Kronecker's theorem.  Thus \(\operatorname{Aut}(X)\) embeds in
\(\mu_6\) and contains the cubic deck group.  The only alternatives are
\(C_3\) and \(C_6\).  The latter would contain an automorphism inducing
\([-1]\) on \(J(X)\), which is the hyperelliptic involution; Proposition
76.1 proves that \(X\) is nonhyperelliptic.  This proves (87.17).

The branch set consists of the ten roots of the square-free polynomial in
(76.1), together with infinity.  The exact computation in
[`87_BRANCH_STABILIZER_CERTIFICATE.sage`](87_BRANCH_STABILIZER_CERTIFICATE.sage)
factors this polynomial over \(\mathbf F_{25}\) as two linear factors and
two irreducible quartics, embeds its splitting field \(\mathbf F_{5^8}\),
and lists all projective transformations that can preserve the branch set.
A transformation is determined by the images of one fixed ordered triple,
so the \(11\cdot10\cdot9\) tested triples are exhaustive even over \(k\):
the resulting transformation has coefficients in the splitting field.
Only the identity survives. \(\square\)

### Corollary 87.11

Every connected etale cyclic cubic cover \(D\to X\) has normal deck group,
and

\[
                  |\operatorname{Aut}(D)|\in\{3,9\};                 \tag{87.21}
\]

in particular \(\operatorname{Aut}(D)\) is an abelian \(3\)-group.

#### Proof

Apply Theorem 87.5 and Corollary 87.6 using Proposition 87.10. \(\square\)

### Corollary 87.12 (explicit abelian--Galois exclusion)

Let \(Y\) be any hyperelliptic curve of genus at least two over \(k\).
There is no smooth connected curve \(D\) with an etale cyclic cubic Galois
map \(D\to X\) and an etale abelian Galois map \(D\to Y\).

#### Proof

As in Theorem 87.8, the hyperelliptic involution has a nontrivial
base-point-fixing involutory lift to every connected abelian etale cover of
\(Y\).  This would give an element of order two in \(\operatorname{Aut}(D)\),
contradicting (87.21). \(\square\)
