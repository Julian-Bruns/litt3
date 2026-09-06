# Degree-one Hamiltonian restricted powers recover Cartier

Date: 2026-09-05. Author: /root/cartier_via_restricted_hamiltonian_formula.
Status: explicit proof; no common-cover nonexistence claim.

Let k be a perfect field of characteristic p > 2, X a smooth projective
geometrically connected curve, and K = k(X). In the canonical rational
Poisson ring K[u,u^{-1}], choose a nonzero rational differential eta,
represented by u, and put D = d/eta. The bracket convention is

\[
 \{a u^m,b u^n\}=(n bD(a)-m aD(b))u^{m+n+1}.
\]

The canonical section-ring applications below use genus at least two,
so its homogeneous localization is this rational ring.

## 1. Frobenius convention

Write X^(1) = X x_{k,F_k} k and F = F_{X/k}: X -> X^(1).
The relative Cartier map is the k-linear map

\[
 C_{\rm rel}:F_*\Omega^1_{X/k}\longrightarrow\Omega^1_{X^{(1)}/k}.
\]

Because k is perfect there is a canonical additive, Frobenius-semilinear
identification j of rational differential spaces, induced by
K -> K^(1) = K tensor_{k,F_k} k, a |-> a tensor 1:

\[
 j(f\,dt)=(f\otimes1)d(t\otimes1),\qquad j(\lambda\omega)=\lambda^p j(\omega).
\]

Define C_abs = j^{-1} C_rel. Thus C_abs(lambda omega) =
lambda^(1/p) C_abs(omega). This is an additive semilinear identification,
not an identification of X with X^(1) as k-curves. Below C means C_abs.

For a separating parameter t, uniquely write
f = sum_{i=0}^{p-1} f_i^p t^i. Then

\[
 C(f\,dt)=f_{p-1}\,dt.
\]

## 2. Restricted derivation formula and its proof

There is a unique a in K with D^p = aD, since D^p is a derivation
and Der_k(K) is one-dimensional over K. Commuting D with D^p shows
D(a) = 0, hence a belongs to K^p. The exact formula is

\[
 \boxed{C(\eta)=a^{1/p}\eta.}                       \tag{1}
\]

Here the root is unique in K. In relative notation, (1) reads
C_rel(eta) = j(a^(1/p)) j(eta), and F^#(j(a^(1/p))) = a.

For completeness, Cartier's derivation identity is

\[
 \langle C\omega,E\rangle^p
 =\langle\omega,E^p\rangle-E^{p-1}\langle\omega,E\rangle. \tag{2}
\]

It appears as equation (6) in Cartier's 1957 note,
[*Une nouvelle operation sur les formes differentielles*](https://www.math.stonybrook.edu/~jiahao/Notes/cartier.pdf)
(linked English transcription). We use only that displayed identity
from this transcription, which contains unrelated apparent typos.

Here is also a direct check. The p-basis expansion writes every rational
form as dh + b^p t^{p-1}dt. Both sides of (2) are additive and scale by
b^p when the form scales by b^p. They vanish on dh. For t^{p-1}dt,
(2) is the identity

\[
 E^{p-1}(t^{p-1}E(t))=t^{p-1}E^p(t)-E(t)^p.
\]

One can prove this polynomial identity by lifting the universal
derivation to Z/p^2 and expanding E^p(t^p). After division by p,
only the orbit with one derivative of order p and the orbit with all
derivatives of order one survive; Wilson's theorem gives the minus
sign. See [Mundinger's one-page proof](https://joshuamundinger.github.io/assets/notes/hochschild-identity.pdf)
for the full universal calculation. This proves (2) in the present
one-variable setting independently of the transcription.

Apply (2) with omega = eta and E = D. Since eta(D) = 1,
its right side is a. Its left side is (C(eta)/eta)^p, proving (1).

## 3. Hamiltonian formula, global regularity, and degree

Put H_eta = {u,-} = -u^2 D, where D fixes u. Consequently

\[
 H_\eta^p=-u^{2p}D^p=a u^{2p-2}H_\eta.              \tag{3}
\]

In intrinsic differential notation the multiplier in (3) is

\[
 q_\eta=a\eta^{2p-2}=\eta^{p-2}(C\eta)^p.           \tag{4}
\]

If eta is holomorphic, so is C eta, and therefore q_eta belongs to
H^0(X,omega_X^(2p-2)). In particular, poles of D create no regularity
problem. If eta has zero order d and C eta has order e at a point,
q_eta has order (p-2)d + pe, which is nonnegative. For nonzero C eta,
the rational function a has order p(e-d); a itself need not be regular.

There is also a holomorphic Hamiltonian representative:

\[
 \boxed{H_\eta^p=H_{P(\eta)},\qquad
 P(\eta)=-\eta^{p-1}(C\eta)^p\in R(X)_{2p-1}.}      \tag{5}
\]

Indeed (C eta)^p is Poisson-central, and
H_{eta^(p-1)} = -eta^(p-2)H_eta. This proves (5), including its sign.
At p = 5 the multiplier is eta^3(C eta)^5 in weight eight, and
P(eta) = -eta^4(C eta)^5 has weight nine. The fifth iterate H_eta^5
raises degree by ten, as does H_{P(eta)}.

We assert (5) for degree-one Hamiltonians; no choice of a restricted
Poisson operation on every element of the ring is needed here.

## 4. Information content and pullback

For nonzero eta, (3) determines its unique multiplier q_eta by evaluating
on any element with nonzero H_eta. Formula (4) then recovers C eta
uniquely by taking the fifth root (or pth root) in the rational
differential line. Conversely Cartier determines (3) and (5). Thus
these degree-one restricted powers contain exactly the Cartier
operator on degree one, once the multiplication and bracket are fixed.
In particular,

\[
 H_\eta^p=0\quad\Longleftrightarrow\quad C\eta=0.
\]

This does not say that the entire canonical Poisson ring is determined
by the Cartier operator or by its rank.

For a finite separable curve map f:Y -> X, the same separating
parameter t remains a p-basis parameter in k(Y). The p-basis formula
therefore proves C_Y f^* = f^* C_X for rational forms. Relatively this is
C_{Y,rel} f^* = f^(1)* C_{X,rel}, with the appropriate Frobenius
pushforwards. Hence

\[
 q_{f^*\eta}=f^*q_\eta,\qquad P(f^*\eta)=f^*P(\eta).
\]

For etale maps these are identities of regular canonical sections,
and the pullback subspace of H^0(omega_Y) is Cartier-stable and carries
the source Cartier operator. For a common etale cover, both source
subspaces must satisfy this condition inside the same H^0(omega_Y).
The restricted-power formulation supplies no extra condition beyond
that Cartier compatibility. It neither proves nor disproves existence
of the common cover, and it makes no assertion that different source
Cartier ranks cannot coexist in a larger target.
