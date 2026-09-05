# The collision divisor and normal line of a bi-etale joint image

Date: 2026-09-05.
Author: `/root/x_elliptic_quotient_maps`.
Status: proved and self-checked.  The final Raynaud-theta paragraph records
an exact limitation, not a noncontainment theorem.

Let `k` be algebraically closed.  Let

\[
                 f:Z\longrightarrow X,
                 \qquad g:Z\longrightarrow Y                 \tag{1}
\]

be finite etale maps between smooth projective connected curves of genus
at least two.  Assume that

\[
                 j=(f,g):Z\longrightarrow X\times Y
\]

is birational onto its reduced image `C`.  This assumption is automatic
for a minimal common cover.  Write `nu:Z -> C` for the normalization,
`Delta` for its conductor divisor on `Z`, and

\[
 d_X=\deg f,\qquad d_Y=\deg g,\qquad
 \delta(C)=p_a(C)-g(Z).
\]

The purpose of this note is to refine the total conductor formula into an
actual ordered collision divisor which retains both maps.

## 1. The normal line and the canonical differential ratio

Both components of `dj` are isomorphisms.  Hence `j` is an unramified
map and its normal line

\[
 N_j=\operatorname{coker}\bigl(T_Z\longrightarrow
                         f^*T_X\oplus g^*T_Y\bigr)           \tag{2}
\]

is canonically isomorphic to `T_Z` after choosing either projection.  In
particular,

\[
       N_j\simeq T_Z,\qquad \deg N_j=2-2g(Z),\qquad
       H^0(Z,N_j)=0.                                      \tag{3}
\]

Here `j` need not be an immersion in the scheme-theoretic sense: distinct
points of `Z` can have the same image.  It is a closed immersion on each
completed branch.

There is a canonical differential identification

\[
 \kappa=(dg)^{-1}\circ df:f^*\omega_X\xrightarrow{\sim}g^*\omega_Y.
                                                               \tag{4}
\]

Let

\[
                         L=\nu^*\mathcal O_{X\times Y}(C).
\]

The two components of the conormal derivative of a local equation for
`C` are sections

\[
 s_X\in H^0(Z,L\otimes f^*\omega_X),\qquad
 s_Y\in H^0(Z,L\otimes g^*\omega_Y).
\]

The exact conductor-different identity gives

\[
                  \operatorname{div}(s_X)
                  =\operatorname{div}(s_Y)=\Delta.          \tag{5}
\]

The additional exact relation, after using (4), is

\[
                  (1_L\otimes\kappa)(s_X)+s_Y=0.             \tag{6}
\]

Indeed, (6) is simply the pullback of `dF=F_x dx+F_y dy=0` on a
branch of a local equation `F=0`.  Adjunction and normalization duality
also give the line-bundle identity

\[
 \boxed{\quad L\simeq T_Z(\Delta)=N_j(\Delta).\quad}         \tag{7}
\]

To check the sign in (7), use

\[
 \omega_Z\simeq\nu^*\omega_C(-\Delta),\qquad
 \omega_C\simeq
   (\omega_{X\times Y}\otimes\mathcal O(C))|_C,
\]

and `f^*omega_X ~= omega_Z ~= g^*omega_Y`.  Thus
`nu^*omega_(X times Y) ~= omega_Z^2`, which rearranges to (7).

Consequently

\[
 \boxed{\quad C^2=\deg L=2-2g(Z)+\deg\Delta
                    =2-2g(Z)+2\delta(C).\quad}              \tag{8}
\]

This is the double-point formula for the normalization map, with no
assumption that the singularities are nodes.

## 2. Every singularity is a collision of smooth graph branches

Fix `P=(x_0,y_0) in C` and let `z_1,...,z_r` be its inverse images in
`Z`.  Choose uniformizers `x` at `x_0` and `y` at `y_0`.  Since both maps
in (1) are etale, the completed branch at `z_i` has the form

\[
                         y=\phi_i(x),\qquad \phi_i'(0)\ne0.  \tag{9}
\]

