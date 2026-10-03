#!/usr/bin/env python3
"""Exact one-hot GF5 CNF for the genuine five-minor completion.

Negation/nonzero scaling are literal permutations. Native bound arithmetic
checks every gate clause and every marked-K circuit output before publishing.
No SAT solver is invoked by this exporter.
"""
import argparse,hashlib,json,random,shutil,time
from pathlib import Path
from five_minor_circuit import FAMILIES
from two_moment_circuit import evaluate_two
from two_moment_auth_smt import pair_table
from finite_direction_smt import multiplication_maps
from field import K,BINV
from finite import phi
from rank_reconstruction import flat,unflat,KBASIS


class CNF:
    def __init__(self,path):
        self.path=path;self.body=path.with_suffix('.body');self.file=self.body.open('w')
        self.variables=0;self.clauses=0;self.gate_clauses=0;self.bound={}
    def var(self,bound):
        self.variables+=1;self.bound[self.variables]=bool(bound);return self.variables
    def truth(self,lit):
        if isinstance(lit,bool):return lit
        return self.bound[abs(lit)]==(lit>0)
    def clause(self,literals,gate=True):
        if any(v is True for v in literals):return
        literals=tuple(v for v in literals if v is not False)
        literals=tuple(dict.fromkeys(literals))
        if any(-v in literals for v in literals):return
        if gate:
            assert any(self.truth(v) for v in literals),'a native bound gate clause failed'
            self.gate_clauses+=1
        self.clauses+=1;self.file.write(' '.join(map(str,literals))+' 0\n')
    def exactly_one(self,literals):
        self.clause(literals)
        if len(literals)<=5:
            for i,v in enumerate(literals):
                for w in literals[i+1:]:self.clause((-v,-w))
        else:
            previous=False
            for lit in literals:
                # Prefix s iff previous or current. Also disallow a second1.
                if previous is not False:self.clause((-previous,-lit))
                current=self.var(self.truth(lit) or self.truth(previous))
                self.clause((-lit,current));self.clause((not previous if isinstance(previous,bool) else -previous,current))
                self.clause((-current,previous,lit));previous=current
    def and_or(self,a,b,c):
        val=self.truth(a) or (self.truth(b) and self.truth(c));s=self.var(val)
        neg=lambda v:not v if isinstance(v,bool) else -v
        self.clause((neg(a),s));self.clause((neg(b),neg(c),s))
        self.clause((-s,a,b));self.clause((-s,a,c));return s
    def at_least(self,literals,k,asserted=True):
        previous=[True]+[False]*k
        for lit in literals:
            current=[True]
            for j in range(1,k+1):current.append(self.and_or(previous[j],lit,previous[j-1]))
            previous=current
        if asserted:self.clause((previous[k],),gate=False)
        return previous[k]
    def finish(self):
        self.file.close()
        with self.path.open('wb') as out:
            out.write(f'p cnf {self.variables} {self.clauses}\n'.encode())
            with self.body.open('rb') as inp:shutil.copyfileobj(inp,out)
        self.body.unlink()


