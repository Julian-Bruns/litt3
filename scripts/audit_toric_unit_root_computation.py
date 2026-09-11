#!/usr/bin/env python3
"""Independent small-field audit: direct beta25, ghost formula, actual point counts."""
import argparse,json,time
from pathlib import Path
from sage.all import GF,Zmod,PolynomialRing,matrix
from toric_prym_unit_roots import multiply,power,extract_beta
from fixed_x_prym_toric import toric_model,newton_diagnostics


def point_count(poly,q):
    k=GF(q,'a');support=[(tuple(e),k(int(c))) for e,c in poly.dict().items()]
    coefficient=dict(support)
    nonzero=list(k)[1:];assert 0 not in nonzero
    powers={a:[k.one()]+[a**i for i in range(1,5)] for a in nonzero}
    count=0
    for x in nonzero:
        coeff=[k.zero() for _ in range(5)]
        for (i,j),c in support:coeff[j]+=c*powers[x][i]
        for z in nonzero:
            value=coeff[4]
            for c in reversed(coeff[:4]):value=value*z+c
            count+=value==0
    diag=newton_diagnostics(poly)
    for edge in diag['edges']:
        a=edge['start'];b=edge['end'];length=edge['lattice_length']
        step=[(b[i]-a[i])//length for i in range(2)]
        coeff=[coefficient.get((a[0]+j*step[0],a[1]+j*step[1]),k.zero())
               for j in range(length+1)]
        assert coeff[0] and coeff[-1]
        for z in nonzero:
            value=k.zero()
            for c in reversed(coeff):value=value*z+c
            count+=value==0
    return int(count)


def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('out',type=Path)
    args=p.parse_args();start=time.monotonic();k=GF(5);R=PolynomialRing(k,'x');x=R.gen()
    Q=x*x+1;pp=R.one();A=x**3+2*x+1
    for parameter in range(5):
        B=x**4+parameter*x**2
        B+=(2*A*A-B)%Q
        C,rem=(2*A*A-pp*B).quo_rem(Q);assert not rem
        F=A**3+pp*A*B-pp**2*C+4*Q*B*B
        if not F.is_squarefree():continue
        P=pp*pp-Q*A;RR=pp**3+pp*Q*A+3*Q*Q*B
        assert P**3+F*Q**3==RR**2 and F.degree()==10
        poly,_,_=toric_model(P,Q,RR);diag=newton_diagnostics(poly)
        if not diag['all_edges_transverse']:continue
        points=diag['interior_points'];f={tuple(e):c for e,c in poly.dict().items()}
        beta5=extract_beta(power(f,4,k.one()),5,points,k)
        if beta5.is_invertible():break
    else:raise RuntimeError('No ordinary small-field audit example in this family')
    O=Zmod(25);ff={e:O(int(c)) for e,c in f.items()}
    direct=extract_beta(power(ff,24,O.one()),25,points,O)
    ff4=power(ff,4,O.one());ff5=multiply(ff4,ff)
    for (i,j),c in ff.items():ff5[(5*i,5*j)]=ff5.get((5*i,5*j),O.zero())-c
    G={e:k(int(c)//5) for e,c in ff5.items() if c}
    assert all(int(c)%5==0 for c in ff5.values())
    cor=multiply(power(f,4,k.one()),G);f3=power(f,3,k.one());rows=[]
    for u in points:
        row=[]
        for v in points:
            target=(25*v[0]-u[0],25*v[1]-u[1]);value=O.zero();carry=k.zero()
            for (i,j),c in ff4.items():value+=c*ff4.get((target[0]-5*i,target[1]-5*j),0)
            for (i,j),c in f3.items():carry+=c*cor.get((target[0]-5*i,target[1]-5*j),0)
            row.append(value+20*int(carry))
        rows.append(row)
    assert matrix(O,rows)==direct
    beta5w=extract_beta(ff4,5,points,O);U=direct*beta5w.inverse()
    counts={str(q):point_count(poly,q) for q in [5,25,125]}
    print(json.dumps(dict(stage='independent_comparison',parameter=parameter,
        polynomial=str(poly),counts=counts,interior_count=len(points),
        unit_charpoly=list(map(int,U.charpoly())),
        traces=[int((U**i).trace()) for i in [1,2,3]],
        inverse_trace=int(U.inverse().trace()))),flush=True)
    assert (int(U.trace())+5*int(U.inverse().trace())-(6-counts['5']))%25==0
    assert (int((U**2).trace())-(26-counts['25']))%25==0
    assert (int((U**3).trace())-(126-counts['125']))%25==0
    result=dict(status='PASS',parameter=parameter,genus=8,
        direct_beta25_equals_ghost_all64_entries=True,
        actual_smooth_toric_point_counts=counts,
        unit_root_trace_checks_powers=[1,2,3],all_edges_transverse=True,
        seconds=time.monotonic()-start)
    args.out.write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))


if __name__=='__main__':main()
