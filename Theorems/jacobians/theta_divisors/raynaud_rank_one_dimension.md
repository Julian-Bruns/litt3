# Dimension bounds for Raynaud families

Version3, 3 October2026. The fixed-evaluation extension passed two
independent focused reviews; the earlier Fourier and Wronskian inputs
retain their audits.

Let \(C\) be a smooth projective connected curve of genus \(G\ge2\)
over an algebraically closed field of characteristic \(p>0\). Put
\(J=J(C^{(1)})\), \(B_C=F_{C/k*}\mathcal O_C/\mathcal O_{C^{(1)}}\),
and let \(i:A\hookrightarrow J\) be an abelian subvariety of
dimension \(d>0\). For any \(L_0\in J(k)\), write
\[
s=\operatorname{generic}_{L\in A}
h^0(C^{(1)},B_C\otimes L_0\otimes i(L)).
\]
If \(s>0\), then
\[
\boxed{d\le\frac{p-1}{p}(G-1).}
\tag{1}
\]
This holds at every positive defect, including sections dependent
over the curve's function field. There is no ordinariness,
inversion-invariance, quotient a-number, principal induced
polarization, or separable-isogeny hypothesis.

Let \(\mathscr K_\pm\) be degree-zero cohomology of the normalized
Poincaré families twisted by \(L_0^{\pm1}\). Both are reflexive of
rank \(s\), with ample determinant duals
\(\mathscr M_\pm=(\det\mathscr K_\pm)^\vee\). If \(D\) is the
effective divisorial torsion cycle of plus-family degree-one
cohomology, then
\[
c_1(\mathscr M_+)+c_1(\mathscr M_-)+[D]=(p-1)i^*[\Theta_J].
\tag{2}
\]
Every dimension inequality here is strict when \(D\ne0\).

Consequently, every translate of \(A\) has generic defect zero
whenever \(d>(p-1)(G-1)/p\). In particular, **Raynaud theta has no
translated abelian divisor component in any characteristic**.
In genus two its restriction to every positive-dimensional abelian
coset is proper.

There are sharper bounds if the \(s\) generic global sections are
independent over the function field of \(C^{(1)}_{k(A)}\) on one or
both opposite families. Such independence implies \(s\le p-1\).
Set \(c_\pm=(s+1)/s\) on each independent family and \(c_\pm=2\)
otherwise. Then
\[
\boxed{d\le
\frac{p-1}{p}\frac{c_+c_-}{c_++c_-}(G-1).}
\tag{3}
\]
With independence on one sign this is
\(2(p-1)(s+1)(G-1)/(p(3s+1))\); on both signs it is the earlier
Wronskian bound
\[
d\le\frac{(p-1)(s+1)}{2ps}(G-1).
\tag{4}
\]
Independence is automatic for \(s=1\). The two signs need not have
the same evaluation rank when \(s>1\). For \(p=5\), the coefficients
in (4) for \(s=1,2,3,4\) remain \(4/5,3/5,8/15,1/2\).

For an actual span \(X\leftarrow Z\rightarrow Y\), apply the result
to the image of both pullback Jacobians. Both actual étale maps
remain. In the characteristic-five mixed family, \(d=11\) and
\(g(Z)-1=8n\); positive generic defect of ANY size requires
\(11\le32n/5\), strictly with a nonzero jump divisor. Every
\(n\ge2\) still satisfies this necessary bound, so the mixed
vanishing question and common-cover problem remain unresolved.

[Proof](../../../Proofs/jacobians/theta_divisors/raynaud_rank_one_dimension.md).
