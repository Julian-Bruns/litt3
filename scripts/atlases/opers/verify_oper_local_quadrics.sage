"""Reconstruct the invariant oper local quotients from cubic deck weights.

This checks candidate homogeneous local algebras directly in the original
96 quadrics. Completeness follows separately by exhausting global length;
no old formal-coordinate or exceptional-slice certificate is read.
"""
import argparse,hashlib,json,sys,time
from pathlib import Path

parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--input',required=True,type=Path)
parser.add_argument('--out',required=True,type=Path)
args=parser.parse_args()
root=Path(__file__).resolve().parents[3]
started=time.monotonic()
data=json.loads(args.input.read_text())
assert data['schema']==1 and data['field_modulus']==[2,4,1]
source=root/'scripts/atlases/opers/fixed_x_dormant_opers.sage'
oldargv=sys.argv;sys.argv=['fixed_x_dormant_opers.sage','--build-only']
ns=dict(globals());exec(compile(source.read_text(),str(source),'exec'),ns);sys.argv=oldargv
k=ns['k'];a=k.gen();P=ns['P'];equations=ns['coefficients']
assert len(equations)==96 and P.ngens()==24
weights=[0]*8+[1]*5+[2]*11
assert all(len({sum(ei*w for ei,w in zip(e,weights))%3 for e in f.dict()})==1
           for f in equations)
R=PolynomialRing(k,'b');b=R.gen()
decode=lambda h:R([k(c[0])+k(c[1])*a for c in h])
H=decode(data['modulus']);Bs=[decode(h) for h in data['coordinates']]
factors=[decode(h) for h in data['factors']]
assert H.degree()==55 and H.is_monic() and H.is_squarefree()
assert len(Bs)==8 and Bs[7]==b and all(h.degree()<55 for h in Bs)
assert prod(factors)==H and all(h.is_irreducible() for h in factors)
assert sorted(h.degree() for h in factors)==[1,1,2,9,19,23]
S=R.quotient(H,'beta');beta=S.gen()
center=P.hom([S(h) for h in Bs]+[S.zero()]*16,S)
assert all(center(f)==0 for f in equations)

def generic(rows,K,ncols):
    return matrix(K,rows,ncols=ncols,implementation='generic')

def row_basis(M):
    return M.matrix_from_rows(list(M.transpose().pivots()))

def in_span(M,rows):
    return M.stack(generic(rows,M.base_ring(),M.ncols())).rank()==M.rank()