class GF5:
    def __init__(self,cnf):
        self.cnf=cnf;self.ev,self.ip=multiplication_maps();self.frobs={};self.maps={};self.cache={};self.count=0
    def bound(self,a):
        if isinstance(a,int):return a
        return next(i for i,v in enumerate(a) if self.cnf.truth(v))
    def fresh(self,bound):
        out=tuple(self.cnf.var(i==bound) for i in range(5));self.cnf.exactly_one(out);self.count+=1;return out
    def neg(self,a):return self.scale(a,4)
    def scale(self,a,k):
        if isinstance(a,int):return a*k%5
        if not k:return 0
        inv=pow(k,-1,5);return tuple(a[j*inv%5] for j in range(5))
    def add(self,a,b):
        if isinstance(a,int) and isinstance(b,int):return (a+b)%5
        if isinstance(a,int):
            if not a:return b
            return tuple(b[(j-a)%5] for j in range(5))
        if isinstance(b,int):return self.add(b,a)
        if a==b:return self.scale(a,2)
        key=('add',)+tuple(sorted((a,b)))
        if key not in self.cache:
            out=self.fresh((self.bound(a)+self.bound(b))%5)
            for i in range(5):
                for j in range(5):self.cnf.clause((-a[i],-b[j],out[(i+j)%5]))
            self.cache[key]=out
        return self.cache[key]
    def mul(self,a,b):
        if isinstance(a,int):return self.scale(b,a)
        if isinstance(b,int):return self.scale(a,b)
        key=('mul',)+tuple(sorted((a,b)))
        if key not in self.cache:
            out=self.fresh(self.bound(a)*self.bound(b)%5)
            for i in range(5):
                for j in range(5):self.cnf.clause((-a[i],-b[j],out[i*j%5]))
            self.cache[key]=out
        return self.cache[key]
    def linear(self,coordinates,M):
        out=[]
        for row in M:
            v=0
            for a,k in zip(coordinates,row):
                if k:v=self.add(v,self.scale(a,k))
            out.append(v)
        return out
    def kmul(self,a,b):
        if all(isinstance(v,int) for v in a):
            q=unflat(a)
            if q not in self.maps:self.maps[q]=list(map(list,zip(*(flat(K.mul(q,t)) for t in KBASIS))))
            return self.linear(b,self.maps[q])
        if all(isinstance(v,int) for v in b):return self.kmul(b,a)
        ea,eb=self.linear(a,self.ev),self.linear(b,self.ev);prod=[]
        for i in range(13):
            ar,ai,br,bi=ea[2*i],ea[2*i+1],eb[2*i],eb[2*i+1]
            ac,bd=self.mul(ar,br),self.mul(ai,bi)
            cross=self.mul(self.add(ar,ai),self.add(br,bi))
            prod.extend((self.add(ac,self.scale(bd,3)),self.add(cross,self.neg(ac))))
        return self.linear(prod,self.ip)
    def frob(self,a,r):
        if r not in self.frobs:self.frobs[r]=list(map(list,zip(*(flat(phi(t,r)) for t in KBASIS))))
        return self.linear(a,self.frobs[r])
    def nonzero(self,a):
        if any(isinstance(v,int) and v for v in a):return
        self.cnf.clause([-v[0] for v in a if not isinstance(v,int)],gate=False)
    def zero(self,a):
        for v in a:self.cnf.clause((v==0,) if isinstance(v,int) else (v[0],),gate=False)


