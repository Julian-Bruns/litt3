# The alternating atlas radical is a canonical-divisor evaluation kernel

Let C be a smooth projective connected curve of genus g>=2 over an
algebraically closed field of characteristic different from2. Put n=g-1.
Let V be stable of rank two, det V=omega, with H0(V)=0, and set
E=V omega. A nowhere-zero section u of E gives its ACTUAL extension

    0 -> O --u--> E -> omega^3 ->0,

with class eta. For s in H0(omega), define the alternating form on
A=H0(E), of dimension m=4n, by

    A_s(v,w)=<eta,s det(v,w)>.

For nonzero s, let D_s=div(s), and let E_s be the pushout of this
extension along s:O->omega. Thus

    0 -> omega -> E_s -> omega^3 ->0,
    0 -> E -> E_s -> omega|D_s ->0.

There are natural identifications of vector spaces

    rad(A_s) = Hom(E,E_s)
             = {phi in H0(End(E) omega): phi(u)|D_s=0}.     (1)

In the final description, the corresponding radical vector is phi(u)/s.
The harmless overall sign in the connecting homomorphism depends on
the determinant/extension convention and does not change (1).
Repeated points of D_s are retained scheme-theoretically.

Consequently

    corank A_s = h0(Hom(E,E_s))
               = m+1-rank[H0(End(E) omega)
                          -> H0((E omega)|D_s)].          (2)

The source has dimension m+1, the target dimension m. The image of u
is in every radical, their common intersection is ku, and each single
corank is an even integer at least2.

For a basepoint-free canonical pencil s0,s1, let f:C->P1 be its map.
Its geometry also gives the noncanonical splittings

    f_*E = O^m,
    f_*End(E) = O + O(-1)^(m-1) + O(-2)^(m-1) + O(-3).  (3)

In the exact decomposition H0(E omega)=s0 A + s1 A, put

    H=ker[A_0 A_1],                 dim H=m+1.

Then H is the image of H0(End(E) omega) by evaluation on u. The
canonical-divisor map for s=s0+t s1 is exactly

    H -> A,       (x,y) |-> y-t x.                       (4)

At infinity it is (x,y)|->x. Formula (4) gives a small exact way to
verify (2) using the existing complete alternating tensor.

For an actual fixed-curve atlas m=32. Its normal corank is2 IF AND ONLY
IF the evaluation map in (2) has rank31 at some member of the chosen
pencil. This rank assertion has NOT been proved for orbit0011, nor has
a geometric atlas of higher normal corank been constructed here. The
abstract corank10 example is not evidence against a geometric improvement.
All R equations and normalization remain required for an actual atlas.

Status: author proof,2026-09-07; no independent audit claimed. The full
saved positive genus-two tensor verifies the cohomological kernel model,
evaluation rank3, and radical dimension2 at all26 F25 pencil members
for ALL33 known normalized atlas points. This is a rank formula and a
precise remaining hypothesis, not an atlas or common-cover exclusion.
[Proof](../Solutions/Sol_canonical_divisor_pencil_radical.md).
