# Audit: sign norm branch carrier and coprime descent

**Verdict:** **PASS.** The sign norm defines the claimed canonical
degree-at-most-two field, the inertia calculation remains valid in the
split case `E' = E`, and the coprime descent and spectral genus bounds all
follow with the stated hypotheses. No breaking objection was found.

**Auditor and date:** `/root/c14_elliptic_translation`, 2026-09-04.

## Checks performed

- The product `w = product(z_i)` is fixed by the deck cycle and by the
  selected-sign stabilizer. Hence `A = B(w)` lies in `D` and in `F`, and
  its sign character has kernel with fixed field exactly `A`. Its square is
  the ordinary norm of `f(t)` for the degree-`r` field `E/B`.
- The selected sign orbit is beta-stable and contains the zero selection.
  Since an `r`-cycle fixes only the zero and all-one selections, `j` is
  congruent to 1 or 2 modulo `r`; hence `r` does not divide `j`. The
  faithful action `H_0 <= S_r` and the cycle in `H_0` give
  `v_r(|H_0|) = v_r(|H|) = 1`.
- Inertia acts freely on all `2r` formal signed roots. This remains correct
  when `E' = E`: the positive and negative roots may form two separate
  `H`-orbits, but their stabilizers agree, and `L/E' = L/E` is etale.
  Transitivity is not needed for freeness or for `|I|` dividing `2r`.
- This divisibility bounds inertia before tameness is invoked. It is
  therefore harmless if the characteristic divides `|H|`: because it
  divides neither 2 nor `r`, inertia is tame cyclic of order 1, 2, `r`, or
  `2r`.
- A signed-root-free involution has odd total sign parity. Fixed
  coordinates contribute an odd number of flips, while transposed pairs
  contribute evenly. Intersecting inertia with the even-sign kernel thus
  leaves order 1 or `r`.
- The towers `K/L/A` and `K/F/A` justify the ramification statement for
  `C/A`: `K/L` and `K/F` are etale, so the local ramification indices of
  `F/A` are those of `L/A`, namely 1 or `r`.
- In the coprime case, `[K:L]` divides `m`. A beta-fixed point on `L`
  would make its etale fiber in `K` a union of free `r`-orbits, forcing
  `r` to divide `[K:L]`. Thus beta is free on `L`. Since the `r`-part of
  `|H|` is exactly `r`, all order-`r` subgroups are conjugate and no
  order-`r` inertia survives. Hence `L/A` and then `K/A`, `C/A`, and
  `D/A` are etale.
- Etale Riemann--Hurwitz and `M = mjd/2` give the two genus identities in
  (83.3) and the asserted degree of `C/A`.
- For square sign norm, the sign character is trivial, excluding all even
  inertia. Thus the degree-`lambda` map `E'/E`, for `lambda = 1` or 2, is
  etale. The degree of `E' -> Y` is `lambda*d/2`, giving
  `g(E) = drs/2 + 1`.
- Adjunction for the degree-`(r,d)` spectral incidence divisor gives
  arithmetic genus `r*b + (r-1)(d-1)`. Comparison with its normalization
  and the birational plane-genus bound gives `d >= s+1+2/r`, hence
  `d >= s+2`; the coprime equality sharpens this to `d >= s+3`.

## Non-breaking suggestions and objections

- In Theorem 83.1(2), explicitly noting that the signed roots can split
  into two orbits when `E' = E` would make clear why equal stabilizers,
  rather than transitivity, suffice.
- The etaleness sentence in (83.2) could first compose `K -> L -> A` to
  obtain `K/A` etale and then pass to the intermediate field `F`. This is
  what the proof uses and entails no mathematical change.

**Audited revision SHA-256:**

`c26610108514841f202c7d2344c724bd66ddcc680d475a122b451b5beacb9326`

