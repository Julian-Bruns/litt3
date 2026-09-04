# Simple \(x=0,u^{10}\) solve

## Status

**proved-text** as a local response calculation under the \(u^4\) leading
form in file 85. Its use in the tower also assumes the incoming
repeated-\(u^5\) chart.

## Statement

Work over \(k=\overline{\mathbb F}_5\). Assume the normalized entry-zero
equation has the \(u^4\) leading form displayed in file 85, with leading
scalar \(a\in k^\times\). On its simple branch \(w=-u+O(u^2)\), the new
coefficient

\[
 v=U_{17}(0),\qquad F_{18}=x(x-1)U_{17}(x),
\]

enters the \(u^{10}\) ODE equation as

\[
 R+3a^{-1}v=0,
\]

where \(R\) is independent of \(v\).  Hence this layer uniquely solves
\(U_{17}(0)\) and imposes no equation on the older variables.

## Proof

Apply the simple-branch five-step lemma in
[file 85](85_SIMPLE_FIVE_STEP_SOLVE_LEMMA.md) with \(m=2\).  Here the new
term is \(u(u-1)v\,w^{18}\), and the lemma gives the unit coefficient
\(3a^{-1}\). Under the separate specialization \(\pi=-1\), one has
\(a=-\pi=1\), recovering the formerly displayed coefficient \(3\).

This exact leading-order argument is independent of the chart parameters.
The previously recorded finite scans (100 samples and one full
\(\mathbb F_5\)-graph on each preferred chart) agreed with the specialized
coefficient \(3\), but their cited scripts are absent and are not needed for
the proof above.
