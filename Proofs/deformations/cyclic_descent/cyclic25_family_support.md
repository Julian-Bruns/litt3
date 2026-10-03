# The explicit cyclic-25 family for uniform descent

[Uniform descent theorem](../../../Theorems/deformations/cyclic_descent/cyclic_power_descent.md).
This example verifies nonemptiness of its hypotheses; it is independent
of the uniform comparison proof.

Over bar(F5), let

    Delta=(t^5-t)(t²+2t+3)(t²+2t+4)!=0,
    R=u(u-3), S=(u-1)(u-2)(u-t), F=RS, H=t²+2t+3.

Use smooth projective models

    Y:v²=F,
    C:k(u,kappa,gamma), kappa²=R, gamma²=S, v=kappa*gamma,
    E:gamma²=S.

The original C→Y is a connected etale double and g(C)=3; C→E is
ramified quadratic. The elliptic curve E is ordinary because its
Hasse coefficient [u4]S²=H is nonzero. Pull back V²:E^(25)→E to C:

    T=C×_E E^(25) →h C.

Over the algebraically closed field, ordinary elliptic Verschiebung
has cyclic kernel of order25. The ramified quadratic and etale
25-extensions are linearly disjoint; hence h is connected finite
etale cyclic25 and g(T)=51. The involution over Y acts by [-1] on
the elliptic cover and reverses translations, giving the actual
etale D50 map T→Y.

Its first cyclic-five intermediate has equation

    w5-Hw=gamma(u+4-2t).

For a direct etaleness check at elliptic infinity put z=u/gamma.
The right side is the affine part of z^-5-Hz^-1; the remainder is
regular of positive valuation. Thus w_O=w_U-z^-1 gives a regular
equation there, while its affine derivative is -H. The nonzero
H1(O_E) class z^-1 proves connectedness. The involution is explicitly
(kappa,gamma,w)↦(-kappa,-gamma,-w).

On Y retain the established active connection

    G=u(u-1)(u-2)(u-3), A=(t+1)²G, a=A/F²,
    r=3a''/a+(a'/a)², eta=du/v,

in the scalar convention U''=rU, with actual flat periodicity line
O_Y(W_t-O). The [genus-two active-twist theorem](../../projective_connections/genus_two_active_twists.md)
and [bad-double operator](../abelian_covers/bad_double_cubic_defect.md) give
ordinariness on Y and the five-bijective-plus-one-zero operator on C.
The canonical ordinary Y tower lifts the original etale covers and
their full tuple, supplying the required compatible reference.

For completeness the first cyclic-five source defect is certified on
exactly Delta!=0. In the D0=eta^-1 and kappa D0 frames, the two-chart
normal lattices are z² and z4; their Cech representatives are respectively
(z^-1,z) and (z^-1,z,z²,z³). Five AS powers give the actual30-dimensional
upper cohomology. Its Psi multipliers are A and A R². The original
gluing retains w_O=w_U-z^-1 and the displayed equation for w_U5.
The [generic matrices](../../../../litt3-computation-data/legacy_workspace_computations/bad_double_dihedral5_defect_generic.json)
and [their construction](../../../scripts/deformations/cyclic/bad_double_dihedral5_defect.sage)
have block ranks10 and18, with all larger minors identically zero and
the following nonzero minors:

    det10=(t+3)^5(t+4)^5(t+1)^20 H^20,
    minor18=2 t8(t+2)^8(t+3)^8(t+4)^8(t+1)^43
              *(t²+2t+4) H^32.

They prove defect2 on the stated open set. The
[cyclic-tower theorem, Section3](../section_growth/symplectic_p_cover_section_growth.md)
propagates the first defect2<5 to the full cyclic25 source: the
nil module length below5 is unchanged by higher cyclic base change.
Thus this family satisfies every hypothesis, with no new exceptional
parameters. No new150-dimensional computation is required.
