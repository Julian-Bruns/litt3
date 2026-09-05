# A nonzero mixed torsion constant for an actual étale product action

Date: 2026-09-05.
Author: /root/gluing_cohomology_rigidity.
Status: proved and author-checked; not independently audited.

## 1. Statement and scope

Let \(k\) be algebraically closed of characteristic different from \(3\),
choose \(\lambda\notin\{0,1\}\), and fix a primitive cube root \(\zeta\).
In particular, take characteristic \(5\) and \(\lambda=2\).

There exist a smooth projective curve \(W\) of genus \(10\), a free action
\[
                    H=H_1\times H_2\simeq C_3\times C_3,
\]
and an **actual finite étale map** \(r:W\to T\) of degree \(3\), where
\(T\) is nonhyperelliptic of genus \(4\), such that:

1. For every \(h_i\in H_i\), the exact homomorphism of Jacobians
   \[
                         r_*(h_{1*}-1)(h_{2*}-1)=0.          \tag{1.1}
   \]
2. Neither factor fixes \(r\); both stabilizers are trivial.
3. For generators, the constant
   \[
   c=\iota_T rh_1h_2-\iota_T rh_1-\iota_T rh_2+\iota_T r      \tag{1.2}
   \]
   has exact order \(3\) in \(J(T)(k)\). It is the difference of the
   two trigonal-pencil classes on the displayed \((3,3)\) model.

Moreover \(V=W/H\) has genus \(2\), and
\[
                         T\longleftarrow W\longrightarrow V \tag{1.3}
\]
is a minimal bi-étale correspondence of degrees \(3\) and \(9\).

Thus coprimality cannot simply be removed from
[the coprime mixed-Jacobian descent theorem](COPRIME_PRODUCT_MIXED_JACOBIAN_VANISHING_FORCES_DESCENT.md),
even for an actual étale map to a nonhyperelliptic target and a free
product action of odd-order groups. There is no contradiction: here the
two factor orders share the prime \(3\).

No ordinarity claim about \(V\), and no claim that
\(\operatorname{Hom}(J(T),J(V))=0\), is made. This is an auxiliary
family, not the fixed pair of the main problem or a verified example
satisfying all of its additional hypotheses.

## 2. A complete intersection with free actions

Define \(W\subset\mathbf P^3_{[U:Z:A:S]}\) by
\[
                  U^3-Z^3=S^3,\qquad U^3-A^3=\lambda S^3.   \tag{2.1}
\]
On \(S\ne0\), put \(u=U/S,\ z=Z/S,\ a=A/S,\ t=u^3\). Then
\[
                      u^3=t,\quad z^3=t-1,\quad a^3=t-\lambda.
                                                               \tag{2.2}
\]
The three Kummer classes are independent: their valuations at
\(0,1,\lambda\), reduced modulo \(3\), form the identity matrix.
The affine field therefore has degree \(27\) over \(k(t)\), with group
\[
 G=(\mathbf Z/3)^3,\qquad
 (x,y,z_0):(u,z,a)\longmapsto
                  (\zeta^xu,\zeta^yz,\zeta^{z_0}a).          \tag{2.3}
\]

The projective complete intersection is smooth. Neither gradient in
(2.1) vanishes at a point of the intersection. Dependence of the two
nonzero gradients would, from their \(Z\) and \(A\) coordinates, force
\(Z=A=0\). The equations would then give
\(U^3=S^3=\lambda S^3\), impossible. Its intersection with \(S=0\)
is nine points, so it has no curve component there. Independence of the
affine Kummer field consequently proves irreducibility of the whole
smooth complete intersection.

The four branch points of \(W\to\mathbf P^1_t\) are
\(0,1,\lambda,\infty\), with inertia lines
\[
                  (1,0,0),\quad(0,1,0),\quad(0,0,1),\quad(1,1,1).
                                                               \tag{2.4}
\]
Every inertia group has order \(3\). At infinity the three radicands
all have valuation \(-1\); over the algebraically closed residue field
their local tame cubic extensions are the same. There is no other
ramification. Hence
\[
 2g(W)-2=27\left(-2+4\left(1-\frac13\right)\right)=18,
 \qquad g(W)=10.                                             \tag{2.5}
\]

