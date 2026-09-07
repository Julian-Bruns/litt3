# Bounded audit: full-tensor comparison and cohomological ODE

Verdict: PASS, with the Frobenius convention and local kernel argument
made explicit below. This is an independent prose audit, not Lean verification.

Auditor: `/root/cohomological_ode_comparison_audit`.
Date: 2026-09-07.

Scope: the proposed fixed comparison in
[the now-canonical derivation](../../Solutions/Sol_dormant_differential_projection.md), the scalar realization
in Section 2 of
[scalar reconstruction](../../Solutions/Sol_scalar_hermitian_reconstruction.md),
and Section 3 of
[the extension pencil proof](../../Solutions/Sol_rank_two_extension_pencil.md).
No audit of the whole atlas/common-cover chain, enumeration, numerical
samples, or primitive-kernel degree is asserted here.

## 1. The scalar kernel is the required bundle, including at O

Fix the geometric dormant oper over the algebraically closed field k of
characteristic 5. Put L_r=delta^2-P, and use absolute Frobenius F:C->C.
The O_C-module structure on F_*M is a.m=a^5 m; all scalar-twist
identifications below refer to this convention.

For every integer n, the scalar first coordinate embeds W(nO) into
F_*O((5n-8)O). Away from O, its image consists exactly of solutions
L_r f=0: the full horizontal column is (f,delta f). At O, set

    h=t^(5n-8) f.

The local oper coordinates of that column, after the indicated twist, are

    (h, t^(5n+8) delta f - 8 t^(5n+7)(delta t) f)
      = (h, t^16 delta h).

The equality uses 5n=0 in k. Since t^16 delta is a regular derivation
at O, regularity of h implies regularity of both coordinates; necessity
follows from the first coordinate. Cartier descent then identifies all
such regular horizontal columns with W(nO). This works for negative n,
not just the positive twists used to construct a frame.

For n=-24, the scalar bound is f in O(-128O). Since delta loses at most
17 orders of valuation and P loses at most 34, L_r defines an
O_C-linear map

    F_*O(-128O) --L_r--> F_*O(-94O).

O_C-linearity here follows from L_r(a^5 f)=a^5 L_r(f). The preceding
local calculation proves that its kernel is exactly W(-24O). Thus, if
I_r denotes its image sheaf, there is an exact sequence

    0 -> W(-24O) -> F_*O(-128O) -> I_r -> 0,
    I_r subset F_*O(-94O).

No surjectivity onto F_*O(-94O) is needed or claimed. The negative line
bundle has no global sections, so H0(I_r)=0. The long exact sequence
therefore gives a fixed injective comparison

    j:H1(W(-24O)) -> H1(F_*O(-128O)).

Its source and target have dimensions 64 and 136. For the source,
stability gives H0(W(-24O))=0 and Riemann--Roch gives chi=-64.
Finite Frobenius identifies the target additively with H1(O(-128O)).

## 2. The comparison intertwines the entire tensors

Let E=H1(O(-48O)) and A=H0(W(24O)). The cup-product tensor is

    m:A tensor E -> H1(W(-24O)).

For a section u with scalar realization U and an E-cochain eta, its
image under j is represented by U eta^5. This follows directly from
the module rule a.m=a^5 m, and holds on cochains, before taking any
kernel. Consequently it holds for arbitrary sums of simple tensors.

The additive identification H1(F_*O(-128O))=H1(O(-128O)) is not
k-linear with the latter's usual scalar action: under it j(c z) is
c^5 j(z). Choose a basis z_j of H1(W(-24O)), and let J be the 136x64
matrix whose j-th column is rho128 of the underlying scalar cochain
j(z_j). Then J has rank 64: a relation with coefficients b_j can be
written b_j=c_j^5 because k is perfect, and injectivity of j forces
every c_j, hence every b_j, to vanish.

If m has coefficient matrices in bases u_i, ell_l, z_j, the ordinary
scalar matrices for the old principal-part tensor are J times the
entrywise fifth powers of those cup-product matrices. The 64-row
Wronskian/residue formula in the extension-pencil proof is precisely
that fifth-powered cup-product matrix, expressed in the fixed basis
dual to the S_40 basis. An overall determinant sign or a different
fixed dual basis merely changes J by a fixed invertible factor.
Thus there exists a single injective J, independent of U and eta, with

    N_total = J Ntilde_total.

