# Marked obstruction torsors and delayed extension

Version1, 2026-09-15. These are statements about actual allowed
points and complete obstruction equations. Their geometric use
requires full primary solves and whole regular repairs; a selected
scalar equation does not supply those inputs.

## Tame averaging of a complete obstruction

Let K,O be abelian groups, A a nonempty K-torsor, and R:K->O
additive. A finite group Gamma acts on these data, affinely on A,
and R is equivariant. Suppose multiplication by q=|Gamma| is
bijective on K and O. Let c:A->O be equivariant and satisfy

    c(a+x)=c(a)+R(x).

Then A has fixed points. A zero of c exists if and only if it
has a Gamma-fixed zero. Let P:O^Gamma->Q be additive and suppose

    R(K^Gamma)=ker P.

The residual P(average_Gamma c(a)) is independent of EVERY choice
a in A, and its vanishing is equivalent to a zero of c. In
particular knowledge of the complete fixed image can give an iff
criterion with all noninvariant choices allowed. This does not
identify the full kernel of R with its fixed kernel.

Over characteristic-p vector groups it suffices that p not divide
|Gamma| and that the maps be Fp-additive. Field-linearity and
perfectness are not hypotheses of this averaging lemma. A wild
deck group of order divisible by p does not satisfy its hypothesis.

## Triangular elimination on actual points

For i=1,...,s, let K_i,O_i be abelian groups and M_i:K_i->O_i bijections. For
arbitrary functions T_i of the earlier variables, the map with blocks

    M_i(x_i)+T_i(x_1,...,x_(i-1))

is bijective on the product of these point sets. If all M_i,T_i
send zero to zero, and an additional variable is absent from every
block, the zero fiber is exactly that free variable. The tails
need not be additive. This is a pointwise conclusion, not an
assertion about reducedness of a parameter scheme.

## Delayed extension

Fix an initial marked W_(m0) truncation and a compatible tuple
through W_(m0+2). At every reached W_m prefix admitting W_(m+2),
m>=m0, suppose its intermediate W_(m+1) choices admitting W_(m+2)
form a torsor A_m under an abelian group T_m of actual allowed
points. Include all lower structures in those choices, or require
them to be uniquely determined by the recorded curve choice.
Suppose their COMPLETE remaining obstruction is an affine map

    psi_m:A_m->Q_m,
    psi_m(a+x)=psi_m(a)+S_m(x),

with S_m additive, and psi_m(a)=0 is equivalent to existence
through W_(m+3), with all later choices and whole repairs allowed.

If every S_m is surjective, a compatible formal marked tower exists
above the fixed W_(m0). If every S_m is also injective, the formal
tower is unique in the specified marked category, provided compatible
identifications are unique. The construction preserves W_(n-3)
when producing length n and may change the last two digits of a
previously chosen length n-1 tuple.

The groups and maps may depend on height and reached prefix.
Neither field-linearity, dimension bounds nor a fixed secondary map
is needed. Surjectivity and injectivity concern the actual chosen
points. In an oper application, complete relative elimination gives
T_m=ker R_m and Q_m=O_m/im R_m; full primary solvability and whole
regularity must establish the stated iff obstruction before this
criterion can be applied.

[Human-readable proof](../../Proofs/deformations/marked_obstruction_torsors.md).
