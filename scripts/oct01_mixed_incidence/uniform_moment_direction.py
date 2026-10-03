#!/usr/bin/env sage
"""Uniform two-original-moment direction chart, including source L=0.

Only the inherited singular FIRST moment is removed. This is an exact
necessary source row/rank relaxation, not an authenticated target decision.
"""
import argparse
import json
import random
import sys
import time
from pathlib import Path
from sage.all import PolynomialRing, matrix
sys.path.insert(0, str(Path(__file__).parent))
from direction_boundary import marked_field
from direction_system import build_direction
from source_system import evaluate
from field import K
from incidence import endpoint
from source_mobius import resolvent_matrix, m2det


def build_uniform(ep, source_rows=None):
    KK, b, embed, unembed = marked_field()
    A = endpoint(ep) if source_rows is None else source_rows
    base = {name: [embed(z) for z in row] for name,row in A.items()}
    C,U,V = [base[n] for n in ('C','U','V')]
    m=b(21); k=V[2]/V[1]; d=(U[2]-k*U[1])/U[3]
    A0=1-2*k*d; B0=d*d+m*k*k
    L=U[1]*A0-U[3]*B0; Cstar=m*U[3]*A0-U[1]*B0
    ell=V[1]*L; cs=V[1]*Cstar
    alpha=-U[1]/(U[3]**2*V[1]); delta=-(k*U[1]+U[2])/U[3]
    eta=-2*U[1]*d/U[3]-k*m
    k0=C[3]*alpha+C[1]/(U[3]*V[1]); k1=C[3]*delta+C[2]+k*C[1]
    assert k1 != 0, 'audited genuine-source L1 nonvanishing required'
    xs=U[0]-U[1]*d-k*m*U[3]; ys=C[0]+C[3]*eta+C[1]*d
    singular_x=xs-U[3]*ell*k0/k1
    assert m2det(resolvent_matrix(A,unembed(singular_x))[0])==K.zero
    L1=C[3]*(V[1]*U[2]+V[2]*U[1])-U[3]*(C[1]*V[2]+C[2]*V[1])
    assert k1 == -L1/(U[3]*V[1])
    AF=(m*U[3]**2-U[1]**2)/(U[3]**2*V[1]); assert AF != 0
    R=PolynomialRing(KK,names=[f'w{r:02d}' for r in range(14)]+
                     [f'y{r:02d}' for r in range(14)]+['saturation'],order='degrevlex')
    ws,ysv,sat=R.gens()[:14],R.gens()[14:28],R.gens()[28]
    rows={name:[[v**(5**r) for v in row] for r in range(14)] for name,row in base.items()}
    dirs,Bs,fn,en,x,Y=[],[],[],[],[],[]
    for r in range(14):
        ph=lambda v:v**(5**r)
        w,y=ws[r],ysv[r]; z=y-ph(ys)-ph(C[3])*w
        Br=ph(k1)*w+ph(ell*k0)
        an=ph(ell)*z+ph(k1*cs)
        bn=w*z-ph(k0*cs)
        rn=[ph(alpha)*an+ph(delta)*bn+(ph(eta)+w)*Br,bn,
            ph(k)*bn+ph(d)*Br+an/ph(U[3]*V[1]),Br]
        fr=(ph(AF)*an+(ph(2*k*U[3]*V[1]*AF)-ph(U[3])*w)*bn+
            (ph(U[1])*w+ph(2*d*U[3]*V[1]*AF))*Br)
        xr=ph(xs)+ph(U[3])*w
        assert sum((rows['U'][r][3-i]*rn[i] for i in range(3)),R.zero())==(xr-rows['U'][r][0])*Br
        assert sum((rows['C'][r][3-i]*rn[i] for i in range(3)),R.zero())==(y-rows['C'][r][0])*Br
        dirs.append(rn);Bs.append(Br);fn.append(fr);en.append([-rows['V'][r][1]*q for q in rn]);x.append(xr);Y.append(y)
    X=[x[(r+10)%14] for r in range(14)]
    def product(left,right,r):
        out=[R.zero() for j in range(4)]
        for i in range(4):
            for j in range(4):out[(i+j)%4]+=left[i]*right[j]*(b(21)**(5**r) if i+j>=4 else 1)
        return out
    D,G,third=[],[],[]
    for r in range(14):
        dr=product(en[r],rows['E1'][r],r);gr=product(en[r],rows['C'][r],r);tr=product(en[r],rows['U'][r],r)
        for l in range(4):
            dr[l]-=X[(r+7)%14]*en[r][l];gr[l]-=Y[r]*en[r][l]
            tr[l]+=-x[r]*en[r][l]+rows['V'][r][l]*fn[r]
        dr[0]+=Y[(r+7)%14]*fn[r];gr[0]+=X[r]*fn[r];tr[0]+=Y[(r+8)%14]*fn[r]
        assert gr[3]==0 and all(tr[l]==0 for l in (1,2,3))
        D.append(dr);G.append(gr);third.append(tr[0])
    Z=[[b(gamma)**(5**r)*D[(r+8)%14][l] for l,gamma in enumerate((13,17,7))]+[R.zero()] for r in range(14)]
    W=[]
    for r in range(14):
        zr=Z[r][:];zr[0]+=Y[(r+1)%14]*fn[(r+8)%14]
        wr=[-v for v in product(en[r],zr,r)];wr[0]+=X[(r+11)%14]*fn[r]*fn[(r+8)%14];W.append(wr)
    Ti=matrix(KK,[base[n][1:] for n in ('E1','C','U')]).transpose().inverse()
    eq,labels=[],[]
    for r in range(14):
        def put(name,v):eq.append(v);labels.append((name,r))
        put('original_third_0',third[r])
        shift=(rows['E1'][r][0]-X[(r+7)%14],rows['C'][r][0]-Y[r],rows['U'][r][0]-x[r])
        functional=[sum((shift[i]*Ti[i,j]**(5**r) for i in range(3)),R.zero()) for j in range(3)]
        put('actual_rank_lift',Z[r][0]+Y[(r+1)%14]*fn[(r+8)%14]-
            sum((functional[j]*Z[r][j+1] for j in range(3)),R.zero()))
        for l,dl in enumerate((8,18,15)):
            put(f'actual_W_G_{l}',W[r][l]*fn[(r+11)%14]-b(dl)**(5**r)*G[(r+11)%14][l]*fn[r]*fn[(r+8)%14])
    for r in range(14):
        for name,v in [('w',ws),('y',ysv)]:eq.append(v[r]**5-v[(r+1)%14]);labels.append((name+'_field',r))
    eq.append(Bs[0]*sat-1);labels.append(('exclude_inherited_singular_first_moment',0))
    return R,eq,labels,dict(field=KK,embed=embed,unembed=unembed,directions=dirs,B=Bs,denominators=fn,
        X=X,Y=Y,source_rows=rows,prospective_rows=dict(C=D,E1=G,U=W,V=Z),singular_x=singular_x,
        first_moment_constant=xs,L=L,parameters=(ws,ysv),saturation=sat)


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--source',required=True);ap.add_argument('--output',required=True,type=Path)
    args=ap.parse_args();ep=json.loads(args.source);start=time.monotonic();R,eq,labels,aux=build_uniform(ep)
    rng=random.Random(111);spec=build_direction(ep)
    for check in range(5):
        while True:
            w,y=[aux['embed'](K.decode(rng.randrange(5**14))) for i in range(2)]
            point=[w**(5**r) for r in range(14)]+[y**(5**r) for r in range(14)]+[0]
            bs=[p(*point) for p in aux['B']];fs=[p(*point) for p in aux['denominators']]
            if bs[0] and fs[0]:break
        point[-1]=1/bs[0]
        rn=[p(*point) for p in aux['directions'][0]]
        direction=[aux['unembed'](q/bs[0]) for q in rn[:3]]+[
            aux['unembed'](-aux['embed'](endpoint(ep)['V'][1])*bs[0]/fs[0])]
        vals=evaluate(spec,direction+[K.zero,K.zero])
        for i,(name,r) in enumerate(labels[:70]):
            expected=aux['embed'](vals[spec['K_equations'][name]])**(5**r)
            denominator=fs[r] if name=='original_third_0' else fs[(r+8)%14] if name=='actual_rank_lift' else fs[r]*fs[(r+8)%14]*fs[(r+11)%14]
            assert eq[i](*point)==expected*denominator
        assert all(pol(*point)==0 for pol in eq[70:])
        for name,rows in aux['prospective_rows'].items():
            denominator=fs[0] if name in ('C','E1') else fs[8] if name=='V' else fs[0]*fs[8]
            actual=tuple(aux['unembed'](pol(*point)/denominator) for pol in rows[0])
            assert actual==tuple(vals[g] for g in spec['prospective_rows'][name])
    meta=dict(source=ep,variables=R.ngens(),equations=len(eq),terms=sum(len(p.monomials()) for p in eq),
        maximum_degree=int(max(p.total_degree() for p in eq)),point_checks=5,
        degree_by_type={name:int(eq[i].total_degree()) for i,(name,r) in enumerate(labels[:5])},
        singular_first_moment=aux['unembed'](aux['singular_x']),source_L_zero=aux['L']==0,
        build_check_seconds=time.monotonic()-start,
        scope='uniform exact row/rank relaxation on inherited nonsingular first moment; target authentication absent')
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta),flush=True)


if __name__=='__main__':main()
