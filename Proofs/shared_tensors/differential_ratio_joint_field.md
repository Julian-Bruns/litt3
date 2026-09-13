# Proof: rational Cartier recovery and two cyclic exclusions

[Statement](../../Theorems/shared_tensors/differential_ratio_joint_field.md).
Author /root,2026-09-08; generalizes the returned Pro proof.

Use the usual semilinear Cartier operator C(a^5 alpha)=a C(alpha).
It commutes with separable function-field inclusions and k-automorphisms:
a separating parameter remains a p-basis, so its expansion over fifth
powers computes Cartier in both fields. This assertion concerns rational
differentials and does not require regularity at any omitted point.

## Intrinsic recovery

Write F=sum f_j x^j and

    ell(x)=sum_(i=0)^(r-1) f_(5i+4)^(1/5) x^i.

Since theta=y^(-5)F dx, Cartier extraction gives C(theta)=ell dx/y.
Consequently q=C(theta)/theta=ell y and

    T=dq/theta=ell' F+(ell/3)F'.

The unique point O at infinity has pole orders3 for x and5r for y.
Our leading-coefficient assumption gives deg ell=r-1, hence q has
unique pole8r-3. Since r-1!=0 in k, ell' F has degree6r-2. The other
term has degree at most6r-3: the derivative of x^(5r) is zero. Thus
T has unique pole18r-6. The gcd of these integers divides3, by
9(8r-3)-4(18r-6)=-3; it is1 because3 does not divide r. The extension
[k(X):k(q,T)] divides both function degrees and is therefore1.
If theta descends to a separable intermediate field, q and T belong
to that field, proving rational recovery of k(X).

For Y, eta recovers u=(C(eta)/eta-c0)/c1 and v=du/eta. The displayed
Cartier formula always has degree at most one for a degree-five model,
by eta=v^(-5)P²du; the hypothesis is exactly its nonconstant coefficient.

## Recovering M from x and delta

Let N=k(x,delta) and E=N(y). Theta and then eta=delta theta descend to
E, so the preceding recovery shows E=M. If E!=N, the Kummer extension
has degree3, with sigma(y)=zeta*y and sigma fixing x,delta. Hence

    sigma(eta)=zeta*eta,
    sigma(C(eta)/eta)=zeta*C(eta)/eta,

because zeta^(1/5)=zeta². It follows that sigma(u)=zeta*u+
(zeta-1)c0/c1 and sigma(v)=v. This is a nontrivial order-three
automorphism of k(Y) fixing v. But v has a unique pole of order5,
so [k(Y):k(v)]=5. Artin's fixed-field theorem would make3 divide5,
a contradiction. Thus M=N.

Now let N=k(u,delta), E=N(v). Rational recovery from eta and
theta=eta/delta gives E=M. If E!=N, its quadratic involution tau has
tau(theta)=-theta, tau(q)=q and tau(T)=-T. Thus it restricts to a
nontrivial involution of k(X)=k(q,T) fixing q. This would make2 divide
[k(X):k(q)]=8r-3, which is odd. Again E=N.

All intermediate fields above are separable under K: the first contains
the separating parameter x and the second contains u. No descent of a
rational differential through a purely inseparable inclusion was used.

## Etale quotients, divisors, and spin probes

An intermediate field in a finite etale cover of smooth curves again
gives finite etale maps: all ramification indices and differents vanish
in the intermediate tower. Applying this to M for each actual leg
retains both maps. Tame Hurwitz for the trigonal model gives g(X)=5r-1.
The differential theta has divisor(10r-4)O_X, while div(eta)=2O_Y.
Etale Hurwitz and pullback give all stated degree and divisor formulas.
Poles of delta have orders10r-4 or10r-6, respectively at T minus U
and T intersect U. These are1 or4 modulo5. T is nonempty, so delta
cannot be a fifth power and is separating.

The four probe ratios generate k(x,w); since w²=delta this equals
M(w). Its normalization is an intermediate field between M and K,
so every resulting map is etale. Div(e0)=(5r-2)f*O_X identifies L
with the pullback of O((5r-2)f_w*O_X). The square is the one supplied
by theta. On the quotient, w times its canonical section is regular
because div(w)=U-(5r-2)T. The same holds for x and x² times that section.
This proves exactly the claimed descent and no statement about additional
sections. The ratio image may be singular and the four sections may
have common zeros; neither affects its normalized function field.

For the selected F, r=2 and ell=(a+1)(x+2), recovering the Pro values
13 and30. For the family Y_t, direct expansion gives c1^5=3(t+1),
nonzero whenever t^5-t!=0. Thus both current endpoints satisfy the
theorem, but the conclusion alone does not exclude a common cover.
