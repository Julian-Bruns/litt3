# Proof: maximal two-cover of the prescribed genus-two family

Author /root,2026-09-09. No independent audit or Lean verification claimed.
All ordinariness in this proof concerns the Jacobian/Cartier operator,
not an indigenous bundle. The group-extension argument is the familiar
ordinary-p-cover mechanism; the new explicit input is the exact family
calculation, including its full exceptional parameter set.

## 1. The actual maximal cover, including infinity

Put a_i=0,1,2,3,t. Their five functions u-a_i have independent square
classes in k(u): valuation at a_i detects the ith exponent. The displayed
field therefore has degree32 over k(u), with group (C2)^5.

At each finite branch point its inertia is the individual sign change.
At infinity, all five functions have odd pole order and any quotient
(u-a_i)/(u-a_j) is a local unit, hence a square in k((1/u)). Thus the
inertia at infinity is the simultaneous sign change. There is no other
ramification. The product of the roots gives v, so the subgroup defining
T_t→Y_t is the kernel of the product of the five signs. Neither a finite
inertia generator nor the infinite inertia generator belongs to it.
The map is therefore etale everywhere, of degree16. Hurwitz gives genus17.

The maximal elementary abelian2 quotient of the geometric etale group
of a genus-two curve has order2^4, by Kummer theory/Pic[2]. Our connected
degree16 cover realizes that order and is consequently the maximal one.
Every connected elementary abelian2 etale cover of Y_t is its quotient.

## 2. All Cartier blocks are elliptic except the original Y_t block

The sign characters of (C2)^5 are indexed by nonempty subsets I of the
five finite branch values. The corresponding quadratic quotient is

    C_I: z²=product_(a in I)(u-a).

The sign action is defined over F5. Cartier therefore preserves each
character subspace of H0(T_t,omega). That subspace identifies by pullback
with H0(C_I,omega): invariant differentials under the character kernel
descend, including at tame ramification. The trivial-character space is
H0(P1,omega)=0. Hence the Cartier kernels split as a direct sum of those
on the31 quadratic quotients.

For |I|=1,2 the quotient has genus0. The ten subsets of size3 and five of
size4 give elliptic curves; |I|=5 gives Y_t. Equivalently this is the
prime-to5 character decomposition J(T_t)~J(Y_t) times fifteen elliptic
Jacobians. We use its differential decomposition, so there is no issue
of a-number invariance under a possibly inseparable isogeny.

For z²=H(u) of degree3 or4 in characteristic5, Cartier on du/z is
multiplication by ([u4]H²)^(1/5). The following are all fifteen
coefficients; the first four size3 subsets and the constant size4
subset give the five nonzero constants shown.

| I | [u4](product_(a in I)(u-a))² |
| --- | --- |
| 0,1,2 | 3 |
| 0,1,3 | 2 |
| 0,2,3 | 2 |
| 1,2,3 | 3 |
| 0,1,2,3 | 3 |
| 0,1,t | t²+4t+1 |
| 0,2,t | t²+3t+4 |
| 0,3,t | t²+2t+4 |
| 1,2,t | t²+2t+3 |
| 1,3,t | t²+t+2 |
| 2,3,t | t²+2 |
| 0,1,2,t | 3t²+4t+4 |
| 0,1,3,t | 2t²+3t+4 |
| 0,2,3,t | 2t²+1 |
| 1,2,3,t | 3t²+3t+3 |

After making the ten quadratics monic they are precisely the ten
irreducible quadratics over F5: each has nonsquare nonzero discriminant
and they are distinct. Their product is

    t20+t16+t12+t8+t4+1 = (t25-t)/(t5-t).

Thus exactly one elliptic block has Cartier kernel1 when t is in
F25\F5; otherwise all fifteen blocks are ordinary.

For Y_t the usual two-by-two Cartier coefficient matrix is

    (t+1) [[1-2t,-2t],[-2,t-2]],
    determinant=3(t+1)^4.

Its rank is2 except at t=4, where it is0. Since the only allowed
F5-parameter is4, adding these sixteen Cartier-kernel contributions
proves the complete a-number assertion. The accompanying standard-library
script checks the displayed coefficients, matrix, discriminants, and
product identically in F5[t], not by sampling parameter values.

## 3. The general unbounded p-group step

If C is ordinary and q:W→C is a connected finite etale Galois p-group
cover, W is ordinary. Here is a proof avoiding any division by its degree.
Let B_C be the sheaf of locally exact differentials on C^(1), so that
H0(B_C)=ker(Cartier on H0(C,omega_C)). Etale Frobenius base change gives
B_W=q^(1)*B_C. The regular representation of a finite p-group in
characteristic p has a filtration with trivial one-dimensional factors.
Etale torsor descent converts it into a vector-bundle filtration of
q^(1)_*O_(W^(1)) with factors O_(C^(1)). After tensoring by B_C, every
successive quotient has zero H0. The projection formula then gives
H0(B_W)=0, proving ordinariness of W. Descent here is exact; no exactness
of modular group invariants is assumed.

Ordinariness also descends along ANY separable finite cover of smooth
curves: a nonzero regular Cartier-zero form downstairs pulls back to a
nonzero regular Cartier-zero form upstairs. We will use this only for
the actual finite etale maps at issue.

Now let W→Y_t be the Galois closure in the statement, and put V=W/P.
The curve V is an intermediate quotient of the ordinary T_t, and hence
ordinary. The preceding p-group argument makes W ordinary. But W→Z→X
is still the composition of the actual finite etale maps. Nonordinary X
would supply a nonzero Cartier-zero form on W, a contradiction.
This retains the same common source through a genuine one-leg closure;
no simultaneous finite Galois closure is presumed.

## 4. The fixed genus-nine endpoint needs no separate calculation

For any squarefree degree10 F in characteristic5, the smooth projective
model X:y³=F(x) has genus9. Its regular differential basis is

    x^i dx/y² (0<=i<=5),  x^j dx/y (0<=j<=2).

Under y→zeta_3 y these have character zeta_3 and zeta_3² respectively.
Cartier is inverse-Frobenius-semilinear and commutes with the action, so
it swaps the character spaces (5 is -1 modulo3). Since their dimensions
are6 and3, its total rank is at most6. Thus a(X)>=3. This proves the
application without the individual coefficients of the fixed F.

## Relation to previous work and limitation

The historical bounded-abelian ordinarity theorem establishes a nonempty
open in FULL hyperelliptic moduli for each fixed prime-to-p exponent.
The bounded-Raynaud-monodromy note already contains the p-group closure
argument used in Section3. Neither certifies this prescribed one-parameter
family. Sections1–2 do so exactly for exponent2 and exhibit its exceptions.
There is no claim that this new theorem subsumes either broader generic
result. Nor does it imply that indigenous connections on T_t are ordinary:
the genuine bad twists in genus_two_active_twists remain valid.

Outside the specified group class, ordinary versus nonordinary endpoints
can have common etale covers, even with prime-to5 Galois legs. In
particular, the existing cubic_genus_two_common_covers theorem forbids
extending Section3 to arbitrary prime-to5 or solvable monodromy.
