# The original contact bounds the first Frobenius-instability height

ID: `first_section_trace_frobenius_height`. Version1,2 October2026.
[Focused independent proof review](../../Research/audits/CONTACT_FIRST_FROBENIUS_INSTABILITY_HEIGHT_AUDIT_2026_10_02.md) PASS.

Retain the fixed genus-nine X, a smooth genus-two Y, and TWO actual
finite etale maps $X\xleftarrow hS\xrightarrow gY$ from the SAME
smooth connected projective source, of degrees n and 8n. Let J be
the complete trace of the original three exact sections. Assume
$\deg J=1$, and write $r=t/n<9$ for its contact with the saturated
X hyperplane as in
[the contact theorem](first_section_contact_strictness.md).
Then J is stable and $r\ge7$.

If a is the FIRST positive Frobenius-instability height of J,
\[
\boxed{r\ge7+\frac{2}{3\cdot5^a}.}
\]
More precisely, if the top HN term of $F_Y^{a*}J$ has rank k and
degree A, then $r\ge5+8A/(k5^a)$.
In particular first-height top ranks one, two and three respectively
force $r\ge41/5,37/5,107/15$.

Thus $r<7+2/(3\cdot5^a)$ forces semistability through the first a
Frobenius pullbacks. At contact exactly seven, J is strongly
semistable. If $t>7n$ and a finite first unstable height exists, it
satisfies $5^a\ge2n/(3(t-7n))$.

The height can still increase without a uniform bound. No shared
coefficient, finite monodromy, source realization or common-cover
exclusion is inferred. Ordinariness, corelessness and a simultaneous
Galois closure are not required for this conditional contact result.

[Proof](../../Proofs/cartier_and_spin/first_section_trace_frobenius_height.md).
