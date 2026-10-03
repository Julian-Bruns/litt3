#!/usr/bin/env python3
"""Exact same-moment finite circuit with genuine target pair authentication.

Consumes a checked two_moment_circuit.py export. No arbitrary graph is accepted.
Without --solve this only builds and performs a bound gate/lookup check.
"""
import argparse,gzip,hashlib,json,os,random,sys,time
from pathlib import Path
from finite_direction_smt import Encoder
from two_moment_circuit import evaluate_two
from field import K,F,xi,BINV
from finite import phi
from incidence import endpoint,phase_polynomials,f5rank,rank_graph,equations_hold
from rank_reconstruction import flat,unflat
from source_system import build,recover_witness


def pair_table():
    return [(a,b,K.add(K.pow(xi,5*a),K.pow(xi,5*b)),
                   K.add(K.pow(xi,17*a),K.pow(xi,17*b)))
            for a in range(29) for b in range(a,29)]


def select_column(z3,index,column,width):
    padded=tuple(column)+(0,)*(512-len(column));cache={}
    def tree(values,bit):
        if all(v==values[0] for v in values):return z3.BitVecVal(values[0],width)
        key=(values,bit)
        if key not in cache:
            m=len(values)//2
            cache[key]=z3.If(z3.Extract(bit,bit,index)==1,
                            tree(values[m:],bit-1),tree(values[:m],bit-1))
        return cache[key]
    return tree(padded,8)


def decode(spec,field_inputs,target_indices,table):
    x,y=field_inputs;vals=evaluate_two(spec,[x,y]);n=vals[spec['n0']]
    assert n!=K.zero
    eps=tuple(K.div(vals[q],n) for q in spec['scalar_numerators'])
    X,Y=phi(x,10),phi(y,6);source=spec['source']
    target=tuple(tuple(table[i][:2]) for i in target_indices)
    assert f5rank(phase_polynomials(source))==2
    assert f5rank(phase_polynomials(target))==3
    A,B=endpoint(source),endpoint(target)
    assert all(q!=K.zero for row in (A['C'],B['C']) for q in row[1:])
    assert rank_graph(A,B)[0] and all(equations_hold(A,B,eps,X,Y))
    # Select the ACTUAL nonzero Moore coordinate, then use the original
    # independent decoder, including permitted opposite phase restoration.
    q=[K.scale(B['C'][l],BINV[(13,3,9,2)[l]]) for l in (1,2,3)]
    a,b,c=q
    moore=K.add(K.sub(K.mul(a,K.sub(K.mul(phi(b,1),phi(c,2)),K.mul(phi(c,1),phi(b,2)))),
                     K.mul(b,K.sub(K.mul(phi(a,1),phi(c,2)),K.mul(phi(c,1),phi(a,2))))),
                K.mul(c,K.sub(K.mul(phi(a,1),phi(b,2)),K.mul(phi(b,1),phi(a,2)))))
    coordinate,value=next((i,v) for i,v in enumerate(flat(moore)) if v)
    original=build(source,coordinate,value)
    witness,meta=recover_witness(original,list(eps)+[X,Y],restore_E=True)
    assert witness and meta['stage']=='full-original-witness'
    return witness


