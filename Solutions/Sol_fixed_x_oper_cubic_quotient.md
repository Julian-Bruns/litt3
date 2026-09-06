# Proof: cubic quotient and explicit reconstruction

Canonical [statement](../Theorems/Thm_fixed_x_oper_cubic_quotient.md).

## The exceptional slice

Use the notation L_j,n_j,F of the complete scalar system. The coefficient
of x^28 in the third numerator equation is2*c4^2-2*a10, hence a10=c4^2
over every parameter algebra.

The exact Groebner calculation for I+(c4) has length330. Its radical has
length55 and contains every coefficient of A and C. Thus its support is
precisely the invariant slice, already known to have55 distinct points.
Independently, adding c4 to the saved full local presentations gives
length6 at each of those55 points, accounting for all330.

Reproduce the input with
scripts/fixed_x_dormant_opers.sage --c4-zero --msolve-input --reduced,
run msolve -g2 on that input, then use
scripts/export_oper_basis.sage --c4-zero --radical.
The retained raw basis is Research/computations/c4_zero_oper_msolve.gb.
Full and radical F25 checkpoints are alongside it. Local certificates
are Research/computations/invariant_oper_c4_slice.json, reproduced by
scripts/invariant_oper_c4_slice.sage. These are computational evidence,
not a claimed independent whole-theorem audit.

## Normalization and elimination

Work with c4 invertible. Put t=c4, lambda=t^3, C=t Chat, A=t^2 Ahat.
The preceding coefficient identity makes Chat and Ahat monic. Set

    Nbase=2F''F+2(F')^2+2x^8F,
    T=(L_2(Ahat)-Nbase*Ahat-3F^2*Chat^2)/F.

The numerator of T is divisible by F: modulo F, the two contributions
2(F')^2*Ahat cancel. Direct leading-coefficient cancellation gives
deg T<=17. Divide by the monic degree-ten polynomial Ahat:

    T=B*Ahat+e2,       deg B<=7, deg e2<10.

Define N0=Nbase+FB and

    W=F*(Chat*F)''-N0*Chat,
    lambda=2*[x^20]W,
    e1=W-3*lambda*Ahat^2,
    e0=(L_0(N0)-3N0^2)/F^2-lambda*Chat*Ahat.

Here deg W<=20; the x^21 coefficient cancels identically for this
quotient B. The numerator defining e0 is divisible by F^2. All these
identities are checked by exact polynomial division in the retained script.
Because Ahat and Chat are monic, no parameter is inverted in constructing
B or lambda.

Set every coefficient of e0,e1,e2 to zero, giving14 variables and44 equations.
Temporarily localize at lambda; the next section proves this does not
change the scheme, so no inverse variable is needed in the actual input.
Expansion has maximum degree16; the script saves the equations and
the reconstruction polynomials.

To prove equivalence, start with an original solution with t!=0.
The third equation divided by t^2*F says T=B*Ahat, so forces the quotient
B and e2=0. The second equation divided by t*F says W=3*lambda*Ahat^2,
whose x^20 coefficient forces the displayed lambda. The first equation,
divided by F^2, is e0=0.

Conversely, given these equations with lambda invertible, adjoin t with t^3=lambda.
Set C=t Chat,A=t^2 Ahat and use the reconstructed B. The same identities
in reverse give all three original polynomial equations. This works over
parameter algebras, so it preserves the nonreduced schemes.

## Removing the inverse variable

First consider just the polynomial equations e0=e1=e2=0, without inverting
lambda. At a geometric solution with lambda=0, e0 is precisely the
invariant dormant-oper equation for B. Its scheme is reduced of length55,
so B is one of the already enumerated invariant points. Equation e1 then
reads

    F*(Chat*F)''-N0*Chat=0.

For each such B this is a homogeneous linear map on polynomials Chat
of degree at most4. The exact script normalized_oper_lambda_unit.sage
checks that it has rank5 on every one of the six closed points of residue
degrees1,1,2,9,19,23. It stores a nonzero5-by5 minor for each. It also
verifies that the tested B values solve the invariant Groebner basis of
length55 and that their minimal polynomials are distinct irreducibles.
Thus they exhaust all55 geometric points. The certificates are in
Research/computations/normalized_oper_lambda_unit.json.

It follows that Chat=0, contradicting its monic degree-four coefficient.
There are therefore no geometric zeros after adjoining lambda=0. By the
Nullstellensatz, the ideal of the polynomial equations together with lambda
is the unit ideal. Hence lambda is a unit in the entire quotient algebra,
not merely nonzero on its reduced support. Adjoining inv with inv*lambda=1
is consequently an isomorphism, preserving every nilpotent and multiplicity.
This proves the14-variable presentation.

## Length and enumeration

The excluded support consists of55 points, each of full local length8.
The open part therefore has length29375-440=28935. It is the degree-three
etale cover t^3=lambda of the normalized scheme, since lambda is invertible
and characteristic5 does not divide3. Its quotient length is28935/3=9645.

For each geometric quotient point, all three cube roots of lambda give
different c4 values, hence different original tuples. Conversely c4
uniquely recovers t and all normalized coordinates. There are no duplicate
tuples, and etaleness preserves each local length.
