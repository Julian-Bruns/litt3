#!/usr/bin/env sage-python
"""Spread the actual fifteen determinant-quadric exclusions over F5(a).

Consumes the Bol-section identities from derive_family_bol_theta.py and
compares their specialization with the completed cubic certificate.
All outputs are stored outside the research workspace.
"""
from sage.all import GF, FunctionField, PolynomialRing, matrix, vector, lcm
import argparse
import itertools
import json
import hashlib
from pathlib import Path
import time


def run(theta_path, certificate_dir):
    start = time.monotonic()
    data = json.loads(theta_path.read_text())
    old = json.loads((certificate_dir/'data.json').read_text())
    smooth = json.loads((certificate_dir/'smoothness_certificates.json').read_text())
    F = FunctionField(GF(5), 'a'); a = F.gen()
    polynomial = PolynomialRing(GF(5), 'aa'); aa = polynomial.gen()
    k = GF(125, name='alpha', modulus=aa**3+aa+1); alpha = k.gen()

    def code(c):
        return k([(int(c)//5**i)%5 for i in range(3)])

    def spec(c):
        c = F(c)
        return c.numerator()(alpha)/c.denominator()(alpha)

    def degree(c):
        c = F(c)
        return max(0, int(c.numerator().degree()), int(c.denominator().degree()))

    def parse(s):
        return F(s.replace('^','**'))

    RT = PolynomialRing(F, 'tt'); tt = RT.gen()
    psi = RT([parse(c) for c in data['extension_polynomial']])
    K = F.extension(psi, 'T'); T = K.gen()
    points = [sum(K(parse(c))*T**i for i,c in enumerate(row))
              for row in data['theta_coordinates']]
    expected = [[55,82,104,115,87],[67,74,82,45,60],[19,60,68,13,18],[1,0,0,0,0]]
    assert [[spec(z.element()[i]) for i in range(5)] for z in points] == [[code(c) for c in row] for row in expected]
    print('actual theta coordinates specialize exactly to the cubic certificate', flush=True)
    R = PolynomialRing(F, names=('z0','z1','z2','z3')); z = R.gens()
    pairs = list(itertools.combinations_with_replacement(range(4),2))
    monomials = [z[i]*z[j] for i,j in pairs]
    tests = matrix(F,5,10,lambda h,j:F((points[pairs[j][0]]*points[pairs[j][1]]).element()[h]))
    roots = [F(0),F(1),F(2),F(3),a**5]
    fc = [F(0),a**5,-a**5-1,a**5+1,-a**5-1,F(1)]

    def polar(x,y):
        return fc[1]*(x+y)+2*fc[2]*x*y+fc[3]*x*y*(x+y)+2*fc[4]*x*x*y*y+x*x*y*y*(x+y)

    labels = [()] + list(itertools.combinations(range(6),2))
    nodes = [vector(F,[0,0,0,1])]
    for i,j in labels[1:]:
        if j == 5:
            b=roots[i]; nodes.append(vector(F,[0,1,b,b*b]))
        else:
            b,c=roots[i],roots[j]
            nodes.append(vector(F,[1,b+c,b*c,polar(b,c)/(b-c)**2]))

    def sum_index(left,right):
        s=set(left)^set(right)
        if len(s)==4:s=set(range(6))-s
        return labels.index(tuple(sorted(s)))

    k1,k2,k3,k4=z[3],-z[2],z[1],-z[0]
    c1,c2,c3,c4=fc[1:5]
    Delta=k2*k2-4*k1*k3
    P=c1*k1*k1*k2+2*c2*k1*k1*k3+c3*k1*k2*k3+2*c4*k1*k3*k3+k2*k3*k3
    K0=c1*c1*k1**4-2*c1*c3*k1**3*k3-4*c1*c4*k1*k1*k2*k3-4*c1*k1*k2*k2*k3+(2*c1-4*c2*c4+c3*c3)*k1*k1*k3*k3-4*c2*k1*k2*k3*k3-2*c3*k1*k3**3+k3**4
    G=Delta*k4*k4-2*P*k4+K0
    for exponent, val in zip(old['quartic_monomials'],old['dual_Kummer']):
        assert spec(G.monomial_coefficient(R.monomial(*exponent)))==code(val)
    gdegree=max(degree(c) for c in G.coefficients())
    print('actual dual Kummer specializes exactly; coefficient degree',gdegree,flush=True)
    span=matrix(F,5,4,lambda i,j:F(points[j].element()[i]))
    span_rows=list(span.transpose().pivots())
    assert len(span_rows)==4
    span_den=lcm([v.denominator() for v in span.list()])
    span_degree=4*max(degree(F(span_den)*v) for v in span.list())
    output={'base':'F5(a)', 'theta_input':str(theta_path.resolve()),
            'theta_span_minor_rows':span_rows,'theta_span_minor_degree_bound':span_degree,
            'calibration_data_sha256':hashlib.sha256((certificate_dir/'data.json').read_bytes()).hexdigest(),
            'smoothness_certificates_sha256':hashlib.sha256((certificate_dir/'smoothness_certificates.json').read_bytes()).hexdigest(),
            'Kummer_coefficient_degree':gdegree, 'covers':[]}
    allbound=5
    moduli_nodes=[vector(F,[1,0,0,0])]

    def clear_rows(A):
        denominators=[]; rows=[]
        for row in A.rows():
            den=lcm([c.denominator() for c in row])
            denominators.append(den)
            rows.append([F(den)*c for c in row])
        return matrix(F,rows),denominators

    for cover_index,tau in enumerate(labels[1:]):
        rows=[]
        for label,source in zip(labels,nodes):
            target=nodes[sum_index(label,tau)]
            for h,j in itertools.combinations(range(4),2):
                rows.append([source[col]*(target[j] if row==h else -target[h] if row==j else 0)
                             for row in range(4) for col in range(4)])
        incidence=matrix(F,rows)
        kernel=incidence.right_kernel()
        assert kernel.dimension()==1
        flat=kernel.basis()[0]; M=matrix(F,4,4,flat)
        moduli_nodes.append(M.row(0))
        square=M*M; c=square[0,0]
        assert c and square==c*matrix.identity(F,4)
        trans=M.transpose()*vector(R,z)
        invariance=matrix(F,10,10,lambda h,j:(trans[pairs[j][0]]*trans[pairs[j][1]]-c*monomials[j]).monomial_coefficient(monomials[h]))
        combined=invariance.stack(tests)
        ker=combined.right_kernel(); assert ker.dimension()==1
        q=ker.basis()[0]; assert q[0]; q=q/q[0]
        assert [spec(v) for v in q]==[code(v) for v in old['covers'][cover_index]['quadric']]
        denominator=lcm([v.denominator() for v in q])
        cleared_q=[F(denominator)*v for v in q]
        qdegree=max(degree(v) for v in cleared_q)
        assert spec(denominator)
        A, row_dens=clear_rows(combined)
        minor_rows=list(A.transpose().pivots()); minor_cols=list(A.pivots())
        assert len(minor_rows)==len(minor_cols)==9
        rank_degree=sum(max(degree(v) for v in A.row(h)) for h in minor_rows)
        incid, incid_dens=clear_rows(incidence)
        incidence_rows=list(incid.transpose().pivots())
        incidence_degree=sum(max(degree(v) for v in incid.row(h)) for h in incidence_rows)
        # Every denominator is required to remain nonzero. The matrices then
        # specialize, and the indicated nonzero minors retain their ranks.
        denom_degree=max([degree(v) for v in M.list()+[c,denominator]]+
                         [int(d.degree()) for d in row_dens+incid_dens])
        smooth_degree=220*(qdegree+gdegree)
        source_certificate=smooth[cover_index]
        assert source_certificate['pair']==list(tau)
        assert source_certificate['degree']==9 and source_certificate['rank']==220
        assert len(set(source_certificate['rows']))==220 and source_certificate['determinant']
        bound=max(rank_degree,incidence_degree,denom_degree,smooth_degree,span_degree)
        allbound=max(allbound,bound)
        output['covers'].append({'pair':list(tau), 'translation':[str(v) for v in M.list()],
            'translation_square':str(c),'quadric':[str(v) for v in q],
            'quadric_clearing_denominator':str(denominator),'cleared_quadric_degree':qdegree,
            'rank_minor_rows':minor_rows,'rank_minor_columns':minor_cols,
            'rank_minor_degree_bound':rank_degree,'translation_rank_minor_degree_bound':incidence_degree,
            'denominator_degree_bound':denom_degree,'smoothness_minor_degree_bound':smooth_degree,
            'calibration_smoothness_minor':{'degree':9,'rows':source_certificate['rows'],
                                          'determinant_code':source_certificate['determinant']},
            'parameter_degree_bound':bound,
            'checks':['translation incidence rank15','translation square scalar','combined rank9',
                      'normalized quadric equals cubic certificate at alpha','clearing denominator nonzero at alpha']})
        print('pair',tau,'Q degree',qdegree,'rank bound',rank_degree,'smooth bound',smooth_degree,flush=True)
    # The conversion used to write G is only a candidate formula until this
    # actual moduli-node check. The standard doubled-theta trope is kappa1=0;
    # its translations are the first rows of the actual M_tau matrices.
    quartic_mons=[R.monomial(*exponent) for exponent in old['quartic_monomials']]
    quartic_rows=[]
    for node in moduli_nodes:
        assert all(G.derivative(z[i])(*node)==0 for i in range(4))
        den=lcm([entry.denominator() for entry in node])
        integral_node=[F(den)*entry for entry in node]
        for i in range(4):
            quartic_rows.append([m.derivative(z[i])(*integral_node) for m in quartic_mons])
    quartic_matrix=matrix(F,quartic_rows)
    assert quartic_matrix.rank()==34
    qrows=list(quartic_matrix.transpose().pivots())
    qcols=list(quartic_matrix.pivots())
    quartic_rank_bound=sum(max(degree(v) for v in quartic_matrix.row(i)) for i in qrows)
    assert quartic_rank_bound<=5280
    output['actual_moduli_quartic']={'checks':['all16 actual moduli nodes singular','quartic constraint rank34'],
        'rank_minor_rows':qrows,'rank_minor_columns':qcols,'rank_minor_degree_bound':quartic_rank_bound}
    allbound=max(allbound,quartic_rank_bound)
    print('actual moduli quartic: rank34, minor degree bound',quartic_rank_bound,flush=True)
    output['parameter_degree_bound']=allbound
    output['seconds']=time.monotonic()-start
    output['checks']=['all theta coefficients specialize exactly','dual Kummer specializes exactly',
                      'all fifteen forced quadrics specialize exactly',
                      'existing degree9 smoothness minors therefore specialize nonzero']
    return output


if __name__=='__main__':
    parser=argparse.ArgumentParser()
    parser.add_argument('--theta',type=Path,required=True)
    parser.add_argument('--certificates',type=Path,required=True)
    parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args()
    dest=args.output.resolve(); workspace=Path(__file__).resolve().parents[2]
    if dest.is_relative_to(workspace):raise ValueError('output must be outside litt3')
    result=run(args.theta,args.certificates)
    dest.parent.mkdir(parents=True,exist_ok=True)
    dest.write_text(json.dumps(result,indent=2)+'\n')
    print('UNIFORM PARAMETER DEGREE BOUND:',result['parameter_degree_bound'],flush=True)
