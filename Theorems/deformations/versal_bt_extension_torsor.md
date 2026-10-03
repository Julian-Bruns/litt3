# A rank-four affine torsor represents the actual next BT level

Version2,3 October2026. Let $C/k$ be smooth projective connected,
$k=\overline{\mathbf F}_5$, of genus at least two. Let $A_N/C$ be
an actual determinant-normalized height-two, dimension-one BT$_N$,
$N\ge1$. Its BT1 $H$ is everywhere versal, generically ordinary,
and has reduced supersingular divisor $S$. No next-level reference
on $C$ or on a proper cover is assumed.

Put $L=\mathcal O_C(S)$. Use ABSOLUTE Frobenius in the following
formula, including its action on $k$. The logarithmic Cartier map
is an $\mathcal O_C$-linear surjection
\[
\mathscr C_H:F_{{\rm abs}*}L\twoheadrightarrow L,
\qquad C(\pi^*h\,\Omega)=\pi^*\mathscr C_H(h)\,\Omega.
\tag{1}
\]
Thus
\[
0\longrightarrow\mathcal B_H\longrightarrow F_{{\rm abs}*}L
\overset{\mathscr C_H}\longrightarrow L\longrightarrow0
\tag{2}
\]
defines a vector bundle of rank four and degree $4(g(C)-1)$.
Its global sections are the Cartier difference space, with the
Frobenius-twisted scalar convention in (2), and
\[
H^1(C,\mathcal B_H)\simeq
\operatorname{coker}\bigl(\mathscr C_H:H^0(C,L)\to H^0(C,L)\bigr),
\qquad \chi(\mathcal B_H)=0.
\tag{3}
\]

The sheaf on the SMALL ETALE SITE of $C$ of normalized marked
BT$_{N+1}$ extensions of $A_N$ is a torsor $\mathscr T_N(A_N)$
under the additive vector bundle $\mathcal B_H$. It is represented
on that site by an affine vector-bundle torsor on $C$. In particular
there is a canonical absolute class
\[
e_N(A_N)=[\mathscr T_N(A_N)]\in H^1(C,\mathcal B_H),
\tag{4}
\]
and
\[
e_N(A_N)=0
\quad\Longleftrightarrow\quad
A_N\text{ has an actual normalized marked BT}_{N+1}\text{ on }C.
\tag{5}
\]
If the induced connection is indigenous-ordinary, then
$H^0(C,\mathcal B_H)=H^1(C,\mathcal B_H)=0$.
Therefore EVERY supplied normalized marked BT$_N$ has a UNIQUE next
extension and a UNIQUE full marked tower on the ORIGINAL curve.
This requires no global next-level reference. It applies to every
actual versal BT1 on either selected genus-two endpoint. It does
not identify the two pulled-back towers on a common source.

This statement does not assert a fine moduli scheme on arbitrary,
possibly nonreduced base schemes, or a universal BT group over the
total space of the torsor. It classifies actual groups on etale
curves over $C$ and in particular on $C$ itself.

All constructions commute with actual etale pullback. For any actual
five-group Galois cover $q:D\to C$, of group $P$, the ambient module is
\[
H^0(D,q^*L)\simeq k[P]^{\,3g(C)-3}.
\tag{3a}
\]
For a
five-group Galois cover with a next-level reference upstairs,
the class (4) is exactly the class detected by the Cartier primitive
in [the existence-descent theorem](bt_p_cover_cartier_obstruction.md),
up to the chosen sign convention for a torsor cocycle. Thus that
cover kills a specific absolute coherent-cohomology class; no
arbitrary abstract cocycle is substituted for it.

Equivalently, (4) gives a canonical extension up to the usual
isomorphism fixing its ends,
\[
0\longrightarrow\mathcal B_H\longrightarrow\mathcal M_N(A_N)
\longrightarrow\mathcal O_C\longrightarrow0.
\tag{6}
\]
The torsor is the inverse image of $1$ in (6). If actual marked
BT$_N$ data are common on the two maps $X\leftarrow Z\to Y$,
then (2), (4) and (6) are common on those SAME maps. Compatible
next levels are precisely compatible splittings of (6). The
rank-five middle bundles do not come with those splittings.

The argument also gives actual next-level existence on every
smooth AFFINE etale curve over $C$, where $H^1(\mathcal B_H)=0$.
This does not force the proper-curve class (4) to vanish or prove
two-leg compatibility. Both original common-cover problems remain
unresolved.

[Proof](../../Proofs/deformations/versal_bt_extension_torsor.md).