Set
\[
\begin{aligned}
 h_1&=\operatorname{diag}(\zeta,\zeta,1,1),\\
 h_2&=\operatorname{diag}(\zeta,1,\zeta,1),\\
 k_0&=\operatorname{diag}(1,\zeta,\zeta,1),
\end{aligned}                                                \tag{2.6}
\]
and \(H_i=\langle h_i\rangle,\ H=\langle h_1,h_2\rangle,\
K=\langle k_0\rangle\). In (2.3),
\[
 H=\{(i+j,i,j)\}=\ker(x-y-z_0),\qquad K=\langle(0,1,1)\rangle.
                                                               \tag{2.7}
\]
The displayed functional is nonzero on every inertia generator (2.4).
Thus the **whole** group \(H\), not just each factor, acts freely.
The line \(K\) also differs from all four inertia lines and acts freely.
Moreover its generator has functional value \(-2=1\) in \(\mathbf F_3\);
therefore \(G=H\times K\).

Consequently the actual quotient maps
\[
                    r:W\to W/K,\qquad s:W\to W/H             \tag{2.8}
\]
are finite étale of degrees \(3\) and \(9\). These freeness checks
include every point at infinity.

## 3. The nonhyperelliptic target and its two genus-two quotients

Put \(T=W/K\). Its invariant functions \(u,v=z/a\) satisfy
\[
                       v^3(u^3-\lambda)=u^3-1,               \tag{3.1}
\]
or equivalently
\[
                       u^3=t,\qquad v^3=(t-1)/(t-\lambda).
                                                               \tag{3.2}
\]
They generate the invariant field: adjoining \(z\) has degree at most
three and recovers \(a=z/v\), whereas \(K\) has order three.

Equation (3.1) is a smooth \((3,3)\) curve in
\(\mathbf P^1_u\times\mathbf P^1_v\). On the affine chart with \(u,v\)
nonzero, simultaneous vanishing of its two partial derivatives would
give \(v^3=1,\ u^3=\lambda\), contrary to \(\lambda\ne1\).
At \(u=0\) or \(v=0\) the remaining derivative is nonzero.
At \(u=\infty\) the equation has \(v^3=1\) and nonzero \(v\)-derivative;
at \(v=\infty\) it has \(u^3=\lambda\) and nonzero \(u\)-derivative.
There is no point with both coordinates infinite.

Adjunction gives
\[
                         \omega_T=\mathcal O_T(1,1),\qquad g(T)=4.
                                                               \tag{3.3}
\]
The four sections of \(\mathcal O(1,1)\) restrict to a canonical basis,
and the canonical map is the restricted Segre embedding. Thus \(T\)
is nonhyperelliptic. Its genus also follows from the étale map \(r\).

Write \(\sigma(u,v)=(\zeta u,v)\) and
\(\tau(u,v)=(u,\zeta v)\). The two factors induce
\[
                      \bar h_1=\sigma\tau,\qquad
                      \bar h_2=\sigma\tau^{-1}.              \tag{3.4}
\]
They generate the full \(C_3^2\)-group of (3.2), whose quotient is
\(\mathbf P^1_t\). Its only inertia lines are \(\langle\sigma\rangle\)
and \(\langle\tau\rangle\), so each cyclic subgroup in (3.4) acts
freely. Therefore
\[
              q_i:T\to T_i=T/\langle\bar h_i\rangle
       \quad\text{is degree-three étale, with }g(T_i)=2.      \tag{3.5}
\]
Both induced actions are faithful, so neither \(H_i\) fixes \(r\).
Explicit quotient models, useful independently, are
\[
 T_1:\ b^3=\frac{t(t-\lambda)}{t-1},\quad b=u/v;\qquad
 T_2:\ d^3=\frac{t(t-1)}{t-\lambda},\quad d=uv.                \tag{3.6}
\]
As usual these equations denote smooth projective normalizations.

## 4. Exact Jacobian vanishing

