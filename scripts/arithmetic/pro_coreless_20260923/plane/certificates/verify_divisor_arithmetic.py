"""Check integer divisor identities and local numerical orders in the report.

These are consistency checks. They are not a replacement for geometric
proofs of saturation, descent, or existence/nonexistence on a cover.
"""
import json


def plus(a, b):
    return tuple(x+y for x, y in zip(a, b))


def times(c, a):
    return tuple(c*x for x in a)


def minus(a, b):
    return plus(a, times(-1, b))


def run():
    # Coordinates are [E, Delta, G, H]; R=E+Delta.
    E, D, G, H = (1,0,0,0), (0,1,0,0), (0,0,1,0), (0,0,0,1)
    R = plus(E,D)
    q = minus(minus(times(3,E),times(5,G)),times(10,H))
    df = minus(times(2,R),times(10,H))
    T = minus(minus(E,G),times(4,H))
    d_q_squared = plus(q,df)
    assert d_q_squared == plus(times(5,T),times(2,D))
    z = minus(E,times(5,H))
    u = minus(times(3,z),q)
    assert u == times(5,minus(G,H))
    dg = minus(d_q_squared,times(5,z))
    assert dg == plus(times(5,minus(H,G)),times(2,D))
    assert plus(u,dg) == times(2,D)
    w = minus(z,u)
    assert w == minus(E,times(5,G))
    degree_weights = (5,8,1,1)
    degree = lambda a: sum(x*y for x,y in zip(a,degree_weights))
    assert all(degree(a) == 0 for a in (q,T,z,u,w))
    assert degree(df) == degree(dg) == 16
    # Local primitive monomials: saturation order is floor(ord(dg)/5).
    local_checks = 0
    for exponent in range(-80,81):
        if exponent % 5:
            section_order = exponent // 5
            derivative_order = exponent - 1
            assert derivative_order // 5 == section_order
            assert derivative_order - 5*section_order in (0,1,2,3)
            local_checks += 1
    # Q_D modification locally uses a,t^5*b with evaluation orders 2,5.
    assert min(2,5) == 2
    assert 5-2 == 3
    # Coefficients of n in the global numerical identities.
    assert 19-3*8 == -5
    assert 16-2*8 == 0
    assert (19-3*8)-(16-2*8) == 3-8 == -5
    assert 5+8 == 13  # h^1 of degree -5n on genus 8n+1
    assert 19-8 == 11  # degree of the horizontality-obstruction line
    return {"status":"PASS", "divisor_coordinate_order":["E","Delta","G","H"],
            "div_q":q, "div_df":df, "T":T, "div_z":z,
            "div_u":u, "div_dg":dg, "div_w":w,
            "primitive_monomial_cases_checked":local_checks,
            "kernel_degree_coefficient":-5,
            "splitting_obstruction_dimension_coefficient":13,
            "horizontality_line_degree_coefficient":11,
            "scope":"Symbolic integer consistency checks only; no all-cover existence claim."}


if __name__ == '__main__':
    print(json.dumps(run(),indent=2))
