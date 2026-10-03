# The critical quintic is irreducible in actual admissible degree eleven

Version3,1 October2026. Retain an ACTUAL nontrivial admissible
degree-eleven source and its annihilator $u$ in
[reconstruction](admissible_line_reconstruction.md), with the
primitive coordinate supplied by
[degree-eleven reduction](admissible_degree_ten_eleven_reduction.md).
Use the short coordinate $W$, affine primitive content
$v\in L_9$, raw polynomial $F$, critical polynomial $D$ and
trace-dual numerator $U$ from the uniform and quadratic trace
theorems. Thus $\deg F=11$, $\deg D=5$,
$[T^5]D=v$, $[T^4]D=0$, and $\deg U\le6$.

Without ANY function-field squarefreeness assumption, $D$ is
IRREDUCIBLE over $K=k(X)$ in all four content-pole profiles
$d=0,3,6,9$. An inseparable irreducible quintic is allowed by
this statement. Every finite coefficient drop and every repeated
specialized critical fiber is retained.

Consequently
\[
\gcd(D,U)=1,
\qquad\deg\operatorname{den}_{\mathrm{red}}(U/D)=5.
\]
There is no partial critical-factor cancellation. The full
degree-five critical denominator remains necessary.

The factor-trace pole argument first excludes $d=0,3,6$. In the last
profile it forces $v=\kappa(q_3+\lambda q)$, where
$q_3=([1],[22],[9],[1])$ and $q=([13],[18],[24])$.
For a proper factor of degree $e=1,2,3,4$, the sum of its
finite-frame roots equals its short-frame sum plus $eZ/y$,
with $e\ne0$ in characteristic five.
Clearing the possible finite poles of this rational sum by a polynomial
of degree at most two gives a fixed gap contradiction, unless
$v$ has three distinct simple branch roots and divides $P$.
An explicit small polynomial Bezout identity shows that no
member of the displayed cubic pencil divides $P$, completing
the remaining boundary. The proof does not infer affinity of
the short lower critical coefficients.

No full rational-denominator, actual-source or unmarked
common-cover decision follows. There is no nonzero degree-ten
annihilator-trace hypothesis in this argument.

[Proof and fixed evidence](../../Proofs/cartier_and_spin/admissible_degree_eleven_critical_irreducibility.md).
