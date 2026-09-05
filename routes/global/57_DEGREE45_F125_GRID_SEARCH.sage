"""
Exact finite search for the degree-45 families-preserving endpoint.

For every F_125-isomorphism class of elliptic curves E, every nonzero
T in E(F_125)[28], and every possible high point P != O, the divisor

    (P+T) + (O) - (P) - (T)

determines a degree-two function A_P up to a scalar.  Only the class of
that scalar modulo mu_31 matters for the equation A_P^31 = 1, so there
are four possible level sets.  A degree-45 pair from file 57 would give
two distinct P's whose corresponding level sets meet in at least 44
points.  This script computes the largest such intersection exactly.

It deliberately tests only the necessary 44-point condition.  Therefore
an output below 44 is a certificate of nonexistence; an output at least
44 would merely leave candidates for the full ramification test.
"""

K.<z> = GF(5^3)
primitive = K.multiplicative_generator()
eta = primitive^31
quartic_label = {eta^e: e for e in range(4)}


def elliptic_curve_representatives():
    """One representative of every F_125-isomorphism class (char != 2,3)."""
    curves = []
    j1728 = K(1728)

    # For j not 0 or 1728 there are the curve and its quadratic twist.
    # The displayed coefficients give the prescribed j-invariant.
    for j in K:
        if j == 0 or j == j1728:
            continue
        den = j1728 - j
        a = 3*j/den
        b = 2*j/den
        curves.append(EllipticCurve(K, [a, b]))
        curves.append(EllipticCurve(K,
                                    [primitive^2*a, primitive^3*b]))

    # At j=0, twists are indexed by K^*/(K^*)^6, of order gcd(6,124)=2.
    curves.append(EllipticCurve(K, [0, 1]))
    curves.append(EllipticCurve(K, [0, primitive]))

    # At j=1728, twists are indexed by K^*/(K^*)^4, of order four.
    for e in range(4):
        curves.append(EllipticCurve(K, [primitive^e, 0]))

    assert len(curves) == 252
    return curves


def cross_ratio_value(E, P, T, R):
    r"""Value at R of a function with divisor (P+T)+(O)-(P)-(T).

    The function is the reciprocal of the usual Miller line function
    g_{P,T}.  Return None at a zero or pole; such a point never lies over
    mu_31.  The second formula handles the removable 0/0 at -(P+T).
    """
    O = E(0)
    S = P + T
    if R == O or R == S or R == P or R == T:
        return None

    xP, yP = P[0], P[1]
    xT, yT = T[0], T[1]
    xR, yR = R[0], R[1]

    if S == O:
        # Here T=-P and g_{P,T}=x-x(P).
        return 1/(xR-xP)

    if P == T:
        a = E.a4()
        slope = (3*xP^2+a)/(2*yP)
    else:
        slope = (yT-yP)/(xT-xP)

    line_at_R = yR-yP-slope*(xR-xP)
    vertical_at_R = xR-S[0]
    if vertical_at_R != 0:
        return vertical_at_R/line_at_R

    # R= -S is the removable common zero of the line and vertical line.
    # From (y-L)(y+L)=(x-xP)(x-xT)(x-xS), where
    # L=yP+slope*(x-xP), one gets the following regular value for 1/g.
    L_at_R = yP+slope*(xR-xP)
    return (yR+L_at_R)/((xR-xP)*(xR-xT))


def four_level_sets(E, points, P, T):
    """Bit sets for the four cosets of mu_31 attained by A_P."""
    sets = [0, 0, 0, 0]
    for idx, R in enumerate(points):
        value = cross_ratio_value(E, P, T, R)
        if value is None:
            continue
        label = quartic_label[value^31]
        sets[label] |= (1 << idx)
    excluded = {E(0), P+T, P, T}
    assert sum(int(level).bit_count() for level in sets) == \
           len(points)-len(excluded)
    return sets


def search():
    global_best = -1
    witnesses = []
    curves_with_torsion = 0
    torsion_points_tested = 0
    pairs_tested = 0

    for curve_index, E in enumerate(elliptic_curve_representatives()):
        points = list(E.points())
        O = E(0)
        nonzero_28_torsion = [T for T in points
                              if T != O and 28*T == O]
        if not nonzero_28_torsion:
            continue
        curves_with_torsion += 1

        possible_high_points = [P for P in points if P != O]
        for T in nonzero_28_torsion:
            torsion_points_tested += 1
            level_sets = [four_level_sets(E, points, P, T)
                          for P in possible_high_points]

            for i in range(len(possible_high_points)):
                for j in range(i+1, len(possible_high_points)):
                    pairs_tested += 1
                    best = 0
                    for left in level_sets[i]:
                        for right in level_sets[j]:
                            overlap = int(left & right).bit_count()
                            if overlap > best:
                                best = overlap
                    if best > global_best:
                        global_best = best
                        witnesses = [(curve_index, E.ainvs(),
                                      E.cardinality(), T,
                                      possible_high_points[i],
                                      possible_high_points[j], best)]
                        print("new maximum", witnesses[-1])
                    elif best == global_best:
                        witnesses.append((curve_index, E.ainvs(),
                                          E.cardinality(), T,
                                          possible_high_points[i],
                                          possible_high_points[j], best))

    print("curves", 252)
    print("curves_with_nonzero_rational_28_torsion", curves_with_torsion)
    print("torsion_points_tested", torsion_points_tested)
    print("unordered_high_point_pairs_tested", pairs_tested)
    print("global_maximum_distinct_grid_intersection", global_best)
    print("number_of_maximizers", len(witnesses))
    for witness in witnesses[:20]:
        print("maximizer", witness)

    # These totals make an incomplete or altered run fail loudly.
    assert curves_with_torsion == 186
    assert torsion_points_tested == 1256
    assert pairs_tested == 9580970
    assert global_best == 32
    assert len(witnesses) == 9


search()
