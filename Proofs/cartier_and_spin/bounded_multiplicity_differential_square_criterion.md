# Proof: the polynomial differential kernel records multiplicities modulo p

27 September2026. The characteristic-five observation and solution
module are already present in Section27.2 of the received
[double-root report](../../../litt3-computation-data/double_root_square_endpoints_reply_20260927/extracted/REPORT.md).
This record integrates that input, states its odd-characteristic version,
and records an additional one-dimensional false-positive example. It is
not counted as a new exclusion of the actual square family.

Let R and k be as in the statement. At a finite root
a of multiplicity m, a nonzero polynomial B of multiplicity n satisfies
2RB'-R'B=0 only if2n=m in k: compare the logarithmic residues in
2B'/B=R'/R. At a point outside the roots of R, the same equation forces
the multiplicity of B to be divisible by p.

Conversely let n_a be the residue in{0,...,p-1} with2n_a=m_a mod p.
The polynomial B_min=product_a(x-a)^(n_a) satisfies the differential
equation, since its logarithmic derivative agrees with R'/2R. Every
other polynomial solution is divisible by B_min, and its quotient has
all finite root multiplicities divisible by p. Since k is perfect it
belongs to k[x^p]. Conversely every such multiple is a solution. This
proves the stated module and dimension formula, including constants
and roots whose R-multiplicity is divisible by p.

Now suppose all m_a<p. For even m_a, n_a=m_a/2. For odd m_a,
n_a=(m_a+p)/2. If o is the number of odd-multiplicity roots, then
\[
\deg B_{\min}=d+po/2.
\]
Thus a nonzero solution of degree at most d exists precisely when
o=0, precisely when every m_a is even. Algebraic closedness makes the
leading constant a square as well. Then B_min has degree d, and the
kernel consists of its constant multiples. No scheme-theoretic
conclusion is asserted from this pointwise factorization argument.

The exceptional multiplicities matter even when the kernel has dimension
one. In characteristic five, let a!=b and let S be a squarefree degree66
polynomial nonzero at a,b. Put
\[
R=(x-a)^7(x-b)S^2,\qquad B=(x-a)(x-b)^3S.
\]
Then deg R=140 and deg B=70, and2RB'-R'B=0 because
2(1)-7=-5 and2(3)-1=5. But R is not a square. This demonstrates why
the degree140 differential equations alone, without a multiplicity
argument or the retained Frobenius-resonant square equations, are not
a complete test.

For degree140, write R=sum_(i=0)^140 r_i x^i and
B=sum_(j=0)^70 b_j x^j. The coefficient of x^(i+j-1) in
2RB'-R'B is(2j-i)r_i b_j. Its maximum degree is209. The coefficient
at degree209 vanishes identically because2*70-140=0, leaving209 rows
(degrees0..208) and71 columns. On the open with no root of multiplicity
at least five, rank<=70 is therefore exactly the geometric square
condition. It makes no assertion that this open exhausts any particular
two-parameter family; that remaining multiplicity question must be proved.
