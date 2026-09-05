# Clump existence: an exact two-map spectral criterion and the weight boundary

Status: proved elementary criterion and bounded primary-source check,
2026-09-05. Author: gluing_cohomology_rigidity. Not independently
audited. The source search found no answer applicable to an ordinary
genus-two endpoint or a fixed-prime-support iterated family; this is not
a certification of the current open status of Question 9.7.

## 1. What the cited theorems do and do not supply

Krishnamoorthy, [*Correspondences without a core*](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf),
Question 9.7, printed p.1210, asks whether every proper coreless
etale correspondence in positive characteristic has a clump, equivalently
an invariant pluricanonical form. Theorem 9.6 proves **at most one** clump,
not existence. Proposition 8.2 gives at most one independent invariant
section of each invariant line bundle. Corollary 8.10, printed p.1205,
converts a positive invariant line bundle into a power of the canonical
pair using torsion in the finite invariant Picard group. Its proof gives
no uniform torsion exponent or pluricanonical weight. These proofs were
read for this check.

Bellaiche, [*On self-correspondences on curves*](https://arxiv.org/pdf/2004.09689),
Proposition 2.3.1, preprint p.18, proves an at-most-one result over
algebraic extensions of finite fields. The proof descends **already
finite complete sets** and their inverse images to a finite field before
using the finiteness of its Jacobian points. It does not prove that an
arbitrary point has finite saturation. Theorem 3.5.3, preprint pp.32--33,
is another upper bound, conditional on failure of linear finitariness.
Both proofs were read. Neither assumes endpoint ordinarity or supplies
a clump-existence theorem.

The relevant positive criterion in Hallouin--Perret,
[*Recursive towers of curves over finite fields using graph theory*](https://arxiv.org/pdf/1212.3465),
Proposition 20, preprint pp.24--25, identifies maximal arithmetic
spectral radius with a finite regular complete subgraph. Its proof was
read. The following elementary version retains the original two maps
and needs neither irreducibility of recursive path curves nor a
tree hypothesis.

## 2. Exact criterion on the original two-map family

Let

\[
                X\xleftarrow{f}Z\xrightarrow{g}Y
\]

be finite etale maps of smooth proper geometrically connected curves,
defined over a finite field \(F\). Put \(a=\deg f\), \(b=\deg g\), and
\(D=ab\). Define the nonnegative integer matrix

\[
 B_{x,y}=\#\{z\in Z(F):f(z)=x,\ g(z)=y\},
 \quad x\in X(F),\ y\in Y(F),\qquad A=B^{\mathsf T}B.
\]

Multiple points of the normalization above the same joint-image point
are counted separately. This is essential; no smoothness of the joint
image is assumed. Row sums of \(B\) are at most \(a\), and column sums
are at most \(b\). An empty matrix has spectral radius zero here.

### Proposition

The following conditions are equivalent:

1. There is a nonempty finite set \(S\subset Z(F)\) such that
   \(f^{-1}f(S)=g^{-1}g(S)=S\), with inverse images taken among **all
   geometric points**.
2. \(\rho(A)=D\).
3. For the full alternating path fibre products
   \[
   P_1=Z\times_X Z,\qquad
   P_n=P_1\times_Y\cdots\times_Y P_1
   \quad(n\text{ factors}),
   \]
   where adjacent factors identify the right and left \(Y\)-endpoints,
   \[
              \lim_{n\to\infty}\frac{\#P_n(F)}{D^n}>0.
   \]

Always \(\rho(A)\le D\), and the displayed limit exists. Consequently,
over \(\overline{\mathbf F}_p\), a clump exists if and only if these
equivalent conditions hold over **some one fixed finite extension**
of a field of definition.

#### Proof

Write \(r_x=\sum_yB_{x,y}\le a\), \(c_y=\sum_xB_{x,y}\le b\).
For a real vector \(u\), weighted Cauchy--Schwarz gives

\[
\begin{aligned}
 \|Bu\|^2
 &\le\sum_x r_x\sum_y B_{x,y}u_y^2\\
 &\le a\sum_y c_yu_y^2
 \le ab\|u\|^2.
\end{aligned}
\]

Thus \(\rho(A)\le D\). Suppose equality holds, and choose a nonnegative
nonzero eigenvector \(u\) for the largest eigenvalue of \(A\). Equality
holds at every stage above. Let \(T=\{y:u_y>0\}\). Then \(c_y=b\) for
every \(y\in T\), and \(r_x=a\) for every row incident to \(T\).
Equality in the rowwise Cauchy--Schwarz inequality says that all
\(u_y\) incident to such a row have the same value; in particular,
none is zero. Hence all rational edges incident to those rows end in
\(T\). Since their row and column sums attain the full geometric
etale fibre degrees, there are no additional nonrational geometric
edges at any of these vertices. The edges above \(T\) therefore form
the required clump \(S\).

Conversely, a clump contained in \(Z(F)\), with endpoint sets
\(T_X=f(S)\), \(T_Y=g(S)\), has all \(a\) edges at every \(X\)-vertex
and all \(b\) edges at every \(Y\)-vertex. Consequently
\[
             B^{\mathsf T}B\,1_{T_Y}=ab\,1_{T_Y},
\]
which proves (1) implies (2).

The full path schemes \(P_n\) are smooth proper, possibly disconnected,
and finite etale of degree \(D^n\) over either \(Y\)-endpoint. Their
rational points are exactly the rational edge paths, so
\[
                    \#P_n(F)=\mathbf 1^{\mathsf T}A^n\mathbf 1.
\]
The real symmetric matrix \(A\) is positive semidefinite, with
eigenvalues in \([0,D]\). The normalized expression therefore converges
to the squared norm of the projection of \(\mathbf1\) onto the
\(D\)-eigenspace. This is positive exactly when \(\rho(A)=D\):
a nonnegative eigenvector for that eigenvalue has positive scalar
product with \(\mathbf1\). Finally, every geometric finite clump and
its endpoints are rational over a sufficiently large finite field.
\(\square\)

This isolates the missing arithmetic input. The construction of
infinitely many distinct minimal endpoint images does not establish
maximal spectral radius or positive density in these full path schemes.
No implication from that construction to this extra condition is
proved here. Selecting connected
components, or replacing paths by their endpoint images, does not
preserve the point-count formula. No argument was found that uses
fixed prime support to bound the fields needed for all inverse branches.
Individual Frobenius orbits being finite is insufficient.

## 3. No applicable published weight bound was found

An apparent near-match is Saha,
[*Invariant rational forms for correspondences of curves*](https://arxiv.org/pdf/1203.1108),
J. Number Theory 143 (2014), 170--184. Theorem 1.1 and Lemma 2.2
(preprint pp.4--7, proof read) bound the support of an invariant
rational tensor by
\[
 \frac{2\deg R_{\sigma_1}+\deg R_{\sigma_2}}
      {\deg\sigma_1-\deg\sigma_2}.
\]
They require tame maps to the **same curve** with unequal degrees.
This does not apply to the original different-endpoint diagram.
After forming any connected proper bi-etale self-correspondence on
a hyperbolic endpoint, Riemann--Hurwitz forces equal degrees, so the
essential denominator vanishes. The theorem is also a support bound,
not a bound on the first invariant weight.

### A degree-dependent refinement when the Jacobians have no homomorphisms

Suppose \(\operatorname{Hom}(JX,JY)=0\), and retain \(a=\deg f\),
\(b=\deg g\). Set \(E=\operatorname{lcm}(a,b)\). Then
\[
 E\cdot\operatorname{Pic}^0(X\leftarrow Z\to Y)(k)=0.
\]
Indeed, duality also gives \(\operatorname{Hom}(JY,JX)=0\), so
\(f_*g^*=g_*f^*=0\) on the corresponding Jacobians. If
\(f^*\alpha=g^*\beta\), applying norms gives \(a\alpha=0\) and
\(b\beta=0\). This proves the exponent bound. Identifying the group
with invariant line bundles introduces no extra scalar obstruction:
a constant gluing scalar is absorbed by rescaling a trivialization
on one endpoint.

In particular, if \(g(Y)=2\) and a clump \(S\) exists, there is an
invariant pluricanonical form of weight \(|S|\). To prove this, set
\(c=|g(S)|\) and let \(L(S)\) be the invariant line bundle with its
canonical effective section. Riemann--Hurwitz gives
\(b=(g(X)-1)a\), while saturation gives
\[
             a|f(S)|=b|g(S)|=|S|.
\]
Thus \(L(S)^2\otimes\Omega^{-c}\) has degree zero on both endpoints.
Its \(E\)-th power is trivial, so the section of \(L(S)^{2E}\)
gives a section of \(\Omega^{cE}\). Here \(E=b\), hence
\(cE=bc=|S|\), as asserted.

This bounds the least invariant weight in terms of a **known clump**,
not uniformly over all correspondences. Neither a uniform bound on
\(|S|\) nor a bound on the exponents in the iterated leg degrees is
provided here. A fixed prime support for the degrees bounds the
prime support of this Picard exponent, not its size.

For a fixed actual correspondence, each weight can of course be
tested by the finite-dimensional equalizer
\[
 \ker\!\left[
 H^0(X,\omega_X^m)\oplus H^0(Y,\omega_Y^m)
 \xrightarrow{\,f^*-g^*\,}H^0(Z,\omega_Z^m)
 \right].
\]
When \(Y\) has genus two its contribution has dimension \(2m-1\)
for \(m\ge2\). This is a finite test at each specified weight, not
a finite test for all weights.

For p-rank-zero \(X\) and ordinary \(Y\), the weight-one equalizer
vanishes by Cartier functoriality: Cartier is nilpotent on the first
space and bijective on the second, and etale pullback is injective.
No assertion for all higher weights follows. In the prime-to-\(p\)
cyclic-root construction, a higher invariant tensor yields a
one-form only after replacing the endpoints by cyclic covers, which
can be ramified over its zeros. Its new one-form can lie in a
nontrivial deck-character space, not in the pulled-back one-forms of
the original ordinary endpoint. The required Cartier control on
those new spaces is an additional hypothesis. For weights divisible
by \(p\), the separable cyclic-root argument has a further obstruction.

Finally, an invariant pluricanonical section may vanish at singular
points of the joint image. Its existence does not automatically
say that the canonical differential trivialization descends there
as a **unit**. Thus the gluing-order hypothesis in file 101 cannot
be silently substituted for existence of an invariant form.

Conclusion: the exact additional condition available here is
maximal arithmetic path growth (equivalently a clump), not a theorem
that the current coreless ordinary-genus-two family satisfies it.
Neither a higher-weight vanishing range beyond the established
weight-one argument nor a theorem-backed global weight bound was
established in this bounded check.
