# Audit: odd-prime deck normality under rigid branch locus

**Date:** 2026-09-04  
**Auditor:** Codex subagent `cyclic_cover_deck_normality_group_audit`  
**Verdict:** **PASS after proof repair.**  The asserted normality theorem is true,
but the claim that the original deck group must be a Sylow subgroup of
`Aut(D)` is false and should not be used.  The hypothesis `ell does not divide
s` is unnecessary for the repaired proof.

## Audited statement

Let `k` be algebraically closed, let `ell` be a prime different from
`char(k)`, and let `X/k` be a curve of genus at least two such that

- `J(X)` is absolutely simple;
- `Aut(X)=C_ell`;
- `X/Aut(X)` is the projective line; and
- the reduced branch set of `X -> X/Aut(X)` has trivial stabilizer in
  `PGL_2(k)`.

Then, for every connected etale cyclic cover `D -> X` of degree `ell`, its
deck group `H=C_ell` is normal in `Aut(D)`.

This proof does not use the additional numerical assumption
`ell does not divide (g(X)-1)`.

## Corrected proof

Put `A=Aut(D)` and choose an `ell`-Sylow subgroup `P` of `A` containing `H`.
The normalizer quotient

```text
N_A(H)/H -> Aut(X)
```

is injective: its kernel consists exactly of the automorphisms of `D` over
`X`, namely `H`.

Suppose first that `P` properly contains `H`.  The strict-normalizer property
for finite `ell`-groups gives

```text
H < Q := N_P(H).
```

Since `Q/H` injects into `Aut(X)=C_ell`, necessarily `|Q|=ell^2` and
`Q/H=Aut(X)`.  Consequently

```text
D/Q = X/Aut(X) = P^1.
```

The branch locus of `D -> D/Q` is precisely the given branch locus of
`X -> P^1`, because `D -> X` is etale.  If `Q<P`, then again the strict-
normalizer property gives `Q<N_P(Q)`.  But

```text
N_P(Q)/Q -> Aut(D/Q)
```

is injective and its image preserves that branch locus.  This contradicts
the assumed trivial `PGL_2`-stabilizer.  Hence `P=Q`, so `|P|=ell^2`.
Applying the same normalizer argument in `A` gives

```text
N_A(P)=P.
```

If instead `P=H`, then `N_A(P)/P` injects into `Aut(X)=C_ell`; the nontrivial
possibility would have order divisible by `ell`, contrary to Sylow
maximality.  Thus `N_A(P)=P` in this case as well.

In either case `P` is abelian (its order is `ell` or `ell^2`) and
self-normalizing.  Hence

```text
P <= Z(N_A(P)).
```

Burnside's normal `ell`-complement theorem supplies a normal subgroup
`K triangleleft A` of order prime to `ell` with

```text
A=K semidirect P.
```

Assume for contradiction that `H` is not normal in `A`, and let `G` be its
normal closure.  Because `A/K is isomorphic to P` is abelian, every conjugate
of `H` has the same image `H` in `A/K`.  Therefore, with `K_0=G intersect K`,

```text
G/K_0 is isomorphic to C_ell.
```

In particular `H` is an `ell`-Sylow subgroup of `G`.  Every nonidentity
`ell`-element of `G` is conjugate into `H`, hence acts freely on `D`, since
`D -> X` is etale.  It follows that every point stabilizer for the `G`-action
has order prime to `ell`, and therefore lies in `K_0`.  Thus the residual map

```text
D/K_0 -> D/G
```

is etale of degree `ell`.

It remains to identify the base.  Since `H` is not normal, `G` contains a
distinct conjugate of `H`, so `X=D/H -> D/G` has degree greater than one.  If
`g(D/G)>0`, pullback gives a nonzero abelian subvariety of the simple
`J(X)`.  Simplicity would force `g(D/G)=g(X)`, which Riemann--Hurwitz excludes
for a map of degree greater than one between curves of genus at least two.
Hence `D/G` has genus zero.  The displayed residual map would therefore be
a nontrivial connected finite etale cover of `P^1`, impossible.  This proves
that `H` is normal in `A`.

## Points where the proposed route needed correction

1. From `v_ell(2g(D)-2)=1`, Riemann--Hurwitz can force a large cyclic inertia
   subgroup when an `ell`-Sylow has order at least `ell^3`, but it does not
   force `H` itself to be Sylow.  Etale `C_ell` quotients inside
   `C_ell^2`-covers are numerically and geometrically possible.

2. `N_A(H)/H` embeds in `Aut(X)`.  By contrast, `N_A(P)/P` does not generally
   embed in `Aut(X)`.  It embeds in the stabilizer of the branch locus on
   `D/P` only after proving `P=N_P(H)`, which identifies
   `D/P=X/Aut(X)=P^1`.

3. Burnside gives a normal `ell`-complement, not normality of `P` or `H`.
   The decisive extra step is to pass to the normal closure `G` of `H`: its
   image in the abelian quotient `A/K` is only the line `H`, so `H` becomes a
   Sylow subgroup of `G` and all `ell`-inertia disappears.

4. The final etale `C_ell`-cover of `P^1` is valid even when the ambient
   action is wild: all inertia groups of `D -> D/G` lie in `K_0`, so the
   residual constant-group action is free and the intermediate quotient is
   etale.

## Addendum: `ell=char(k)` and `ell=2`

