#!/usr/bin/env python3
"""Reconstruct every endpoint constant from P,A; standard library only."""
from pathlib import Path
import argparse
import json
from ff25 import *

ROOT = Path(__file__).resolve().parents[1]
MOD = [5, 2, 6, 7, 1]

def kmul(a, b):
    return pmod(pmul(a, b), MOD)

def kpow(a, n):
    if n < 0:
        return kpow(kpow(a, 25**4-2), -n)
    out = [1]
    while n:
        if n & 1:
            out = kmul(out, a)
        a = kmul(a, a)
        n //= 2
    return out

def kdiv(a, b):
    if trim(b) == [0]:
        raise ZeroDivisionError("zero in F_(25^4)")
    return kmul(a, kpow(b, 25**4-2))

def kval(p, a):
    c = [0]
    for z in p[::-1]:
        c = padd(kmul(c, a), [z])
    return c

def reconstruct():
    alpha = [0, 1]
    ap = kval(pder(A), alpha)
    app = kval(pder(pder(A)), alpha)
    pa = kval(P, alpha)
    pp = kval(pder(P), alpha)
    B = kdiv(pscale(kmul(kpow(ap, 3), kpow(pa, 2)), 3), [pow_(A[4], 3)])
    b = kpow(B, pow(29, -1, 25**4-1))
    lam = kdiv(pscale(kpow(b, 4), A[4]), ap)
    C = kmul(kmul(b, lam), padd(kdiv(pp, pa), kdiv(app, pscale(ap, 4))))
    M = psub(pscale(kdiv(kmul(lam, C), b), 4), kmul(kdiv(app, pscale(ap, 2)), kpow(lam, 2)))
    return {name: [kpow(z, 25**i) for i in range(4)]
            for name, z in [('alpha', alpha), ('b', b), ('lambda', lam), ('C', C), ('M', M)]}

def header_text(data, zeta_modulus):
    text = 'static const unsigned char AM[4] = {5,2,6,7};\n'
    text += 'static const unsigned char ZM[7] = {' + ','.join(map(str, zeta_modulus[:-1])) + '};\n'
    for name in ['C', 'M']:
        text += 'static const unsigned char ' + name + 'COEFF[4][4] = {'
        text += ','.join('{' + ','.join(map(str, x + [0]*(4-len(x)))) + '}' for x in data[name])
        text += '};\n'
    return text

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true', help='compare with retained JSON and C++ constants')
    parser.add_argument('--output-dir', type=Path, help='write reconstructed JSON/header to this directory')
    args = parser.parse_args()
    data = reconstruct()
    fields = json.loads((ROOT/'data/field_data.json').read_text())
    header = header_text(data, fields['zeta_modulus'])
    if args.check:
        assert data == json.loads((ROOT/'data/endpoint_data.json').read_text())
        assert header == (ROOT/'src/field_constants.h').read_text()
        print('PASS: all endpoint constants and the C++ header reconstructed from P,A')
    if args.output_dir:
        args.output_dir.mkdir(parents=True, exist_ok=True)
        (args.output_dir/'endpoint_data.json').write_text(json.dumps(data, indent=2)+'\n')
        (args.output_dir/'field_constants.h').write_text(header)
    if not args.check and not args.output_dir:
        print(json.dumps(data, indent=2))

if __name__ == '__main__':
    main()
