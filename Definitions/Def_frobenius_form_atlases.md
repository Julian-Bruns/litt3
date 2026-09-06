# Frobenius-form atlas data

ID: `frobenius_form_atlases`. Work over an algebraically closed field of
characteristic five. F_C is absolute Frobenius and omega=omega_C.

A nonsingular, line-valued Frobenius form on a rank-three bundle E is
an O_C-linear pairing beta:E tensor F_C^*E -> M, for a line bundle M,
whose adjoint F_C^*E -> E^vee tensor M is an isomorphism. No symmetry
condition on a matrix over O_C is imposed. In frames its polynomial is
v^t A v^(5), with A invertible. 'Nonsingular' is stronger than injectivity.

Projective frames carrying this polynomial to the standard polynomial
X_0^6+X_1^6+X_2^6 form a finite etale PGU_3(5)-torsor. The resulting
projective connection is the one trivial in these frames. Its second
fundamental map on a line L is independent of scalar choices of an
ordinary connection lifting it.

For an isotropic sub-line-bundle L, put
K_L=ker(E -> (F_C^*L)^vee tensor M). Then L is contained in K_L.
The second fundamental map lands in (K_L/L) tensor omega. We call the
data transverse if this map from L is an isomorphism everywhere.

Normalized data replace (E,M,L) by
(E tensor L^-1, M tensor L^-6, O_C). The distinguished section e of the
normalized E is the original inclusion of L. It is nowhere vanishing.

Let K_C denote the middle bundle of a nonzero extension
0 -> O_C -> K_C -> omega^-1 -> 0. Since H^1(omega)=k, its isomorphism
class as a bundle with distinguished subline is unique, allowing scalar
change of the quotient identification. Whenever a specific extension
class is used, its inclusion and quotient map are part of the data.
