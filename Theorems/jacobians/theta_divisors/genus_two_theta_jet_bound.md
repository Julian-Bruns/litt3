# Sharp theta jet bounds on a genus-two Jacobian

Version1. Independently audited.

Let A be the Jacobian of a smooth genus-two curve over an algebraically
closed field of characteristic different from2, and let Theta be its
principal theta class. If a line bundle T has numerical class rTheta,
r>0, then every nonzero section satisfies

    ord_b(s) <= floor(3r/2)       for every b in A.

Thus jets of total order floor(3r/2) at ANY one point injectively
determine H0(A,T). These are Hasse jets, not ordinary derivatives.

For r=4m the bound6m is sharp among all line bundles of this numerical
class. For a Weierstrass point w put i_w(P)=[P-w] and define
B_b=t_b([2](i_w(C))) with its reduced image structure. This is
independent of w. Equality ord_b(s)=6m occurs exactly
when div(s)=m B_b. The space of sections with order at least6m is
therefore at most one-dimensional for any fixed T.

## Actual two-map Raynaud family

Let X<-f-Z-g->Y be ANY actual finite bi-etale span over an algebraically
closed field of odd characteristic p, with Y of genus2 and m=deg g.
Form the determinant-of-cohomology section sigma on
J(X^(1)) times J(Y^(1)) for B_Z tensor f^(1)*L tensor g^(1)*M.
Here B_Z=coker(O_(Z^(1))->F_(Z/k)*O_Z) and delta is the generic
dimension of this section space on Z^(1).
Its restriction in the second direction has numerical class

    rTheta_Y,       r=(p-1)m.

At any fixed M0, sigma is identically zero exactly when its full
relative Hasse jet of order 3(p-1)m/2 along JX times {M0} is zero.
This detects generic mixed vanishing in arbitrary cover degrees,
without ordinariness, joint minimality or Hom-zero. In characteristic
five the bound is6m, improving the returned8m test.

If Hom(JX,JY)=0, the determinant line is an external product TX⊠TY.
Writing the jets as coefficient sections on JX gives

    delta=0 iff some sigma_ij!=0 with i+j<=6m             (p=5).

The second-variable section space has dimension16m^2. If sigma is
nonzero but all coefficients below degree6m vanish at M0, then
sigma is a decomposable tensor s_X tensor s_Y and div(s_Y)=m B_(M0).

These are exact finite tests, not a nonvanishing theorem. No bound
on the unknown degree m or common-cover exclusion follows.

[Proof](../../../Proofs/jacobians/theta_divisors/genus_two_theta_jet_bound.md).