The series `phi_i` are pairwise distinct.  Up to a unit, the completed
local equation is

\[
                         F(x,y)=\prod_{i=1}^r(y-\phi_i(x)).  \tag{10}
\]

Thus a bi-etale joint image has no cusps and no other singular
unibranch points.  Its singularities arise solely by identifying two or
more smooth branches, each etale over both coordinate curves.

Put

\[
             m_{ij}=\operatorname{ord}_x(\phi_i-\phi_j).
\]

Then the local normalization defect and the conductor exponent on the
`i`-th branch are exactly

\[
 \boxed{\quad
   \delta_P(C)=\sum_{i<j}m_{ij},\qquad
   c_i(\Delta)=\sum_{j\ne i}m_{ij}.
 \quad}                                                     \tag{11}
\]

Indeed, all branches in (10) are smooth, so the delta invariant is the
sum of their pairwise intersection multiplicities.  Restriction of the
partial derivatives to the `i`-th branch gives, up to a unit,

\[
 \begin{aligned}
 F_y(x,\phi_i(x))
    &=\prod_{j\ne i}(\phi_i-\phi_j),\\
 F_x(x,\phi_i(x))
    &=-\phi_i'(x)\prod_{j\ne i}(\phi_i-\phi_j).
 \end{aligned}                                             \tag{12}
\]

Because `phi_i'` is a unit, both orders equal `c_i`, proving the
conductor assertion as well as (5) locally.

A transverse double collision (`r=2,m_12=1`) is an ordinary node.
Tangency has a precise differential-ratio interpretation.  At a collision
of branches `i,j`, the ratio of the two identifications (4) is

\[
                         \frac{\phi_j'}{\phi_i'}.
\]

It equals one at the collision exactly when `m_ij>=2`.  More generally,

\[
 \operatorname{ord}_x\left(\frac{\phi_j'}{\phi_i'}-1\right)
                         \ge m_{ij}-1,                     \tag{13}
\]

with equality when the characteristic does not divide `m_ij`.  When the
characteristic divides `m_ij`, the order can be larger or infinite.  For
example, in characteristic `p`, the branches

\[
                         y=x,\qquad y=x+x^{p^a}
\]

have contact `p^a` but identical first-derivative ratios.  Thus both-leg
etaleness puts no upper bound on contact order.

## 3. The conductor is an ordered equalizer divisor

Because `f` is etale, its diagonal is an open-and-closed component of
`Z times_X Z`.  Put

\[
 R_X=(Z\times_X Z)\setminus\Delta_Z,
 \qquad \pi_i=\operatorname{pr}_i|_{R_X}.
\]

This is a smooth projective curve, possibly disconnected.  Birationality
of `j` implies that no component of `R_X` is mapped into the diagonal of
`Y times Y` by `(g pi_1,g pi_2)`: otherwise a generic point of `Z` would
have a distinct point with the same `f`- and `g`-images.  Hence

\[
 E_X=(g\pi_1,g\pi_2)^*\Delta_Y                         \tag{14}
\]

is a well-defined effective Cartier divisor on `R_X`.

**Proposition 3.1 (ordered collision formula).**  One has

\[
 \boxed{\quad (\pi_1)_*E_X=\Delta,\qquad
                  \deg E_X=\deg\Delta=2\delta(C).\quad}    \tag{15}
\]

The same assertion holds after interchanging `X,f` and `Y,g`.

**Proof.**  A point of `E_X` is an ordered pair `(z_i,z_j)`, `i ne j`,
over one point of `X` whose two `Y`-images coincide.  Using their common
etale parameter `x`, the local equation of the equalizer is
`phi_i(x)-phi_j(x)`, so its multiplicity is `m_ij`.  The coefficient of
`z_i` in `(pi_1)_*E_X` is therefore
`sum_(j ne i)m_ij`, which is the conductor coefficient in (11).
This proves the divisor equality.  Summing over ordered pairs proves the
degree identity.  \(\square\)

