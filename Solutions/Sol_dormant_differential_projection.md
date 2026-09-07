# Proof: a dormant operator, its third-order partner, and horizontal classes

[Statement](../Theorems/Thm_dormant_differential_projection.md).
Use the fixed curve, delta, theta, t, affine ring Acal, and reductions of
`scalar_hermitian_data`. All arguments fix a geometric oper. They do not
assert a construction over its possibly nonreduced parameter scheme.

## 1. The two operators on the function field

Write K=k(C). Dormancy gives a horizontal basis U,T over K^5, normalized
by U delta T-T delta U=1. As delta^5 is a derivation, it is b delta
for some b in K. Applying this identity to both basis solutions, and
using L_r U=L_r T=0, gives

    delta^3 P=P delta P,    b=3 delta^2 P+P^2,    delta b=0.

Indeed delta^5 U=(delta^3 P+4P delta P)U+
(3 delta^2 P+P^2)delta U, and the two horizontal columns are independent.
Direct operator multiplication now gives Q_r L_r=L_r Q_r=delta^5-b delta=0.
The kernel of L_r has K^5-dimension2. A nonzero differential operator of
order j<5 has kernel dimension at most j: factor out a nonzero solution
and induct on the order. Thus Q_r has kernel dimension at most3. As
im L_r has dimension3 and is contained in that kernel, both asserted
field exactness identities follow.

Q_r is also the symmetric-square equation: it annihilates U^2, UT, T^2.
This follows by differentiating those products and using delta^2 U=P U.
It explains the appearance of a third-order partner without any lifting.

## 2. Exactness including the point O

For every integer n, the scalar realization identifies W(nO) with the
horizontal functions in F_*O((5n-8)O). To see the local regularity
precisely, set h=t^(5n-8)f. The oper coordinates of a horizontal section
are (h,t^16 delta h); since t^16 delta is regular at O, they are regular
if and only if h is regular. This proves the assertion also for negative n.

At O, delta t=3t^-16(1+O(t^3)) and P=2t^-34+O(t^-32).
The leading coefficient of L_r(t^j) at exponent j-34 is
9j(j-17)-2. It vanishes for j=-32,-31. Hence L_r maps O32 into O64.
For Q_r the leading coefficient at exponent j-51 is

    2j(j-2)(j-4)+j+3.

It vanishes for j=-64,-63,-62. The only further term possibly below
exponent -112 comes from P's t^-32 coefficient, say p2, on t^-64.
Its coefficient is p2(3j+9(-32))=0 when j=-64. The error in delta t
starts three orders higher. Therefore Q_r maps O64 into O112, and
L_r Q_r=0 places its image in the scalar realization of W24.

The images L_r(t^-30), L_r(t^-29), L_r(t^-28) have distinct leading
poles64,63,62, with coefficients3,4,3. These are independent in the
Frobenius fiber of F_*O64. Likewise Q_r(t^-61), Q_r(t^-60) have leading
poles112,111, with coefficients2,3. In W24 coordinates (h,t^16 delta h)
their fiber columns are independent. Thus the maps have fiber ranks3,2
at O.

Away from O take local horizontal sections U,T with U a unit and
Wronskian1. The etale coordinate z=T/U satisfies delta z=U^-2. One has

    L_r f=U^-3 partial_z^2(f/U),
    Q_r f=U^-9 partial_z^3(U^3 f).

The first identity is direct differentiation. For the second, both
operators have the same leading symbol and annihilate U^-3 times
1,z,z^2 (equivalently the symmetric-square solutions up to fifth powers).
Their difference has order at most2 and three independent solutions,
so is zero. The displayed local forms give split Frobenius ranks3,2.
The generic exactness from Section1 consequently extends everywhere,
proving (1). Twisting proves the stated integer-n versions.

Let I=im L_r in (1). The first short exact sequence gives H1(I)=0:
H1(O32)=0 and a curve has no H2. The second then gives surjectivity
of global Q_r. Stability and Riemann--Roch give h0(W24)=32; dim L64=56.
Thus dim ker Q_r=24. The first sequence also shows
ker Q_r/im(L_r on L32)=H1(W8), of dimension h0(W8), because chi(W8)=0.

## 3. The intrinsic horizontal 32-space

The scalar inclusion W(-8O)->F_*O(-48O) has quotient equal to the
image of L_r, contained even in F_*O(-14O). That negative line bundle
has no global sections. Thus the induced H1 map is injective, with
32-dimensional source (stability and Riemann--Roch). Its image consists
exactly of cohomology classes with rational horizontal representatives,
using the affine/open-neighborhood Cech presentation and its scalar
horizontal frame. The scalar image is a k-subspace because k is perfect;
the map before transporting coefficients is Frobenius-semilinear.

Delta is anti-self-adjoint for the local residue pairing with theta:
delta f theta=df and residues of exact Laurent differentials vanish.
Consequently L_r is self-adjoint. If Y is rational horizontal and
h in L64 satisfies Q_r h=0, Section1 supplies rational f with h=L_r f.
Formal integration by parts at O gives

    Res_O(Y h theta)=Res_O(f L_r Y theta)=0.

Replacing Y by rho48(Y) preserves this pairing. The removed affine
part contributes zero by the global residue theorem, while t48Rcal
times h theta is regular. Thus the horizontal image is contained in
Ann(ker Q_r), and both have dimension32. They are equal, proving (2).
This argument does not equate ker Q_r with im L_r on bounded globals.

## 4. The full tensor comparison and the R-image

Similarly W(-24O)->F_*O(-128O) has quotient contained in F_*O(-94O).
Its H1 map is therefore a fixed injection of dimension64 into dimension136.
On Cech cochains the cup product u tensor eta maps to U eta^5.
It follows BEFORE taking kernels that the old principal-part tensor is
J times the new64-row cup-product tensor, for a single injective matrix J.
In absolute Frobenius conventions the cup-product matrix is first raised
entrywise to the fifth power; the Wronskian/residue definition of Ntilde
already incorporates exactly this power. This comparison holds for
arbitrary sums, not only for individual U pencils.

Take such a tensor in the common kernel. Write its scalar product as
H=sum U_i eta_i^5. Then T=-aff(H), V=rem(H) satisfy val_O V>=128.
Since L_r H=0, L_r T=L_r V. The former is affine and the latter has
positive valuation at least94, so both vanish on the projective curve.
The unreduced R-output is

    Y=kappa^5 V-sum U_i(-rho32(delta eta_i))^5.

Every summand is horizontal. Section3 therefore places rho48 Y in J_r.
This proves (3), including arbitrary sums and all restricted sieve tensors.

## Evidence and limitations

The bounded audit linked from the statement checked the full-tensor
comparison, local pole cancellations, exactness and uniform annihilator
argument. `wronskian_differential_projection.sage` additionally verifies
the operators, all56 monomial images, rank32, and the kernel for the first
new F25 oper; its JSON is saved under Research/computations. This computation
is corroboration, not the reason the theorem holds for all opers.

The theorem removes24 eta coordinates universally. Nonzero decomposable
tensors, the Wronskian normalization, and the Frobenius fixed-point equation
still have to be excluded; the theorem alone does none of those things.
