"""Independent Sage field/quotient audit of local full geometric point receipts.

Run with sage -python; this does not replace the Laurent/regular-frame replay.
"""
import hashlib
import json
from pathlib import Path
import sys
import zipfile
from sage.all import GF, PolynomialRing, matrix, vector

root=Path(__file__).resolve().parents[3]
paths=[Path(p) for p in sys.argv[1:]]
with zipfile.ZipFile(root/'Research/pro_inputs/rank25_surface_fifth_inputs.zip') as z:
    data=json.loads(z.read('surface.json'))
P=PolynomialRing(GF(5),'X');X=P.gen()
reports=[]
for run in paths:
    raw=json.loads((run/'fifth_constant_4200_0.json').read_text())
    independent=json.loads((run/'independent_fifth_audit_4200_0.json').read_text())
    params=json.loads((run/'parameters.json').read_text())
    degree=len(raw['E5'][0]);stride=degree//4
    f=X**degree+4*X**(3*stride)+X**(2*stride)+4*X**stride+3
    assert f.is_irreducible()
    K=GF(5**degree,'h',modulus=f);h=K.gen();t=h**stride
    def elem(a):
        if len(a)==4:return sum(K(c)*t**i for i,c in enumerate(a))
        assert len(a)==degree
        return sum(K(c)*h**i for i,c in enumerate(a))
    def code(c):return elem([(c//5**i)%5 for i in range(4)])
    def mat(tensor):
        nr,nc=tensor['shape'];A=matrix(K,nr,nc)
        for i,c in tensor['nonzero']:A[i//nc,i%nc]=code(c)
        return A
    lam=elem(params.get('lambda',[3,2,2,2]));ss=elem(params['s']) if 's' in params else lam**-2
    C=vector(K,map(elem,raw['E5']));normal=vector(K,map(elem,raw['rho5_coordinates']))
    M=mat(data['matrix']);dual=mat(data['dual'])
    assert M.rank()==66 and dual*M==0 and dual*normal==C
    J=sum((ss**a*lam**b*mat(q) for a,b,q in data['relative_J']),matrix(K,9,9))
    assert J.rank()==5
    y=J.matrix_from_rows_and_columns([7,8],[7,8]).solve_right(vector(K,[C[7],C[8]]))
    def pair(i):return vector(K,[J[i,j] for j in (7,8)])
    residual=vector(K,[C[0],C[4]-2*C[3]-(pair(4)-2*pair(3))*y,
        C[5]-pair(5)*y,C[6]-pair(6)*y])
    assert residual==vector(K,map(elem,independent['residuals']))
    assert C==vector(K,map(elem,independent['riccati_E5']))
    assert J.augment(C).rank()==independent['rank_augmented']
    G=sum(code(c)*lam**i for i,c in enumerate(data['known_curve_G']))
    point={'directory':str(run),'degree_over_F5':degree,'G_zero':bool(G==0),
           'rank_J':int(J.rank()),'rank_augmented':int(J.augment(C).rank()),
           'residual_nonzero':bool(any(residual)),
           'all_fourth_choices_excluded':bool(J.augment(C).rank()>J.rank()),
           'source_receipt_sha256':hashlib.sha256((run/'fifth_constant_4200_0.json').read_bytes()).hexdigest(),
           'independent_receipt_sha256':hashlib.sha256((run/'independent_fifth_audit_4200_0.json').read_bytes()).hexdigest()}
    if 'factor' in params or 'factor_codes' in params:
        cs=params.get('factor',params.get('factor_codes'))
        assert sum(code(c)*lam**i for i,c in enumerate(cs))==0
        orbit=[];v=lam
        while v not in orbit:orbit.append(v);v=v**625
        assert v==lam and len(orbit)==len(cs)-1
        point['F625_Frobenius_orbit_size']=len(orbit)
        point['sign_doubles_orbit']=bool(-lam not in orbit)
        point['roots_excluded_by_Frobenius_and_sign']=len(orbit)*(2 if -lam not in orbit else 1)
    reports.append(point)
result={'status':'PASS independent Sage field/rank audit','points':reports}
(root/'Research/computations/rank25_local_root_receipts.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
