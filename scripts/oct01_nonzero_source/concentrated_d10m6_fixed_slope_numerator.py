#!/usr/bin/env python3
"""Entire freev source line at eta1: exact polynomial numerator module."""
import argparse,json,sys
from pathlib import Path
from itertools import combinations
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly,Curve,monomials,Q_CODES
from cubic_extension import CubicExtension
from infinity import InfinitySystem
from concentrated_d0_polynomial_kernel import unimodular_kernel,column_reduce
from concentrated_d0_polynomial_numerator import matmul
def main():
    ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);args=ap.parse_args();data=args.work/'data';base=Field(args.work/'cache');bp=Poly(base);e=CubicExtension(base);p=Poly(e);C=Curve(e)
    left=next(r for r in json.loads((data/'critical_quadratic_endpoint_probe.json').read_text())['records'] if r['name'].startswith('concentrated_d10_m6'))
    right=next(r for r in json.loads((data/'critical_quadratic_endpoint_probe_lambda2.json').read_text())['records'] if r['name']==left['name'])
    assert left['lambda']==1 and right['lambda']==2 and left['D_finite']==right['D_finite']
    family=json.loads((data/'adapted_family.json').read_text());system=InfinitySystem(base,family)
    def frame(source):
        v=C.zero()
        for scalar,(b,char) in zip(source[13:],monomials(10)):v=C.add(v,C.monomial(b,char,scalar))
        N=[C.zero() for _ in range(6)]
        for scalar,column in zip(source[:13],system.N):
            for j in range(6):N[j]=C.add(N[j],C.scale(column[j],scalar))
        N[0]=v;N[5]=C.add(N[5],C.mul(v,C.polyx(Q_CODES)));S,q=C.frame(N)
        F=[C.add(C.add(C.mul(v,C.power(q,2)),C.mul(q,S[0])),C.power(C.polyx(family['t']),3))]
        F.extend(C.mul(q,S[j]) for j in range(1,5));F.append(C.add(S[0],C.scale(C.mul(v,q),2)));F.extend(S[1:]);F.append(v)
        return v,S,F
    vl,Sl,Fl=frame(left['source_original']);vr,Sr,Fr=frame(right['source_original']);assert Sl==Sr
    def line(a,b):
        out=[]
        for i in range(max(len(a),len(b))):
            aa=a[i] if i<len(a) else 0;bb=b[i] if i<len(b) else 0;delta=e.sub(bb,aa);out.append(p.trim([e.sub(aa,delta),delta]))
        return out
    v=[line(a,b) for a,b in zip(vl,vr)];F=[[line(a,b) for a,b in zip(f,g)] for f,g in zip(Fl,Fr)]
    top=json.loads((data/'concentrated_top_compatibility.json').read_text());record=next(r for r in top['records'] if r['root_K_code']==145049 and r['sheet_suffix']=='');lookup={tuple(label):i for i,label in enumerate(top['top_labels'])}
    factor=e.div(bp.eval(bp.derivative(family['t']),145049),record['y0_extension_code']);old=[[c] if c else [] for c in top['ordinary_compatibility_coefficients']];new=[[p.eval(f,factor)] if p.eval(f,factor) else [] for f in record['new_compatibility_coefficients']]
    embed=[[[] for _ in range(8)] for _ in range(21)]
    for j in range(8):
        if j<3:
            a5=[ [ [] for _ in range(j)]+component for component in v]
            a4=[ [0]*j+component for component in Sl[4]]
        else:
            degree,char=monomials(10)[j-3];a5=[[],[],[]];a4=[[] for _ in range(3)]
            for ch,component in enumerate(v):
                if component:a4[ch+char]=[[] for _ in range(degree)]+component
        for degree,functions in ((5,a5),(4,a4)):
            for char,component in enumerate(functions):
                for xx,coefficient in enumerate(component):
                    if j<3 and degree==4:coefficient=[coefficient] if coefficient else []
                    if coefficient:embed[lookup[(degree,xx,char)]][j]=coefficient
    rows=matmul(p,[old,new],embed);minors=[p.sub(p.mul(rows[0][i],rows[1][j]),p.mul(rows[0][j],rows[1][i])) for i,j in combinations(range(8),2)];g=[]
    for f in minors:g=p.gcd(g,f)
    assert g==[1]
    transform,ker=unimodular_kernel(p,rows);ker,steps=column_reduce(p,ker)
    weights=matmul(p,embed,ker)
    lower_num=json.loads((data/'concentrated_d0_polynomial_numerator_145049.json').read_text());L=[[[p.eval(f,1)] if p.eval(f,1) else [] for f in row] for row in lower_num['polynomial_left_inverse']]
    M=[[[p.eval(f,1)] if p.eval(f,1) else [] for f in row] for row in lower_num['lower_matrix']]
    extra=[[[p.eval(f,factor)] if p.eval(f,factor) else [] for f in row] for row in record['extra_top_matrix']]
    rhs=matmul(p,extra,weights);low=[[p.neg(f) for f in row] for row in matmul(p,L,rhs)];residual=matmul(p,M,low)
    assert all(not p.add(a,b) for rr,ss in zip(residual,rhs) for a,b in zip(rr,ss))
    lower=json.loads((data/'lower_numerator_product_space.json').read_text())['numerator_coefficients'];U=[]
    for column in range(6):
        functions=[[[] for _ in range(3)] for _ in range(6)]
        for basis,coefficients in ((top['particular_finite_numerator_coefficients'],weights),(lower,low)):
            for ff,row in zip(basis,coefficients):
                scalar=row[column]
                if not scalar:continue
                for degree,components in enumerate(ff):
                    for char,component in enumerate(components):
                        result=functions[degree][char]
                        while len(result)<len(component):result.append([])
                        for xx,c in enumerate(component):result[xx]=p.add(result[xx],p.scale(scalar,c))
        U.append(functions)
    forcing=[ [line([a],[b])[0] for a,b in zip(aa,bb)] for aa,bb in zip(left['forcing_m4_square_monomials'],right['forcing_m4_square_monomials'])]
    out={'scope':'entire affine freev source line at root145049 eta1; no other slope claim','root':145049,'eta':1,'source_left':left['source_original'],'source_right':right['source_original'],'v':v,'F':F,'D':left['D_finite'],'top_compatibility_rows':rows,'top_minors':minors,'top_kernel':ker,'top_degree_reduction':steps,'U':U,'m4':[[ker[i][j] for i in range(3)] for j in range(6)],'auxiliary_endpoint_matrix':left['matrix'],'auxiliary_forcing':forcing}
    (data/'concentrated_d10m6_fixed_slope_numerator.json').write_text(json.dumps(out,separators=(',',':'))+'\n');print('TOPKERNEL_DEGREES',[max(len(row[j])-1 for row in ker) for j in range(6)]);print('U_DEGREES',[max(len(f)-1 for deg in uu for char in deg for f in char) for uu in U])
if __name__=='__main__':main()
