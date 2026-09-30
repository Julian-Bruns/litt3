#!/usr/bin/env python3
"""Independent polynomial reconstruction of the complete pencil boundary."""
import argparse,hashlib,json,math,re
from pathlib import Path
import check_klein_four_constant_pencils as C
T=C.T;F=C.F;Z=C.Z;O=C.O


def solve(mat,rhs):
    a=[list(row)+[v] for row,v in zip(mat,rhs)];n=len(mat)
    assert all(len(row)==n+1 for row in a)
    for j in range(n):
        i=next(i for i in range(j,n) if a[i][j]!=Z)
        a[i],a[j]=a[j],a[i];unit=T.inv(a[j][j]);a[j]=[T.mul(v,unit) for v in a[j]]
        for i in range(n):
            if i!=j:
                c=a[i][j];a[i]=[T.sub(v,T.mul(c,w)) for v,w in zip(a[i],a[j])]
    return [row[-1] for row in a]


def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('directory',type=Path)
    args=ap.parse_args();p=args.directory
    z=(0,1,0,0,0,0,0);zs=[C.power(z,i) for i in range(29)]
    probes=[]
    for line in (p/'pencil_boundary_probe.log').read_text().splitlines():
        if not line.startswith('PROBE '):continue
        vals=list(map(int,line.split()[1:]));d,mask=vals[:2]
        delta,an,bn,cn=[tuple(vals[2+7*j:9+7*j]) for j in range(4)]
        c=[O]
        for i in range(29):
            if not mask>>i&1:c=C.pm(c,[T.neg(zs[i]),O])
        assert len(c)-1==15+2*d
        qs=[];rs=[]
        for i in range(d+1):
            q,r=C.divide([Z]*(22+i)+[O],c);qs.append(q);rs.append(r+[Z]*(len(c)-1-len(r)))
        mat=[[rs[j][k] for j in range(d+1)] for k in range(16+d,len(c)-1)]
        mat.append([O]+[Z]*d)
        mat.append([C.scale(T.mul(c[0],q[0] if q else Z),2) for q in qs])
        t0=solve(mat,[Z]*(d-1)+[O,Z])
        t1=solve(mat,[Z]*(d-1)+[Z,O])
        words=[]
        for v in (t0,t1):
            q=[Z]*max(map(len,qs))
            for tj,qj in zip(v,qs):
                for i,x in enumerate(qj):q[i]=T.add(q[i],T.mul(tj,x))
            f=[C.scale(x,2) for x in C.pm(c,q)]
            assert all(x==Z for x in f[16+d:22])
            for i,tj in enumerate(v):assert f[22+i]==C.scale(tj,2)
            words.append(f)
        assert words[0][0]==Z and words[1][0]==O
        qa=T.neg(t1[1]);qb=T.sub(words[1][1],t0[1]);qc=words[0][1]
        assert [T.mul(v,T.inv(delta)) for v in (an,bn,cn)]==[qa,qb,qc]
        probes.append({'d':d,'complement_mask':mask,'direct_quadratic_coefficients':[qa,qb,qc]})
    assert len(probes)==42
    totals=[]
    for name in ['pencil_boundary_low.log','pencil_boundary_high.log']:
        for line in (p/name).read_text().splitlines():
            assert line.startswith('TOTAL '),line
            x={k:int(v) for k,v in re.findall(r'(\w+)=(\d+)',line)}
            assert x['covered']==x['normalized_subsets']==math.comb(28,13-2*x['d'])
            for k in ('zero_quadratic','nonrational_hits','quartic_hits','rational_hits'):assert x[k]==0
            totals.append(x)
    assert [x['d'] for x in totals]==list(range(1,7))
    assert [x['representatives'] for x in totals]==[128037,49478,10645,1196,65,2]
    zl=(p/'zero_endpoint_derivative.log').read_text()
    assert zl.strip()=='TOTAL character_tests=804837 zero_B=345 zero_B_nonzero_A=0 nonzero_B_zero_derivative=0'
    # Reconstruct the two quartic-only quadratic coefficients over F25.
    import klein_four_constant_character_jet as J
    old=F.construct_data();roots=list(map(tuple,old['alpha_roots']));bases=list(map(tuple,old['B_base']))
    cc=[];ll=[]
    for a in roots:
        cv=F.es(F.ei(F.ev(F.f.der(F.f.A),a)),13)
        lv=F.em(cv,F.ea(F.em(F.ev(F.f.der(F.f.P),a),F.ei(F.ev(F.f.P,a))),F.en(F.em(F.ev(F.f.der(F.f.der(F.f.A)),a),F.ei(F.ev(F.f.der(F.f.A),a))))))
        cc.append(F.em(cv,F.ep(bases[len(cc)],4)));ll.append(F.em(lv,F.ep(bases[len(ll)],5)))
    quartics=[]
    for tags,expected in [((0,0,1,2),(10,15,0)),((0,0,2,3),(24,18,14))]:
        vals=[]
        for arr in (roots,bases,cc,ll):
            a=F.ZERO
            for tag,sign in zip(tags,J.SIGNS[0]):a=F.ea(a,F.es(arr[tag],sign))
            vals.append(a)
        a,b,da,db=vals;rr=F.em(a,F.ei(b));ss=F.em(F.ea(F.em(da,b),F.en(F.em(a,db))),F.ei(F.ep(b,2)))
        reconstructed=F.ea(F.ea(F.es(F.ep(rr,2),expected[0]),F.es(rr,expected[1])),F.es(F.ONE,expected[2]))
        assert reconstructed==ss
        # Uniqueness from an actual rank-three coefficient matrix.
        cols=[F.ep(rr,2),rr,F.ONE]
        minor_found=False
        import itertools
        for rows in itertools.combinations(range(4),3):
            det=0
            for perm in itertools.permutations(range(3)):
                v=1
                for i,j in enumerate(perm):v=F.f.mul(v,cols[j][rows[i]])
                if sum(perm[i]>perm[j] for i in range(3) for j in range(i+1,3))%2:v=F.f.neg(v)
                det=F.f.add(det,v)
            if det:minor_found=True;break
        assert minor_found
        quartics.append({'roots':tags,'quadratic_coefficients':expected})
    out={'status':'PASS','scope':'Complete forced subset logs;42 independent direct polynomial kernels;two quartic target reconstructions;complete vanishing-derivative label count.',
         'totals':totals,'independent_probes':probes,'quartic_targets':quartics,'zero_derivative_log':zl.strip(),'sha256':{}}
    files=[Path(__file__),Path(__file__).with_name('klein_four_pencil_boundary_all.cpp'),Path(__file__).with_name('klein_four_zero_endpoint_derivative.py'),Path(__file__).with_name('klein_four_zero_endpoint_derivative.cpp')]
    files +=[p/n for n in ['pencil_boundary_low.log','pencil_boundary_high.log','pencil_boundary_probe.log','zero_endpoint_derivative.json','zero_endpoint_derivative.log','linear_pencil_targets.json']]
    for f in files:out['sha256'][str(f)]=hashlib.sha256(f.read_bytes()).hexdigest()
    (p/'pencil_boundary_independent.json').write_text(json.dumps(out,indent=2)+'\n')
    print('PASS: all six full subset boundaries,42 independent coefficient comparisons,two quartic targets,804837 endpoint derivative tests.')


if __name__=='__main__':main()
