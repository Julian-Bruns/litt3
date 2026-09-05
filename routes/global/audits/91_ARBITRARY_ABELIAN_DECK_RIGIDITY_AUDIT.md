# Audit: arbitrary abelian deck rigidity

**Date:** 2026-09-04  
**Auditor:** Codex subagent
`/root/x_elliptic_quotient_maps/abelian_deck_group_theory`  
**Audited SHA-256:**
`ebd434108cbbc512964d9235e12f7a1829e6d1e0eafae0a804ae51c51251a748`  
**Verdict:** **PASS.**

## Scope checked

The audit checked Theorem 91.1, with particular attention to:

- passage to a minimal overgroup \(H<M\) and the core quotient;
- the proof that the resulting faithful primitive action is Frobenius;
- injectivity of geometric point stabilizers modulo the core;
- the claim that their nonidentity images are derangements;
- construction of the residual etale cover of \(\mathbf P^1\), including in
  wild characteristic; and
- failure of a normal-complement argument for arbitrary self-normalizing
  abelian subgroups.

## Breaking objections

None.

## Non-breaking suggestions and boundary

The auditor recommended phrasing the last step directly with the inverse
image of the Frobenius kernel: all point stabilizers lie in it, so the
residual quotient is etale.  This avoids unnecessary language about normal
generation by inertia and is the formulation used in the theorem.

The proof does not extend as written to nonabelian deck groups.  The example

\[
  \mathbf F_5^2\rtimes S_3\supset
  L\times\langle t\rangle\simeq C_{10}
\]

was also checked as a warning that a self-normalizing abelian subgroup need
not possess a normal complement.  Thus the minimal-overgroup/Frobenius step
is essential.

## Addendum: simple-Jacobian and hyperelliptic common-cover corollaries

**Additional verdict (2026-09-04): PASS.**

Corollary 91.3 is valid.  If \(H_Y\) is the deck group over \(Y\), then
Theorem 91.1 gives

\[
                         H_Y\le \operatorname{Aut}(D)=H.
\]

Since \(H\) is abelian, \(H_Y\triangleleft H\), and freeness of the
\(H\)-action makes the induced quotient

\[
                         Y=D/H_Y\longrightarrow D/H=X
\]

finite etale with group \(H/H_Y\).  If its degree were greater than one,
pullback \(J(X)\to J(Y)\) would have positive-dimensional image.  Simplicity
of \(J(Y)\) makes that image all of \(J(Y)\), hence \(g(X)=g(Y)\), while the
etale Riemann--Hurwitz formula then rules out degree greater than one.
Therefore \(H_Y=H\) and \(Y\simeq X\).

Corollary 91.4 also needs no separate abelianness assumption on the deck
group over the hyperelliptic curve: it is automatically the subgroup
\(H_Y\le H=\operatorname{Aut}(D)\).  The fixed-point-preserving lift of the
hyperelliptic involution then gives the stated contradiction.
