# P-rank amplification and rank-one non-Galois factorization

**Status: collaborative author proof with separate author verification,
2026-09-05; not independently audited.**

Main argument: `/root`. Separate verification of the full amplification
and factorization proofs: `/root/canonical_trace_algebra`. Prime-degree
and finite-group checks: `/root/x_elliptic_quotient_maps`.

This note uses Borne's published modular decomposition, not the rational
character dimension estimate in file 108. The additional information is
that certain projective modules occur as **direct summands**. It yields
an all-degree theorem for genuinely non-Galois etale maps:

> If an etale cover (D\to X) has (p)-rank one at both ends, it
> factors as (D\to E\to X), where (E/X) is cyclic Galois of degree
> exactly the (p)-part of (\deg(D/X)), and (D/E) has degree prime
> to (p). In particular, every (p)-power-degree etale cover between
> (p)-rank-one curves is cyclic Galois.

The theorem does **not** assume that its Galois closure has (p)-rank
one. It does not prove that arbitrary covers of a rank-one curve
preserve rank one. This distinction is essential for common covers.

Throughout, (k) is algebraically closed of characteristic (p>0),
all curves are smooth, projective and connected, and (\gamma(C))
denotes the geometric (p)-rank. The group-theoretic statements and
factorization hold also for (p=2).

## 1. The precise published input

Let (W\to X) be a connected finite etale Galois cover with group (G).
Let

\[
 V_W=H^0(W,\omega_W)^s
\]

be the Cartier-semisimple part. This is a (k[G])-module of dimension
(\gamma(W)). It is the dual of
(H^1_{\rm et}(W,\mathbf F_p)\otimes_{\mathbf F_p}k).

For a simple (k[G])-module (S), write (P_G(S)) for its projective
cover. Borne's decomposition and quotient formula give

\[
 V_W\simeq\Omega_G^2(k)\oplus
        \bigoplus_S P_G(S)^{\oplus b_S},
 \qquad b_k=\gamma(X)-d_p(G),                              \tag{112.1}
\]

where

\[
 d_p(G)=\dim_{\mathbf F_p}\operatorname{Hom}(G,\mathbf F_p).
\]

