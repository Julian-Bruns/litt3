# Proof of the actual weak PSL-eight invariant five-torsors and Sylow ledger

This proves the
[statement](../../../Theorems/quotient_geometry/local_actions/actual_psl_eight_weak_curve_invariant_five_torsors_and_sylow_ledger.md).
Its new actual-curve arguments have a fresh focused
[independent audit PASS](../../../Research/notes/oct03_ten_hour/eight_module_actual_curve_p_torsors_and_sylow_five_audit.md).
The audited author note had SHA-256
8ac2e3c32f6b0c71233dfb325ebc5669b4f0e863020f47f34a1135bf7fbfb987.
This record preserves that proof without numerical replay.

## Actual hypotheses and settled inputs

Let $k=\overline{\mathbf F}_5$, let $Q=\operatorname{PSL}_8(\mathbf F_5)$,
and suppose $Q$ acts faithfully on an actual smooth projective connected
curve $D$. Require $D/Q=B=\mathbf P^1$, with exactly TWO branch values:
one has inertia $I\simeq C_5$ and lower break one, and the other has tame
inertia $C_2$. These are two coarse branch values, not three. For the Sylow ledger only, additionally require the
order-five inertia class to be the projective image of a unipotent matrix
with Jordan type $J_5+J_3$ in the natural eight-dimensional module.
The invariant-torsor classification uses no Jordan-class hypothesis.
The accepted abstract tuple has this class, but does not supply the
actual curve. Its balanced involution class may also be retained;
the findings below use only its order two.

The settled primary group input is that
$H_0=\operatorname{SL}_8(\mathbf F_5)$ is centrally closed. Its scalar
center is $C_4$, so $H_0\to Q$ is the universal central extension. Since
$Q$ is perfect, this gives
\[H^1(Q,C_{5^m})=H^2(Q,C_{5^m})=0\qquad(m\ge1),\]
with trivial coefficient action. The central-closure input and its exact
Steinberg citation are recorded in
[the accepted source half-class proof](canonical_ten_source_half_class_and_full_linear_kernel_constraints.md).
No matrix or finite-group enumeration is needed here.

Write $f_5(C)=\dim_{\mathbf F_5}H^1_{\mathrm{et}}(C,\mathbf F_5)$ for
the p-rank. The actual Hurwitz formula gives
\[g(D)-1=|Q|/20.\]
Indeed the wild different is eight and the tame different is one, so
$2g(D)-2=|Q|(-2+8/5+1/2)=|Q|/10$.

## Exact invariant étale p-torsors

**Claim.** There is a unique one-dimensional invariant line
\[H^1_{\mathrm{et}}(D,\mathbf F_5)^Q\simeq\mathbf F_5.\]
Its nonzero classes are the four markings of the same connected étale
$C_5$ cover. More generally, naturally up to the choice of its generator,
\[H^1_{\mathrm{et}}(D,\mathbf Z/5^n)^Q
\simeq\operatorname{Hom}(C_5,\mathbf Z/5^n)\simeq C_5
\qquad(n\ge1).\]
Every reduction map from level $n+1$ to level $n$ is ZERO on these invariant
groups. In particular the nonzero invariant mod-five class has no invariant
lift to a surjective $C_{25}$ torsor, and
$H^1_{\mathrm{et}}(D,\mathbf Z_5)^Q=0$.

Choose a coarse coordinate $\beta$ with the wild branch at infinity.
The actual weak completed $C_5$ extension over $k((\beta^{-1}))$ has an
Artin--Schreier description
\[u^5-u=a\beta,\qquad a\in k^*.\]
Regular tails are Artin--Schreier coboundaries because the residue field is
algebraically closed. The scalar $a$ is determined up to $\mathbf F_5^*$;
its fourth power is the fixed-base local invariant in the
[accepted weak completed-extension theorem](../../../Theorems/quotient_geometry/weak_local_completed_extension_invariant.md)
and [its proof](../../../Proofs/quotient_geometry/weak_local_completed_extension_invariant.md).
All points of the single wild fiber have this same completed extension over
the SAME completed coarse field, since the actual $Q$ action is transitive.

Let $U\to B$ be the global Artin--Schreier cover $u^5-u=a\beta$. It is
a $C_5$ cover of $\mathbf P^1$ branched only at infinity. Normalize the
fiber product $D\times_B U$, calling the result $D'$. At the wild branch,
the two completed extensions coincide, so their normalized tensor product
splits over the completed field of $D$ and introduces no ramification.
At every other point $U\to B$ is unramified. Thus $D'\to D$ is finite
étale. It is connected: a nontrivial intersection of the two Galois fields
over $k(B)$ would contain the whole degree-five field $k(U)$ and give a
$C_5$ quotient of the perfect group $Q$. Its group over $B$ is therefore
exactly $Q\times C_5$, so its marked torsor class is $Q$-invariant and
nonzero. This proves existence of the invariant line.