**Additional verdict (2026-09-04): PASS.**  The proof of Theorem 87.5 remains
valid for every prime `ell`, including `ell=char(k)` and `ell=2`.  Thus the
prime-to-characteristic restriction in the audited-statement paragraph above
is unnecessary.

The points requiring care in equal characteristic are harmless:

- Since `D -> X` is etale, the reduced branch locus of the possibly wild map
  `D -> D/Q` is still exactly the reduced branch locus of
  `X -> X/Aut(X)`.  A normalizer of `Q` descends to the quotient and preserves
  this set.  This argument does not use tame ramification.
- After passing to the normal closure `G`, every nonidentity `ell`-element is
  conjugate into the free deck group `H`.  Hence no point stabilizer has order
  divisible by `ell`, by Cauchy's theorem.  Its image in
  `G/R_0=C_ell` is therefore trivial.
- Equivalently, the residual `C_ell`-action on `D/R_0` is free.  The constant
  group scheme `C_ell` is finite etale even when `ell=char(k)`, so its free
  quotient map is finite etale.  A connected finite etale cover of the proper
  projective line is still impossible in characteristic `ell`.

For `ell=2`, the only extra group-theoretic observation needed is already in
the proof: a Sylow subgroup of order `2` or `4` is abelian.  Burnside's normal
complement theorem applies to `P <= Z(N_A(P))` without an odd-prime
hypothesis.  No sign, parity, or tame-inertia argument is being used.

## Addendum: hyperelliptic common-cover corollary

**Additional verdict (2026-09-04): PASS.**  The common-cover corollary
appended to file 87 is valid, including when the abelian deck group over the
hyperelliptic curve has a characteristic-primary etale part.

Choose a Weierstrass point `y_0` of the hyperelliptic curve `Y` and use it as
base point.  For the Abel--Jacobi map

```text
a:Y -> J(Y),   y |-> [y-y_0],
```

the hyperelliptic involution `iota` satisfies `a iota = [-1] a`, since
`y+iota(y)` is linearly equivalent to `2y_0`.  The Abel--Jacobi map induces
an isomorphism

```text
pi_1(Y,y_0)^ab -> pi_1(J(Y),0)
```

on the full profinite abelian fundamental group, not merely its
prime-to-characteristic quotient.  Consequently `iota_*` is inversion on
the full group.  Thus it preserves the kernel of every finite abelian
quotient, including a characteristic-primary one.

For a pointed connected abelian etale cover `(W,w_0)->(Y,y_0)`, the lifting
criterion therefore gives a unique lift of `iota` fixing `w_0`.  Its square
is a deck transformation fixing `w_0`, hence is the identity.  The lift is
nontrivial because it descends to the nontrivial hyperelliptic involution,
and it has the fixed point `w_0`.

If the deck group of `W->X` is nontrivial, Theorem 87.3 identifies
`Aut(W)` with that deck group, all of whose nonidentity elements act freely;
the lifted involution is a contradiction.  If that deck group is trivial,
`W->X` is an isomorphism and `Aut(W)=Aut(X)=1`, again a contradiction.  This
also covers the case where `W->Y` itself has trivial deck group.  The
assumption `char(k) != 2` ensures the usual nontrivial hyperelliptic
involution and a Weierstrass fixed point used above.

## Addendum: explicit genus-nine application

**Additional verdict (2026-09-04): PASS.**  Proposition 87.10 and
Corollaries 87.11--87.12 are correct.  The exact branch-stabilizer
certificate was rerun successfully.

- The irreducible degree-18 Frobenius polynomial has degree `2 dim J(X)`.
  Honda--Tate therefore gives exponent one and
  `End^0_{F_25}(J(X))=Q(pi)`.  For every finite constant extension,
  `Q(pi^n)=Q(pi)` again makes the degree-18 characteristic polynomial the
  minimal polynomial with exponent one.  Since every geometric endomorphism
  is defined over a finite extension, `End^0_k(J(X))=Q(pi)` follows.
- The discriminant exclusions leave only roots of unity of orders
  `1,2,3,6`; the cubic deck action supplies `zeta_3`, so the full root group
  is `mu_6`.  Rosati is complex conjugation on this CM Frobenius field, and
  a polarization-preserving integral unit has modulus one at every embedding,
  hence is a root of unity.  Torelli is faithful.  The only enlargement of
  the deck `C_3` inside `mu_6` would contain `[-1]`; strong Torelli would then
  make `X` hyperelliptic, contrary to Proposition 76.1.  Thus `Aut(X)=C_3`.
- The certificate enumerates the `11*10*9` possible images of one fixed
  ordered triple.  This is exhaustive over the algebraic closure: all eleven
  branch points lie in the computed splitting field, and the unique Mobius
  transformation between two such triples consequently has coefficients in
  that field.  Only the scalar identity survives.  Running
  `sage -c "load('routes/global/87_BRANCH_STABILIZER_CERTIFICATE.sage')"`
  returned the asserted verification.
- Theorem 87.5 and Corollary 87.6 now give `|Aut(D)|` equal to `3` or `9`
  for every etale cyclic cubic cover `D->X`.  An abelian etale presentation
  over any hyperelliptic `Y` would lift its hyperelliptic involution to an
  element of order two in `Aut(D)`, contradicting that order bound.  Trivial
  deck group on the hyperelliptic side is included.
