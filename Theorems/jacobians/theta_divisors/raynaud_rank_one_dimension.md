# Dimension bounds for Raynaud families

Version2. Independently audited, including the Wronskian extension.

Let \(C\) be a smooth projective connected curve of genus \(G\ge2\)
over an algebraically closed field of characteristic \(p>0\). Write
\(J=J(C^{(1)})\), \(B_C=F_{C/k*}\mathcal O_C/\mathcal O_{C^{(1)}}\),
and let \(i:A\hookrightarrow J\) be a positive-dimensional abelian
subvariety. Fix any \(L_0\in J(k)\), and put
\[
\delta(A,L_0)=
\operatorname{generic}_{L\in A}h^0(C^{(1)},B_C\otimes L_0\otimes i(L)).
\]
If \(\delta(A,L_0)=1\), then
\[
\boxed{\dim A\le\frac{p-1}{p}(G-1).}
\tag{1}
\]
The translate need not be invariant under inversion. There is no
ordinariness, separability of a polarization, principal induced
polarization, or Néron--Severi rank hypothesis.

More precisely, use normalized Poincaré families on \(C^{(1)}\times A\)
and let \(\mathscr K_\pm\) be their degree-zero cohomology sheaves
for twists by \(L_0^{\pm1}\). They are line bundles, with ample duals
\(\mathscr M_\pm\). Let \(D\) be the effective divisorial torsion
cycle in degree-one cohomology for the plus family. If \(D\ne0\),
then inequality (1) is strict.

Two consequences are immediate.

1. No translate of an abelian subvariety of codimension one in \(J\)
   has generic Raynaud defect exactly one. A translate which is a
   component of \(\Theta_{B_C}\) therefore has generic defect at
   least two and appears with multiplicity at least two.
2. Every abelian subvariety of codimension one through the origin
   has generic defect zero. More generally, this vanishing holds
   whenever \(a(J/A)\le1\) and
   \(\dim A>(p-1)(G-1)/p\). Here the quotient is understood before
   Frobenius twist when applying the
   [quotient a-number bound](restricted_raynaud_complement_rank.md).

The second assertion does not extend to arbitrary translates by
that a-number argument: the bound is based at the trivial line.
The first assertion does apply to every translate.

There is a stronger bound at higher generic defect when the
sections are independent at the generic point of the curve.
Suppose \(\delta(A,L_0)=s\), and for both opposite translates
\(L_0^{\pm1}A\), the \(s\) generic global sections are linearly
independent over the function field of \(C^{(1)}\). Then
\(1\le s\le p-1\) and
\[
\boxed{\dim A\le
\frac{(p-1)(s+1)}{2ps}(G-1).}
\tag{2}
\]
Again the inequality is strict if degree-one cohomology has a
nonzero divisorial torsion cycle. The section-independence hypothesis
is automatic for \(s=1\), and is an actual extra hypothesis for
\(s>1\). The proof uses the ordinary Wronskian of the corresponding
exact differentials, not differentiation on parameter space.

Consequently, on every translated abelian divisor contained in
\(\Theta_{B_C}\), at least one of the two opposite translated
families has generically dependent sections over the curve's function
field. If the translate is invariant under inversion, its own
generic sections are dependent. For \(p=5\), the coefficients of
\(G-1\) in (2) for \(s=1,2,3,4\) are respectively
\(4/5,3/5,8/15,1/2\).

For an actual span \(X\leftarrow Z\rightarrow Y\), take the image
of the two pullback Jacobians as \(A\). Both maps are retained.
In the current characteristic-five mixed family, \(\dim A=11\) and
\(g(Z)-1=8n\). The necessary inequality is \(11\le32n/5\);
the nonzero jump divisor makes it strict. This still allows every
\(n\ge2\), so it does not decide the mixed vanishing question or
the common-cover problem.

[Proof](../../../Proofs/jacobians/theta_divisors/raynaud_rank_one_dimension.md).
