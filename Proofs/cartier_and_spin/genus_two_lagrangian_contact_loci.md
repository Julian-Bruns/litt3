# Proof: primitive equations for the two endpoint tests

Use the coordinate-independent primitive Wronskian isomorphism and
quadratic normalization established in the
[degree-one plane proof](backup_degree_one_cartier_planes.md),
section2. That proof's nonisotropic census is not a census of the
zero-norm locus considered here.

For a Lagrangian plane P in B, its Pluecker line has zero contraction.
After dividing by omega its source is M=det(P)omega^-1. It lies
in the primitive summand, and decomposability says exactly Q=0.
Conversely a nowhere-zero primitive line of norm zero is a
decomposable Pluecker line, hence defines a unique saturated
Lagrangian plane. These operations are inverse and retain embeddings.

By adjunction a nonzero map j:M->F_*omega_Y^-2 is a map
F^*M->omega_Y^-2. For deg M=-1 its zero divisor has degree one;
for deg M=-2 it has degree six. If all multiplicities of that
divisor are less than five, the map j is saturated: a zero on C
would contribute a multiple of five to the adjunction divisor.
Thus the stated divisor conditions make decomposability an
everywhere regular Grassmannian construction.

It remains to verify the evaluation orders, not just determinant
degrees. Locally B has exact-form basis dt,t dt,t^2 dt,t^3 dt
over O_C. A saturated plane admits horizontal generators whose
evaluations have distinct leading orders a<b in {0,1,2,3}.
The Wronskian has leading order a+b-1, since b-a is nonzero
in characteristic five. These are exactly the local zero orders
of the adjoint primitive Wronskian section; the canonical-line
frame divided out in the primitive identification is a unit.

Wronskian order zero forces(a,b)=(0,1). Order one forces(0,2).
Order four forces(2,3). Therefore a degree-one zero divisor gives
surjective evaluation with exactly one simple second-fundamental
zero. The canonical second-line construction has adjunction twice
that divisor and is saturated, since2<5.

For divisor4P+Q1+Q2, the unique order pair at P is(2,3), and at
each Q it is(0,2). Hence the evaluation base is exactly2P and
the residual Wronskian is Q1+Q2. Evaluation gives an extension
of two degree-zero lines in F^*S. Every further Frobenius pullback
is likewise semistable; semistability descends through Frobenius,
so S is strongly semistable. Conversely the stipulated common
base and simple residual branch give exactly that raw divisor.

The first implication for an actual span uses the endpoint plane
Pi constructed in [the double-zero contact proof](double_zero_orbit_contacts.md).
The second applies directly to the isotropic orbit plane S.
No existence, dimension or finiteness of either endpoint parameter
locus is assumed. In particular M cannot be silently specialized
to O(-p) or O(-2p), nor can its five-primary choices be discarded.
