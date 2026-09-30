#!/usr/bin/env python3
"""Uniform Newton bounds for the constant-v degree140 family.

Full mode uses a proved q-degree bound, not finite-field point sampling.
The assertion being tested is whether one fixed-ratio determinant certificate
also certifies a nonzero generic elimination in q.
"""
import argparse
from math import comb
import json
from pathlib import Path
import sys
import numpy as np
from degree140_constant_ratio import assignment


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('package', type=Path)
    ap.add_argument('fiber', type=Path)
    ap.add_argument('--points', type=int, default=459)
    ap.add_argument('--out', type=Path, required=True)
    args = ap.parse_args()
    root, work = args.package.resolve(), args.fiber.resolve()
    sys.path[:0] = [str(root/'src'), str(root/'prior/src')]
    import exact as E
    from atlas import fixed_data
    from cube_chart import evaluate as cube_evaluate
    from fast import Fast
    from interpolation import interp_vec
    from verify_support import load, specialize_sparse
    E.init(work/'field.bin')
    fast = Fast(work/'fast_exact.so', work/'field.bin')
    P, A, Q, B, L, t, Ct = fixed_data()
    cube = load(root/'prior/data/cube_constant.json')
    assert all(-1 <= ex[1] <= 4 and 0 <= ex[0] <= 1 and 0 <= ex[3] <= 2
               for g in cube['G'] for ex, c in g)
    assert all(ex == [0,0,0,0] for ex,c in cube['common_denominator_d'])
    assert max(ex[1] for ex,c in cube['Psi'] if ex[0] == 0) <= 7
    assert max(ex[1] for ex,c in cube['Psi'] if ex[0] == 1) <= 2
    # q^37*R has q-degree <=206: original (10,2) resultant has twelve
    # coefficient factors; reducing Y^3=P/q gives q-range [-20,48].
    # Cubic norm gives [-62,144], division by (P/q)^40*(qt)^15 adds25.
    # Translation H->H-Psi0/Psi1, cleared by Psi1^36, has degree <=458.
    q_degree = 206
    translation_degree = 458
    count = args.points
    assert 1 <= count <= 1000
    lo = np.full((75,7),10000,dtype=int)
    hi = np.full((75,7),-10000,dtype=int)
    vp = np.full((75,7),10000,dtype=int)
    Hpoints = np.arange(37,dtype=np.int32)
    # Build the exact interpolation matrix once, avoiding repeated vector
    # divided differences. Characteristic-five code integers 0..4 are scalars.
    matrix = interp_vec(Hpoints,np.eye(37,dtype=np.int32))
    records = []
    q = 0
    while len(records) < count:
        q += 1
        psi = specialize_sparse(cube['Psi'],q)
        if len(psi) != 2 or not psi[0]:
            continue
        vals = np.stack([fast.residual(cube_evaluate(cube,int(h),q),None,
                                      E.scale(P,E.F.I(q)),E.scale(t,q)) for h in Hpoints])
        tensor = np.zeros_like(vals)
        for i in range(37):
            for j in range(37):
                if matrix[i,j]: tensor[i] = E.F.add(tensor[i],E.F.mul(vals[j],int(matrix[i,j])))
        # Restrict to reversed coefficients needed by j71..j74.
        raw = tensor[:,:,140:65:-1].transpose(0,2,1)
        translated = np.zeros_like(raw)
        r = E.F.N(E.F.M(int(psi[0]),E.F.I(int(psi[1]))))
        powers = [E.F.P(r,j) for j in range(37)]
        for h in range(37):
            for j in range(h+1):
                c = comb(h,j)%5
                if c: translated[j] = E.F.add(translated[j], E.F.mul(raw[h],E.F.M(c,powers[h-j])))
        for h in range(37):
            nonzero = raw[h] != 0
            lo[nonzero] = np.minimum(lo[nonzero],h)
            hi[nonzero] = np.maximum(hi[nonzero],h)
            nonzero = translated[h] != 0
            vp[nonzero] = np.minimum(vp[nonzero],h)
        import hashlib
        records.append({'q':q,'residual_H_tensor_sha256':hashlib.sha256(tensor.tobytes()).hexdigest()})
        if len(records)%25 == 0:
            print('Verified full coefficient identities at',len(records),'q values',flush=True)
    # Tropical products, using 63=3+2*5+2*25. No factorial denominators.
    shape = (75,106)
    def multiply(a,b,minimum):
        sentinel=100000 if minimum else -100000
        c=np.full(shape,sentinel,dtype=int)
        op=np.minimum if minimum else np.maximum
        for m,l in np.argwhere(b!=sentinel):
            part=a[:75-m,:106-l]
            value=part+int(b[m,l])
            value=np.where(part==sentinel,sentinel,value)
            op(c[m:,l:],value,out=c[m:,l:])
        return c
    def frob(a,k,minimum):
        sentinel=100000 if minimum else -100000
        b=np.full(shape,sentinel,dtype=int)
        for m,l in np.argwhere(a!=sentinel):
            if m*k<75 and l*k<106:b[m*k,l*k]=k*a[m,l]
        return b
    def power63(source,minimum):
        sentinel=100000 if minimum else -100000
        a=np.full(shape,sentinel,dtype=int)
        for m in range(75):
            for l in range(7):
                if abs(source[m,l])<10000:a[m,l]=source[m,l]
        a2=multiply(a,a,minimum)
        a3=multiply(a2,a,minimum)
        return multiply(multiply(a3,frob(a2,5,minimum),minimum),frob(a2,25,minimum),minimum)
    low,high,psi_low=power63(lo,True),power63(hi,False),power63(vp,True)
    coefficients=load(work/'coefficients.json')
    raw_bounds=[]
    for row in coefficients['errors']:
        index=row['index']; removal=400+row['H_removed']
        assert row['psi_removed']==0
        raw_bounds.append({'index':index,'H_power_removed':removal,
                           'low':(low[index]-removal).tolist(),
                           'high':(high[index]-removal).tolist(),
                           'psi_low':psi_low[index].tolist()})
    results=[]
    for jj in [1,3]:
        f,g=raw_bounds[0],raw_bounds[jj]
        cert=load(work/f'G71_{71+jj}.bounds.json');m,n=cert['fixed_degrees']
        checks=[]
        global_duals=[]
        assert all(f['high'][i] < -10000 for i in range(m+1,106))
        assert all(g['high'][i] < -10000 for i in range(n+1,106))
        for number,kind in enumerate(['low','high','psi_low']):
            mat=np.full((m+n,m+n),10**8,dtype=int)
            for rr,rows,off,degree in [(f,n,0,m),(g,m,n,n)]:
                weights=[]
                for l in range(degree,-1,-1):
                    x=rr[kind][l]
                    weights.append(10**8 if abs(x)>10000 else (-x if kind=='high' else x))
                for i in range(rows):mat[off+i,i:i+degree+1]=weights
            bound=cert['bounds'][number]
            u,v=np.array(bound['row_duals']),np.array(bound['column_duals'])
            failures=np.argwhere(u[:,None]+v[None,:]>mat)
            uu,vv,matching=assignment(mat)
            sign=-1 if kind=='high' else 1
            global_duals.append({'kind':kind,'sign':sign,'row_duals':uu,'column_duals':vv,
                                 'matching':matching,'bound':sign*(sum(uu)+sum(vv))})
            checks.append({'kind':kind,'valid':len(failures)==0,'failure_count':len(failures),
                           'first_failures':failures[:6].tolist(),
                           'new_global_bound':global_duals[-1]['bound'],
                           'matches_fiber_bound':global_duals[-1]['bound']==bound['bound']})
        results.append({'resultant':f'G71_{71+jj}','checks':checks,'global_duals':global_duals})
    from verify_support import readpoly
    fiber_degrees=[len(readpoly(work/f'G71_{j}.poly'))-1 for j in [72,74]]
    generic_bounds=[]
    for r in results:
        bounds=[d['bound'] for d in r['global_duals']]
        generic_bounds.append(bounds[1]-bounds[0]-bounds[2])
    certified=count>translation_degree
    if certified:
        assert all(min(x for x in r['low'] if x<10000)>=0 for r in raw_bounds)
        assert all(c['matches_fiber_bound'] for r in results for c in r['checks'])
        assert fiber_degrees[0]==generic_bounds[0]==22865
        assert fiber_degrees[1]==23502<=generic_bounds[1]==23505
        assert readpoly(work/'bezout.gcd').tolist()==[1]
    data={'status':'uniform_support_certified' if count>translation_degree else 'bounded_diagnostic',
          'q_degree_bound':q_degree,'translated_q_degree_bound':translation_degree,
          'number_of_valid_q':count,'records':records,'bounds':raw_bounds,'dual_tests':results,
          'fiber_H_degrees':fiber_degrees,'generic_H_degree_bounds':generic_bounds,
          'generic_elimination_nonzero':certified,
          'scope':'Constant-v squares have q in a finite necessary algebraic set; no expanded q polynomial, enumeration of its roots, or full exclusion is claimed.'}
    args.out.parent.mkdir(parents=True,exist_ok=True)
    args.out.write_text(json.dumps(data,indent=2)+'\n')
    print(json.dumps([{k:v for k,v in r.items() if k!='global_duals'}for r in results],indent=2),flush=True)


if __name__=='__main__':main()
