#!/usr/bin/env python3
"""Exact genuine finite encoding of fixed-source or uniform five-minor systems."""
import argparse,gzip,hashlib,json,os,random,time
from pathlib import Path
from five_minor_circuit import FAMILIES
from two_moment_circuit import evaluate_two
from two_moment_auth_smt import pair_table,select_column
from finite_direction_smt import Encoder
from field import K,F,BINV
from finite import phi
from incidence import endpoint,phase_polynomials,f5rank,rank_graph,equations_hold
from rank_reconstruction import flat,unflat,KBASIS
from source_system import build,recover_witness


class BoundModelEncoder(Encoder):
    """Audit every field gate without invoking solver preprocessing."""
    def __init__(self,solver,model):
        super().__init__(solver);self.bound_model=model
    def fresh(self,expr):
        v=super().fresh(expr);actual=self.bound_model.eval(expr,model_completion=False)
        assert self.z3.is_bv_value(actual), 'bound audit has an unassigned input'
        self.bound_model.update_value(v.decl(),actual);return v


def decode(spec,moments,chosen,table):
    target=tuple(tuple(table[i][:2]) for i in chosen['target'])
    source=spec['source']
    if source is None:
        pool=[tuple(table[i][:2]) for i in chosen['source']]
        source=tuple(pool[i] for i in FAMILIES[spec['source_family']])
    A,B=endpoint(source),endpoint(target);X,Y=moments
    assert f5rank(phase_polynomials(source))==2 and f5rank(phase_polynomials(target))==3
    assert all(v!=K.zero for ep in (A,B) for v in ep['C'][1:])
    eps=F.div(F.sub(B['E1'],F.elt([X])),F.sub(A['C'],F.elt([Y])))
    assert not F.inK(eps) and rank_graph(A,B)[0] and all(equations_hold(A,B,eps,X,Y))
    q=[K.scale(B['C'][l],BINV[(13,3,9,2)[l]]) for l in (1,2,3)];a,b,c=q
    moore=K.add(K.sub(K.mul(a,K.sub(K.mul(phi(b,1),phi(c,2)),K.mul(phi(c,1),phi(b,2)))),
                     K.mul(b,K.sub(K.mul(phi(a,1),phi(c,2)),K.mul(phi(c,1),phi(a,2))))),
                K.mul(c,K.sub(K.mul(phi(a,1),phi(b,2)),K.mul(phi(b,1),phi(a,2)))))
    j,v=next((j,v) for j,v in enumerate(flat(moore)) if v)
    witness,stage=recover_witness(build(source,j,v),list(eps)+[X,Y],restore_E=True)
    assert witness and stage['stage']=='full-original-witness';return witness