In particular the kernels on the full scalar tensor product agree.
This is stronger than equality of pointwise pencil kernels; no deduction
from the latter is being used. The result also applies on every tensor
subspace A_scalar tensor J0^[5] used in the coupled sieve.

Equivalently, one may formulate the construction using relative Frobenius
C->C^(1), placing W and the cup product on C^(1), and then consistently
transport coefficients by the field Frobenius. One must not mix this
with an untwisted k-linear identification of absolute F_* cohomology.
Nothing here asserts a family construction over the nonreduced oper
scheme; the geometric oper remains fixed.

## 3. The induced cohomological differential and its dimension

At O the expansions supplied in the frontier are

    delta t=3t^-16(1+O(t^3)),   P=2t^-34+O(t^-32).

For t^n, the leading coefficient of L_r is 9n(n-17)-2 at exponent
n-34. It vanishes for n=48 and n=49 in characteristic 5. The stated
error orders produce no additional terms below exponent 16; inputs
of valuation at least 50 already have image valuation at least 16.
Therefore L_r(t^48 k[[t]]) is contained in t^16 k[[t]]. It also
preserves Acal. Hence it induces

    D_r:H1(O(-48O)) -> H1(O(-16O)).

Writing theta=dx/y^2, one has delta f theta=df. The residue of an
exact Laurent differential is zero, so delta is anti-self-adjoint
under the residue pairing with theta, and L_r is self-adjoint.
The transpose of D_r is consequently

    L_r:L(32O) -> L(64O).

One can also check this bound directly: the leading coefficients
cancel for n=-32,-31, and all smaller pole orders land within L64.
The scalar kernel identification from Section 1 at n=8 identifies
ker(L_r on L32) semilinearly with H0(W(8O)). As dim L32=24 and
dim E=56, it follows that

    dim ker D_r = 56-(24-h0(W(8O))) = 32+h0(W(8O)).

This does not assert that h0(W(8O)) vanishes for every oper.

## 4. Inclusion for arbitrary sums, and its precise scope

Take an arbitrary scalar tensor in ker Ntilde_total. By Section 2 it
lies in ker N_total. Over perfect k write its coordinates as a sum
U_i tensor eta_i^[5], absorbing any coefficients into the factors,
and put

    Q=sum_i U_i eta_i^5,   T=-aff(Q),   V=rem(Q).

Then L_r Q=0 and rho128(Q)=0, so V has valuation at least 128 and
L_r T=L_r V. The former side is affine, whereas the latter has
valuation at least 94. An affine function with no pole at O is
constant on the projective curve, and its positive valuation forces
that constant to be zero. Thus L_r T=L_r V=0.

Write lambda_i=-rho32(delta eta_i). The unreduced R-output is

    Y=kappa^5 V-sum_i U_i lambda_i^5.

Each multiplier is a fifth power, so L_r Y=0. Reducing modulo
Acal+t^48 k[[t]] gives R_total of the original tensor. Since D_r
is induced on that quotient, D_r(rho48 Y)=0. Therefore

    R_total(ker Ntilde_total) subset ker D_r.

In particular an actual solution eta=R_U eta^[5], Ntilde_U eta^[5]=0
must lie in ker D_r. The inclusion is universal for each fixed geometric
oper and does not require the tensor to be decomposable or U admissible.
Equality with the coupled sieve, vanishing of H0(W8), and any global
atlas exclusion remain separate assertions. The original unmarked
common-cover problem remains unsolved.

## Objections and limitations

No remaining mathematical objection to this bounded comparison/inclusion
was found. The frontier's terse phrase about Frobenius needs the scalar
convention in Section 2 when incorporated into a proof. Pointwise kernel
equality alone would leave a real gap, but the fixed sheaf injection
above closes it without assuming simultaneous Galois closure or changing
either actual finite etale map in the original problem.

## Addendum: third-order exact complex and the uniform 32-space

Additional bounded verdict: PASS, 2026-09-07, same auditor. This checks
the subsequent derivation proposed by the main agent; it does not change
the original comparison verdict or assert an exclusion.

Put Q_r=delta^3+P delta+3(delta P), where the last term is multiplication
by the function 3(delta P), and a=3 delta^2 P+P^2. Dormancy gives

    delta^5=a delta,    delta a=0,
    delta^3 P=P delta P.

