# Audit: the quadratic-core field intersection in files 66 and 68

**Verdict:** **FAIL as written.**  The displayed quadratic-core degree
formulas in Theorem 66.4 and case B of Theorem 68.5 use a
compositum--intersection equality which is false without an additional
linear-disjointness or stability hypothesis.  The hypotheses currently
proved in those files do not supply one.  A replacement using the full
signed orbit field is under development and may recover the downstream
applications.

**Auditor and date:** /root/c14_elliptic_translation, 2026-09-04.

## Claim checked

Use the notation common to files 66 and 68:

\[
 B\subset F=k(C),\qquad E=B(t)\subset K=k(V),\qquad
 [K:F]=[E:B]=r,
\]

where \(K/F\) is cyclic of odd prime degree \(r\), and

\[
 [F:B]=[K:E]=e.
\]

In case B, the hyperelliptic square root does not lie in \(E\), so

\[
 E'=E(z),\qquad [E':E]=2,\qquad [K:E']=e/2,
\]

and \(FE'=K\).  The files put \(D=F\cap E'\) and infer

\[
 [F:D]=e/2,\qquad [D:B]=2,\qquad [E':D]=r.             \tag{A.1}
\]

The cited compositum--intersection degree formula proves (A.1) only
under an extra hypothesis such as linear disjointness over the
intersection.  It is not an identity for arbitrary finite separable field
pairs.

## Exact surviving field dichotomy

Put

\[
                              h=[D:B].
\]

The always-valid compositum inequality gives

\[
 [K:E']=e/2\leq[F:D]=e/h,
\]

so \(h\leq2\).  Hence exactly one of the following occurs.

1. **Quadratic-core case:** \(h=2\).  Then all degrees in (A.1) are
   correct, \(F\) and \(E'\) are linearly disjoint over \(D\), and the
   normalized fiber square claimed in files 66 and 68 exists.
2. **Split-sign case:** \(h=1\), so \(D=B\),
   \[
          [F:D]=e,\qquad [E':D]=2r.
   \]
   Let \(\gamma\) be the involution of \(E'/E\).  The two multiplication
   maps
   \[
   F\otimes_B E'\longrightarrow K,\qquad
       x\otimes y\longmapsto xy,\quad x\otimes y\longmapsto x\gamma(y)
   \]
   are distinct surjections.  Their targets have total \(B\)-dimension
   \(2er\), equal to the dimension of the source.  Since the tensor
   product is reduced, they give
   \[
                         F\otimes_B E'\simeq K\times K.              \tag{A.2}
   \]
   Thus the normalized fiber product \(C\times_B E'\) has two
   components, each isomorphic to \(V\); it is not the integral
   normalized square used in the existing proofs.

The dichotomy is exhaustive.  What is missing is an argument excluding
the second case or replacing the one-sign field \(E'\).

## Concrete counterexample to the abstract field inference

The cyclic normality of \(K/F\) does not exclude the split-sign case.
Let \(K/B\) be a Galois extension with group \(A_4\), and choose

\[
 H=C_3,\qquad J=V_4,\qquad J'=C_2\subset V_4
\]

so that \(H\) and \(J'\) generate \(A_4\).  Put

\[
                   F=K^H,\qquad E=K^J,\qquad E'=K^{J'}.
\]

Then

\[
\begin{array}{c|c}
\text{degree} & \text{value}\\ \hline
[K:F] &3\\
[F:B]&4\\
[E:B]&3\\
[K:E]&4\\
[E':E]&2\\
[K:E']&2,
\end{array}
\]

\(K/F\) is cyclic, \(FE=FE'=K\), but

\[
                 F\cap E'=K^{\langle H,J'\rangle}=K^{A_4}=B.
\]

By the primitive-element theorem one may write \(E=B(t)\), and in
characteristic different from two one may write \(E'=E(z)\) with
\(z^2\in E\).  Moreover, taking an unramified \(A_4\)-cover of a curve
shows that etaleness of both \(K/F\) and \(K/E'\) does not repair the
field inference.

This example does not by itself realize the additional special equation
\(z^2=f(t)\) coming from a fixed hyperelliptic curve \(Y\).  Such an
equation is therefore the only remaining place where a new argument might
exclude (A.2).  No argument in files 66 or 68 uses it to establish
linear disjointness, so the present theorem is unproved even if that
extra geometry ultimately rescues the intended conclusion.

## Statements which survive

The following parts do not use the failed equality.

- Proposition 47.2: if \(z\notin E\), then \(e\) is even,
  \(E'/E\) is quadratic, \([K:E']=e/2\), and
  \(E'\to Y\) and \(V\to E'\) are finite etale.
- All of case A in Theorem 68.5.
- In case B, vanishing of the direct coefficient norm
  \(q_*h=0\), inclusion of the norm image in
  \(\operatorname{Prym}(C/B)\), and the bound
  \(g(B)\leq(M-r)s\).  These follow by pushing through
  \(E'\to E\to B\) and do not require \(D\).
- Every coefficient-degree-two application.  When \(e=2\), one has
  \(E'=K\), hence \(F\cap E'=F\) and \([F:B]=2\) automatically.
  In particular, the quadratic rows analyzed in files 47, 53--63, 74,
  78, 79, and 80 retain their field-theoretic foundation.
- The implication \(e\) odd \(\Rightarrow z\in E\) remains valid,
  since a quadratic intermediate extension cannot lie in an odd-degree
  extension \(K/E\).

The following require the new hypothesis \([F\cap E':B]=2\), or a
replacement construction.

- Theorem 66.4, Corollary 66.5, and the quadratic-core part of
  Theorem 68.5 after the direct Prym bound.
- The lower bound \(d\geq r\) in case B and the case-B half of
  Corollary 68.6.
- The case-B endpoint and complementary-divisor arguments in files 73
  and 75 when the coefficient degree exceeds two.

## Immediate route consequences before repair

- The \(e=2\) and \(e=1\) analyses inside file 78 remain valid, as do
  its discriminant-double-plane lemmas.
- The proof of the complete \(M=6\) reduction in Theorem 78.1 has two
  newly unhandled formal case-B rows:
  \[
                (e,d_{\rm coeff})=(4,3)\quad\text{or}\quad(6,2).
  \]
  The first was excluded only by the affected endpoint theorem; the
  second was omitted only because of the affected bound \(d\geq r\).
  This is a proof gap, not a claim that either row is geometrically
  realizable.  The full-orbit repair under development may eliminate
  them.
- The \(M=7\) reduction in files 79--80 is unaffected: in case B,
  \(ed=14\), nondegeneracy and \(\dim W\geq3\) exclude
  \((e,d)=(14,1)\), leaving \(e=2\).  Statements combining it with an
  already-complete \(M=6\) theorem must wait for the repair.
- The degree-five result of file 76 can be repaired without the faulty
  divisor sieve: case B has \(ed=10\); the only extra formal choice
  \(e=10,d=1\) cannot support a nondegenerate coefficient system of
  dimension at least three.

## Non-breaking suggestions

- Replace the asserted binary dichotomy by the exhaustive
  quadratic-core/split-sign dichotomy above.
- The full cyclic orbit field generated by all translates of
  \((t,z)\) is stable under the deck group and is the natural source of
  a valid replacement core.  Its degrees must be proved directly; it
  cannot be identified with \(F\cap E'\) by the old argument.

