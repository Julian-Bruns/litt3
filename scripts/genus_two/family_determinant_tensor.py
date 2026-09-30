#!/usr/bin/env sage-python
"""Reconstruct the actual triquadratic from ten two-torsion node values.

The node values' scalars are fixed by symmetry against the zero node.
This replaces a 236-unknown homogeneous calibration by ten-point
quadratic interpolation. All arithmetic is exact over F5(a).
"""
from sage.all import GF, FunctionField, PolynomialRing, matrix, vector, lcm
import argparse
import itertools
import json
from pathlib import Path
import time


def compute(theta_file, quadric_file, original_file):
    started=time.monotonic()
    data=json.loads(theta_file.read_text())
    translations=json.loads(quadric_file.read_text())
    old=json.loads(original_file.read_text())
    F=FunctionField(GF(5),'a'); a=F.gen()
    parse=lambda s:F(s.replace('^','**'))
    def degree(c):
        c=F(c)
        return max(0,int(c.numerator().degree()),int(c.denominator().degree()))
    P=PolynomialRing(GF(5),'aa'); aa=P.gen()
    k=GF(125,'alpha',modulus=aa**3+aa+1); alpha=k.gen()
    def spec(c):
        c=F(c);return c.numerator()(alpha)/c.denominator()(alpha)
    decode=lambda c:k([(int(c)//5**i)%5 for i in range(3)])
    encode=lambda c:sum(int(c.polynomial()[i])*5**i for i in range(3))
    mon2=list(itertools.combinations_with_replacement(range(4),2))
    mon_index={e:i for i,e in enumerate(mon2)}
    M=[matrix.identity(F,4)]+[matrix(F,4,4,[parse(c) for c in r['translation']]) for r in translations['covers']]
    L=[m.transpose() for m in M]
    nodes=[ell.column(0) for ell in L]
    H=matrix(F,[[0,0,0,1],[0,0,-1,0],[0,1,0,0],[-1,0,0,0]])
    # The linear pullback map j^*: hyperplanes -> |2Theta| is actual.
    # These node incidences identify its coordinate matrix uniquely.
    roots=[F(0),F(1),F(2),F(3),a**5]
    c=[F(0),a**5,-a**5-1,a**5+1,-a**5-1,F(1)]
    kappas=[vector(F,[0,0,0,1])]
    for i,j in itertools.combinations(range(6),2):
        if j==5:
            b=roots[i];kappas.append(vector(F,[0,1,b,b*b]))
        else:
            b,d=roots[i],roots[j];polar=c[1]*(b+d)+2*c[2]*b*d+c[3]*b*d*(b+d)+2*c[4]*b*b*d*d+b*b*d*d*(b+d)
            kappas.append(vector(F,[1,b+d,b*d,polar/(b-d)**2]))
    incidence=[]
    for source,target in zip(nodes,kappas):
        image=H*source
        for i,j in itertools.combinations(range(4),2):
            assert image[i]*target[j]==image[j]*target[i]
            incidence.append([source[col]*(target[j] if row==i else -target[i] if row==j else 0)
                              for row in range(4) for col in range(4)])
    hi=matrix(F,incidence); assert hi.rank()==15
    hi_rows=[]
    for row in hi.rows():
        den=lcm([x.denominator() for x in row]);hi_rows.append([F(den)*x for x in row])
    hi_clear=matrix(F,hi_rows)
    hi_pivots=list(hi_clear.transpose().pivots())
    hbound=sum(max(degree(v) for v in hi_clear.row(i)) for i in hi_pivots)
    print('actual alternating coordinate pairing identified; minor bound',hbound,flush=True)

    def square_bilinear(B):
        ans=matrix(F,10,10)
        for i,j,h,l in itertools.product(range(4),repeat=4):
            ans[mon_index[tuple(sorted((i,h)))],mon_index[tuple(sorted((j,l)))]]+=B[i,j]*B[h,l]
        assert ans==ans.transpose()
        return ans

    values=[]; scalars=[]
    for ell,node in zip(L,nodes):
        left=node*H; right=nodes[0]*H*ell
        pivot=next(i for i in range(4) if right[i])
        ratio=left[pivot]/right[pivot]
        assert left==ratio*right
        lam=ratio**2;scalars.append(lam)
        values.append(lam*square_bilinear(H*ell))
    evals=matrix(F,[[node[i]*node[j] for i,j in mon2] for node in nodes])
    selected=list(evals.transpose().pivots()); assert len(selected)==10
    V=evals.matrix_from_rows(selected)
    rhs=matrix(F,[values[i].list() for i in selected])
    solution=V.solve_right(rhs)
    tensor=[[[solution[h,10*i+j] for h in range(10)] for j in range(10)] for i in range(10)]
    for i,j,h in itertools.product(range(10),repeat=3):
        assert tensor[i][j][h]==tensor[i][h][j]==tensor[h][j][i]
    for node,val in zip(nodes,values):
        vm=vector(F,[node[i]*node[j] for i,j in mon2])
        for i,j in itertools.product(range(10),repeat=2):
            assert sum(tensor[i][j][h]*vm[h] for h in range(10))==val[i,j]
    oldt={(i,j,h):decode(c) for i,j,h,c in old['tensor_nonzero_unordered']}
    for i,j,h in itertools.combinations_with_replacement(range(10),3):
        assert spec(tensor[i][j][h])==oldt.get((i,j,h),k(0))
    coeffs=[tensor[i][j][h] for i,j,h in itertools.combinations_with_replacement(range(10),3)]
    tensor_den=lcm([x.denominator() for x in coeffs]); tensor_deg=max(degree(F(tensor_den)*x) for x in coeffs)
    print('ten-node actual tensor verified; cleared coefficient degree',tensor_deg,flush=True)
    vrows=[]
    for row in V.rows():
        den=lcm([x.denominator() for x in row]);vrows.append([F(den)*x for x in row])
    vbound=sum(max(degree(v) for v in row) for row in vrows)

    RT=PolynomialRing(F,'tt');tt=RT.gen();psi=RT([parse(c) for c in data['extension_polynomial']])
    K=F.extension(psi,'T');T=K.gen()
    points=[sum(K(parse(c))*T**i for i,c in enumerate(row)) for row in data['theta_coordinates']]
    az=[points[i]*points[j] for i,j in mon2]
    first=[[[sum(F(az[i].element()[r])*tensor[i][j][h] for i in range(10))
             for h in range(10)] for j in range(10)] for r in range(5)]
    first_coeff=[v for mat in first for row in mat for v in row]
    first_den=lcm([v.denominator() for v in first_coeff])
    first_degree=max(degree(F(first_den)*v) for v in first_coeff)
    assert spec(first_den)
    boundary_resultant_bound=640*(5*first_degree+10)
    semistable_resultant_bound=7680*first_degree+25600
    print('five-test coefficient degree',first_degree,'boundary resultant bound',boundary_resultant_bound,
          'strictly-semistable resultant bound',semistable_resultant_bound,flush=True)
    quadrics=[[sum(K(first[r][j][h])*az[j] for j in range(10)) for h in range(10)] for r in range(5)]
    exponents=lambda n:[tuple(word.count(i) for i in range(4)) for word in itertools.combinations_with_replacement(range(4),n)]
    m2=exponents(2);m3=exponents(3)
    MK=matrix(K,20,20)
    for r in range(5):
        for x in range(4):
            for h,ex in enumerate(m2):
                ee=list(ex);ee[x]+=1
                MK[m3.index(tuple(ee)),4*r+x]=quadrics[r][h]
    restriction=matrix(F,100,100)
    for row,col in itertools.product(range(20),repeat=2):
        for j in range(5):
            product=MK[row,col]*T**j
            for i in range(5):restriction[5*row+i,5*col+j]=F(product.element()[i])
    specialized=matrix(k,100,100,[spec(x) for x in restriction.list()])
    # Scalar elimination avoids the native dense finite-extension determinant
    # discrepancy observed in Sage10.9 for this custom-modulus field. Its
    # result agrees with the original independent field-code implementation.
    rows=[list(row) for row in specialized.rows()]; determinant=k.one()
    for i in range(100):
        j=next(j for j in range(i,100) if rows[j][i])
        if j!=i:
            rows[i],rows[j]=rows[j],rows[i]; determinant=-determinant
        pivot=rows[i][i]; determinant*=pivot
        rows[i]=[v/pivot for v in rows[i]]
        for j in range(i+1,100):
            coeff=rows[j][i]
            if coeff:rows[j]=[x-coeff*y for x,y in zip(rows[j],rows[i])]
    assert determinant==decode(78)
    denominator=lcm([v.denominator() for v in restriction.list()])
    entry_degree=max(degree(F(denominator)*v) for v in restriction.list())
    unstable_bound=100*entry_degree
    assert spec(denominator)
    tensor_source_den_degree=max(degree(parse(c)) for key in ['p0','p1','q0','q1','theta_coordinates'] for row in data[key] for c in row)
    bound=max(5280,hbound,vbound,unstable_bound,degree(denominator),degree(tensor_den),tensor_source_den_degree)
    print('actual first-unstable cubic matrix: norm determinant at alpha',encode(determinant),
          'entry degree',entry_degree,'uniform degree bound',bound,flush=True)
    return {'base':'F5(a)','tensor_entries':[[i,j,h,str(tensor[i][j][h])] for i,j,h in itertools.combinations_with_replacement(range(10),3) if tensor[i][j][h]],
        'tensor_clearing_denominator':str(tensor_den),'cleared_tensor_degree':tensor_deg,
        'coordinate_pairing':[str(x) for x in H.list()],'pairing_rank_minor_degree_bound':hbound,
        'interpolation_nodes':selected,'interpolation_rank_degree_bound':vbound,
        'node_calibration_scalars':[str(x) for x in scalars],
        'five_test_coefficients':[[[str(v) for v in row] for row in mat] for mat in first],
        'five_test_clearing_denominator':str(first_den),'five_test_cleared_coefficient_degree':first_degree,
        'affine_boundary_resultant_degree_bound':boundary_resultant_bound,
        'strictly_semistable_resultant_degree_bound':semistable_resultant_bound,
        'first_unstable_quadrics':[[[str(F(q.element()[i])) for i in range(5)] for q in row] for row in quadrics],
        'first_unstable_matrix_clearing_denominator':str(denominator),
        'first_unstable_matrix_cleared_entry_degree':entry_degree,
        'first_unstable_matrix_determinant_degree_bound':unstable_bound,
        'calibrated_norm_determinant_code':encode(determinant),
        'parameter_degree_bound':bound,'seconds':time.monotonic()-started,
        'checks':['actual linear pairing identified by16 nodes','ten-node interpolation full rank',
            'full threefold tensor symmetry','all16 node calibrations','every tensor coefficient matches original at alpha',
            '100x100 first-unstable matrix reconstructed and specialized norm determinant78']}


if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--theta',type=Path,required=True)
    ap.add_argument('--quadrics',type=Path,required=True);ap.add_argument('--original',type=Path,required=True)
    ap.add_argument('--output',type=Path,required=True);args=ap.parse_args()
    if args.output.resolve().is_relative_to(Path(__file__).resolve().parents[2]):raise ValueError('external output required')
    result=compute(args.theta,args.quadrics,args.original)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
