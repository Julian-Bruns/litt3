#!/usr/bin/env sage-python
"""Certify the exceptional D10 fourth coefficients and the surjective late response.

The polynomial support is the proved integral weight statement in the named
audit, not a conclusion inferred from interpolation. This script verifies
its exact calibration and the independently reconstructed actual W4 tuple.
"""
import argparse
import hashlib
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, vector

ap=argparse.ArgumentParser(description=__doc__)
ap.add_argument('--data',required=True);ap.add_argument('--output',required=True)
args=ap.parse_args();data=Path(args.data).resolve()
root=Path(__file__).resolve().parents[3]
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
P=PolynomialRing(GF(5),'t');k=GF(625,'t',modulus=P([3,4,1,4,1]))
R=PolynomialRing(k,4,'x');x=R.gens()
enc=lambda a:[int(k(a).polynomial()[i]) for i in range(4)]
candidate=json.loads((data/'exceptional_dihedral5_positive_candidate.json').read_text())
E=vector(R,[R({tuple(c['exponents']):k(c['coefficient']) for c in row}) for row in candidate['polynomials']])
monomials=[R(1)]+list(x)+[v**5 for v in x]+[x[i]**5*x[j]**5 for i in range(4) for j in range(i,4)]
assert len(monomials)==19 and all(all(m in monomials for m in e.monomials()) for e in E)
model_path=data/'exceptional_dihedral5_model.json';model=json.loads(model_path.read_text())
M=matrix(k,[[k(c) for c in row] for row in model['hodge_matrix']])
kernel=matrix(k,[[k(c) for c in row] for row in model['kernel_basis']]).transpose()
dual=matrix(k,[[k(c) for c in row] for row in model['obstruction_duals']])
assert M.rank()==11 and kernel.rank()==dual.rank()==4
assert M*kernel.apply_map(lambda c:c**5)==0 and dual*M==0
assert M[:11,:11].rank()==9 and M[11:,11:].rank()==2
base=data/'exceptional_dihedral5_base'
rows=[];source_hashes={};file_hashes={}
def read_case(label):
    folder=base if label=='base' else data/'exceptional_dihedral5_samples'/label
    if label=='base':params=[[0]*4 for _ in range(4)]
    else:
        receipt=json.loads((folder/'receipt.json').read_text())
        assert receipt['status']=='PASS' and receipt['fingerprint']['model_sha256']==sha(model_path)
        params=receipt['fingerprint']['parameters']
        for name,h in receipt['outputs'].items():assert sha(folder/name)==h
        for name,h in receipt['fingerprint']['sources'].items():
            source=root/name
            if sha(source)!=h:source=data/'source_snapshots'/(h+'.py')
            assert sha(source)==h
            source_hashes[name]=h
    result=json.loads((folder/'genus6_fourth_result.json').read_text())
    assert result['status'].startswith('PASS complete') and result['parameters']==params
    actual=vector(k,[k(c) for c in result['c4']])
    point=[k(c)**125 for c in params]
    assert vector(k,[e(*point) for e in E])==actual,label
    parts=json.loads((folder/'genus6_decomposition.json').read_text())
    assert parts['status'].startswith('PASS exact')
    names=['divided_linear_carry','quadratic_first_repairs','weighted_jet','cubic_Taylor_derivative','preceding_oper_potential']
    assert sum((vector(k,[k(c) for c in parts['components'][n]['scalar']]) for n in names),vector(k,[0]*4))==actual
    for p in folder.glob('genus6_*.json'):file_hashes[str(p.relative_to(data))]=sha(p)
    return point,actual
labels=['base']+[f'e{i}_{a}' for i in range(4) for a in [1,4]]+[f'e{i}_e{j}' for i in range(4) for j in range(i+1,4)]+[f'e{i}_tau_1' for i in range(4)]
assert len(labels)==19
values=[]
for label in labels:
    pt,val=read_case(label);rows.append([m(*pt) for m in monomials]);values.append(val)
calibration=matrix(k,rows);det=calibration.det();assert det!=0
coefficients=calibration.solve_right(matrix(k,values))
for i,e in enumerate(E):assert e==sum((coefficients[j,i]*m for j,m in enumerate(monomials)),R(0))
extra=[f'e{i}_tau_4' for i in range(4)]+['field_check_1','field_check_2']
for label in extra:read_case(label)