In \(\operatorname{End}^0(J(T))\), let
\[
                       e_i=\frac13\sum_{j=0}^2\bar h_{i*}^{\,j}.
\]
Their images are \(q_i^*J(T_i)\), each of dimension two. Since the
whole group quotient is \(\mathbf P^1\), its norm is zero on \(J(T)\):
\[
                 e_1e_2=\frac19\sum_{h\in C_3^2}h_*=0.       \tag{4.1}
\]
Thus these two images intersect only in a finite subgroup and together
have dimension four. Addition gives an isogeny
\[
                          J(T_1)\times J(T_2)\longrightarrow J(T).
                                                               \tag{4.2}
\]
Every element of the first cyclic group acts identically on the first
summand; the second group acts identically on the second. Since the
actions commute, for all elements of the respective groups
\[
                         (\bar h_{1*}-1)(\bar h_{2*}-1)=0.    \tag{4.3}
\]
This identity holds exactly in \(\operatorname{End}(J(T))\): the
endomorphism is zero after precomposition with the surjective isogeny
(4.2), hence is zero. Equivariance of \(r\) yields
\[
 r_*(h_{1*}-1)(h_{2*}-1)
       =(\bar h_{1*}-1)(\bar h_{2*}-1)r_*=0.                 \tag{4.4}
\]
No inference from zero differential to zero homomorphism in positive
characteristic is used.

## 5. The constant is a nonzero difference of trigonal pencils

Choose \(v_0^3=1/\lambda\) and set
\[
                         P_j=(0,\zeta^jv_0),\qquad j\in\mathbf Z/3.
\]
Let \(H_u,H_v\) denote the degree-three fiber classes of the maps
\(u,v:T\to\mathbf P^1\). Their fibers show
\[
                  H_u=[P_0+P_1+P_2],\qquad H_v=[3P_j]
                         \quad\text{for every }j.           \tag{5.1}
\]
Indeed the \(u\)-fiber at zero is reduced, and (3.1) gives order three
for \(v-\zeta^jv_0\) at \(P_j\).

By (4.4) and the universal property of the Jacobian, (1.2) is constant.
At any point over \(P_0\), its value is
\[
                  c=[2P_0-P_1-P_2]=H_v-H_u.                 \tag{5.2}
\]
Equation (5.1) implies \(3c=0\). If \(c=0\), the distinct effective
degree-two divisors \(2P_0\) and \(P_1+P_2\) would be linearly
equivalent. That would give a degree-two pencil on \(T\), contrary to
nonhyperellipticity. Thus \(c\) has **exact order three**.

The telescoping identities for constant mixed differences give
\[
                             c(h_1^i,h_2^j)=ijc.             \tag{5.3}
\]
This is a nonzero pairing on \(H_1\times H_2\) with trivial radicals.
Both residual quotient indices are exactly three, and \(r\) descends
through neither axis.

## 6. The retained genus-two leg and minimality

The \(H\)-invariant functions \(t=u^3,\ w=uz^2/a\) satisfy
\[
                            w^3=\frac{t(t-1)^2}{t-\lambda}. \tag{6.1}
\]
Let \(V\) be the smooth projective normalization. Its radicand has
valuation vector \((1,1,2,2)\) modulo three at
\((0,\infty,1,\lambda)\). This is a connected cyclic degree-three
cover with four branch points of inertia three, and Riemann–Hurwitz
gives \(g(V)=2\). Its field is exactly \(k(W)^H\) by the degree count,
so \(s:W\to V\) is the already verified degree-nine étale quotient.

Finally the two target function fields generate \(k(W)\): from
\(u,v\) on \(T\) and \(w\) on \(V\), one recovers
\[
                               z=\frac{w}{uv},\qquad a=\frac zv.
                                                               \tag{6.2}
\]
These are rational-function identities, so vanishing denominators at
some points cause no function-field exception. The normalization of
the joint image in \(T\times V\) is therefore \(W\) itself. This proves
minimality without replacing either target or discarding either map.

The resulting data are
\[
              (g(T),g(V),g(W))=(4,2,10),\qquad
                         (\deg r,\deg s)=(3,9).
\]
Both degrees are prime to five. The additional ordinarity and
Hom-vanishing conditions mentioned in §1 remain unchecked and are not
part of this counterexample.
