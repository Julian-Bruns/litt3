#!/usr/bin/env python3
"""Exhaustive local relation checks for the NEW native CNF encoding."""
import argparse,itertools,json,tempfile
from pathlib import Path
from five_minor_native_cnf import CNF,GF5

def satisfied(clauses,assignment):
    return all(any(assignment[abs(lit)]==(lit>0) for lit in clause) for clause in clauses)

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--output',required=True,type=Path);args=ap.parse_args()
    field_checks=0;boolean_checks=0;threshold_checks=0;order_checks=0
    with tempfile.TemporaryDirectory() as temp:
        for op in ('add','mul'):
            cnf=CNF(Path(temp)/f'{op}.cnf');gf=GF5(cnf);a=gf.fresh(0);b=gf.fresh(0)
            out=getattr(gf,op)(a,b);cnf.finish()
            clauses=[tuple(map(int,line.split()[:-1])) for line in cnf.path.read_text().splitlines()[1:]]
            for av,bv,cv in itertools.product(range(5),repeat=3):
                assignment={}
                for lits,val in ((a,av),(b,bv),(out,cv)):
                    for i,lit in enumerate(lits):assignment[lit]=i==val
                want=cv==((av+bv)%5 if op=='add' else av*bv%5)
                assert satisfied(clauses,assignment)==want;field_checks+=1
        cnf=CNF(Path(temp)/'boolean.cnf');a,b,c=[cnf.var(False) for _ in range(3)]
        s=cnf.and_or(a,b,c);cnf.finish()
        clauses=[tuple(map(int,line.split()[:-1])) for line in cnf.path.read_text().splitlines()[1:]]
        for av,bv,cv,sv in itertools.product((False,True),repeat=4):
            assert satisfied(clauses,{a:av,b:bv,c:cv,s:sv})==(sv==(av or(bv and cv)));boolean_checks+=1
        for n in (5,6):
            cnf=CNF(Path(temp)/f'domain{n}.cnf');lits=[cnf.var(i==0) for i in range(n)]
            cnf.exactly_one(lits);cnf.finish()
            clauses=[tuple(map(int,line.split()[:-1])) for line in cnf.path.read_text().splitlines()[1:]]
            for primary in itertools.product((False,True),repeat=n):
                possible=False
                for auxiliary in itertools.product((False,True),repeat=cnf.variables-n):
                    assignment=dict(enumerate(primary+auxiliary,1))
                    possible|=satisfied(clauses,assignment)
                assert possible==(sum(primary)==1);boolean_checks+=1
        for n in range(8):
            for primary in itertools.product((False,True),repeat=n):
                cnf=CNF(Path(temp)/'threshold.cnf')
                lits=[cnf.var(v) for v in primary]
                for k in range(1,n+2):
                    threshold=cnf.at_least(lits,k,asserted=False)
                    assert cnf.truth(threshold)==(sum(primary)>=k)
                    threshold_checks+=1
                cnf.finish()
        for r,s in itertools.product(range(7),repeat=2):
            cnf=CNF(Path(temp)/'ordered.cnf')
            rl=[cnf.var(i==r) for i in range(7)]
            sl=[cnf.var(i==s) for i in range(7)]
            cnf.exactly_one(rl);cnf.exactly_one(sl);prefix=False
            for i in range(7):
                prefix=cnf.and_or(prefix,sl[i],True)
                cnf.clause((-rl[i],-prefix),gate=False)
            cnf.finish()
            clauses=[tuple(map(int,line.split()[:-1])) for line in cnf.path.read_text().splitlines()[1:]]
            assert satisfied(clauses,cnf.bound)==(r<s);order_checks+=1
    result=dict(GF5_addition_multiplication_assignments=field_checks,
        Boolean_relation_domain_assignments=boolean_checks,
        threshold_truth_assignments=threshold_checks,pair_order_assignments=order_checks,
        result='all exact local relation checks passed',
        scope='NEW native CNF primitive semantics; no incidence solve')
    args.output.write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))

if __name__=='__main__':main()
