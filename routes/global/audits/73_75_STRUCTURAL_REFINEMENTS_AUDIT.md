# Audit: files 73--75, coefficient endpoints and Prym packing

**Verdict:** **PASS.** No breaking mathematical objection or required
correction was found in files 73, 74, or 75.

**Auditor and date:** `/root/c14_elliptic_translation`, 2026-09-04.

## Checks performed

- The norm-zero lemma in file 73 is valid in arbitrary separable degree.
  Vanishing of (q_*b^*) makes the degree-(m) divisors
  (b_*q^*(d)) linearly equivalent.  They move because (b) is
  surjective, and their common base locus is empty because, for fixed
  (x), only the finite set (q(b^{-1}(x))) of parameters contains
  (x).  A base-point-free pencil therefore gives a degree-(m) map.
- The pull--push identities in the normalized coefficient squares have
  no missing degree factor.  They are the divisor/norm base-change
  identities
  (p_*s^*=q^*\pi_*).  Locally, for a point (x) over (b), the sum
  of the ramification indices after normalized base change is
  (e(x/b)).  At the defect-free endpoints in file 73 both lower maps
  are etale, so the fiber product is already normal and the identity is
  ordinary finite-flat base change.  File 75 also states the resulting
  factorization as an explicit hypothesis before using it.
- At each endpoint of file 73, the lower map from (J(Y)) is nonzero by
  the gonality/norm lemma in file 68.  Simplicity of (J(Y)), together
  with equality of source and target dimensions, makes it an isogeny.
  Cancelling this isogeny in the rational Hom group and dualizing
  correctly yields the zero norm to which Lemma 73.1 applies.
- In file 74, (q_*c^*=0) would imply
  ((c\delta)^*=-c^*), and signed pullback rigidity really does force
  hyperellipticity.  Similarly, vanishing of the anti-invariant map
  forces (c\delta=c); when (q) is ramified this would factor the
  etale map (c) through a ramified double cover, which is impossible.
- The invariant and anti-invariant maps out of (J(X)) have their full
  dimension whenever nonzero because (J(X)) is simple.  The
  anti-invariant image is orthogonal to the norm image: (c_*h=0),
  self-adjointness of (delta^*), and
  (delta^*|_{\operatorname{im}h}=-1) give both required
  orthogonalities.  Positive definiteness of the restricted
  polarizations makes the intersection finite, so the dimension count
  and the interval in (74.13) are correct.
- The unramified calculation in file 74 is exactly etale
  Riemann--Hurwitz.  Its combination with the case-B genus bound gives
  ((M-2r)s\ge2), and the ramified interval is nonempty exactly when
  ((M-r-2)s\ge2).  All listed endpoint consequences follow.
- In file 75, for
  (v=(q_0)_*c^*), the adjoint identity
  (v^\dagger h_0=c_*q_0^*h_0=c_*h=0) proves orthogonality.  Simplicity
  is used correctly and only to turn each nonzero map into a
  full-dimensional image.  The inequalities with
  (g(D)\le ns+1) or (g(D)\le ds+1) then force respectively
  (n\ge r+2) or (d\ge r+2), with no off-by-one error.

## Non-breaking suggestions and objections

- In Lemma 73.1, one optional sentence saying that two general sections
  of the globally generated line bundle have no common zero would make
  the final pencil step completely explicit.
- In Theorem 73.2, the phrase “finite-flat base change in the normalized
  fiber square” is correct, but at that endpoint it can be simplified:
  both lower maps are etale, so their fiber product is already normal.
- “Absolutely simple” can be weakened to “simple” everywhere in these
  three arguments.  The stronger hypothesis is harmless and matches the
  surrounding route.

**Audited revision SHA-256:**

- file 73: `694df9b05dfa718ddf78a31079a4a7eef56aa713a3fa3157ab87a71a8b3b70df`
- file 74: `ffd9beb535040ca03fbcc0ec15c815c521f6172c68a398f6b379e469fac65029`
- file 75: `371b0643182ae76b19877bb5f360b1e456d9648d6392480bd1b4d40b8afc89e8`
