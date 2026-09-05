# A common ramification defect and the extra orbit Prym

**Status: proved below; self-check and exact cubic character check complete.**

This note refines the audited construction in file 83. The full orbit
curve and the canonical sign double cover have exactly the same genus
defect. Their genus difference is therefore independent of ramification
and of the residual covering degree. This yields a corrected Prym bound
which persists in arbitrary degree.

## 1. Notation

Use the hypotheses and fields of files 81 and 83. In particular

\[
g(X)=s+1,\quad g(Y)=rs+1,\quad M=\frac{mjd}{2},\quad
D\subseteq F=k(C),\quad [F:D]=m,
\]

and

\[
H=\operatorname{Gal}(L/B)\subseteq C_2\wr S_r,
\qquad D=L^{H_0},\qquad j=[H:H_0].
\]

The group \(H_0\) fixes the chosen sign selection, and contains the
coordinate \(r\)-cycle \(\beta\). The canonical sign field is

\[
A=B\left(\prod_i z_i\right)=L^{\ker\epsilon}\subseteq D,
\qquad \nu=[A:B]\in\{1,2\}.
\]

Let \(b=g(B)\), \(N=M/m=jd/2\), and

\[
                         \eta=Ns+1-g(D)\geq0.           \tag{84.1}
\]

The nonnegativity and the exact identity
\(\deg\operatorname{Diff}(C/D)=2m\eta\) follow from the integral
full-orbit square, independently of the assertions below. Inertia of
\(L/B\) is tame of order \(1,2,r\), or \(2r\), by Theorem 83.1.
Write \(u,a,h\) for the numbers of branch values with inertia of
orders \(2,r,2r\), respectively.

## 2. The sign character determines the fixed selections

### Lemma 84.1

The number of sign selections in \(H\cdot0\) fixed by \(\beta\)
equals \(\nu\). More explicitly,

\[
\nu=1\Longleftrightarrow\mathbf1\notin H\cdot0,
\qquad
\nu=2\Longleftrightarrow\mathbf1\in H\cdot0.
\tag{84.2}
\]

Consequently

\[
                            \frac j\nu\equiv1\pmod r. \tag{84.3}
\]

#### Proof

If \(\epsilon=0\), every vertex in \(H\cdot0\) has even weight.
The all-one vertex has odd weight, so is absent. Zero is the only fixed
vertex of \(\beta\) in this orbit.

If \(\epsilon\ne0\), the even and odd parts of \(H\cdot0\) have
equal size \(j/2\): any element of odd sign character exchanges them.
They are both preserved by \(\beta\). The even part contains exactly
one fixed vertex, zero, and hence has cardinality congruent to one
modulo \(r\). The odd part has the same cardinality; since its only
possible fixed vertex is \(\mathbf1\), that vertex must be present.
Each parity part therefore has cardinality congruent to one modulo
\(r\). These facts prove (84.2) and (84.3). \(\square\)

## 3. Exact genus identities

### Theorem 84.2 (the common defect)

One has

\[
\boxed{\quad
\eta=\frac{(r-1)(\nu a+h)}{2r},\qquad
g(A)=\frac{\nu ds}{2}+1-\eta,\qquad
g(D)=\frac{jds}{2}+1-\eta.
\quad}                                                   \tag{84.4}
\]

When \(\nu=1\), necessarily \(u=h=0\). In every case,

\[
\boxed{\quad
g(D)-g(A)=\frac{(j-\nu)ds}{2},\qquad
\eta\in\frac{r-1}{2}\mathbf Z_{\geq0}.
\quad}                                                   \tag{84.5}
\]

The ramification degrees are

\[
\begin{aligned}
\deg\operatorname{Diff}(D/A)&=2\left(\frac j\nu-1\right)\eta,\\
\deg\operatorname{Diff}(C/A)&=\frac{2mj}{\nu}\eta.
\end{aligned}                                             \tag{84.6}
\]

In particular, \(\eta>0\) forces \(r\mid m\), whereas \(\eta=0\)
makes both maps in (84.6) etale.

#### Proof

