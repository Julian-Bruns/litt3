# Audit: degree-six plane contact and spectral discriminant

**Verdict:** **PASS.**  No breaking mathematical objection was found in
file 78.  In particular, the characteristic-five plane-orbit
classification, the singularity and crepant-resolution calculations, the
rational lift, and the Hodge--adjunction genus bounds used in Theorem 78.10
are valid.

**Auditor and date:** `/root/genus2_counterexample_variant`, 2026-09-04.

## Checks performed

### The degree-six reduction

- Re-enumerated Corollary 68.6 at \(r=3,M=6\).  Case A has
  \((n,e)=(3,2),(6,1)\), while case B has
  \((d,m,e)=(3,2,4),(6,1,2)\).  Theorem 75.2 excludes the first
  case-A row and Theorem 75.3 excludes the first case-B row because the
  complementary degree is two and \(\operatorname{gon}(X)=3\).  Thus the
  two rows in Theorem 78.1 are exhaustive.
- Recomputed the Castelnuovo bounds
  \(\operatorname{Cast}(12,3)=25\) and
  \(\operatorname{Cast}(6,3)=4\).  They force \(w=3\) in both surviving
  rows.  The plane genera are respectively \(55\) and \(10\), giving
  delta invariant \(6\) in the birational row and
  \(g(B)\in\{9,10\}\) in the quadratic row.  Riemann--Hurwitz gives
  \(|\Delta|=100-4g(B)=64,60\), as stated.

### Incidence and the nonabelian spectral closure

- Checked the finite-flat discriminant computation in Lemma 78.3.
  A divisor of class \(A\boxtimes\mathcal O(3)\) has square \(6n\),
  canonical intersection \(3(2g-2)-2n\), and arithmetic genus
  \(3g+2n-2\).  The trace-discriminant line has degree
  \(6(g+n-1)\), and passage to the normalization accounts for exactly
  twice the conductor length.  Reduction of the trace form modulo a
  uniformizer proves the support bound (78.12), including for nonreduced
  fibers.
- Recomputed both incidence tables.  In the birational row they are
  \((p_a,g,\delta,\deg\mathrm{Diff},\deg\mathrm{Disc})
   =(169,145,24,312,360)\).  In the cyclic quadratic row they are
  \((37,25,12,60,84)\) and \((40,28,12,66,90)\).  Thus the stated
  slacks \(48\) and \(24\) are exact.
- In the \(S_3\) case, inertia above every point of \(\Delta\) is a tame
  transposition: it is nontrivial in \(F/B\) and has trivial intersection
  with the etale \(C_3\)-extension \(K/F\).  Its degree-three action has
  different contribution one.  Hence Riemann--Hurwitz gives
  \(g(E)=57,58\), whereas the integral incidence cubics have arithmetic
  genus \(37,40\).  Proposition 78.5 is therefore correct.

### Plane sections of the binary-cubic discriminant

- Checked the orbit classification without using a characteristic-zero
  specialization.  Since \(5>3\), the apolar pairing is nondegenerate.
  Hyperplanes are consequently classified by the three root-multiplicity
  types of their nonzero dual binary cubic.  Restriction to the
  triple-root twisted cubic shows directly that the displayed planes have
  intersection types \(1+1+1\), \(2+1\), and \(3\), so they represent
  all three orbits.
- Substituted the three plane equations into the discriminant.  For
  \(b+c=0\), an exact characteristic-five derivative calculation gives
  precisely the three singular points
  \([1:0:0]\), \([0:0:1]\), and \([1:2:4]\); each has a doubled tangent
  and a nonzero transverse cubic term, hence is an ordinary cusp.  The
  quartic is geometrically irreducible (equivalently, its double-root
  parametrization is a degree-four rational parametrization).  For
  \(b=0\), the branch is the line \(a=0\) and the irreducible cuspidal
  cubic \(4c^3+27ad^2=0\); they meet with multiplicity three at a smooth
  point of the cubic, away from its cusp.
- At a branch cusp the double plane has completed local equation
  \(uv=x^3\), an \(A_2\) point.  At the order-three contact it has
  completed local equation \(uv=x^6\), an \(A_5\) point.  Both are tame
  ADE equations in characteristic five and their minimal resolutions are
  crepant.  In the third orbit, adjoining \(w/b\) gives exactly the smooth
  quadric \((w/b)^2=c^2-4bd\), so the normalization claim is correct.
- A square discriminant on \(k(\Gamma)\) selects a generic sheet of the
  double plane.  The induced rational map from the smooth normalization
  of \(\Gamma\) extends by properness; its generic point lies in the
  smooth locus, so the map also lifts to the minimal resolution.  The
  image is birational to \(\Gamma\), not a multiple cover.
- In types 1 and 2, the pullback \(H\) of a line satisfies
  \(H^2=2\), \(K=-H\); on the normalized type-3 quadric,
  \(H^2=2\), \(K=-2H\).  Hodge index and adjunction therefore give
  exactly
  \(g(\Gamma^\nu)\le n^2/4-n/2+1\) and
  \(g(\Gamma^\nu)\le n^2/4-n+1\), respectively.
- Finally, a separable irreducible cubic has square discriminant exactly
  when its Galois group lies in \(A_3\).  This applies both to the given
  etale \(C_3\)-torsor in the birational row and to the etale cyclic cubic
  \(E/B\) in the quadratic row.  At degrees \(12\) and \(6\), Lemma 78.9
  gives genus bounds \(31\) (or \(25\)) and \(7\) (or \(4\)), contradicting
  genera \(49\) and \(9,10\).  Theorem 78.10 follows.

## Non-breaking suggestions and objections

- Lemma 78.8's phrase “direct differentiation” is correct but terse.  For
  ease of future checking, the theorem file could display the three
  singular points of the type-1 quartic and the local equations
  \(uv=x^3\), \(uv=x^6\).  No certificate is needed for the proof.
- In Lemma 78.9, one sentence saying that the generic lift avoids the
  singular locus, and hence gives a rational map to the resolution before
  properness is invoked, would make the extension step more explicit.
- The Hodge-index step uses a nef and big pullback class rather than an
  ample one because it is orthogonal to exceptional curves.  The stated
  inequality is still valid (by the Hodge index theorem, or by an ample
  perturbation); noting this would remove a possible presentational
  hesitation.
- “Integral binary cubic” in Lemma 78.3 should be read as saying that the
  resulting incidence divisor is integral.  Making that wording explicit
  would clarify why no fixed component occurs.

## Audited revision hash

- file 78:
  `f919fbb21423a04489ec7711bc3d0cc7e3bc8aecc8bf2d0ed9a693ef13e8c33f`
