# Proof: homogeneous coordinates and one unit in the census algebra

[Statement](../../Theorems/atlases/cubic_oper_atlas_descent.md).
Use the [scalar data](../../Definitions/scalar_hermitian_data.md) and
[Q-frame presentation](alternating_forms/acyclic_alternating_atlas.md).
Write u=x^3/y for the local uniformizer, reserving t for c4; then
kappa=u^-17 and theta=dx/y^2.

## 1. The descent mechanism

Use the ring notation R->A of
[Stacks, Lemma35.37.1](https://stacks.math.columbia.edu/tag/0245).
For any F25-algebra R and lambda in R^*, the algebra
A=R[t]/(t^3-lambda) is a finite etale mu3-torsor. Equivariant affine
schemes over A therefore descend to R by that lemma.

Here the descent is explicit. If a coordinate x_i has character w_i,
then t^-w_i x_i is invariant. After this substitution, an equation of
character e has coefficients in t^e R; divide by this unit to obtain
its descended equation. Thus homogeneous coordinate and equation
rescalings recover the original scheme after base change, including
nonreduced schemes and split torsors. The remaining task is to verify
the characters for this atlas.

## 2. The actual scalar and local characters

The deck automorphism satisfies

    sigma(u)=zeta^-1 u, sigma(theta)=zeta theta,
    delta sigma=zeta sigma delta, sigma(kappa^5)=zeta kappa^5.

The affine ring and gap remainders are stable, so aff, rem and rho_n
commute with sigma. For P(t)=t^2 Ahat+(B+2x^8)y+t Chat*y^2,

    P(zeta*t)=zeta^2 sigma(P(t)),
    L_(zeta*t) sigma=zeta^2 sigma L_t,
    Q_(zeta*t) sigma=sigma Q_t.                         (1)

Set U'=sigma U, eta'=zeta sigma eta. With H=U eta^5,
V=rem H, T=-aff H and D=-rho32 delta, each of H,V,T,D eta
transforms by zeta^2 sigma. Consequently the raw outputs transform by

    N' = zeta^2 sigma N,       R' = zeta sigma R,

and Wh(U',T')=zeta^3 sigma Wh(U,T). Thus N=0, R=eta and
Wronskian1 are preserved, as are all pole bounds.

The compact normalization is preserved because Q_t h=U implies
Q_(zeta*t)(sigma h)=sigma U, and

    Res_O((zeta sigma eta)(sigma h)theta)
       =Res_O sigma(eta h theta)=Res_O(eta h theta).       (2)

This checks the local extension data as well as the differential equation.

## 3. A polynomial Q matrix over the normalized coefficients

Equation(1) gives

    M(zeta*t)=diag(zeta^k_r) M(t) diag(zeta^-j_i),

so t^(j_i-k_r) M(t)_(r,i) is invariant. To see that its expression in
lambda has no negative powers, decompose Q on h=x^i y^j as

    Q_B h=delta^3 h+((B+2x^8)y)delta h
                         +3delta((B+2x^8)y)h,
    Q_A h=Ahat delta h+3delta(Ahat)h,
    Q_C h=(Chat*y^2)delta h+3delta(Chat*y^2)h.

Their output characters are j,j+2,j+1 modulo3. Hence the normalized
column is exactly

    Q_B h+lambda^[j>=1] Q_A h+lambda^[j=2] Q_C h,         (3)

where a bracket is0 or1. This uses the original relation y^3=F and
derivation delta. Its entries have total degree at most2 in the23
normalized coordinates. Diagonal rescaling gives the stated minor identity.

## 4. Characters of the frame equations

The input coordinates v_i have character j_i by(1). Equation(2) makes
the residue pairing invariant, so its dual coordinates b_l have
character -k_l. Thus the invariant coordinates are precisely vhat,bhat.

For the acyclic97-equation presentation put f=x^2 y. Since
sigma(f^5)=zeta^2 f^5, the N row paired with f^(5s)h_i, s=0,1,
has character1-j_i-2s. The R row paired with h_i, including its right
side, has character -j_i. The compact normalization has character0.
These follow by moving sigma across the residue pairing in(2).

Section1 now applies row by row over K, giving the entire descended
scheme and bhat^T Ghat vhat=2. Negative powers of lambda can be
cleared because lambda is a unit. The same construction applies to
the169-equation raw-N presentation without acyclicity, using its raw
row characters.

## 5. A uniform frame from one finite-algebra unit

Take I,J from the statement. Formula(3) constructs their32-square
minor over the polynomial ring in the23 normalized coordinates.
Exact row and column operations use26 nonzero constant pivots and
leave a6-square matrix H, with

    det Mhat[J,I]=-det H,       degree H_(i,j)<=9.          (4)

These are polynomial matrix operations, independent of oper equations.

Specialize the same operations to the independently certified
[normalized oper algebra](../../Research/computations/normalized_oper_algebra_certificate.json),
R=F5[T]/(P), deg P=19290. Its twelve field factors encode the complete
noninvariant census. The F25 embedding, Ahat,B,Chat and lambda are
recorded in that certificate. Constant pivots remain units in R.

The [verifier](../../scripts/atlases/verify_cubic_oper_frame.py)
reconstructs(3) directly in the monomial bases and performs(4), while
applying the identical operations in R. It computes the final determinant
without division, by both subset and permutation expansion. The two
answers equal the retained polynomial d modulo P. It then checks the
polynomial identity d e+P f=1. Therefore d is a unit in R, proving the
same frame invertible at every geometric census point. The diagonal
rescaling in Section3 covers all three cubic branches.

```sh
sage -python scripts/atlases/verify_cubic_oper_frame.py
```

An optional `--output PATH` regenerates the certificate. The default
recomputes the matrix and checks the retained certificate without
writing files. Individual residue-field constructions and individual
orbit frame checks are unnecessary for this uniform conclusion.
