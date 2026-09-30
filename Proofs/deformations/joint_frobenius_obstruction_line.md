# Proof: the unique Frobenius-killed joint obstruction line

[Statement](../../Theorems/deformations/joint_frobenius_obstruction_line.md).
Use the actual maps on every twist. All quotient spaces below are
ordinary coherent cohomology quotients; no unproved identification
with higher Ext in the common category is required.

## 1. The individual Frobenius rows

Fix a target twist, suppress its index, and write $F:C\to C_1$.
Tensor the unit sequence by $\omega_{C_1}^{-m}$ and use projection
formula. This gives
\[
0\longrightarrow\omega_{C_1}^{-m}
\longrightarrow F_*\omega_C^{-5m}
\longrightarrow B_C\otimes\omega_{C_1}^{-m}
\longrightarrow0.
\tag{1}
\]
The last term has no global sections. Indeed the canonical
filtration of $F^*B_C$ has grades $\omega_C^j$, $1\le j\le4$;
after tensoring its pullback by $\omega_C^{-5m}$ all grades have
negative degree. Faithfully flat Frobenius injects global sections.
The other two terms of (1) also have no global sections. Curves
have no coherent $H^2$, so (1) gives a short exact row
\[
0\longrightarrow H^1(\omega^{-m})
\xrightarrow{F^*}H^1(\omega^{-5m})
\longrightarrow H^1(B\omega^{-m})\longrightarrow0.
\tag{2}
\]
This argument applies on $X,Y,Z$ and needs no ordinariness.

Take the direct sum of the endpoint rows and map it to the source
row using $f^*-g^*$. Etale base change makes the diagram commute.
The first and second vertical maps are injective: individual
negative-degree cohomology pullback is injective, and the two
images have zero intersection by
[two_leg_negative_extensions](two_leg_negative_extensions.md).
The snake lemma therefore gives
\[
0\longrightarrow K_m\longrightarrow Q_m(i+1)
\xrightarrow{\mathfrak F_{m,i}}Q_{5m}(i)
\longrightarrow\operatorname{coker}(v_m)\longrightarrow0,
\tag{3}
\]
where
\[
v_m:H^1(X_{i+1},B_X\omega_X^{-m})\oplus
H^1(Y_{i+1},B_Y\omega_Y^{-m})
\longrightarrow H^1(Z_{i+1},B_Z\omega_Z^{-m}),
\qquad K_m=\ker v_m.
\]

## 2. Computing the kernel in the actual common category

The Cartier pairing identifies $B^\vee=B\omega^{-1}$, hence
\[
E_m=(B\omega^{-m})^\vee=B\omega^{m-1}.
\]
The $H^0$ vanishings in Section1 and extension gluing identify
\[
K_m=\operatorname{Ext}^1_{\rm common}(E_m,\mathcal O).
\tag{4}
\]
There is no residual freedom to change the comparison on $Z$:
that freedom would be $H^0(Z,E_m^\vee)$, already zero.

The common bundle $B$ is simple under the hypotheses, and line
twist preserves common simplicity. It is ample because its first
Frobenius pullback is an extension of positive canonical lines;
ampleness descends through the finite surjective Frobenius map.
Thus every $E_m$ is ample. Apply the common-simple ample clause of
[common_cartier_extension_trace](../cartier_and_spin/common_cartier_extension_trace.md):
the group in (4) is a line precisely for $E_m\simeq B$, and is
zero otherwise. On the genus-two endpoint,
\[
\deg E_m=4+8(m-1).
\]
Thus $E_m\simeq B$ exactly when $m=1$. Its extension line is the
canonical one. This proves the first two assertions.

For an $r$-fold pullback, the first arrow has weight1 and all
subsequent arrows have weights $5,25,\ldots,5^{r-1}$.
Every subsequent arrow is injective by the result just proved.
The kernel is therefore exactly that of the first arrow, with
its original source twist. This proves the all-height assertion.

## 3. The canonical snake boundary