For the converse, first take a nonzero $Q$-invariant class whose connected
image cover $V\to D$ has group $C_{5^m}$. The use of the connected image
is essential: a class with coefficients $\mathbf Z/5^n$ need not be
surjective to that full coefficient group. Invariance supplies an
extension of the group of transports
\[1\longrightarrow C_{5^m}\longrightarrow E\longrightarrow Q
\longrightarrow1.\]
It is central because the marked class is fixed, and it splits because
$H^2(Q,C_{5^m})=0$. Thus $E=Q\times C_{5^m}$ acts on the connected
curve $V$. Quotient by the $Q$ factor to obtain an actual connected cyclic
cover $W\to B$ with group $C_{5^m}$.

Since $V\to D$ is étale, its point stabilizers over $B$ project
isomorphically onto the stabilizers of $D\to B$. At the tame value,
their images in $C_{5^m}$ are trivial. At the sole wild value, the image
has order at most five. Because this cyclic group is abelian, the subgroup
generated by every inertia group is therefore of order at most five.
Quotienting by it would give an étale connected cover of $\mathbf P^1$.
Hurwitz rules out a nontrivial such cover. Consequently $m\le1$.
For a nonzero class $m=1$, and the wild inertia image must be nontrivial.
The completed extension of $W\to B$ is then the SAME weak extension
as that of $D\to B$, since the completed field of $V$ equals that of
$D$ at an étale point.

A cyclic-five cover of $\mathbf P^1$ with only this branch and break one
has reduced Artin--Schreier equation $w^5-w=b\beta$; a constant term can
be removed. The fixed-base completed classification forces
$b/a\in\mathbf F_5^*$. Equivalently the local restriction kernel is the
single line spanned by $a\beta$. There is no global unramified difference
on $\mathbf P^1$. Hence every nonzero invariant $C_5$ class lies in the
line already constructed.

For coefficients $\mathbf Z/5^n$, the connected-image argument shows that
every invariant class has image of order at most five. The inclusion of
its coefficient subgroup $C_5=(\mathbf Z/5^n)[5]$ is injective on
$H^1$, since this cohomology is the group of continuous homomorphisms from
the actual fundamental group. Therefore the invariant classes are exactly
the images of the unique $\mathbf F_5$ line under multiplication by
$5^{n-1}$. Reduction from level $n+1$ to level $n$ kills that subgroup,
proving the asserted zero transition maps.

This concerns constant étale $C_5$ torsors. It does not assert a
$Q$-invariant p-torsion point of $\operatorname{Pic}(D)$. Those two
modular representations are dual, and their invariants and coinvariants
must not be identified through a semisimplicity assumption.

The same actual cover $D'\to U$ is $Q$-Galois and has exactly five tame
$C_2$ branch values; its wild ramification has disappeared. In particular
\[g(D')-1=|Q|/4,\qquad f_5(D')-1=5(f_5(D)-1).\]
The p-rank equality uses the actual étale cyclic-five cover, not the
prime-to-five Humbert refinement.

## The exact number of Sylow-five short orbits

Let $P$ be a Sylow-five subgroup of $Q$, represented by upper unitriangular
matrices, so $|P|=5^{28}$. Let $\mathcal B$ be its upper triangular Borel
subgroup in $Q$. Its torus has order $4^6$, hence
$|\mathcal B|=5^{28}4^6$.

For an inertia generator $a$ of type $(5,3)$, its matrix centralizer in
$\operatorname{GL}_8(\mathbf F_5)$ has order $5^{12}4^2$. Here the
endomorphism algebra over $\mathbf F_5[t]$ has dimension
$5+3+3+3=14$, and its semisimple quotient is
$\mathbf F_5\times\mathbf F_5$, leaving a radical of dimension twelve.
The determinant map is surjective: block scalars $(r,s)$ have determinant
$r^5s^3$. Thus the centralizer in $\operatorname{SL}_8$ has order
$5^{12}4$, and
\[|C_Q(a)|=5^{12}.\]
There are no extra projective centralizers: conjugacy from the unipotent
matrix to a nontrivial scalar multiple would change its sole eigenvalue.
All four nontrivial powers of $a$ have the same Jordan type and are
conjugate inside $\operatorname{SL}_8$, since a general linear conjugator
can have its determinant corrected in the centralizer. Hence
$|N_Q(\langle a\rangle)|=4\cdot5^{12}$.

We next count the complete $\mathbf F_5$ flags fixed by $a$ without a
published counting formula. For two Jordan blocks of sizes $r\ge s$,
write $F_{r,s}(q)$ for the stable complete-flag count over $\mathbf F_q$.
The kernel has dimension two when $s>0$. If $r>s$, precisely one kernel
line is the head of the longer block; quotienting by it gives type
$(r-1,s)$. The other $q$ lines give type $(r,s-1)$. If $r=s$, all
$q+1$ lines give type $(r,r-1)$. Therefore
\[F_{r,0}=1,\qquad
F_{r,s}=F_{r-1,s}+qF_{r,s-1}\ (r>s>0),\qquad
F_{r,r}=(q+1)F_{r,r-1}.\]
The recursive first-column choice is bijective with stable flags of the
quotient, so these relations count every flag exactly once. The needed
intermediate polynomials are:

| Partition | Stable complete-flag polynomial |
|---|---|
| $(r,1)$ | $1+rq$ |
| $(2,2)$ | $1+3q+2q^2$ |
| $(3,2)$ | $1+4q+5q^2$ |
| $(4,2)$ | $1+5q+9q^2$ |
| $(5,2)$ | $1+6q+14q^2$ |
| $(3,3)$ | $1+5q+9q^2+5q^3$ |
| $(4,3)$ | $1+6q+14q^2+14q^3$ |
| $(5,3)$ | $1+7q+20q^2+28q^3$ |

In particular $F_{5,3}(5)=4036$. Complete flags are the cosets
$Q/\mathcal B$. Counting fixed cosets gives
\[|a^Q\cap P|=\frac{|\mathcal B|F_{5,3}(5)}{|C_Q(a)|}.\]
The intersection with the Borel is the intersection with $P$, because
the unique order-five matrix lift is unipotent and hence has diagonal
entries one in an upper triangular basis.

The wild fiber of $D\to B$ is the single orbit $Q/\langle a\rangle$.
For each subgroup $J\subset P$ conjugate to $\langle a\rangle$, there
are $|N_Q(\langle a\rangle)|/5$ points whose stabilizer is precisely $J$.
There are $|a^Q\cap P|/4$ such subgroups. Every $P$ short orbit has
length $|P|/5=5^{27}$; the tame fiber supplies none. Thus the exact
number of short orbits is
\[\kappa=\frac{|a^Q\cap P|}{4}
\frac{|N_Q(\langle a\rangle)|}{|P|}
=4^6F_{5,3}(5)=16,531,456.\]

## Hurwitz and Deuring--Shafarevich consequences

Put $E=D/P$. The stabilizer at every short orbit is weak $C_5$, with
different eight. Hurwitz and Deuring--Shafarevich give, respectively,
\[g(D)-1=5^{28}(g(E)-1)+4\kappa5^{27},\]
\[f_5(D)-1=5^{28}(f_5(E)-1)+4\kappa5^{27}.\]
The p-rank formula is the standard short-orbit Deuring--Shafarevich
formula for p-group actions; a primary research source states it explicitly
as equation (5) in
[Korchmáros--Montanucci, Ordinary algebraic curves with many automorphisms, §2](https://msp.org/ant/2019/13-1/ant-v13-n1-p01-s.pdf#page=4).
It requires no ordinarity assumption. Weak ramification is used in the
Hurwitz comparison, not to replace the p-rank formula.

Consequently
\[g(D)-f_5(D)=5^{28}(g(E)-f_5(E)),\]
and
\[f_5(D)\ge1+(4\kappa-5)5^{27}
=1+66,125,819\cdot5^{27}.\]
In particular p-rank zero, p-rank one, and every p-rank below this bound
are excluded for this actual curve class. The p-rank defect is divisible
by $5^{28}$, and $D$ is ordinary exactly when $D/P$ is ordinary.
None of these conclusions forces ordinarity.

For a copyable exact quotient-genus expression, set
\[M=\frac{|Q|}{20\cdot5^{27}}
=\frac1{16}\prod_{i=2}^8(5^i-1).\]
Then
\[g(E)=1+\frac{M-4\kappa}{5},\qquad
f_5(D)=1+5^{27}\bigl(5f_5(E)-5+4\kappa\bigr).\]
These leave a large nonempty numerical range. They are necessary
conditions, not an exclusion of every actual $D$.

## Transfer to an actual free kernel: explicit additional hypothesis

Suppose an actual original group $G$ acts on $\Gamma$, with free kernel
$N$ and $D=\Gamma/N$ as in the retained source diagram. If
$5\nmid|N|$, then pullback
\[H^1_{\mathrm{et}}(D,\mathbf F_5)
\longrightarrow H^1_{\mathrm{et}}(\Gamma,\mathbf F_5)\]
is injective: trace composed with pullback is multiplication by the
invertible degree $|N|$. Therefore the same lower p-rank bound holds for
$\Gamma$. The unique invariant line on $D$ pulls back nontrivially and
is $G$-invariant. Coprime group cohomology gives
$H^2(G,C_{5^m})\simeq H^2(Q,C_{5^m})=0$, so the same connected-image
argument also gives
$H^1_{\mathrm{et}}(\Gamma,\mathbf F_5)^G\simeq\mathbf F_5$ and the
same order-$5^n$ nonlifting conclusion. This applies in particular to a
two-group kernel, including the abstract elementary two-kernel candidate
if an actual carrier were ever supplied.

The general necessary even kernel need not be prime to five. In that
case the injective transfer and the $G$-invariant classification above
are not asserted; a degree divisible by five can kill an étale-five
torsor under pullback. The conclusions on the actual quotient $D$ remain
valid regardless of the order of $N$.

No original map $T\to X$ is descended to $D$, $D'$, or $\Gamma/N$.
The actual two original finite étale legs on $T$ remain required.
Neither the new p-rank ledger nor the invariant p-torsor line provides
the missing geometric source or solves the common-cover problem.
