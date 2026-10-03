#!/usr/bin/env python3
"""Global polynomial six-generator numerator family on concentrated d0."""
import argparse,json,sys
from pathlib import Path
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly
from cubic_extension import CubicExtension
from shifted_concentrated_projection import extended_gcd


def left_inverse(p,rows):
    a=[[f[:] for f in row] for row in rows];m=len(a);n=len(a[0])
    b=[[[1] if i==j else [] for j in range(m)] for i in range(m)]
    for r in range(n):
        candidates=[i for i in range(r,m) if a[i][r]];assert candidates
        i=min(candidates,key=lambda i:len(a[i][r]))
        a[r],a[i]=a[i],a[r];b[r],b[i]=b[i],b[r]
        for i in sorted(range(r+1,m),key=lambda i:len(a[i][r])):
            if not a[i][r]:continue
            f,h=a[r][r],a[i][r];g,x,y=extended_gcd(p,f,h)
            aa,bb=p.exactdiv(f,g),p.exactdiv(h,g)
            for matrix in (a,b):
                left,right=matrix[r],matrix[i]
                matrix[r]=[p.add(p.mul(x,l),p.mul(y,t)) for l,t in zip(left,right)]
                matrix[i]=[p.sub(p.mul(aa,t),p.mul(bb,l)) for l,t in zip(left,right)]
        assert a[r][r]==[1]
        for i in range(r):
            coefficient=a[i][r]
            for matrix in (a,b):matrix[i]=[p.sub(f,p.mul(coefficient,g)) for f,g in zip(matrix[i],matrix[r])]
    assert a==[[[1] if i==j else [] for j in range(n)] for i in range(m)]
    for i in range(m):
        for j in range(n):
            total=[]
            for c,row in zip(b[i],rows):total=p.add(total,p.mul(c,row[j]))
            assert total==a[i][j]
    return b[:n]


def matmul(p,a,b):
    out=[]
    for row in a:
        result=[]
        for j in range(len(b[0])):
            total=[]
            for c,br in zip(row,b):total=p.add(total,p.mul(c,br[j]))
            result.append(total)
        out.append(result)
    return out


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True)
    ap.add_argument('--root',type=int,default=145049);ap.add_argument('--sheet',default='')
    args=ap.parse_args();base=Field(args.work/'cache');bp=Poly(base);e=CubicExtension(base);p=Poly(e)
    data=args.work/'data';top=json.loads((data/'concentrated_top_compatibility.json').read_text())
    family=json.loads((data/'concentrated_d0_source_family.json').read_text())
    adapted=json.loads((data/'adapted_family.json').read_text())
    lower=json.loads((data/'lower_numerator_product_space.json').read_text())['numerator_coefficients']
    record=next(r for r in top['records'] if r['root_K_code']==args.root and r['sheet_suffix']==args.sheet)
    source=next(r for r in family['records'] if r['root_K_code']==args.root)
    shifted=json.loads((data/('shifted_concentrated_projection'+args.sheet+'.json')).read_text())
    shift=next(r for r in shifted['records'] if r['root_K_code']==args.root)
    ker=json.loads((data/f'concentrated_d0_polynomial_kernel_{args.root}{args.sheet}.json').read_text())['kernel_columns']
    y0=record['y0_extension_code'];factor=e.div(bp.eval(bp.derivative(adapted['t']),args.root),y0)
    def substitute(matrix):return [[[e.mul(c,e.power(factor,j)) for j,c in enumerate(f)] for f in row] for row in matrix]
    M=substitute(shift['polynomial_matrix']);L=left_inverse(p,M)
    E=substitute(record['extra_top_matrix'])
    labels={tuple(label):i for i,label in enumerate(top['top_labels'])}
    nums=source['source_numerators'];v=p.scale(nums[13],y0)
    p0=[]
    for i,s in zip((1,2,3,4),(12,1,24,3)):p0=p.add(p0,p.scale(nums[i],s))
    s4=[(0,0,p0)]+[(i,0,nums[i]) for i in range(1,5)]+[(0,1,p.scale(nums[5],e.inv(y0)))]
    embed=[[[] for _ in range(8)] for _ in range(21)]
    for kk in range(3):
        embed[labels[(5,kk,0)]][kk]=v
        for degree,char,coefficient in s4:embed[labels[(4,degree+kk,char)]][kk]=coefficient
    from exact import monomials
    for j,(degree,char) in enumerate(monomials(10)):embed[labels[(4,degree,char)]][3+j]=v
    weights=matmul(p,embed,ker);rhs=matmul(p,E,weights)
    low=[[p.neg(f) for f in row] for row in matmul(p,L,rhs)]
    residual=matmul(p,M,low)
    assert all(not p.add(f,g) for a,b in zip(residual,rhs) for f,g in zip(a,b))
    U=[]
    for j in range(6):
        functions=[[[] for _ in range(3)] for _ in range(6)]
        for basis,coefficients in ((top['particular_finite_numerator_coefficients'],weights),(lower,low)):
            for f,row in zip(basis,coefficients):
                scalar=row[j]
                if not scalar:continue
                for degree,components in enumerate(f):
                    for char,component in enumerate(components):
                        result=functions[degree][char]
                        while len(result)<len(component):result.append([])
                        for ix,c in enumerate(component):result[ix]=p.add(result[ix],p.scale(scalar,c))
        U.append(functions)
    report={'scope':'global polynomial basis of the necessary six-dimensional concentrated d0 numerator; Uhat=H*U',
            'root':args.root,'sheet':args.sheet,'basis_coefficient_order':'[basis][Tdegree][ycharacter][xdegree][etadegree]',
            'polynomial_top_kernel':ker,'top_function_weights':weights,'lower_weights':low,
            'lower_matrix':M,'polynomial_left_inverse':L,'numerator_basis':U}
    (data/f'concentrated_d0_polynomial_numerator_{args.root}{args.sheet}.json').write_text(json.dumps(report,separators=(',',':'))+'\n')
    print(json.dumps({'root':args.root,'sheet':args.sheet,
                     'basis_eta_degrees':[max(len(poly)-1 for f in functions for char in f for poly in char) for functions in U],
                     'left_inverse_max_degree':max(len(f)-1 for row in L for f in row)}))


if __name__=='__main__':main()
