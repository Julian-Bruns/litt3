#!/usr/bin/env python3
"""Verify the delivered ideal certificate and the auxiliary exact checks.
Run from any working directory: python3 /path/to/archive/verify.py
Requires only the Python standard library. Does not rerun a Groebner algorithm.
"""
import argparse, hashlib, itertools, json, os, platform, subprocess, sys
from pathlib import Path
sys.dont_write_bytecode=True
ROOT=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'src'))
from verify_dag import ADD,MUL,fadd,fmul
NEG=[next(b for b in range(25) if ADD[a][b]==0) for a in range(25)]
INV=[0]+[next(b for b in range(1,25) if MUL[a][b]==1) for a in range(1,25)]

def trim(p):
    p=list(p)
    while p and not p[-1]:p.pop()
    return p

def p_add(a,b):
    return trim([ADD[a[i] if i<len(a) else 0][b[i] if i<len(b) else 0] for i in range(max(len(a),len(b)))])

def p_neg(a):return [NEG[c] for c in a]

def p_mul(a,b):
    if not a or not b:return []
    z=[0]*(len(a)+len(b)-1)
    for i,c in enumerate(a):
        for j,d in enumerate(b):z[i+j]=ADD[z[i+j]][MUL[c][d]]
    return trim(z)

def p_pow(a,n):
    z=[1]
    while n:
        if n&1:z=p_mul(z,a)
        a=p_mul(a,a);n//=2
    return z

def p_rem(a,b):
    a=trim(a);b=trim(b)
    if not b:raise ZeroDivisionError('zero polynomial divisor')
    while len(a)>=len(b):
        d=len(a)-len(b);c=MUL[a[-1]][INV[b[-1]]]
        for i,v in enumerate(b):a[i+d]=ADD[a[i+d]][NEG[MUL[c][v]]]
        a=trim(a)
    return a

def p_deriv(a):return trim([MUL[i%5][a[i]] for i in range(1,len(a))])

def p_gcd(a,b):
    while b:a,b=b,p_rem(a,b)
    if not a:return []
    return [MUL[c][INV[a[-1]]] for c in a]

def check_manifest():
    lines=(ROOT/'MANIFEST.sha256').read_text().splitlines()
    for line in lines:
        digest,rel=line.split('  ',1)
        path=ROOT/rel
        if not path.is_file() or hashlib.sha256(path.read_bytes()).hexdigest()!=digest:
            raise AssertionError('manifest mismatch: '+rel)
    print(f'PASS: SHA-256 manifest, {len(lines)} files.',flush=True)

def check_field_and_curve():
    # An independent convolution/reduction implementation builds the tables.
    assert all((b*b-b-3)%5 for b in range(5))
    assert MUL[5][5]==8  # beta^2=3+beta
    for a,b,c in itertools.product(range(25),repeat=3):
        assert MUL[a][ADD[b][c]]==ADD[MUL[a][b]][MUL[a][c]]
        assert MUL[MUL[a][b]][c]==MUL[a][MUL[b][c]]
    print('PASS: F25 modulus is irreducible; field relation, distributivity and associativity checked.',flush=True)
    d=json.loads((ROOT/'data/curve.json').read_text())
    assert d['field']['characteristic']==5 and d['field']['degree']==2
    assert d['field']['modulus_ascending']==[2,4,1]
    P,A,Q,B,L=[d[k] for k in ('P','A','Q','B0','L')]
    assert p_deriv(Q)==p_mul(P,p_pow(A,2))
    assert not p_rem(p_add(Q,p_neg(p_pow(B,5))),p_pow(P,2))
    assert not p_rem(p_add(Q,p_neg(p_pow(L,5))),p_pow(A,3))
    assert p_gcd(P,p_deriv(P))==[1]
    assert p_gcd(A,p_deriv(A))==[1]
    assert p_gcd(P,A)==[1]
    print("PASS: Q'=P*A^2; P^2 divides Q-B0^5; A^3 divides Q-L^5; squarefreeness and coprimality.",flush=True)
    return P