Consider the permutation action on the \(2r\) signed roots. If
\(E'=B(t,z)\) is quadratic over \(E=B(t)\), this is the connected
degree-\(2r\) cover \(E'\to B\). Otherwise it is the disjoint union
of two copies of the degree-\(r\) cover \(E'\to B\). In either case
the sum of \(2g-2\) over its connected components is \(2drs\), since
each component is etale over \(Y\). Every inertia group is free in
this permutation action. Riemann--Hurwitz therefore gives

\[
2drs=2r(2b-2)+r u+2(r-1)a+(2r-1)h.
\tag{84.7}
\]

We next compute the different contributions for \(D\to B\), whose
permutation action is on the \(j\) sign selections.

An inertia involution has a sign-flipped fixed coordinate, as in the
parity proof of Theorem 83.1. It fixes no sign selection. Its
contribution is consequently \(j/2\).

Every order-\(r\) inertia subgroup is conjugate to
\(\langle\beta\rangle\). By Lemma 84.1 it fixes exactly \(\nu\)
selections. Its contribution is

\[
                         \frac{(r-1)(j-\nu)}r.
\]

For inertia of order \(2r\), its order-\(r\) subgroup projects to a
coordinate \(r\)-cycle. The unique involution in this cyclic group is
the global sign reversal: its coordinate permutation is trivial, and
commuting with a transitive coordinate cycle makes its flips constant.
It is nontrivial, so all coordinates flip. Thus \(\nu=2\). The two
fixed selections of the order-\(r\) subgroup form one two-cycle under
the full inertia, and every other selection has orbit size \(2r\).
Its different contribution is

\[
                    j-1-\frac{j-2}{2r}
                    =\frac{(2r-1)j}{2r}-\frac{r-1}r.
\]

The last expression is only needed when \(h>0\), in which case
\(\nu=2\). Therefore

\[
\begin{split}
2g(D)-2={}&j(2b-2)+\frac j2 u
 +\frac{(r-1)(j-\nu)}r a\\
&+\left(\frac{(2r-1)j}{2r}-\frac{r-1}r\right)h.
\end{split}                                               \tag{84.8}
\]

Multiply (84.7) by \(j/(2r)\) and subtract (84.8). The result is

\[
                       2\eta=\frac{r-1}r(\nu a+h),
\]

which proves the first formula of (84.4).

If \(\nu=1\), the parity character is trivial, so \(u=h=0\).
Equation (84.7) then gives

\[
                     b=\frac{ds}{2}+1-\frac{(r-1)a}{2r}
                       =\frac{ds}{2}+1-\eta.
\]

Here \(A=B\), proving the formula for \(g(A)\).

If \(\nu=2\), the cover \(A\to B\) is ramified precisely at the
\(u+h\) even-inertia branch values. Thus

\[
                          g(A)=2b-1+\frac{u+h}{2}.
\tag{84.9}
\]

Combining (84.9) with (84.7) gives

\[
g(A)=ds+1-\frac{(r-1)(2a+h)}{2r}=ds+1-\eta,
\]

completing (84.4). Its subtraction gives the first identity of (84.5).
The number \(\eta\) is an integer by (84.1), and
\(\gcd(r,(r-1)/2)=1\). Its formula therefore forces
\(r\mid\nu a+h\), and proves the divisibility assertion in (84.5).

Finally, apply Riemann--Hurwitz to the separable maps \(D\to A\)
and \(C\to A\), of degrees \(j/\nu\) and \(mj/\nu\), using
(84.4) and \(g(C)-1=M s=mjds/2\). This proves (84.6).
The implication \(\eta>0\Rightarrow r\mid m\) follows from the
coprime etaleness theorem 83.1. \(\square\)

## 4. The extra sign choices have an intrinsic Prym cost

### Theorem 84.3

Assume \(J(Y)\) is absolutely simple and \(j>\nu\). The nonzero
full-orbit norm

\[
h_D=(E_*/D)_*(E_*/Y)^*:J(Y)\longrightarrow J(D)
\]

is killed by pushforward \(q_*:J(D)\to J(A)\), where \(q:D\to A\).
Consequently its image lies in the Prym variety, and

\[
\boxed{\qquad
                    \frac{(j-\nu)ds}{2}\geq rs+1.
\qquad}                                                  \tag{84.10}
\]

This bound is independent of \(m\) and of the ramification defect.

#### Proof

First suppose \(\nu=1\). Since \(j>1\), Theorem 81.1 gives
\(z\notin E\). The map \(E'\to E\) is a double cover whose
involution restricts to the hyperelliptic involution on \(Y\).
Therefore

\[
                        (E'/E)_*(E'/Y)^*=0:
                             J(Y)\longrightarrow J(E).
\]

Indeed the two points in a fiber map to a hyperelliptic pair, whose
divisor class is independent of the fiber. Since \(A=B\), factoring
\(E_*\to A\) through \(E'\to E\to B\), and using norm-pullback
for the intermediate finite map, gives \(q_*h_D=0\).

Now suppose \(\nu=2\) and \(j>2\). We claim \(A\not\subseteq E'\).
Otherwise \(EA=E'\): the quadratic extension \(A/B\) is linearly
disjoint from the odd-degree extension \(E/B\), and both \(EA\) and
\(E'\) have degree \(2r\) over \(B\). Then \(z\) can be expressed
as a polynomial of degree less than \(r\) in \(t\) with coefficients
in \(A\). The interpolation uniqueness in file 81 implies that all
coefficients of \(Q\) lie in \(A\). Hence \(D=A\), contrary to
\(j>2\).

Thus \(E'/E\) and \(EA/E\) are distinct quadratic extensions. Their
compositum \(E'A\) has an involution over \(EA\) fixing \(t\) and
\(A\), and sending \(z\) to \(-z\). Its restriction to \(Y\) is
the hyperelliptic involution. The same norm argument gives

\[
                       (E'A/EA)_*(E'A/Y)^*=0.
\]

Since \(E_*\) contains \(E'A\), factoring through these maps again
gives \(q_*h_D=0\).

The norm \(h_D\) is nonzero by Theorem 81.2, and simplicity of
\(J(Y)\) makes its image have dimension \(rs+1\). That connected
image is contained in the identity component of \(\ker q_*\), of
dimension \(g(D)-g(A)\). Apply (84.5) to obtain (84.10).
\(\square\)

## 5. Strategic boundary

The two base cases \(j=\nu=1\) and \(j=\nu=2\) have no extra orbit
Prym. They are not eliminated by (84.10). In particular, the generic
birational coefficient case \(j=m=1\), \(d=2M\), remains a distinct
large-degree problem.

The identities above quantify the full higher-sign obstruction without
an uncertain field intersection. They do not assert that the map
\(C\to X\) descends to \(A\) or \(D\), or that any of the displayed
genus inequalities excludes every sufficiently large degree.

## 6. Computational cross-check

On 2026-09-04, an exact Sage calculation enumerated all ten subgroups of
\(C_2\wr S_3\) containing the chosen coordinate three-cycle. For every
group it checked that the sign-character degree equals the number of
fixed selections and that \(j/\nu\equiv1\pmod3\). For all 92 group
elements whose nontrivial cyclic powers are free on signed roots, it
checked the selection-action different contributions in (84.8) and
their difference from the signed-root contributions in (84.7).
All checks passed. The proof above is independent of this finite test;
the short checking script was run in memory rather than retained as
another permanent algorithm.
