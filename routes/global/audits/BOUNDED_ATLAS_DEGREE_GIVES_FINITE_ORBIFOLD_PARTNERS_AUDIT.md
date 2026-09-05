# Audit: bounded atlas degree gives finitely many orbifold partners

**Verdict:** **PASS.** No breaking objection was found.

**Auditor:** `/root/x_elliptic_quotient_maps`

**Date:** 2026-09-05

**Revision checked (SHA-256):**
`ed995553f9de4fa20eb87da451d3f7340f95667f87af253bc8bf53b9e5b5159a`

## Scope

This audit checks
`BOUNDED_ATLAS_DEGREE_GIVES_FINITE_ORBIFOLD_PARTNERS.md`, including wild
effective orbifolds. It does not supply the atlas-degree bound assumed in
the open-family consequence, classify local orbifold signatures, or say
anything about coreless common covers.

## Checks

1. The full etale fundamental group of a fixed smooth proper curve is
   topologically finitely generated, including in positive characteristic;
   the proper smooth specialization map from a characteristic-zero lift
   is surjective. Hence there are finitely many connected covers of each
   bounded degree.

2. For an `n`-sheeted atlas `X -> S`, its Galois closure in the finite
   etale category of `S` is a curve `W`, because it maps finite etale to
   the scheme `X`. Its group is a transitive subgroup of `S_n`, and the
   stabilizer calculation gives `deg(W/X) <= (n-1)!`. Thus only finitely
   many covers `W -> X` occur.

3. Effectiveness is used at exactly the needed point. It makes the Galois
   group act faithfully on the underlying curve `W`, hence embeds it into
   the finite group `Aut_k(W)` and gives `S = [W/G]`. Each of the finitely
   many possible `W` has only finitely many subgroups, proving finiteness
   of `S`. Without effectiveness an invisible generic stabilizer would
   invalidate this subgroup-of-`Aut(W)` step.

4. For each resulting `S`, its fundamental group is finitely generated
   because it contains `pi_1(W)` as an open subgroup. Canonical pullback
   along the etale atlas gives positive orbifold canonical degree
   `delta=(2g(X)-2)/n`. A genus-`h` curve atlas must consequently have the
   single prescribed degree `(h-1)n/(g(X)-1)`. Finitely generated
   `pi_1(S)` then gives only finitely many such connected covers and hence
   finitely many source curves `Y`.

5. The Galois closure is taken only after a common orbifold `S` has been
   assumed. No step replaces two arbitrary maps from a common curve by a
   simultaneous Galois cover. The stated coreless limitation is therefore
   accurate.

## Objections and limitations

**Breaking objections:** none.

**Non-breaking suggestion:** the first paragraph could cite explicitly
that every smooth proper curve lifts to characteristic zero before using
the specialization lemma. This is standard and does not affect the proof.

The lemma proves finiteness conditional on a uniform bound for the
`X`-atlas degree. It neither provides that bound nor applies to a
correspondence without a finite common orbifold quotient.
