#!/usr/bin/env python3
"""Necessary integer profiles after the small-pencil bounds; no curve search."""
import argparse,json,sys
from pathlib import Path

sys.path.insert(0,str(Path(__file__).resolve().parent/'pro_finite_square_secant_20260926/klein/src'))
import new_profile_checks as P


def character_allocations(g,j,e):
    """Necessary integer allocations; all M-rationality tests are joint."""
    total=27+2*j-g
    out=[]
    for d0 in range(total+1):
        for d1 in range(d0,total+1):
            d2=total-d0-d1
            if d2<d1:continue
            ds=(d0,d1,d2)
            bounds=[min(j,14+2*d,13 if d==0 else 15 if d==1 and e<=28 else j) for d in ds]
            for c0 in range(bounds[0]+1):
                for c1 in range(bounds[1]+1):
                    c2=2*j-c0-c1
                    if not 0<=c2<=bounds[2]:continue
                    cs=(c0,c1,c2);hs=tuple(10+c-d for c,d in zip(cs,ds))
                    if any(h<1 or j-c>g+3-2*h for c,h in zip(cs,hs)):continue
                    rational=[(e<=27 and c>=14+2*d) or (e<=26 and c>=13+2*d) or
                              (e<=25 and c>=12+2*d) or (d==0 and c>=e-15)
                              for c,d in zip(cs,ds)]
                    if sum(rational)>1:continue
                    out.append(dict(d=ds,c=cs,h=hs))
    return out


def one(n,uniform=False,unused=False,mixed=False,two_ends=False,three_unused=False,four_unused=False,characters=False,retain_profiles=False):
    profiles=[]
    for j2 in range(30):
        for j1 in range(30-j2):
            j=j1+j2;a=n-12-3*j1-6*j2
            if a<0:continue
            for s in range((a+3)//4,min(a,29-j)+1):
                e=s+j;b=min(10,3+(e+1)//2)
                upper=min(n,48+j if uniform else 49+j-int(j<=24),3*b+2*j-3-2*int(e%2==1 and e<=13))
                if unused and e<=27:upper=min(upper,47+j)
                if mixed and e<=28 and j<=26:upper=min(upper,47+j)
                if two_ends and j<=23:upper=min(upper,47+j)
                if three_unused and e<=26:upper=min(upper,46+j)
                if four_unused and e<=25:upper=min(upper,45+j)
                for g in range(max(0,j-3),upper+1):
                    if 2*g+j1>3*e+12+4*j:continue
                    m=j1+2*j2;N=7*n-3*g+15+3*m
                    cost=(n-12)*(n-13)//2+P.grid_min(n,N)+4*P.balanced(a,s)+j1+8*j2
                    if g+cost>(n-1)**2:continue
                    record=dict(g=g,s=s,a=a,j1=j1,j2=j2,e=e)
                    if characters:
                        allocations=character_allocations(g,j,e)
                        if not allocations:continue
                        record['character_allocations']=allocations
                    profiles.append(record)
    P.grid_min.cache_clear()
    return dict(n=n,count=len(profiles),genus_min=min((r['g'] for r in profiles),default=None),
                genus_max=max((r['g'] for r in profiles),default=None),profiles=profiles if n>=86 or retain_profiles else None)


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--n-min',type=int,default=86);ap.add_argument('--n-max',type=int,default=91)
    ap.add_argument('--uniform',action='store_true')
    ap.add_argument('--unused-poles',action='store_true')
    ap.add_argument('--mixed-poles',action='store_true')
    ap.add_argument('--two-endpoints',action='store_true')
    ap.add_argument('--three-unused',action='store_true')
    ap.add_argument('--four-unused',action='store_true')
    ap.add_argument('--characters',action='store_true')
    ap.add_argument('--retain-profiles',action='store_true')
    ap.add_argument('--output',type=Path,required=True);a=ap.parse_args()
    both=a.two_endpoints or a.three_unused or a.four_unused or a.characters
    rows=[one(n,a.uniform or a.unused_poles or a.mixed_poles or both,a.unused_poles or both,a.mixed_poles or both,both,a.three_unused or a.four_unused or a.characters,a.four_unused or a.characters,a.characters,a.retain_profiles) for n in range(a.n_min,a.n_max+1)]
    out={'scope':'Exhaustive necessary integer profiles only; omits polynomial and actual two-map existence conditions.',
         'new_genus_bound':('All registered scalar and joint character bounds, including g<=45+j for e<=25 and marked constant rationality' if a.characters else 'Previous bounds and g<=45+j for e<=25' if a.four_unused else 'Previous bounds and g<=46+j for e<=26' if a.three_unused else 'g<=47+j for j<=23 or (e<=28 and j<=26)' if a.two_endpoints else 'g<=min(n,48+j-indicator(e<=28 and j<=26))' if a.mixed_poles else 'g<=min(n,48+j-indicator(e<=27))' if a.unused_poles else 'g<=min(n,48+j)' if a.uniform else 'g<=min(n,49+j-indicator(j<=24))'),'rows':rows}
    if a.characters:out['character_scope']='All registered character bounds and the marked constant threshold c>=e-15, with shared M-jet counting. Necessary allocations only.'
    a.output.write_text(json.dumps(out,indent=2)+'\n')
    for r in rows:print({k:v for k,v in r.items() if k!='profiles'})
    assert all(r['count']==0 for r in rows if r['n']>=89)
    if both:assert all(r['count']==0 for r in rows if r['n']>=88)


if __name__=='__main__':main()
