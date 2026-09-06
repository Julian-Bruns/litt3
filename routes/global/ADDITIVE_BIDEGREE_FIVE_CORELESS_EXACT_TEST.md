# An explicit ramified additive coreless correspondence in characteristic five

Date: 2026-09-05. Author: /root/additive_bidegree_five_core_test.
Independent check: PASS with the derivative-bound correction below,
/root/additive_projective_counter_global_audit, 2026-09-05;
[audit](audits/ADDITIVE_PROJECTIVE_COUNTER_GLOBAL_AUDIT_2026_09_05.md).
The ramified-fiber lemma was independently checked by
/root/ramified_core_clump_fiber_test on the same date.

## Theorem and scope

Let \(k=\overline{\mathbf F}_5\), and let \(C\) be the smooth projective curve with function field
\[
K=k(x,y),\qquad x-y=(xy)^5.
\]
Then \(C\) has genus four, the separable maps \(x,y:C\to\mathbf P^1\) have degree five, and
\[
k(x)\cap k(y)=k.
\]
Moreover \(dx=dy\ne0\) is holomorphic and Cartier-zero, with divisor \(3P+3Q\) as specified below.

**Scope warning.** Both legs are ramified and both endpoints have genus zero. This is a coreless additive seed, not a finite-etale correspondence between proper hyperbolic curves. No claim of an etale compactification is made here.

## Geometry

Put \(z=xy\) and \(w=x+y\). Then
\[
w^2=z^{10}+4z,\qquad x=(w+z^5)/2,\quad y=(w-z^5)/2.
\]
The degree-ten polynomial has derivative \(4\), so its roots are simple. This hyperelliptic presentation gives a smooth projective curve of genus four, with two points at infinity. Label them \(P,Q\) so that
\[
\operatorname{div}(x)=O+4Q-5P,\qquad
\operatorname{div}(y)=O+4P-5Q,
\]
where \(O\) is the point \(z=w=0\). Indeed, at infinity \(z\) has pole order one and \(w\) pole order five; cancellation in one of \(w\pm z^5\) gives zero order four. At \(O\), both \(x\) and \(y\) have order one.

Differentiating the defining equation gives \(dx=dy\), and
\[
dz=(x+y)dx=w\,dx,\qquad dx=dz/w.
\]
The hyperelliptic differential \(dz/w\) has order three at each point at infinity and no other zeros or poles. Thus \(\operatorname{div}(dx)=3P+3Q\). It is nonzero, so both degree-five maps are separable; as an exact differential it is killed by Cartier. The local degrees include five at the pole and four at the other point at infinity, so the legs are ramified.

The set \(S=\{O,P,Q\}\) is connected and saturated for the two legs:
\[
x^{-1}\{0,\infty\}=S=y^{-1}\{0,\infty\}.
\]
Its incidence edges are \(O:(0,0)\), \(P:(\infty,0)\), and \(Q:(0,\infty)\), with separate copies of \(\mathbf P^1\) for the two endpoint vertex sets.

## Why a nontrivial core would give a Laurent relation

Suppose \(H=k(x)\cap k(y)\ne k\). By Luroth's theorem \(H=k(h)\). The extension \(K/H\) is separable: if an element of \(K\) has fifth power in \(H\), separability of \(K/k(x)\) and \(K/k(y)\) puts the element in both subfields, hence in \(H\). Thus \(H\) is relatively fifth-root closed in \(K\); a separating parameter of \(H/k\) remains separating in \(K\).

Here is the connected-fiber argument, including ramified fibers. Take a finite Galois closure \(N/H\), and set
\[
G=\operatorname{Gal}(N/H),\quad
A=\operatorname{Gal}(N/k(x)),\quad
B=\operatorname{Gal}(N/k(y)),\quad
J=\operatorname{Gal}(N/K).
\]
The intersection defining \(H\) implies \(\langle A,B\rangle=G\). Above any geometric point of the core, choose a decomposition group \(D\). The endpoint vertices and correspondence edges of its fiber are respectively
\[
D\backslash G/A,\qquad D\backslash G/B,\qquad D\backslash G/J,
\]
with the natural incidence maps. Multiplication by elements of \(A\) or \(B\) connects edges through a common endpoint; since these subgroups generate \(G\), the graph is connected. This description uses decomposition groups and therefore applies also at ramified points.

The connected set \(S\) lies in one core fiber: sharing an endpoint forces the same core image. Saturation means that it is a full connected component of that fiber's incidence graph. The preceding argument makes it the entire fiber. Choose the rational coordinate \(h\) on the core with its unique pole at that image. Pullback gives
\[
h=F(x)=G_0(y)
\]
with poles precisely on \(S\). Therefore \(F,G_0\in k[T,T^{-1}]\).

Consequently it suffices to exclude nonconstant common Laurent functions. This use of a finite clump is conditional on having a core; it does not assert uniqueness of finite clumps for arbitrary ramified correspondences.

## Laurent pole bounds and minimality

