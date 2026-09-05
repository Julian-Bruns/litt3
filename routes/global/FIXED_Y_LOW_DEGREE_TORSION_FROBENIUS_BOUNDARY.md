# Fixed-Y low-degree torsion: exact Frobenius applicability boundary

**Status:** author proof and exact integer certificate, 2026-09-05;
not independently audited. Author: gluing_cohomology_rigidity, in
collaboration with root.

This concerns the fixed ordinary genus-25 hyperelliptic curve \(Y\) of
[file 76](76_EXPLICIT_BRANCH_RATIONAL_R3_REDESIGN.md), not a replacement
curve. Write \(J=J(Y)\), let \(\pi\) be its \(\mathbf F_5\)-Frobenius,
and use its rational Weierstrass point \(\infty\).
The hyperelliptic pencil is \(H\sim2\infty\), so
\([E-3H]=[E-6\infty]\) lies on \(W_6\).

## 1. The exact primary theorem and the elementary order-eight bound

Zarhin, *Division by 2 on odd-degree hyperelliptic curves and their
Jacobians*, [MPIM 18-31](https://archive.mpim-bonn.mpg.de/3152/1/preprint_2018_31.pdf),
printed pages 7--9, Theorem 2.12, property (M3), and Theorem 2.14(i),
provides the following applicable implication in every characteristic
different from two:

If \(a\in W_{\lfloor g/2\rfloor}\) and some ground-field automorphism
sends \(a\) to \(3a\), then \(2a=0\).
Only this relation for the individual point is needed; a uniform scalar
Frobenius action on bounded torsion is a sufficient, stronger hypothesis.
More generally the same proof works if
\(\sum_{\ell=1}^{k}\sigma_\ell(a)=\pm Na\), with \(k<N\) and
\((N+k)\deg(E)\le2g\). For \(W_6\) here, \(N+k\le8\) suffices.
The proof compares multiplicities in a principal divisor whose poles
have degree at most \(2g\); no characteristic-zero specialization is used.

There is also an unconditional bound. If \(8a=0\) for
\(a=[E-6\infty]\), \(\deg E=6\), then a function realizing
\(8E-48\infty\) lies in \(L(48\infty)\).
On the odd-degree genus-25 model, \(x\) has pole order two and \(y\)
has pole order 51. Thus this function is a polynomial in \(x\).
Its divisor is invariant under the hyperelliptic involution; therefore
\(E\) is invariant and \(2a=0\). This includes divisors containing
\(\infty\), by cancelling that contribution first.
In particular, \(W_6\) contains no point of exact order four or eight.
The same pole calculation is the content of Zarhin's Lemma 2.2.

Nothing in this argument excludes exact orders 16, 32, or 64.

## 2. The fixed Jacobian fails property (M3)

All 52 branch points are rational over \(\mathbf F_{125}\), so
\(J[2]\subset J(\mathbf F_{125})\) has cardinality \(2^{50}\).
The recorded Weil polynomial gives

\[
 \#J(\mathbf F_{125})
 =28401356582148358632129391900914590018369492518699008,
 \qquad v_2(\#J(\mathbf F_{125}))=56.
\]

Hence \(J(\mathbf F_{125})\) contains a point \(a\) of order four.
Its \(\mathbf F_5\)-Galois orbit has size one or three, and cannot
contain \(-a=3a\). Thus the full property (M3) actually fails for
this Jacobian. This point is not asserted to lie in \(W_6\).

## 3. All useful single-scalar Frobenius certificates fail on \(J[64]\)

In fact there is no integer \(m\) with

\[
                   \pi^m=\lambda I\quad\hbox{on }J[64],
             \qquad \lambda\in\{3,-3,5,-5,7,-7\}.                \tag{1}
\]

Here is a proof using the actual integral Tate-module action, not a
companion-matrix identification.

Since \(\pi^3=I\) on \(J[2]\), write
\(\pi^3=I+2A\) on the free rank-50 \(\mathbf Z_2\)-module \(T_2J\).
Repeated squaring gives \(\pi^{96}=I\) modulo 64.
The mod-two order of \(\pi\) is exactly three: otherwise all of \(J[2]\)
would be rational over \(\mathbf F_5\), whereas
\(v_2(\#J(\mathbf F_5))=20<50\).

Consequently an exponent in (1) can be reduced modulo 96 and must
be divisible by three. The Weil pairing also requires
\(5^m\equiv\lambda^2\pmod{64}\).
Exact Newton sums from the Weil polynomial give

\[
\begin{array}{c|c|c}
|\lambda|&\text{possible }m&\operatorname{Tr}(\pi^m)\bmod64\\ \hline
3&6,54&26,26\\
5&18,66&42,42\\
7&36,84&34,34 .
\end{array}
\]

Comparison with \(50\lambda\bmod64\) eliminates all but
\((\lambda,m)=(-7,36),(-7,84)\).
Now

\[
 v_2\det(\pi^3-I)=56>50
       \quad\Longrightarrow\quad A\bmod2\text{ is singular}.
\]

For \(m=36,84\), binomial expansion gives

\[
             \pi^m\equiv I+8(A+A^2)\pmod{16}.
\]

But \(-7I\equiv I+8I\pmod{16}\), and
\(A+A^2=I\) modulo two is impossible when \(A\) has a nonzero kernel.
This eliminates the last two cases and proves (1).

All exact integer calculations are reproduced by
[the certificate](FIXED_Y_LOW_DEGREE_TORSION_FROBENIUS_CERTIFICATE.py),
which uses only the Weil polynomial of file 76. The extra integral
input \(\pi^3\equiv I\pmod2\) comes from the actual rational branch
divisor, not from the Galois group of the Weil polynomial.

## 4. What this does and does not settle

The scalar approach is unavailable for this fixed \(Y\).
Point-dependent Frobenius relations and short sums of Frobenius
conjugates remain different possibilities; neither has been ruled out.
The actual \(W_6\cap J[64]\) question can instead be formulated through
Mumford--Cantor arithmetic or a Riemann--Roch jet-evaluation rank test.
Such a test must include the lower-degree, branch-point, and infinity
strata, and use ideal powers or Hasse jets in characteristic five.

No conclusion about nonexistence of the specified degree-six divisors
of exact order 16, 32, or 64 is claimed. No statement about the fixed
common-cover problem is inferred from the failure of a sufficient
Frobenius criterion.
