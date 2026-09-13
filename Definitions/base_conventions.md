# Base conventions

ID: `base_conventions`.

The principal problem is over k=the algebraic closure of F_5. A theorem
may explicitly use another algebraically closed field or characteristic;
its stated hypotheses take precedence over this default.

A curve is smooth, projective, geometrically connected, and one-dimensional,
unless stated otherwise. All covering maps discussed in the main problem
are finite, surjective, and etale. Hyperbolic means genus at least two.
Write omega_C for the canonical line bundle, J(C)=Pic^0(C), and
kappa_C=2g(C)-2. Divisors are integral divisors on a curve, unless a
stack divisor or rational coefficient is explicitly specified.

`C^(1)` means scalar twist by absolute Frobenius of k, not an assumed
k-isomorphism C≈C^(1). F_C:C→C^(1) is relative Frobenius. Its differential
is zero; it must not be used as a separating or etale map.

When a finite-field model is specified, Frob_q on an abelian variety
denotes the q-power Frobenius endomorphism, acting on geometric points
by raising their coordinates to q. A rational function is *separating*
when its differential is nonzero, equivalently its induced curve map
is generically separable.

Every algebraic point of an abelian variety over Fbar_p is torsion.
This standard finite-field fact must NOT be transferred to points over
a transcendental moduli function field.
