# Two-pole genus-\(p-1\) curves and the impossible weak \(A_5\) profile

Date: 2026-09-05.

Status: proved. The gluing/cohomology agent derived the two-pole and branch-orbit obstruction; the root agent checked the orbit argument and requested the parameterized formulation. Collaborative author verification, not an independent audit.

## 1. A two-pole lemma in every odd characteristic

Let \(k\) be algebraically closed of odd characteristic \(p\), and let \(C/k\) be a smooth projective curve of genus \(p-1\) with a faithful action of \(P\simeq C_p\).

If \(P\) has exactly two fixed points, both with lower ramification break \(1\), then:

1. \(C/P\simeq\mathbf P^1\);
2. suitable generators of the function field satisfy
   \[
   k(C)=k(x,y),\qquad y^p-y=ax+\frac b x,\qquad a,b\in k^\times;
   \]
3. \(C\) is hyperelliptic, with model
   \[
   z^2=(y^p-y)^2-4ab;
   \]
4. the hyperelliptic branch set has exactly \(2p\) distinct points, and \(C\) is ordinary.

### Proof

Each fixed point has different exponent \(2(p-1)\). Writing \(h=g(C/P)\), Riemann–Hurwitz gives

\[
2p-4=p(2h-2)+4(p-1),
\]

so \(h=0\). The quotient is an Artin–Schreier cover of a rational curve. Move its two branch points to \(0,\infty\). The reduced Artin–Schreier representative has a simple pole at each, since its pole orders equal the corresponding lower breaks, and no other poles. Thus it is \(ax+b/x+c\), with \(ab\ne0\). A constant change in \(y\) removes \(c\), since \(k\) is algebraically closed.

Multiplying by \(x\) and setting \(z=2ax-(y^p-y)\) gives the asserted quadratic model. Conversely \(x=(z+y^p-y)/(2a)\), so it defines the same function field. The polynomial on the right has degree \(2p\) and is square-free: its derivative is \(-2(y^p-y)\), which cannot vanish at a root because \(ab\ne0\). Infinity is unramified in this even-degree quadratic model. Hence the hyperelliptic branch set consists of its \(2p\) roots.

Finally, Deuring–Shafarevich gives

\[
f(C)-1=p(0-1)+2(p-1)=p-2,
\]

and therefore \(f(C)=p-1=g(C)\). \(\square\)

