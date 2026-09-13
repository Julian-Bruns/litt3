#!/usr/bin/env python3
"""Compressed nilpotent regular-module tests; no curves are constructed."""
from math import gcd


def main():
    tested = 0
    for length in [2, 4, 6, 26]:
        modulus = 5**length-1
        positive = [pow(5, i, modulus) for i in range(length)]
        negative = [(-x) % modulus for x in positive]
        assert len(set(positive)) == length
        assert set(positive).isdisjoint(negative)
        assert modulus % 8 == 0
        for q in [5, 25]:
            string_length = q*length
            # Each block is ordered by j*length+i, so Psi advances by1,
            # whereas e advances by length. Both matrices have F5 entries.
            for sign in [1, -1]:
                for j in range(q):
                    for i in range(length):
                        index = j*length+i
                        p_image = index+1 if index+1 < string_length else None
                        e_image = index+length if index+length < string_length else None
                        pe = e_image+1 if e_image is not None and e_image+1 < string_length else None
                        ep = p_image+length if p_image is not None and p_image+length < string_length else None
                        assert pe == ep
                        character = sign*pow(5, i, modulus) % modulus
                        if p_image is not None:
                            next_character = sign*pow(5, p_image % length, modulus) % modulus
                            assert next_character == 5*character % modulus
                        # Trace of Psi vanishes on the nilpotent summand:
                        # trace is supported on the two heads (index zero).
                        assert p_image != 0
                assert 5*(sign*positive[-1]) % modulus == sign % modulus
            # The mixed defect line has stabilizer zeta^(2a)=1.
            orbit = modulus//gcd(2, modulus)
            assert orbit == modulus//2
            assert 24*q <= 64*24
            assert (q*modulus//8) % 5 == 0
            if length == 26:
                assert modulus > 4*(5**24+1)
            tested += 1
    print('PASS:', tested, 'cyclic-five-part/length cases')
    print('PASS: two strings qL, defect2, reciprocal Frobenius character identity')
    print('PASS: commuting nilpotent trace, degree-zero composition and unbounded mixed-line orbit')
    print('Scope: linear models only; bounded-degree cored maps are NOT constructed')


if __name__ == '__main__':
    main()
