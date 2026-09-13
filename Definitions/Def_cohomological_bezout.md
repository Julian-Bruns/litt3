# Cohomological Bezout conventions

Let C be a smooth projective connected curve of genus g over an
algebraically closed field of arbitrary characteristic. Let V have rank2
and degree2g-2, and T be a line bundle. Set

    M=det(V) tensor T^-1,   A=H0(V tensor T^-1).

Assume H0(T)=0, H1(M)=0, and that A surjects onto the restriction of
V tensor T^-1 to every effective divisor of length2. Write

    n=h1(T)=h0(M),          r=h0(V)=h1(V).

A section u in A determines a_u:T->V and
b_u:V->M by b_u(v)=u wedge v. These maps are linear in u and b_u a_u=0.
For nonzero u, D_u denotes its zero divisor as a rank-two section:
locally its multiplicity is the minimum of the valuations of the two
coordinates. The section is admissible when D_u=0.

For admissible u the complex is a short exact sequence

    0 -> T --a_u--> V --b_u--> M ->0.

Its class eta_u lies in E=H1(T tensor M^-1). Scaling u by c scales
eta_u by c^-2. The connecting map is cup product

    K(eta_u):H0(M)->H1(T).

Our Cech convention is d(h_U,h_O)=h_O-h_U, so that if
d h=a_u xi, then the connecting map sends b_u h to xi.
Use ordinary section coordinates u in this definition. The fixed-curve
scalar coordinates U are their coefficient Frobenius twist, NOT their
degree-five pullback as independent polynomial variables.
