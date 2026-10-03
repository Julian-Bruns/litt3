# Fixed-pair geometry and a real-field simplicity criterion

Let \(k=\overline{\mathbf F}_5\), choose \(a^2+4a+2=0\) in
\(\mathbf F_{25}\), and let \(X,Y\) be the smooth projective models of
the original pair
\[
\begin{aligned}
y^3={}&x^{10}+(4a+2)x^9+(a+4)x^8+(3a+1)x^7+3ax^6+4ax^5\\
&+(3a+4)x^4+ax^3+(3a+3)x^2+(4a+2)x+(2a+1),\\
z^2={}&(t^{25}+t^5+t)(t^{25}+t^5+t-1)(t-4).
\end{aligned}
\]
Then \(g(X)=9\), \(g(Y)=25\), and \(g(Y)-1=3(g(X)-1)\).
The curve \(X\) is nonhyperelliptic. Its degree-three map to the
\(x\)-line is tame and totally ramified at ten distinct finite roots and
at its unique \(\mathbf F_{25}\)-rational point \(O\) above infinity.
The hyperelliptic branch divisor of \(Y\) is reduced and consists of
52 points rational over \(\mathbf F_{125}\).

Both geometric Jacobians are absolutely simple. The Jacobian \(J(Y)\)
is ordinary (equivalently, its 5-rank is 25). In particular
\(\operatorname{Hom}_k(J(X),J(Y))=0\), since their dimensions differ.
The Jacobian \(J(X)\) has 5-rank six.

With \(\theta=dx/y^2\), one has
\(\operatorname{ord}_O(x)=-3\), \(\operatorname{ord}_O(y)=-10\), and
\(\operatorname{div}(\theta)=16O\).

**Reusable simplicity criterion.** Let A/F_q have irreducible Frobenius
polynomial of degree 2g and 0<f_p(A)<g. If its real Frobenius field
Q(pi+q/pi) has no proper nontrivial subfield, then A is absolutely
simple. For g>2, a squarefree residue-degree pattern(1,g−1) certifies
this field condition. The proof uses the same real-field input as
Howe–Zhu's ordinary criterion, applied here to Y.

[Proof and exact arithmetic inputs](../../Proofs/curve_arithmetic/fixed_pair_arithmetic.md).

Version3,3 October2026. The nonordinary simplicity criterion passed
an independent focused audit. Exact Frobenius inputs retain their
author-prose status; the older ordinary refinement audit is retained.
