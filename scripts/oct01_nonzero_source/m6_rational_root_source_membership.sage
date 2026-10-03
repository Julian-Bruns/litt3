#!/usr/bin/env sage
"""Bounded polynomial row membership; preserves both shift variables."""
from sage.all import *
import argparse,json,time
from pathlib import Path
parser=argparse.ArgumentParser();parser.add_argument('--work',type=Path,required=True);parser.add_argument('--cases',default='0');parser.add_argument('--max-degree',type=int,default=3);args=parser.parse_args();data=args.work/'data';start=time.time();reports=[]
for case in [int(c) for c in args.cases.split(',')]:
    raw=load(str(data/('m6_rational_root_source_case_%s.sobj'%case)));M=raw['matrix'];R=M.base_ring();E=R.base_ring();u,v=R.gens();target=vector(R,raw['source_kappa']);done=False;steps=[]
    for degree in range(args.max_degree+1):
        shifts=[(a,b) for a in range(degree+1) for b in range(degree+1-a)];bound=degree+3;exps=[(a,b) for a in range(bound+1) for b in range(bound+1-a)];columns={(j,a,b):i for i,(j,a,b) in enumerate((j,a,b) for j in range(M.ncols()) for a,b in exps)}
        rows=[];rowtags=[]
        for i in range(M.nrows()):
            for a,b in shifts:
                row={}
                for j in range(M.ncols()):
                    for (aa,bb),c in M[i,j].dict().items():row[columns[(j,int(a+aa),int(b+bb))]]=c
                rows.append(row);rowtags.append((i,a,b))
        G=matrix(E,len(rows),len(columns),{(i,j):c for i,row in enumerate(rows) for j,c in row.items()},sparse=False);t=vector(E,len(columns))
        for j in range(M.ncols()):
            for (a,b),c in target[j].dict().items():t[columns[(j,int(a),int(b))]]=c
        try:w=G.transpose().solve_right(t)
        except ValueError:
            steps.append({'degree':degree,'rows':G.nrows(),'columns':G.ncols(),'target_membership':False,'seconds_so_far':time.time()-start});print({'case':case,**steps[-1]},flush=True);continue
        comb=[R.zero() for i in range(M.nrows())]
        for c,(i,a,b) in zip(w,rowtags):comb[i]+=R(c)*u**a*v**b
        assert vector(R,comb)*M==target
        save({'case':case,'matrix':M,'target':target,'combination':comb,'degree':degree},str(data/('m6_rational_root_source_membership_case_%s.sobj'%case)))
        steps.append({'degree':degree,'rows':G.nrows(),'columns':G.ncols(),'target_membership':True,'nonzero_combination_terms':sum(h!=0 for h in comb),'seconds_so_far':time.time()-start});print({'case':case,**steps[-1]},flush=True);done=True;break
    reports.append({'case':case,'exact_kappa_target_membership':done,'steps':steps})
report={'scope':'exact polynomial row identities iftarget membership; unsuccessful degreebound is not nonmembership','cases':reports,'seconds':time.time()-start}
(data/'m6_rational_root_source_membership_summary.json').write_text(json.dumps(report,default=int)+'\n')
