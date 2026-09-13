"""Independent exact algebra checks for the next question; run with Sage.

These prove the question's chart, calibrations and leverage, not the
candidate universal geometric trace.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import json
from pathlib import Path
import re
import zipfile

from sage.all import GF, PolynomialRing, matrix, vector
from scripts.deformations.rank25 import rank25_pro_data_model as m


def main():
    root=Path(__file__).resolve().parents[3]
    fp=PolynomialRing(GF(5),'T'); T=fp.gen()
    modulus=T**4+4*T**3+T**2+4*T+3
    assert modulus.is_irreducible()
    K=GF(625,name='t',modulus=modulus); t=K.gen()
    def coefficient(c):
        if isinstance(c,int): c=m.digits(c)
        return sum(K(a)*t**i for i,a in enumerate(c))
    def four(c):return [int(c.polynomial()[i]) for i in range(4)]
    def ctext(s):return coefficient(tuple(map(int,s)))
    with zipfile.ZipFile(root/'Research/pro_inputs/rank25_all_fifth_lifts_inputs.zip') as archive:
        data=m.unpack(json.loads(archive.read('data.json')))
        fourth=m.unpack(json.loads(archive.read('fourth.json')))['obstruction']
        family=json.loads(archive.read('family.json'))
    prompt=(root/'Research/requests/rank25_universal_fifth_trace_request.txt').read_text()
    R=PolynomialRing(K,['U','A','B','q']); U,A,B,q=R.gens(); Fr=R.fraction_field()
    coefficient_lines=re.findall(r'^\s+Coeff\.\s+([0-4\s]+)$',prompt,re.M)
    coefficients=[ctext(c) for line in coefficient_lines for c in line.split()]
    monomials=[R.one(),U*q*q,q*q,B*q*q,A*q*q,B*B,A*B,A*A,B**3,A*B*B,A*A*B,A**3]
    assert len(coefficients)==len(monomials)
    theta=sum(c*mon for c,mon in zip(coefficients,monomials))
    reported=sum(coefficient(c)*R.monomial(*powers) for powers,c in family['theta_candidate'])
    assert theta==reported, {'literal':str(theta),'stored':str(reported)}

    D=matrix(K,[[ctext('2014'),ctext('0130')],[ctext('4342'),ctext('3004')]])
    c=vector(K,[ctext('1002'),ctext('4420')]); r=ctext('0224')
    assert D.det()==ctext('4303') and r**125==ctext('3112')
    H=matrix(K,[[ctext('2140'),ctext('3031')],[ctext('3300'),ctext('1040')]])
    assert H==matrix(K,[[coefficient(v) for v in row] for row in data['additive_matrix']])
    assert H.det()==4 and t**5==2+3*t
    primary=[K.zero()]*75
    primary[:3]=[ctext('3242'),ctext('4014'),K.zero()]
    for i,j,factor in [(0,2,t*t),(1,1,2*t),(2,0,K.one())]:
        primary[3*(5*i+j):3*(5*i+j)+3]=[factor*ctext(v) for v in ('4340','0434','1121')]
    assert primary==[coefficient(v) for v in data['primary_repair']]
    basic=[K.one(),t,3+3*t*t]
    for index,components in [(0,[(0,0,K.one())]),(1,[(1,0,K.one()),(0,1,t)]),(2,[(0,1,K.one())])]:
        v=[K.zero()]*75
        for i,j,factor in components:v[3*(5*i+j):3*(5*i+j)+3]=[factor*a for a in basic]
        assert v==[coefficient(a) for a in data['kernel_basis'][index]]
    pair_coefficients=[]
    for name in ('F0','G0'):
        line=re.search(r'^\s+'+name+r'\s+((?:[0-4]{4}\s+){5}[0-4]{4})\s*$',prompt,re.M)
        pair_coefficients.append([ctext(c) for c in line.group(1).split()])
    p3=3+3*t**3; p4=3*t+t*t+4*t**3
    X3=A+p3; X4=B+p4
    mon=[R.one(),X3,X4,X3**2,X3*X4,X4**2]
    # Take fifth roots of COEFFICIENTS to parametrize actual x rationally.
    inverse_pair=vector(Fr,[sum(a**125*b for a,b in zip(row,mon)) for row in pair_coefficients])
    Dr=D.apply_map(lambda a:a**125); cr=c.apply_map(lambda a:a**125)
    lower=-(matrix(Fr,Dr)**-1)*(inverse_pair/q+q*vector(Fr,cr))
    x=[Fr(U),lower[0],lower[1],Fr(X3),Fr(X4),Fr(r**125*q),Fr(q),Fr(0),Fr(0)]
    y=[a**5 for a in x]
    answer=[Fr(coefficient(c)) for c in fourth['constant']]
    for i,row in enumerate(fourth['ordinary']):
        answer=[a+coefficient(c)*x[i] for a,c in zip(answer,row)]
    for i,row in enumerate(fourth['frobenius']):
        answer=[a+coefficient(c)*y[i] for a,c in zip(answer,row)]
    for i,j,row in fourth['quadratic']:
        answer=[a+coefficient(c)*y[i]*y[j] for a,c in zip(answer,row)]
    assert answer==[Fr(0)]*9
    assert all(a.denominator().degree(A)==a.denominator().degree(B)==a.denominator().degree(U)==0 for a in x)
    assert theta.derivative(U)==ctext('2110')*q**2

    S=PolynomialRing(K,['s','lam']); s,lam=S.gens()
    restrict=R.hom([2+t+3*t*t+s**5,0,0,lam**5],S)
    assert restrict(theta)**5==(3+4*t*t)*(s*lam**2-1)**25
    # Accepted surface parametrization must match the actual open chart.
    for index,value in [(1,ctext('4331')),(2,ctext('2234'))]:
        num=x[index].numerator(); den=x[index].denominator()
        assert R.hom([U,0,0,q],R)(num)-value*q*R.hom([U,0,0,q],R)(den)==0

    boundary=json.loads((root/'Research/computations/rank25_w5_return_and_global_w4_locus_checks.json').read_text())['boundary_four_roots']
    outputs=[]
    for point in boundary:
        a,b=coefficient(point['a']),coefficient(point['b'])
        powers=[K.one(),a,b,a*a,a*b,b*b]
        assert all(sum(v*w for v,w in zip(row,powers))==0 for row in pair_coefficients)
        X,Y=coefficient(point['x3']),coefficient(point['x4'])
        assert X**5==a and Y**5==b
        val=theta(U,X-p3,Y-p4,0)
        assert val.degree(U)==0 and val!=0
        outputs.append({'x3':four(X),'x4':four(Y),'candidate_trace':four(K(val)**5)})
    expected={(2,0,1,0),(4,1,4,0),(1,3,3,0),(3,1,2,0)}
    assert {tuple(p['candidate_trace']) for p in outputs}==expected

    receipt={
        'status':'PASS algebraic leverage and literal prompt checks; universal geometric identity remains UNPROVED',
        'date':'2026-09-13',
        'field_H_and_Dmix':'irreducible quartic, original H, det H=4, det Dmix=4303, fifth-root convention PASS',
        'full_fourth_open_chart':'All nine established fourth equations vanish identically in the rational actual coordinates.',
        'exceptional_denominators':'Only q powers; q=0 is separately retained as four three-dimensional boundary families.',
        'theta_literal':'Every printed coefficient equals the retained candidate, coefficientwise.',
        'surface_restriction':'Exactly the newly proved (3+4t^2)*(s*lambda^2-1)^25.',
        'boundary_candidate_values':outputs,
        'new_mathematics_required':'Nine candidate coefficient monomials vanish on A=B=0; the proved surface does not determine them or exclude hidden family terms/carries.',
        'leverage_if_candidate_proved':'All four boundary families excluded; the open reduced trace-zero locus is the graph U=-Theta(0,A,B,q)/((2+t+t^2)*q^2). Three other fifth residuals still remain.',
        'leverage_if_candidate_wrong':'Correct universal trace replaces the reported polynomial and determines the true first constraint before any further residual calculation.',
        'fifth_lift_claim':False
    }
    (root/'Research/computations/rank25_universal_trace_target_checks.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print(json.dumps(receipt,indent=2))


if __name__=='__main__':
    main()
