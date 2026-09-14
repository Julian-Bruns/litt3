# Alternating radicals as evaluation on a canonical divisor

Version2,2026-09-14.

Let C be a smooth projective connected curve of genus g>=2 over an
algebraically closed field, in any characteristic. Put n=g−1.
Let V be semistable of rank two with det V=omega, and set

    E=V omega,    A=H0(E),    m=dim A=4n,    h=h0(End(V)).

A nowhere-zero u in A defines the extension
0->O --u--> E->omega^3->0, with class eta. For s in H0(omega), set

    A_s(v,w)=<eta,s det(v,w)>.

These forms are alternating. For nonzero s write D_s=div(s), with
its full scheme structure, and let E_s be the pushout along s:O->omega.

## Evaluation and the scalar quotient

There are natural identifications

    rad A_s = Hom(E,E_s)
            = {phi in H0(End(E) omega): phi(u)|D_s=0}.    (1)

The last description recovers the radical vector as phi(u)/s. Hence

    corank A_s = m+h−rank[H0(End(E) omega)
                             -> H0((E omega)|D_s)].       (2)

The source has dimension m+h and the target dimension m.

In characteristic different from2, define

    M_s(u):H0(End_0(E) omega)
       -> H0((E omega)|D_s)/{(r u)|D_s:r in H0(omega)}.

Its source and target dimensions are 3n+h−1 and 3n, and

    0 -> k(s Id_E) -> rad A_s -> ker M_s(u) ->0.           (3)

Thus corank A_s=1+dim ker M_s(u). If V is simple, in particular if it
is stable, h=1 and M_s is square of size3n with odd nullity. Corank2 is
equivalent to rank3n−1, or to a nonzero minor of size3n−2.

## An acyclic canonical pencil

Assume additionally H0(V)=0. Such a V is automatically semistable.
For a basepoint-free canonical pencil s0,s1 and its map f:C->P1,

    H0(E omega)=s0 A direct-sum s1 A,
    intersect_s rad A_s={phi(u):phi in H0(End(E))},

where the intersection is over the pencil and has dimension h. Moreover

    f_*E=O^m,
    f_*End(E)=O^h + O(-1)^(m−h) + O(-2)^(m−h) + O(-3)^h. (4)

These splittings need not be canonical, and f may be inseparable.
In the displayed section decomposition put H=ker[A_0 A_1], of dimension
m+h. It is the evaluation image of H0(End(E) omega). Restriction to
D_(s0+t s1), in the induced target coordinates, is

    H -> A,       (x,y) |-> y−t x.                       (5)

At infinity it is (x,y)|->x.

For stable V the common radical is ku. At a fixed genus-nine acyclic
atlas, normal corank2 is therefore equivalent to evaluation rank31 at
some pencil member, or scalar-quotient rank23. These ranks are tests;
they have not been proved for every actual atlas.

[Proof](../../../Proofs/atlases/alternating_forms/canonical_divisor_evaluation.md).
