# Finite partner counts for bounded and fixed quotient atlases

Let k be algebraically closed, X/k a fixed smooth projective connected
curve with g(X)>=2, and B>=1 an integer. Only finitely many isomorphism
classes of smooth proper effective DM curves S admit a representable
finite etale atlas X -> S of degree at most B.

For any fixed h>=2, only finitely many isomorphism classes of genus-h
smooth projective curves Y admit a representable finite etale atlas
to any such S. If n=deg(X/S), the degree of Y -> S is necessarily
(h-1)n/(g(X)-1).

Wild inertia and non-Galois atlases are allowed. The theorem neither
supplies the bound B nor turns a coreless span into an orbifold atlas.

## Explicit count

In any characteristic, write g=g(X), take B>=2, and set

    D=(B-1)!, G=1+(g-1)D, L=B^2,
    M=floor((h-1)B/(g-1)),
    K=D*(D!)^(2g)*3^(4G^2 L)*(M!)^(2G+L).

If M>=1, the number of genus-h partners through these bounded atlases
is at most K. If M=0, there are no such partners.
If ALL effective orbifold atlas degrees of X are bounded by B, the
same K bounds all its genus-h CORED finite-etale common-cover partners.

## A fixed quotient target

Let \(D/\mathbf F_q\) be smooth projective of genus \(d\ge2\), with
a finite constant group \(G\) acting over \(\mathbf F_q\), and set
\(\mathcal S=[D/G]\). For genus \(h\ge2\), put
\[
n=\frac{(h-1)|G|}{d-1},\qquad
a=2d+\lfloor\log_2|G|\rfloor.
\]
If \(n\notin\mathbf Z\), there is no representable finite étale
genus-\(h\) atlas to \(\mathcal S\). Otherwise at most \((n!)^a\)
geometric curve classes admit one. This includes wild stabilizers,
non-Galois atlases and disconnected pullbacks of \(D\to\mathcal S\).
The finite set is \(q\)-Frobenius-stable. For a finite list of such
targets, sum the bounds; if every geometric isomorphism class in a
family \(Y_t/\mathbf F_q\) has at most \(c\) parameter preimages,
a parameter of prime degree greater than both (c) and that sum
avoids all their atlases.

For \(H:X^6+Y^6+Z^6=0\) in characteristic five and
\(G=\operatorname{PGU}_3(5)\), one has \(d=10\),
\(|G|=378000\), \(n=42000\) for \(h=2\), and \(a=38\).
Thus the already selected \(Y_t\) below, whose parameter degree
exceeds \(K>(42000!)^{38}\), has no atlas to \([H/G]\) or to
\([H/G']\) for any subgroup \(G'\le G\). No new Hermitian atlas
enumeration or stronger parameter selection is required. This
does not turn a connection into an atlas or exclude one on an
arbitrary further étale cover of \(Y_t\).

## Avoidance in characteristic five

Suppose X is defined over F_q, with q a power of5, and
use h=2 and M>=1. For any prime r>K, let t have degree r over
F_q. Then the ordinary genus-two curve

    Y_t: v^2=u(u-1)(u-2)(u-3)(u-t)

has no CORED common finite-etale cover with X. Choosing the least such
prime and the first monic irreducible degree-r polynomial in a fixed
coefficient order is a deterministic finite prescription, not a practical
computation. No claim about coreless covers or simplicity of J(Y_t) follows.

Version5. The fixed-quotient count and its Hermitian application are
combined with the effective partner bound. The fixed-quotient
corollary is author-proved. The explicit count applies in every
characteristic, using the published automorphism bound and its
Hermitian exception.
[Proof](../../Proofs/quotient_geometry/bounded_atlas_partner_finiteness.md).
