# Proof: reconstructing the actual map from its Prym lines

The formulas are those of
[Ducrohet, Proposition6.6](https://aif.centre-mersenne.org/item/10.5802/aif.2473.pdf).
The point here is to replace its general-curve qualification by
ordinariness of C alone. We give the
reconstruction argument, including the scalar normalization that
projective restrictions alone would otherwise leave unresolved.

## 1. Geometric inputs on the actual curve

We use the following standard genus-two facts, as stated and proved
in Ducrohet, Sections2--3 and5--6.

* The theta morphism identifies \(SU_C(2,\mathcal O)\) with
  \(\mathbf P^3\). In a theta basis its Kummer boundary has the
  displayed Hudson equation.
* For an ordinary curve, the actual relative Frobenius map has a
  primitive homogeneous presentation by four quintics. Its base locus
  is finite; see Lemma3.2(1). Its target and source theta bases are
  related by coefficient Frobenius, as in Remark3.5.
* Every nonzero two-torsion label gives two projective lines, the
  eigenspaces of its order-two theta lift. These are the quotients
  by inversion of translates of the corresponding elliptic Prym.
  The actual Frobenius map is defined on the whole of each line.
* In coordinates \((s:t)\) in which the four branch points satisfy
  \(s^4+\omega s^2t^2+t^4=0\), its restriction is the elliptic
  Verschiebung
  \[
  Q_\omega(s,t)=
  \bigl(s^5+\omega(\omega^2+2)s^3t^2+(\omega^2+2)st^4,
        Q_{\omega,0}(t,s)\bigr).
  \tag{1}
  \]
  This is Lemma6.3, obtained by conjugating the elliptic division
  formula of Lemma6.1. Its source branch polynomial has coefficients
  raised to five. These are coordinates on a Frobenius-twisted line,
  not a claim that its branch parameter is unchanged.

In the paper's proof, generality supplies ordinariness of the curve
and its Pryms. The second assumption can be removed in genus two.
For any elliptic curve E in odd characteristic, ordinary or
supersingular, let its principal divisor be its identity point O.
Then \(V_E^*\mathcal O_E(O)\simeq\mathcal O_{E^{(1)}}(pO)\).
Indeed its kernel divisor has degree p and sum zero in the elliptic
group: in the separable case the nonidentity points pair under
inversion; in the inseparable case it is pO. Thus the compatible
Prym line construction does not require an ordinary elliptic curve.
Formula (1) follows from division polynomials for every smooth
elliptic parameter, not just an ordinary one. At the supersingular
parameters \(\omega^2+2=0\), it becomes \((s^5,t^5)\), still
a basepoint-free degree-five morphism.

The double-cover base-change identity itself holds for every curve.
Explicitly, for its double cover \(\pi\), a degree-zero Prym
line L and a fourth-order line z with \(z^2=\tau\),
\[
F_C^*((\pi^{(1)})_*L\otimes z^{(1)})
 \simeq\pi_*F^*L\otimes z,
\tag{2}
\]
since five is one modulo four. Such induced bundles are semistable
and stay so after pullback. Thus none of the thirty lines contains
a true base point. The ambient primitive-quintic input uses the
ordinary genus-two curve; the elliptic restrictions just discussed
need no further ordinariness or unspecified general-curve hypothesis.

The equality of the true domain with Frobenius semistability is also
[Osserman, TheoremA.6](https://arxiv.org/pdf/math/0410613).

## 2. The line configuration and polynomial uniqueness

Index the four coordinates by \(H=(\mathbf Z/2)^2\). For
\((\alpha,\beta)\ne(0,0)\), let
\[
(T_{\alpha,\beta}x)_i=
 \mu(-1)^{\langle i,\beta\rangle}x_{i+\alpha},
\qquad
\mu=\begin{cases}1,&\langle\alpha,\beta\rangle=0,\\
                  2,&\langle\alpha,\beta\rangle=1.
     \end{cases}
\tag{3}
\]
Then \(T_{\alpha,\beta}^2=1\). Its two eigenspaces give the
thirty lines, with bases over \(\mathbf F_5\). These bases therefore
agree with their coefficient Frobenius twists.

Their union is connected. For \(\alpha=0\) they are the six
coordinate edges of a tetrahedron. Every remaining line has an
eigenbasis supported on the two coordinate pairs permuted by
\(i\mapsto i+\alpha\). Each of its two basis points lies on one
of the coordinate edges. This proves the claimed connectedness
without a parameter-dependent incidence assumption.

The restriction map on all homogeneous quintics is injective. Here
is a short elementary check. Its kernel is preserved by coordinate
characters and translations. Splitting under the characters and
translating any nonzero character component produces a nonzero
invariant quintic in the kernel, because the degree is odd.

An invariant quintic is a linear combination of fourteen monomials.
Vanishing on the coordinate edges removes seven of them. Write the
remaining polynomial as
\[
\begin{split}
P={}&A x_0x_1^2x_2^2+B x_0x_1^2x_3^2+C x_0x_2^2x_3^2\\
 &+x_1x_2x_3(Dx_0^2+Ex_1^2+Fx_2^2+Gx_3^2).
\end{split}
\tag{4}
\]
Restriction to \((s,s,t,t)\) and \((s,s,t,-t)\) gives
\(A+B=0,D+E=0,C=0,F+G=0\). Restriction to
\((s,t,s,t)\) and \((s,t,s,-t)\) similarly gives
\(A+C=0,D+F=0,B=0,E+G=0\). Thus A,B,C vanish and
\((E,F,G)=(-D,-D,D)\). The line \((s,t,t,s)\) then forces
\(2D=0\), hence P=0. All five displayed lines occur in (3).

This proves uniqueness on the full 56-dimensional quintic space,
without presupposing equivariance of a candidate tuple.

## 3. The universal restriction identity

Let L be a four-by-two eigenbasis matrix for one of the lines in
(3), with its two pivot coordinate rows equal to the identity.
Direct restriction of the Hudson equation has the form
\[
K(L(s,t))=c_L(s^4+t^4)+d_Ls^2t^2,
\quad
c_L\in\{1,2\pm b,2\pm c,2\pm d\}.
\tag{5}
\]
Every \(c_L\) is nonzero in the smooth Hudson chart. The branch
parameter is \(\omega_L=d_L/c_L\), and it is different from
\(\pm2\), because the four Prym branch points are distinct.

For the tuple V in the statement, one has the polynomial identity
\[
V(L(s,t))=L\begin{pmatrix}
 c_L^3s^5+d_L(d_L^2+2c_L^2)s^3t^2
                  +c_L(d_L^2+2c_L^2)st^4\\
 c_L^3t^5+d_L(d_L^2+2c_L^2)t^3s^2
                  +c_L(d_L^2+2c_L^2)ts^4
\end{pmatrix}
=c_L^3L Q_{\omega_L}(s,t).
\tag{6}
\]
The identity is in the ring
\(\mathbf F_5[a,b,c,d,s,t]/(a^2-b^2-c^2-d^2+bcd+4)\).
For a coordinate edge it is immediate from the three pure-pair
coefficients of V. For \(L(s,t)=(s,s,t,t)\), put
\(c_L=2+b\), \(d_L=2(a+c+d)\), substitute, and reduce
using the displayed cubic relation. The other pairings are obtained
by permuting the coordinate labels, changing signs, and multiplying
the two entries of one coordinate pair by2. These operations also
give the eigenlines with the phase \(\mu=2\). Thus (6) involves
no division by a possible additional specialization denominator.

For a reproducible full check,
[the exact script](../../scripts/deformations/check_quintic_prym_reconstruction.py)
verifies (5)--(6) on all thirty symbolic lines, reducing coefficients
by the single Hudson relation. It also verifies the full restriction
rank56 and connectivity. The
[small certificate](../../../litt3-computation-data/unmarked_extension_spectrum_20260915/quintic_prym_reconstruction_20260916.json)
records each basis and its two branch coefficients. It is a check
over the parameter ring, not a sample of curves or points.

Now let P be a primitive actual quintic presentation. On each line,
P and V give the same degree-five elliptic map, with no common zero.
Consequently \(P|_L=\lambda_L V|_L\) for a nonzero constant
\(\lambda_L\). If two lines meet, their candidate value at the
intersection is nonzero, so their constants agree. Connectedness
makes all constants a single \(\lambda\). Every component of
\(P-\lambda V\) vanishes on all thirty lines. Section2 makes it
zero. This proves the actual formula, its primitivity and the
base-locus assertion. A generic-curve specialization argument is
unnecessary.

## 4. Corrected dictionary and an independent branch certificate

For the cubic curve set \((\lambda,\mu,\nu)=(2,3,\alpha)\).
First compute the intermediate lowercase constants, with d=1:
\[
z^2=\lambda\mu/\nu,\quad r=\lambda/z,\quad e=\mu/z,
\quad q=(e+1)/(e-1),
\qquad y^2=\frac{(z+1)^2-q^2(z-1)^2}{(r+1)^2-q^2(r-1)^2},
\]
then \((a_0,b_0,c_0,d_0)=(\sqrt{ry},\sqrt y,\sqrt z,1)\).
These lowercase constants must NOT be used as the Hudson node:
that earlier convention produced a Richelot neighbor. Instead put
\[
U=a_0^2+b_0^2+c_0^2+d_0^2,\quad
V=a_0^2+b_0^2-c_0^2-d_0^2,
\quad W=a_0^2-b_0^2+c_0^2-d_0^2,
\quad T=a_0^2-b_0^2-c_0^2+d_0^2.
\]
Choose \(A^2=U/4\), \(B^2=V/4\), \(C^2=W/4\), with
\(D=AB/(qC)\). Then \(D^2=T/4\), and the corrected actual
node is \((A:B:C:D)\). The implementation retains the AB/CD
sign throughout these choices.

The distinction is between first-order and second-order theta
constants; [Gaudry, Sections2--4.2](https://eprint.iacr.org/2005/314.pdf)
uses lowercase functions at period Omega and uppercase functions at
period2Omega. The latter evaluated at2z give the required embedding.
The [correction audit](../../Research/audits/GENUS_TWO_THETA_DICTIONARY_CORRECTION_AUDIT_2026_09_16.md)
also gives an independent algebraic certificate, so the endpoint
identification does not rest solely on this convention.

Namely, the six nodes on a trope plane determine a nonsingular
conic. The quartic restricts to a nonzero scalar times its square.
Projection from one node, with the tangent at that node supplying
its missing parameter, gives six points of the projective line.
The [canonical checker](../../scripts/deformations/check_cubic_theta_dictionary.py)
exhibits a projective transformation taking exactly those six
points to \(\{0,1,2,3,\alpha,\infty\}\). The genus-two
Kummer reconstruction from a trope conic and its six nodes therefore
identifies the underlying curve with the actual backup. The old
lowercase node fails the same test and is explicitly identified
with a Richelot neighbor; its original evidence is retained externally.

The Hudson equation is uniquely determined by the corrected node's
four gradient equations, whose coefficient matrix is invertible.
Its coefficients lie in F125, and all displayed theta constants
lie in F_(5^12). A frame made from five labelled nodes puts the
whole configuration, quartic, quintic tuple and every trope over
F125. The [receipt](../../../litt3-computation-data/theta_dictionary_correction_20260916/canonical_dictionary_check.json)
records these complete checks, not just sampled curve points.

Finally use the equivariant Wirtinger projective identification
between the Jacobian's theta embedding and the theta-divisor map
of SU (Ducrohet, Proposition2.1). The standard Heisenberg matrices
and their contragredients agree projectively. Any remaining
projective intertwiner is a scalar times a Heisenberg operator:
its commutator scalars form a character, remove that character by
one such operator, then apply ordinary Schur uniqueness. These
operators preserve the Hudson equation. Their compatible Frobenius
twists on the source preserve the equivariant formula of Section3.
Thus the corrected frame gives the actual map on the backup.

## 5. The boundary square at every ordinary specialization

Ducrohet's Proposition1.2 proves the generic factorization
\[
K(V)=K^{(5)}H^2,\qquad \deg H=8.
\tag{8}
\]
Its general-curve hypothesis must not simply be dropped. Here is
why the factorization extends in the present normalization.
On the smooth Hudson parameter chart the actual quintics above
have regular polynomial coefficients, as do both Kummer quartics.
The source quartic is monic as a polynomial in x0. Polynomial
division therefore writes K(V) as that quartic times a regular
degree-sixteen form D, plus a regular remainder. The remainder
vanishes at the generic point by (8), so it vanishes identically.
Moreover V(e0)=e0 and both quartics take value1 at e0=(1:0:0:0).
Thus D(e0)=1 throughout the chart: D never specializes to zero.

In characteristic different from two the map of projective spaces
\[
\mathbf P H^0(\mathcal O(8))\longrightarrow
\mathbf P H^0(\mathcal O(16)),\qquad [h]\longmapsto[h^2],
\tag{9}
\]
is a closed immersion. It is proper and universally injective;
its differential sends a tangent class dh to 2h dh and is
injective modulo the scalar direction, since the polynomial ring
is a domain. These facts give the closed-immersion assertion.
The regular map [D] lands in this closed image generically,
hence everywhere. This proves (8) at every ordinary smooth
specialization and gives a regular projective octic [H].
Normalize H(e0)=1 if an actual representative is needed.
The argument is compatible with changes of actual theta frame.
It does not extend generic irreducibility, which is unnecessary.

At a stable base point, all four quintics vanish and the source
quartic is a unit. The left side of (8) has order at least four,
so H has order at least two. At any stable non-base point,
the source quartic is nonzero and (8) identifies H=0 with the
target Kummer condition, exactly strict semistability after
the actual relative Frobenius pullback.

## 6. Iteration and scope

Coefficient Frobenius sends the target frame, equation and candidate
tuple to the next source frame, equation and tuple. Thus the ordered
composition in the statement follows from relative pullback and
the coordinate map \(x\mapsto x^{[5^h]}\). No rational-point
enumeration replaces the geometric parameter plane, and no period
of the coefficients proves a period of all its points.

The known theta-plane dictionary identifies pointed extensions with
the sixteen trope planes; their boundary is strongly semistable and
the two-torsion action identifies the sixteen survival questions.
We have supplied the missing actual-map identification for this
fixed-dimensional model. No new height verdict follows until its
intermediate base loci are tested or controlled geometrically.
