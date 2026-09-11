# Relative fourth-level obstruction: parameter-independence audit

Verdict: PASS for the parameter-independence assertion, with the full
regular-module norm argument below replacing the candidate's optional
Smith-coordinate shortcut. That replacement is proved here and introduces
no new geometric hypothesis. No value of the constant is obtained.

Auditor: `/root/audit_backup_cored_completion`. Date: 2026-09-11.
This is a bounded mathematical/prose audit, not Lean verification.

Target: `Research/NEUTRAL5_PARAMETER_INDEPENDENCE_CANDIDATE.md` for the
specific R=u(u-1) D10 example, with its previously audited actual models,
canonical W2 marking, primary repair and previous periodicity-line data.
Let W3(b) denote the etale double of the given T3(b), not a descended
cyclic cover over a hypothetical compatible D3. Then

    epsilon_W(W3(b'))=epsilon_W(W3(b)),
    epsilon_T(T3(b'))=epsilon_T(T3(b))       for all b,b' in k.

The nilpotent Fitting length on D is TWO, not one. The old simple-zero
cyclic descent theorem is not applied. The computation below only uses
the actual cyclic DECK cokernel `coker(Psi_W)=k[e]/e^2`.

## 1. Which global objects are used

Choose a smooth descended curve reference through W4 and a genuine
global auxiliary filtered oper on its W2 truncation extending the fixed
special-fiber oper. Such an oper extension exists because H1(omega^2)=0.
Choose its prescribed spin/graded normalization and retain the actual
flat square-trivial periodicity line. These are legitimate auxiliary
input objects even though their next Hodge compatibility fails downstairs.

The relevant LSZ input includes the preceding global filtered flat object,
the new graded object, and their graded identification. Lemma 4.10 uses
both the filtered and graded overlap maps. It does not rescale an arbitrary
matrix with a nongluing lower-left entry. The comparison here uses exactly
that construction, with local oper lifts supplying its twisted divided
operators. [LSZ, Theorem 4.1, Lemmas 4.7, 4.8, 4.10 and formula 4.16.1](https://arxiv.org/html/1311.6424v4).

For each b, the actual preceding H2(b) IS global and filtered: this is
the established compatibility of T3(b), pulled to W. Its mod-five object
is the same fixed one. Comparing it with the auxiliary oper is therefore
a comparison between genuine preceding inputs. The auxiliary oper's
failure to match its inverse-Cartier output is a fixed reference error;
it is not treated as a missing global Hodge line.

All curve lifts W3(b) have the same W2 truncation. Arbitrary smooth W4
extensions suffice for computing epsilon. Their differences from the
descended reference are represented by 25 times tangent cochains over
W2, since 25*W4 is square-zero. The reference has its actual cyclic deck
action. No action of sigma on W3(b), and no compatible lower D3, is used.

## 2. First cochains and their relative filtration

On the ACTUAL special-fiber AS algebra, sigma(w)=w+1. Write Pj for
polynomial degree at most j in w. Then

    P2=e^2 A, P0=e^4 A, P2*P0 subset P2, P0*P0 subset P0.

These are statements about products of functions, not a derivation rule
for e. They hold on both charts w_O=w_U-chi. Base differential operators
preserve these spaces (differentiating the AS equation makes dw a base
form), as does Frobenius using w^5=w+f. No integral polynomial-filtration
claim is made across division by five.

The fixed particular curve cochain lies in P2. Changing b changes it
by a P0 cochain pulled back from ker(Psi_D), indeed from ker(Psi_C).
The reference normal error is pulled back from D and lies in P0. The
first Taylor/normal response is additive and deck-equivariant. Therefore
the exact first gluing error for either compatible upper lift is P2,
and the difference of those errors is P0.

The negative normal Cech complex has H0=0 and its H1 is free over
W2[C5]; use its integral deck-linear section and primitive. After
reduction, the unique normal generator corrections consequently satisfy

    ell_b in P2,       ell_b'-ell_b in P0.

Changing the chosen tangent representative by a boundary only changes
the marked curve presentation. Hence the existing equivariant section
may be used without replacing the specified curve digit or parameter.

Restoring the prescribed grading preserves these statements. A first
graph change e1->e1+5*ell*e2 changes the maximal-Higgs coefficient by
a linear expression in ell and its derivative modulo 25. Its restoration
uses inverses of units and a square root of a unit; 2 is invertible.
Thus every reduced first filtered-frame/scalar correction is P2, and
its relative change is P0. The normal coefficient line is identified
with the fixed tangent line by this restored maximal Higgs map. The
flat periodicity line is retained; its cancellation in Hom introduces
no division or extra choice.

## 3. Completeness of the next-digit comparison

In adapted frames the actual weight-one construction reads

    Mtilde=[[a_new,5*b_old],[0,d_new]],
    nablatilde=5*d+[[5*alpha_old,25*beta_old],
                   [gamma_new,5*delta_old]].

The new graded entries are prescribed. Since the old data are known
modulo 25, their first variations are 5 times reduced cochains. Their
contributions to these matrices at the next digit are additive of order
25; the varied upper connection entry is order 125 and vanishes.
Products of two first old-input changes have vanished in that input
modulo 25. The displayed construction does NOT divide them by five.
In normalized oper frames, the stronger observation is that the old
scalar appears only through 25*r: a scalar change 5*delta_r is invisible
modulo 125. General adapted frames can retain additive order-25 terms,
which are harmless here and are not assumed absent.

The change of the new graded object caused by a 25-order curve change
is likewise additive at this precision. Any diagonal restoration or
normal-frame transport at first order has the filtration behavior from
Section 2. Its interaction with another first change is an ORDINARY
quadratic product, considered below.

There is no missing divided Taylor term. On a torsion-free local oper
lift, the genuine Taylor matrices obey

    K_j=diag(5,1)*5^j*L_j*diag(5,1)^(-1),
    L_0=I, L_(j+1)=partial L_j+[[0,r],[1,0]]*L_j.

Hence v5(K_j)>=j-1. If ell>=2 factors of the divided Frobenius
displacement change by 5*zeta, the complete coefficient has valuation

    ell+j-1-v5(ell!)-v5((j-ell)!) >= 3.

Indeed v5(ell!)+v5((j-ell)!)<=v5(j!), and j-1-v5(j!)>=1 for j>=2.
Such terms vanish modulo 125. This includes factorials divisible by 5.
A mixed change with an order-25 tilde transition is also order at least
125. Scalar dependence is checked directly by the displayed oper formula:
K1 has upper entry 25*r, K2 is entirely order 25, and all later scalar
variations have the same or stronger gain after division by j!.
Nonlinear coordinate gluing starts at 25^2, and even its single
Frobenius division leaves order 125. Thus it vanishes here as well.

What remains is exactly:

1. the divided integral remainder of the first normal linear comparison;
2. additive order-25 changes of the preceding filtered/graded data;
3. ordinary products of first normal/frame changes.

For the last item the exact local graph calculation is

    Rj^-1*G*Ri lower-left
      =5*(K21+D*ell_i-A*ell_j)
       +25*(L21+K22*ell_i-K11*ell_j-B*ell_i*ell_j) mod125,

where Ri=I+5*ell_i*E21 and G=G0+5*K+25*L. The fixed reference error
is included in K and L. Its coefficients are descended, hence P0.
Every relative quadratic summand contains a P0 difference and at most
one P2 first correction. Its normal cochain is therefore in P2. The
additive relative terms have P0 inputs. Since e^2 annihilates the actual
normal cokernel, both kinds have zero class there.

This reasoning explicitly covers changes of the prescribed graded
identification and of the normal-line trivialization. Neither brings
another division by five. It also retains the incompatible reference
error: its constant contribution cancels in the relative comparison,
and its products with changed generators are the P0-controlled products
just described. Compatibility of that reference is not required.

## 4. The divided linear carry on FULL regular lattices

This avoids any identification of Smith factors with Fitting blocks.
Define A2 by extracting the additive-in-curve part of the actual
jet/Taylor normal comparison over W2, with the descended auxiliary
input frozen, then use the chosen cochain section and normal projection.
It is an additive deck-equivariant map between the full regular source
and target lattices. Its reduction is the actual Hodge operator. The
one-digit identification is the Hodge-projection first variation of
[LSYZ, Theorem 6.2](https://arxiv.org/html/1404.0538v2); no assertion of
bijectivity is used.

Let N=1+sigma+...+sigma^4. Lift the relative tangent class as N*alpha.
Such a lift exists by freeness and the norm identification of invariant
and coinvariant lattices. The reduction of alpha in coinvariants is
the corresponding lower kernel vector. Therefore

    A2(alpha)=e*zeta+5*v

for integral target vectors zeta,v. This uses only that the reduction
induced on coinvariants is Psi_D and that the lower vector is in its
kernel. Additivity and deck-equivariance now give the EXACT equation

    A2(N*alpha)=N*A2(alpha)=5*N*v,

because N*e=0 integrally. Its divided reduction is Nbar*vbar=e^4*vbar,
which is zero in coker(Psi_W)=R/e^2.

This is also the actual Cech carry, not a replacement for it. For the
integral first normal cochain z, take the integral primitive q=P(z).
Then z-dq=s*cl(z). Its reduction is exact because the relative curve
direction is in ker(Psi_W). The divided residual represents cl(z)/5,
precisely the class calculated above. The reduced primitive agrees with
the actual first Hodge repair by uniqueness. A different integral lift
of the primitive adds a final boundary; a free next curve digit adds a
Psi_W image. Neither affects epsilon.

Thus no division has been moved through an augmentation ideal. The
candidate's e^6/5 computation is consistent, but the norm argument is
preferable: it applies to the entire matrix and avoids any unit-block
elimination. Mixed coefficient Frobenius terms commute with the abstract
deck action and are covered by additivity; they add no further issue.

## 5. Conclusion, checks and exact scope

Sections 3 and 4 kill EVERY term in the relative next obstruction.
Hence epsilon_W(W3(b'))-epsilon_W(W3(b))=0. The actual degree-two map
W3(b)->T3(b) gives naturality, and its pullback on the special-fiber
obstruction cokernel is injective. The same parameter-independence
therefore holds on T.

The function requested in the Pro problem is consequently constant:

    P(b)=P(0).

Its zero set is either all of k or empty. THIS AUDIT DOES NOT DETERMINE
WHICH. It gives no W4 lift, no obstruction value, no full tower and no
counterexample to non-Galois descent. The calculation of P(0) still
requires the actual next inverse-Cartier normal cocycle.

The small exact script `scripts/audit_neutral5_parameter_independence.py`
checks the graph identity, relative quadratic degree, the actual AS
finite-difference images, the integral norm identities and 124,750 mixed
Taylor inequalities through j=500. The all-order bound and geometric
identification are the proofs above, not consequences of the finite test.
Receipt: `Research/computations/neutral5_parameter_independence_audit.json`.
Runtime 0.069 seconds after Sage startup. SHA256:

    source: cf046d5ca968650edb9ca720820532437b8934188dc0a104228cf11209bc0088
    receipt: 1690e841f283aafea0e7251d1b52dd0cdd77503e656668fe4a871c13612bc0bb

No producer, canonical statement, library or state file was changed by
this audit. The exact local construction in the uniform-comparison
proof was inspected, but its simple-zero and compatible-initial-reference
descent conclusion was not imported into this different example.
