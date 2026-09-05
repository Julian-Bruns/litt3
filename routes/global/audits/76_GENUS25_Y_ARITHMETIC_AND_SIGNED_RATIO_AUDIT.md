# Audit: genus-25 target arithmetic and the signed root-ratio lemma

**Date:** 2026-09-04  
**Auditor:** Codex subagent `/root/c14_elliptic_translation`  
**Verdict:** **PASS.**

**Checked source SHA-256 values:**

- file 76: `931453592614c616454212d6ec451fa3bd21ab0cdd638d08a342a5d6b88ef8e6`;
- file 76 certificate: `be7f445c6e894be9bb94a7821eb47d5bdeef7e720271a0ad53fd6d556e82b420`;
- file 98 as consulted for the signed-cycle deductions:
  `71007b444dc7c04a25b48d5e83c4c19d1cc064bd83833e4341ad2491295d9e5b`;
- file 98 certificate:
  `113cfd95a2e457de837c498f8d21a23a2a6d705bad9c5dd6845ca8a1ed004c6b`.

The standalone root-ratio lemma audited below was supplied separately by the
root agent and had not yet been assigned a theorem-file revision hash.  The
proof is therefore included here in full.

## Exact source and computation checks

Only the genus-25 curve was recomputed; no assertion about the genus-nine
curve or its number field was included in this audit.  The checked model is

\[
 Y:\quad z^2=(t^{25}+t^5+t)(t^{25}+t^5+t-1)(t-4)
 \quad\text{over }\mathbf F _5.
\]

Using SageMath 10.9, the genus-25 portion of
`76_EXPLICIT_R3_REDESIGN_CERTIFICATE.sage` was run in isolation.  Its exact
assertions verified:

1. the right side has degree 51 and is square-free, and the resulting smooth
   hyperelliptic curve has genus 25;
2. its 51 finite branch points are distinct and split completely over
   \(\mathbf F _{125}\);
3. Sage's independent `HyperellipticCurve.frobenius_polynomial()` output is
   exactly
   \[
                   P_Y(T)=T^{25}Q_Y(T+5/T)
   \]
   for the integer polynomial \(Q_Y\) printed in file 76;
4. \(P_Y\) is a Weil polynomial, its middle coefficient is prime to 5, and
   \(P_Y\bmod47\) is irreducible; and
5. the square-free factorization degrees of \(Q_Y\) modulo
   \(47,173,467\) are respectively \((25),(24,1),(23,2)\).

The isolated run ended with

```text
PASS: isolated genus-25 Y certificate
```

The separate exact command

```text
sage -c "load('routes/global/98_SIGNED_FROBENIUS_CERTIFICATE.sage')"
```

also passed.  In addition to rechecking the preceding \(Q_Y\)-factorizations,
it verified the square-free degrees

\[
\begin{array}{c|cc}
 \ell&Q_Y\bmod\ell&P_Y\bmod\ell\\ \hline
 47 &(25)&(50)\\
 467&(23,2)&(46,4),
\end{array}
\]

the indicated powers of the corresponding signed permutations, and the
rank-25 span of the sign kernel.  Thus the deduction

\[
 \operatorname{Gal}(P_Y)=\mathbf F _2^{25}\rtimes S_{25}
\]

is supported by exact computations.  For completeness, file 76's three
factor patterns give \(\operatorname{Gal}(Q_Y)=S_{25}\): they give a
transitive action, a 24-cycle with one fixed point (hence primitivity), and a
transposition (the 23rd power of a \((23)(2)\)-element).  At 467 the two
pair-cycles are negative, so the 46th power is a weight-two switch; at 47 the
negative 25-cycle has 25th power the all-ones switch.  Conjugates of the first
span the even-weight hyperplane, and adjoining the second spans the entire
sign kernel.

## Standalone lemma checked