Finite Frobenius duality identifies the dual of
$0\to\mathcal O\to F_*\mathcal O\to B\to0$ with
\[
0\longrightarrow B^\vee
\longrightarrow F_*\omega_C\otimes\omega_{C_1}^{-1}
\xrightarrow{\mathrm{Cartier}}\mathcal O\longrightarrow0.
\tag{5}
\]
Its class $\gamma_C\in H^1(B^\vee)$ generates the same nonzero
extension line as the canonical unit class, with the sign fixed
by dualization. The classes commute with actual etale pullback.

Choose endpoint lifts $a_X,a_Y$ of $\gamma_X,\gamma_Y$ under
the surjections (2), with $m=1$. Their difference on $Z$ has
zero image in $H^1(B_Z^\vee)$, so there is a UNIQUE
$\delta\in H^1(Z_{i+1},\omega^{-1})$ with
\[
F^*\delta=f^*a_X-g^*a_Y.
\tag{6}
\]
Changing either lift $a_C$ adds an element of
$F^*H^1(C_{i+1},\omega^{-1})$. Hence $[\delta]\in Q_1(i+1)$
is independent of these choices. It is the snake boundary of
$(\gamma_X,\gamma_Y)$, up to the simultaneous Cech sign convention.
The first injection of (3) proves that this class is NONZERO.
No covering degree has been inverted.

## 4. Identification with the first Witt obstruction

Use the marked curve-lift/Frobenius-extension correspondence
already established in
[two_leg_negative_extensions, Section2](two_leg_negative_extensions.md#2-an-arbitrary-simultaneous-w2-lift-supplies-such-an-extension).
For clarity, its compatibility with (5) can be checked locally.
A lift $\widetilde F$ of relative Frobenius gives
$d\widetilde F/5$, a splitting of the Cartier map in (5).
For two local choices, their difference divided by5 is a section
of $F_*F^*T_{C_1}$. Applying $d$ gives the difference of those
splittings. Consequently the underlying Frobenius-lifting class
in $H^1(C,F^*T_{C_1})$ maps to $\gamma_C$ in (2).

Marked $W_2$ lifts of $C_1$ form a torsor under $H^1(C_1,T)$.
Translation by a class $v$ translates their underlying
Frobenius-lifting classes by $F^*v$, with the chosen common sign.
In local coordinates, changing a transition by $1+5D$ contributes
$(D(u))^5$ to the divided Frobenius discrepancy. The other
potential term contains $D(u^5)=0$ in characteristic five.
This is precisely the relative Frobenius pullback, including its
coefficient twist. The same calculation holds on every actual
etale pullback by the Cartesian relative Frobenius square.

Choose arbitrary endpoint $W_2$ lifts on twist $i+1$. Each induces
its unique lifted finite etale cover of $Z_{i+1}$. Their difference
is a class in $H^1(Z_{i+1},T)$; its image in $Q_1(i+1)$ is
the simultaneous lifting obstruction. Their Frobenius-lifting
classes are valid choices of $a_X,a_Y$ in Section3. Functoriality
and the preceding translation calculation identify their difference
with (6). Therefore the actual Witt obstruction spans $L(i+1)$.
Its sign depends only on choosing endpoint-one minus endpoint-two
or the reverse in both Cech constructions.

This does not assert that every preimage of $\gamma_C$ under
(2) is a curve-lifting class. Curve-lifting classes retain their
canonical connection and normalization. Choosing those actual
classes is sufficient, and Section3 proves independence from the
larger space of possible preimages.

## 5. Dimension and scope

Riemann--Roch gives $h^1(C,\omega^{-m})=(2m+1)(g(C)-1)$.
For the fixed genera, $g(Z)-1=8n$, while the endpoint contributions
are8 and1. Since their images are disjoint, subtraction gives
$\dim Q_m=(2m+1)(8n-9)$.

The theorem computes a nonzero obstruction, rather than a mechanism
making it vanish. A hypothetical no-clump common cover could have
exactly this nonzero line; nothing here excludes that possibility.
The new content beyond the established no-$W_2$ theorem is the
kernel calculation on the entire quotient and its persistence
without additional kernel at all later Frobenius weights.
