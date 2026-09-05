# Separable pullback of the Cartier bundle detects the full different

**Status:** author proof and exact local calculation, 2026-09-05.
**Author/checker:** canonical_trace_algebra.
**Scope:** finite separable maps of smooth curves over a perfect field of
odd characteristic. No Galois or tame hypothesis is imposed.

Use the relative Frobenius conventions of
[file 22](22_CARTIER_BUNDLE_ETALE_FUNCTORIALITY_AND_LIMITS.md):
\[
 F_C:C\longrightarrow C^{(1)},\qquad
 0\longrightarrow\mathcal O_{C^{(1)}}\longrightarrow
 F_{C,*}\mathcal O_C\longrightarrow B_C^1\longrightarrow0.
 \tag{1}
\]
Let \(h:Z\to X\) be finite separable between smooth geometrically connected
curves over a perfect field \(k\) of characteristic \(p>2\). Put
\(r=(p-1)/2\). Write \(R_h\) for the effective different divisor, so that
\[
 dh:h^*\omega_X\longrightarrow\omega_Z,\qquad
 \operatorname{im}(dh)=\omega_Z(-R_h).
 \tag{2}
\]
Its multiplicities are the full different exponents, not \(e-1\) in
the wild case. The divisor \(R_h^{(1)}\) is its Frobenius twist on
\(Z^{(1)}\); its coefficients are unchanged.

## 1. Canonical injection and exact determinant divisor

### Theorem

There is a canonical exact sequence on \(Z^{(1)}\)
\[
 0\longrightarrow (h^{(1)})^*B_X^1
 \xrightarrow{\alpha_h} B_Z^1
 \longrightarrow T_h\longrightarrow0,
 \tag{3}
\]
where \(T_h\) is a torsion sheaf. Under the canonical symplectic
determinant identifications
\(\det B_C^1\simeq\omega_{C^{(1)}}^{\otimes r}\), its determinant is
\[
                     \det\alpha_h=(dh^{(1)})^{\otimes r}.
 \tag{4}
\]
In particular,
\[
 \boxed{\operatorname{div}(\det\alpha_h)=rR_h^{(1)},\qquad
 \operatorname{Fitt}_0(T_h)=\mathcal O_{Z^{(1)}}(-rR_h^{(1)}).}
 \tag{5}
\]
At each geometric point \(z\), with different exponent \(d_z\),
\[
 \boxed{\operatorname{length}_{\mathcal O_{Z^{(1)},z^{(1)}}}
       (T_{h,z^{(1)}})=r\,d_z.}
 \tag{6}
\]
Thus \(\alpha_h\) is an isomorphism precisely where \(h\) is étale.
For projective curves,
\[
 \deg T_h=r\,\deg R_h
 =r\bigl(2g(Z)-2-\deg(h)(2g(X)-2)\bigr).
 \tag{7}
\]
The local equality (6), not just (7), includes arbitrary wild ramification.

### Construction and injectivity

The commutative Frobenius square gives a canonical algebra map
\[
 \beta_h:(h^{(1)})^*F_{X,*}\mathcal O_X
       \longrightarrow F_{Z,*}\mathcal O_Z,\qquad
 b\otimes a\longmapsto F_Z^\#(b)\,h^\#(a).
 \tag{8}
\]
Both sides are locally free of rank \(p\) over \(\mathcal O_{Z^{(1)}}\).
The map \(h^{(1)}\) is flat, since a finite map between smooth
connected curves is flat. Pullback of (1) therefore remains exact.
Map (8) takes its unit subbundle identically to the unit subbundle
of \(F_{Z,*}\mathcal O_Z\).

Generically, (8) is an isomorphism: for a finite separable extension
of one-variable function fields \(L/K\) over a perfect field,
\(L^pK=L\) and \([K:K^p]=[L:L^p]=p\). Equivalently a separating
parameter of \(K\) remains a \(p\)-basis in \(L\). Hence (8) is
injective between torsion-free bundles of equal rank, with torsion
cokernel. The snake lemma for the two unit sequences now gives
(3), and identifies \(T_h\) also with \(\operatorname{coker}\beta_h\).