# Verify exactly the block form needed for complete late surjectivity.
for e in E[:2]:
    for ex,c in e.dict().items():
        assert (ex[2]==ex[3]==0 and all(a%5==0 for a in ex)) or (ex[0]==ex[1]==0 and ex[2]+ex[3]==10 and ex[2]%5==ex[3]%5==0)
for e in E[2:]:
    for ex,c in e.dict().items():
        assert (sum(ex[:2])==0 and sum(ex[2:]) in [1,5]) or (sum(ex[:2])==5 and sum(ex[2:])==5 and all(a%5==0 for a in ex))
A=matrix(k,[[e.monomial_coefficient(x[j]) for j in [2,3]] for e in E[2:]])
assert A.det()!=0
Y=PolynomialRing(k,2,'y',order='lex');y=Y.gens()
even=[Y({tuple(v//5 for v in ex[:2]):c for ex,c in e.dict().items() if ex[2]==ex[3]==0}) for e in E[:2]]
B=Y.ideal(even).groebner_basis()
Q=PolynomialRing(k,'a');a=Q.gen();p=Q(B[-1](0,a))
assert p.degree()==3 and p.is_irreducible() and p.gcd(p.derivative())==1
K=Q.quotient(p,'l');l=K.gen();point=[-B[0](0,l),l]
assert all(e(*point)==0 for e in even)
J=matrix(K,[[e.derivative(v)(*point) for v in y] for e in even]);assert J.det()!=0
flat=lambda c:sum((enc(K(c).lift()[i]) for i in range(3)),[])
config_path=data/'exceptional_dihedral5_cubic_point.json';config=json.loads(config_path.read_text())
assert config['extension_polynomial']==[enc(p[i]) for i in range(4)]
assert config['parameters']==[flat(c) for c in point]+[[0]*12,[0]*12]
assert config['positive_candidate_jacobian_determinant']==flat(J.det())
assert config['odd_ordinary_determinant']==enc(A.det())

replays=[]
for variant in [0,1]:
    folder=data/f'exceptional_dihedral5_cubic_w4_p3800_v{variant}'
    receipt=json.loads((folder/'receipt.json').read_text())
    assert receipt['status']=='PASS' and receipt['parameters']==config['parameters']
    assert receipt['model_sha256']==sha(model_path) and receipt['config_sha256']==sha(config_path)
    for name,h in receipt['sources'].items():assert sha(root/name)==h
    for name,h in receipt['outputs'].items():assert sha(folder/name)==h
    result=json.loads((folder/'genus6_w4_tuple.json').read_text())
    assert result['status'].startswith('PASS actual compatible W4') and result['primary_rank']==11
    assert result['parameters']==config['parameters']
    assert all(not any(row) for row in result['remaining_normal_vector'])
    four=json.loads((folder/'genus6_fourth_result.json').read_text())
    assert all(not any(row) for row in four['c4'])
    log=(folder/'run.log').read_text()
    for marker in ['FIRST FL CONNECTION CHECK PASS','rank15; same marked T2','FULL W2 JET TRANSITION CHECK PASS','PASS actual next flat-connection gluing modulo125','PASS independent iterated p-connection Taylor formula','PASS actual compatible W4 curve and full W3 filtered/graded tuple']:
        assert marker in log
    replays.append(dict(variant=variant,receipt_sha256=sha(folder/'receipt.json')))
result=dict(status='PASS exact fourth calibration, actual W4 tuple, and complete late-surjectivity blocks',
            support_theorem='EXCEPTIONAL_DIHEDRAL_FOURTH_SUPPORT_AND_FULL_EXTENSION_AUDIT_2026_09_21.md',
            kernel_rank=4,primary_rank=11,calibration_size=19,calibration_determinant=enc(det),
            certified_actual_samples=25,odd_ordinary_determinant=enc(A.det()),
            positive_eliminant=[enc(p[i]) for i in range(4)],positive_jacobian_determinant=flat(J.det()),
            replays=replays,polynomials=candidate['polynomials'],
            calibration_labels=labels,extra_labels=extra,original_sources=source_hashes,files=file_hashes,
            scope='Full existence above the selected third tuple, using the proved late-response theorem; no bounded finite field for the full tower.')
Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
print(result['status'])
print('Calibration determinant',enc(det),'odd determinant',enc(A.det()),'positive determinant',flat(J.det()))
