# Audit: branch-rigid abelian prime-power covers

**Date:** 2026-09-04  
**Auditor:** Codex subagent
`/root/x_elliptic_quotient_maps/abelian_p_index_group_audit`  
**Audited SHA-256:**
`2d5340a40d8fcadb83799c0d203f1ffbc3ff03722e100da607ec9b2f7ae06ac7`  
**Verdict:** **PASS.**

## Scope checked

The audit checked Theorem 92.1 through Corollary 92.4, especially:

- the Sylow and branch-stabilizer reductions, including equal
  characteristic;
- the three possibilities for (Z(J_o(P))), where (J_o(P)) is generated
  by abelian subgroups of maximum order;
- the reduction through (D/Z(P)\to X) in the multiple-maximal-subgroup
  case;
- the precise hypotheses of the Glauberman--Thompson normal
  (p)-complement theorem;
- the normal-closure and residual-etale-cover argument; and
- compression of an arbitrary second Galois deck group to a cyclic
  (p)-group over the hyperelliptic curve.

The primary source was checked directly: G. Glauberman, *A characteristic
subgroup of a (p)-stable group*, Canadian J. Math. 20 (1968), Theorem D,
p. 1105, with (J_o) defined using maximum **order** on p. 1104.  Theorem D
has no additional (p)-stability or (Qd(p))-exclusion hypothesis.  The
restriction to odd (p) is essential.

## Checked group-theoretic point

If the nonabelian Sylow (p)-subgroup (P) has an abelian index-(p)
subgroup (H), then (H) has maximum possible abelian order.  If it is
the unique such subgroup, (Z(J_o(P))=H).  If there is a second one (H'),
then

\[
 H\cap H'=Z(P),\qquad [P:Z(P)]=p^2,\qquad J_o(P)=P.
\]

Indeed, (H) and (H') are normal and generate (P); their intersection
centralizes both.  Conversely a central element outside either subgroup
would enlarge that maximum-order abelian subgroup.  The separate abelian
case gives (Z(J_o(P))=P).  These alternatives justify every application
of Glauberman--Thompson in the proof.

In the multiple-subgroup case, (D/Z(P)\to X) is cyclic etale of degree
(p).  Files 87.5--87.6 make its automorphism group a (p)-group, and the
natural map

\[
 N_{\operatorname{Aut}(D)}(Z(P))/Z(P)
   \hookrightarrow \operatorname{Aut}(D/Z(P))
\]

is injective.  Thus the required characteristic-subgroup normalizer is a
(p)-group.  After obtaining a normal (p)-complement, the normal closure
of (H) has free Sylow (p)-subgroups; if it were larger than (H), the
proof would produce a nontrivial connected etale cover of
(\mathbf P^1).  This establishes normality and the asserted order bound.

The common-cover compression is also complete.  For a second deck group
(B\not\subseteq H), the subgroup (N=H\cap B) is normal in (HB), and
(B/N=C_p).  On (D/N), both induced actions remain free.  The
hyperelliptic involution then lifts through the cyclic cover and conflicts
with the odd (p)-group automorphism group.

## Breaking objections

None.

## Non-breaking suggestions and boundary

When (H/(H\cap B)=1) in Theorem 92.3, the first compressed cover is the
trivial cover (D_0=X).  The trivial-cover clause of Theorem 92.1 already
handles this; spelling it out would only make the edge case more visible.

The proof must not replace (J_o) by a Thompson subgroup defined using
maximum rank or maximum elementary-abelian order.  It also does not address
nonabelian deck groups over (X), or common covers whose maps are not
Galois.
