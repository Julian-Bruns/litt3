# Prime-to-characteristic covers do not create the next BT level

Version2,3 October2026. Let $C$ be a scheme of characteristic $p>0$,
let $A/C$ be an ACTUAL BT$_N$, $N\ge1$, and put $H=A[p]$.
If a finite etale surjection $q:D\to C$ has constant degree $d$
prime to $p$ and $q^*A$ has a marked BT$_{N+1}$ extension,
then $A$ has a marked BT$_{N+1}$ extension on the ORIGINAL $C$.

The assertion concerns existence. The constructed extension need
not pull back to the specified one. No Galois assumption, or
prime-to-$p$ assumption on the Galois closure, is needed. There is
no versality, genus, height, dimension or ordinariness hypothesis.
For odd $p$, height two and dimension one, a supplied next determinant
target compatible with the marked determinant of $A$ can be imposed
by a character twist trivial at level $N$. In particular this
preserves a supplied Teichmuller determinant normalization.

The general criterion behind the construction is useful separately.
For any extension of abelian fppf sheaves
$0\to H\to B\to A\to0$, lifting $a\in A[p]$ locally to $b\in B$
defines the additive boundary $\partial(e)(a)=pb\in H$.
Then
\[
\partial(e)=\operatorname{id}_H
\quad\Longleftrightarrow\quad
B\text{ is an actual marked BT}_{N+1}\text{ extending }A.
\tag{1}
\]
The marking in (1) retains the given inclusion and quotient maps.
The boundary of the corestricted supplied extension is
$d\operatorname{id}_H$. A Baer multiple $a$ with $ad\equiv1\bmod p$
therefore constructs the required group.

At $p=5$, [common admissible BT1 realization](common_admissible_bt1.md)
gives a global BT2 extension of $H_X$ whenever $5\nmid\deg f$:
its source pullback has a full extension from $g^*G_Y$, twisted
by the finite character discrepancy. This does not make the two
endpoint BT2 groups compatible on the source.

Arbitrary-degree existence descent is false, already for the
[actual cyclic-five example](etale_p_witt_obstruction.md).
The reduction to cyclic degree $p$ uses only a normal closure of
the chosen single cover and a Sylow subgroup, never a simultaneous
Galois closure of both legs.
[Proof](../../Proofs/deformations/prime_to_five_bt_extension_descent.md).