def check_norm_inputs(P):
    # Independent coefficient reconstruction by enumerating the 64 ordered
    # factors of g^3 and the 243 ordered factors of H^2*J^3.
    eq=[{} for _ in range(11)];zero=(0,)*8
    def insert(i,m,c):
        z=ADD[eq[i].get(m,0)][c]
        if z:eq[i][m]=z
        elif m in eq[i]:del eq[i][m]
    for i,c in enumerate(P):insert(i,zero,c)
    for choices in itertools.product(range(4),repeat=3):
        e=[0]*8
        for i in choices:e[i]+=1
        insert(sum(choices),tuple(e),1)
    for choices in itertools.product(range(3),repeat=5):
        e=[0]*8
        for k,i in enumerate(choices):
            if i<2:e[(4 if k<2 else 6)+i]+=1
        insert(sum(choices),tuple(e),4)
    assert not eq[10]
    data=json.loads((ROOT/'data/norm_system.json').read_text())
    assert data['field']['p']==5 and data['field']['degree']==2
    assert data['field']['modulus_ascending']==[2,4,1]
    assert data['variables']==['g0','g1','g2','g3','h0','h1','j0','j1']
    assert data['P']==P
    assert len(data['equations'])==10
    for i,e in enumerate(data['equations']):
        assert e['x_coefficient']==i
        assert len(e['terms'])==len(eq[i])
        assert {tuple(m):c for m,c in e['terms']}==eq[i]
    # The generator's plain-text input must describe exactly the same ideal.
    nums=list(map(int,(ROOT/'data/norm_system.txt').read_text().split()))
    assert nums[:2]==[8,10];pos=2
    for e in eq[:10]:
        num=nums[pos];pos+=1;actual={}
        for _ in range(num):
            c=nums[pos];m=tuple(nums[pos+1:pos+9]);pos+=9
            assert m not in actual;actual[m]=c
        assert actual==e
    assert pos==len(nums)
    print('PASS: all 10 input equations reconstructed independently from P+g^3-H^2*J^3.',flush=True)

def partitions(n,mx=None):
    if not n:
        yield ();return
    if mx is None:mx=n
    for a in range(min(n,mx),0,-1):
        for p in partitions(n-a,a):yield (a,)+p

def check_pole_tables():
    basis=[(a,j) for j in range(3) for a in range(20) if 3*a+10*j<=14]
    assert basis==[(0,0),(1,0),(2,0),(3,0),(4,0),(0,1),(1,1)]
    orders={3*a+10*j for a,j in basis}
    assert orders=={0,3,6,9,10,12,13}
    expected={0:[(4,4,2),(4,4,1,1),(3,3,3,1),(3,3,2,2),(3,3,2,1,1),(2,2,2,2,2)],1:[(3,3,1),(2,2,2,1)],2:[(1,1,1,1)]}
    for d in range(3):
        before=[p for p in partitions(10-3*d) if len(p)<=5 and p.count(p[0])>=2]
        keep=[p for p in before if p.count(p[0])!=2 or 4+2*p[0] in {s-3*d for s in orders}]
        assert keep==expected[d]
        print(f'PASS: degree(v)={d}, necessary G multiplicities over O: {keep}',flush=True)
    branch_before=[p for p in partitions(6) if len(p)<=5 and p.count(p[0])>=2]
    assert branch_before==[(3,3),(2,2,2),(2,2,1,1)]
    # The omitted partition would require ord_r(D)=2, proved impossible in
    # REPORT section 5.6. This enumeration is not a substitute for that proof.
    assert [p for p in branch_before if p!=(2,2,1,1)]==[(3,3),(2,2,2)]
    print('PASS: finite branch-square partition enumeration; theoretical exclusions are in REPORT.md.',flush=True)

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--skip-manifest',action='store_true',help='for the archive-build stage only')
    args=ap.parse_args()
    print('Python '+platform.python_version(),flush=True)
    if not args.skip_manifest:check_manifest()
    P=check_field_and_curve();check_norm_inputs(P);check_pole_tables()
    subprocess.run([sys.executable,str(ROOT/'src/verify_dag.py'),str(ROOT/'data/norm_system.json'),str(ROOT/'certificates/norm_unit_ideal.dag')],check=True)
    print('ALL CHECKS PASSED. The actual polynomial-v cover-existence problem remains unresolved.',flush=True)
    return 0
if __name__=='__main__':sys.exit(main())
