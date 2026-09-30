# Proof: descend the actual geometric morphism by finite arithmetic monodromy

[Statement](../../Theorems/shared_tensors/geometric_common_coefficients.md).
Choose a finite field over which the curves, the two maps and the
specified arithmetic X-system are defined. Enlarge it when necessary
so the curves are geometrically connected. Constant extensions do not
replace either map or the common source.

## The normalized semisimple category

Call an arithmetic object normalized here if each of its irreducible
constituents has finite-order determinant. This is a constituentwise
condition, not just a condition on the determinant of a direct sum.
The needed primary input is
[D'Addezio, Lemma3.4.6, Theorem3.4.7 and Corollary3.4.5](https://arxiv.org/pdf/1711.06669):
the zero twist-class condition is preserved and reflected by finite
étale pullback, forms a Tannakian subcategory, and its arithmetic
monodromy has unipotent radical. For a semisimple object the arithmetic
monodromy identity component is therefore semisimple. The geometric
identity component is its derived subgroup, so the two identity
components coincide.

In particular, for a normalized semisimple object $P$, put
$G=G_{\rm arith}(P)$ and $H=G_{\rm geom}(P)$. Then
\[
G^\circ=H^\circ,\qquad G/H\text{ is finite}.
\tag{1}
\]
The geometric group is a normal algebraic subgroup. After a finite
extension of constants, arithmetic Frobenius has trivial image in
$G/H$, so the arithmetic and geometric Zariski closures become equal.
Consequently every geometric invariant subspace, projector and
endomorphism of $P$ is arithmetic over this same extension.

Apply this to a direct sum of finitely many normalized semisimple
objects. Its arithmetic group still has semisimple identity component;
it is a subdirect product of the corresponding groups, or one may use
the Tannakian assertion directly. This proves the simultaneous Hom
and finite-diagram statements. It preserves a SPECIFIED geometric
map, rather than merely replacing it with some arithmetic map.

## Finite étale induction stays in this category

Restriction of a normalized semisimple representation to a finite-index
subgroup is semisimple: its algebraic monodromy has the same reductive
identity component. Normalization is preserved by the cited pullback
lemma.

Finite étale pushforward also preserves both properties. To see this,
take a Galois closure of that ONE finite étale map. After pullback to
the closure, the pushforward is a sum of conjugate pullbacks of the
original object. It is normalized and semisimple. Normalization is
reflected by finite étale pullback. For semisimplicity, use a normal
finite-index subgroup corresponding to the closure: an equivariant
splitting there can be averaged over the finite quotient to make it
equivariant for the full group. This averaging is in characteristic
zero, so no restriction on the covering degree is needed.

This argument makes no assertion that there is a source simultaneously
Galois over both endpoints.

## Produce the other arithmetic extension inside the actual pushforward

Let $L_{X,0}$ denote the specified arithmetic extension and put
\[
P_0=g_*f^*L_{X,0}.
\tag{2}
\]
It is normalized and semisimple by the preceding section. Geometrically,
the specified $\eta$ and projection formula identify it with
$g_*g^*\mathcal L_Y$. The unit and trace maps exhibit
$\mathcal L_Y$ as a direct summand: their composite is multiplication
by $\deg g$, which is invertible in $\overline{\mathbf Q}_\ell$ even
when it is divisible by $p$ or $\ell$.

Thus the ORIGINAL geometric $\mathcal L_Y$ is the image of a specified
geometric idempotent on $P_0$. By (1), this idempotent is arithmetic
after extending the constants. Its image supplies a normalized
semisimple arithmetic extension $L_{Y,0}$ of $\mathcal L_Y$.

Finally, on $Z$ consider
$f^*L_{X,0}\oplus g^*L_{Y,0}$. Apply (1) to its geometric Hom space.
The given $\eta$ becomes arithmetic over a further finite extension.
If an arithmetic Y-extension was supplied initially, use it in this
last direct sum; the same argument preserves that choice as well.
No irreducibility after restriction to $Z$ was required.

An irreducible finite-determinant arithmetic object with finite geometric
image also has finite arithmetic image, by (1). Hence infinite geometric
image and the required infinite normalized arithmetic image agree here.
The result removes an arithmetic matching hypothesis. It does not
assert arithmetic origin or geometric matching for arbitrary local
systems on the endpoints, and it does not produce one from the span.
