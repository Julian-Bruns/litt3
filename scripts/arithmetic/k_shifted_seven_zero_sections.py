#!/usr/bin/env python3
"""Reconstruct H0(F^*K(8O)); a seven-zero section is not decided here."""
import argparse,json
from pathlib import Path
import pro_quadratic_twist_vanishing as q
from k_fifth_twist_probe import reconstruct,serialize

def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--output',type=Path,required=True)
    ap.add_argument('--wedges-output',type=Path)
    ap.add_argument('--twist',type=int,default=8)
    a=ap.parse_args()
    columns,rows,full=q.system(5,twist=a.twist)
    selected=[j for j,c in enumerate(columns) if c[0]==5]
    mat=[[row[j] for j in selected] for row in full]
    pairs=[(r,row) for r,row in zip(rows,mat) if any(row)];rows=[r for r,row in pairs];mat=[row for r,row in pairs]
    rr,piv=q.rref(mat);free=[j for j in range(len(selected)) if j not in piv]
    rank5=q.prime_field_rank(mat);assert rank5==2*len(piv)
    sections=[]
    for j in free:
        short=[0]*len(selected);short[j]=1
        for i,p in enumerate(piv):short[p]=q.NEG[rr[i][j]]
        v=[0]*len(columns)
        for m,c in zip(selected,short):v[m]=c
        aff,other=reconstruct(columns,v,5,twist=a.twist)
        assert all(not aff[i] and not other[i] for i in range(1,5))
        characters={(r+2)%3 for r,m in aff[0]}|{r%3 for r,m in aff[5]}
        assert len(characters)==1
        sections.append({'free_column':columns[selected[j]],'coordinates':short,
                         'affine':serialize(aff),'other_chart':serialize(other),
                         'C3_character':next(iter(characters))})
    result={'status':'PASS','scope':'Exact global section space only; maximal zero divisor not computed.',
            'bundle':f'F_abs^*K({a.twist}O)','columns':[columns[j] for j in selected],
            'rows':rows,'matrix':mat,'rank':len(piv),'independent_F5_rank':rank5,'sections':sections}
    a.output.write_text(json.dumps(result,separators=(',',':'))+'\n')
    print('PASS',len(rows),'x',len(selected),'rank',len(piv),'kernel',len(free),'F5 rank',rank5)
    print('Free columns',[s['free_column'] for s in sections])
    print('C3 characters',[s['C3_character'] for s in sections])
    if a.wedges_output:
        assert a.twist==8
        assert len(sections)==7
        affs=[[{(r,m):c for r,m,c in p} for p in s['affine']] for s in sections]
        assert all(set(r for r,m in a[0])=={1} and set(r for r,m in a[5])=={0} for a in affs[:5])
        assert all(set(r for r,m in a[0])=={0} and set(r for r,m in a[5])=={2} for a in affs[5:])
        wedges=[]
        for i,u in enumerate(affs[:5]):
            for j,v in enumerate(affs[5:]):
                h=q.add(q.multiply(v[0],u[5]),q.multiply(u[0],v[5]),4)
                assert h and all(r==0 and 0<=m<=7 for r,m in h)
                wedges.append({'u':i,'v':j,'polynomial':[h.get((0,m),0) for m in range(8)]})
        a.wedges_output.write_text(json.dumps({'status':'PASS',
            'scope':'Ten actual wedge polynomials; no seven-zero exclusion.',
            'determinants':wedges},indent=2)+'\n')
        print('PASS ten wedge polynomials have degree at most seven')

if __name__=='__main__':main()
