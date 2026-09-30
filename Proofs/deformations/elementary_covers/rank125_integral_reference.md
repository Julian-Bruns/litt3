# Proof: constant formal algebras and integral etale transport

[Statement](../../../Theorems/deformations/elementary_covers/rank125_integral_reference.md).
Version1,2026-09-14. The bounded
[independent audit](../../../Research/audits/RANK125_INTEGRAL_ETALE_REFERENCE_AUDIT_2026_09_14.md)
checks the marking, whole-root construction, regularity, two different
Taylor truncations, and the constant-algebra decomposition.

## 1. The normalized original double

Put R=u(u-3) and Q=(u-1)(u-2)(u-T). They are coprime modulo5.
Over Q invertible, adjoining y with y^2=Q is etale and kappa=v/y.
Over R invertible, adjoining kappa with kappa^2=R is etale and y=v/kappa.
These opens cover the affine base. At infinity

    kappa=epsilon*u*sqrt(1-3/u), y=v/kappa, epsilon=+1,-1.

The square root is a unit formal series, proving etaleness there too.
This is the original degree-two cover. The simultaneous v,kappa square
equations without normalization would have singularities at u=0,3.

For eta=du/v and D=eta^-1, direct differentiation gives the regular
affine formulas

    D(u)=kappa*y, D(kappa)=(2u-3)y/2, D(y)=kappa*Q'/2.

The base flat line O(W_t-infinity), represented on its own double by
w^2=u-T, remains part of the pulled oper. The different kappa double
does not authorize discarding that line.

## 2. Exact character charts and the whole formal roots

The listed characters are the original scaled characters in the retained
primary reconstruction. Direct fifth powering in the normalized residue
coordinate ring gives the FU polynomials in the statement. In each case
FO=FU-c*chi^5+chi has valuation1 at infinity. Hence the iteration

    RO^(0)=0, RO^(n+1)=c*(RO^(n))^5-FO                 (1)

converges z-adically to the unique solution in z*k0[[z]]. Uniqueness
also follows because a nonzero difference h=c*h^5 cannot have positive
valuation. The formula(1) specifies the WHOLE series, independent of a
chosen computational window.

Let a=Teich(c^-1) and consider the actual affine algebra

    A_U[W]/(W^5-aW-a*FU),                              (2)

where A_U is the normalized affine product-chart algebra. Its derivative
5W^4-a is a unit: its inverse is the finite nilpotent geometric series

    -a^-1 * sum_(j=0)^(m-1) (5W^4/a)^j.               (3)

Thus(2) is a finite etale affine algebra, not a meromorphic substitute.
The formal constant algebra R_m[S]/(S^5-aS) is also finite etale. Its
residue root S+chi+RO satisfies(2), by the defining FO equation. Hensel
lifting therefore gives a unique embedding of(2) into that formal
Laurent algebra with the specified residue. Newton iteration using(3)
is the executed formula for its whole root W_U.

Taking the tensor product for all three independent original characters
retains their degree125 cover. The residue W_O=S+RO is regular and
W_U-W_O=chi. These transitions identify the original cover and labels.
Finite etale lifting is unique over nilpotent thickenings, so gluing by
the lifted base overlap gives its canonical pulled reference. The formal
constant algebra is the algebra of the cover over the completed local
patch; it makes no assertion that the global cover is disconnected.

Regularity of W_U refers to the coordinate W in(2). Its possibly polar
Laurent expansion is its image on the overlap, not a claim that it is
regular at infinity. The maps below are regular on their actual charts
because they are the unique etale lifts of regular base maps with the
specified residue maps.

## 3. Differentiation, the two Frobenius maps and source transport

On the constant formal algebra D(S_i)=0. Differentiating(2) gives

    (5W_U^4-a)*D(W_U)=D(a*FU),                         (4)

whose inverse(3) is regular in the actual affine algebra. This uniquely
extends the lifted base derivation.

Let F0 mean sigma on Witt coefficients, z->z^5, and S_i->a_i*S_i.
Since a_i^4=1 and sigma(a_i)=a_i, this preserves the constant relations
and is the true Frobenius lift there. The base affine Frobenius has
Phi(z)=fuz, with displacement d=fuz-z^5 divisible by5. On a whole Laurent
series with coefficients in the constant algebra its extension is

    Phi(h)=sum_(j=0)^(m-1) d^j/j! * F0(partial_z^j h). (5)

