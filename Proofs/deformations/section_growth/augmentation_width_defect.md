# A noncommutative augmentation-width bound for actual defect

[Statement](../../../Theorems/deformations/section_growth/augmentation_width_defect.md).

## 1. Actual one-relation presentation and quotients

Use etale_p_witt_obstruction: the linearized actual Hodge operator is
an R-linear map between free modules of equal rank3(g(C)-1), reducing
under augmentation to the actual base operator. Its constant matrix
has corank one. Noncommutative block elimination of its invertible
(r-1)-block gives a scalar Schur entry f in J and cokernel R/(R f).
For left free modules the scalar map is right multiplication by f.

This presentation specializes to every ACTUAL group quotient. If
K is normal in P, the norm N_K identifies the coinvariants of a free
R-module with its K-invariants. On negative curve cohomology the latter
are exactly H1(T/K,T_(T/K)) by Cartan--Leray. Naturality intertwines
the linearized Hodge maps. Therefore tensoring the presentation by
k[P/K] gives the actual defect presentation on T/K. In particular its
scalar entry is the image of f. Frobenius linearization fixes the group
basis and retains the source/target coefficient twist.

## 2. The linear term vanishes geometrically

For any nonzero character chi:P->C5, the actual intermediate C_chi
is a nontrivial cyclic-five cover of C. Its defect is at least two.
Here is the relevant elementary symplectic argument, so this step does
not require the more general inherited odd-growth theorem.

Let E be the actual omega-valued alternating defect bundle on C^(1),
and s its unique section up to scalar. The first two unipotent layers
of the actual cyclic torsor give 0->O->A2->O->0, with extension class
xi. The connecting homomorphism on E is cup product by xi. Under
Serre duality H1(E)=H0(E)^dual, its value on s pairs with s as

    <xi, beta(s,s)>=0.

Since H1(E) has dimension one, the connecting map vanishes. Hence
h0(E tensor A2)=2. This bundle embeds in the actual pushed-down E
on the cyclic cover, so that cover has defect at least two.

If the image of f in k[C5]=k[e]/e^5 had a nonzero linear coefficient,
its cokernel would have length one. The actual cyclic lower bound
therefore forces every such linear coefficient to vanish. Characters
P->C5 separate J/J^2: this quotient is k tensor_F5 P/(P^5[P,P]).
Choosing the coordinate F5-characters already detects all its k-linear
coefficients. Consequently f belongs to J^2.

## 3. The width inequality

Right multiplication by f sends J^i into J^(i+2). Its rank is at most

    dim(R/J^i)+dim J^(i+2).

Thus its cokernel has dimension at least

    dim J^i-dim J^(i+2)=h_i+h_(i+1)

for every i. Taking the maximum proves the theorem. Further actual
etale pullback is injective on defect-bundle sections and preserves
the bound. This proof does not infer equality from an associated
graded rank, nor realize arbitrary algebra elements as Hodge operators.

## 4. Explicit Heisenberg width

Write P=<g,h,c | g^5=h^5=c^5=1, c central, gh=c hg> and
x=g-1,y=h-1,z=c-1. The125 monomials x^i y^j z^l,
0<=i,j,l<5, are a basis: expand binomially in the actual ordered
group basis g^a h^b c^d.

Give x,y weight one and z weight two. Since

    xy-yx=z(1+y)(1+x),

z belongs to J^2. Conversely the reordering identity

    yx=xy+(c^(-1)-1)(1+x)(1+y)

never decreases weight: c^(-1)-1=-z+z^2-z^3+z^4. Hence the span
F_n of weight-at-least-n monomials is multiplicative. As F_1=J,
this proves J^n is contained in F_n. The reverse inclusion follows
from x,y in J and z in J^2. Therefore J^n=F_n exactly.

Its Hilbert polynomial is

    (1+t+t^2+t^3+t^4)^2(1+t^2+t^4+t^6+t^8).

Its coefficient list is

    1,2,4,6,9,10,12,12,13,12,12,10,9,6,4,2,1.

The maximum sum of two adjacent coefficients is25. The same argument
for an odd prime p gives width p^2 for the exponent-p group of orderp^3;
the current geometric assertion only needs p=5.

For the all-odd-p coefficient maximum, multiplying the Hilbert polynomial
by(1+t) gives A_p(t)^2 A_(2p)(t), where A_n=1+...+t^(n-1).
Each coefficient is a partial sum of the nonnegative coefficients of
A_p^2, and the central interval contains all of them. Its maximum is
therefore exactly p^2.

For elementary balanced abelian groups the polynomial is
(1+...+t^(q-1))^rank. Its adjacent coefficient maxima give the other
displayed examples. In rank three this is exactly the A1 balanced
defect formula; the branch A3 example has strictly larger defect.

## 5. Exact checks and remaining boundary

`scripts/deformations/check_augmentation_width.py` constructs the ACTUAL Heisenberg
groups as triples(a,b,c), with multiplication

    (a,b,c)(d,e,f)=(a+d,b+e,c+f+ae).

For p=3 and5 it checks the full group-algebra relation, all powers of
the augmentation ideal by iterated linear algebra, the ordered-basis
weight filtration, and every Hilbert coefficient. It also checks the
three abelian formulas for q=5,25,125. Replay takes0.37seconds after
startup. Receipt: Research/computations/augmentation_width_checks.json.

The independent audit uses a different ordered-word group convention,
both left and right radical generation, and every index-p quotient norm
matrix for p=3,5. All common outputs match. Its script and receipt are
`scripts/deformations/audit_augmentation_width.py` and
`Research/computations/augmentation_width_audit.json`.

The arbitrary sample algebra elements in that receipt are only tests
of the inequality. They are not actual connections, counterexamples,
or exact geometric defect computations.

[Focused audit](../../../Research/audits/AUGMENTATION_WIDTH_DEFECT_AUDIT_2026_09_11.md).
The result concerns actual Galois five-group covers; it does not
settle non-Galois neutral descent.
