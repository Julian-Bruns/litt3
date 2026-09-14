# Inertia and the compositum of ramified refinements

Version3,2026-09-14.
[Statement](../../Theorems/quotient_geometry/inertia_generated_core_preserving_refinement.md).

## 1. Core preservation

For a Galois cover with group G, an intermediate quotient by H is
etale exactly when every inertia group acts trivially on G/H.
Thus inertia normally generating G is equivalent to having no nontrivial
etale intermediate cover. This is the genuinely ramified condition;
see [Biswas--Das--Parameswaran, Theorem2.4(1)--(2)](https://arxiv.org/pdf/2203.03246).

Write K=k(X), L=k(Y), M=k(Z), and embed K'/K,L'/L in a separable closure
of M. The intersection K' intersect M is etale over K and hence equals K.
Since K'/K is Galois, it is linearly disjoint from M; likewise for L'.
Put M'=MK'L' and H=Gal(M'/M). Restriction onto both auxiliary Galois
groups is surjective, so

    (K' intersect L')^H=K intersect L=k.

Every element of K' intersect L' satisfies its finite H-orbit polynomial
over k. Algebraic closedness gives K' intersect L'=k.

At a point of Z the original etale maps identify the completed base
fields. By hypothesis the two auxiliary completed extensions agree,
so their compositum is unramified over either. The normalization W
of M' therefore maps etale to X' and Y'. This works for every normalized
component. In the tame case the extension of k((t)) of index n is uniquely
k((t^(1/n))); equality of indices then gives the required equality of
fields. In the wild case the full completed extensions are needed.

## 2. Primitive weight

The canonical-intersection theorem gives an upper shared ring k[t] with
s=c t^m and d=m d'. Rescale t. Since d is prime to the characteristic,
so is m. In a rational frame s_C=a_C eta_C^d, the element

    u_C=t_C/(pi_C^*eta_C)^d'

satisfies u_C^m=a_C. The subextension k(C)(u_C)/k(C) is cyclic Galois
because k contains the m-th roots of unity. A perfect auxiliary group
has no nontrivial cyclic quotient, so u_C belongs to k(C). Hence t_C
descends; its m-th power is the regular tensor s_C, so it is regular
downstairs by valuations. The two descended roots agree on Z up to a
constant m-th root of unity. Rescaling one would contradict the original
primitivity if m>1. Thus m=1.

## 3. Published construction of the auxiliary covers

Use the surface generators x_i,y_i,sigma_j of
[SGA1, XIII, Corollary2.12](https://arxiv.org/pdf/math/0206203#page=306),
with [x,y]=xyx^-1y^-1. Choose x1,y1 generating the nonabelian simple
group G. By
[Liebeck--O'Brien--Shalev--Tiep, The Ore conjecture, Theorem1](https://ems.press/content/serial-article-files/31730?nt=1#page=1),
choose x2,y2 so that

    [x2,y2]=[x1,y1]^-1*(sigma1...sigmar)^-1.

Set the other handle generators to1. The tuple generates G and satisfies

    product_i [xi,yi] * product_j sigma_j=1.

SGA1 realizes this tuple as the required cover when |G| is prime to the
characteristic; its characteristic-zero case is the same surface
presentation. Each inertia group is conjugate to <sigma_j>. Their normal
closure is nontrivial and therefore all of G. Riemann--Hurwitz gives
the stated genus. No enumeration of group elements is needed.

For G=PSL2(F7), simplicity and generation by elementary matrices are
the standard PSL2 facts; see [Elkies, Handout3, paragraphs0--3](https://people.math.harvard.edu/~elkies/M155.15/h3.pdf).
The upper and lower unipotents with entry1 generate, and |G|=7(7²-1)/2=168.
The matrices [[0,1],[-1,t]] for t=0,1,3 have projective orders2,3,4 by
Cayley--Hamilton; the upper unipotent has order7. Hence all the prescribed
mixed-index covers in the statement exist.

For a clump, choose endpoint covers with the same uniform index n.
Their pullbacks have matching completed extensions, so Section1 applies,
and simplicity gives the perfectness needed in Section2. Both MK'/M
and ML'/M have degree168. Consequently

    168 divides [M':M],       [M':M]<=168²,
    [M':K']/[M:K]=[M':L']/[M:L]=[M':M]/168<=168.

These are ramified auxiliary endpoint covers; the two upper horizontal
legs constructed by the compositum are etale.

## 4. Regular transverse Cartier-zero data

The Cartier coefficient criterion excludes E=e/d=4. For E=1,2,3,
choose n=3,2,4 so that n(E+1)=1 in F5. Pullback changes the zero order to

    e'=ne+d(n-1)=n(e+d)-d=0 modulo5.

Rational Cartier commutes with separable pullback. Locally the new tensor
is a(du)^d with a=u^(5m)v and v a unit. Hence ell=a'/(d a)=v'/(d v)
is regular, as is r_s=-ell'/2+ell²/4. The
[rational equation and Cartier test](../projective_connections/coreless_connection_spectrum.md#2-the-rational-equation-and-localization)
make its p-curvature zero. Choose j with 2dj=-1mod5. Removing the
horizontal factor u^(5mj) from the solution a^j gives the jet
(v^j,(v^j)'), whose first coordinate is a unit. Its saturated horizontal
line is everywhere transverse to the oper line. Naturality identifies
these structures through both upper etale maps. For E=0 the same
argument applies on the original curves.

The original [geometric audit](../../Research/audits/INERTIA_REFINEMENT_AUDIT_2026_09_08.md)
covers Sections1,2,4. The Ore--SGA replacement and mixed-inertia
generalization received a bounded medium PASS on2026-09-14.
