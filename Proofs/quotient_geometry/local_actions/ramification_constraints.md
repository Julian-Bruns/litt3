# Proof: first-break Swan divisibility and tame ramification constraints

[Statement](../../../Theorems/quotient_geometry/local_actions/ramification_constraints.md).

Use Serre's lower groups \(G_i\), break function \(i_G\), and graded
maps \(\theta_i\). The standard inputs are in
[Serre, *Local Fields*, IV§1 Proposition4; IV§2 Propositions7,9,11;
VI§2 Theorem1′ and Proposition2, Corollary1′](https://www.sas.rochester.edu/mth/sites/doug-ravenel/otherpapers/Serre-Local.pdf#page=68).
These chapters assume a separable residue extension, so they apply to
the totally ramified extension \(k((z))/k((z))^G\).

## First-break divisibility

For a complex representation \(V\), Serre's Artin conductor \(f(V)\)
gives the integral Swan conductor
\[
 \operatorname{Sw}(V)=f(V)-\operatorname{codim}V^G
 =\sum_{i\ge1}\frac{|G_i|}{|G|}\operatorname{codim}V^{G_i}.
\]
Thus \(\operatorname{Sw}(\mathbf C[G])=\epsilon\), and the regular
representation gives
\[
 \epsilon-b(|G|-1)
 =\sum_{\rho\ne1}\dim\rho\,
       \bigl(\operatorname{Sw}(\rho)-b\dim\rho\bigr).            \tag{1}
\]
Put \(A=G/G_{b+1}\). Its irreducible characters are linear and, except
for the trivial character, have Swan conductor \(b\); their terms vanish.
Twist the remaining irreducibles by \(A^\vee\). Swan conductors are
constant on each orbit: above \(b\) the restrictions agree, while at
indices \(1,\ldots,b\) every member is nontrivial irreducible and has
zero \(G\)-invariants.

If \(\dim\rho=p^a\) and its twisting stabilizer has order \(p^s\),
the stabilizing characters give distinct character lines in
\(\operatorname{End}(\rho)\). Hence \(s\le2a\), and also \(s\le r\).
The orbit contributes
\[
 p^{r-s+a}\bigl(\operatorname{Sw}(\rho)-bp^a\bigr)
\]
to (1). Its exponent is at least
\(\max(a,r-a)\ge\lceil r/2\rceil\), proving the divisibility.

## Tame characters and positive breaks

Serre IV§2 Proposition9 gives
\(\theta_i(s\tau s^{-1})=\theta_0(s)^i\theta_i(\tau)\).
For a tame generator \(s\), the image of \(\theta_{b_i}\) is therefore
a vector space over \(\mathbf F_p(\theta_0(s)^{b_i})\). This gives
\(t\mid b_i(p^{r_i}-1)\). Proposition11 gives the common residue of
the positive breaks. It is nonzero here: the last ramification group
has an order-\(p\) element, whose break is prime to \(p\) by
Artin–Schreier reduction over the perfect residue field.

Finally, counting elements of each exact break gives
\[
 \epsilon=\sum_{\sigma\ne1}(i_G(\sigma)-1)
 =\sum_i b_i p^{d_i}(p^{r_i}-1),\qquad
 d_i=\sum_{j>i}r_j.
\]
Tame divisibility of each summand gives \(t\mid\epsilon\).