Let \(A/\mathbf F_q\) be an actual abelian variety of dimension \(g\ge3\),
let \(P\) be its Frobenius characteristic polynomial, and suppose the natural
Galois action on its \(g\) reciprocal pairs of distinct roots is the full
signed wreath product

\[
                  (C_2)^g\rtimes S_g.
\]

Then:

1. the ratio of two distinct roots of \(P\) is never a root of unity;
2. for every \(n\ge1\), the Frobenius characteristic polynomial over
   \(\mathbf F_{q^n}\) is irreducible of degree \(2g\);
3. \(A\) is absolutely simple; and
4. writing \(\pi\) for Frobenius,
   \[
              \operatorname{End}^0_{\overline{\mathbf F}_q}(A)
                         =\mathbf Q(\pi).
   \]

### Proof audit

Label the reciprocal pairs
\(\{\alpha_i,q/\alpha_i\}\).  Suppose first that roots from distinct pairs
satisfy \(\alpha_i/\alpha_j=\zeta\), with \(\zeta\) a root of unity.  The
full sign kernel contains an automorphism \(\tau\) which flips only pair
\(i\) and fixes \(\alpha_j\).  Therefore

\[
 {\zeta\over\tau(\zeta)}
 =\frac{\alpha_i/\alpha_j}{(q/\alpha_i)/\alpha_j}
 =\frac{\alpha_i^2}{q}
\]

is a root of unity.  If the two original roots belong to the same reciprocal
pair, their ratio is already \(\alpha_i^2/q\), so the same conclusion holds
directly.

The signed wreath product is transitive on all \(2g\) roots.  Hence every
root \(\beta\) would satisfy \(\beta^2/q\in\mu_\infty\).  After fixing
\(\sqrt q\), this says \(\beta/\sqrt q\in\mu_\infty\).  Since there are only
finitely many roots, the splitting field of \(P\) would then lie in

\[
                     \mathbf Q(\sqrt q,\mu_N)
\]

for some \(N\).  This is an abelian extension of \(\mathbf Q\), contradicting
the full nonabelian signed wreath Galois group.  This proves (1).

If two roots had equal \(n\)-th powers, their ratio would be an \(n\)-th root
of unity.  Thus powering is injective on the roots.  The Galois orbit of
\(\pi^n\) consequently still has \(2g\) elements, so its minimal polynomial
has degree \(2g\) and equals the Frobenius characteristic polynomial over
\(\mathbf F_{q^n}\).  This proves (2).

Honda--Tate decomposition now makes \(A_{\mathbf F_{q^n}}\) simple for every
\(n\); any geometric abelian subvariety descends over a finite extension, so
\(A\) is absolutely simple.  For a simple abelian variety over a finite
field, the characteristic polynomial is the minimal polynomial of Frobenius
raised to the Schur index of its endomorphism division algebra.  Here that
exponent is one for every \(n\), hence

\[
       \operatorname{End}^0_{\mathbf F_{q^n}}(A)=\mathbf Q(\pi^n).
\]

Both \(\mathbf Q(\pi^n)\) and \(\mathbf Q(\pi)\) have degree \(2g\), while
the former is contained in the latter, so they are equal.  Every geometric
endomorphism is defined over some finite extension.  Taking the union over
\(n\) proves (3)--(4).

Applied to the computed \(P_Y\), this proves absolute simplicity and
\(\operatorname{End}^0 J(Y)=\mathbf Q(\pi_Y)\) without an ordinarity or
Howe--Zhu hypothesis.  The independently checked ordinary coefficient is
still correct, but is not needed for this implication.

## Breaking objections

None.

## Non-breaking precision suggestions

When stating the lemma, retain the words **actual Frobenius characteristic
polynomial** and interpret "full reciprocal splitting group" as the natural
signed action on \(2g\) distinct roots.  These hypotheses make the
Honda--Tate and transitivity steps explicit.  No claim about the genus-nine
curve or the number-field discriminant was audited here.
