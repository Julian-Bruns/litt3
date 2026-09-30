#!/usr/bin/env python3
"""Verify one-sheet geometric rank certificates by independent series powers.

The generator uses the cubic coefficient recurrence in a list. This
verifier uses exponentiation of power series and exact specified minors.
It does not import the generator or repeat pivot selection.
"""
import argparse,itertools,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing,PowerSeriesRing,matrix

def compositions(n,r):
    if r==1:yield (n,);return
    for i in range(n+1):
        for t in compositions(n-i,r-1):yield (i,)+t

def main():
    ap=argparse.ArgumentParser();ap.add_argument('certificate',type=Path);ap.add_argument('output',type=Path)
    args=ap.parse_args();d=json.loads(args.certificate.read_text());n=d['pole'];started=time.monotonic()
    R0=PolynomialRing(GF(5),'z');mod=R0(d['field']['modulus']);assert mod.degree()==8 and mod.is_irreducible()
    K=GF(5**8,'z',modulus=mod);z=K.gen()
    def decode(c):
        result=K(0);power=K(1)
        while c:c,a=divmod(c,5);result+=a*power;power*=z
        return result
    beta=decode(d['field']['beta']);alpha=decode(d['field']['alpha'])
    assert beta*beta==beta+3
    f25=lambda c:K(c%5)+K(c//5)*beta
    R=PolynomialRing(K,'x');x=R.gen()
    P=R([f25(c) for c in [11,22,18,5,19,20,15,16,9,22,1]])
    A=R([f25(c) for c in [1,21,14,22,13]])
    assert alpha**4+f25(7)*alpha**3+f25(6)*alpha**2+f25(2)*alpha+f25(5)==0
    p0=P(alpha);assert p0==decode(d['field']['p0'])
    zeta=f25(11);assert zeta==decode(d['field']['zeta']) and zeta**3==1 and zeta!=1
    characters=d.get('characters',[0,1,2])
    assert characters in [[0,1,2],[0,1],[0,2]]
    columns=[(i,j) for j in characters for i in range((n-10*j)//3+1)]
    assert columns==[tuple(v) for v in d['columns']]
    S=PowerSeriesRing(K,'t',default_prec=n);t=S.gen()
    frob=5
    while frob<n:frob*=5
    exponent=pow(3,-1,frob)
    jets=[]
    for k in range(4):
        a=alpha**(25**k);assert A(a)==0 and P(a)!=0
        c=p0**((25**k-1)//3);assert p0*c**3==P(a)
        Y=c*S(P(a+t)/P(a)).add_bigoh(n)**exponent
        assert (p0*Y**3-S(P(a+t))).valuation()>=n
        phase_jets=[]
        for phase in range(3):
            polynomials=[S((a+t)**i*(zeta**phase*Y)**j) for i,j in columns]
            phase_jets.append([[f[m] for f in polynomials] for m in range(n)])
        jets.append(phase_jets)
    expected=set()
    for w in compositions(n,4):
        if w!=min(w[i:]+w[:i] for i in range(4)):continue
        occupied=[i for i,m in enumerate(w) if m]
        for tail in itertools.product(range(3),repeat=len(occupied)-1):
            phases=[0]*4
            for i,s in zip(occupied[1:],tail):phases[i]=s
            expected.add((w,tuple(phases)))
    seen=set()
    for record in d['records']:
        key=(tuple(record['weights']),tuple(record['phases']))
        assert key in expected and key not in seen;seen.add(key)
        rows=[]
        for i,m in enumerate(key[0]):rows.extend(jets[i][key[1][i]][:m])
        selected=record['rows'];assert len(selected)==len(columns) and len(set(selected))==len(columns)
        minor=matrix(K,[rows[i] for i in selected]);det=minor.det()
        assert det and det==decode(record['det'])
    assert seen==expected and not d['survivors'] and len(seen)==d['systems']
    result=dict(result='PASS',pole=n,systems=len(seen),all_geometric_supports=True,
        all_exact_nonzero_minors=True,independent_series_power_reconstruction=True,
        elapsed_seconds=time.monotonic()-started)
    args.output.write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result),flush=True)

if __name__=='__main__':main()
