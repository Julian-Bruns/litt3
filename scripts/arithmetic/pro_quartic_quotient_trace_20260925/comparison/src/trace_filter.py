#!/usr/bin/env python3
"""Check the universal necessary trace identity for one profile and two endpoint multisets.

Passing this filter is NOT a curve, Kummer, irreducibility or etale certificate.
The profile is ordered at zeta^j, j=0..28.  Only its residues modulo five enter.
"""
from pathlib import Path
import argparse
import json
from field_tower import *


def check(profile, infinity_labels, zero_labels):
    if len(profile)!=29 or any(not isinstance(d,int) or not 0<=d<=6 for d in profile):
        raise ValueError('profile must consist of 29 integers in 0..6')
    Cinf = endpoint_sum(infinity_labels,C_LABELS)
    Minf = endpoint_sum(infinity_labels,M_LABELS)
    C0 = endpoint_sum(zero_labels,C_LABELS)
    M0 = endpoint_sum(zero_labels,M_LABELS)
    moments = {}
    for exponent in (-6,-2,2,6):
        s = ZERO
        for j,d in enumerate(profile):
            s = eadd(s,emul(scalar(d%5),ZPOW[exponent*j % 29]))
        moments[exponent] = s
    a = scalar(8)
    N1 = eadd(Cinf,emul(a,moments[-6]))
    D1 = eadd(M0,emul(a,moments[-2]))
    N2 = eadd(Minf,emul(a,moments[2]))
    D2 = eadd(C0,emul(a,moments[6]))
    residual = esub(emul(N1,D2),emul(N2,D1))
    result = {'scope':'necessary trace identities only','degree_n_from_profile':12+sum(profile),
              'residual_E_codes':list(residual),'passes_product_identity':residual==ZERO}
    if residual!=ZERO:
        result['passes_trace_filter'] = False
        return result
    if D1!=ZERO:
        epsilon = ediv(N1,D1)
    elif D2!=ZERO:
        epsilon = ediv(N2,D2)
    else:
        result['passes_trace_filter'] = False
        result['reason'] = 'both denominators zero; no nonzero epsilon satisfies the two equations'
        return result
    good = epsilon!=ZERO and emul(epsilon,D1)==N1 and emul(epsilon,D2)==N2
    result['passes_trace_filter'] = good
    if good:
        result['epsilon_E_codes'] = list(epsilon)
        result['warning'] = 'No geometric realization or covering test has been performed.'
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('input',type=Path,help='JSON containing profile, infinity_labels and zero_labels')
    parser.add_argument('--output',type=Path)
    args = parser.parse_args()
    data = json.loads(args.input.read_text())
    result = check(data['profile'],data['infinity_labels'],data['zero_labels'])
    text = json.dumps(result,indent=2)+'\n'
    if args.output:
        args.output.write_text(text)
    print(text,end='')

if __name__=='__main__':
    main()
