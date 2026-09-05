# Audit of file 115: positive-rank-preserving Tango descent

**Verdict: PASS.**

**Auditor:** `/root/x_elliptic_quotient_maps`  
**Date:** 2026-09-05

Checked revisions:

- `115_POSITIVE_RANK_PRESERVING_TANGO_DESCENT.md`:
  `f4926890cf431b4cf047ef2dd9f751a57bd45fe0e8f0fb63b27ec78d7c9a2215`;
- imported file 111:
  `135a197975e8c47e4e44ff1a2e6c7ef0911ce458fbda62300d10f1619f2b9592`;
- imported file 112:
  `fae2df0389dfe63b8e937a012d19b628288bd84f1e513b518470450bcc94df6b`;
- imported file 113:
  `e7ac8ee71165fd08053507d84509278ae11deebfc9875164395e8dcf15a59fae`.

## Scope and findings

The intrinsic proof of Lemma 115.2 is correct.  For an etale map of degree
`n` prime to `p`, the relative-Frobenius square is Cartesian and finite-flat
norm commutes with this base change.  Thus an upstairs root gives a norm
whose Frobenius pullback is `M^n`.  Bezout exponents `un+vp=1`, together
with `F_X^*(M^(1))=M^p`, produce a downstairs root.  The kernel of
Frobenius pullback on `Pic^0(C^(1))(k)` is the group of geometric points of
the Verschiebung kernel, hence has cardinality `p^gamma(C)` and is killed by
`p`.  Pullback on these kernels is injective by applying norm and using
`gcd(n,p)=1`; equal p-ranks then make it an isomorphism.  The two root sets
are torsors under these groups, so pullback is bijective.

Corollary 115.3 correctly upgrades descent of a root **class** to descent of
the embedded Tango line.  Frobenius adjunction and flat base change identify
the pulled-back adjoint map with the given upstairs embedding up to one
global scalar.  Being a line subbundle and being killed by Cartier both
descend faithfully flatly; Cartier commutes with etale pullback.  Thus no
unmentioned choice of linearization or isomorphism remains.

The normalized-norm connection calculation is also consistent.  After an
etale local splitting, averaging the connection coefficients is legitimate
because `n` is invertible in `F_p`; both the affine coordinate-change term
and the rank-one p-curvature equation average correctly.  Equal p-rank
identifies the Cartier-fixed differential spaces, and the trace-zero
difference must vanish.  This section is explanatory rather than needed to
repair the root proof.

The two positive-rank cases in Theorem 115.1 use the earlier files exactly as
claimed:

- if the common p-rank is at least two, Corollary 113.3 forces the actual
  cover degree to be prime to `p`, so Corollary 115.3 applies directly;
- in p-rank one, Theorem 112.3 gives an actual factorization into a
  prime-to-`p` leg and a cyclic Galois p-power leg, all of rank one.  The
  first leg is handled by Corollary 115.3 and the second by Theorem 111.2.
  No assertion about the p-rank of a Galois closure is used.

The modular input needed for files 112--113 has the required scope.  In
Stalder's *On p-rank representations*, the quotient formula applies to an
arbitrary finite automorphism group.  Specializing it to a free G-action and
the full normal subgroup gives

`b(G,k) + dim H^1(G,k) = gamma(W/G)`.

There is no p-group hypothesis here.  The direct projective summand and
composition-multiplicity argument used in 112.2 and 113.1 is therefore
available for the actual free action of `N=O^p(G)` on the Galois closure.
The group-theoretic proof that `N` is p-perfect, the three uses of
Deuring--Shafarevich only on genuine Galois p-group covers, and the ceiling
in (113.3) were checked and are correct.

The application limits in Section 5 are accurately stated.  In particular,
the fixed genus-nine/genus-25 pair has source-side p-rank growth, so the
rank-preserving theorem supplies no contradiction.  The result also does not
bound how much p-rank can grow.

## Objections and provenance

**Breaking objections:** none.

**Non-breaking suggestion:** Corollary 115.3 could explicitly say that the
subbundle property of the adjoint map descends after its pullback is
identified with the specified upstairs Tango subbundle.  This is already
implicit and does not affect the proof.

I previously supplied the prime-degree and small finite-group tests recorded
in the nonessential testing section of file 112.  Accordingly, this record
is an independent audit of file 115 and of the precise imported results
111.2, 112.3, and 113.3, but it is **not** a claim that every statement and
example throughout files 111--113 has now received a wholly independent
audit.  The earlier finite-group tests are not used in Theorem 115.1.

