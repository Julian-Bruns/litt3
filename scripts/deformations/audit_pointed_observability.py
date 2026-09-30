"""Small correctness tests of observability; never runs any cover builder.

Run with sage -python. Extracts only the three audited function definitions.
"""
from sage.all import *
from pathlib import Path
import ast
import hashlib
import itertools
import json

ROOT = Path(__file__).resolve().parents[2]
SOURCE = ROOT/'scripts/deformations/probe_pointed_observability.py'
OUT = ROOT.parent/'litt3-computation-data/pointed_observability_popov_audit_20260915'
OUT.mkdir(parents=True,exist_ok=True)
k = GF(125,'b')
parsed = ast.parse(SOURCE.read_text())
functions = [n for n in parsed.body if isinstance(n,ast.FunctionDef)
             and n.name in ('normalized_pencil','restrict_scalars','insert_row','insert_popov_row')]
assert len(functions)==4
exec(compile(ast.Module(body=functions,type_ignores=[]),str(SOURCE),'exec'),globals())


def analyze(parts, restricted=False, popov=False):
    global R
    A,B,C,D = normalized_pencil({'matrices':parts})
    if restricted:
        A,B,C,D = [restrict_scalars(m) for m in (A,B,C,D)]
    field = A.base_ring()
    R = PolynomialRing(field,'t')
    t = R.gen()
    n = A.ncols()
    obs = []
    row = D
    for j in range(n):
        obs.extend(row.rows())
        row = row*B
    infinity_rank = matrix(field,obs).rank()
    T = A.change_ring(R)+t*B.change_ring(R)
    row = C.change_ring(R)+t*D.change_ring(R)
    basis = [None]*n
    allrows = []
    for j in range(n):
        for v in row.rows():
            allrows.append(list(v))
            (insert_popov_row if popov else insert_row)(basis,v)
        row = row*T
    degrees = [int(v[j].degree()) for j,v in enumerate(basis) if v is not None]
    full = len(degrees)==n and all(d==0 for d in degrees)
    result = {'dimension':n,'infinity_rank':int(infinity_rank),
              'affine_whole_module':full,'pivot_degrees':degrees}
    if not restricted:
        # Independent determinantal-ideal oracle for the small original module.
        W = matrix(R,allrows)
        g = R(0)
        for rows in itertools.combinations(range(W.nrows()),n):
            g = g.gcd(W.matrix_from_rows(rows).det())
        if g:
            g = g.monic()
        assert full == (g==1)
        determinant = matrix(R,basis).det() if len(degrees)==n else R(0)
        assert (determinant.monic() if determinant else R(0)) == g
        if popov and determinant:
            assert determinant.degree()==sum(degrees)
        result['maximal_minor_gcd'] = str(g)
    return result


I = identity_matrix(k,2)
Z = zero_matrix(k,2)
# Multiplication by x0+x1*z+x2*z² on polynomials of degree at most1.
no_drop = [matrix(k,[[1,0],[0,1],[0,0],[0,0]]),
           matrix(k,[[0,0],[1,0],[0,1],[0,0]]),
           matrix(k,[[0,0],[0,0],[1,0],[0,1]])]
affine_drop = [I.stack(Z),Z.stack(Z),Z.stack(I)]
infinity_drop = [I.stack(Z),Z.stack(I),Z.stack(Z)]
companion = matrix(k,[[0,2],[1,0]])
quadratic_drop = [I.stack(Z),Z.stack(-companion),Z.stack(I)]
tests = [('no_drop',no_drop,True,True),
         ('affine_drop',affine_drop,False,True),
         ('infinity_drop',infinity_drop,True,False),
         ('quadratic_extension_drop',quadratic_drop,False,True)]
receipt = {'sage':version(),'source_sha256':hashlib.sha256(SOURCE.read_bytes()).hexdigest(),
           'cases':{}}
left = matrix(k,[[0,0,1,0],[0,0,0,1],[1,1,0,0],[0,1,0,0]])
right = matrix(k,[[1,k.gen()],[0,1]])
assert left.det()!=0 and right.det()!=0
for name,parts,affine,infinity in tests:
    original, restricted = analyze(parts), analyze(parts,True)
    mixed = analyze([left*m*right for m in parts])
    for ans in (original,restricted,mixed):
        assert ans['affine_whole_module']==affine
        assert (ans['infinity_rank']==ans['dimension'])==infinity
    receipt['cases'][name] = {'original':original,'restricted':restricted,
                            'nontrivial_normalization':mixed}
    variants = {'popov':analyze(parts,popov=True),
                'popov_restricted':analyze(parts,True,True),
                'popov_normalized':analyze([left*m*right for m in parts],popov=True)}
    for ans in variants.values():
        assert ans['affine_whole_module']==affine
        assert (ans['infinity_rank']==ans['dimension'])==infinity
    receipt['cases'][name].update(variants)

