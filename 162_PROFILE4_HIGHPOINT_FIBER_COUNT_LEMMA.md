# Profile-4 high-point fiber-count lemma

Date: 2026-06-05.

This records a small new cleanup for the direct profile-4 incidence matrix

```text
M =
[[0,1,3],
 [1,2,1],
 [3,1,0]]
```

with labels ordered as `0,1,infty`.

It does not solve profile 4.  It removes several high-point coincidence
cases uniformly and clarifies exactly what remains before the current
`Q0=P0` double-fiber tower.

## Logarithmic forms

For a map `h` and a label `c in {0,1,infty}`, put

```text
Omega_c(h) = dh/((h-a)(h-b)),       {a,b,c}={0,1,infty}.
```

Thus

```text
Omega_0(h)=dh/(h-1),
Omega_1(h)=dh/h,
Omega_infty(h)=dh/(h(h-1)).
```

Its divisor is

```text
div Omega_c(h) =
  30 P_c(h) - P_a(h) - P_b(h) - E_a(h) - E_b(h).
```

At an unramified boundary point with boundary label `l`, the residue of
`Omega_c(h)` is:

```text
          l=0   l=1   l=infty
c=0        0     1      -1
c=1        1     0      -1
c=infty   -1     1       0
```

## A high-point coincidence gives a low-degree function

Assume `Q_j=P_i`.  Define

```text
Y_{i,j} = Omega_j(r) / Omega_i(x).
```

Then the order-30 terms at the common high point cancel, and

```text
div Y_{i,j}
 =
 (P_a+P_b+F_j) - (Q_c+Q_d+E_i),
```

where `{a,b,i}={0,1,infty}` and `{c,d,j}={0,1,infty}`.  Hence

```text
deg(Y_{i,j}) <= 2 + deg(F_j - E_i)_+
              = 2 + 4 - M_{i,j}
              = 6 - M_{i,j}.
```

Equality holds when there are no other high-point coincidences among the
remaining `P`'s and `Q`'s.  Extra high-point coincidences only cancel more
terms and make the degree smaller, so the contradictions below remain valid.

At every atom `U_{a,b}=E_a cap F_b` with `a != i` and `b != j`, both
logarithmic forms have simple poles, so the value of `Y_{i,j}` is the quotient
of the displayed residues.

## Forced finite fibers

The forced finite-value counts are:

```text
coincidence      M_ij  deg(Y) <=  forced finite-value counts
Q0=P0              0       6      value 1:2, value -1:2
Q1=P0              1       5      value 1:1, value -1:4
Qinfty=P0          3       3      value 1:5, value -1:2

Q0=P1              1       5      value 1:1, value -1:4
Q1=P1              2       4      value -1:6
Qinfty=P1          1       5      value 1:4, value -1:1

Q0=Pinfty          3       3      value 1:5, value -1:2
Q1=Pinfty          1       5      value 1:4, value -1:1
Qinfty=Pinfty      0       6      value 1:2, value -1:2
```

The entries with forced count larger than `deg(Y)` are impossible:

```text
Qinfty=P0,
Q1=P1,
Q0=Pinfty.
```

For instance, if `Q1=P1`, then

```text
Y = Omega_1(r)/Omega_1(x) = (dr/r)/(dx/x)
```

has degree `4`, but it is forced to equal `-1` at the six reduced points

```text
U_{0,infty} + U_{infty,0}.
```

This is exactly the old `Q1=P1` contradiction, but the table shows the same
argument also kills the two entry-`3` coincidences.

## Remaining high-point possibilities

This lemma leaves only:

```text
entry-0 coincidences:
  Q0=P0,  Qinfty=Pinfty;

entry-1 coincidences:
  Q1=P0, Q0=P1, Qinfty=P1, Q1=Pinfty;

and the no-high-point case.
```

The current double-fiber tower addresses the entry-0 case `Q0=P0` with no
other high-point coincidences.  The archive still needs either an elimination
or a reduction for the entry-1 coincidences and for the no-high-point profile-4
case, unless another note already contains such a proof.

Addendum, 2026-06-05: the second entry-0 edge `Qinfty=Pinfty` is equivalent
to `Q0=P0` by simultaneous inversion `x -> 1/x`, `r -> 1/r`.  This preserves
the divisor hypotheses and the incidence matrix, because the matrix is
unchanged by simultaneous interchange of `0` and `infty` in rows and columns.
The standalone partial-progress note contains the full divisor calculation.

Second addendum, 2026-06-05: the paired entry-0 case
`Q0=P0, Qinfty=Pinfty` is now eliminated.  The two logarithmic quotients
`Omega_0(r)/Omega_0(x)` and `Omega_infty(r)/Omega_infty(x)` have degree `5`
and give a birational bidegree `(5,5)` image in `P^1 x P^1`; the boundary
atoms force singularities with branch counts `3,3,2`, so the normalization has
genus at most `16 - (3+3+1) = 9`, contradicting `g(C)=11`.
