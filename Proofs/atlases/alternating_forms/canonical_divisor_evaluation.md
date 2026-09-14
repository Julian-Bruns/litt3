# Proof: pushout and evaluation on the section

## 1. The two exact sequences

Semistability gives H0(E^vee)=H0(E^vee omega)=0 and
Hom(V,V omega^-1)=0. Riemann–Roch and Serre duality give

    h0(E)=4n=m,    h0(End(E) omega)=m+h.

Here End(E) is self-dual by its nondegenerate trace pairing in every
characteristic. The trace-free splitting will only be used when2 is
invertible.

The pushout is E_s=coker[O->E+omega,1|->(u,−s)]. Since u is nowhere
zero it is locally free, and its sequences are

    0 -> omega -> E_s -> omega^3 ->0,
    0 -> E -> E_s -> omega|D_s ->0.

The first has class s eta. Tensor by E^vee to obtain

    0 -> E^vee omega -> Hom(E,E_s) -> E ->0.              (6)

Its connecting map on H0(E) is A_s, up to the fixed overall extension
sign. The left H0 vanishes, so Hom(E,E_s) identifies with rad A_s.

Evaluation at u also gives

    0 -> E^vee omega -> End(E) omega -> E omega ->0.      (7)

Its connecting map is determinant cup product with eta. Thus A_s v=0
exactly when s v is the evaluation of a global Higgs field. This field
is unique by the same left-hand vanishing. Its value is divisible by s
exactly when it vanishes on the entire divisor D_s, proving(1).
Since D_s has length2n, the target of evaluation has dimension4n=m.
This proves(2), including repeated points.

When2 is invertible, split End(E)=O+End_0(E). The trace-free Higgs
space has dimension (m+h)−h0(omega)=3n+h−1. Scalar evaluation on D_s
has kernel ks because u is nowhere zero, so its image has dimension n.
The quotient target therefore has dimension3n.

A trace-free field phi lies in ker M_s precisely when
phi(u)|D_s=(r u)|D_s for some r in H0(omega). Subtracting r Id makes
it a radical field; the choice of r is unique modulo ks. This gives(3).
Finally A_s is alternating on the even-dimensional A and kills u, so
its corank is positive and even. For h=1, the square M_s consequently
has odd nullity, giving the stated minor test.

## 2. The common radical under acyclicity

If H0(V)=0 then chi(V)=0 gives H1(V)=0. A destabilizing line would
have degree>g−1 and hence a section by Riemann–Roch; thus acyclicity
alone implies the semistability used above.

The basepoint-free pencil sequence, tensored with V omega, is

    0 -> V -> E+E -> E omega ->0.

Acyclicity gives H0(E omega)=s0 A direct-sum s1 A. Tensoring the
section extension by E^vee gives

    0 -> E^vee -> End(E) -> E ->0.

Its connecting map has kernel the h-dimensional evaluation image of
H0(End(E)); evaluation is injective since H0(E^vee)=0. By Serre
duality and the pencil decomposition, this map is the two stacked
alternating forms. Their common radical is therefore that image.

## 3. Direct images under the pencil

The finite flat map f has degree2n and f^*O(1)=omega.
The bundle f_*V has rank m and no cohomology, so its splitting on P1
is O(-1)^m. Projection formula gives f_*E=O^m.

Put T=f_*End(E), of rank2m and degree−3m. Semistability and duality give

    h0(T(-1))=0,    h0(T)=h,
    h1(T(1))=h,     h1(T(2))=0.

The first two force exactly h zero-degree summands and no positive
ones. The last two exclude degrees below−3 and force h copies of
O(-3). Rank and degree leave m−h copies each of O(-1) and O(-2),
proving(4). Finite flatness and duality suffice; no separability of f
is required.

## 4. Coordinates and the fixed tensor

By(7) the evaluation image is the kernel of cup product on H0(E omega).
Its matrix in the pencil decomposition is [A_0 A_1], whose rank is
m−h because its transpose has the h-dimensional common radical.
Thus H has dimension m+h.

A section s0 x+s1 y vanishes on D_(s0+t s1) precisely when it equals
(s0+t s1)v for a global v in A. The direct sum makes this equivalent
to y=t x; at s=s1 it is x=0. This proves(5).

Coefficient Frobenius transports these maps to the fixed scalar oper
coordinates and preserves their ranks. The
[genus-two checker](../../../scripts/genus_two/alternating_kernel_genus_two_check.sage)
verifies the original33 normalized atlas points and their R-sensitive
controls. At all26 F25 pencil parameters its4×5 evaluation matrix has
rank3, with the reconstructed radical of dimension2. This checks the
saved tensor interface.
