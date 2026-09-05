# The Frobenius-quotient class: all-degree étale injectivity and the universal boundary

**Status:** author proof, 2026-09-05; not independently audited.
This records a standard Cartier obstruction and an elementary all-degree
injectivity consequence. It does not produce a new common-cover obstruction.

Let \(k\) be algebraically closed of characteristic \(p>0\), and let
\(C/k\) be smooth, projective, connected, of genus \(g\ge2\). Write

\[
 C^{(1)}=C\times_{k,F_k}k,\qquad F_C:C\longrightarrow C^{(1)},\qquad
 V_C^{(1)}=H^1(C^{(1)},T_{C^{(1)}}),
\]

\[
 H_C=H^1(C,F_C^*T_{C^{(1)}}),\qquad
 Q_C=H_C/F_C^*V_C^{(1)}.
\]

The map \(F_C^*\) here is **k-linear relative-Frobenius pullback**.
No k-isomorphism \(C\simeq C^{(1)}\) is chosen or assumed.

## 1. Exact identification of the quotient

Put \(E_C=B_C^1\otimes T_{C^{(1)}}\). Then there is a canonical exact
sequence of k-vector spaces

\[
 0\longrightarrow V_C^{(1)}\xrightarrow{F_C^*}H_C
   \xrightarrow{\pi_C}H^1(C^{(1)},E_C)\longrightarrow0.       \tag{1}
\]

In particular

\[
             \boxed{Q_C\simeq H^1(C^{(1)},E_C),}\qquad
             \dim Q_C=2(p-1)(g-1).                         \tag{2}
\]

### Proof

Tensor the first Cartier sequence by \(T_{C^{(1)}}\):

\[
 0\longrightarrow T_{C^{(1)}}
   \longrightarrow F_{C,*}F_C^*T_{C^{(1)}}
   \longrightarrow E_C\longrightarrow0.                   \tag{3}
\]

The middle identification is the projection formula. Tensoring the
second Cartier sequence by the same line bundle gives

\[
 0\longrightarrow E_C
   \longrightarrow F_{C,*}(\omega_C^{\otimes(1-p)})
   \xrightarrow{\operatorname{Car}\otimes1}
      \mathcal O_{C^{(1)}}\longrightarrow0.                 \tag{4}
\]

Here the line-bundle identity
\(F_C^*\omega_{C^{(1)}}\simeq\omega_C^{\otimes p}\) is not the
zero differential of Frobenius.

Since \(\omega_C^{1-p}\) has negative degree,
\(H^0(C^{(1)},E_C)=0\) follows from (4). Cohomology of (3), using
\(H^2(C^{(1)},T)=0\), proves (1). Finally \(E_C\) has rank \(p-1\)
and degree \(-(p-1)(g-1)\), so Riemann--Roch gives (2).

This vanishing needs **no stability theorem**. The stability result
in file 22 gives the alternative argument that \(E_C\) is stable of
negative slope \(-(g-1)\), and remains so after every étale pullback.

## 2. The canonical class is exactly the Cartier extension

Define

\[
 \kappa_C=\partial_{(4)}(1)
       \in H^1(C^{(1)},E_C)\simeq Q_C.                    \tag{5}
\]

It is the extension class of (4), equivalently the class of
\(0\to B_C^1\to F_{C,*}\omega_C\to\omega_{C^{(1)}}\to0\)
in \(\operatorname{Ext}^1(\omega_{C^{(1)}},B_C^1)\).
For every genus-at-least-two curve,

\[
                              \boxed{\kappa_C\ne0.}      \tag{6}
\]

Indeed, the middle term of (4) has no global sections, so its connecting
map from \(H^0(\mathcal O_{C^{(1)}})=k\) is injective.

### Relation to every marked W2 lift, including twists and signs

Fix the Čech convention \((\delta s)_{ij}=s_j-s_i\). For a marked
\(W_2(k)\)-lift \(\widetilde C\), form its twisted target using the
Witt Frobenius \(\sigma:W_2(k)\to W_2(k)\). Choose affine local lifts
\(\phi_i:\widetilde U_i\to\widetilde U_i^{(1)}\) of relative Frobenius.
The convention

\[
                 h_{ij}=(\phi_j^*-\phi_i^*)/p\pmod p
\]

defines the Deligne--Illusie class in \(H_C\). Each divided differential
\(\zeta_i=d\phi_i/p\pmod p\) is an O-linear map
\(\omega_{C^{(1)}}\to F_{C,*}\omega_C\) splitting Cartier locally.
In a parameter \(z\), if \(\phi_i^*(z^{(1)})=z^p+p a_i\), then

\[
 \zeta_i(dz^{(1)})=z^{p-1}dz+da_i,\qquad
 \zeta_j-\zeta_i=d h_{ij}.                               \tag{7}
\]

Thus the image of the DI cocycle under the quotient in (3) is exactly
the connecting cocycle of the local splittings of (4). Consequently

\[
                    \pi_C(\operatorname{DI}(\widetilde C))
                               =\kappa_C.                \tag{8}
\]

Reversing the DI/Čech convention reverses both representatives, not the
substance of the identification or any vanishing assertion.

For precision about deformation parameters, if
\(\Delta\in H^1(C,T_C)\) is an ordered marked-lift difference, its
twisted class is

\[
 \Delta^{(1)}\in H^1(C^{(1)},T_{C^{(1)}})
      \simeq H^1(C,T_C)\otimes_{k,F_k}k.
\]

