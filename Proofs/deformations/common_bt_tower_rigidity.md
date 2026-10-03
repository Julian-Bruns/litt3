# Proof: the coherent torsor and the intersection of the endpoint fields

[Statement](../../Theorems/deformations/common_bt_tower_rigidity.md).
Use the actual Cartier classification and the later absolute torsor.
Both retain the determinant and complete lower-level marking.

## Arithmetic counts from the absolute coherent torsor

The [absolute extension torsor](versal_bt_extension_torsor.md)
and its bundle $\mathcal B_H$ descend with the supplied actual
data to the fixed curve $C_0/\mathbf F_q$. Use the scalar twist
of absolute Frobenius in that construction; its sections are the
Cartier difference space with the corresponding twisted scalar
convention, of dimension $d$.

Coherent field base change gives
\[
H^1(C_0,\mathcal B_H)\otimes_{\mathbf F_q}k
\simeq H^1(C_0\times_{\mathbf F_q}k,\mathcal B_{H,k}).
\tag{2}
\]
A geometrically nonempty next-level fiber therefore has zero
absolute class already over $\mathbf F_q$. Its actual torsor has
a rational section, so actual normalized marked extensions exist
there. Their classes form a torsor under the $d$-dimensional
$\mathbf F_q$ space $H^0(C_0,\mathcal B_H)$, and have no marked
automorphisms. Hence their number is $q^d$, and after any degree-$m$
constant extension it is $q^{md}$.

If $d=0$, zeroth and first coherent cohomology both vanish.
The same argument gives the unique next extension at every level,
starting with any supplied actual normalized finite level.
The resulting unique marked normalized full tower stays over
$\mathbf F_q$. No reference on a proper cover is needed.

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
data. Uniqueness supplies its descent comparison. Work over a finite field
of definition and use triviality of marked
automorphisms to check the cocycle, then descend actual groups,
markings and the original source comparison.

Finally, suppose compatible levels are unbounded. Truncation gives
one at every smaller level. Their unique marked identifications
identify all these truncations coherently. They therefore form a
compatible inductive system of finite flat groups, which is a full
Barsotti--Tate group on each endpoint. The source identifications
are coherent by uniqueness as well. All terms remain over the
original finite field. No choice of arithmetic Frobenius orbit is
being used to create a missing next level.
