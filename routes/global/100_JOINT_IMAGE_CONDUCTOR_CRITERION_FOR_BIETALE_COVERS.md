# The joint-image conductor criterion for bi-etale covers

**Status: proved below; author self-check complete; independent audit
pending. 2026-09-04.**

This note records an exact, all-degree formulation that retains both maps
from the **same** projective curve. It is not a nonexistence theorem. The
ingredients are standard normalization, adjunction, and the different;
the purpose is to keep the full geometric condition in the current search.
No Galois hypothesis is imposed on either map.

All curves are smooth, projective, and connected over an algebraically
closed field \(k\), unless an image curve is explicitly allowed to be
singular. Put \(s_X=g(X)-1>0\), \(s_Y=g(Y)-1>0\).

## 1. Passing to the joint image loses no common cover

### Proposition 100.1

Given finite etale maps \(f:Z\to X\) and \(g:Z\to Y\), let
\(C\subset X\times Y\) be the reduced image of \((f,g)\), and let
\(\nu:Z_0\to C\) be its normalization. Then

\[
                Z\longrightarrow Z_0\longrightarrow X,Y
\]

are all finite etale maps. In particular, the common-cover problem is
unchanged if one requires the joint map to be birational onto its image.

#### Proof

The function field of \(Z_0\) is the compositum of the two specified
subfields \(k(X),k(Y)\subset k(Z)\). Every extension in the resulting
towers is separable, because \(k(Z)/k(X)\) and \(k(Z)/k(Y)\) are
separable. Properness makes the induced maps of curves finite.

The different transitivity formula for \(Z\to Z_0\to X\) is

\[
 R_{Z/X}=R_{Z/Z_0}+\pi^*R_{Z_0/X}.
\]

The left side is zero, and both terms on the right are effective.
They therefore vanish. The same argument for the tower over \(Y\)
proves the assertion. This works also when a degree is divisible by
the characteristic. \(\square\)

Unlike a coefficient-image quotient in an auxiliary construction,
\(Z_0\) still maps to these exact two original curves.

## 2. The two differential conditions share one conductor

Let \(C\subset S=X\times Y\) be an integral curve with finite,
generically separable projections. Write

\[
        \nu:Z\to C,\qquad f:Z\to X,\qquad g:Z\to Y,
        \qquad d_X=\deg f,\ d_Y=\deg g.
\]

Let \(\Delta\) be the conductor divisor on \(Z\): the conductor
ideal of \(\mathcal O_C\subset\nu_*\mathcal O_Z\), viewed as an
ideal of \(\mathcal O_Z\), is \(\mathcal O_Z(-\Delta)\).
Since \(C\) is a Cartier divisor on the smooth surface \(S\), it
is Gorenstein and

\[
 \omega_Z\simeq\nu^*\omega_C(-\Delta),\qquad
 \omega_C\simeq(\omega_S\otimes\mathcal O_S(C))|_C.
                                                               \tag{100.1}
\]

Denote \(L=\nu^*\mathcal O_S(C)\). The conormal derivative of a
local equation of \(C\), restricted to \(C\), is intrinsic. Splitting
\(\Omega_S=\operatorname{pr}_X^*\Omega_X\oplus
\operatorname{pr}_Y^*\Omega_Y\) and pulling back to \(Z\) gives
two global sections

\[
        s_x\in H^0(Z,L\otimes f^*\omega_X),\qquad
        s_y\in H^0(Z,L\otimes g^*\omega_Y).
                                                               \tag{100.2}
\]

### Theorem 100.2 (exact conductor-different identities)

The divisors of these sections satisfy

\[
             \operatorname{div}(s_x)=\Delta+R_g,
             \qquad
             \operatorname{div}(s_y)=\Delta+R_f.         \tag{100.3}
\]

Consequently, \(f\) and \(g\) are both etale if and only if

\[
             \operatorname{div}(s_x)
              =\operatorname{div}(s_y)=\Delta.          \tag{100.4}
\]

In (100.4) the equalities are equalities of **divisors on the same
normalization**, not just equalities of total degrees.

#### Proof

At a point of \(C\), choose local parameters \(x,y\) from \(X,Y\)
and a local equation \(F(x,y)=0\). A generator of the dualizing
module of this plane complete intersection, in its function field, is

\[
                      \eta=\frac{dx}{F_y}
                            =-\frac{dy}{F_x}.          \tag{100.5}
\]

Both denominators are nonzero in the function field because both
projections are generically separable. On a branch parameterized by
\(t\), with conductor exponent \(c\), (100.1) says
\(\operatorname{ord}_t\eta=-c\). Thus

\[
 \operatorname{ord}_t(F_y)=c+\operatorname{ord}_t(dx/dt),
 \qquad
 \operatorname{ord}_t(F_x)=c+\operatorname{ord}_t(dy/dt).
\]

For a separable map of smooth curves, the orders of the differential
maps are precisely the different exponents, including in wild
characteristic. These are the asserted identities.

Changing the equation \(F\) by a unit changes its differential on
\(C\) by the same unit; changing coordinates gives exactly the line
bundle transformations in (100.2). Hence the local identities glue.
Finally an effective different vanishes exactly when the finite
separable map of smooth curves is etale. \(\square\)

