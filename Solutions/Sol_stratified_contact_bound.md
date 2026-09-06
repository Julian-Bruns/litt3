# Stratified contact counting and a simultaneous quotient

Author: `/root`, 2026-09-06. Status: author proof, audit pending.
Canonical statement: [stratified_contact_bound](../Theorems/Thm_stratified_contact_bound.md).
This strengthens the counting mechanism, not the unmarked Litt conclusion.

## 1. Local slopes and their first possible collision

At zeros of order e choose coordinates x,y and write the endpoint
tensors x^e U(x)(dx)^d and y^e V(y)(dy)^d, with unit U,V. Every etale
branch y=h(x) preserving them has nonzero slope lambda satisfying

    lambda^(e+d)=U(0)/V(0).

Over an algebraically closed field of characteristic p this equation
has exactly r_e distinct roots, where r_e is the prime-to-p part of
e+d. Counting e+d roots with multiplicity would lose this improvement.

Two distinct branches of the same slope have a finite contact order
q>=2. Composing one with the inverse of the other gives an automorphism
h(x)=x+c x^q+O(x^(q+1)), c!=0, preserving x^e W(x)(dx)^d for a unit W.
The relative coefficient in degree q-1 of the change is

    (e+dq)c.

The unit ratio starts in degree at least q, so no omitted term changes
this coefficient. Thus e+dq=0 in k. If p|d and p does not divide e,
no such pair exists: each slope class has at most one branch. Otherwise
q>=m_e with m_e as in the statement. In particular the previously
excluded case p|(e+d), p not dividing d has m_e=p+1, not a value <=p.
If p divides both e,d, the universally valid bound q>=2 suffices.

Distinct normalized image branches cannot have identical completed
germs: an identical germ would be a common component of their algebraic
image curves. Repetitions of the SAME image are why the union must be
reduced. Within one normalization the different branches at a singular
point likewise have distinct formal germs.

## 2. Each stratum uses the same total bidegree

Let D be the reduced union in X x Y, with normalized connected components
Z_i. Its delta invariant satisfies the already proved reduced-union
adjunction/Hodge-index estimate

    delta(D)=D^2/2+T <= AB+T,
    T=sum_i(g(Z_i)-1)=A(g(X)-1)=B(g(Y)-1).

See [the contact theorem](Sol_contact_degree_bound.md), reduced-union
section. This estimate includes intersections between components.

For the e-stratum, on the disjoint normalization put S_e equal to the
preimage of the order-e zero sets on either endpoint. Actual tensor
equality and etaleness make these the SAME reduced set. Therefore

    |S_e|=A u_e=B v_e,
    |S_e|^2/(u_e v_e)=AB.

Fix one of the u_e v_e endpoint pairs, with R branches and slope-class
sizes R_j. The local delta contribution is at least

    binom(R,2)+(m_e-1)sum_j binom(R_j,2)
      >= (1/2)(1+(m_e-1)/r_e)R^2-(m_e/2)R.

There are at most r_e slope classes, so this is Cauchy--Schwarz. Summing
over the pairs and applying Cauchy--Schwarz once more gives the stratum
contribution

    (1/2)(1+(m_e-1)/r_e)AB-(m_e/2)|S_e|.

Different multiplicity strata occupy DISJOINT points of X x Y. Their
contributions may therefore be added. Comparing their sum with AB+T
gives exactly K AB<=2T+sum_e m_e A u_e and the two degree bounds.

In the hard-cap case every pair has at most r_e branches, so directly
A u_e=B v_e<=r_e u_e v_e. This proves both bounds without a contact
inequality. In the remaining cases each summand defining K exceeds
one; if at least two strata occur, K>0. No ordinarity, Jacobian, core,
or Galois assumption enters the proof.

## 3. The bound controls the whole relation

Specialize X=Y=C. Every finite set of distinct exact preserving images
has total degree bounded by the SAME constant B_s in the statement.
There cannot be infinitely many such images: any floor(B_s)+1 distinct
ones would already have total degree at least floor(B_s)+1. Thus all
exact images form a finite set, without needing a cover enumeration.

They contain the diagonal and are closed under transpose and normalized
composition, because their tensors agree through the intermediate
endpoint. Joint minimalization preserves both etale maps and tensor
equality. The [finite-groupoid theorem](Sol_finite_correspondence_groupoid.md)
gives a canonical effective orbifold S_s, with C x_(S_s) C exactly this
relation. Its degree is the bounded total degree, and s descends to beta.

For two endpoints, the same estimate bounds every finite union of cross
images. Along one actual preserving span, u_e/(g(X)-1)=v_e/(g(Y)-1),
so the profile criterion holds on both or neither. The finite two-object
groupoid identifies the exact quotients, as in
[the canonical-quotient proof, Section3](Sol_canonical_marked_quotient.md).

For a fixed scalar lambda, apply this to (C,s) and (C,lambda s). The
exact self-relations are unchanged by rescaling. As a result, every
line-preserving image lies over an automorphism of S_s sending beta to
a scalar multiple. Conversely every such automorphism gives the twisted
fiber-product images. As in Sections4--5 of that proof, the multiplier
is injective; Aut(S_s) is finite, and thus the multiplier group is cyclic
of order prime to p. The line quotient governs all these images.

Etale refinements multiply all u_e and g(C)-1 by their degree and leave
e,d,m_e,r_e unchanged, so the criterion persists. Powers need not satisfy
the numerical criterion afresh: equality of powers is equivalent to a
root-of-unity multiplier on s, and line preservation is unchanged by
powers. Thus the previously constructed finite line relation gives the
same line quotient for all positive powers as well. This is not a claim
that the displayed numerical bound is power-invariant.

## 4. Known consequence versus strengthening; explicit boundaries

Different zero-order strata are disjoint etale clumps. Theorem9.6 of
Krishnamoorthy already shows that an individual span preserving such a
tensor has a core; see
[the primary paper](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf).
The present direct proof instead bounds the ENTIRE exact relation and
therefore constructs one quotient for all its members.

In p=5 the uniform one-form profiles e=1,2,5 give respectively:

    (r_e,m_e,K)=(2,4,1/2), (3,3,-1/3), (6,5,-1/3).

Thus simple zeros are controlled; the known double-zero and Igusa
fivefold-zero coreless families are not excluded. Uniform d=2,e=1
also has K=-2/3, so the known characteristic-five Hasse-type profile
is not accidentally ruled out. The criterion never guarantees that a
tensor exists, or that an arbitrary span has more than one stratum.
It preserves, rather than repairs by assumption, the known counterexamples.
