#!/usr/bin/env python3
"""Exhaust primitive marked divisors by exact, rank-pruned Hermite search.

At most two occupied sheets per marked fibre are admitted. Polynomial
content must first be removed in the mathematical reduction. A function
of exact pole n is sought in L(nO), with unrestricted geometric
coefficients. Once a kernel is a line its complete marked divisor is
checked directly, pruning every continuation of that line at once.
"""
import argparse,hashlib,json,time
from pathlib import Path
from sage.all import vector
from supported_one_sheet_jets import field_and_jets

def main():
    ap=argparse.ArgumentParser();ap.add_argument('pole',type=int);ap.add_argument('output',type=Path)
    args=ap.parse_args();start=time.monotonic();n=args.pole
    K,columns,raw,field,code=field_and_jets(n)
    top=next(i for i,(a,b) in enumerate(columns) if 3*a+10*b==n)
    nonconstant_character=[i for i,(a,b) in enumerate(columns) if b]
    jets=[[[vector(K,row) for row in rows] for rows in phases] for phases in raw]
    dim=len(columns);initial=[vector(K,[int(i==j) for i in range(dim)]) for j in range(dim)]
    stats=dict(nodes=0,cuts=0,zero_kernels=0,top_zero=0,polynomial_only=0,line_checks=0,
               repeated_lines=0,branches=0)
    survivors=[];seen_lines=set();digest=hashlib.sha256();last_report=start

    def check_line(basis):
        v=basis[0];pivot=next(c for c in v if c);v=v/pivot
        encoded=tuple(code(c) for c in v)
        if encoded in seen_lines:
            stats['repeated_lines']+=1;return
        seen_lines.add(encoded);stats['line_checks']+=1
        orders=[]
        for i in range(4):
            for phase in range(3):
                order=next((j for j,row in enumerate(jets[i][phase]) if v.dot_product(row)),n+1)
                orders.append(order)
        assert sum(orders)<=n, (encoded,orders)
        digest.update(json.dumps([encoded,orders],separators=(',',':')).encode()+b'\n')
        if sum(orders)==n:
            witness=dict(coefficients=encoded,orders=orders)
            survivors.append(witness);print('EXACT SUPPORTED FUNCTION',witness,flush=True)

    def usable(basis):
        if not basis:stats['zero_kernels']+=1;return False
        if all(not b[top] for b in basis):stats['top_zero']+=1;return False
        if all(not b[j] for b in basis for j in nonconstant_character):
            stats['polynomial_only']+=1;return False
        if len(basis)==1:check_line(basis);return False
        return True

    def cut(basis,row):
        stats['cuts']+=1
        values=[b.dot_product(row) for b in basis]
        pivot=next((i for i,c in enumerate(values) if c),None)
        if pivot is None:return basis
        bp=basis[pivot];iv=values[pivot]**-1
        return [b-(values[i]*iv)*bp if values[i] else b
                for i,b in enumerate(basis) if i!=pivot]

    def chain(basis,fibre,phase,budget):
        current=basis
        for m in range(1,budget+1):
            current=cut(current,jets[fibre][phase][m-1])
            if not usable(current):break
            yield m,current

    def visit(fibre,left,basis,occupied):
        nonlocal last_report
        stats['nodes']+=1
        if fibre==4:
            assert left!=0, 'A degree-zero residual divisor cannot retain a kernel of dimension>1'
            return
        if left==0:return
        # Leaving this complete fibre unoccupied imposes no new condition.
        visit(fibre+1,left,basis,occupied)
        # If this is the first occupied fibre, its phase orbit has one
        # representative (a,0,0) or (a,b,0) with a,b>0.
        singles=range(3) if occupied else (0,)
        for phase in singles:
            for a,Ba in chain(basis,fibre,phase,left):
                stats['branches']+=1
                visit(fibre+1,left-a,Ba,True)
        pairs=((0,1),(1,2),(2,0)) if occupied else ((0,1),)
        for first,second in pairs:
            for a,Ba in chain(basis,fibre,first,left-1):
                for b,Bb in chain(Ba,fibre,second,left-a):
                    stats['branches']+=1
                    visit(fibre+1,left-a-b,Bb,True)
        now=time.monotonic()
        if now-last_report>15:
            print('pole',n,'fibre',fibre,'left',left,'stats',stats,
                  'seconds',round(now-start,2),flush=True);last_report=now

    visit(0,n,initial,False)
    result=dict(pole=n,field=field,columns=columns,stats=stats,survivors=survivors,
        exact_line_check_digest=digest.hexdigest(),elapsed_seconds=time.monotonic()-start,
        scope='all exact-pole primitive functions with at most two sheets in each of four marked fibres',
        proof_of_pruning='Linear kernels only shrink. A one-dimensional kernel fixes the entire function; its actual marked valuation sum is checked before any continuation is discarded.')
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print('COMPLETE',json.dumps(result),flush=True)

if __name__=='__main__':main()
