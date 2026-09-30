# Proof: affine Frobenius and the intersection of the endpoint fields

[Statement](../../Theorems/deformations/common_bt_tower_rigidity.md).
This is local continuation of exact realization; no independent
audit is claimed.

## Arithmetic descent of a nonempty single-curve fiber

Let $\sigma$ be arithmetic $q$-Frobenius. The Cartier kernel $K_H$
is a finite-dimensional $k$-linear space, with its natural semilinear
$\sigma$ action and descent to $\mathbf F_q$. One can see the descent
by writing the Cartier equation in bases defined over $\mathbf F_q$
and taking fifth powers to linearize it. A change of logarithmic
character trivialization multiplies its form by a nonzero constant
and leaves the zero condition unchanged.

Choose one geometric next extension $A$. The exact realization
theorem identifies the fiber with a torsor under $K_H$. Under this
identification Frobenius is an affine semilinear map
\[
a\longmapsto \tau+\sigma(a),
\qquad \tau=\Delta_N(A,\sigma A).
\tag{2}
\]
Choose an $\mathbf F_q$ basis of $K_H$. A fixed point of (2) is
obtained by solving, separately in each coordinate,
$a_i^q-a_i=-\tau_i$. These equations have solutions in the
algebraic closure and each has exactly $q$ roots. Hence there are
exactly $q^d$ Frobenius-fixed geometric classes.

Each fixed class descends as an actual marked normalized group.
The group and the unique comparison with its Frobenius conjugate
are defined over a finite extension. Iterate that comparison around
the finite Galois cycle: the composite is a marked normalized
automorphism and hence is the identity by the established scalar
theorem. Effective descent of finite locally free Hopf algebras
therefore applies. Conversely a rational group has a fixed class.
There are no further rational forms because the marked normalized
automorphism group has no nonidentity geometric sections. This
proves(1) without asserting a fine moduli scheme or global
nonemptiness.

## Uniqueness on the actual two-leg span

Suppose two compatible next-level pairs extend the same fixed
compatible BT$_N$ datum. Let $a\in K_X$ and $b\in K_Y$ be their
endpoint differences. Their specified comparisons on the SAME $Z$
and functoriality of the invariant give
\[
f^*a=g^*b\quad\text{in }k(Z).
\tag{3}
\]
Corelessness makes the common value lie in $k$. A constant in a
Cartier kernel is zero because $C(c\Omega)=c^{1/5}\Omega$. Thus
$a=b=0$. Actual endpoint comparisons exist and are unique. They
respect the source comparison by its own normalized uniqueness.
This proves uniqueness of the next pair. Induction starting with
the marked BT1 proves uniqueness at every level. This step uses
both actual embeddings, not an isogeny-category replacement.

If the fixed data are defined over $\mathbf F_q$, every arithmetic
conjugate of a compatible pair is another extension of the same
data. Uniqueness supplies its descent comparison. As in the first
part, work over a finite field of definition and use triviality of
marked automorphisms to check the cocycle, then descend actual groups,
markings and the original source comparison.

Finally, suppose compatible levels are unbounded. Truncation gives
one at every smaller level. Their unique marked identifications
identify all these truncations coherently. They therefore form a
compatible inductive system of finite flat groups, which is a full
Barsotti--Tate group on each endpoint. The source identifications
are coherent by uniqueness as well. All terms remain over the
original finite field. No choice of arithmetic Frobenius orbit is
being used to create a missing next level.
