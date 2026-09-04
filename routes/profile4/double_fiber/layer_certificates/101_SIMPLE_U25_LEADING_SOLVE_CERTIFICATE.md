# Simple \(x=0,u^{25}\) solve

## Status

**proved-text** as a local response calculation under the \(u^4\) leading
form in file 85, but **not an established step of the retained tower**.
Applying it after file 97 requires the missing repeated-\(u^{20}\) result
called note 100.

## Statement and proof

Work over \(k=\overline{\mathbb F}_5\). Assume the normalized entry-zero
equation has the \(u^4\) leading form displayed in file 85, with leading
scalar \(a\in k^\times\), and suppose an incoming solution has in fact been
carried through repeated \(u^{20}\). On its simple branch
\(w=-u+O(u^2)\), let

\[
 v=U_2(0),\qquad F_{33}=x(x-1)U_2(x).
\]

Apply [file 85](85_SIMPLE_FIVE_STEP_SOLVE_LEMMA.md) with \(m=5\).  The
\(u^{25}\) ODE equation is

\[
 R+2a^{-1}v=0,
\]

with \(R\) independent of \(v\). Thus this equation uniquely solves
\(U_2(0)\) and imposes no equation on the older variables. The formerly
displayed coefficient \(2\) is the specialization \(a=-\pi=1\), which
requires the separate condition \(\pi=-1\).

This proposition does not supply, reconstruct, or bypass the missing
repeated-\(u^{20}\) proof.