def main():
    import z3
    ap=argparse.ArgumentParser();ap.add_argument('--circuit',required=True,type=Path)
    ap.add_argument('--output-dir',required=True,type=Path);ap.add_argument('--solve',action='store_true')
    ap.add_argument('--timeout-ms',type=int,default=600000);args=ap.parse_args()
    start=time.monotonic();spec=json.loads(args.circuit.read_text());out=args.output_dir;out.mkdir(parents=True,exist_ok=True)
    z3.set_param(proof=True);solver=z3.Solver();solver.set(timeout=args.timeout_ms,max_memory=3500)
    enc=Encoder(solver);inputs,values=enc.build(spec);assert len(inputs)==2
    table=pair_table();indices=[z3.BitVec(f'pair_index_{i}',9) for i in range(4)]
    for idx in indices:solver.add(z3.ULT(idx,435))
    selected=[];phasepairs=[]
    for idx in indices:
        cv=[select_column(z3,idx,[flat(row[2])[j] for row in table],3) for j in range(14)]
        uv=[select_column(z3,idx,[flat(row[3])[j] for row in table],3) for j in range(14)]
        selected.append((cv,uv));phasepairs.append(tuple(select_column(z3,idx,[row[j] for row in table],5) for j in (0,1)))
    # Bound one point before original-row/authentication conditions are added.
    rng=random.Random(293);point=[K.decode(rng.randrange(5**14)) for _ in range(2)]
    pairpoint=[rng.randrange(435) for _ in range(4)];solver.push()
    for vector,actual in zip(inputs,point):
        for variable,coefficient in zip(vector,flat(actual)):solver.add(variable==coefficient)
    for idx,v in zip(indices,pairpoint):solver.add(idx==v)
    assert solver.check()==z3.sat;model=solver.model();native=evaluate_two(spec,point)
    get=lambda e:e if isinstance(e,int) else model.eval(e).as_long()
    for vector,actual in zip(values,native):assert [get(e) for e in vector]==list(flat(actual))
    for pair,index,phase in zip(selected,pairpoint,phasepairs):
        assert [get(e) for e in pair[0]]==list(flat(table[index][2]))
        assert [get(e) for e in pair[1]]==list(flat(table[index][3]))
        assert tuple(get(e) for e in phase)==table[index][:2]
    solver.pop()
    nonzero=lambda vec:z3.Or(*[v!=0 for v in vec])
    for gate in spec['K_equations'].values():
        for v in values[gate]:solver.add(v==0)
    for gate in spec['nonzero_K'].values():solver.add(nonzero(values[gate]))
    for i,(cv,uv) in enumerate(selected):
        cc=enc.kmul(values[spec['n0']],cv);uu=enc.kmul(values[spec['denominator_D']],uv)
        for lhs,rhs in zip(values[spec['root_C_numerators'][i]],cc):solver.add(lhs==rhs)
        for lhs,rhs in zip(values[spec['root_U_numerators'][i]],uu):solver.add(lhs==rhs)
    # Genuine target full support and phase dimension3 are checked without
    # choosing one of56 Moore coordinate charts.
    C=[]
    for l in (1,2,3):
        col=[0]*14
        for i,(cv,uv) in enumerate(selected):
            col=[enc.add(a,enc.scale(b,pow(2,l*i,5))) for a,b in zip(col,cv)]
        solver.add(nonzero(col));C.append(col)
    frob=lambda a,n:enc.linear(a,enc.frobs.setdefault(n,list(map(list,zip(*(flat(phi(unflat([int(i==j) for i in range(14)]),n)) for j in range(14)))))))
    sub=lambda a,b:[enc.add(x,enc.neg(y)) for x,y in zip(a,b)]
    add=lambda a,b:[enc.add(x,y) for x,y in zip(a,b)]
    a,b,c=C
    moore=add(sub(enc.kmul(a,sub(enc.kmul(frob(b,1),frob(c,2)),enc.kmul(frob(c,1),frob(b,2)))),
                  enc.kmul(b,sub(enc.kmul(frob(a,1),frob(c,2)),enc.kmul(frob(c,1),frob(a,2))))),
              enc.kmul(c,sub(enc.kmul(frob(a,1),frob(b,2)),enc.kmul(frob(b,1),frob(a,2)))))
    solver.add(nonzero(moore))
    # Retain only the supplied remaining support/common-phase sectors.
    labels=[v for pair in phasepairs for v in pair]
    novel=[z3.And(*[labels[i]!=labels[j] for j in range(i)]) for i in range(8)]
    minimum=6 if len({j for p in spec['source'] for j in p})==4 else 5
    solver.add(z3.PbGe([(v,1) for v in novel],minimum))
    for candidate in phasepairs[0]:solver.add(z3.Not(z3.And(*[z3.Or(candidate==a,candidate==b) for a,b in phasepairs[1:]])))
    smt=out/'genuine.smt2';smt.write_text(solver.to_smt2())
    meta=dict(source=spec['source'],field_inputs=2,prime_inputs=28,pair_indices=4,
        K_gates=len(spec['nodes']),auxiliary_prime_gates=enc.count,genuine_target_pairs=435,
        circuit_sha256=hashlib.sha256(args.circuit.read_bytes()).hexdigest(),
        smt_sha256=hashlib.sha256(smt.read_bytes()).hexdigest(),solver_version=z3.get_version_string(),
        bound_all_field_gate_checks=1,bound_pair_lookup_checks=4,minimum_target_support=minimum,
        timeout_ms=args.timeout_ms,build_seconds=time.monotonic()-start,
        scope='genuine fixed-source mixed incidence on supplied original source opens; opposite-phase E restoration retained',
        threads={n:os.environ.get(n) for n in ('OMP_NUM_THREADS','OPENBLAS_NUM_THREADS','MKL_NUM_THREADS','VECLIB_MAXIMUM_THREADS')})
    (out/'result.json').write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta),flush=True)
    if not args.solve:return
    begun=time.monotonic();result=solver.check();meta.update(result=str(result),solve_seconds=time.monotonic()-begun)
    if result==z3.unknown:meta['reason_unknown']=solver.reason_unknown()
    elif result==z3.unsat:
        proof=out/'unsat.proof.txt.gz'
        with gzip.open(proof,'wt') as f:f.write(solver.proof().sexpr())
        meta['proof_file']=str(proof)
    elif result==z3.sat:
        model=solver.model();actual=[unflat([model.eval(q).as_long() for q in v]) for v in inputs]
        chosen=[model.eval(idx).as_long() for idx in indices]
        meta['witness']=decode(spec,actual,chosen,table)
    (out/'result.json').write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta),flush=True)

if __name__=='__main__':main()
