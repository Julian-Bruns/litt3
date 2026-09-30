#!/usr/bin/env python3
"""Global support/leading-coefficient certificate; not a square-locus decision.

Every parameter is symbolic. The finite combinatorial enumeration here enumerates
monomials in a fixed product, not geometric points or finite-field parameter values.
"""
from pathlib import Path
import sys, json, itertools
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'src'))
from check_global_changes import mul,power,add

def main():
    data={}
    count=0
    for line in (ROOT/'inputs/E_records.tsv').read_text().splitlines()[1:]:
        j,h,q,m,x,c=map(int,line.split())
        key=(j,m,x)
        data.setdefault(key,{})[h,q]=c
        count+=1
    assert count==89481
    degrees=[[max(x for j0,m0,x in data if (j0,m0)==(j,m)) for m in range(3)] for j in range(3)]
    assert degrees==[[46,45,43],[43,42,39],[40,38,35]]
    assert data[0,2,43]=={(0,16):75810}
    a0=[89654,311173,214299,163299,315361,33043,356725,245794]
    a1=[0,299833,232505]
    pred={(0,i+15):mul(29995,c) for i,c in enumerate(a0)}
    pred.update({(1,i+15):mul(29995,c) for i,c in enumerate(a1) if c})
    assert pred==data[1,1,42]
    # Full norm support bound, before any cancellations.  The mixed term's
    # three components are distinguishable; the cube terms use multinomials.
    candidates=[]
    for j in range(3):
        for ms in itertools.combinations_with_replacement(range(3),3):
            candidates.append((sum(ms),10*j+sum(degrees[j][m] for m in ms),('cube',j,ms)))
    for ms in itertools.product(range(3),repeat=3):
        candidates.append((sum(ms),10+sum(degrees[j][ms[j]] for j in range(3)),('mixed',ms)))
    frontier=[max(x for m0,x,_ in candidates if m0==m) for m in range(7)]
    assert frontier==[140,138,137,136,133,131,129]
    leaders={str(m):[desc for m0,x,desc in candidates if m0==m and x==frontier[m]] for m in (3,5,6)}
    assert leaders['3']==[('cube',1,(1,1,1))]
    assert leaders['5']==[('cube',0,(1,2,2))]
    assert leaders['6']==[('cube',0,(2,2,2))]
    deficit=[140-d for d in frontier]
    triples=list(itertools.combinations_with_replacement(range(7),3))
    pairs=list(itertools.combinations_with_replacement(range(7),2))
    optimal={}
    for bound in (71,72,73,74):
        best=-1;winners=[]
        for a in triples:
            da=sum(deficit[i] for i in a); ma=sum(a)
            for b in pairs:
                db=da+5*sum(deficit[i] for i in b);mb=ma+5*sum(b)
                if db>bound:continue
                for c in pairs:
                    dc=db+25*sum(deficit[i] for i in c);mc=mb+25*sum(c)
                    if dc>bound:continue
                    if mc>best:best=mc;winners=[]
                    if mc==best:winners.append([list(a),list(b),list(c),dc])
        optimal[str(bound)]={'maximum_mu_degree':best,'winning_scale_allocations':winners}
    assert optimal['71']=={'maximum_mu_degree':47,'winning_scale_allocations':[[[5,6,6],[3,3],[0,0],71]]}
    assert optimal['73']=={'maximum_mu_degree':48,'winning_scale_allocations':[[[6,6,6],[3,3],[0,0],73]]}
    c3=power(29995,3); c6=power(75810,3)
    lc=mul(power(c6,3),power(c3,10))
    assert (c3,c6,lc)==(353570,242747,295985)
    out={
        'status':'PASS','scope':'global symbolic support and leading-coefficient certificate',
        'decision':'UNRESOLVED','E_records_checked':count,
        'E_x_degrees_rows_component_columns_mu':degrees,
        'W_x_degree_upper_bounds_by_mu':frontier,
        'unique_frontier_contributions':leaders,
        'coefficient_identities':{
            '[x^43 mu^2]E0':'<75810> q^16',
            '[x^42 mu]E1':'<29995> q^15 Psi',
            '[x^136 mu^3]W':'<353570> q^46 Psi^3',
            '[x^129 mu^6]W':'<242747> q^50',
            '[mu^48][T^73]Ahat^63':'<295985> L^50 q^610 Psi^30'
        },
        'support_enumeration':optimal,
        'conclusion':'The 73rd coefficient equation has degree exactly 48 in mu and unit leading coefficient on the whole allowed ratio chart. Every fixed-ratio square fiber, including nilpotents and after removing mu=0, has length at most 48.'
    }
    path=Path(sys.argv[1]) if len(sys.argv)>1 else ROOT/'build/scale_bound.json'
    path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(json.dumps(out,indent=2)+'\n')
    print('GLOBAL_SCALE_BOUND PASS: monic degree 48, every allowed H,q; no new pivot localization.')
    print('SOURCE OF PROOF: all E support records, two exact coefficient-array identities, finite monomial enumeration.')
    print('GLOBAL SQUARE LOCUS: UNRESOLVED.')
if __name__=='__main__':main()
