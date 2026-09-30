# Unit-root multiplicity one excludes unbounded five-by-abelian covers

Version3,22September2026. Let X/F25 be the fixed genus-nine curve.
Let Y/F_(25^b) be any smooth proper genus-two curve, with13 not
dividing b. Suppose an ACTUAL finite bi-etale span X<-Z->Y has
Y-leg Galois closure W/Y with group G. Then G cannot have a normal
five-group P with abelian prime-to-five quotient A of exponent n
satisfying
\[
\lambda\not\equiv0,1,-1,5,-5\pmod{13}\quad(\lambda\mid n),
\qquad 4\nmid\operatorname{ord}_n(5).
\tag{1}
\]
For n=1 take ord_n(5)=1. Both |P| and |A| are UNBOUNDED.
The original leg need not be Galois, and Y need not be ordinary.
Both selected partners satisfy the field condition13 not dividing b.

In particular the quotient exponent may be
\[
n=2^a3^c7^d11^e19^f23^j,
\qquad 0\le a\le3,
\]
with the other exponents arbitrary. The factor8 is permitted, so
these are actual possible genus-two-leg degrees, not prime-power
groups already prohibited by Riemann--Hurwitz.

The hyperelliptic involution gives a sharper characterwise test.
For d dividing n put f(d)=ord_d(5), with f(1)=1, and set
\[
f_+(d)=
\begin{cases}
f(d)/2,&d>2\text{ and }-1\in\langle5\rangle\subset(\mathbf Z/d)^\times,\\
f(d),&\text{otherwise}.
\end{cases}
\]
Keeping the prime condition in(1), one may replace its last condition
by4 not dividing f_+(d) for EVERY d dividing n. In particular the
quotient may have elementary two-primary part and odd exponent
37^a*41^c*89^d, with all three exponents arbitrary. An elementary
two-group of order8 or16 retains the necessary factor8 in the degree.
These new odd exponents fail the unrefined condition4 not dividing
ord_n(5). Primitive order8 mixed characters need not satisfy the
inversion condition, so this is not an arbitrary extension in n.

The proof uses the ACTUAL quotient cover C=W/P. Its nontrivial
character spaces in etale five-cohomology have multiplicity AT MOST
ONE, even when C is nonordinary. Their centralizers are multiplicative
groups of fields. Frobenius therefore cannot acquire the factor13
required by the fixed X unit root of residual order624.

## The characteristic-primary test used here

Let C/Fq be a smooth proper geometrically connected curve of
characteristic p. Let m be Frobenius order on J(C)[p](bar Fq),
the ETALE p-torsion, whose dimension is the p-rank. Every geometric
etale cover T/C with p-group Galois closure has an actual model over
F_(q^(m*p^s)), for some s, with rational etale p-torsion of J(T).

If A0/Fq is a geometric factor of J(T) and pi is a Frobenius
eigenvalue which is a UNIT at the selected p-adic place, then
\[
\overline\pi^{\,m}\in\overline{\mu(K)},\qquad K\supset\mathbf Q(\pi).
\tag{2}
\]
No rationality of the connected p-torsion is asserted. Although not
all conjugates of pi are units, conjugates fixing K of pi*zeta
are units; this suffices to retain the geometric root-of-unity twist.

For fixed X, a unit eigenvalue has residual order624=16*3*13 and
mu(K)=mu6. Hence a five-group cover over F_(25^c) can contain JX
only if104 divides c*m. In particular c and m cannot both avoid13.

More generally, after a prime-to13 field extension making a
prime-to-five deck group A constant, write its semisimple F5 algebra
as a product of M_e(F_(5^f)). The same argument works if every
nontrivial factor satisfies4/gcd(4,f)>e. No arbitrary nonabelian
quotient or mixed-chief tower is covered without this condition.

In particular EVERY Y-leg closure group of order8*5^a is excluded,
for arbitrary a, without any assumed normality or commutativity.
Its Sylow five-group is automatically normal: the number of Sylow
five-subgroups divides8 and is1 modulo5, hence is1. The order-eight
quotient has a prime-to13 constant-deck model and satisfies the
nonabelian centralizer test. This conclusion concerns the closure
group order, not merely the original covering degree.

Actual new families are given by
(C5 wreath C25) x C_(8*3^c) over either ordinary selected partner.
The five-group is two-generated, has order5^27, derived group of
order5^24, and a faithful degree25 character. Such covers exist;
the old character-size and bounded-derived-group tests allow them.
The theorem excludes their actual second maps to X.

This does not eliminate all monodromy groups, construct a common
positive tensor, or settle either unrestricted common-cover problem.

[Proof](../../../Proofs/jacobians/isogeny_sieves/five_by_abelian_unit_root_exclusion.md).