Formula (15) is stronger than a count of coincident point-pairs: it retains
their complete contact multiplicities and both original maps.  It is also
the global form of the local derivative-ratio restriction (13).

## 4. Self-intersection and the correspondence action

Let

\[
             \Phi=g_*f^*:J(X)\longrightarrow J(Y),
 \qquad \Phi^\dagger=f_*g^*
\]

with adjoint taken for the canonical principal polarizations.  A standard
Kunneth calculation of the cycle class of `C` gives, for any prime
`ell` different from the characteristic,

\[
 \boxed{\quad
 C^2=2d_Xd_Y-
   \operatorname{Tr}\bigl(\Phi\Phi^\dagger\mid V_\ell J(Y)\bigr).
 \quad}                                                     \tag{16}
\]

For completeness, the two fiber components of `[C]` contribute
`2d_Xd_Y`; the square of its `H^1(X) tensor H^1(Y)` component is the
negative trace in (16).  The latter component is exactly the
cohomological correspondence `Phi`.  Combining (8) and (16) yields

\[
 \delta(C)=d_Xd_Y+g(Z)-1-
  \frac12\operatorname{Tr}(\Phi\Phi^\dagger).             \tag{17}
\]

In particular, if `Hom(J(X),J(Y))=0`, then `Phi=0` and

\[
 C^2=2d_Xd_Y,\qquad
 \delta(C)=d_Xd_Y+g(Z)-1.                                \tag{18}
\]

Thus the negative normal line in (3) is not a contradiction: the positive
self-intersection is supplied exactly by the conductor.  If all
singularities happened to be nodes, (18) would say that their number is
`d_Xd_Y+g(Z)-1`; high contacts merely concentrate the same weighted total.

## 5. What this does and does not say about Raynaud theta

Assume now that `char(k)=p>0`, and let

\[
 \mathcal B_Z=F_{Z/k*}\mathcal O_Z/\mathcal O_{Z^{(1)}}.
\]

The old two-leg locus is the image of

\[
 \alpha:J(X^{(1)})\times J(Y^{(1)})\longrightarrow J(Z^{(1)}),
 \qquad (A,B)\longmapsto f^{(1)*}A\otimes g^{(1)*}B.       \tag{19}
\]

Containment of this entire image in Raynaud's theta divisor is exactly the
statement that

\[
 H^0\!\left(Z^{(1)},\mathcal B_Z\otimes f^{(1)*}A
                              \otimes g^{(1)*}B\right)\ne0 \tag{20}
\]

for **every** `(A,B)`.  Nothing in (2)--(18) produces one pair for which
(20) vanishes.  In particular:

- if `Z` is ordinary, the pair `(O,O)` already makes (20) vanish, so the
  old locus is not contained;
- when `Z` is nonordinary, the vanishing of `H^0(N_j)` only says that the
  normalized map is rigid inside the fixed product; it does not control
  the Frobenius kernel in (20);
- the conductor and differential-ratio identities record first and higher
  contact jets, whereas (20) is a global Frobenius condition on every
  degree-zero twist.

Actual one-leg etale covers with an everywhere-bad restricted Raynaud
theta locus are known from Raynaud's no-theta constructions, so etaleness
itself is not a generic-vanishing principle.  The argument above neither
constructs such an example with two minimal legs nor rules it out.

The new geometric datum most directly available for attacking (20) is
therefore the actual equalizer divisor `E_X` in (14), together with the
canonical ratio stratification (13).  A successful theta argument would
have to connect Frobenius failure in (20) to this ordered collision data.
Total defect, self-intersection, negativity of `N_j`, and first-order
tangency alone do not make that connection.

## Relation to earlier notes

The total identities (5), (8), and (18) recover the conductor and defect
formulas in files 100 and `PARAMETERIZED_PUSHED_INCIDENCE_DICHOTOMY.md`.
The additional content here is the global ordered-equalizer formula (15),
the branchwise differential-ratio estimate (13), and the explicit
separation between fixed-product rigidity and Raynaud-theta containment.
