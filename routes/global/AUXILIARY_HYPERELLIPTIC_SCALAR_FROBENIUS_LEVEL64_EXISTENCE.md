# Auxiliary hyperelliptic curves with scalar Frobenius on level 64

**Status:** author proof, 2026-09-05, not independently audited.
Authors: gluing_cohomology_rigidity, in collaboration with root.
This is an existence statement for a freely chosen auxiliary curve.
It does not replace the fixed curve of file 76; its obstruction is recorded
in [the fixed-Y theorem's scope discussion](FIXED_Y_TWO_PRIMARY_W6_HAS_ONLY_TWO_TORSION.md#3-what-this-restores-and-what-it-does-not-prove).

## Statement

For every \(g\ge2\), there are ordinary hyperelliptic curves \(C\) of genus
\(g\) over \(\mathbf F_{5^N}\), for arbitrarily large
\(N\equiv6\pmod {96}\), for which

\[
                 \operatorname{Frob}_{5^N}=3I
                 \quad\text{on }J(C)[64].
\]

The curves may be chosen with a rational Weierstrass point.
No assertion of absolute simplicity, a prescribed Weil polynomial, or
full Weyl-group Galois action is included in this note.

## 1. The correct geometric group is principal level two

Let \(U\) be the ordered configuration space of \(2g+1\) distinct points
\(\alpha_i\) of the affine line, with universal curve

\[
                 y^2=\prod_{i=1}^{2g+1}(x-\alpha_i).
\]

The labels, including the branch point at infinity, trivialize \(J[2]\).
Choose one symplectic basis of this constant mod-two local system.
Over the complex numbers the monodromy on \(J[64]\) is

\[
 K=\ker\bigl(\operatorname{Sp}_{2g}(\mathbf Z/64)
                     \longrightarrow\operatorname{Sp}_{2g}(\mathbf F_2)\bigr).
                                                        \tag{1}
\]

The primary source is Yelton, *Images of 2-adic representations associated
to hyperelliptic Jacobians*,
[arXiv:1410.2668](https://arxiv.org/pdf/1410.2668):
Theorem 2.1 is the integral pure-braid monodromy theorem of A'Campo;
Theorem 1.1 and Corollary 1.2(c), with the comparison in Section 2,
give precisely (1) on the division fields. Thus no full symplectic
mod-two monodromy is asserted.

This image remains (1) in characteristic five. Here are the relevant
specialization hypotheses. The group \(K\) is a 2-group, and

\[
 U\simeq\mathbf A^1\times\mathbf G_m\times M_{0,2g+2}.
\]

Consequently \(U\) has the smooth proper compactification
\(\mathbf P^1\times\mathbf P^1\times\overline M_{0,2g+2}\), with
relative simple-normal-crossings boundary, over a mixed-characteristic
strictly henselian trait of residue characteristic five. Prime-to-five
specialization for such pairs identifies their pro-prime-to-five
fundamental groups and their finite prime-to-five local systems.
Apply it to the universal Jacobian's level-64 local system, which
already exists over the trait. This preserves its image \(K\).
The relevant primary statements are
[SGA 1](https://arxiv.org/pdf/math/0206203),
Exposé XIII, Corollary 2.9 and the specialization construction of 2.10
(reprint PDF pages 303--305).

The \(\mathbf G_m\) factor must not be silently discarded.
Writing \(\alpha_i=A+B t_i\), with \(t_1=0,t_2=1\), the normalized
equation retains the quadratic-twist factor \(B\), since \(2g+1\)
is odd. Suppressing this parameter can change the level-two subgroup,
in particular its central sign.

The ordinary locus \(U^{\rm ord}\) is a nonempty open subset.
For example, nonemptiness for every genus follows from
Glass--Pries, *Hyperelliptic curves with prescribed p-torsion*,
[Theorem 2.3](https://arxiv.org/pdf/math/0401008).
Restricting the connected finite étale \(K\)-cover to this open
does not destroy geometric connectedness.

## 2. A single finite-field twist suffices

Fix a primitive 64th root \(\zeta\). Over \(\overline{\mathbf F}_5\),
let \(V_\zeta\) be the cover of \(U^{\rm ord}\) of symplectic
level-64 bases with the fixed mod-two reduction and pairing \(\zeta\).
By (1), \(V_\zeta\) is geometrically connected and hence geometrically
irreducible. It is finite étale over \(U^{\rm ord}\).

Since \(5^6\equiv9\pmod {64}\), the semilinear operator

\[
                    \sigma=3^{-1}\operatorname{Frob}_{5}^{\,6}
                                                        \tag{2}
\]

preserves \(V_\zeta\): the two pairing multipliers cancel, and
\(3^{-1}\equiv1\pmod2\). Because \(3^{16}=1\pmod {64}\),
\(\sigma^{16}=\operatorname{Frob}_5^{96}\).
Thus (2) is an effective finite descent datum, giving a
geometrically irreducible twist \(T/\mathbf F_{5^6}\), still finite
étale over \(U^{\rm ord}\). Explicitly one can carry out the descent
over \(\mathbf F_{5^{96}}/\mathbf F_{5^6}\).

A point of \(T(\mathbf F_{5^{6m}})\) is represented by a curve with
a level basis on which

\[
             \operatorname{Frob}_{5^{6m}}=3^m I.
\]

Lang--Weil gives such points for all sufficiently large \(m\).
Taking \(m\equiv1\pmod {16}\) proves the statement. All the resulting
curves are ordinary because the construction took place over
\(U^{\rm ord}\).

For the precise finite-field twisting method, see Meagher,
*A simple proof of Chebotarev's density theorem over finite fields*,
[Theorem 1.1 and its proof, pages 196--198](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/72DECC8EB5E120B1218B4A3AC4129C62/S0004972718000448a.pdf/a-simple-proof-of-chebotarevs-density-theorem-over-finite-fields.pdf).
Here the explicit twist avoids any assumption that an arithmetic
cover is geometrically connected before its pairing component is fixed.

## 3. The bounded-torsion consequence and its scope

For \(g=25\), Zarhin's divisor argument implies

\[
              W_{12}(C)\cap J(C)[64]\subseteq J(C)[2],
\]

and in particular the same holds for \(W_6(C)\).
Indeed the Frobenius relation is \(\sigma(a)=3a\), and the
multiplicity proof of Theorem 2.12 applies to this individual point.
See Zarhin, *Division by 2 on odd-degree hyperelliptic curves and
their Jacobians*, [MPIM 18-31, printed pages 7--9](https://archive.mpim-bonn.mpg.de/3152/1/preprint_2018_31.pdf),
Theorems 2.12 and 2.14(i).

This is a finite-level condition only. It does not assert Zarhin's
property (M3) on all 2-primary torsion, and it does not establish the
same condition on the fixed genus-25 Jacobian. Combining this
auxiliary existence theorem with additional simplicity or
large-monodromy requirements needs its own simultaneous argument.
