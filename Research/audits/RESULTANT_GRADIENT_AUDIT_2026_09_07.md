# Bounded major-proof audit: resultant-gradient identity

- Verdict: PASS, conditional on the stated canonical prerequisites.
- Auditor: fresh bounded agent `/root/resultant_gradient_major_audit`.
- Date: 2026-09-07.
- Object: `Solutions/Sol_resultant_gradient_atlas.md`, global identity
  `i(R_U e(U)) = -d Delta(U)` for each fixed geometric dormant oper.
- Remaining objections: none. The clarification below concerning the
  Frobenius twist should be retained when making the canonical statement.
- Scope: independent prose audit of this new identity and its displayed
  consequences; not a full re-audit of Litt3 or formal verification.

## Inputs and review

Read the proposed proof completely, together with the canonical statements
and relevant proofs for `rank_two_extension_pencil`,
`dormant_differential_projection`, `direct_wronskian_atlas`, and
`wronskian_matrix_pencil`, and the scalar principal-part definitions.
The audited differential projection and direct criterion were accepted as
inputs. The primitive kernel construction and its generic rank at one-zero
sections were inspected because they are essential to this new argument.
No experimental line identity is used as a proof of the global assertion.

## Resultant and coordinate convention

Stability gives the asserted vanishing for subschemes of length at most
seven: the Serre-dual bundle has slope `-8 + length < 0`. In particular
evaluation and first jets are sufficient to show that the incidence is an
irreducible divisor, with a generic section having exactly one simple zero,
and with an unramified incidence projection there. Two distinct zeros or a
double zero give proper smaller strata by the length-two evaluation bound.
Intersecting with a general pencil gives the top Chern number
`deg W(24O) = 48`. The reduced resultant therefore has degree 48.

The coefficient-Frobenius passage here must mean the coefficient twist of
this incidence and its reduced equation. Explicitly, if its old homogeneous
equation is `F(u)`, the equation in scalar coordinates is `F^[5](U)`, where
only coefficients are raised to the fifth power and `U_j = u_j^5` on
geometric points. It has degree 48 and is irreducible over the perfect
field. Pulling this equation back along the Frobenius map instead produces
`F(u)^5`, of degree 240; that is a different operation. The proof's stated
degree-preservation convention, together with the canonical pencil proof,
uses the former operation and is correct.

At the generic one-zero section the pencil retains rank 55 and the primitive
kernel vector is nonzero. The affine reconstructed T is horizontal and its
Wronskian constant; this uses only N=0, not Wronskian normalization. Both U
and delta U vanish at the finite zero, so Delta vanishes. On the nowhere-zero
locus the injectivity of the kernel Wronskian makes Delta nonzero. Since its
degree is 48, it is a nonzero scalar multiple of the reduced resultant.

## Boundary representative

Wronskian zero gives `T/U = h^5` in the function field. At a simple zero of
the descended section, scalar U has order 5 or 6. At its other finite scalar
zeros, U has order 1 because the descended section does not vanish there.
Affineness of T therefore allows only a simple finite pole of h, at P.
If it had no such pole, h would be affine, and
`val_O(eta+h) >= 48` would force the P48 representative eta to vanish,
contradicting the nonzero kernel generator. The bound at O is at most 17.

The replacement eta by -h is justified by exactly that valuation bound.
The local gauge correction to R is a Laurent algebra identity: it does
not require an invertible horizontal two-column frame or Wh=1. It remains
valid at Wh=0. After replacement V=0 and lambda=rho32(delta h).
Although delta h has a finite pole at P, its affine reduction at O is by
definition an affine polynomial. Thus replacing rho32(delta h) by delta h
changes `U lambda^5` by an affine polynomial plus a series of valuation
at least `-112 + 5*32 = 48`. This proves the displayed representative (1).
Its residue pairing can then be transferred from O to P with exactly the
sign in (2). There are no other finite poles.

## Local calculation and continuation

In the chosen horizontal coordinate, the canonical local expression for Q
gives `partial_z^3 H = u0^10(C^5+zD^5)`. Since u0^10 has only exponents
divisible by 5, its nonconstant terms do not affect the constant and linear
coefficients. The differentiation constants are `3! = 1` and `4! = 4` in
characteristic 5, yielding precisely the two displayed coefficient formulas.

Likewise the principal part of `(delta h)^5` is
`-c^5 u0^-10 z^-10`. Multiplication by U and theta leaves only the z^3
and z^4 coefficients of H in the residue. The result is
`c^5(a(0)^5 D(0)^5-b(0)^5 C(0)^5)`, which is minus Wh(Z,T)(P).
All omitted coefficient series begin sufficiently high (in multiples of
five) to make no contribution to this residue.

Differentiating Delta in any scalar direction Z is legitimate because
T(U) is polynomial in U and affine as a curve function. Thus dT is regular
at P, and Wh(U,dT)(P)=0. Equality of the two covectors holds on a dense
open subset of the reduced irreducible degree-48 divisor. Each difference
coordinate has degree 47, so divisibility by that equation forces it to
vanish identically. No smoothness of the whole divisor, logarithmic
extension, or normality assertion is needed.

Euler gives `i(B)(U)=-48 Delta=2 Delta`. The normalization e/Delta therefore
makes the atlas equation exactly `B^[5]=Delta^4 e` on Delta nonzero, and
the R-output cannot vanish there. In this open locus the quotient is
nowhere zero, so the infinity pole conditions 111 or 112 are retained.
At a normalized atlas the displayed scalar condition `i(eta)(U)=2` follows.
These conclusions do not exclude the remaining incidence or solve Litt3.
