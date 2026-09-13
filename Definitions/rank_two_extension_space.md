# Rank-two extension-space conventions

Let C be a smooth projective connected curve of genus g>=2 over an
algebraically closed field of ANY characteristic. Let W be a stable
rank-two bundle with fixed determinant identification det W=O_C.
Let L be a line bundle of degree ell>2g. Write

    A=H0(W tensor L),              dimension2ell-2g+2,
    B=H0(W tensor L tensor omega), dimension2ell+2g-2,
    H=H0(L^2 tensor omega),        dimension2ell+g-1,
    E=H1(L^-2)=H^vee.

The open admissible subset of P(A) consists of nowhere-zero sections u.
Such a section, by determinant pairing, gives

    0 -> L^-2 --u--> W tensor L^-1 --det(u,-)--> O_C -> 0.

Its extension class eta_u is the image of1 under the connecting map
H0(O_C)->H1(L^-2). Thus eta_(c u)=c^-2 eta_u.
The associated linear matrix pencil is the determinant multiplication

    M_u:B->H,             w |-> det(u,w),

and its Serre dual N_u:E->B^vee. A primitive polynomial kernel vector
means a homogeneous vector e(u) with polynomial entries having no common
nonconstant factor and N_u e(u)=0. It is unique up to scalar when the
generic kernel is a line. These un-twisted u coordinates are not the
scalar Frobenius coordinates U of the fixed-curve computation.
