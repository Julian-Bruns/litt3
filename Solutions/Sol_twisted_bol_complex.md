# Proof: twist the two intrinsic oper operators, not rational frames

[Statement](../Theorems/Thm_twisted_bol_complex.md).
All coherent modules below are on the absolute-Frobenius target. On a
scalar F_* module, c acts as c^5; converting to the scalar coordinates
used in computations is a coefficient twist. None of the degree counts
substitutes fifth powers for independent polynomial variables.

## 1. Intrinsic operators and their local forms

The rank-two oper has the scalar operator

    L0:theta^-1 -> theta^3,       f |-> D^2 f-r f.

This is part of its oper structure, rather than an operator defined only
after choosing one global rational coordinate. Its symmetric-square
connection supplies the scalar third-order operator

    Q0:omega^-1 -> omega^2,       f |-> D^3 f+r Df+3(Dr)f.

Indeed the usual derivative calculation annihilates u^2,uv,v^2 when
u,v solve D^2u=ru. Its leading symbol is the normalized third derivative.
This is also a direct gluing check: the symmetric-square oper has the
coordinate-free quotient omega^-1 and its first three jets reconstruct
the horizontal section. In characteristic5 the required coefficients2
and3 are invertible. The normalized operator with these three independent
solutions is unique, so the local expressions glue.

Tensor L0 by the canonical horizontal line F^*(theta tau^2). Since

    F^*(theta tau^2)=theta^5 tau,

its source and target become omega^2 tau and omega^4 tau. Tensor Q0
by F^*(omega tau^2)=omega^5 tau: its source and target become omega^4 tau
and omega^7 tau. These constructions define L_tau and Q_tau globally.
They use tau^3=O explicitly; treating tau as an ordinary constant factor
without the fifth-power calculation would not be a valid gluing argument.

At any point choose a local horizontal frame of the dormant rank-two
bundle whose first scalar solution u is a unit. For a complementary v,
z=v/u is an etale parameter: the oper second fundamental map is nowhere
zero. After the corresponding density gauges, L_tau and Q_tau are
partial_z^2 and partial_z^3. Locally the scalar Frobenius module has
basis1,z,z^2,z^3,z^4. The two maps have ranks3 and2, their compositions
are zero, and image(partial_z^2)=ker(partial_z^3). This proves exactness
in regular local frames at EVERY point, including any poles of a rational
coordinate used elsewhere.

The kernel of L_tau is W theta tau^2 by Cartier descent. The kernel
of Q_tau is Sym^2(W) omega tau^2 by the symmetric-square construction.
Finally the image of Q_tau is the kernel of the rank-two operator on
omega^7 tau. Tensoring L0 by F^*(theta^3 tau^2)=theta^15 tau identifies
that kernel with W theta^3 tau^2. These local identifications are the
intrinsic oper maps just constructed, so they glue to(1).

## 2. Global exactness and dimensions

Split(1) at I_tau. Since deg(omega^2 tau)=4g-4>2g-2,
H1(omega^2 tau)=0. The first short exact sequence and vanishing of H2
on a curve imply H1(I_tau)=0. The second sequence therefore makes H0Q_tau
surjective. Stability gives H1(W theta^3 tau^2)=0: its Serre-dual
bundle is W theta^-1 tau, of negative slope. Riemann--Roch yields

    h0(W theta^3 tau^2)=4(g-1),
    h0(omega^4 tau)=7(g-1),

so the kernel has dimension3(g-1). The first sequence also gives

    ker(H0 Q_tau)/im(H0 L_tau) = H1(W theta tau^2).

Its dimension is h0(W theta tau^2), because that rank-two bundle has
Euler characteristic zero. This is why one must not replace the full
Q kernel by the bounded L image at a nonacyclic oper or torsion twist.

## 3. The correct dual torsion exponent

Dualize 0->I_tau->F_*(omega^4 tau)->W theta^3 tau^2->0 and tensor by
omega. Finite-Frobenius duality identifies

    (F_*(omega^4 tau))^vee tensor omega
        = F_*(omega^-3 tau^-1).

One may verify this without a trace-of-degree assumption: the local
Cartier residue pairing on the five basis monomials is perfect, and
gluing gives precisely the displayed canonical-line twist. Ordinary
field trace of a purely inseparable extension is NOT being used.

The left term in the dual exact sequence is

    (W theta^3 tau^2)^vee tensor omega = W theta^-1 tau,

since det W=O and tau^-2=tau. This is tau, not tau^2. The quotient is
I_tau^vee omega, whose H0 is dual to H1(I_tau) and therefore zero.
Thus the induced H1 map is injective. Serre duality identifies its image
with the annihilator of the global Q kernel. It has dimension4(g-1).
Transporting the Frobenius scalar convention gives exactly(2) and J_tau.

Equivalently, the dual injection is the scalar horizontal inclusion for
the rank-two operator on omega^-3 tau^-1. Its kernel description follows
by twisting L0 with F^*(theta^-1 tau)=theta^-5 tau^-1. This checks the
same torsion exponent directly from differential operators.

## 4. The small resultant construction also survives the twist

For genus9 put V=W theta tau^2, T=omega^-1 and M=omega^2 tau.
Then deg V=16, h1(T)=h0(M)=24, and V T^-1=W theta^3 tau^2 separates
length-two subschemes. Its Serre-dual obstruction has stable slope-6.
The general cohomological Bezout theorem therefore gives its mixed
(24+h0(V))-square matrix, with determinant the reduced degree48
resultant and exact corank on every zero divisor. In the acyclic case
the inverse-cup matrix is quadratic24x24.

When tau is nontrivial, H1(T)^vee=H0(omega^2) is NOT H0(M).
Accordingly no symmetry of this matrix is claimed. The determinant and
cup-product constructions remain valid without that identification.

This proof closes the twisted differential-space construction, not the
remaining Hermitian compatibility. In particular neither an unnormalized
residue formula nor the untwisted97-equation coefficient file is silently
reused as a complete test for all cubic torsion classes.