These identities can be checked without assuming them: delta^5 is a
derivation b delta on the one-variable function field. Applying it to
two horizontal solutions with Wronskian 1 gives b=a and
delta^3 P+4P delta P=0; differentiating a then gives delta a=0.
Operator multiplication consequently gives Q_r L_r=L_r Q_r=0.
Over K=k(C), regarded as a five-dimensional K^5-space, L_r has kernel
dimension 2 and rank 3. The order-three operator Q_r has kernel at most
3, while its image lies in ker L_r; hence its rank is 2 and

    ker Q_r=im L_r,    im Q_r=ker L_r.

The bound L_r:O(32O)->O(64O) was proved above. For Q_r, its leading
coefficient on t^n, at exponent n-51, is

    q(n)=2n(n-2)(n-4)+n+3.

This is zero for n=-64,-63,-62, and is respectively 2 and 3 for
n=-61,-60. The error in delta t begins three orders higher. If
p2 is the coefficient of t^-32 in P, its potentially dangerous
contribution on t^-64 at exponent -113 is

    p2(3n+9(-32))=p2(3n+2)=0,    n=-64=1 in k.

All other corrections have exponent at least -112. Hence Q_r maps
O(64O) into O(112O), and L_r Q_r=0 identifies its output with the
scalar realization of W(24O).

At O the images under L_r of t^-30,t^-29,t^-28 have leading poles
64,63,62 with nonzero coefficients 3,4,3. These give three independent
classes in the Frobenius fiber of F_*O(64O), whose five basis exponents
are -64 through -60. Thus L_r has fiber rank 3 there. Under Q_r,
t^-61 and t^-60 give solutions with leading poles 112 and 111. In
the W(24O) coordinates (h,t^16 delta h), h=t^112 f, their leading
first coordinates are 2 and 3t, and the second column has nonzero
second coordinate 9=4. They are independent in the W(24O) fiber.

Away from O choose a local horizontal solution U which is a unit and
a complementary horizontal solution T with Wronskian 1. The function
z=T/U is an etale coordinate, since delta z=U^-2. Explicitly,

    L_r f = U^-3 partial_z^2(f/U),
    Q_r f = U^-9 partial_z^3(U^3 f).

For the second identity, both sides have the same leading symbol and
annihilate U^-3 times 1,z,z^2; their difference has order at most 2,
so it vanishes. Thus both maps have split ranks 3 and 2 in local
Frobenius coordinates. The local calculations and generic kernel
identities prove exactness of sheaves

    0 -> W(8O) -> F_*O(32O) --L_r--> F_*O(64O)
      --Q_r--> W(24O) -> 0.

Here the final target is the horizontal bundle, with the same absolute
Frobenius module convention as above. Its scalar realization sends
the global map to the ordinary k-linear differential operator
Q_r:L64->S_U. No untwisted k-linear identification of W sections
with their scalar realizations is being imposed.

If I=im L_r, the first short exact sequence shows H1(I)=0, because
H1(O(32O))=0 and a curve has H2(W(8O))=0. The second sequence then
shows that Q_r:L64->S_U is onto for every fixed geometric oper.
Consequently ker(Q_r on L64) has dimension 56-32=24. The global
image L_r(L32) can have codimension h1(W(8O))=h0(W(8O)) in that
kernel; no equality of those two spaces is required.

Finally, the arbitrary-sum proof above gives a rational horizontal Y
for every tensor in ker Ntilde_total. If h in L64 satisfies Q_r h=0,
the function-field equality ker Q_r=im L_r supplies a rational f
with h=L_r f. Formal integration by parts at O gives

    Res_O(Y h theta)=Res_O(f L_r Y theta)=0.

Reducing Y to rho48 Y does not change this pairing: the affine
subtraction has no residues away from O, hence also none at O, and
the local t^48 remainder times h theta is regular. Thus

    R_total(ker Ntilde_total)
      subset Ann(ker(Q_r:L64->S_U)),
    dim Ann(ker(Q_r:L64->S_U))=32.

This sharper, uniform 32-dimensional necessary space remains valid
when h0(W(8O)) is positive. Its equality with any coupled-sieve stage,
or incompatibility with all admissible atlas tensors, is not proved
by this addendum.
