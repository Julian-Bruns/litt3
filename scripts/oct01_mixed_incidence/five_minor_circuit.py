#!/usr/bin/env python3
"""Boundary-free SAME-moment completion using five projected minors.

Supports fixed actual sources and two uniform repeated-pair source families.
Pair sum inputs are bound to exact435-pair lookups by a separate encoder.
"""
import argparse,json,random,time,sys
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parents[3]/'litt3-computation-data/october01_audited_replies/mixed_span_incidence/src'))
from source_system import Circuit
from field import K,F,xi
from finite import phi
from incidence import endpoint
from two_moment_circuit import evaluate_two

CW,EW,UW,VW=(13,3,9,2),(4,3,14,0),(22,24,12,11),(6,21,11,0)
FAMILIES={'adjacent':(0,0,1,2),'opposite':(0,1,0,2)}
PAIRS=((0,1),(0,2),(1,2),(0,3),(1,3))


def build_five(source=None,family=None,include_rank=False):
    if (source is None)==(family is None):raise ValueError('one source or one family required')
    cc=Circuit();X,Y=cc.input('X'),cc.input('Y');bindings=[]
    def make_pairs(role,count):
        pairs=[]
        for i in range(count):
            pairs.append((cc.input(f'{role}_pair_{i}_c5'),cc.input(f'{role}_pair_{i}_u17')))
            bindings.extend(((role,i,0),(role,i,1)))
        return pairs
    def make_rows(pairs):
        qs=[[cc.sum(cc.scale(pairs[i][0],pow(2,l*i,5)) for i in range(4)) for l in range(4)],
            [cc.sum(cc.scale(pairs[i][1],pow(2,l*i,5)) for i in range(4)) for l in range(4)]]
        return dict(C=[cc.scale(q,CW[l]) for l,q in enumerate(qs[0])],
            E1=[cc.scale(cc.frob(q,3),EW[l]) for l,q in enumerate(qs[1])],
            U=[cc.scale(q,UW[l]) for l,q in enumerate(qs[1])],
            V=[cc.scale(cc.frob(q,8),VW[l]) for l,q in enumerate(qs[0])])
    if family is None:A={name:[cc.const(q) for q in row] for name,row in endpoint(source).items()}
    else:
        pool=make_pairs('source',3);A=make_rows([pool[i] for i in FAMILIES[family]])
    B=make_rows(make_pairs('target',4))
    negate=lambda row:[cc.scale(q,4) for q in row]
    av=[A['E1'],A['C'],A['U'],B['V']]
    bv=[B['C'],B['E1'],negate(A['V']),negate(B['U'])]
    al=[cc.scale(cc.frob(X,7),4),cc.scale(Y,4),cc.scale(cc.frob(X,4),4),cc.frob(Y,1)]
    be=[cc.scale(cc.frob(Y,7),4),cc.scale(X,4),cc.scale(cc.frob(Y,8),4),cc.frob(X,11)]
    def mul(a,b):
        out=[cc.zero]*4
        for i in range(4):
            for j in range(4):
                if (i+j)%4==0:continue
                q=cc.mul(a[i],b[j])
                if i+j>=4:q=cc.scale(q,21)
                out[(i+j)%4]=cc.add(out[(i+j)%4],q)
        return out
    eq={}
    for i,j in PAIRS:
        u,v=mul(av[i],bv[j]),mul(av[j],bv[i])
        for l in range(1,4):
            eq[f'projected_minor_{i+1}{j+1}_{l}']=cc.sum((cc.sub(u[l],v[l]),
                cc.mul(al[i],bv[j][l]),cc.scale(cc.mul(al[j],bv[i][l]),4),
                cc.mul(be[j],av[i][l]),cc.scale(cc.mul(be[i],av[j][l]),4)))
    if include_rank:
        top=[[cc.add(av[i][0],al[i]),*av[i][1:]] for i in range(4)]
        assert top[0][3]==top[3][3]==cc.zero
        def det3(a,b,c):
            return cc.sum((cc.mul(a[0],cc.sub(cc.mul(b[1],c[2]),cc.mul(b[2],c[1]))),
                cc.scale(cc.mul(a[1],cc.sub(cc.mul(b[0],c[2]),cc.mul(b[2],c[0]))),4),
                cc.mul(a[2],cc.sub(cc.mul(b[0],c[1]),cc.mul(b[1],c[0])))))
        eq['top_column_determinant']=cc.sub(
            cc.mul(top[1][3],det3(top[0][:3],top[2][:3],top[3][:3])),
            cc.mul(top[2][3],det3(top[0][:3],top[1][:3],top[3][:3])))
    return dict(format='five-projected-minor-original-moment-v1',inputs=cc.names,nodes=cc.nodes,
        source=source,source_family=family,source_positions=FAMILIES.get(family),
        pair_bindings=bindings,K_equations=eq,source_rows=A,target_rows=B,
        prime_free_moment_coordinates=28,maximum_F5_degree=max(cc.degree(g) for g in eq.values()),
        rank_determinant_included=include_rank,
        scope=('EXACT original SAME-moment rank3 incidence for actual full endpoints; scalar E restoration retained'
               if include_rank else 'NECESSARY five-minor scalar-completion relaxation; rank3 determinant omitted; scalar E restoration retained'))