Here (\Omega_G^2(k)) is the second syzygy using minimal projective
covers, and the summands are actual summands, not virtual characters.
For (p\nmid |G|) the syzygy is zero. The input is
[Borne, *A relative Shafarevich theorem*, Lemma 2.1 and Proposition 2.4](https://arxiv.org/pdf/math/0204088).
An alternative is
[Stalder, *On p-rank representations*, Remark 4.9 and Theorem 5.4](https://arxiv.org/pdf/math/0402340).
The latter theorem with the full deck group as its normal subgroup,
and trivial quotient group, gives the second formula in (112.1).
All stabilizers are trivial here, so its locally trivial cohomology
term is exactly (H^1(G,k)).

These published results allow arbitrary finite deck groups. A
(p)-group hypothesis on (G), or on a normal subgroup used in the
quotient formula, must not be added.

### Why this is stronger than the rational calculation

The cohomological construction can be seen by allowing simple poles
at one free orbit of points. Residues give an exact sequence from
holomorphic Cartier-semisimple differentials to a projective module
of meromorphic differentials, with quotient the augmentation kernel
of (k[G]). Taking its projective cover produces the second syzygy
and the direct projective summands in (112.1). This is the proof of
Stalder's Theorem 4.8 specialized to a free action.

The exact multiplicity of the trivial projective summand also follows
from that decomposition. If (p\mid |G|), then

\[
 \dim(\Omega_G^2 k)^G=d_p(G).                             \tag{112.2}
\]

For clarity, one elementary explanation of (112.2) is as follows.
The top multiplicity of (k) in (\Omega_G k) is
(\dim\operatorname{Ext}^1_G(k,k)=d_p(G)). Hence its projective
cover has (d_p(G)) copies of (P_G(k)). A projective cover's
socle maps to zero in the core (\Omega_G k): a map nonzero on
the simple essential socle of an indecomposable projective would
embed that projective in the core, and then split, a contradiction.
Thus all its invariant vectors lie in the kernel (\Omega_G^2 k).
Each (P_G(k)) has one-dimensional invariant socle; other
indecomposable projectives have no invariants. This proves (112.2).
Finally (V_W^G=H^0(X,\omega_X)^s), which recovers (b_k).

## 2. Trivial composition factors measure amplification

For a subgroup (H\le G), put

\[
 D=W/H,\qquad M_H=k[G/H],\qquad
 c_H=[M_H:k],                                             \tag{112.3}
\]

where brackets denote **composition multiplicity**, not vector-space
dimension or an index of groups.

### Lemma 112.1

For every (H\le G),

\[
              \dim P_G(k)^H=c_H.                          \tag{112.4}
\]

Moreover,

\[
             p\mid[G:H]\quad\Longrightarrow\quad c_H\ge2.
                                                               \tag{112.5}
\]

#### Proof

The finite group algebra is symmetric. Consequently (P_G(k)) is
also the injective hull of (k), and has simple socle (k).
The exact contravariant functor
(\operatorname{Hom}_G(-,P_G(k))) has dimension one on the simple
module (k), and dimension zero on any other simple module. Applying
it to a composition series of (M_H), and then using Frobenius
reciprocity, gives

\[
 [M_H:k]=\dim\operatorname{Hom}_G(M_H,P_G(k))
         =\dim P_G(k)^H.
\]

There is always a nonzero constant submodule (k\subset M_H), and
an augmentation quotient (M_H\twoheadrightarrow k). If the index
is divisible by (p), augmentation kills the constant vector.
The constant submodule is then inside its kernel, so the two
occurrences of (k) give distinct composition factors. \(\square\)

### Theorem 112.2 (all-degree amplification)

For every actual etale Galois tower (W\to W/H=D\to X),

\[
 \gamma(D)\ \ge\ c_H\bigl(\gamma(X)-d_p(G)\bigr).        \tag{112.6}
\]

In particular, if (G) has no quotient (C_p) and
(p\mid\deg(D/X)), then

\[
                         \gamma(D)\ge2\gamma(X).          \tag{112.7}
\]

There is no core-freeness assumption on (H); (W) need not be
the minimal Galois closure of (D/X).

#### Proof

Formula (112.1) gives an actual direct summand
(P_G(k)^{\oplus(\gamma(X)-d_p(G))}\subset V_W).
Taking (H)-invariants preserves this direct-sum inclusion, even
when (p\mid |H|).

Etale descent of differentials gives
(H^0(W,\omega_W)^H=H^0(D,\omega_D)), compatibly with Cartier.
The decomposition into Cartier-bijective and Cartier-nilpotent parts
is (H)-stable; the bijective part remains bijective on invariants.
It follows that

\[
                  V_W^H=H^0(D,\omega_D)^s.
\]

Its dimension is (\gamma(D)). Lemma 112.1 proves (112.6), and
(d_p(G)=0) together with (112.5) proves (112.7). \(\square\)

This invariant calculation uses **differentials**, not the false
general identification of mod-(p) etale cohomology downstairs with
invariants upstairs. The latter has extra group-cohomology terms.

## 3. Isolating the entire p-part of a rank-one cover

### Theorem 112.3

Let (D\to X) be any connected finite etale cover such that

\[
                         \gamma(D)=\gamma(X)=1.
\]

Write (\deg(D/X)=p^a m), where (p\nmid m). Then there is an
intermediate smooth projective curve (E) for which

\[
              D\longrightarrow E\longrightarrow X,
 \qquad \deg(D/E)=m,
 \qquad E/X\text{ is cyclic Galois of degree }p^a.        \tag{112.8}
\]

All maps in (112.8) are finite etale and (\gamma(E)=1).

#### Proof

Take the connected etale Galois closure (W\to X), with group (G),
and write (D=W/H). Define

\[
 N=O^p(G),\qquad B=W/N,\qquad D'=W/(H\cap N),             \tag{112.9}
\]

where (O^p(G)) is the smallest normal subgroup with (p)-group
quotient. Equivalently it is the intersection of all normal
subgroups of (p)-power index.

First (N) is (p)-perfect, meaning (d_p(N)=0). Indeed,
(O^p(N)) is characteristic in the characteristic subgroup (N),
so it is normal in (G). Both (N/O^p(N)) and (G/N) are
(p)-groups. Their extension (G/O^p(N)) is therefore a (p)-group,
and minimality of (O^p(G)) forces (O^p(N)=N).

The cover (B\to X) is Galois with (p)-group (G/N).
Deuring--Shafarevich gives

\[
                      \gamma(B)-1=|G/N|(\gamma(X)-1)=0.  \tag{112.10}
\]

In fact (G/N) is cyclic. Its homomorphisms to (C_p) inject,
by the covering quotient, into
(H^1_{\rm et}(X,\mathbf F_p)), which has dimension one.
The Burnside basis theorem says that a finite (p)-group with
at most one generator modulo its Frattini subgroup is cyclic
(including the trivial group).

Since (N\triangleleft G), the subgroup (H\cap N) is normal
in (H). Consequently (D'\to D) is genuinely Galois, with group

\[
                     H/(H\cap N)\ \le\ G/N.
\]

It is a (p)-group cover. Another application of
Deuring--Shafarevich gives

\[
                              \gamma(D')=1.              \tag{112.11}
\]

Now apply Theorem 112.2 directly to the actual etale tower

\[
                    W\longrightarrow D'\longrightarrow B
\]

with deck group (N) and subgroup (H\cap N).
Since (d_p(N)=0) and both (B,D') have rank one, inequality
(112.7) excludes (p\mid[N:H\cap N]). Thus

\[
                         p\nmid[N:H\cap N].              \tag{112.12}
\]

Because (G/N) is cyclic, its subgroup (HN/N) is normal.
Hence (HN\triangleleft G). Put (E=W/HN). Then (E/X)
is cyclic Galois of (p)-power degree, while

\[
 \deg(D/E)=[HN:H]=[N:H\cap N]
\]

is prime to (p) by (112.12). Multiplicativity of degrees identifies
these two degrees with (p^a) and (m), respectively. All maps
are intermediate maps in an etale Galois cover and hence are etale.
Finally (\gamma(E)=1) follows either from Deuring--Shafarevich or
from monotonicity of (p)-rank under finite maps between (D,E,X).
\(\square\)

### Corollary 112.4

Every connected (p)-power-degree finite etale cover between curves
of (p)-rank one is cyclic Galois.

Moreover, the curve (E) of Theorem 112.3 is the unique cyclic
(p^a)-cover of (X), up to isomorphism over (X), contained in (D).
For the uniqueness assertion, any finite (p)-group quotient of
the fundamental group of (X) is cyclic by the same generator-rank
argument; combining two cyclic covers of degree (p^a) therefore
gives a cyclic group, which has only one subgroup of index (p^a).

### Corollary 112.5 (combination with file 111)

For odd (p), a (p)-power-degree etale map between rank-one curves
induces a bijection of maximal Tango structures.

#### Proof

It is cyclic Galois by Corollary 112.4, so apply Theorem 111.2.
This does not assert Tango descent through the prime-to-(p) map
(D\to E) in a general factorization. \(\square\)

## 4. Prime-degree tests and a sharp example

### Corollary 112.6

Let (D\to X) be non-Galois, connected, finite etale of degree (p),
with permutation monodromy (G\le S_p) and point stabilizer (H).
Then

\[
 \gamma(D)\ge r(G)\gamma(X),\qquad
 r(G)=\#(H\backslash G/H)\ge2.                            \tag{112.13}
\]

#### Proof

A nonzero homomorphism (G\to C_p) would have normal kernel (K)
of order prime to (p), since the (p)-part of (|G|) is exactly
(p). The orbits of (K) form blocks in the prime-degree action.
They cannot have size (p), because (p\nmid |K|); thus (K)
fixes every letter. Faithfulness gives (K=1), forcing (G=C_p)
and the original cover to be Galois. Therefore (d_p(G)=0).

Here (p\nmid |H|), so (k[G/H]) is projective of dimension (p).
Every nonzero projective summand has dimension divisible by (p),
as restriction to a Sylow (C_p) is free. Thus it is indecomposable;
augmentation identifies it with (P_G(k)). Its (H)-invariants
have dimension (r(G)). Apply Theorem 112.2. \(\square\)

In characteristic five the ranks are (3) for (D_{10}), and (2)
for the Frobenius group of order (20), (A_5), and (S_5).
The actual non-Galois etale degree-five example in
[the ordinariness counterexample](NONGALOIS_ETALE_DEGREE5_CAN_DESTROY_ORDINARINESS.md)
has group (D_{10}), base rank (3), and source rank (9).
It attains equality in (112.13). Thus no positive universal additive
term can be appended to that bound.

## 5. Application boundary for Litt Problem 3

1. The statement preserves the actual source (D), and takes only
   the Galois closure over (X). If (D) also maps etale to a fixed
   (Y), that map remains present. We do **not** assert that the
   intermediate (E) maps to (Y).
2. The fixed curve (X) in file 76 has (p)-rank six, not one.
   Theorem 112.3 does not apply to it. Theorem 112.2 is general,
   but it gives a rank lower bound, not a new all-degree
   common-cover exclusion for that pair.
3. Even if both original curves have rank one, a common cover can
   have larger rank. No result here bounds the rank of that cover
   or of its Galois closure by one.
4. Even for rank-one (D,X), a non-Galois prime-to-(p) remainder
   can persist. It must not be discarded, called tame Galois, or
   assumed to have a prime-to-(p) Galois closure.
5. File 108's genus divisibility filter must precede any promotion
   of a group bound to a new common-cover exclusion. The original
   problem remains open in this repository.
