# A residue resolution by the complete dormant scheme

Version1, 19 September 2026. The returned five-kernel resolution is
extended here to the complete, possibly nonreduced dormant scheme.
Its bounded independent review passed. The rank-one boundary
implication remains open.

Let k be algebraically closed of characteristic five, and let
\(Y:v^2=f(u)\) be any smooth genus-two curve, with f monic of degree
five. Put \(C=Y^{(1)}\), \(\Phi=F_{Y/k}\), and use the actual
relative Frobenius throughout. With \(f=\sum_{j=0}^5 a_j u^j\), set
\[
w=T^2+3a_4T+3a_3,\qquad d=-a_2+(a_4+2T)w,\qquad
\Psi=2a_0-2a_1T+a_2w-dw.
\]
The [universal dormant quintic](genus_two_dormant_quintic.md)
identifies the complete dormant scheme with
\(D=\operatorname{Spec}A\), where \(A=k[T]/(\Psi)\).
Its length is five; separability is not assumed. Let
\(\ell:A\to k\) send a reduced polynomial to its T-fourth
coefficient. This is a perfect Frobenius-algebra functional:
\((a,b)\mapsto\ell(ab)\) is nondegenerate.

Let \(\mathcal V_A\) be the universal rank-two Bol kernel on
\(C\times D\), with potential
\[
r_T=2(f'/f)^2-f''/f+
\frac{2u^3+Tu^2+w(T)u+d(T)}{f},
\]
and write \(\mathcal W=\operatorname{pr}_{C*}\mathcal V_A\),
\(P=\Phi_*\omega_Y^2\), and \(Q=\Phi_*\omega_Y^{-1}\).
Then there is an exact sequence of actual vector bundles
\[
0\longrightarrow Q\xrightarrow{\alpha}\mathcal W
\xrightarrow{\varepsilon}P\longrightarrow0.                 \tag{1}
\]
Here \(\varepsilon=(1\otimes\ell)\circ\iota\), for the universal
inclusion \(\iota:\mathcal V_A\hookrightarrow P\otimes A\), and
in a regular local coordinate
\[
\alpha(h)=\mathcal A_T(h),\qquad
\mathcal A_T=D^3+r_TD+3r_T'.                                  \tag{2}
\]
The Wronskian followed by \(\ell\) gives a perfect alternating
\(\omega_C\)-valued pairing on \(\mathcal W\). Under the Cartier
duality \(Q=P^\vee\otimes\omega_C\), \(\alpha\) is four times
the adjoint of \(\varepsilon\). In particular Q is Lagrangian.

If \(\Psi\) is separable, rescaling its five direct summands
identifies (1) with the returned resolution
\[
0\to Q\xrightarrow{(\lambda_i\mathcal A_i)_i}
\bigoplus_{i=0}^4\mathcal V_i
\xrightarrow{\sum\iota_i}P\to0,
\qquad \lambda_i=1/\Psi'(T_i).                               \tag{3}
\]
An overall nonzero scalar on the first map is immaterial. For
\(f=u(u-1)(u-2)(u-3)(u-a)\), (3) applies to every
\(a\in k\setminus\{0,1,2,3\}\).

The nonreduced case is nonvacuous: the smooth curve
\(v^2=u^5+u^3+u\) has \(\Psi=3T^3(T^2+1)\). Here (1) retains
the actual length-three universal deformation at T=0, rather than
replacing it by three copies of the reduced kernel.

## Cohomological consequences

Let E have rank r and degree zero on C, and suppose
\(S=\Phi^*E\) is semistable. No stability or determinant condition
on E is needed here. Sequence (1) gives a connecting map
\[
\delta_E:H^0(Y,S\omega_Y^2)\longrightarrow
H^1(Y,S\omega_Y^{-1}),
\]
between spaces of dimension 3r, and
\[
h^0(C,\mathcal W\otimes E)=3r-\operatorname{rank}\delta_E.
                                                                    \tag{4}
\]
For a reduced dormant scheme the left side is
\(\sum_i h^0(C,\mathcal V_i\otimes E)\). In particular this sum
is at most 3r. On an actual degree-n finite étale cover
\(q:Z\to Y\), the five pulled-back dormant tangent spaces embed
as a direct sum in \(H^0(Z,\omega_Z^2)\); their total dimension
is at most \(3n\).

Assume now that E is stable of rank two, that \(\Psi\) is
separable, and that \(\Phi^*E\) is semistable.

1. If \(\det E\ne\mathcal O_C\), each
   \(h^0(C,\mathcal V_i\otimes E)\) is at most one. All five
   are nonzero if and only if \(\operatorname{rank}\delta_E=1\).
   Rank zero never occurs on this locus.
2. If \(\det E=\mathcal O_C\), at most three of the five tests
   are nonzero. In fact this conclusion does not require E stable:
   each section dimension is even, while their sum is at most six.
3. Locally on a parameter scheme carrying a universal E, around
   a common point with nontrivial determinant, the actual five-test
   scheme has ideal \(I_2(\delta)\). If \(\sigma_i\) are its
   determinant sections, then
   \(\delta\sim\operatorname{diag}(1,\sigma_0,\ldots,\sigma_4)\).
   On the Frobenius-semistable locus the determinant identity is
   \(\det\delta=u\prod_i\sigma_i\) for a local unit u.

These statements do not prove that rank one forces S strictly
semistable. That is a condition on the particular extension (1),
not a consequence of the dimensions in (4).

[Proof](../../Proofs/projective_connections/dormant_pushforward_resolution.md).