The conductor-duality identity in (100.1) can also be obtained directly
from finite duality:
\(\nu_*\omega_Z=\mathcal Hom_C(\nu_*\mathcal O_Z,\omega_C)\).
Since \(\omega_C\) is invertible, the Hom factor is the conductor.
For the relevant general duality background, see the
[Stacks Project, Algebraic Curves, Section 53.4](https://stacks.math.columbia.edu/tag/0E31).

### Corollary 100.3 (the common tangent line)

For a bi-etale correspondence the differential of its joint map is
a subbundle inclusion

\[
 T_Z\longrightarrow f^*T_X\oplus g^*T_Y\simeq T_Z\oplus T_Z,
\]

with each component an isomorphism. Its normal bundle is therefore
\(T_Z\), of degree \(2-2g(Z)<0\).

This is a statement about the normalization map. It does **not** say
that \(C\) is smooth or that \(Z\to S\) is a closed immersion.
\(\square\)

## 3. An exact maximal-singularity formulation when the Jacobians are disjoint

Assume

\[
                       \operatorname{Hom}(J(X),J(Y))=0.
                                                               \tag{100.6}
\]

The Neron--Severi group of the product, modulo numerical equivalence,
then has only the two fiber directions. With
\(F_X=\{x\}\times Y\), \(F_Y=X\times\{y\}\), one has

\[
 C\equiv d_YF_X+d_XF_Y,\qquad C^2=2d_Xd_Y,
 \qquad K_S\cdot C=2s_Xd_X+2s_Yd_Y.                   \tag{100.7}
\]

The usual additional summand in the Neron--Severi group is the group
of homomorphisms between the two Jacobians; (100.6) removes it.

Write \(\delta(C)=p_a(C)-g(Z)\), the total normalization defect.
Adjunction gives

\[
                  p_a(C)=1+d_Xd_Y+s_Xd_X+s_Yd_Y.       \tag{100.8}
\]

### Theorem 100.4 (equivalent all-degree criterion)

Under (100.6), \(X,Y\) have a common finite etale cover if and only
if there are positive integers \(d_X,d_Y\) and an integral curve
\(C\subset X\times Y\), with finite generically separable
projections of those degrees, such that

\[
                s_Xd_X=s_Yd_Y=:t,
                \qquad \delta(C)=d_Xd_Y+t.            \tag{100.9}
\]

The number \(d_Xd_Y+t\) is the largest possible normalization defect
for such balanced degrees and separable projections.

#### Proof

For arbitrary separable projections, Riemann--Hurwitz implies

\[
                       g(Z)-1\ge\max\{s_Xd_X,s_Yd_Y\}.
\]

Subtracting this from (100.8) gives

\[
                 \delta(C)\le d_Xd_Y+\min\{s_Xd_X,s_Yd_Y\}.
                                                               \tag{100.10}
\]

If both maps are etale, both Riemann--Hurwitz inequalities are
equalities, yielding (100.9). Proposition 100.1 supplies such an image
from any common cover.

Conversely, (100.8)--(100.9) imply \(g(Z)-1=t\). Both different
degrees are then zero by Riemann--Hurwitz. Since the different
divisors are effective, they vanish, and both maps are etale.
\(\square\)

For the current genera \((9,25)\), write \(N=d_Y\). Then

\[
 \boxed{d_X=3N,\quad g(Z)=24N+1,\quad
        p_a(C)=3N^2+48N+1,\quad\delta(C)=3N^2+24N.}
                                                               \tag{100.11}
\]

Condition (100.6) holds because \(J(Y)\) is simple of dimension 25,
whereas \(J(X)\) has dimension 9. In fact it holds for **every**
first curve of genus less than 25 with this fixed target; no simplicity
assumption on \(J(X)\) is needed.

## 4. Why counting ordinary nodes would lose the condition again

Even when both projections are etale on every branch, the joint image
can have arbitrarily high tangential contacts in characteristic five.
For example, in the completed local plane, take

\[
                    F=(y-x)(y-x-x^{5^m}),\qquad m\ge1.
                                                               \tag{100.12}
\]

Both branches are smooth and both coordinate projections are etale:
their slopes are both one. Their intersection multiplicity is
\(5^m\). Each conductor exponent is \(5^m\), and on either branch
both partial derivatives have exactly that order. Thus (100.4) holds
locally, with \(\delta=5^m\), not one.

This is a local two-branch model, not an asserted global common cover.
It shows why a bound on the number of coincident point-pairs does not
bound \(\delta(C)\). The contact orders must be retained.

One must also use the different, not just \(e-1\), in wild cases.
For the smooth branch \(x=y^5+y^6\), projection to \(x\) has
ramification index 5 but different exponent 5, because
\(dx/dy=y^5\) in characteristic five. Projection to \(y\) is etale.
Equation (100.3) detects this exactly with conductor zero.

## 5. The precise next obstruction

Files 95--99 remain useful monodromy filters, but they do not decide
whether a curve satisfying (100.9) exists. A proof must rule out the
maximal-defect locus **on the fixed product** \(X\times Y\), or show
that the two partial differential sections cannot both have precisely
the shared conductor divisor in (100.4).

Neither arbitrary singularity data, nor a Jacobian isogeny factor, nor
two independently realizable maps is a substitute for that condition.
No impossibility of (100.9) in unbounded degree is claimed here.
