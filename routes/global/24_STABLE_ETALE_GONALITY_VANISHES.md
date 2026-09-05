# Stable finite-etale gonality vanishes

## Status and purpose

**Status: proved.** This note tests a direct geometric invariant for the
common-cover problem and shows that it is universal.

Let \(k=\overline{\mathbf F}_p\), and let \(C/k\) be a smooth projective
connected curve of genus \(g\geq2\). Define

\[
 \gamma_{\mathrm{et}}(C)
 =\inf_{D\to C\ {\rm connected\ finite\ etale}}
       \frac{\operatorname{gon}(D)}{g(D)-1}.
\]

The towers of two curves having a common finite etale cover are cofinal, so
\(\gamma_{\mathrm{et}}\) is formally a finite-etale commensurability
invariant. The theorem below shows that it cannot distinguish any curves.

## Theorem

For every smooth projective connected curve \(C/k\) of genus at least two,

\[
                         \gamma_{\mathrm{et}}(C)=0.
\]

More precisely, there is a constant \(A_C>0\) and, for every integer
\(n\geq2\) prime to \(p\), a connected finite etale cover
\(C_n\to C\) of degree \(n^{2g}\) such that

\[
 \operatorname{gon}(C_n)\leq A_C n^{2g-2},
 \qquad
 \frac{\operatorname{gon}(C_n)}{g(C_n)-1}
 \leq \frac{A_C}{(g-1)n^2}.
\]

## Proof

Choose \(c_0\in C(k)\), let \(J=\operatorname{Jac}(C)\), and use \(c_0\)
to form the Abel--Jacobi embedding

\[
                         \iota:C\hookrightarrow J.
\]

For an integer \(n\) prime to \(p\), form the Cartesian square

\[
\begin{CD}
C_n @>>> J\\
@V q_n VV @VV [n] V\\
C @>{\iota}>> J.
\end{CD}
\tag{24.1}
\]

Multiplication by \(n\) on \(J\) is finite etale of degree \(n^{2g}\), so
\(q_n\) is finite etale of that degree. We next check that \(C_n\) is
connected. The cover in (24.1) is the \(J[n]\)-torsor whose monodromy is
the composite

\[
 \pi_1^{\mathrm{et}}(C)\longrightarrow
 \pi_1^{\mathrm{et}}(J)\longrightarrow J[n](k).
\]

The Abel--Jacobi map induces the canonical isomorphism from the maximal
abelian prime-to-\(p\) quotient of
\(\pi_1^{\mathrm{et}}(C)\) to
\(\pi_1^{\mathrm{et}}(J)^{(p')}\). In particular the displayed monodromy
onto \(J[n](k)\simeq(\mathbf Z/n)^{2g}\) is surjective. Hence the torsor
\(C_n\) is connected.

The upper horizontal map identifies \(C_n\) with the inverse-image curve
\([n]^{-1}(\iota(C))\subset J\): once its \(J\)-coordinate \(a\) is known,
the equality \(\iota(c)=[n]a\) and injectivity of \(\iota\) determine \(c\).

Choose a globally generated ample line bundle \(L\) on \(J\), replacing an
ample line bundle by a sufficiently high fixed power if necessary, and put

\[
                         A_C=\deg(\iota^*L)>0.
\]

The restriction of \(L\) to \(C_n\) is globally generated. Two suitable
global sections have no common zero on \(C_n\): choose a first section
whose restriction is nonzero, then choose the second outside the finitely
many hyperplanes of sections vanishing at a zero of the first. They give a
morphism \(C_n\to\mathbf P^1\), and therefore

\[
             \operatorname{gon}(C_n)\leq\deg(L|_{C_n}).
\tag{24.2}
\]

Numerically, \([n]^*\) acts by \(n^{2r}\) on codimension-\(r\) cycles on an
abelian variety. Here is an equivalent direct intersection calculation.
Since \([n]^*L\equiv n^2L\) and \(\deg[n]=n^{2g}\), the projection formula
gives

\[
                         [n]_*L\equiv n^{2g-2}L.
\]

Using \([C_n]=[n]^*[\iota(C)]\) and the projection formula once more,

\[
 \deg(L|_{C_n})
 =L\cdot[n]^*[\iota(C)]
 =[n]_*L\cdot[\iota(C)]
 =n^{2g-2}A_C.
\tag{24.3}
\]

Finally, etale Riemann--Hurwitz gives

\[
                         g(C_n)-1=n^{2g}(g-1).
\tag{24.4}
\]

Combining (24.2)--(24.4) yields

\[
 0\leq
 \frac{\operatorname{gon}(C_n)}{g(C_n)-1}
 \leq \frac{A_C}{(g-1)n^2}.
\]

Letting \(n\) tend to infinity through integers prime to \(p\) proves the
theorem. \(\square\)

## Consequence for the common-cover problem

The normalized gonality of an individual cover can contain useful
information, and a lower bound for a restricted tower can still be useful.
But the infimum over the full finite-etale tower is always zero. Therefore
neither \(\gamma_{\mathrm{et}}(C)\) nor any proposed obstruction that only
requires this infimum to differ between two curves can disprove the
common-cover assertion.
