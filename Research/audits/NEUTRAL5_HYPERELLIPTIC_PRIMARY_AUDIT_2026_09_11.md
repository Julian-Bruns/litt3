# Same hyperelliptic cover and primary repair: bounded audit

Verdict: PASS. Auditor: `/root/audit_backup_cored_completion`.
Date: 2026-09-11. Prose and exact finite-field audit, not Lean verification.
No W4 obstruction or higher continuation claim is made.

Audited sources are `scripts/construct_neutral5_hyperelliptic.py` and
`scripts/prepare_neutral5_w4_input.py`, with their two JSON receipts.
The independent replay `scripts/audit_neutral5_hyperelliptic_input.py`
imports neither source and never calls an elliptic multiplication map,
isogeny routine or square-root finder. It checks the displayed polynomial
identities directly in the exact coefficient field.

## 1. Rational map and complete etaleness check

Use the same t, genus-two C, H=t^2+2 and mu=4+4t as in the previous
[D10 audit](EXPLICIT_NON_GALOIS_NEUTRAL_FIVE_AUDIT_2026_09_11.md).
The frozen polynomials N,d,J satisfy

    deg(N,d,J)=(5,2,6), D=d^2, gcd(N,d)=1,
    S5=s^3-t^5*s^2+s-t^5,
    J^2*S5=N^3-t*N^2*D+N*D^2-t*D^3.

S5 is squarefree. The degree-thirteen polynomial

    G=N(N-D)S5

is squarefree, and gcd(d,G)=1 with d itself squarefree. Thus

    T: Y^2=G(s),
    u=q(s)=N/D,  v=JY/d^5

defines a nonconstant map to the original genus-two equation. Its full
rational identity `v^2=q(q-1)(q-2)(q-3)(q-t)` is checked directly.
The field degree is 5: `[k(T):k(q)]=10` and the embedded genus-two field
has degree 2 over k(q). The source is smooth projective of genus 6.

For the exact signs chosen in the frozen receipt, the differential is

    h*(du/v)=c*d^2*ds/Y,  c=-(t^2+2)=3+4t^2 != 0.

This proves separability and also verifies etaleness at EVERY point.
The two simple roots of d each give two distinct nonbranch points of T,
and infinity gives the fifth preimage of the original infinity. At all
five points q has pole order 2, so the map has local degree 1 there.
Since `div(ds/Y)=10*infinity_T` and d has four simple finite zeros and
pole order 4 at infinity,

    div(c*d^2 ds/Y)=2*(the five preimages of infinity_C)
                  =h*div(du/v).

The ramification divisor is therefore zero. This is a direct curve and
differential verification, not an inference from the label Verschiebung.

## 2. Exact identification with the OLD Artin-Schreier cover

There is an explicit stronger check than uniqueness of an elliptic
degree-five cover. Write `E5: y^2=S5`, and put

    B0(s)=(2+3t+3t^2+2t^3)s+(3+t+2t^2),
    B=lambda*B0,  lambda^4*(t^2+2)=1.

Then the original affine AS coordinate is EXACTLY

    w_U=y*B/d,
    u=N/d^2,  ell=Jy/d^3.

The audit constructs B by solving a linear system in four coefficient unknowns
and then checking the two required coefficient-Frobenius equations.
The final identity is

    S5^2*B^5-B*d^4=lambda^5*J*(N-2t*d^2).

Consequently

    w_U^5-w_U=lambda^5*ell*(u-2t),

which is precisely the old affine AS equation for R=u(u-1), not merely
another cyclic cover of the same elliptic curve. The old overlap is
also retained:

    w_O=w_U-lambda*ell/u
        =y*(B*N-lambda*J)/(d*N).

The numerator is divisible by d and has degree at most 5; the resulting
quotient has degree at most 3. Thus w_O is regular at the d-roots and
at infinity, and its only possible finite poles lie over N=0, which the
old infinity chart excludes. Its AS equation follows by substitution.
This verifies the actual two-chart identification, including its sign.

To identify the quotient, set K=kappa*d^2. On the common D10 closure,

    K^2=N(N-D), y^2=S5, w_U=yB/d.

The original reflection is `(K,y)->(-K,-y)`. Its invariant generator
Y=Ky gives exactly `Y^2=N(N-D)S5` and `v=JY/d^5`. Hence the frozen
hyperelliptic model is the SAME R=u(u-1) quotient cover of C. No [5]
black box, guessed monodromy group or non-explicit uniqueness assertion
is required for this identification.

## 3. Particular primary repair and both involutions

The thirty cohomology coordinates are those of the previous full audit:
w_U^j times `(v/u,v/u^2,v/u^3,ell/u,kappa/u,ell/u^2)`.
The six nonzero particular coefficients are verified to be

    xi_0=4+4t+t^3,
    xi_1=1+3t^3,
    xi_10=(t+2)lambda^3,
    (xi_12,xi_13,xi_14)
       =lambda^2(2+2t+4t^3)*(1,4,4+t+3t^2).

The pulled-back base kernel is

    k_C=(1,4,4+t+3t^2,0,...,0).

Independently converting the inherited reference obstruction from
z=u^2/v to the Laurent-u basis gives

    rho_u=(rho_-3, rho_-1-(t+1)rho_-3, rho_1+(t+1)rho_-3).

The required coordinate conversion is checked from the curve relation
through the necessary orders; in particular v/u^2=z^(-1) exactly.
With M the already independently audited actual Hodge matrix, the new
replay checks the FULL equalities

    M*xi^[5]=(rho_u,0,...,0),  M*k_C^[5]=0.

The residue pairing still equals mu^(-1), so the lower reference
obstruction and its orientation have not been replaced. In the original
tau-positive block M has rank 14. Thus the whole primary compatible
curve-digit family is `xi+b*k_C`, for b in k.

The old reflection has coefficient sign `(-1)^(a+b+j)` on
kappa^a ell^b w^j. The hyperelliptic involution is kappa->-kappa,
ell,w fixed. Because eta=du/v also changes sign, its tangent-coefficient
sign is `(-1)^(a+1)`. The replay checks that xi and k_C are positive
for BOTH actions, and that the hyperelliptic-positive subspace of the
fifteen-dimensional quotient tangent space has dimension 11. Hence
the stated invariance holds for every b, not merely sampled coefficients.

The new receipt additionally substitutes the exact same-cover formulas
to transport xi and k_C into rational coefficients of d/ds. These use
the inherited pulled-back open cover; they have not yet been reduced
to a standard genus-six cohomology basis. All their coefficients lie
in F625, which is checked explicitly despite the auxiliary lambda lying
in F_(5^16). These rational functions are useful input for the next
calculation, not a computation of its obstruction.

## Receipt

`Research/computations/neutral5_hyperelliptic_primary_audit.json`,
runtime 0.22 seconds after Sage startup. Replay:

```sh
OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 sage -python scripts/audit_neutral5_hyperelliptic_input.py --output /tmp/neutral5-primary-audit.json
```

SHA256:

    model input: d9d1cc7791ae49bf617e43c051ea1b87f3d45800fa7e6c994a5df18dfc900729
    primary input: b6b81765c2b56775fd35f474ec30415b65a2247974b5a3c855cb9b1b634ae987
    audit source: 60f3685e9903be3f0f0791c14b3a5a586a41317d8c8ec4d2b52fd8b4d69f84ad
    audit receipt: 5066041930cc64589447e02c10beb576444893325cdcad996843e3f62dfdd23a

No objections remain to these exact characteristic-five and primary
repair claims. The identity of higher-Witt lifts, existence of a W4
extension and any full-tower conclusion remain outside this audit.
