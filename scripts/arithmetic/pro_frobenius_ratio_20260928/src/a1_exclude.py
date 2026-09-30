"""All-geometric-scale certificates on the entire remaining a_1=0 divisor.
Factorization and the linear reduction in u describe all geometric points;
this is not a finite-field point scan.
"""
from pathlib import Path
import json,time,argparse
from ff import *
from residual import *
ROOT=Path(__file__).resolve().parents[1]

def point(mod,data):
 q=ext.context(mod);u=-peval(data['A0'],q)/peval(data['A1'],q)
 check_open(q,u)
 return q,u

def solve(i,verbose=True):
 data=json.loads((ROOT/'data/a1_reduced.json').read_text());mod=Poly(data['factorization'][i]);start=time.time()
 q,u=point(mod,data)
 print('a1=0 factor',i,'degree',mod.degree(),flush=True)
 rr,A=residual(q,u,verbose=verbose);assert not A[1]
 ts=Tails(A,verbose=verbose,max_n=72)
 f,g=ts.tail(71),ts.tail(72)
 print('tails',f.degree(),g.degree(),'elapsed',round(time.time()-start,3),flush=True)
 gg,U,V=f.xgcd(g)
 assert gg==EP(1),('first two tails did not exclude',gg.serialize())
 assert U*f+V*g==EP(1)
 print('Bezout identity verified elapsed',round(time.time()-start,3),flush=True)
 cert={'case':'a1_zero','factor_index':i,'modulus':mod.tolist(),'u_formula':'-A0(q)/A1(q), as in data/a1_reduced.json',
       'tail_indices':[71,72],'tail_degrees':[f.degree(),g.degree()],'mu_power':0,'bezout_coefficients':[U.serialize(),V.serialize()],
       'a1_identically_zero':True,'elapsed_seconds':round(time.time()-start,3)}
 out=ROOT/'data/a1_certificates';out.mkdir(exist_ok=True);(out/f'a1_zero_{i}.json').write_text(json.dumps(cert,separators=(',',':'))+'\n')
 return {'certificate':str((out/f'a1_zero_{i}.json').relative_to(ROOT)),'degree':mod.degree(),'factor_index':i,'elapsed_seconds':cert['elapsed_seconds'],'status':'excluded'}

def main():
 ap=argparse.ArgumentParser();ap.add_argument('--factor',type=int);args=ap.parse_args()
 data=json.loads((ROOT/'data/a1_reduced.json').read_text())
 todo=range(len(data['factorization'])) if args.factor is None else [args.factor]
 out=[solve(i) for i in todo]
 dest=ROOT/'checks'/('a1_exclusion.json' if args.factor is None else f'a1_exclusion_factor_{args.factor}.json')
 dest.write_text(json.dumps({'blocks':out,'status':'all listed blocks excluded'},indent=2)+'\n')
if __name__=='__main__':main()
