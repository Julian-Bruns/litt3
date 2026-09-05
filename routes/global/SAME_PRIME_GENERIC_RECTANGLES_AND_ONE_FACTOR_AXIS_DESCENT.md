# Same-prime generic rectangles and one-factor axis descent

Date: 2026-09-05.
Author: /root; product-line transversality, torsion intersections, and connected
tail groups checked by /root/gluing_cohomology_rigidity on this date.
Status: collaborative author proof; not a full independent audit.
No existing special case is deleted.

## 1. A single prime suffices for suitable directions

Work over \(k=\overline{\mathbf F}_p\). Fix actual finite étale maps
\[
                         X\xleftarrow f Z\xrightarrow g Y
\]
between smooth projective connected hyperbolic curves. Put
\(A_X=J(X^{(1)})\), \(A_Y=J(Y^{(1)})\), and assume
\[
 D=\{(L,M):H^0(Z^{(1)},B_Z\otimes f^{(1)*}L\otimes g^{(1)*}M)\ne0\}
                                  \subset A_X\times A_Y          \tag{1}
\]
is proper, where \(B_Z=F_{Z*}\mathcal O_Z/\mathcal O_{Z^{(1)}}\).
This is an additional hypothesis; it is not proved here.

Fix ONE prime \(\ell\ne p\). A rational Tate line in \(V_\ell A_X\)
specifies a rank-one Prüfer subgroup
\(\Gamma_X\subset A_X[\ell^\infty](k)\); similarly for \(Y\).
The finite subgroups \(\Gamma_X[\ell^m]\), \(\Gamma_Y[\ell^n]\) specify
actual cyclic étale towers \(X_m/X,Y_n/Y\).

**Theorem A.** There is an open dense full-measure set of PAIRS of directions
in
\[
            \mathbf P(V_\ell A_X)\times\mathbf P(V_\ell A_Y)
\]
such that compatible connected components
\[
                    W_{m,n}\subset Z\times_X X_m\times_Y Y_n
\]
have, beyond a finite corner \((a,a)\), full product tail groups
\[
 \operatorname{Gal}(W_{m,n}/W_{a,a})
      \simeq(\mathbf Z/\ell^{m-a})\times(\mathbf Z/\ell^{n-a}),       \tag{2}
\]
with the two axis quotients \(W_{a,n},W_{m,a}\). The mixed Jacobian
contribution relative to these tails is ordinary. In particular,
\[
 \Delta(W_{m,n})=\Delta(W_{m,a})+\Delta(W_{a,n})-\Delta(W_{a,a}),     \tag{3}
\]
where \(\Delta(C)=g(C)-f_p(C)\).

No simplicity, Hom-zero, or nonisogeny assumption on the endpoint Jacobians
is needed. The two directions must be chosen jointly: this is not a claim
that every prescribed pair works. Even when \(X=Y\) and \(f=g\), a suitable
pair of distinct directions is allowed.

**Theorem B.** Fix a hyperbolic target \(T\) whose Jacobian has a nonordinary
simple factor \(A\) of dimension at least three. For the towers in Theorem A
there is a larger corner \((b,b)\) such that, for all \(m,n\ge b\),
\[
 \operatorname{Et}(W_{m,n},T)
       =\operatorname{Et}(W_{b,n},T)\ \cup\
                             \operatorname{Et}(W_{m,b},T).        \tag{4}
\]
Maps are identified with their pullbacks. The intersection of the two
sets is \(\operatorname{Et}(W_{b,b},T)\).
Other simple factors of \(J_T\) may be ordinary. The cutoff \(b\) may depend
on \(T,A\); no common cutoff for all targets is asserted.

## 2. Product-line transversality

For any proper abelian subvariety \(B\subset A_X\times A_Y\), let
\(\pi:A_X\times A_Y\to Q=(A_X\times A_Y)/B\).
On Tate spaces, write \(\pi_X,\pi_Y\) for its two restrictions.

If \(B\) contains neither full axis, both \(\pi_X,\pi_Y\) have nonzero
abelian images. Their rational Tate images have dimension at least two.
There consequently exist lines \(U_X,U_Y\) whose images are nonzero and
linearly independent in \(V_\ell Q\): choose a nonzero vector from the
first image, then one in the second image outside its span. This is a
nonempty Zariski-open condition on the pair. Under it,
\[
                         (U_X\oplus U_Y)\cap V_\ell B=0.          \tag{5}
\]

If \(B\) contains exactly the X-axis, it is \(A_X\times B_Y\) for a proper
abelian subvariety \(B_Y\subset A_Y\). Choose \(U_Y\not\subset V_\ell B_Y\).
Then the intersection in (5) is exactly \(U_X\). The reverse case is
symmetric. A proper \(B\) cannot contain both full axes.

For finitely many such \(B\), the simultaneous conditions still form a
nonempty Zariski-open subset of the product of projective spaces. Over
\(\mathbf Q_\ell\) this is open dense and full measure. It need not be
a product of two separately specified open sets.

## 3. From Tate lines to bounded torsion strips

The proved Boxall-method decomposition gives finitely many cosets
\[
 D(k)\cap(A_X\times A_Y)[\ell^\infty](k)
       =\bigcup_j\left(t_j+B_j[\ell^\infty](k)\right),
             \qquad t_j+B_j\subset D.                           \tag{6}
\]
Use the product-line conditions for every \(B_j\), and put
\(\Gamma=\Gamma_X\times\Gamma_Y\).

