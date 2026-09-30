"""Check the new 70-generator model in a complete actual ratio algebra.

Use the retained native coefficient engine; no root of the length-nine
ratio algebra or scale is selected. This is a bounded implementation check.
"""
import argparse, ctypes as ct, json, sys, time
from pathlib import Path


def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('--engine-dir',required=True)
    ap.add_argument('--output',required=True)
    ap.add_argument('--u',type=int,default=1)
    args=ap.parse_args(); start=time.time()
    sys.path.insert(0,str(Path(args.engine_dir).resolve()))
    from exact import ROOT, DATA, add, mul, power as fpow
    from extension import E, Poly, init
    from ratio_eliminant_data import load
    from interpolate_global import library
    from residual import sm
    from hasse_linear import power
    meta,raw=load(); src=json.loads((ROOT/'evidence/global_source.json').read_text())
    mod=[0]*10
    for iq,iu,a in src['critical_monic']:
        mod[iq]=add(mod[iq],mul(a,fpow(args.u,iu)))
    init(mod); q=E([0,1]); u=E(args.u)
    d=Poly(DATA['d']).eval(q)
    a,b,c,e=[Poly(DATA[k]).eval(q) for k in ('a0','b','c','e')]
    F=a*u**3+b*u*u+c*u+e
    for z in (q,u,d,F,b*u+c,q-E(10149),q-E(118020),q-E(64426)):
        z.inv()
    n=133; m=7*141*9
    inp=(ct.c_int*len(raw))(*raw); out=(ct.c_int*m)()
    library().ff_evaluate_rows(inp,n,m,args.u,out)
    A=[Poly([E(list(out[(s*141+140-t)*9:(s*141+141-t)*9])) for s in range(7)]) for t in range(141)]
    assert A[0].degree()==0
    L=A[0][0]; L.inv(); alpha=[z/L for z in A]
    assert alpha[1].degree()==0
    C=power(alpha,63,141)
    canonical=C[:71]
    b=[Poly(1)]
    for j in range(1,71):
        b.append(3*(alpha[j]-sum((b[i]*b[j-i] for i in range(1,j)),Poly())))
    assert b==canonical
    tail=list(C)
    carry=2*(alpha[1]**125)
    for n0 in range(125,141):
        tail[n0]=tail[n0]+carry*C[n0-125]
    residual=[a-z for a,z in zip(sm(b,b,141),alpha)]
    assert not any(residual[:71])
    for n0 in range(71,141):
        expected=3*sum((b[n0-j]*tail[j] for j in range(71,n0+1)),Poly())
        assert residual[n0]==expected
    result={'status':'PASS','u_code':args.u,'ratio_algebra_length':9,
            'scale_is_polynomial_variable':True,'original_open_verified':True,
            'first70_root_matches_independent_recurrence':True,
            'all70_square_errors_match_unit_triangular_tail_transformation':True,
            'tail_scale_degrees':[z.degree() for z in tail[71:]],
            'max_tail_scale_degree':max(z.degree() for z in tail[71:]),
            'seconds':round(time.time()-start,3),
            'scope':'bounded complete-algebra check; global square decision OPEN'}
    Path(args.output).parent.mkdir(parents=True,exist_ok=True)
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result),flush=True)


if __name__=='__main__':main()