def build_native(spec,out,include_support_four=False,opposite_order=False):
    start=time.monotonic();out.mkdir(parents=True,exist_ok=True);cnf=CNF(out/'genuine.cnf');gf=GF5(cnf)
    table=pair_table();roles={'target':4}
    if spec['source'] is None:roles={'source':3,**roles}
    rng=random.Random(911);point=[K.decode(rng.randrange(5**14)) for i in range(2)]
    chosen={role:[rng.randrange(435) for i in range(n)] for role,n in roles.items()}
    if 'source' in roles:
        index={row[:2]:i for i,row in enumerate(table)}
        chosen['source']=[index[p] for p in ((0,1),(2,3),(4,5))]
    domains={};lookups={};hits={}
    for role,n in roles.items():
        domains[role]=[];lookups[role]=[];hits[role]=[]
        for i in range(n):
            allowed=(0,1,2,4,8) if role=='source' and i==0 else tuple(range(435))
            domain={j:cnf.var(j==chosen[role][i]) for j in allowed};cnf.exactly_one(list(domain.values()))
            domains[role].append(domain);cols=[]
            for character in (2,3):
                col=[]
                for coordinate in range(14):
                    values={j:flat(table[j][character])[coordinate] for j in allowed}
                    if len(set(values.values()))==1:v=next(iter(values.values()))
                    else:
                        v=gf.fresh(values[chosen[role][i]])
                        for j,sel in domain.items():cnf.clause((-sel,v[values[j]]))
                    col.append(v)
                cols.append(col)
            lookups[role].append(cols);phasehits=[]
            for phase in range(29):
                hit=cnf.var(phase in table[chosen[role][i]][:2]);phasehits.append(hit)
                for j,sel in domain.items():cnf.clause((-sel,hit if phase in table[j][:2] else -hit))
            hits[role].append(phasehits)
    moments=[[gf.fresh(v) for v in flat(q)] for q in point]
    inputs=moments+[lookups[role][i][character] for role,i,character in spec['pair_bindings']]
    add=lambda a,b:[gf.add(x,y) for x,y in zip(a,b)]
    sub=lambda a,b:[gf.add(x,gf.neg(y)) for x,y in zip(a,b)]
    values=[]
    for node in spec['nodes']:
        op,a=node['op'],node['args']
        if op=='constant':v=flat(K.decode(a[0]))
        elif op=='input':v=inputs[a[0]]
        elif op=='add':v=add(values[a[0]],values[a[1]])
        elif op=='multiply':v=gf.kmul(values[a[0]],values[a[1]])
        elif op=='Frobenius':v=gf.frob(values[a[0]],a[1])
        else:raise ValueError(op)
        values.append(v)
    nativeinputs=point+[table[chosen[role][i]][character+2] for role,i,character in spec['pair_bindings']]
    native=evaluate_two(spec,nativeinputs)
    for vec,q in zip(values,native):assert [gf.bound(v) for v in vec]==list(flat(q))
    for gate in spec['K_equations'].values():gf.zero(values[gate])
    def det(a,b,c):
        return add(sub(gf.kmul(a[0],sub(gf.kmul(b[1],c[2]),gf.kmul(b[2],c[1]))),
                       gf.kmul(a[1],sub(gf.kmul(b[0],c[2]),gf.kmul(b[2],c[0])))),
                   gf.kmul(a[2],sub(gf.kmul(b[0],c[1]),gf.kmul(b[1],c[0]))))
    rows={role:{name:[values[g] for g in row] for name,row in spec[f'{role}_rows'].items()} for role in ('source','target')}
    for row in rows.values():
        for q in row['C'][1:]:gf.nonzero(q)
        gf.nonzero(det(row['E1'][1:],row['C'][1:],row['U'][1:]))
    scale=lambda v,k:gf.kmul(v,flat(K.elt(k)))
    q=[scale(rows['target']['C'][l],BINV[(13,3,9,2)[l]]) for l in (1,2,3)]
    gf.nonzero(det(q,[gf.frob(v,1) for v in q],[gf.frob(v,2) for v in q]))
    if 'source' in roles:
        q=[scale(rows['source']['C'][l],BINV[(13,3,9,2)[l]]) for l in (1,2)]
        gf.nonzero(sub(gf.kmul(q[0],gf.frob(q[1],1)),gf.kmul(q[1],gf.frob(q[0],1))))
        for i in range(3):
            for j in range(i+1,3):
                for key in domains['source'][i].keys()&domains['source'][j].keys():
                    cnf.clause((-domains['source'][i][key],-domains['source'][j][key]),gate=False)
        if opposite_order:
            assert spec['source_family']=='opposite'
            prefix=False
            for key in sorted(domains['source'][2]):
                prefix=cnf.and_or(prefix,domains['source'][2][key],True)
                cnf.clause((-domains['source'][1][key],-prefix),gate=False)
    else:
        assert not include_support_four and not opposite_order
    occupancy={}
    for role,n in roles.items():
        occupied=[]
        for phase in range(29):
            selected=[hit[phase] for hit in hits[role]];occ=cnf.var(any(cnf.truth(v) for v in selected));occupied.append(occ)
            for v in selected:cnf.clause((-v,occ))
            cnf.clause((-occ,*selected))
            if role=='target' or include_support_four:cnf.clause(tuple(-v for v in selected),gate=False)
        minimum=6 if role=='target' and spec['source'] is not None and len({j for p in spec['source'] for j in p})==4 else 5
        if role=='source' and include_support_four:minimum=4
        cnf.at_least(occupied,minimum)
        occupancy[role]=occupied
    if include_support_four:
        s5=cnf.at_least(occupancy['source'],5,asserted=False)
        t6=cnf.at_least(occupancy['target'],6,asserted=False)
        cnf.clause((s5,t6),gate=False)
    cnf.finish()
    decode=dict(source=spec['source'],source_family=spec['source_family'],moments=moments,
                pair_domains=domains,format='native-five-minor-onehot-decoder-v1')
    (out/'decode.json').write_text(json.dumps(decode,indent=2)+'\n')
    meta=dict(source=spec['source'],source_family=spec['source_family'],variables=cnf.variables,
        clauses=cnf.clauses,native_GF5_gates=gf.count,all_gate_clauses_bound_checked=cnf.gate_clauses,
        all_K_circuit_outputs_bound_checked=len(values),free_prime_moment_coordinates=28,
        genuine_pair_indices=sum(roles.values()),seconds=time.monotonic()-start,
        cnf_sha256=hashlib.sha256(cnf.path.read_bytes()).hexdigest(),bytes=cnf.path.stat().st_size,
        include_support_four=include_support_four,opposite_pair_order=opposite_order,
        rank_determinant_included=spec.get('rank_determinant_included',False),
        scope=(('EXACT full rank3 incidence' if spec.get('rank_determinant_included',False) else 'NECESSARY scalar-completion relaxation; rank determinant omitted')+
               ('; whole repeated-source support4..6, source4 requires target>=6; no solve executed'
                if include_support_four else '; fixed source or whole repeated-source support>=5; no solve executed')))
    (out/'result.json').write_text(json.dumps(meta,indent=2)+'\n');return meta


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--circuit',required=True,type=Path)
    ap.add_argument('--output-dir',required=True,type=Path)
    ap.add_argument('--include-support-four',action='store_true')
    ap.add_argument('--opposite-order',action='store_true');args=ap.parse_args()
    print(json.dumps(build_native(json.loads(args.circuit.read_text()),args.output_dir,
                                 args.include_support_four,args.opposite_order)),flush=True)

if __name__=='__main__':main()
