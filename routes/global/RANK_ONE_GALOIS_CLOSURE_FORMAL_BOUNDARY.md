# Rank-one Galois-closure shortcut: formal boundary only

Status: bounded comparison, 2026-09-05. No actual counterexample was
constructed. This note neither proves nor disproves that a prime-to-5
etale cover preserving p-rank one has a p-rank-one Galois closure.
It is not an input to the separate direct descent argument.

## Exact modular test

Let k be algebraically closed of characteristic 5, G=A5, and H=D10
(order 10, index 6). Let P0 be the projective cover of the trivial
module and let P3 be the projective cover of the simple 3-dimensional
module S. In the ordinary-character ordering 1, chi3, chi3', chi4,
chi5, the 5-modular decomposition matrix is

```
1 0 0
0 1 0
0 1 0
1 1 0
0 0 1
```

This was checked by Sage 10.9/GAP:

```
DecompositionMatrix(CharacterTable("A5") mod 5);
```

Consequently P0 has dimension 5 and projective character 1+chi4;
P3 has dimension 10 and projective character chi3+chi3'+chi4.
The composition factors of P0 are k,S,k. Its simple top and socle
are k, so the top of rad(P0)=Omega(k) is S. Thus

    0 -> Omega^2(k) -> P3 -> rad(P0) -> 0

is exact, and Omega^2(k) has dimension 6 and Brauer character equal
to the restriction of chi3+chi3'.

The H-invariant calculation must NOT average ordinary characters
over H, since 5 divides |H|. Instead restrict projectives to H.
The two H-PIMs, P_H(k) and P_H(epsilon), have dimension 5 and
Brauer-character values +1 and -1 on an involution. The restriction
of P3 is projective of dimension 10 with involution value -2, hence

    P3|H = P_H(epsilon)^2.

It has no H-invariants, so its submodule Omega^2(k) has none.
Similarly P0|H=P_H(k), and dim(P0^H)=1. Finally
dim((Omega^2(k))^G)=dim H^1(G,k)=0, since A5 is perfect.

Therefore the actual k[G]-module

    V = Omega^2(k) direct-sum P0

has dimensions

    dim V = 11,       dim V^G = 1,       dim V^H = 1.

It has exactly the stable core and trivial-projective multiplicity
required by the free-action formula in
[Borne, Lemma 2.1 and Proposition 2.4](https://arxiv.org/pdf/math/0204088),
or [Stalder, Remark 4.9 and Theorem 5.4](https://arxiv.org/pdf/math/0402340).
Thus those module conditions alone do not force the Galois closure
to retain p-rank one. Geometric realization is a separate question.

## Bounded actual-construction test: no example found

An alternative D8 construction was tested, without claiming that
module admissibility implies realizability. Set

    E: y^2=F(x^2),       X: v^2=uF(u),

where F is a separable quartic with nonzero roots. The involution
(x,y)->(-x,-y) is fixed-point-free on E and has quotient X. The
other quotient is the elliptic curve R: y^2=F(u). We required
f(X)=1 and f(R)=0, hence f(E)=1.

For each even branch subset S of E of size 2 or 4, its partition
defines an etale double cover D/E. Its Prym p-rank is the sum of
the p-ranks of the two hyperelliptic curves defined by the partition
polynomials. We sought zero for S, but positive p-rank for
T=S symmetric-difference (-S), with T neither empty nor the full
branch set. Such a result would produce a genuinely non-Galois
degree-4 cover D/X with D8 Galois closure of larger p-rank.

The first batch required all eight branch points in F25 and found
no eligible base. The final batch allowed their square roots in
F625: among quartic root subsets of F25^* containing 1, 154 gave
supersingular R and 8 also had f(X)=1. All size-2 and size-4
partitions of those eight eligible branch sets were tested by
exact Cartier-Manin stable ranks. None produced the desired
counterexample. No further field enlargement was attempted.

The low-p-rank Prym existence results in
[Celik et al.](https://arxiv.org/pdf/1708.03652) establish suitable
individual unramified double covers, but do not by themselves
supply the simultaneous conjugate-partition conditions needed
here. The general Galois-closure shortcut remains unresolved by
this bounded branch.
