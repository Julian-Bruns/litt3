#!/usr/bin/env python3
"""Geometric horizontal-section certificates for residue-cost profiles.

The logarithmic differential is obtained from the unique equivariant
Cartier-fixed differential with the prescribed residues.  The underlying
section coefficients are arbitrary geometric coefficients.
"""
import argparse,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix
from supported_one_sheet_jets import field_and_jets,compositions
p=argparse.ArgumentParser();p.add_argument('profiles',type=Path);p.add_argument('connection',type=Path);p.add_argument('output',type=Path)
args=p.parse_args();args.output.mkdir(parents=True,exist_ok=True)
inputs=json.loads(args.profiles.read_text());con=json.loads(args.connection.read_text());N=max(c['pole_bound'] for c in inputs['cases'])
K,cols,jets,field,code=field_and_jets(N)
assert field==con['field']
decode=lambda n:K([GF(5)((n//(5**i))%5) for i in range(8)])
alpha=decode(field['alpha']);p0=decode(field['p0']);beta=decode(field['beta']);zeta=decode(field['zeta'])
dec=lambda n:K(n%5)+K(n//5)*beta
R=PolynomialRing(K,'x');x=R.gen();P=R([dec(n) for n in [11,22,18,5,19,20,15,16,9,22,1]]);Q=P/p0
roots=[alpha**(25**i) for i in range(4)];den=R(1)
for a in roots:den*=x-a
A=R([decode(n) for n in con['A']]);B=R([decode(n) for n in con['B']])
forms=[]
for i,a in enumerate(roots):
    d=den//(x-a);aa=R([c**(25**i) for c in A]);bb=R([c**(25**i) for c in B]);rr=p0**((25**i-1)//3)
    for s in range(3):
        rho=rr*zeta**s
        forms.append([d/3,rho*rho*bb*d,rho*aa*d])
out=[];start=time.monotonic()
for ix,case in enumerate(inputs['cases']):
    fn=args.output/f'case_{ix:04d}.json'
    if fn.exists():
        old=json.loads(fn.read_text());out.append({k:old[k] for k in ['index','base','blocks','pole_bound','dimension','status']});continue
    then=time.monotonic();base=case['base'];n=case['pole_bound'];bmax=case['blocks']
    H=[sum((K(base[i]%5)*forms[i][j] for i in range(12)),R(0)) for j in range(3)]
    ids=[i for i,(ii,jj) in enumerate(cols) if 3*ii+10*jj<=n];mons=[cols[i] for i in ids]
    def diff(col):
        i,j=col;g=[R(0)]*3;g[j]=x**i;U,V,W=g;h0,h1,h2=H
        return [den*Q*U.derivative()-(Q*h0*U+Q*h1*W+Q*h2*V),
                den*(Q*V.derivative()+Q.derivative()*V/3)-(Q*h0*V+h1*U+Q*h2*W),
                den*(Q*W.derivative()+2*Q.derivative()*W/3)-(Q*h0*W+h1*V+h2*U)]
    ims=[diff(c) for c in mons];md=max(f.degree() for fs in ims for f in fs)
    M=matrix(K,[[fs[j][i] for j in range(3) for i in range(md+1)] for fs in ims]).transpose()
    base_rows=[]
    for z,m in enumerate(base):base_rows.extend([[r[t] for t in ids] for r in jets[z//3][z%3][:m]])
    if base_rows:M=M.stack(matrix(K,base_rows))
    ker=M.right_kernel().basis_matrix().transpose();k=ker.ncols()
    rec={'index':ix,**case,'dimension':int(k),'monomials':mons,
         'constraint_shape':[M.nrows(),M.ncols()], 'kernel':[[code(c) for c in row] for row in ker.rows()]}
    if k==0:
        piv=list(M.transpose().pivots());assert len(piv)==M.ncols()
        rec.update(status='excluded_zero_horizontal_space',rows=piv,det=code(M.matrix_from_rows(piv).det()))
    else:
        # The least pole possible in this space determines the minimum
        # number of remaining zeros. All monomial pole orders are distinct.
        minimal=n
        for mm in range(sum(base),n+1):
            high=[ii for ii,(i,j) in enumerate(mons) if 3*i+10*j>mm]
            rank=ker.matrix_from_rows(high).rank() if high else 0
            if rank<k:minimal=mm;break
        assert (minimal-sum(base))%5==0
        bmin=(minimal-sum(base))//5;rec['minimum_blocks']=bmin
        if bmin<k:
            rec.update(status='unresolved_small_zero_count')
        else:
            evals=[]
            for z in range(12):
                rows=[[jets[z//3][z%3][base[z]+5*j][t] for t in ids] for j in range(k)]
                evals.append(matrix(K,rows)*ker)
            minors=[];bad=[]
            for D in compositions(k,12):
                rows=[]
                for z,m in enumerate(D):rows+=evals[z][:m,:].rows()
                mm=matrix(K,rows);dt=mm.det()
                if dt:minors.append({'D':D,'det':code(dt)})
                else:bad.append({'D':D,'rank':int(mm.rank())})
            rec.update(status='excluded_all_support_subdivisors' if not bad else 'unresolved_rank_defects',
                       subdivision_degree=int(k),minors=minors,rank_defects=bad)
    rec['elapsed_seconds']=round(time.monotonic()-then,3)
    fn.write_text(json.dumps(rec,separators=(',',':'))+'\n')
    short={j:rec[j] for j in ['index','base','blocks','pole_bound','dimension','status']};out.append(short)
    (args.output/'summary.json').write_text(json.dumps(out,indent=2)+'\n');print(short,'seconds',rec['elapsed_seconds'],flush=True)
print('COMPLETE',len(out),'cases',round(time.monotonic()-start,3),flush=True)