With the ordered deformation convention of file 37,

\[
 \operatorname{DI}(\widetilde C_1)
       -\operatorname{DI}(\widetilde C_0)=F_C^*(\Delta^{(1)}).
                                                               \tag{9}
\]

The twisting map \(\Delta\mapsto\Delta^{(1)}\) is Frobenius-semilinear;
\(F_C^*\) in (9) is k-linear. Since k is perfect and marked curve lifts
form a nonempty torsor under \(H^1(C,T_C)\), (1) and (9) show that DI
identifies all marked W2 lifts with the entire affine fiber

\[
                       \pi_C^{-1}(\kappa_C)\subset H_C.  \tag{10}
\]

This is a concrete model of the existing deformation torsor, not a
canonical choice of a point in that torsor.

The identity is standard: [Deligne--Illusie, §2.1(b)--(d), pp.251--252](https://math.uchicago.edu/~emerton/prismatic/Deligne-Illusie.pdf)
gives (7). [Achinger--Witaszek--Zdanowicz, Proposition 3.3.1(a)--(c) and Lemma 3.3.3](https://ems.press/content/serial-article-files/32569)
explicitly identifies the unfixed-lift obstruction with the Cartier
extension and records its functoriality, crediting Nori--Srinivas.
No novelty is claimed for this obstruction class.

## 3. Injectivity for every finite étale cover

### Theorem

For any finite étale \(f:D\to C\), the canonical induced map

\[
                        \boxed{f_Q^*:Q_C\hookrightarrow Q_D}
                                                               \tag{11}
\]

is injective. The assertion includes p-divisible degrees and non-Galois
covers. Moreover

\[
                           f_Q^*\kappa_C=\kappa_D.       \tag{12}
\]

### Proof

Write \(f^{(1)}:D^{(1)}\to C^{(1)}\). Frobenius base change and the
étale differential isomorphism give

\[
 (f^{(1)})^*B_C^1\simeq B_D^1,\qquad
 (f^{(1)})^*E_C\simeq E_D,
\]

and identify the pullbacks of (3)--(4) with their D versions. They
therefore identify the Q map with coherent-cohomology pullback for
\(E_C\), and prove (12).

Let \(R=(f^{(1)})_*\mathcal O_{D^{(1)}}/\mathcal O_{C^{(1)}}\).
This is locally free and becomes a trivial bundle after a finite étale
Galois closure. No semisimplicity assertion about the associated
permutation representation is used. On that closure, the pullback of
\(E_C\) is again the corresponding E bundle of a genus-at-least-two
curve, and has no global sections by (4). Thus the pullback of
\(E_C\otimes R\) has no sections, and faithful flatness implies

\[
                         H^0(C^{(1)},E_C\otimes R)=0.
\]

Tensoring the defining sequence of R by \(E_C\), and taking cohomology,
now gives

\[
 H^1(C^{(1)},E_C)\hookrightarrow
 H^1(D^{(1)},(f^{(1)})^*E_C)=H^1(D^{(1)},E_D).
\]

This proves (11), without a trace denominator. It is the vector-bundle
version of the negative-line-bundle argument in file 116.

### Equivalent saturation statement

Let \(f_H^*:H_C\to H_D\) denote pullback, including the tangent
identification. Then

\[
 (f_H^*)^{-1}(F_D^*V_D^{(1)})=F_C^*V_C^{(1)}.          \tag{13}
\]

In words, an H1 class does not become a Frobenius pullback for the first
time after an étale cover. This follows exactly from quotient injectivity,
not merely from the separate injectivity of the two maps in (1).

## 4. What this does and does not add to files 37, 110 and 116

File 37 already proves Frobenius injectivity and the variation formula.
The quotient description packages those facts through the standard
Cartier extension. Statement (11), or (13), is a reusable all-degree
strengthening obtained by the same elementary argument as file 116.

But \(\kappa_C\ne0\) is **universal** for every smooth projective curve
of genus at least two. As a pointed k-vector space without any additional
structure, \((Q_C,\kappa_C)\) records only its dimension and a nonzero
point. In characteristic five the dimension is \(8(g-1)\).

For an actual common étale source \(f:Z\to X\), \(g:Z\to Y\), one has
automatically

\[
                          f_Q^*\kappa_X
                             =\kappa_Z=g_Q^*\kappa_Y.
\]

There is no conflict between the two legs here. More strongly, for any
chosen target liftings, file 110 gives

\[
 g_H^*\operatorname{DI}(\widetilde Y)
      -f_H^*\operatorname{DI}(\widetilde X)
       =F_Z^*(\Delta^{(1)}),
\]

so its image in \(Q_Z\) is zero **even when the simultaneous-lifting
obstruction is nonzero**. Quotienting by the full \(F_Z^*V_Z^{(1)}\)
forgets all ordered source-deformation differences.

To retain the actual two-leg test one must instead keep the two affine
subsets of \(\pi_Z^{-1}(\kappa_Z)\):

\[
 f_H^*\bigl(\pi_X^{-1}(\kappa_X)\bigr),\qquad
 g_H^*\bigl(\pi_Y^{-1}(\kappa_Y)\bigr).
\]

Their intersection is the simultaneous W2-lifting problem of file 110;
passing to the single universal point \(\kappa_Z\) loses precisely
that intersection question. This note supplies no exclusion for the
fixed genus-nine/genus-twenty-five pair.