Any nonconstant common Laurent function has poles at all three points of \(S\): a pole at any one propagates through the connected saturated incidence graph. Write the pole orders of \(F\) at zero and infinity as \(m,n\), and those of \(G_0\) as \(m',n'\). Comparing orders at \(O,P,Q\) gives
\[
m=m',\qquad 5n=4m',\qquad 4m=5n'.
\]
Hence, for an integer \(a>0\), both Laurent polynomials have extreme exponents
\[
-5a,\quad 4a.
\]
Choose a common Laurent function with \(a\) minimal. Any common Laurent function whose two expressions have exponents strictly inside \([-5a,4a]\) must then be constant.

The derivation \(D\) on \(K\) characterized by \(Dx=Dy=1\) is well defined. Applied to the minimal relation it gives \(F'(x)=G_0'(y)\). Its largest exponent is at most \(4a-1\). If nonconstant, the common-Laurent pole calculation would force its largest exponent to be \(4b\) with \(b<a\), contradicting minimality. Thus the derivative is a constant \(c\). This argument does not incorrectly assume a strict lower exponent bound after differentiation. If \(c=0\), taking fifth roots gives a nonconstant common Laurent relation with smaller \(a\), again a contradiction. Thus \(c\ne0\). The highest exponent \(4a\) must be divisible by five, so \(5\mid a\), in particular \(a\ge5\).

Write \(s=c^{1/5}\) and
\[
F(x)=cx+H_1(x)^5,\qquad G_0(y)=cy+J_1(y)^5.
\]
Then
\[
H_1(x)-J_1(y)=-s z.
\]
Differentiation gives the common Laurent function
\[
H_1'(x)+sx=J_1'(y)-sy.
\]
The exponents of \(H_1,J_1\) lie in \([-a,4a/5]\); the displayed expressions have exponents strictly inside \([-5a,4a]\). They equal a constant \(b\). The kernel of Laurent differentiation consists exactly of fifth powers, so
\[
H_1=bx-\frac{s}{2}x^2+U(x)^5,\qquad
J_1=by+\frac{s}{2}y^2+V(y)^5.
\]
Substituting and using \(x-y=z^5\) gives
\[
(U-V)^5=-b z^5+\frac{s}{2}z^{10}.
\]
Thus there is a relation
\[
U(x)-V(y)=qz^2+rz+t,\qquad q\ne0,
\tag{1}
\]
(initially \(t=0\)). Both Laurent exponent sets have absolute value at most
\[
R_0=\max\{\lfloor a/5\rfloor,1\}.
\]

## A strict descent preserving a nonzero quadratic coefficient

Suppose
\[
A_0(x)-B_0(y)=qz^2+rz+t,\qquad q\ne0,
\tag{2}
\]
with Laurent exponents bounded in absolute value by an integer \(R\le R_0\). Since
\[
Dz=w,\quad Dw=2,\quad w^2=z^{10}+4z,
\]
calculation in characteristic five gives
\[
D^2z^2=2z^{10}+2z,\qquad D^3z^2=2w.
\]
Taking three derivatives in (2) yields the common Laurent function
\[
A_0'''(x)-2qx=B_0'''(y)+2qy.
\]
Its exponents lie in \([-R-3,\max(R-3,1)]\), strictly inside \([-5a,4a]\), because \(a\ge5\) and \(R\le R_0\). Minimality makes it a constant \(b_1\). Consequently
\[
\begin{aligned}
A_0(x)&=\frac q2x^4+b_1x^3+C(x)^5x^2+E(x)^5x+L(x)^5,\\
B_0(y)&=-\frac q2y^4+b_1y^3+F_1(y)^5y^2+I(y)^5y+M(y)^5.
\end{aligned}
\tag{3}
\]
These are exact Laurent decompositions: the kernel of the third derivative has exponents congruent to \(0,1,2\) modulo five. The coefficients follow from \(D^3T^4=4T\) and \(D^3T^3=1\).

Take two derivatives of (2), substitute (3), and use
\(x^2+y^2=z^{10}+2z\), \(x-y=z^5\). The result is
\[
q(z^{10}+2z)+b_1z^5+2(C^5-F_1^5)
=2qz^{10}+2qz+2r.
\]
Therefore
\[
C(x)-F_1(y)
=\left(\frac q2\right)^{1/5}z^2
 +\left(-\frac{b_1}{2}\right)^{1/5}z+r^{1/5}.
\tag{4}
\]
This has the same form as (2), with a nonzero quadratic coefficient. Moreover, \(C\) is formed from terms of \(A_0\) of exponent \(n\equiv2\pmod5\), replacing \(n\) by \((n-2)/5\); the same holds for \(F_1\). Their exponent bound is consequently
\[
R_{\rm new}\le\left\lfloor\frac{R+2}{5}\right\rfloor.
\]
For every integer \(R\ge1\) this strictly decreases \(R\). Iterating reaches \(R\le1\). At that point \(A_0'''\) can only have an \(x^{-4}\) term, whereas its already-proved identity \(A_0'''=2qx+b_1\) has a nonzero \(x\) term. This contradiction excludes (1), hence the original common Laurent function, and proves \(k(x)\cap k(y)=k\).

The proof above is independent of numerical sampling. An earlier discovery
calculation used an inconsistent sign in its power reduction and is not
retained as evidence. The correct identity is
\(y^5=x^{-4}-x^{-5}y\); this does not affect the displayed geometric
or differential proof.
