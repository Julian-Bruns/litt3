# Audit: higher cyclic prime-power deck rigidity

**Date:** 2026-09-04  
**Auditor:** Codex subagent
`/root/x_elliptic_quotient_maps/abelian_deck_group_theory`  
**Audited SHA-256:**
`7f7a0020f40446d893e69616163361c082cfafc2b5992525fb184ce4a9354f56`  
**Verdict:** **PASS.**

## Scope checked

The audit checked Lemma 90.1 through Corollary 90.6, with particular
attention to:

- the order-`p` automorphisms of `C_(p^n)` and the order-`p` elements in
  the semidirect product `C_(p^n) semidirect C_p`;
- the production of an order-`p` element outside the deck group from
  geometric inertia;
- the Sylow conclusion in arbitrary characteristic, including
  `p = char(k)`;
- Burnside's normal-complement theorem and the passage from the normal
  closure of the deck group to a direct product;
- the parity argument for automorphisms of a nonhyperelliptic curve with
  simple Jacobian; and
- the hyperelliptic common-cover exclusions for cyclic `2^n`- and
  `3^n`-covers.

## Checked details

In Lemma 90.1, write `b h b^(-1) = h^u`. The congruence `u^p = 1`
modulo `p^n` implies, for odd `p`,

```text
u = 1 + c p^(n-1) modulo p^n.
```

Expansion then gives

```text
1 + u^j + ... + u^((p-1)j) = p modulo p^n,
(h^a b^j)^p = h^(pa).
```

Thus the solutions of `x^p = 1` are exactly

```text
T = <h^(p^(n-1)), b> = C_p x C_p.
```

This is a subgroup and is characteristic because it is intrinsically the
solution set of `x^p = 1`. It is proper for every `n >= 2`.

In Theorem 90.2, a nontrivial point stabilizer exists because otherwise
`D -> D/Q = P^1` would be a nontrivial connected etale cover. Freeness of
`H` injects each stabilizer into `Q/H = C_p`, so a nontrivial stabilizer
has order `p` and supplies exactly the element `b` required by Lemma 90.1.
All stabilizers then lie in `T`. Consequently the `Q/T`-action on `D/T`
is free, so `D/T -> D/Q` is etale. This remains correct in wild
characteristic; no different-exponent calculation is being used.

Proposition 90.3 correctly applies Burnside's normal `p`-complement theorem
under `H <= Z(N_A(H))`. If `R` is the normal `p`-prime complement and `G`
is the normal closure of `H`, then

```text
G/(G intersect R) = H.
```

If `G > H`, simplicity makes `D/G = P^1`, while freeness of every conjugate
Sylow `p`-subgroup forces all inertia into `G intersect R`. The resulting
nontrivial etale `H`-cover of `P^1` is impossible. Hence `H` is normal in
`A`; the two normal subgroups `H` and `R` have trivial intersection and
therefore commute, giving the claimed direct product.

For Theorem 90.5, an even-order automorphism group of `X` would contain an
involution. Simplicity makes its quotient rational, and in characteristic
different from two this would make `X` hyperelliptic. Thus `Aut(X)` has odd
order. The normalizer/Sylow arguments for both `2^n` and `3^n` are then
valid. In the `3^n` case the full automorphism group is odd; in the `2^n`
case every involution lies in the free cyclic deck group. Either conclusion
contradicts the fixed-point-preserving lift of the hyperelliptic involution
through an abelian etale Galois cover.

## Breaking objections

None.

## Non-breaking suggestion

It would be slightly clearer to say explicitly that the stabilizer in
`Q/T` of the image of a point `z` of `D` is `T Q_z/T`. Since `Q_z <= T`,
this proves freeness of the residual action directly and makes the
equal-characteristic step transparent.

Theorems 90.2--90.5 retain content not supplied by file 91: they allow `X`
to have nontrivial automorphisms, notably `Aut(X) = C_3` in the explicit
genus-nine application.
