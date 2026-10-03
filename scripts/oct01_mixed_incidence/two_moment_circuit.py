#!/usr/bin/env sage
"""Exact finite-field product circuit in the SAME two original moment inputs.

Finite K inputs make all Frobenius gates linear over F5. No solver or target
authentication is executed here. Source A3/Hd opens are explicit outputs.
"""
import argparse,json,random,time
from pathlib import Path
from source_system import Circuit
from field import K,F,BINV
from finite import phi
from incidence import endpoint,phase_polynomials,f5rank
from source_mobius import resolvent_matrix,m2det,candidate_rows,semilinear_projective_solutions,fourth_row_residual
from source_system import build,evaluate


def evaluate_two(spec,inputs):
    vals=[]
    for node in spec['nodes']:
        op,a=node['op'],node['args']
        if op=='constant':v=K.decode(a[0])
        elif op=='input':v=inputs[a[0]]
        elif op=='add':v=K.add(vals[a[0]],vals[a[1]])
        elif op=='multiply':v=K.mul(vals[a[0]],vals[a[1]])
        elif op=='Frobenius':v=phi(vals[a[0]],a[1])
        else:raise ValueError(op)
        vals.append(v)
    return vals


def build_two(ep):
    from polynomial_rank_resolvent import polynomial_resolvent
    assert f5rank(phase_polynomials(ep))==2
    aux=polynomial_resolvent(ep);cc=Circuit();x,y=cc.input('X625'),cc.input('Yrho')
    raw=endpoint(ep);cst=lambda v:cc.const(v)
    def pol(poly,z,r=0):
        out=cc.zero
        for coef in reversed(poly.list()):out=cc.add(cc.mul(out,z),cst(phi(aux['unembed'](coef),r)))
        return out
    def mul(left,right,r=0):
        out=[cc.zero]*4;m=phi(K.elt(21),r)
        for i in range(4):
            for j in range(4):
                q=cc.mul(left[i],right[j])
                if i+j>=4:q=cc.mul(q,cst(m))
                out[(i+j)%4]=cc.add(out[(i+j)%4],q)
        return out
    row=lambda name,r=0:[cst(phi(q,r)) for q in raw[name]]
    xp=lambda r:cc.frob(x,r);yp=lambda r:cc.frob(y,r)
    hd=cc.add(cc.mul(pol(aux['bn'],x),y),pol(aux['a'],x))
    hn=cc.add(cc.mul(pol(aux['d'],x),y),pol(aux['c'],x))
    third=cc.sub(cc.mul(hd,yp(6)),hn)
    ld=cc.sub(pol(aux['d'],xp(8),8),cc.mul(pol(aux['bn'],xp(8),8),y))
    n=pol(aux['norm'],x);D=cc.mul(n,ld)
    V=row('V');V[0]=cc.add(V[0],y)
    en=mul([pol(p,x) for p in aux['adj']],V)
    e8=[cc.add(pol(aux['A'][i],xp(8),8),cc.mul(pol(aux['B'][i],xp(8),8),y)) for i in range(4)]
    E8=row('E1',8);E8[0]=cc.sub(E8[0],xp(11));zs=mul(e8,E8,8)
    Z=[cc.scale(zs[i],gamma) for i,gamma in enumerate((13,17,7))]+[cc.zero]
    Zplus=list(Z);Zplus[0]=cc.add(Zplus[0],cc.scale(cc.mul(yp(7),ld),14))
    ellshift=[cc.sub(cst(raw['E1'][0]),xp(3)),cc.sub(cst(raw['C'][0]),yp(6)),cc.sub(cst(raw['U'][0]),x)]
    ell=[cc.sum(cc.mul(ellshift[i],cst(aux['unembed'](aux['Ti'][i,j]))) for i in range(3)) for j in range(3)]
    rank=cc.sub(Zplus[0],cc.sum(cc.mul(ell[i],Z[i+1]) for i in range(3)))
    w=[cc.scale(q,4) for q in mul(en,Zplus)];w[0]=cc.add(w[0],cc.mul(xp(7),D))
    gt=[cc.scale(w[i],BINV[delta]) for i,delta in enumerate((8,18,15))]+[cc.zero]
    gt[0]=cc.sub(gt[0],cc.mul(xp(7),D))
    left=row('U',11);left=[cc.sub(xp(11),left[0])]+[cc.scale(q,4) for q in left[1:]]
    rightV=row('V',11);rightV[0]=cc.add(rightV[0],yp(11))
    rightC=row('C',11);rightC[0]=cc.sub(rightC[0],yp(3))
    l,r=mul(left,gt,11),mul(rightV,rightC,11)
    products=[cc.sub(l[i],cc.mul(D,r[i])) for i in range(4)]
    E=row('E1');E[0]=cc.sub(E[0],xp(3));dn=mul(en,E);dn[0]=cc.add(dn[0],cc.mul(yp(13),n))
    def fourier(v,weights):
        return [cc.scale(cc.sum(cc.scale(cc.scale(v[j],BINV[weights[j]]),pow(2,-i*j,5)) for j in range(4)),4) for i in range(4)]
    cn=fourier(dn,(13,3,9,2));un=fourier(w,(22,24,12,11))
    eq={'source_G3':third,'actual_rank_lift':rank}
    eq.update({f'original_WG_product_{i}':q for i,q in enumerate(products)})
    return dict(format='two-original-moment-K-circuit-v1',source=ep,inputs=cc.names,nodes=cc.nodes,
        K_equations=eq,nonzero_K={'supplied_A3':pol(aux['A'][3],x),'supplied_Hd':hd},
        n0=n,Ld=ld,denominator_D=D,root_C_numerators=cn,root_U_numerators=un,
        scalar_numerators=en,WG_product_factor=left,
        maximum_F5_degree=max(cc.degree(q) for q in eq.values()),
        scope='EXACT original finite-K source row/rank relaxation on supplied opens; genuine target lookup absent')


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--source',required=True);ap.add_argument('--output',required=True,type=Path)
    args=ap.parse_args();ep=json.loads(args.source);start=time.monotonic();spec=build_two(ep)
    rng=random.Random(240);source=endpoint(ep);direct=build(ep)
    for sample in range(4):
        while True:
            x=K.decode(rng.randrange(5**14));M,Rx=resolvent_matrix(source,x)
            if m2det(M)==K.zero:continue
            ys,stats=semilinear_projective_solutions(M)
            if any(q is not None for q in ys):y=next(q for q in ys if q is not None);break
        rows,eps,X,Y=candidate_rows(source,x,y,Rx);val=evaluate_two(spec,[x,y])
        assert val[spec['K_equations']['source_G3']]==K.zero
        assert all(val[q]!=K.zero for q in spec['nonzero_K'].values())
        rankval=evaluate(direct,list(eps)+[X,Y])[direct['K_equations']['actual_rank_lift']]
        assert val[spec['K_equations']['actual_rank_lift']]==K.mul(rankval,val[spec['Ld']])
        residual=[K.div(q,K.elt(d)) for q,d in zip(fourth_row_residual(rows),(8,18,15))]+[K.zero]
        # F.mul uses m, whereas phi11-conjugated multiplication uses m11.
        m11=phi(K.elt(21),11);scaled=[K.zero]*4
        for i in range(4):
            for j in range(4):
                q=K.mul(val[spec['WG_product_factor'][i]],residual[j])
                if i+j>=4:q=K.mul(q,m11)
                scaled[(i+j)%4]=K.add(scaled[(i+j)%4],q)
        for i in range(4):assert val[spec['K_equations'][f'original_WG_product_{i}']]==K.mul(scaled[i],val[spec['denominator_D']])
        for name,weights,den in [('C',(13,3,9,2),spec['n0']),('U',(22,24,12,11),spec['denominator_D'])]:
            for i in range(4):
                # Keep the independently decoded inverse Fourier literal.
                actual=K.zero
                for j in range(4):actual=K.add(actual,K.scale(K.scale(rows[name][j],BINV[weights[j]]),pow(2,-i*j,5)))
                actual=K.scale(actual,4)
                assert val[spec[f'root_{name}_numerators'][i]]==K.mul(actual,val[den])
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(spec,indent=2)+'\n')
    print(json.dumps(dict(inputs=len(spec['inputs']),prime_inputs=28,nodes=len(spec['nodes']),
        equation_degrees={name:spec['nodes'][q]['F5_degree_bound'] for name,q in spec['K_equations'].items()},
        original_G3_checks=4,rank_checks=4,WG_coordinate_checks=16,pair_sum_checks=32,
        seconds=time.monotonic()-start,scope=spec['scope'])),flush=True)

if __name__=='__main__':main()
