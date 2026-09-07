# Non-Galois p-rank amplification and the p-monodromy factor

Version 2, 2026-09-08. Consolidated author proofs of the modular amplification,
rank-one factorization and positive-rank quantitative extension. Original
proofs: /root; separate author verification: /root/canonical_trace_algebra;
prime-degree group examples: /root/x_elliptic_quotient_maps (2026-09-05).

The [Tango-descent audit](audits/115_POSITIVE_RANK_PRESERVING_TANGO_DESCENT_AUDIT.md)
is PASS, auditor /root/x_elliptic_quotient_maps, 2026-09-05, for that theorem
and its exact required input chain. It does NOT audit every example in
this packet; its auditor had contributed the unused prime-degree examples.
Both original factorization proofs and their hypotheses are retained below.
No new independent audit or common-cover exclusion is claimed.

All curves are smooth projective connected over algebraically closed k of
characteristic p>0. Write γ(C) for p-rank. Characteristics two and odd p
are both allowed unless a Tango corollary explicitly requires odd p.

## 1. Actual projective summands, not virtual characters

For a connected finite etale Galois cover W→X with group G, put
V_W=H^0(W,ω_W)^s, the Cartier-bijective differential subspace, of dimension
γ(W). It is a k[G]-module (not generally semisimple as a group module).
Let P_G(S) be the projective cover of a simple k[G]-module S, and put
d_p(G)=dim_(F_p)Hom(G,F_p). The published decomposition is

\[
 V_W\simeq\Omega_G^2(k)\oplus\bigoplus_S P_G(S)^{b_S},
 \qquad b_k=\gamma(X)-d_p(G)\ge0.                         \tag{1}
\]