This normal form is a special case of the primary classification of wild genus-\(p-1\) curves in Arakelian–Speziali, Lemma 4.1, Theorem 4.2(b), and the wild part of Theorem 4.4. Their relevant proofs were read: the two-fixed-point case is precisely the two-simple-pole hyperelliptic case, whereas the one-fixed-point case has a cubic polynomial Artin–Schreier representative. The coordinate change above places the poles at \(0,\infty\), rather than their \(0,1\). Our direct proof also covers \(p=3\), while those statements assume genus greater than two. [*Algebraic curves with automorphism groups of large prime order*, preprint pp. 9–11](https://arxiv.org/pdf/2007.01338).

## 2. Ordinarity forces the hypotheses

If \(C\) is ordinary of genus \(p-1\) and \(C_p\subset\operatorname{Aut}(C)\), then it satisfies every conclusion of §1.

Indeed, let \(r\) be the number of fixed points and \(f_0=f(C/P)\). Deuring–Shafarevich reads

\[
p-2=p(f_0-1)+r(p-1),
\qquad\text{equivalently}\qquad
2p-2=pf_0+r(p-1).
\]

Since \(f_0\ge0\), \(0\le r\le2\). Reducing modulo \(p\) gives \(r\equiv2\pmod p\), hence \(r=2\) and \(f_0=0\). At each fixed point the different is at least \(2(p-1)\). If \(h=g(C/P)\), Riemann–Hurwitz consequently gives

\[
2p-4=p(2h-2)+d_1+d_2\ge 2p-4+2ph.
\]

Thus \(h=0\), both differents are minimal, and both lower breaks are \(1\). Section 1 applies. This argument does not need the general theorem that ordinary curves have trivial second ramification groups.

For the formulas and conventions used here, see Montanucci–Speziali, §2, equations (2) and (4); the latter counts short orbits, which for a group of prime order are exactly fixed points. [*Large automorphism groups of ordinary curves of even genus in odd characteristic*, preprint pp. 3–4](https://backend.orbit.dtu.dk/ws/portalfiles/portal/216803404/Ordinary_curve_even_genus_Montanucci_Speziali.pdf).

## 3. No hyperelliptic genus-four \(A_5\)-curve in characteristic five

There is no faithful \(A_5\)-action on a hyperelliptic genus-four curve over an algebraically closed field of characteristic \(5\).

Suppose otherwise. The unique hyperelliptic involution is central, and the action on the hyperelliptic quotient has kernel contained in its order-two group. Simplicity of \(A_5\) makes that kernel trivial. Hence \(A_5\) acts faithfully on \(\mathbf P^1\) and preserves the reduced hyperelliptic branch set \(B\), which has size \(10\).

We need only elementary point-stabilizer structure, not a classification of finite subgroups of \(\operatorname{PGL}_2\). If a finite subgroup \(H\) fixes a point of \(\mathbf P^1\), move that point to infinity and write its elements as

\[
u\longmapsto \alpha u+\beta.
\]

The kernel of \(H\to k^\times,\ (\alpha,\beta)\mapsto\alpha\), is a normal translation \(5\)-group.

- If this kernel is trivial, \(H\) is cyclic and prime to \(5\). A subgroup of \(A_5\) of this type has order \(1,2,\) or \(3\).
- If the kernel is nontrivial, it is a Sylow group \(C_5\), because \(25\nmid60\). Its normality gives \(H\subset N_{A_5}(C_5)=D_{10}\), so \(|H|=5\) or \(10\).

Here \(D_{10}\) has order \(10\); the normalizer has this order because \(A_5\) has six Sylow-five subgroups. Therefore every orbit on \(\mathbf P^1\) has size in

\[
\{60,30,20,12,6\}.
\]

A set of size \(10\) cannot be a union of such orbits. This contradicts invariance of \(B\). \(\square\)

Combining with §2 proves the stronger useful conclusion:

\[
\boxed{\text{An ordinary genus-four curve in characteristic five has no faithful }A_5\text{-action.}}
\]

## 4. The proposed two-point \(A_5\) cover does not exist

There is no connected \(A_5\)-Galois cover

\[
W\longrightarrow\mathbf P^1_k,\qquad \operatorname{char}(k)=5,
\]

with precisely two branch points, one having inertia \(C_5\) and different \(8\), and the other having tame inertia \(C_2\).

The hypothetical Riemann–Hurwitz calculation is numerically consistent:

\[
2g(W)-2
=60\left(-2+\frac85+\frac12\right)=6,
\]

so \(g(W)=4\). The wild branch fiber consists of \(60/5=12\) points. Their stabilizers are the six conjugate Sylow-five groups, with equally many points for each stabilizer. Hence any fixed \(P\simeq C_5\) fixes exactly two points, both of lower break \(1\). There are no further fixed points, because all remaining inertia is trivial or of order two.

Section 1 now makes \(W\) hyperelliptic and ordinary. Section 3 contradicts the \(A_5\)-action. This is a geometric nonrealizability result, not merely a failure to find an equation.

The proposed free \(C_3\)-quotients would indeed be étale genus-two quotients if this passport existed: no allowed inertia contains an element of order three. The obstruction occurs before forming them—the Galois source itself does not exist.

## 5. Bring-curve and scope warning

The characteristic-zero Bring curve is not a valid realization by naive reduction. Its familiar projective model

\[
\sum_{i=1}^{5}x_i=\sum_{i=1}^{5}x_i^2=\sum_{i=1}^{5}x_i^3=0
\quad\subset\mathbf P^4
\]

contains \([1:1:1:1:1]\) in characteristic five. At this point all three Jacobian rows are proportional, so the tangent dimension is three, not one. This displayed model is not a smooth genus-four special fiber. The calculation does not assert that every alternative model or potential reduction is singular; any smooth ordinary genus-four reduction carrying a faithful \(A_5\)-action is excluded instead by the theorem above.

The result eliminates this particular wild cored ordinary-genus-two construction and supplies a reusable small-genus automorphism test. It does not prove joint liftability of other cored correspondences, classify their possible global groups, or exclude nonordinary genus-four curves with \(A_5\)-actions.
