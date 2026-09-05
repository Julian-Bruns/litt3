# The complex commensurator of the (31,31,31) triangle group

## Status

Proved, using the published classifications of arithmetic triangle groups and
of inclusions between triangle groups.

Throughout, triangle groups are orientation-preserving Fuchsian groups. Put

\[
 \Gamma=\Delta(31,31,31),\qquad
 \Gamma_0=\Delta(2,3,62).
\]

## Theorem

Inside \(\operatorname{PSL}_2(\mathbf R)\),

\[
             \operatorname{Comm}^{+}(\Gamma)=\Gamma_0.
\]

Here \(\operatorname{Comm}^{+}\) denotes the orientation-preserving
commensurator.

### Proof

The quotient

\[
 \mathbf P^1(31,31,31)\longrightarrow \mathbf P^1(2,3,62)
\]

by the permutations of the three stacky points is an \(S_3\)-quotient. On
complex uniformizing groups it gives a normal inclusion

\[
                  \Gamma\triangleleft \Gamma_0,\qquad
                  [\Gamma_0:\Gamma]=6.                 \tag{17.1}
\]

Takeuchi's classification of arithmetic triangle groups shows that
\(\Delta(2,3,62)\) is not arithmetic. More explicitly, the compact
arithmetic groups of the form \(\Delta(2,3,n)\) occurring in his list have

\[
 n\in\{7,8,9,10,11,12,14,16,18,24,30\};
\]

the value \(62\) does not occur.

For a non-arithmetic cocompact triangle group, its orientation-preserving
commensurator is a discrete Fuchsian overgroup of finite index. The
Singerman classification, in the convenient formulation of
Singerman--Syddall, says that for \(\Delta(2,m,n)\), with \(m\leq n\), the
only exceptional ways in which this commensurator can be a larger triangle
group are

\[
 m=n \quad\text{or}\quad 2m=n.
\]

For \((m,n)=(3,62)\), neither equality holds. Consequently

\[
            \operatorname{Comm}^{+}(\Gamma_0)=\Gamma_0. \tag{17.2}
\]

Finally, commensurators do not change on passage to a finite-index subgroup.
Indeed, if \(H\leq G\) has finite index, then an element conjugates \(H\) to
a group commensurable with \(H\) if and only if it conjugates \(G\) to a
group commensurable with \(G\): both assertions follow by inserting the
finite-index inclusions \(H\leq G\) and \(gHg^{-1}\leq gGg^{-1}\).
Applying this to (17.1) and then using (17.2) gives

\[
 \operatorname{Comm}^{+}(\Gamma)
 =\operatorname{Comm}^{+}(\Gamma_0)
 =\Gamma_0.
\]

This proves the theorem. \(\square\)

## Corollary for the characteristic-five problem

The commensurator hypothesis in
15_TAME_OVER_ORBIFOLD_SPECIALIZATION.md is now verified. Hence every tame
over-orbifold of \(\mathbf P^1(31,31,31)\) in characteristic \(5\) factors,
compatibly with the original map, through

\[
 \mathbf P^1(31,31,31)\longrightarrow\mathbf P^1(2,3,62).
\]

Thus a non-visible correspondence, if one exists, must enter through the
wild part of an over-orbifold. The theorem does not by itself exclude that
remaining case.

## References used

1. K. Takeuchi, *Arithmetic triangle groups*, Journal of the Mathematical
   Society of Japan **29** (1977), 91--106, Theorem 3.
   <https://www.jstage.jst.go.jp/article/jmath1948/29/1/29_1_91/_pdf/-char/en>
2. D. Singerman, *Finitely maximal Fuchsian groups*, Journal of the London
   Mathematical Society (2) **6** (1972), 29--38, Proposition 1 and Theorem 2.
   <https://doi.org/10.1112/jlms/s2-6.1.29>
3. D. Singerman and R. I. Syddall, *The Riemann surface of a uniform dessin*,
   Beiträge zur Algebra und Geometrie **44** (2003), 413--430, Theorem 9.1
   and the classification immediately following it.
   <https://www.kurims.kyoto-u.ac.jp/EMIS/journals/BAG/vol.44/no.2/b44h2sin.pdf>