This construction is compatible with composition:
\[
 \alpha_{h\circ g}=\alpha_g\circ(g^{(1)})^*\alpha_h
 \quad\text{for finite separable }g:V\to Z.
 \tag{9}
\]
It specializes to the canonical étale isomorphism of file 22.

### Canonical determinant, including its section

The perfect alternating pairing on \(B_C^1\) is
\[
 \langle\bar a,\bar b\rangle_C
   =\operatorname{Car}_C(a\,db)\in\omega_{C^{(1)}}.
 \tag{10}
\]
Cartier is natural under pullback of differentials. Therefore
\[
 \langle\alpha_h(s),\alpha_h(t)\rangle_Z
  =dh^{(1)}\bigl((h^{(1)})^*\langle s,t\rangle_X\bigr).
 \tag{11}
\]
Here Cartier naturality holds for the actual separable map, not just
for étale maps. It follows from the defining formula for inverse
Cartier,
\[
                 C^{-1}(d(a\otimes1))=[a^{p-1}\,da],
\]
which commutes with every pullback; exact differentials map to exact
differentials. See the construction and uniqueness in
[Katz, *Nilpotent connections and the monodromy theorem*,
Theorem 7.2 and formula (7.2.3)](https://web.math.princeton.edu/~nmk/old/nilpconn.pdf).

Taking Pfaffians in (11) gives (4); equivalently take the \(r\)-fold
exterior product and divide by \(r!\), which is invertible. Thus the
determinant identity includes its distinguished morphism of line bundles,
not only their abstract isomorphism classes. Since
\(\operatorname{div}(dh^{(1)})=R_h^{(1)}\), (5) follows. The
determinant-length identity over a DVR proves (6).

## 2. Independent completed-local determinant calculation

It suffices to extend the perfect constants and complete at a geometric
point. Write
\[
 k[[t]]\longrightarrow k[[u]],\qquad
 t\longmapsto\phi(u)=\sum_n a_nu^n,\qquad \phi'(u)\ne0.
\]
Use twist coordinates \(T,U\) with \(F_X^\#T=t^p\) and
\(F_Z^\#U=u^p\). The coefficient convention is important:
\[
 (h^{(1)})^\#T=\phi^{(1)}(U):=\sum_n a_n^pU^n,\qquad
 \phi^{(1)\prime}(u^p)=\phi'(u)^p.
 \tag{12}
\]
The completed Frobenius base-change algebra and its map are
\[
 k[[U]][t]/(t^p-\phi^{(1)}(U))
       \longrightarrow k[[u]],\qquad t\longmapsto\phi(u).
 \tag{13}
\]
Both are rank \(p\) over \(k[[U]]\). Relative to the bases
\(1,t,\ldots,t^{p-1}\) and \(1,u,\ldots,u^{p-1}\), define \(A\) by
\[
              \phi(u)^i=\sum_{j=0}^{p-1}A_{ji}(u^p)u^j.
 \tag{14}
\]
Its first column is \((1,0,\ldots,0)^{\mathsf T}\). Removing that
row and column gives the matrix \(A_B\) of \(\alpha_h\), so
\(\det A=\det A_B\).

Let \(D=d/du\). Every entry \(A_{ji}(u^p)\) is killed by \(D\).
For derivative orders \(0,\ldots,p-1\), the Wronskians give
\[
 \det\bigl(D^j\phi(u)^i\bigr)_{j,i}
    =\det\bigl(D^ju^i\bigr)_{j,i}\,\det A(u^p).
 \tag{15}
\]
The second Wronskian is \(\prod_{i=0}^{p-1}i!\ne0\).
The chain rule expresses the first as
\[
 \left(\prod_{i=0}^{p-1}i!\right)
       \phi'(u)^{\,0+1+\cdots+(p-1)}:
\]
the change from \(D_u^j\) to differentiation with respect to \(\phi\)
is triangular with diagonal \(\phi'(u)^j\). Cancelling gives the
exact identity
\[
 \boxed{\det A_B(u^p)=\phi'(u)^{p(p-1)/2}
            =\phi^{(1)\prime}(u^p)^r.}
 \tag{16}
\]
The different is generated by \(\phi'(u)\), so
\(d=\operatorname{ord}_u\phi'(u)\). Passing from \(u\)-valuation
to \(U\)-valuation divides by \(p\), not multiplies by \(p\):
\[
 \operatorname{ord}_U\det A_B
  =\frac1p\operatorname{ord}_u\det A_B(u^p)
  =\frac1p\cdot prd=rd.
 \tag{17}
\]
This independently verifies the wild local length and twist scaling.

Algebra (13) is a domain when \(\phi'\ne0\); its fraction field
maps isomorphically to \(k((u))\). The target \(k[[u]]\) is its
normalization. Thus \(T_h\) also measures the normalization defect
of the Frobenius base-change algebra. In the ramified case this
algebra is not silently identified with its normalization.

## 3. Tame elementary divisors

In the tame case, étale-local parameters give \(t=u^e\), \(p\nmid e\).
For \(1\le i\le p-1\), write
\[
 ei=pq_i+j_i,\qquad q_i=\left\lfloor\frac{ei}{p}\right\rfloor,
 \quad 1\le j_i\le p-1.
\]
The \(j_i\) permute \(1,\ldots,p-1\). Thus \(A_B\) is a permutation
matrix times a diagonal matrix with entries \(U^{q_i}\), and
\[
 \boxed{T_{h,z^{(1)}}\simeq
  \bigoplus_{i=1}^{p-1}k[[U]]/(U^{\lfloor ei/p\rfloor}).}
 \tag{18}
\]
Summands of exponent zero vanish. These exponents, sorted if desired,
are the elementary divisors. Their sum is
\[
 \sum_{i=1}^{p-1}\left\lfloor\frac{ei}{p}\right\rfloor
  =\frac1p\left(e\sum_i i-\sum_i j_i\right)
  =\frac{(p-1)(e-1)}2,
 \tag{19}
\]
as required by the tame different exponent \(d=e-1\).

## 4. Wild elementary divisors: constraints and a check

For arbitrary separable ramification, define
\(0\le\lambda_1\le\cdots\le\lambda_{p-1}\) by the Smith normal form
of \(A_B\). Besides their sum \(rd\), the pairing identity gives
\[
 \boxed{\lambda_i+\lambda_{p-i}=d\quad(1\le i\le p-1).}
 \tag{20}
\]
Indeed, choose unimodular pairing matrices \(J_X,J_Z\). Equation
(11) becomes
\[
 A_B^{\mathsf T}J_ZA_B=aJ_X,\qquad
 a=\phi^{(1)\prime}(U),\quad\operatorname{ord}_U a=d.
\]
Thus \(aA_B^{-1}=J_X^{-1}A_B^{\mathsf T}J_Z\). Its elementary
exponents are both those of \(A_B\) and
\(d-\lambda_{p-1},\ldots,d-\lambda_1\), proving (20).
In particular the different ideal
\(\mathcal O_{Z^{(1)}}(-R_h^{(1)})\) annihilates \(T_h\).

As a wild check in characteristic five, take \(t=u^5+u^6\).
Here \(e=5\), \(\phi'(u)=u^5\), and \(d=5\).
With \(U=u^5\), replace the source basis by
\(1,(t-U),\ldots,(t-U)^4\), a unimodular change.
Since \(t-U=Uu\), the four elementary exponents are \(1,2,3,4\).
Their sum is \(10=2d\), not \(2(e-1)=8\), and their paired sums are \(5\).

## 5. What is, and is not, obtained

The torsion sheaf and its elementary divisors belong to the canonical
map induced by the specified \(h\). They are a morphism-sensitive
ramification detector, including wild ramification, not a numerical
invariant of an isolated Cartier bundle.

For composable finite separable maps, flatness and (9) also give
\[
 0\longrightarrow(g^{(1)})^*T_h
 \longrightarrow T_{h\circ g}\longrightarrow T_g\longrightarrow0,
\]
consistent with \(R_{h\circ g}=R_g+g^*R_h\).
An actual étale second leg may transport (3) without introducing an
additional torsion defect. No arbitrary bundle map is asserted to
integrate to a morphism of curves, and no common-cover exclusion
follows merely from these formulas.

