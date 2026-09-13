#!/usr/bin/env python3
"""Independent small exact algebra and precision checks for the next Pro question.

Uses the returned polynomial coefficients, but no producer arithmetic import.
The scheme calculation is in independent variables y_i=x_i^5; it is NOT a
claim that the inseparable scheme written in x_i is smooth.
"""
import argparse
import hashlib
import itertools
import json
from pathlib import Path

ZERO = (0, 0, 0, 0)
ONE = (1, 0, 0, 0)
def elt(x):
    return (x % 5, 0, 0, 0) if isinstance(x, int) else tuple(c % 5 for c in x)
def add(x, y): return tuple((a+b) % 5 for a,b in zip(x,y))
def neg(x): return tuple(-a % 5 for a in x)
def sub(x, y): return add(x, neg(y))
def mul(x, y):
    z = [0]*7
    for i,a in enumerate(x):
        for j,b in enumerate(y): z[i+j] += a*b
    for i in range(6,3,-1):
        for j,q in enumerate((3,4,1,4)): z[i-4+j] -= q*z[i]
    return tuple(a % 5 for a in z[:4])
def power(x, n):
    a = ONE
    while n:
        if n & 1: a = mul(a, x)
        x = mul(x, x); n //= 2
    return a
def inv(x):
    assert x != ZERO
    return power(x, 623)
def det2(x): return sub(mul(x[0][0],x[1][1]),mul(x[0][1],x[1][0]))
def rank(matrix):
    a = [list(r) for r in matrix]; k = 0
    for c in range(len(a[0])):
        js = [j for j in range(k,len(a)) if a[j][c] != ZERO]
        if not js: continue
        j = js[0]; a[k],a[j] = a[j],a[k]
        v = inv(a[k][c]); a[k] = [mul(v,x) for x in a[k]]
        for j in range(len(a)):
            if j != k:
                v=a[j][c]; a[j]=[sub(x,mul(v,y)) for x,y in zip(a[j],a[k])]
        k += 1
        if k == len(a): break
    return k
def psum(a,b):
    c = [ZERO]*max(len(a),len(b))
    for i,x in enumerate(a): c[i]=add(c[i],x)
    for i,x in enumerate(b): c[i]=add(c[i],x)
    while len(c)>1 and c[-1]==ZERO: c.pop()
    return c
def pmul(a,b):
    c = [ZERO]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b): c[i+j]=add(c[i+j],mul(x,y))
    return psum(c,[])
def peval(a,x):
    out=ZERO
    for c in reversed(a): out=add(mul(out,x),c)
    return out
def pdiff(a): return [mul(elt(i),x) for i,x in enumerate(a)][1:] or [ZERO]
def detpoly(a):
    out=[ZERO]
    for perm in itertools.permutations(range(len(a))):
        inversions=sum(perm[i]>perm[j] for i in range(len(a)) for j in range(i+1,len(a)))
        term=[elt(-1 if inversions%2 else 1)]
        for i,j in enumerate(perm): term=pmul(term,a[i][j])
        out=psum(out,term)
    return out
