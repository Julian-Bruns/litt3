"""Compact a completed zero-scale witness into unit factorizations and Bezout data.
No primitive tail or large expanded residual needs to be retained.
"""
import json,time
from pathlib import Path
from global_curve import QC
from half_gcd import install
install()
from ff import Poly,inv
from factor import factor_squarefree
from global_units import known_q_units
ROOT=Path(__file__).resolve().parents[1]

def factor_over_units(p,fs):
    p=Poly(p);scalar=p[p.degree()];p=p*inv(scalar);exponents=[]
    for f in fs:
        if p.degree()<f.degree() or p%f:
            exponents.append(0);continue
        lo,hi=1,p.degree()//f.degree()+1
        while hi-lo>1:
            m=(lo+hi)//2
            if p%(f**m):hi=m
            else:lo=m
        p=p//(f**lo);exponents.append(lo)
    assert p==1,('uncontrolled unit divisor',p.degree())
    return {'scalar':scalar,'exponents':exponents}

def evaluate_factorization(d,fs):
    p=Poly(d['scalar'])
    for f,e in zip(fs,d['exponents']):
        if e:p=p*f**e
    return p

def main():
    t=time.time();old=known_q_units();sf=old//old.gcd(old.derivative());fs=factor_squarefree(sf)
    assert old.powmod(old.degree(),sf)==0
    assert sf.powmod(old.degree(),old)==0
    z=json.loads((ROOT/'data/zero_scale_certificate.json').read_text())
    assert z['status']=='global zero-scale square locus excluded on old proved open'
    out={'status':z['status'],'coefficient_field':'K codes as data/inputs.json',
      'ratio_algebra':'K[q,z]/(z^2+2*c(q)*z+3*b(q)*e(q))',
      'source_polynomial':'G=b^72*q^83*d^36*Ahat; use mu=0 and divide by input_content',
      'unit_factors':[f.tolist() for f in fs],
      'input_content':factor_over_units(Poly(z['removed_input_content']),fs),
      'tails':{},'bezout':z['bezout']}
    for n,d in z['tails'].items():
        p=QC(*d['primitive_pair']);nn=Poly(d['allowed_norm']);cc=Poly(d['removed_content']);mm=p.norm()//nn
        out['tails'][n]={'content':factor_over_units(cc,fs),'norm_unit':factor_over_units(mm,fs),
          'primitive_degrees':list(p.degrees()),'normalized_norm_degree':nn.degree()}
        print('COMPACT_ZERO_TAIL',n,'content',cc.degree(),'normunit',mm.degree(),'seconds',round(time.time()-t,3),flush=True)
        assert evaluate_factorization(out['tails'][n]['content'],fs)==cc
        assert evaluate_factorization(out['tails'][n]['norm_unit'],fs)==mm
    (ROOT/'data/zero_scale_compact.json').write_text(json.dumps(out,separators=(',',':'))+'\n')
    print('COMPACT_ZERO_SUMMARY',len(fs),'unit factors',round(time.time()-t,3),'seconds',flush=True)
if __name__=='__main__':main()
