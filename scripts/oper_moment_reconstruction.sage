"""Exact cyclic-probe reconstruction, not an original-ideal certificate.

sage scripts/oper_moment_reconstruction.sage metadata.json --bm /tmp/oper_moment_bm --output result.json
Metadata: {"dimension": D, "coordinate_names": ["a1",...],
           "separator": "a9", "sequences": [[s_0,...],[t_1,0,...],...]}
Alternatively omit sequences and give "binary_file": "moments.bin",
"sequence_length": N. Binary is (1+coordinate_count) consecutive rows of
N raw bytes 0..4, first s, then coordinate rows in coordinate_names order.
Paths are relative to metadata. N>=2D suffices; 2D+64 allows extra checks.
JSON coordinate rows may be shorter than s but must have >=D entries.
Output ascending coefficient lists retain P with all multiplicities.
"""
import argparse
import json
import subprocess
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, vector

R = PolynomialRing(GF(5), 'z', implementation='FLINT')
z = R.gen()

def numerator(P, sequence):
    """Polynomial part P(z) sum sequence[j] z^(-j-1), via fast multiply."""
    d = P.degree()
    return (P * R(list(reversed(sequence[:d])))).quo_rem(z**d)[0]

def recurrence_holds(P, sequence):
    # Coefficient n-1-j of this product is sum P_i sequence[j+i].
    n, d = len(sequence), P.degree()
    product = P * R(list(reversed(sequence)))
    return all(product[k] == 0 for k in range(d, n))

def reconstruct(D, names, separator, sequences, bm_executable):
    D = int(D)
    if D <= 0 or len(sequences) != len(names)+1 or len(set(names)) != len(names):
        raise ValueError('Invalid dimension, sequence count or repeated coordinate name')
    if separator not in names:
        raise ValueError('Separator must be one of the named coordinate sequences')
    for seq in sequences:
        if any(int(x) != x or not 0 <= int(x) < 5 for x in seq):
            raise ValueError('Sequences must contain canonical F5 residues')
    s = sequences[0]
    if len(s) < 2*D or any(len(seq) < D for seq in sequences[1:]):
        raise ValueError('Need >=2D scalar moments and >=D of each coordinate')
    raw = subprocess.check_output([str(bm_executable)], input=bytes(s))
    P = R(json.loads(raw)).monic()
    if P.degree() != D:
        raise ValueError('Cyclic probe failed: recurrence degree %s != D=%s; no completeness claim' % (P.degree(), D))
    print('full-degree scalar recurrence', D, flush=True)
    if not recurrence_holds(P, s):
        raise ValueError('FLINT output does not annihilate all supplied scalar moments')
    A = numerator(P, s)
    if A.gcd(P) != 1:
        raise ValueError('Singular Hankel pairing: gcd(A,P) != 1')
    # Sage10.9 generic inverse_mod first delegates to a Singular ideal
    # lifting computation, which is disastrous at degree19290. The native
    # FLINT extended gcd gives the same exact Bezout certificate directly.
    gcd_A, inverse_A, bezout_P = A.xgcd(P)
    if gcd_A != 1 or A*inverse_A+P*bezout_P != 1:
        raise ValueError('FLINT Bezout inverse certificate failed')
    print('exact Bezout inverse checked', flush=True)
    coordinates = {}
    for name, seq in zip(names, sequences[1:]):
        if len(seq) > D and not recurrence_holds(P, seq):
            raise ValueError('Coordinate recurrence failure: ' + name)
        coordinates[name] = (numerator(P, seq) * inverse_A) % P
        print('reconstructed', name, flush=True)
    if coordinates[separator] != z % P:
        raise ValueError('Separator coordinate does not equal z; surjectivity check failed')
    return P, A, coordinates

def read_input(path):
    path = Path(path)
    data = json.loads(path.read_text())
    if 'sequences' not in data:
        raw = (path.parent / data['binary_file']).read_bytes()
        n = int(data['sequence_length'])
        rows = len(data['coordinate_names']) + 1
        if n <= 0 or len(raw) != rows*n:
            raise ValueError('Unexpected binary byte count')
        data['sequences'] = [list(raw[i*n:(i+1)*n]) for i in range(rows)]
    return data

def coeffs(P):
    return [int(c) for c in P.list()]

def self_test(bm):
    # Nonreduced cyclic algebra with two closed factors, lengths 3 and 2.
    P0 = (z-1)**3 * (z*z+2)**2
    D = P0.degree()
    hs = [z, 2+z*z+z**5]
    s = []
    ts = [[], []]
    power = R.one()
    for j in range(2*D+8):
        s.append(int(power[D-1]))
        for seq,h in zip(ts,hs):
            seq.append(int(((power*h) % P0)[D-1]))
        power = power*z % P0
    P,A,coords = reconstruct(D,['x','y'],'x',[s]+ts,bm)
    assert P == P0 and coords['y'] == hs[1] % P0
    # Direct Hankel confirmation in small test only.
    assert matrix(GF(5),D,D,lambda i,j:s[i+j]).is_invertible()
    # Noncyclic F5[u,v]/(u,v)^2, M=multiply by u, ell=u coefficient.
    # It has D=3 but the observed recurrence has degree 2.
    # Collision: F5 x F5 and separator (1,1), D=2, degree 1.
    failures = [(3,[0,1]+[0]*12), (2,[1]*12)]
    for dimension,seq in failures:
        try:
            reconstruct(dimension,['x'],'x',[seq,seq[1:]+[seq[-1]]],bm)
        except ValueError as exc:
            assert 'Cyclic probe failed' in str(exc)
        else:
            raise AssertionError('Noncyclic/collision example incorrectly accepted')
    print('PASS: nonreduced cyclic reconstruction, noncyclic and collision rejection')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('input', nargs='?')
    parser.add_argument('--bm', required=True)
    parser.add_argument('--output')
    parser.add_argument('--self-test', action='store_true')
    args = parser.parse_args()
    if args.self_test:
        self_test(args.bm)
    else:
        if not args.input or not args.output:
            parser.error('input and --output are required unless --self-test')
        data = read_input(args.input)
        P,A,coordinates = reconstruct(data['dimension'], data['coordinate_names'],
                                     data['separator'], data['sequences'], args.bm)
        result = {'status': 'cyclic_probe_reconstructed_original_equations_NOT_verified',
                  'dimension': int(P.degree()), 'characteristic': 5,
                  'P': coeffs(P), 'A': coeffs(A),
                  'coordinate_polynomials': {name:coeffs(h) for name,h in coordinates.items()},
                  'separator': data['separator']}
        Path(args.output).write_text(json.dumps(result,separators=(',',':'),default=int)+'\n')
