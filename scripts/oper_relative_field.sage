#!/usr/bin/env sage
"""Exact relative-field and cubic-descent data; no atlas solving or queue writes."""
import argparse, hashlib, json, time
from pathlib import Path

def inspect(rep, output):
    root=Path(__file__).resolve().parents[1]
    folder=root/'Research/computations';start=time.monotonic()
    census=json.loads((folder/'normalized_oper_closed_points.json').read_text())
    factor=next(row for row in census['factors'] if row['id']==rep)
    certpath=folder/'normalized_oper_algebra_certificate.json'
    certificate=json.loads(certpath.read_text())
    prime=GF(5);Z=PolynomialRing(prime,'z')
    base=GF(25,name='a',modulus=Z([2,4,1]));a=base.gen()
    R=PolynomialRing(base,'z');z=R.gen()
    f=R(factor['polynomial'])
    embedding=R(certificate['coordinates']['zeta'])%f
    h=f.gcd(embedding-a).monic()
    conjugate=R([c**5 for c in h.list()])
    assert h.degree()==factor['degree_F25'] and h*conjugate==f
    assert (embedding-a)%h==0 and (embedding-a**5)%conjugate==0
    print(rep,'relative modulus',h.degree(),'verified; seconds',round(time.monotonic()-start,2),flush=True)
    lam=R(certificate['lambda'])%h
    norm=h.resultant(lam)
    assert norm!=0
    cubic_character=norm**8
    assert cubic_character**3==1
    encode=lambda c:int(int(c.polynomial()[0])+5*int(c.polynomial()[1]))
    coords={name:R(poly)%h for name,poly in certificate['coordinates'].items() if name!='zeta'}
    coords['lambda']=lam
    coords.update({'b%d'%i:R(poly)%h for i,poly in enumerate(certificate['B'])})
    report=dict(rep=rep,source_certificate_sha256=hashlib.sha256(certpath.read_bytes()).hexdigest(),
        degree_F25=int(h.degree()),relative_polynomial_implementation=type(h).__name__,
        relative_modulus=[encode(c) for c in h.list()],coefficient_encoding='c0+5*c1 for c0+c1*a; a^2+4a+2=0',
        factor_and_embedding_verified=True,norm_lambda_F25=encode(norm),
        cubic_character_F25=encode(cubic_character),lambda_is_cube=bool(cubic_character==1),
        normalized_coordinates={name:[encode(c) for c in poly.list()] for name,poly in coords.items()},
        coordinate_degrees={name:int(poly.degree()) for name,poly in coords.items()},
        elapsed_seconds=time.monotonic()-start,
        scope='Exact normalized field presentation and cubic character, not an atlas exclusion.')
    output=Path(output);output.parent.mkdir(parents=True,exist_ok=True)
    output.write_text(json.dumps(report,separators=(',',':'))+'\n')
    print(json.dumps({key:value for key,value in report.items() if key not in ['relative_modulus','normalized_coordinates']},indent=2),flush=True)

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--rep',default='orbit_0011');parser.add_argument('--output',required=True)
    args=parser.parse_args();inspect(args.rep,args.output)