def vp_factorial(n):
    out=0
    while n: n//=5; out+=n
    return out

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('certificate',type=Path)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args(); p=args.certificate
    u=json.loads((p/'work/receipts/universal2100.json').read_text())
    C=[elt(x) for x in u['constant']]
    L=[[elt(x) for x in row] for row in u['linear_fifth']]
    assert all(elt(x)==ZERO for row in u['linear_x'] for x in row)
    Q={(r['i'],r['j']):[elt(x) for x in r['coefficient']] for r in u['quadratic_fifth']}
    point=json.loads((p/'point_and_fourth_digit.json').read_text())
    x=[elt(a) for a in point['parameters']]; y=[power(a,5) for a in x]
    def evaluate(y):
        out=C.copy()
        for i in range(9): out=[add(c,mul(b,y[i])) for c,b in zip(out,L[i])]
        for (i,j),row in Q.items(): out=[add(c,mul(b,mul(y[i],y[j]))) for c,b in zip(out,row)]
        return out
    assert evaluate(y)==[ZERO]*9
    J=[[L[i][r] for i in range(9)] for r in range(9)]
    for (i,j),row in Q.items():
        for r in range(9):
            J[r][i]=add(J[r][i],mul(row[r],y[j]))
            J[r][j]=add(J[r][j],mul(row[r],y[i]))
    assert rank(J)==5
    det34=det2([[J[r][i] for i in (3,4)] for r in (1,2)])
    det78=det2([[J[r][i] for i in (7,8)] for r in (5,6)])
    assert det34!=ZERO and det78!=ZERO and L[5][3]!=ZERO
    # E5,E6 are in (y7,y8), with invertible linear coefficient at the point.
    assert all(C[r]==ZERO and all(L[i][r]==ZERO for i in range(7)) for r in (5,6))
    assert all(row[r]==ZERO or i in (7,8) or j in (7,8)
               for (i,j),row in Q.items() for r in (5,6))
    # On y7=y8=0, all equations except E1,E2,E3,E4 vanish.
    for r in (0,5,6,7,8):
        assert C[r]==ZERO and all(L[i][r]==ZERO for i in range(7))
        assert all(row[r]==ZERO for (i,j),row in Q.items() if max(i,j)<7)
    assert C[3]==C[4]==ZERO
    assert all(L[i][3]==L[i][4]==ZERO for i in (0,1,2,3,4))
    assert all(row[3]==row[4]==ZERO for (i,j),row in Q.items() if max(i,j)<7)
    assert L[5][4]==mul(elt(2),L[5][3]) and L[6][4]==mul(elt(2),L[6][3])
    relation=sub(ZERO,mul(inv(L[5][3]),L[6][3]))
    # Two quadrics on the slice: resultant in a=y3, eliminating b=y4.
    def coefficients(r):
        return [[C[r],L[3][r],Q[3,3][r]], [L[4][r],Q[3,4][r]], [Q[4,4][r]]]
    f,g=coefficients(1),coefficients(2); z=[ZERO]
    res=detpoly([[f[2],f[1],f[0],z],[z,f[2],f[1],f[0]],
                 [g[2],g[1],g[0],z],[z,g[2],g[1],g[0]]])
    assert len(res)==5
    roots=[]
    for a in itertools.product(range(5),repeat=4):
        if peval(res,a)!=ZERO: continue
        # g2*f-f2*g is linear in b at every resultant root.
        b1=sub(mul(g[2][0],peval(f[1],a)),mul(f[2][0],peval(g[1],a)))
        b0=sub(mul(g[2][0],peval(f[0],a)),mul(f[2][0],peval(g[0],a)))
        assert b1!=ZERO
        b=mul(neg(b0),inv(b1))
        yy=[ZERO]*9; yy[3]=a; yy[4]=b
        assert evaluate(yy)==[ZERO]*9 and peval(pdiff(res),a)!=ZERO
        roots.append({'a':a,'b':b,'x3':power(a,125),'x4':power(b,125)})
    assert len(roots)==4
    # Next level: source exponential uses n=4 AND n=5, output Taylor up to5.
    assert 4-vp_factorial(4)==5-vp_factorial(5)==4
    assert 5-1-vp_factorial(5)==3
    assert all(n-vp_factorial(n)>=5 for n in range(6,1001))
    assert all(n-1-vp_factorial(n)>=4 for n in range(6,1001))
    result={'status':'PASS','scope':'Exact consequences of returned coefficient table and W5 precision diagnostics, not a W5 obstruction computation.',
            'coefficient_sha256':hashlib.sha256((p/'work/receipts/universal2100.json').read_bytes()).hexdigest(),
            'jacobian_in_independent_fifth_power_variables':{'rank':5,'det_E1E2_y3y4':det34,'det_E5E6_y7y8':det78},
            'local_germ_in_y':{'dimension':4,'free_variables':[0,1,2,6],'y7':0,'y8':0,'y5_over_y6':relation,
                             'proof':'Invertible E5,E6 coefficient matrix eliminates y7,y8 in the completed local ring; E4=2E3 leaves one unit linear equation for y5. Invertible E1,E2 derivative eliminates y3,y4. All other equations then vanish exactly.',
                             'warning':'Frobenius y=x^[5] is not an etale coordinate change; no smoothness claim for the scheme in actual x-coordinates.'},
            'reduced_slice_resultant_constant_first':res,'all_four_geometric_reduced_slice_points':roots,
            'W5_edge_checks':{'curve_modulus':3125,'output_modulus':625,'source_exp_orders_needed':[1,2,3,4,5],
                              'higher_Taylor_order5_can_survive_at':125,'preceding_scalar_required_modulo':25,
                              'factorial_bound_checked_through':1000,
                              'all_order_bound':'v5(n!)<n/4; for n>=6, n-1-v5(n!)>=4 (n=6 checked directly).'},
            'next_target':'W5 existence above the fixed witnessed T3, allowing all9compatible fourth digits. Neither rank5 of this y-Jacobian nor a nonempty W4 locus supplies this next comparison.'}
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))

if __name__=='__main__': main()