records=[]
F5z=PolynomialRing(GF(5),'z',implementation='FLINT')
for h in factors:
    d=int(h.degree())
    if d==1:
        K=k;ak=a;u=-h[0]/h[1];emb=k.hom([ak],K)
    else:
        h0=F5z([c[0] for c in h.list()]);h1=F5z([c[1] for c in h.list()])
        norm=h0**2+h0*h1+2*h1**2
        assert norm.degree()==2*d and norm.is_irreducible()
        K=GF(5**(2*d),'u',modulus=norm);u=K.gen();ak=-h0(u)/h1(u)
        assert ak**2+4*ak+2==0
        emb=k.hom([ak],K)
    bv=[sum((emb(c)*u**i for i,c in enumerate(f.list())),K.zero()) for f in Bs]
    vals=bv+[K.zero()]*16
    def ev(f):
        return sum((emb(c)*prod(vals[i]**n for i,n in enumerate(e) if n)
                    for e,c in f.dict().items()),K.zero())
    jac=generic([[ev(f.derivative(v)) for v in P.gens()] for f in equations],K,24)
    MB=jac.matrix_from_columns(list(range(8)))
    MC=jac.matrix_from_columns(list(range(8,13)))
    MA=jac.matrix_from_columns(list(range(13,24)))
    assert MB.rank()==8 and MC.rank()==5 and MA.rank()==8 and jac.rank()==21
    piv=list(MA.pivots());free=[i for i in range(11) if i not in piv]
    assert len(free)==3
    rows=list(MA.transpose().pivots())
    block=MA.matrix_from_rows_and_columns(rows,piv)
    rhs=MA.matrix_from_rows_and_columns(rows,free)
    solved=-block.inverse()*rhs
    kernel=generic([[K(int(i==j)) for j in free] for i in range(11)],K,3)
    for i,row in enumerate(piv):
        for j in range(3):kernel[row,j]=solved[i,j]
    assert MA*kernel==0 and kernel.rank()==3
    T=PolynomialRing(K,names=['t0','t1','t2']);tt=T.gens()
    mons=lambda n:[tt[0]**i*tt[1]**j*tt[2]**(n-i-j) for i in range(n+1) for j in range(n-i+1)]
    m2,m3,m4=mons(2),mons(3),mons(4)
    coeffs=lambda f,mm:[f.monomial_coefficient(m) for m in mm]
    homogeneous=lambda f,n:T({e:c for e,c in T(f).dict().items() if sum(e)==n})
    coordinates=[T(v) for v in vals]
    Alin=[sum((kernel[i,j]*tt[j] for j in range(3)),T.zero()) for i in range(11)]
    coordinates[13:]=Alin
    original_terms=[[(tuple(e),emb(c)) for e,c in f.dict().items()] for f in equations]
    def residual(vv):
        result=[]
        for eq in original_terms:
            total=T.zero()
            for e,c in eq:
                term=T(c)
                for i,power in enumerate(e):
                    if power:term*=vv[i]**power
                total+=term
            result.append(total)
        return result
    eA=residual(coordinates)
    assert all(homogeneous(f,0)==homogeneous(f,1)==0 for f in eA)
    cpiv=list(MC.transpose().pivots())
    cinv=MC.matrix_from_rows(cpiv).inverse()
    Cquad=[-sum((cinv[i,j]*homogeneous(eA[row],2) for j,row in enumerate(cpiv)),T.zero()) for i in range(5)]
    coordinates[8:13]=Cquad
    eC=residual(coordinates)
    Qmat=row_basis(generic([coeffs(f,m2) for f in eC],K,6))
    assert Qmat.nrows()==3 and Qmat.rank()==3
    quadrics=[sum((c*m for c,m in zip(row,m2)),T.zero()) for row in Qmat.rows()]
    degree3=generic([coeffs(q*t,m3) for q in quadrics for t in tt],K,10)
    degree4=generic([coeffs(q*m,m4) for q in quadrics for m in m2],K,15)
    assert degree3.rank()==9 and degree4.rank()==15
    # Thus (quadrics) contains m^4 and its quotient has Hilbert function1,3,3,1.
    bpiv=list(MB.transpose().pivots());binv=MB.matrix_from_rows(bpiv).inverse()
    Bcubic=[-sum((binv[i,j]*homogeneous(eC[row],3) for j,row in enumerate(bpiv)),T.zero()) for i in range(8)]
    coordinates[:8]=[T(v)+f for v,f in zip(bv,Bcubic)]
    final=residual(coordinates)
    assert all(homogeneous(f,0)==homogeneous(f,1)==0 for f in final)
    assert in_span(Qmat,[coeffs(f,m2) for f in final])
    assert in_span(degree3,[coeffs(f,m3) for f in final])
    assert [coordinates[13+i] for i in free]==list(tt)
    # Nonzero c4 in degree2 generates a two-dimensional ideal (degrees2 and3).
    assert Qmat.stack(generic([coeffs(Cquad[4],m2)],K,6)).rank()==4
    assert degree3.stack(generic([coeffs(Cquad[4]*t,m3) for t in tt],K,10)).rank()==10
    encode=lambda v:[int(c) for c in K(v).polynomial().list()]
    records.append({'residue_degree':d,'residue_factor':data['factors'][len(records)],
        'field_modulus':[int(c) for c in K.modulus().list()],
        'quadratic_monomials':[list(m.exponents()[0]) for m in m2],
        'quadrics':[[encode(c) for c in row] for row in Qmat.rows()],
        'c4_quadratic':[encode(c) for c in coeffs(Cquad[4],m2)],
        'tangent_block_ranks':[8,5,8],'tangent_free_A_indices':free,
        'homogeneous_relation_ranks':[3,9,15],
        'deck_weight_of_each_local_parameter':2,
        'hilbert_function':[1,3,3,1],'quotient_length':8,'c4_slice_length':6,
        'all96_original_relations_checked':True,'free_coordinates_recovered':True})
    print('PASS invariant degree',d,'three quadratic relations; local quotient8, c4 quotient6',flush=True)
report={'status':'PASS_explicit_homogeneous_local_quotients',
    'input_sha256':hashlib.sha256(args.input.read_bytes()).hexdigest(),
    'original_equation_source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
    'verifier_sha256':hashlib.sha256((root/'scripts/atlases/opers/verify_oper_local_quadrics.sage').read_bytes()).hexdigest(),
    'invariant_geometric_points':55,'local_lower_length':8,
    'weighted_lower_length':440,'points':records,
    'elapsed_seconds':time.monotonic()-started,
    'scope':'Explicit local length-eight quotients. Equality with actual local algebras follows from the complete census length exhaustion, not from this script alone.'}
args.out.parent.mkdir(parents=True,exist_ok=True)
args.out.write_text(json.dumps(report,separators=(',',':'),default=int)+'\n')
print('PASS',args.out.stat().st_size,'receipt bytes;',round(report['elapsed_seconds'],3),'seconds',flush=True)
