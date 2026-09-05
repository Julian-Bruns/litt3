# Audit: Frobenius-graph trace lattice

**Verdict:** **PASS.**  No breaking objection.  In particular, none of the
results imports the invalid birationality claim from file 48: all degree-nine
graph bounds are applied to the effective pushforward cycle with its generic
multiplicity retained.

**Auditor and date:** `/root/frobenius_trace_lattice_audit`, 2026-09-04.

**Non-breaking suggestions or objections:**

- In Proposition 49.1, the proof explicitly excludes a common component for
  the graphs of \(q_{s,b}\), then uses nonnegativity also for the graphs of
  \(\iota q_{s,b}\).  The latter exclusion follows by the same argument:
  for \(s>0\) the normalized projection degrees differ, while for \(s=0\)
  equality would imply \(a\beta^j=\iota\rho^b a\) and hence
  \((\iota\rho^b)^7=1\), impossible in
  \(\operatorname{Aut}(Y)=C_{31}\times C_2\).  Adding this sentence would
  make the two-sided bound completely explicit.
- Corollary 49.4 has a dangling word “and” immediately before “Conversely.”
  This is only a typographical defect.
- “Explicitly enumerable” in Corollary 49.4 is correct as a finite rational
  candidate list reconstructed from the trace boxes.  Deciding which
  candidates lie in the actual integral endomorphism lattice is not yet an
  effective filtered enumeration; the note itself accurately identifies this
  as the unresolved local integral problem.

## Checks performed

- For \(Z_j=(a,a\beta^j)_*[V]\), multiplicity is retained and its bidegree
  is \((9,9)\) even when the map to its reduced image has generic degree
  three or nine.  Intersecting with a Frobenius graph of bidegree
  \((5^s,1)\) gives the fiber contribution \(9(1+5^s)\).  The direct
  and hyperelliptically composed effective intersections give the stated
  absolute trace bounds.  Transposition has the same bidegrees, and
  \(u_{7-j}=u_j^\dagger\) makes those tests redundant for the complete
  six-tuple.
- The cyclic-algebra decomposition
  \(\mathscr D=K\oplus KF\oplus KF^2\), the Rosati relation
  \(F^\dagger F=5\), and vanishing of reduced trace on the two nontrivial
  cyclic components give orthogonality.  Each cyclotomic frame has Gram
  matrix \(5^s(31I-J)\), so the reconstruction denominator
  \(31\cdot5^s\) and every constant in Parseval are correct.
- Under coefficientwise integrality, dividing the \(s=1,2\) graph bounds
  gives cyclotomic trace bounds 10 and 9.  The coefficient-gap lemma then
  kills both noncommutative components.  Fourier diagonalization after
  adjoining \(\zeta_7\) is valid: the blocks lie in the degree-three
  field \(KL/L\), hence are zero or invertible, and Galois transitivity
  handles all six primitive blocks.  The invariant block is nonzero by the
  norm lemma.  Thus the conditional rank-seven conclusion is correct.
- For Proposition 49.7, integrality of reduced traces places the
  \(K\)-component in the relative codifferent.  Since \(K/E\) is tame,
  totally ramified of degree three at 31 and unramified elsewhere, its
  different is \((1-\zeta_{31})^2\).  Third cyclic finite differences
  therefore have trace divisible by 31.  Their reduction is a polynomial
  function of degree at most two on \(\mathbf F_{31}\).  A nonconstant
  linear function has 31 values and a genuine quadratic has 16, whereas
  the trace box \([-6,6]\) has only 13 residues.  Constancy and the exact
  sum-zero relation force all 31 traces to vanish, and the tight frame then
  kills precisely the \(K\)-component.  The remaining \(KF\) and \(KF^2\)
  components are not claimed to vanish.  Finally, the conductor formula at
  \(n=3\) gives \(\langle v,v\rangle\le102\), as stated.

**Audited revision before audit-metadata insertion (SHA-256):**
`628ef27289aa512570b07053567533ed6f893e85e6a42f39d61ca47a5765a58b`.
