# Equimultiple eigenform tangents and a Cartier character kernel

Date: 2026-09-05. Author: `/root/cartier_eigenform_tangent_character_test`.
Status: direct proof of a tangent-space identity. No identification with
ordinary indigenous bundles is asserted.

Let k be algebraically closed of characteristic 5, let C/k be a smooth
projective connected curve of genus g>=2, and let d=2 or 4. Set
r=5-4/d and e=d/2. Suppose

\[
0\ne s\in V:=H^0(C,\omega_C^d),\qquad
C_{d-1}(s^r)=s,\qquad \operatorname{div}(s)=eD
\]

with D reduced. Let E_d(C) denote the finite eigenform scheme defined by
the equations x_i^5-P_i(x)=0 in the
[finite-pool note](FINITE_GENERALIZED_CARTIER_EIGENFORM_POOLS_AND_ETALE_COMPATIBILITY.md).
Let S_e be the locally closed stratum of nonzero sections whose divisor
is e times a reduced divisor, with its natural divisor-incidence scheme
structure. Let pi:P->C be a connected component of the normalized
canonical d-th-root cover and let eta be its tautological differential,
so eta^d=pi^*s. Its cyclic deck group G has order m dividing d; write chi
for its faithful character on eta. In particular, we do not require
that m=d.

**Claim.** There is a k-linear isomorphism

\[
\boxed{
T_s(E_d(C)\cap S_e)
\xrightarrow{\ \sim\ }
\ker\bigl(C_P:H^0(P,\omega_P)_\chi
                   \longrightarrow H^0(P,\omega_P)_\chi\bigr),
\qquad t\longmapsto\frac{\pi^*t}{\eta^{d-1}}.
}
\]

The Cartier arrow is inverse-Frobenius-semilinear, and its kernel is a
k-vector space. The displayed isomorphism itself is k-linear.

## 1. The finite-scheme tangent equation

Choose a basis of V. The map

\[
u\longmapsto \bigl(\operatorname{coord}_i C_{d-1}(u)\bigr)^5
\]

is k-linear from H^0(omega_C^{5(d-1)+1}) to k, since taking fifth
powers cancels Cartier semilinearity. Applying this linear map to the
derivative of s^r gives

\[
dP_i|_s(t)=r\bigl(\operatorname{coord}_i
                  C_{d-1}(s^{r-1}t)\bigr)^5.
\]

Here r belongs to the prime field and is nonzero. The derivatives of
x_i^5 vanish. Consequently

\[
T_sE_d(C)=\{t\in V:C_{d-1}(s^{r-1}t)=0\}.
\tag{1}
\]

This argument differentiates polynomial equations; it does not attempt
to extend inverse Frobenius to the nonperfect dual-number ring.

## 2. The divisor-stratum tangent

Since e is invertible in k, deforming the local factor z^e at a point
of D through an e-fold moving zero gives precisely perturbations
divisible by z^{e-1}. Globally this yields

\[
T_sS_e=H^0(C,\omega_C^d(-(e-1)D)).                 \tag{2}
\]

For completeness, S_e is smooth in the two cases at hand. For d=2,
e=1 it is the open simple-zero locus in H^0(omega_C^2). For d=4,e=2,
put M=O_C(D) and L=M tensor omega_C^{-2}. The section s identifies
M^2 with omega_C^4, hence L^2=O_C. Locally the stratum is parametrized
by q^2, where q is a section of omega_C^2 tensor L with reduced divisor.
The possible L form the finite etale scheme Pic(C)[2]; fixing L and
an identification L^2=O_C, the only ambiguity is q versus -q.
The quotient of this open section space by the free sign action is
smooth. Its tangent map v->2qv has image exactly
H^0(omega_C^4(-D)). Both S_1 and S_2 therefore have dimension 3g-3.

Equivalently, this scheme description follows by taking the fiber over
omega_C^4 of the map D'->O_C(2D') on the reduced-divisor open subset of
Sym^{4g-4}(C), and adjoining the scalar trivialization. The Abel map is
smooth in this degree and multiplication by 2 on Pic is etale.

## 3. Regularity and descent on the root cover

Above each point of D the root cover has ramification index
d/gcd(d,e)=2, including on a connected component. Tame differential
pullback gives

\[
d\operatorname{ord}_Q(\eta)=2e+d(2-1)=2d,
\qquad \operatorname{ord}_Q(\eta)=2.
\]

Away from D the cover is etale and eta has no zero. If t has order h
at a point of D, then

\[
\operatorname{ord}_Q\left(\frac{\pi^*t}{\eta^{d-1}}\right)
=2h+d-2(d-1)=2(h-e+1).
\]

Thus alpha=pi^*t/eta^{d-1} is regular exactly when t satisfies (2).
Its deck character is chi^{-(d-1)}=chi because chi^d=1.

Conversely, for a regular chi-eigen differential alpha on P,
eta^{d-1}alpha is invariant and therefore descends as a rational
d-differential t on C. The same local order computation forces
ord_D(t)>=e-1 and regularity everywhere. This proves a k-linear
isomorphism

\[
H^0(C,\omega_C^d(-(e-1)D))\simeq H^0(P,\omega_P)_\chi.
\tag{3}
\]

Invariance here is descent of rational differentials through the
separable function-field extension; regular descent is then checked by
the displayed valuations, rather than assumed for a ramified map.

## 4. Intertwining Cartier

Choose a separating parameter with theta=dz, and write
s=a theta^d, t=c theta^d, eta=b theta, b^d=a. Then
alpha=(c/b^{d-1})theta. Since d(r-1)=(5-1)(d-1), Cartier's identity
C(f^5 beta)=f C(beta) gives

\[
\pi^*C_{d-1}(s^{r-1}t)
=\theta^{d-1}C_P(a^{r-1}c\theta)
=\eta^{d-1}C_P(\alpha).                         \tag{4}
\]

Cartier commutes with separable pullback on rational differentials.
Since pullback is injective, equations (1)--(4) prove the claim.
Moreover chi takes values in mu_d subset F_5^*, so Cartier preserves
the chi-eigenspace, rather than changing its character.

## Exact consequences and boundaries

* The finite scheme E_d(C) intersected with S_e is reduced at s if and
  only if Cartier has zero kernel on the chi-eigenspace. This follows
  from the tangent criterion for a local Artin k-algebra.
* For d=2 the stratum is open, so this is also equivalent to E_2(C)
  itself being reduced at s. For d=4 it only tests the equimultiple
  intersection: arbitrary eigenform tangents can leave the double-zero
  stratum. One must not identify the two tangent spaces.
* The eigenspace in (3) has dimension 3g-3. In particular, the condition
  concerns one specified Cartier character block, not the ordinary
  Cartier operator on C and not necessarily all of H^0(P,omega_P).
* Connected components of a disconnected full root cover are allowed.
  Replacing G by mu_d while retaining only one component would be
  incorrect; the proof uses its actual deck group G.
* Reducedness of D imposes the zero multiplicities and regularity in
  (3). It does not prove the Cartier kernel vanishes. No implication
  to an ordinary indigenous bundle is supplied without an additional
  precise deformation-theoretic comparison.
