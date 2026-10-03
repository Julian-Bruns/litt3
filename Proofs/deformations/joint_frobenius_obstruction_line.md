# Proof: the ample criterion computes the entire killed quotient

[Statement](../../Theorems/deformations/joint_frobenius_obstruction_line.md).
Version2,3 October2026. The older
[author check](../../Research/audits/JOINT_FROBENIUS_OBSTRUCTION_LINE_CHECK_2026_09_22.md)
is retained. The later universal ample criterion replaces the
common-simple/genus-two step. Use the actual maps on every twist.
The quotient spaces are ordinary coherent cohomology quotients.

## 1. The individual Frobenius rows

Fix a target twist, suppress its index, and write $F:C\to C_1$.
Tensor the unit sequence by $\omega_{C_1}^{-m}$ and use projection
formula. This gives
\[
0\longrightarrow\omega_{C_1}^{-m}
\longrightarrow F_*\omega_C^{-pm}
\longrightarrow B_C\otimes\omega_{C_1}^{-m}
\longrightarrow0.
\tag{1}
\]
The last term has no global sections. Indeed the canonical
filtration of $F^*B_C$ has grades $\omega_C^j$, $1\le j\le p-1$;
after tensoring its pullback by $\omega_C^{-pm}$ all grades have
negative degree. Faithfully flat Frobenius injects global sections.
The other two terms of (1) also have no global sections. Curves
have no coherent $H^2$, so (1) gives a short exact row
\[
0\longrightarrow H^1(\omega^{-m})
\xrightarrow{F^*}H^1(\omega^{-pm})
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
\xrightarrow{\mathfrak F_{m,i}}Q_{pm}(i)
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

The first Frobenius pullback of $E_m$ has canonical line grades
\[
\omega_C^{j+p(m-1)},\qquad 1\le j\le p-1.
\]
They all have positive degree. Thus $E_m$ is ample, by descent
through finite Frobenius. Its rank is $p-1$, so the later
[universal ample criterion](../cartier_and_spin/common_cartier_extension_trace.md)
has height $\lfloor\log_p(p)\rfloor=1$ and gives
\[
K_m\simeq\operatorname{Hom}_{\rm common}(E_m,B).
\]
For $m=1$ this is $k$, by that theorem's canonical
$\operatorname{End}_{\rm common}(B)=k$ consequence.

For $m\ge2$, even an ENDPOINT homomorphism $E_m\to B$ is zero.
After Frobenius pullback, all source slopes are at least
$(p+1)\deg\omega_C$, whereas all target slopes are at most
$(p-1)\deg\omega_C$. The canonical line filtrations give these
bounds, hence prohibit a nonzero homomorphism. Faithfully flat
Frobenius reflects its vanishing. No common-simplicity assumption
or special endpoint genus is needed.

For an $r$-fold pullback starting at weight1, all arrows after
the first have weights $p,p^2,\ldots,p^{r-1}$ and are injective.
Starting at $m\ge2$, every arrow is injective. This proves the
all-height assertion with its original source twist. Only
$B_1^\vee=B_1\omega^{-1}$ was used; no higher-height common
self-duality is assumed.

## 3. The canonical snake boundary

Finite Frobenius duality identifies the dual of
$0\to\mathcal O\to F_*\mathcal O\to B\to0$ with
\[
0\longrightarrow B^\vee
\longrightarrow F_*\omega_C\otimes\omega_{C_1}^{-1}
\xrightarrow{\mathrm{Cartier}}\mathcal O\longrightarrow0.
\tag{5}
\]
Its class $\gamma_C\in H^1(B^\vee)$ is nonzero, since the
middle term has $H^0=H^0(\omega_C^{1-p})=0$. These classes
commute with actual etale pullback and generate the common line.

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

The actual curve-lift/FL torsor dictionary and its etale
functoriality were established in
[two_leg_negative_extensions, Section2](two_leg_negative_extensions.md#2-an-arbitrary-simultaneous-w2-lift-supplies-such-an-extension).
Its normalized class $a_C\in H^1(C,F^*T_{C_1})$ maps to
$\gamma_C$ in (2): locally $d\widetilde F/p$ splits (5),
and the differential of the divided Frobenius discrepancy is
the difference of those splittings. The same construction shows
that translating a marked $W_2$ lift of $C_1$ by $v$ translates
$a_C$ by $F^*v$, with the fixed simultaneous sign.

Choose actual endpoint lifts on twist $i+1$ and their uniquely
induced etale source lifts. Their difference $o$ satisfies
$F^*o=f^*a_X-g^*a_Y$ by that functoriality. Thus $[o]=[\delta]$
in (6), the nonzero generator of $L(i+1)$. The coefficient
convention is relative Witt Frobenius, as in the cited dictionary.

Only actual normalized curve-lifting classes were chosen here.
An arbitrary coherent preimage of $\gamma_C$ need not be such
a class; Section3 already makes the boundary independent of
that larger choice space.

## 5. Dimension and scope

Riemann--Roch gives $h^1(C,\omega^{-m})=(2m+1)(g(C)-1)$.
The two endpoint images are disjoint, so
\[
\dim Q_m=(2m+1)\bigl(g(Z)-g(X)-g(Y)+1\bigr)=(2m+1)\beta.
\]
Subtracting the domain rank of $F^{[r]*}$ from its target dimension,
with the kernel just calculated, gives the stated cokernel formula.
The nonzero line in $Q_1$ forces the integer $\beta\ge1$.
For genera nine and two, etale Hurwitz gives $\beta=8\deg f-9$.

The result locates the actual obstruction for an existing span.
It does not exclude a span confined to characteristic $p$.