If neither axis is contained in \(B_j\), (5) makes
\(\Gamma\cap B_j[\ell^\infty]\) finite. Explicitly, on the rank-two
saturated Tate lattice the quotient map is injective after tensoring
with \(\mathbf Q_\ell\). Smith normal form makes its kernel on the
corresponding divisible torsion group finite.

If the X-axis is contained, the intersection is
\[
                 \Gamma_X\times(\Gamma_Y\cap B_Y[\ell^\infty]),
 \]
with the second factor finite by the same rank-one argument.
The analogous statement holds for the other axis.

A nonempty coset intersection with \(\Gamma\) is a translate of one
of these subgroups by one point of \(\Gamma\). Finitely many such points
and finite subgroups give a uniform coordinate-order cutoff \(a_\theta\):
\[
 \begin{split}
  L\in\Gamma_X,\ M\in\Gamma_Y,\quad
  \operatorname{ord}(L)>\ell^{a_\theta},\
  \operatorname{ord}(M)>\ell^{a_\theta}\\
                    \Longrightarrow (L,M)\notin D.             \tag{7}
 \end{split}
\]
Neither arithmetic Frobenius invariance of the chosen directions nor
distinct primes are used.

## 4. Actual connected components and their tail groups

Add one more subvariety to the finite transversality list:
\[
  B_0=\left(\ker\left(f^{(1)*}+g^{(1)*}:A_X\times A_Y\to
                                      J(Z^{(1)})\right)_{\rm red}\right)^0.
\]
It contains neither full axis, since each étale pullback has finite
kernel. Condition (5) for \(B_0\) makes the combined map on the two
Prüfer directions have finite kernel. By character duality, the image
\(\Lambda\) of \(\pi_1(Z)\) in the two chosen deck lattices
\(\mathbf Z_\ell^2\) has full rank and is open.

Choose \(a\ge a_\theta\) with \(\ell^a\mathbf Z_\ell^2\subset\Lambda\).
At levels \(m,n\ge a\), the full coordinate tails
\[
 (\ell^a\mathbf Z_\ell/\ell^m\mathbf Z_\ell)
       \times(\ell^a\mathbf Z_\ell/\ell^n\mathbf Z_\ell)
\]
therefore preserve every connected component and act as its full
Galois group over its corner component. Quotienting by one tail gives
the corresponding connected axis component. This proves (2), without
assuming that the initial two covers over \(Z\) were disjoint.

## 5. The entire mixed contribution is ordinary

On the full rectangle, character decomposition labels cohomology by
\((L,M)\in\Gamma_X[\ell^m]\times\Gamma_Y[\ell^n]\).
Étale base change and projection formula identify the first Frobenius
kernel at a label with the group in (1), with the usual relative-Frobenius
twists. Frobenius permutes labels by multiplication by \(p\), which
preserves their coordinate orders.

The mixed tail projector \((1-e_X)(1-e_Y)\) selects precisely labels
nontrivial on both tails, namely those with both orders greater than
\(\ell^a\). All these labels and their Frobenius orbits avoid \(D\)
by (7). Hence Frobenius is bijective on the entire mixed cohomology
block, not just free of a chosen first kernel.

The tail projectors preserve individual connected components. Restricting
the preceding assertion gives an ordinary mixed factor on each component.
Equivalently the quotient
\[
 J(W_{m,n})/
    \left(\operatorname{Im}J(W_{m,a})+\operatorname{Im}J(W_{a,n})\right)
\]
is ordinary. The four commuting axis projectors give (3).

## 6. One-factor descent after a larger corner

Fix a quotient \(\rho:J_T\to A\) as in Theorem B. An ordinary abelian
variety has no nonzero homomorphism to nonordinary simple \(A\).
Theorem A therefore supplies the projected mixed-vanishing hypothesis of
[the one-simple-factor descent theorem](ONE_SIMPLE_FACTOR_CONTROLS_MIXED_ETALE_MAP_DESCENT.md).
That theorem supplies \(M(T,\rho)\), independent of \(m,n\), such that
one tail factor has an orbit of at most \(M\) on any actual map
\(r:W_{m,n}\to T\).

Choose \(c\ge0\) with \(\ell^c\ge M\), and set \(b=a+c\).
A subgroup of either cyclic tail of index at most \(M\) contains its
\(\ell^c\)-multiple. Thus \(r\) descends to \(W_{b,n}\) or \(W_{m,b}\).
For an étale \(r\) the descended map stays étale, proving (4).
Conversely, any map from either axis pulls back to the rectangle.

A map coming from both axes is fixed by both corresponding tail
subgroups, hence by their product, and descends to \(W_{b,b}\).
This proves the intersection assertion.

## 7. Use and remaining limitations

The new features are a single fixed prime, arbitrary endpoint Jacobians,
and control through only one nonordinary simple target factor. All
covering degrees in the chosen directions are allowed.

The chosen generic directions are existential; their finite cutoffs are
not computed here. More importantly, properness in (1) remains an
additional hypothesis, and these abelian rectangles are not shown cofinal
in the towers attached to arbitrary common covers. Equation (4) gives a
union of two boundary towers, not a finite set of target maps.
No claim to resolve Litt's problem follows.