def main():
    ap=argparse.ArgumentParser();group=ap.add_mutually_exclusive_group(required=True)
    group.add_argument('--source');group.add_argument('--family',choices=FAMILIES)
    ap.add_argument('--output',required=True,type=Path);ap.add_argument('--include-rank',action='store_true')
    args=ap.parse_args();start=time.monotonic()
    source=json.loads(args.source) if args.source else None;spec=build_five(source,args.family,args.include_rank)
    rng=random.Random(503)
    for sample in range(4):
        source_pool=[tuple(sorted(rng.sample(range(29),2))) for _ in range(3)] if source is None else []
        src=[source_pool[i] for i in FAMILIES[args.family]] if source is None else source
        target=[tuple(sorted(rng.sample(range(29),2))) for _ in range(4)]
        A,B=endpoint(src),endpoint(target);X,Y=[K.decode(rng.randrange(5**14)) for _ in range(2)]
        inputs=[X,Y]
        for ep in source_pool+target:
            inputs.extend(K.add(K.pow(xi,d*ep[0]),K.pow(xi,d*ep[1])) for d in (5,17))
        vals=evaluate_two(spec,inputs)
        for role,expected in [('source',A),('target',B)]:
            for name,row in spec[f'{role}_rows'].items():assert tuple(vals[g] for g in row)==expected[name]
        av=[F.sub(A['E1'],F.elt([phi(X,7)])),F.sub(A['C'],F.elt([Y])),
            F.sub(A['U'],F.elt([phi(X,4)])),F.add(B['V'],F.elt([phi(Y,1)]))]
        bv=[F.sub(B['C'],F.elt([phi(Y,7)])),F.sub(B['E1'],F.elt([X])),
            F.sub(F.zero,F.add(A['V'],F.elt([phi(Y,8)]))),F.sub(F.elt([phi(X,11)]),B['U'])]
        for i,j in PAIRS:
            actual=F.sub(F.mul(av[i],bv[j]),F.mul(av[j],bv[i]))
            for l in range(1,4):assert vals[spec['K_equations'][f'projected_minor_{i+1}{j+1}_{l}']]==actual[l]
        if args.include_rank:
            def determinant(M):
                if len(M)==1:return M[0][0]
                total=K.zero
                for j,value in enumerate(M[0]):
                    term=K.mul(value,determinant([row[:j]+row[j+1:] for row in M[1:]]))
                    total=K.add(total,term if j%2==0 else K.neg(term))
                return total
            assert vals[spec['K_equations']['top_column_determinant']]==determinant([list(row) for row in zip(*av)])
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(spec,indent=2)+'\n')
    print(json.dumps(dict(source=source,family=args.family,nodes=len(spec['nodes']),field_inputs=len(spec['inputs']),
        prime_free_moment_coordinates=28,pair_lookup_indices=4 if source else 7,equations=len(spec['K_equations']),
        maximum_F5_degree=spec['maximum_F5_degree'],original_projected_minor_checks=60,
        source_target_row_checks=32,independent_full_determinant_checks=4 if args.include_rank else 0,
        seconds=time.monotonic()-start)),flush=True)

if __name__=='__main__':main()