def main():
    import z3
    ap=argparse.ArgumentParser();ap.add_argument('--circuit',required=True,type=Path)
    ap.add_argument('--output-dir',required=True,type=Path);ap.add_argument('--solve',action='store_true')
    ap.add_argument('--timeout-ms',type=int,default=600000);args=ap.parse_args();start=time.monotonic()
    spec=json.loads(args.circuit.read_text());out=args.output_dir;out.mkdir(parents=True,exist_ok=True)
    z3.set_param(proof=True);solver=z3.Solver();solver.set(timeout=args.timeout_ms,max_memory=3500)
    table=pair_table();roles={'target':4}
    if spec['source'] is None:roles={'source':3,**roles}
    rng=random.Random(743);point=[K.decode(rng.randrange(5**14)) for i in range(2)]
    chosen={role:[rng.randrange(435) for _ in range(count)] for role,count in roles.items()}
    if 'source' in roles:
        pairindex={row[:2]:i for i,row in enumerate(table)}
        chosen['source']=[pairindex[p] for p in ((0,1),(2,3),(4,5))]
    audit_model=z3.Model();enc=BoundModelEncoder(solver,audit_model)
    indices={};lookup={};phases={}
    for role,count in roles.items():
        indices[role]=[z3.BitVec(f'{role}_pair_index_{i}',9) for i in range(count)]
        lookup[role]=[];phases[role]=[]
        for i,idx in enumerate(indices[role]):
            audit_model.update_value(idx.decl(),z3.BitVecVal(chosen[role][i],9))
            solver.add(z3.ULT(idx,435))
            lookup[role].append(tuple([enc.fresh(select_column(z3,idx,[flat(row[k])[j] for row in table],3)) for j in range(14)] for k in (2,3)))
            phases[role].append(tuple(select_column(z3,idx,[row[k] for row in table],5) for k in (0,1)))
    if 'source' in roles:
        # Translation fixes one phase of P to0; the E-fixed Frobenius
        # phi8 multiplies phases by24, whose four nonzero cosets have
        # representatives1,2,4,8. These are actual equation symmetries.
        solver.add(z3.Or(*[indices['source'][0]==i for i in (0,1,2,4,8)]))
        solver.add(z3.Distinct(*indices['source']))
    moments=[[z3.BitVec(f'moment_{i}_{j}',3) for j in range(14)] for i in range(2)]
    for vec in moments:
        for v in vec:solver.add(z3.ULE(v,4))
    for vec,actual in zip(moments,point):
        for variable,value in zip(vec,flat(actual)):
            audit_model.update_value(variable.decl(),z3.BitVecVal(value,3))
    inputvectors=moments+[lookup[role][i][character] for role,i,character in spec['pair_bindings']]
    values=[]
    def frob(vec,r):
        if r not in enc.frobs:enc.frobs[r]=list(map(list,zip(*(flat(phi(t,r)) for t in KBASIS))))
        return enc.linear(vec,enc.frobs[r])
    add=lambda a,b:[enc.add(x,y) for x,y in zip(a,b)]
    sub=lambda a,b:[enc.add(x,enc.neg(y)) for x,y in zip(a,b)]
    for node in spec['nodes']:
        op,a=node['op'],node['args']
        if op=='constant':v=flat(K.decode(a[0]))
        elif op=='input':v=inputvectors[a[0]]
        elif op=='add':v=add(values[a[0]],values[a[1]])
        elif op=='multiply':v=enc.kmul(values[a[0]],values[a[1]])
        elif op=='Frobenius':v=frob(values[a[0]],a[1])
        else:raise ValueError(op)
        values.append(v)
    nativeinputs=point+[table[chosen[role][i]][character+2] for role,i,character in spec['pair_bindings']]
    native=evaluate_two(spec,nativeinputs)
    get=lambda x:x if isinstance(x,int) else audit_model.eval(x).as_long()
    for vec,v in zip(values,native):assert [get(x) for x in vec]==list(flat(v))
    for role,cols in lookup.items():
        for i,pair in enumerate(cols):
            for k,vec in enumerate(pair):assert [get(x) for x in vec]==list(flat(table[chosen[role][i]][k+2]))
    nonzero=lambda vec:z3.Or(*[v!=0 for v in vec])
    for gate in spec['K_equations'].values():
        for v in values[gate]:solver.add(v==0)
    def independent2(a,b):return sub(enc.kmul(a,frob(b,1)),enc.kmul(b,frob(a,1)))
    def determinant3(a,b,c):
        return add(sub(enc.kmul(a[0],sub(enc.kmul(b[1],c[2]),enc.kmul(b[2],c[1]))),
                       enc.kmul(a[1],sub(enc.kmul(b[0],c[2]),enc.kmul(b[2],c[0])))),
                   enc.kmul(a[2],sub(enc.kmul(b[0],c[1]),enc.kmul(b[1],c[0]))))
    def actual_rows(role):return {name:[values[g] for g in row] for name,row in spec[f'{role}_rows'].items()}
    A,B=actual_rows('source'),actual_rows('target')
    for rows in (A,B):
        for vec in rows['C'][1:]:solver.add(nonzero(vec))
        solver.add(nonzero(determinant3(rows['E1'][1:],rows['C'][1:],rows['U'][1:])))
    def kscale(vec,code):return enc.kmul(vec,flat(K.elt(code)))
    q=[kscale(B['C'][l],BINV[(13,3,9,2)[l]]) for l in (1,2,3)]
    solver.add(nonzero(determinant3(q,[frob(v,1) for v in q],[frob(v,2) for v in q])))
    if 'source' in roles:
        q=[kscale(A['C'][l],BINV[(13,3,9,2)[l]]) for l in (1,2)]
        solver.add(nonzero(independent2(*q)))
    def support_at_least(pairs,n):
        labels=[v for pair in pairs for v in pair]
        novel=[z3.And(*[labels[i]!=labels[j] for j in range(i)]) for i in range(len(labels))]
        solver.add(z3.PbGe([(v,1) for v in novel],n))
    if 'source' in roles:support_at_least(phases['source'],5)
    minimum=6 if spec['source'] is not None and len({j for p in spec['source'] for j in p})==4 else 5
    support_at_least(phases['target'],minimum)
    for candidate in phases['target'][0]:solver.add(z3.Not(z3.And(*[z3.Or(candidate==a,candidate==b) for a,b in phases['target'][1:]])))
    smt=out/'genuine.smt2';smt.write_text(solver.to_smt2())
    meta=dict(source=spec['source'],source_family=spec['source_family'],prime_free_moment_coordinates=28,
        genuine_pair_indices=sum(roles.values()),source_P_indices=[0,1,2,4,8] if 'source' in roles else None,
        K_equations=15,maximum_field_degree=2,K_gates=len(spec['nodes']),auxiliary_prime_gates=enc.count,
        solver_version=z3.get_version_string(),timeout_ms=args.timeout_ms,memory_limit_MB=3500,
        circuit_sha256=hashlib.sha256(args.circuit.read_bytes()).hexdigest(),smt_sha256=hashlib.sha256(smt.read_bytes()).hexdigest(),
        bound_all_K_gate_checks=1,bound_pair_lookup_checks=sum(roles.values()),build_seconds=time.monotonic()-start,
        scope='EXACT genuine same-moment mixed incidence in fixed source or WHOLE repeated source family with support>=5',
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
        model=solver.model();mom=[unflat([model.eval(v).as_long() for v in vec]) for vec in moments]
        chosen={role:[model.eval(idx).as_long() for idx in idxs] for role,idxs in indices.items()}
        meta['witness']=decode(spec,mom,chosen,table)
    (out/'result.json').write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta),flush=True)

if __name__=='__main__':main()
