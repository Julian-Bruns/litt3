# An actual two-leg obstruction over the second Witt vectors

**Status: exact construction and author proof, 2026-09-05; computational
group-generation certificate included; independent audit pending.**

Over (k=\overline{\mathbf F}_5), there are two finite etale Galois maps

\[
                 f:\mathcal H\longrightarrow X,
                 \qquad g:\mathcal H\longrightarrow Y
\]

of degree (3), where

\[
             g(\mathcal H)=10,\qquad g(X)=g(Y)=4,
\]

such that each map separately lifts over (W_2(k)), but there is no marked
lifting of the three curves over (W_2(k)) on which both maps lift.  Thus the
affine obstruction of Proposition 110.1 is nonzero for an actual pair of
finite etale maps.

The obstruction below is genuinely a (W_2)-obstruction.  A characteristic
zero automorphism bound is neither used nor sufficient.

## 1. Two free cubic actions generating the unitary group

Use the Hermitian plane model

\[
 \mathcal H:\quad \bar v^{,t}Jv=0,\qquad
 J=\begin{pmatrix}0&0&1\\0&1&0\\1&0&0\end{pmatrix},
 \tag{114.1}
\]

over \(\mathbf F_{25}=\mathbf F_5(a)\), where
\(a^2+4a+2=0\) and \(\bar z=z^5\).  This is isomorphic over (k) to

\[
                         y^5+y=x^6.
\]

Consider the following matrices:

\[
R=\begin{pmatrix}
3&3a+1&3\\
4&4a+4&a+1\\
4a+2&4a+3&a+3
\end{pmatrix},
\quad
S=\begin{pmatrix}
4a+3&a+1&4a+2\\
2a+1&4a+2&3\\
a+3&3a+4&2
\end{pmatrix}.
\tag{114.2}
\]

Exact arithmetic gives

\[
 \det R=\det S=1,\qquad
 \bar R^{,t}JR=\bar S^{,t}JS=J,
\]

\[
 R^3=S^3=1,\qquad
 \chi_R(T)=\chi_S(T)=T^3-1,
 \tag{114.3}
\]

and

\[
             |\langle R,S\rangle|=378000=|\operatorname{SU}_3(5)|.
\tag{114.4}
\]

These checks are reproduced by
`114_HERMITIAN_TWO_LEG_W2_CERTIFICATE.sage`.  After quotienting by the
scalar center of order (3), the projective images (r,s) generate

\[
                   G=\operatorname{PSU}_3(5),qquad |G|=126000.
\]

Both (r) and (s) act freely on \(\mathcal H\).  Indeed, each has three
distinct eigenvalues (1,\zeta,\zeta^2\).  If (v,w) are eigenvectors with
distinct eigenvalues \(\lambda,\mu\), unitarity gives

\[
 h(v,w)=h(Rv,Rw)=\lambda^5\mu h(v,w)
                 =(\mu/\lambda)h(v,w),
\]

so the three eigenlines are mutually orthogonal.  Nondegeneracy of (h)
then makes every eigenline anisotropic: if one were isotropic, it would be
orthogonal to the whole space.  A projective fixed point is an eigenline,
whereas \(\mathcal H\) is the locus of isotropic lines.  Hence neither
nonidentity element of either cubic subgroup fixes a point of the curve.

Put

\[
            A=\langle r\rangle,\qquad B=\langle s\rangle,
            \qquad X=\mathcal H/A,\quad Y=\mathcal H/B.
\]

The quotient maps are therefore finite etale Galois maps of degree (3).
Since the Hermitian curve has genus (10), etale Riemann--Hurwitz gives

\[
                         g(X)=g(Y)=4.
\]

## 2. The generated action is not weakly ramified

On the model \(y^5+y=x^6\), let (P_\infty) be the unique point at infinity.
Choose (0\ne b\in\mathbf F_{25}\) with (b^5+b=0).  The automorphism

\[
                    \sigma_b:(x,y)\longmapsto(x,y+b)
\tag{114.5}
\]

is a unipotent element of order (5) in
\(\operatorname{PSU}_3(5)\) and fixes (P_\infty).  At that point,

\[
                    v(x)=-5,\qquad v(y)=-6,
\]

so (t=x/y) is a uniformizer.  Directly,

\[
 \sigma_b(t)-t
   =\frac{x}{y+b}-\frac{x}{y}
   =\frac{-bx}{y(y+b)},
\]

and consequently

\[
                         v(\sigma_b(t)-t)=7.
\tag{114.6}
\]

Thus \(\sigma_b\in G_{P_\infty,6}\), in lower ramification numbering.  In
particular the second ramification group is nontrivial, and the action of
(G) on \(\mathcal H\) is not weakly ramified.

Garnek's Corollary 5.8 in
[Equivariant splitting of the Hodge--de Rham exact
sequence](https://doi.org/10.1007/s00209-021-02839-y), Math. Z. 300
(2022), 1917--1938, says that in characteristic (p>2), if a smooth
projective curve together with a faithful finite group action lifts over
\(W_2(k)\), then the action is weakly ramified.  Therefore

\[
                         (\mathcal H,G)
             \quad\text{does not lift over }W_2(k).
\tag{114.7}
\]

## 3. Separate liftability but no simultaneous lift

Each of the two maps lifts separately.  Smooth projective curves lift over
\(W_2(k)\), and finite etale covers are invariant under a nilpotent
thickening.  Thus, after choosing a lifting of (X), the etale cover
\(\mathcal H\to X\) lifts uniquely; the same argument applies independently
to \(\mathcal H\to Y\).  The two resulting liftings of the source need not be
isomorphic.

Suppose instead that one marked smooth lifting \(\widetilde{\mathcal H}\)
supported liftings of both maps.  Invariance of the finite-etale category
also identifies the deck automorphism groups before and after reduction.
Hence (r) and (s) have unique lifts \(\widetilde r,\widetilde s\) on this
same source.

The reduction map

\[
 \operatorname{Aut}_{W_2(k)}(\widetilde{\mathcal H})
       \longrightarrow \operatorname{Aut}_k(\mathcal H)
\tag{114.8}
\]

is injective.  Indeed, an automorphism reducing to the identity across the
square-zero ideal \((5)\) is an infinitesimal automorphism, and its class lies
in \(H^0(\mathcal H,T_{\mathcal H})\); this group is zero because
\(g(\mathcal H)>1\).  It follows that every relation between (r,s) lifts,
and no new relation can occur.  Therefore

\[
                    \langle\widetilde r,\widetilde s\rangle
                          \cong\langle r,s\rangle=G.
\]

This would lift the pair \((\mathcal H,G)\), contradicting (114.7).  No
simultaneous lifting exists.

## 4. Scope

This proves that the obstruction in file 110 can be nonzero for an actual
bi-etale diagram, even when both legs are tame cyclic Galois covers and each
leg separately lifts.  It does not by itself compute the obstruction class
for the fixed genus-(9)/genus-(25) candidate pair, and the two quotient
curves constructed here are isomorphic because their cubic subgroups are
conjugate.