Here Ω uses MINIMAL projective covers and is zero for p∤|G|.
[Borne, Lemma 2.1 and Proposition 2.4](https://arxiv.org/pdf/math/0204088)
apply to arbitrary finite G. Taking the full group as kernel of the
quotient G→1 gives b_k. Equivalently use
[Stalder, Theorem 4.8/Remark 4.9 and Theorem 5.4](https://arxiv.org/pdf/math/0402340);
all point stabilizers are trivial, so locally trivial H^1 is full H^1.
The construction allows simple poles on one free orbit, obtains a
projective module with augmentation-kernel quotient, and splits off Ω².
Thus the projective terms in (1) are DIRECT summands.

One can also see the trivial multiplicity directly when p divides |G|.
The top of Ω_Gk contains k with multiplicity Ext^1_G(k,k)=d_p(G).
Every socle in its projective cover maps to zero in Ω_Gk: otherwise
the essential simple socle would force an injective projective summand
in Ω_Gk, contradicting minimality. Since the group algebra is symmetric,
P_G(k) has one invariant socle and other P_G(S) have none. Therefore
dim(Ω_G²k)^G=d_p(G), which, with V_W^G=V_X, gives b_k.

For H≤G, define c_H=[k[G/H]:k], the COMPOSITION multiplicity of the
trivial module. Then

\[
 \dim P_G(k)^H=c_H\ge1,\qquad
 p\mid[G:H]\ \Longrightarrow\ c_H\ge2.                   \tag{2}
\]

Indeed P_G(k) is also the injective hull of k. The exact contravariant
functor Hom_G(−,P_G(k)) has dimension one on k and zero on every other
simple module. A composition series and Frobenius reciprocity give (2)'s
equality. Constants supply one trivial factor of k[G/H]; when p divides
the index they lie in the augmentation kernel, and its quotient supplies
a second, distinct factor.

For D=W/H, etale descent identifies invariant DIFFERENTIALS with those
on D, compatibly with Cartier. The Cartier-bijective/nilpotent decomposition
is H-stable and its bijective part remains bijective on invariants.
Taking invariants of the DIRECT summand in (1) therefore proves

\[
 \boxed{\gamma(D)\ge c_H\bigl(\gamma(X)-d_p(G)\bigr).}      \tag{3}
\]

In particular d_p(G)=0 and p|[G:H] imply γ(D)≥2γ(X).
No core-freeness of H or minimality of W is required. The argument does
NOT identify mod-p etale cohomology downstairs with upstairs invariants;
that false shortcut would omit group-cohomology terms.

## 2. One common finite-group tower for both factorization results

For an actual finite etale D→X, choose a connected finite etale Galois
cover W→X dominating it (the one-leg Galois closure suffices). Set

\[
 G=\operatorname{Gal}(W/X),\quad D=W/H,\quad N=O^p(G),
 \quad K=H\cap N,\quad B=W/N,\quad D'=W/K,\quad E=W/HN.
\]

The subgroup N is the smallest normal subgroup with p-group quotient.
It is p-perfect: O^p(N) is characteristic in N and hence normal in G;
G/O^p(N) is an extension of two p-groups, so minimality forces O^p(N)=N.
Thus d_p(N)=0. Put

\[
 d=[G:HN],\quad h=[H:K],\quad n=[N:K],\quad c=[k[N/K]:k].
\]

All intermediate maps are finite etale. Their degrees and groups are:

| Actual map | Degree | Galois assertion |
| --- | ---: | --- |
| B→X | dh | G/N, a p-group |
| B→E | h | HN/N≅H/K, a p-group |
| D'→D | h | H/K, the same p-group |
| D'→B and D→E | n | Not assumed Galois |
| E→X | d | p-group MONODROMY, not assumed Galois |

Apply Deuring--Shafarevich ONLY to the first three, genuinely Galois maps:

\[
\begin{aligned}
 \gamma(B)-1&=dh(\gamma(X)-1)=h(\gamma(E)-1),\\
 \gamma(D')-1&=h(\gamma(D)-1).
\end{aligned}                                                   \tag{4}
\]

Meanwhile (3) for W→B with group N and subgroup K gives

\[
 \gamma(D')\ge c\,\gamma(B),\qquad
 c\ge1,\quad p\mid n\Longrightarrow c\ge2.                 \tag{5}
\]

These two equations are the shared input; a p-power DEGREE alone is
never used as a Galois hypothesis.

## 3. Rank-one factorization, with its original direct proof

If γ(D)=γ(X)=1 and deg(D/X)=p^a m with p∤m, then

\[
 D\longrightarrow E\longrightarrow X,\qquad
 \deg(D/E)=m,\qquad E/X\text{ cyclic Galois of degree }p^a,
 \qquad\gamma(E)=1.                                      \tag{6}
\]

Proof. Equation (4) gives γ(B)=γ(D')=1. Equation (5) forces c=1,
hence p∤n. Inflation embeds Hom(G/N,F_p) in H^1_et(X,F_p), of
dimension one. The Burnside basis theorem makes the finite p-group
G/N cyclic, including the trivial case. Thus HN/N is normal, so E→X
is cyclic Galois. Its degree d is a p-power and deg(D/E)=n is prime
to p; dn=p^a m proves (6). No p-rank assumption on W was used.

Consequently EVERY p-power-degree etale cover between p-rank-one curves
is cyclic Galois. The cyclic p^a subcover E is unique over X: combine
any two cyclic p^a covers in a connected Galois compositum over X.
Its p-group again has generator rank at most one, hence is cyclic and
has a unique subgroup of the relevant index.

For odd p this gives a bijection of maximal Tango structures across
such a p-power-degree cover by the
[rank-one p-group descent theorem](111_P_RANK_ONE_TANGO_DESCENT.md#3-descent-through-an-etale-p-group).
It does not assert Tango descent through the prime-to-p remainder
in (6) without the additional hypotheses of the
[positive-rank-preserving Tango theorem](115_POSITIVE_RANK_PRESERVING_TANGO_DESCENT.md).

## 4. Quantitative extension to every positive base rank

Assume γ(X)≥1 in Section 2. Equations (4) and (5) give

\[
 \gamma(E)=1+d(\gamma(X)-1),\qquad
 \boxed{\gamma(D)\ge1+c(\gamma(E)-1)
                   +\left\lceil\frac{c-1}{h}\right\rceil.}       \tag{7}
\]

Indeed substitute (4) into (5), divide by h and use integrality.
Thus γ(D)≥γ(E)≥1. If p|n, then c≥2 and ceil((c−1)/h)≥1, so

\[
 \gamma(D)\ge2\gamma(E).                                  \tag{8}
\]

In particular γ(D)<2γ(E) forces n prime to p: the full p-part of the
degree lies in the p-group-monodromy factor E/X, which need NOT be Galois.

For any p-divisible degree D→X with γ(X)≥1 this yields

\[
 \boxed{\gamma(D)\ge
       \min\{1+p(\gamma(X)-1),\,2\gamma(X)\}.}             \tag{9}
\]

If d>1, then d≥p and (7) supplies the first bound; if d=1, use (8).
For γ(X)≥2 this is at least 2γ(X) when p is odd, and 2γ(X)−1 when
p=2. The first inequality follows from
1+p(f−1)−2f=(p−2)f−p+1≥p−3 for f≥2. Both bounds exceed f.
Hence a rank-preserving cover with common rank≥2 has degree prime to p
in EVERY characteristic; common rank one is handled independently by (6).

The p-adic valuation of the degree does NOT count successive doublings:
a single residual primitive cover can have degree divisible by a large
power of p. Nor does prime-to-p degree imply prime-to-p Galois closure.

## 5. Prime-degree bound and a sharp example

Let D→X be NON-GALOIS etale of prime degree p, with faithful transitive
monodromy G≤S_p and point stabilizer H. Then

\[
 \gamma(D)\ge r(G)\gamma(X),\qquad
 r(G)=\#(H\backslash G/H)\ge2.                             \tag{10}
\]

A quotient G→C_p would have kernel of order prime to p since v_p(|G|)=1.
Its orbits are blocks of the prime-degree action and cannot have size p,
so the kernel fixes every letter. Faithfulness then makes G=C_p,
contrary to non-Galoisness. Thus d_p(G)=0. Since p∤|H|, k[G/H] is
projective of dimension p. Every nonzero projective summand has dimension
divisible by p (restrict to a Sylow C_p), so it is indecomposable;
augmentation makes it P_G(k). Its H-invariant dimension is the
double-coset count, and (3) proves (10).

At p=5, r(G)=3 for D_10 and r(G)=2 for the Frobenius group of order20,
A_5 and S_5. The retained
[actual non-Galois degree-five example](NONGALOIS_ETALE_DEGREE5_CAN_DESTROY_ORDINARINESS.md)
has group D_10 and ranks 3→9, attaining equality. Thus no positive
universal additive term can be appended. These finite-group/example
claims retain their author-check scope, not the Tango audit's scope.

## 6. Both-leg and fixed-pair limits

If D also has an actual finite etale map to a fixed Y, that map is
retained; only the Galois closure over X is taken. The intermediate E
need not map to Y, and no simultaneous Galois closure is presumed.
Even rank-one endpoints need not have a rank-one common cover or closure.

For the unchanged fixed genus-(9,25) pair, γ(X)=6 and γ(Y)=25.
Writing deg(Z/Y)=M gives deg(Z/X)=3M and g(Z)=24M+1. If 5|M,
(9) on the Y-leg gives γ(Z)≥50. This is compatible with the genus
for every such M and excludes no degree by itself. The rank-one
factorization does not apply to this X. The
[genus-divisibility filter and rational packet bounds](108_UNIT_ROOT_PACKETS_AND_NONGALOIS_P_RANK_BRIDGES.md)
are separate necessary conditions, not substitutes for either actual leg.
