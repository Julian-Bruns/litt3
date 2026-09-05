# Audit: degree-nine cross-correspondence rank obstruction

**Verdict:** **FAIL AS STATED; the rank-five-or-seven conclusion is valid
conditional on all six cross maps being birational onto their images.**

**Auditor and date:** `/root/m9_rank_obstruction_audit`, 2026-09-04.

**Substantive objection:** Proposition 48.1 does not exclude generic image
degree (e_j=3).  With

\[
 L=F_0F_j,qquad B=F_0\cap F_j,
\]

the displayed hypotheses give

\[
 [K:L]=3,qquad [L:F_0]=[L:F_j]=3,
\]

but they do **not** give ([F_j:B]=3).  The latter equality requires a
linear-disjointness assertion which has not been proved.  In general one
only has

\[
 [L:F_0]\le [F_j:B].
\]

Conjugacy by an element of order seven does not repair this field-theoretic
step.  For example, in (A_7), take

\[
 \beta=(1\,2\,3\,4\,5\,6\,7),qquad
 H=\langle(1\,3\,5),\,\beta(1\,3\,5)\beta^{-1}\rangle,
 \qquad H'=\beta H\beta^{-1}.
\]

Then (|H|=|H'|=9), (|H\cap H'|=3), but

\[
                         |\langle H,H'\rangle|=36.
\]

Thus, in an (A_7)-Galois field, the corresponding fixed fields satisfy
all three degree statements above while
([F_j:F_0\cap F_j]=36/9=4), not (3).  This is a counterexample to the
field-lattice inference, not an assertion that this particular group
example realizes the curve diamond.

The gap is essential for Theorem 48.5.  If (e_j=3), the normalization
(Z_j) of the reduced image has two etale degree-three maps
(f_j,g_j:Z_j\to Y), and (V\to Z_j) is etale of degree three.  With the
orientation of the note,

\[
 u_j=3w_j,qquad w_j=f_{j*}g_j^*\ne0.
\]

The nonvanishing follows from Theorem 45.4.  Formula (45.17) and graph
intersections give the exact residual small-endomorphism problem

\[
 \operatorname{Tr}(w_j^\dagger w_j\mid H^1(Y))\le102,
\]

\[
 |\langle w_j,F^s\rho^b\rangle|
       \le 3(1+5^s)=6,18,78
       \quad(s=0,1,2;\ b\in\mathbf Z/31).
\]

These bounds would force (w_j=0) if (w_j) belonged to the
coefficientwise crossed order used conditionally in file 49.  Membership
in that order is not known: the completion of the actual geometric
endomorphism ring at (31) is precisely the missing integral input.

**Non-breaking suggestions and checked surviving claims:**

- The exclusion of (e_j=9) is correct.  The automorphism group used there
  is proved in file 20, not file 40.
- Proposition 48.2 and Corollary 48.3 have the correct signs and constants.
  Their conclusions do not actually require (e_j=1): after excluding
  (e_j=9), use the effective pushforward cycle
  ((a,a\beta^j)_*[V]=e_j[\Gamma_j]).  This gives
  (|\operatorname{Tr}(u_j^\dagger q_b)|\le18),
  (0\le I_j\le36), (delta\le108),
  (D^2=2\delta-252\le-36), and
  (162\le\operatorname{Tr}(s)\le378).
- Proposition 48.4 is correct.  The invariant summand has
  (mathscr D)-rank one; irreducibility of (Phi_7) over (E) and the
  centralizer theorem give (6\mid3(r-1)), hence
  (r\in\{3,5,7\}).
- Conditional on every (e_j=1), the use of (45.17), the cohomological
  rank (30r), and all Gram calculations are correct:

  \[
  \operatorname{Tr}(G)=1890,qquad
  \operatorname{Tr}(G^2)=7(2430+Q),qquad
  Q\ge17010/r-2430.
  \]

  Together with (Q\le2484), these do exclude (r=3), and for (r=5)
  give (Q\ge972).
- For complete rigor, the Cauchy step may say explicitly that the positive
  involution on the semisimple real endomorphism algebra realizes
  (G=\mathcal E^\dagger\mathcal E) as a positive-semidefinite operator.
  This is a clarification, not a flaw.
- No additional characteristic-five inseparability issue was found: all
  relevant field extensions in the image factorization are subextensions
  of the given finite-etale maps.
- The sentence introducing the circulant matrix is duplicated immediately
  before (48.15).

**Audited revision:** SHA-256
`f32bc1426ff23809ce4fb2bdf8ac92737f9d59241d3c3370789b9c3e5a08e81a`.

Any mathematical rewrite of Proposition 48.1 or Theorem 48.5 makes this
revision-specific audit stale and requires a fresh check.

**Post-audit disposition:** the theorem file was rewritten on 2026-09-04
to state only \(e_j\in\{1,3\}\), to make Theorem 48.5 conditional on all
\(e_j=1\), and to prove Proposition 48.2 with the effective pushforward
cycle.  The repaired revision has SHA-256
`12e5accbf836c2a35b114a51bd672b06af426626edce31342f9058e4f5203134`.
Those changes implement this audit, but the new revision has not received a
second independent line-by-line audit.