For m<=5 all displayed factorials are units. The omitted ordinary
Laurent Taylor terms vanish: the divided derivatives of z^e have
integral binomial coefficients for every integer e, including negative e,
and d^m=0. In particular the j=5 term is zero modulo3125. This is
DIFFERENT from the flow or source exponential, where the fifth weighted
term can survive. No fifth term of the source exponential is discarded.

Formula(5) is a ring map and reduces to the actual fifth power. The
unique-etale-lifting property identifies it with the regular affine
Frobenius of the double and each AS chart; (4) and the affine equations
can also be checked directly after substitution.

For the canonical source overlap use the single exponential

    tau=exp((5xi-25n3-125n4-625n5)D)

with the exact base digits and coefficient lifts in the base theorem.
The constant S_i are fixed, so tau acts on the whole Laurent
coefficients of W_U. Both exponential terms of orders4 and5 have
coefficient625/24 and are retained. The image tau(W_U) satisfies the
affine equation pulled along tau; uniqueness identifies the lift of the
ORIGINAL etale map. Pulling the already certified base matrices and
graded data along these charts retains the full preceding tuple and
the flat periodicity line.

## 4. A small exact product decomposition

Let zeta^4=Teich(2). Over R'_m the five roots of the i-th constant
polynomial are Teich(r)*zeta^(-j_i), r in F5, with j=(3,0,1).
Differences between distinct roots are units, so evaluation gives the
integral Chinese-remainder splitting after this unramified extension.
The residue field extension F125(zeta)/F125 has degree4: a nonzero
root has order16 and ord_16(125)=4.

Frobenius cubed acts on the root grid as

    (r1,r2,r3)->(3r1,r2,2r3).

Exactly five triples, those with r1=r3=0, are fixed. Each other orbit
has length4. Therefore the etale algebra over R_m has five degree-one
factors and thirty degree-four factors, giving

    B_m=R_m^5 times (R'_m)^30.

The full Witt Frobenius on R'_m sends zeta to Teich(2)*zeta, as its
reduction is zeta^5 and that expression satisfies the same defining
equation. This makes componentwise mixed-characteristic arithmetic
available without altering the original AS marking. Interpolation or
trace transport is still required to recover a specified cohomology
coordinate from these components.

## 5. Executed evidence and retained limits

The [source](../../../scripts/deformations/rank125/lift_etale_reference.py)
uses the certified cubic-ring arithmetic and initial base chart
reconstruction. Its [certificate](../../../../litt3-computation-data/rank125_reference_20260914/certificates/rank125_integral_reference.json)
retains both whole execution receipts, source hashes and small independent
character, parity and orbit checks, reproducible with the
[small checker](../../../scripts/deformations/rank125/certify_integral_reference.py).
The [storage relocation record](../../../../litt3-computation-data/rank125_reference_20260914/provenance/relocation.json)
preserves the original receipts, historical paths and generating checkers.
The current checker uses the new locations; only path and checker-hash
metadata differ on a rerun.
The first uses coefficient modulus3125,
Laurent workspace2200, the positive infinity branch and base Frobenius
variant0. The second uses workspace2600, the negative infinity branch
and variant1. All three integral affine relations, derivatives,
affine Frobenius maps, Frobenius residues and canonical source transports
pass through exclusive Laurent precision40.

The saved root precisions are at least1823; the saved affine Frobenius
precisions are at least1751. Subsequent products must continue to
propagate precision. A preliminary1200-window run failed its precision
guard in a fifth power of a Frobenius image; it did not exhibit a nonzero
equation residual. The successful larger runs retain the guard.

The source uses absolute exclusive precision and never declares unknown
formal coefficients zero. The whole-object justification is Hensel
uniqueness and the formulas(1)--(5). The finite output windows are
diagnostics, and the checks do not pretend that a formal identity follows
merely from agreement through order40. Under the change of infinity
branch, W1^-(S)=-W1^+(-S), while W2,W3 are unchanged; both receipts obey
these parities. Each FU polynomial also agrees with the earlier
independently replayed primary engine.

The later [actual fourth-reference proof](rank125_actual_fourth_reference.md)
evaluates E4(B0) and alpha,beta,omega on these charts; the
[whole fifth proof](rank125_fixed_line_fifth.md) adds the combined
second repairs and affine fifth value. This proof supplies their
integral reference and stops at that boundary. The component
decomposition is a computational device, not a replacement for both
maps in the unmarked common-cover problem.