# Direct tests of the stated bad points.
assert affine_drop[1].rank()==0   # [x0,x1,x2]=[0,1,0]
assert infinity_drop[2].rank()==0 # [0,0,1]
R = PolynomialRing(k,'t')
t = R.gen()
assert (t*t-2).is_irreducible()
assert all((a*I-companion).rank()==2 for a in k)
E = k.extension(t*t-2,names='s')
s = E.gen()
bad = s*quadratic_drop[2].change_ring(E)+quadratic_drop[1].change_ring(E)
assert bad.rank()==1
v = vector(E,[s,1])
assert all(sum((bad[i,j]*v[j] for j in range(2)),E(0))==0 for i in range(4))
receipt['quadratic_extension_point'] = {'polynomial':'t²-2','base_field_roots':0,
    'extension_degree':2,'point':'[0,1,s]','rank':1,'scalar_kernel_products':'all zero'}

# Check that the block restriction uses multiplication, not a field relabelling.
c = k.gen()+2
d = k.gen()**2+1
mul = lambda a: restrict_scalars(matrix(k,[[a]]))
assert mul(c+d)==mul(c)+mul(d)
assert mul(c*d)==mul(c)*mul(d)
for a in k:
    assert mul(c)*vector(GF(5),list(a.polynomial())+[0]*(3-len(a.polynomial().list()))) == \
        vector(GF(5),list((c*a).polynomial())+[0]*(3-len((c*a).polynomial().list())))
receipt['restriction_scalar_checks']='addition, multiplication, all125 vector products PASS'

# Force Euclidean replacement and a dependent row, without allowing saturation.
rows = [[t*t,t],[t,1],[0,t*t-2]]
basis = [None,None]
for row in rows:
    insert_row(basis,row)
assert [v[j].degree() for j,v in enumerate(basis)]==[1,2]
assert basis[0][0]*basis[1][1]==t*(t*t-2)
receipt['euclidean_nonunit_control']='pivot degrees1,2 retained; no saturation'

# Independent small module tests, including zero and dependent rows.
set_random_seed(20260915)
R = PolynomialRing(k,'t')
t = R.gen()
samples = [[[R(0),R(0)]], [[t,R(1)],[t*t,t],[R(0),R(0)]],
           [[t*t,t],[t,R(1)],[R(0),t*t-2]]]
for index in range(30):
    n = 1+index%3
    samples.append([[R.random_element(degree=3) for j in range(n)]
                    for i in range(1+index%6)])
checks = []
for rows in samples:
    n = len(rows[0])
    basis = [None]*n
    bound = max((v.degree() for row in rows for v in row),default=-1)
    for row in rows:
        insert_popov_row(basis,row)
        for j,v in enumerate(basis):
            if v is not None:
                degree = max(c.degree() for c in v)
                assert degree<=bound
                assert j==max(i for i,c in enumerate(v) if c.degree()==degree)
    active = [v for v in basis if v is not None]
    original = matrix(R,rows)
    assert len(active)==original.change_ring(R.fraction_field()).rank()
    g = R(0)
    for indices in itertools.combinations(range(len(rows)),n):
        g = g.gcd(original.matrix_from_rows(indices).det())
    g = g.monic() if g else g
    determinant = matrix(R,active).det() if len(active)==n else R(0)
    assert (determinant.monic() if determinant else R(0))==g
    degrees = [max(c.degree() for c in row) for row in active]
    full = len(active)==n and all(d==0 for d in degrees)
    assert full==(g==1)
    if determinant:
        assert determinant.degree()==sum(degrees)
    checks.append({'rows':len(rows),'columns':n,'rank':len(active),
                   'row_degrees':[int(d) for d in degrees],'minor_gcd':str(g),'full':full})
receipt['popov_small_modules'] = checks
height3 = ROOT.parent/'litt3-computation-data/unmarked_extension_spectrum_20260915/height3_popov_observability_t0.json'
h3 = json.loads(height3.read_text())
builder = ROOT/'scripts/deformations/pointed_frobenius_polynomial.py'
assert h3['source_sha256']==receipt['source_sha256']
assert h3['builder_sha256']==hashlib.sha256(builder.read_bytes()).hexdigest()
assert h3['height']==3 and h3['reduction']=='popov' and not h3['restrict_to_prime_field']
assert [(b['columns'],b['infinity_rank'],b['stages'][-1]['power'],b['stages'][-1]['rank'],
         b['stages'][-1]['pivot_degree_sum'],b['whole_row_module']) for b in h3['blocks']] == \
       [(63,63,31,63,0,True),(60,60,30,60,0,True)]
receipt['height3_receipt_inspection'] = {'source_and_builder_hashes_match':True,
    'receipt_sha256':hashlib.sha256(height3.read_bytes()).hexdigest(),
    'run_repeated':False,'blocks':[{key:b[key] for key in
        ('torsion','block','columns','infinity_rank','whole_row_module','seconds')}
        for b in h3['blocks']]}
(OUT/'audit.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps(receipt,indent=2))
print('PASS: four toy pencils in both coefficient representations; no cover computations')
