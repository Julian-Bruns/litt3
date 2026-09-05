# Audit: ordinary genus-two uniform orbifold degree bound

**Verdict:** **PASS**.

**Auditor:** `/root/x_elliptic_quotient_maps`

**Date:** 2026-09-05

**Target:**
[Ordinary genus-two uniform orbifold degree bound](../ORDINARY_GENUS_TWO_UNIFORM_ORBIFOLD_DEGREE_BOUND.md).

**Audited SHA-256:**
`4c9c14aa0e2fd8286770a8f9d7faaa1d01f82c509ff5ce13e870ab263cb65a82`.

## Scope

I independently checked the new degree-eight amplification, its use of the
all-degree rational-coarse classification, the exceptional-row elimination,
all positive-coarse-genus cases, and the finite-partner corollary.  In
accordance with the requested dependency scope, I relied on the linked PASS
audits for the ordinary-atlas local bound, weak and nonweak/multibranch
classification, and bounded-atlas finiteness rather than reopening those
proofs without a specific doubt.

Some of those dependency audits were previously written by this auditor.
Thus this is an independent audit of the present synthesis and amplification,
not a fresh independent re-audit of every input theorem.

## Checks

1. Since `8` is invertible in characteristic five,
   `J(C)[8](k)=(Z/8Z)^4`.  An exact-order-eight Kummer character is
   surjective, so its torsor `U -> C` is connected and etale of degree eight.
   Hence `g(U)-1=8(g(C)-1)=8`, so `g(U)=9`, and `U -> S` remains
   representable finite etale with degree
   `n_U=8 deg(C/S)`.

2. After rationality of the coarse space is assumed, the audited
   all-degree classification uses only a genus-nine atlas and an ordinary
   atlas of the same effective orbifold.  It does not require the
   genus-nine curve `U` to be ordinary, its Jacobian to be simple, or
   `Hom(J(U),J(C))=0`.  The latter is indeed false here because norm and
   pullback relate the two Jacobians.  The earlier Hom-zero condition was
   used only to force rational coarse space, which this branch assumes.

3. In the sole unbounded exceptional signature,

   \[
   e_w=3tP,\quad d_w=3tP-1+(3P+9),\quad e_t=t,\quad d_t=t-1,
   \]

   direct simplification gives

   \[
   -2+d_w/e_w+d_t/e_t=8/(3tP).
   \]

   Applying this same local signature to the original genus-two atlas gives

   \[
   2=\deg(C/S)\,8/(3tP)=8\deg(E_C),
   \]

   where `E_C` is the reduced wild fibre and
   `deg(E_C)=deg(C/S)/(3tP)` is an integer.  The forced value `1/4` is
   impossible.  Thus every exceptional row is excluded, and

   \[
   \deg(C/S)=n_U/8\le336000/8=42000.
   \]

4. For coarse genus `b=1`, positivity forces at least one stacky point;
   every nontrivial inertia contribution is at least `1/2`, so
   `2=n delta >= n/2` and `n<=4`.  For `b>=2`,
   `delta>=2b-2>=2`, hence `n<=1`.  Equality forces `b=2` and no inertia,
   so the degree-one atlas is an isomorphism.  These arguments include wild
   and non-Galois coarse maps because uniform local chart data, not global
   Galoisness, supplies the Riemann--Hurwitz terms.

5. For a fixed `X`, canonical-degree equality gives
   `deg(X/S)=(g_X-1)deg(C/S)<=42000(g_X-1)`.  This is exactly the input of
   the separately audited bounded-atlas theorem.  Its Galois closure is
   taken only over the already assumed orbifold, so the corollary proves
   finiteness of common-orbifold partners without making any simultaneous
   Galois or coreless claim.

## Objections and suggestions

**Breaking objections:** none.

**Nonbreaking suggestion:** the rational-coarse paragraph could list the
individual classification files in addition to the composite audit link,
making the precise dependency chain easier to locate.  The present link and
its recorded scope are mathematically sufficient.

The theorem does not address coreless bi-etale correspondences; its final
scope warning is necessary and correct.
