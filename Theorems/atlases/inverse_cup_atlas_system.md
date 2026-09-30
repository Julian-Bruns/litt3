# Three inverse columns give the complete atlas scheme

Version7, 2026-09-23. All18 representative types, exceptional cohomology
and inverse/minor formulations are retained. The underlying
characteristic-free inverse mechanism is now in
[cohomological Bézout](cohomological_bezout.md).

Fix any geometric dormant oper on the chosen genus-nine curve. Put
V=W(8O), T=omega^-1, M=omega², n=24, and r=h0(V)=0 or3. In coefficient
Frobenius coordinates let

    D(U)=[B(U) q(U); a(U) 0]

be its (n+r)-square Bézout matrix. B is quadratic, a and q linear.
Use beta∈A* and eta=i^-1(beta)∈J from the compact atlas system, and
write Gamma(beta)=K(eta)^[5], a fixed linear function of beta^[5].
The top-left block of D^-1 is the normalized cup matrix, of rank n-r.
For r=3 this block has rank21; it is D, not that block, which is invertible.

## Complete selected-column equations

The fixed subspace `S=<y,x^10,x^4 y²>⊂L32` has S·L32=L64. Let Q_S select
columns(4,21,23) of the pole-ordered basis. Put Dtilde(v) equal to the
coefficientwise fifth root of D, with U replaced by v; let Gammatilde(b)
root the linear map beta^[5]->Gamma and apply it to b. Define s(v,b)
by coefficientwise rooting the ENTIRE projected compact R tensor.
With an r by3 auxiliary block Z, the equations

    Dtilde(v) [Gammatilde(b) Q_S; Z]=[Q_S;0],
    b=s(v,b)^[5]                                           (C)

define the full finite reduced untwisted atlas scheme. Its map to the
original compact presentation is U=v^[5], beta=b. Z is unique. There
are no additional N equations, normalizations or nonvanishing conditions.
No boundary or normal-corank stratum is discarded.

The sizes are72 inverse plus32 R equations in64 variables for r=0,
and81 inverse plus32 R equations in73 variables for r=3. Retain all9
entries of Z in the latter case. Inverse equations have degree at most3.
All32 original projected R equations are required; a few selected
inverse entries or necessary rank conditions alone are insufficient.

## Equivalent full inverse and minor presentations

With `G=[Gamma X;Y Z0]`, the unrooted criterion is

    D(U)G=I_(n+r),
    beta_i+Tr(G partial_i D)=0,  i=1,...,32.                 (I)

The inverse determines X,Y,Z0 uniquely, forces admissibility and gives
U.beta=2. The trace includes `Tr(Gamma partial_i B)`,
`Tr(X partial_i a)` and `Tr(Y partial_i q)`; the mixed terms are essential.
Rooting all coefficients and inverse-block entries gives the equivalent
full rooted criterion

    Dtilde(v) Gtilde=I,  b_i=t_i^5,
    t_i=-Tr(Gtilde partial_i Dtilde),  v.t=2.                (R)

Here v.t=2 follows from the equations; it need not be imposed. The
inverse equations are cubic and t is quadratic. This is the full
normalized scheme, not a quotient chart with b_j=s_j=1.

In Serre-dual bases a=q^T. On any open det(q0)!=0, selecting r rows I
of q and ordering them last, put m=n-r,

    P=[I_m;-q0^-T q_top^T],  Bbar=P^T B P,
    Z1=Gamma_(I^c,I^c).

Bbar is symmetric and det D=(-1)^r det(q0)^2 det(Bbar). The complete
criterion in the original64 variables is

    Gamma q=0,  Bbar Z1=I_m,
    beta_i+Tr(Z1 partial_i Bbar)+2 partial_i det(q0)/det(q0)=0. (S)

All minor opens are retained. For r=3 this uses a21-square block and
a3-square minor; r=0 recovers B Gamma=I_24 and its gradient. The general
two-minor version, with independent a0 and q0 and both logarithmic
terms, is supplied by the Bézout theorem. Clearing denominators while
forgetting the named open changes the criterion.

## Boundary rank

In the characteristic-free stable extension setup, a nonzero section u
with zero divisor E>0 satisfies

    ker N_u=ker[H1(L^-2)->H1(L^-2(E))],  dim ker N_u=deg E.

Its cup matrices have rank at most deg E, including multiplicities and
zeros at infinity. On the fixed curve deg E<=23, so invertible cup removes
invalid quotients on the acyclic branch. The augmented D handles both
cohomology profiles.

The acyclic rational-pencil construction and all304,128 first-oper
coefficient comparisons are retained in the Bézout proof. No full
exceptional B tensor or whole-oper exclusion is asserted.

[Proof](../../Proofs/atlases/inverse_cup_atlas_system.md).
