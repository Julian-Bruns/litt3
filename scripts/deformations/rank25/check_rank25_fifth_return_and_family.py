#!/usr/bin/env python3
"""Independent field audit, original-origin check and global fourth-locus reduction.

No producer arithmetic imports. The geometric-point reduction is over bar(F5),
not a claim that the scheme in actual x coordinates is reduced or smooth.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse
import hashlib
import itertools
import json
from pathlib import Path
from scripts.deformations.rank25.analyze_rank25_w4_germ import ZERO, ONE, elt, add, sub, neg, mul, power, inv, det2, rank

def total(xs):
    out=ZERO
    for x in xs: out=add(out,x)
    return out
def mv(a,x):
    assert all(len(row)==len(x) for row in a)
    return [total(mul(elt(v),elt(w)) for v,w in zip(row,x)) for row in a]
def mm(a,b): return [mv(list(zip(*b)),row) for row in a]
def inv2(a):
    di=inv(det2(a))
    return [[mul(di,a[1][1]),mul(di,neg(a[0][1]))],
            [mul(di,neg(a[1][0])),mul(di,a[0][0])]]
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()

def run(w4,w5,germ):
    p=json.loads((w4/'point_and_fourth_digit.json').read_text())
    r=json.loads((w5/'reconstruction/reconstructed_fourth_digit.json').read_text())
    d=json.loads((w5/'supplied/inputs/rank25_fourth.json').read_text())
    c=json.loads((w5/'reconstruction/fifth_locus_certificate.json').read_text())
    u=json.loads((w4/'work/receipts/universal2100.json').read_text())
    assert p['third_curve_repair_actual_coordinates']==r['third_digit']
    assert p['fourth_digit']==r['zeta']
    assert p['reference_rho4']==r['rho4_coordinates']
    M=d['hodge_matrix']; Lam=d['obstruction_dual_rows']; N=list(zip(*d['kernel_basis']))
    assert rank([[elt(x) for x in row] for row in M])==66
    assert mm(Lam,M)==[[ZERO]*75 for _ in range(9)]
    assert mm(Lam,N)==[[ZERO]*9 for _ in range(9)]
    assert mm(M,[[power(elt(x),5) for x in row] for row in N])==[[ZERO]*9 for _ in range(75)]
    sep=c['normalized_separating_row']
    assert mv(list(zip(*M)),sep)==[ZERO]*75
    kappa=elt(c['separating_scalar']); ki=elt(c['separating_scalar_inverse'])
    assert kappa==(2,0,1,0) and mul(kappa,ki)==ONE
    normal=json.loads((w5/'reconstruction/fifth_regular_constant_3600_0.json').read_text())
    assert mv([sep],normal['rho5_coordinates'])==[ONE]
    B=[[elt(a) for a in row] for row in c['frobenius_relative_operator']]
    assert rank(B)==5 and all(B[i]==[ZERO]*9 for i in (0,7,8))
    assert B[4]==[mul(elt(2),x) for x in B[3]]
    C=[elt(a) for a in u['constant']]
    L=[[elt(a) for a in row] for row in u['linear_fifth']]
    Q={(r['i'],r['j']):[elt(a) for a in r['coefficient']] for r in u['quadratic_fifth']}
    assert all(elt(a)==ZERO for row in u['linear_x'] for a in row)
    def evaluate(y):
        return [add(C[r],total([mul(L[i][r],y[i]) for i in range(9)] +
                  [mul(row[r],mul(y[i],y[j])) for (i,j),row in Q.items()])) for r in range(9)]
    def jac(y):
        j=[[L[i][r] for i in range(9)] for r in range(9)]
        for (a,b),row in Q.items():
            for r in range(9):
                j[r][a]=add(j[r][a],mul(row[r],y[b]))
                j[r][b]=add(j[r][b],mul(row[r],y[a]))
        return j
    ystar=[power(elt(x),5) for x in p['parameters']]
    assert evaluate(ystar)==[ZERO]*9 and jac(ystar)==B

    # E0 only involves y7,y8. Neither coordinate axis contains a nonzero zero.
    assert C[0]==ZERO and all(row[0]==ZERO for row in L)
    assert all(row[0]==ZERO for ij,row in Q.items() if ij not in {(7,7),(7,8),(8,8)})
    qa,qb,qc=[Q[ij][0] for ij in [(7,7),(7,8),(8,8)]]
    assert qa!=ZERO and qc!=ZERO
    slopes=[a for a in itertools.product(range(5),repeat=4)
            if add(add(qa,mul(qb,a)),mul(qc,mul(a,a)))==ZERO]
    assert len(slopes)==2 and slopes[0]!=slopes[1]
    # Two distinct exact roots exhaust a degree-two polynomial over k.
    assert mul(qc,mul(*slopes))==qa
    assert neg(mul(qc,add(*slopes)))==qb
    exclusions=[]
    for h in slopes:
        rows=[]
        for r0 in (5,6):
            assert C[r0]==ZERO and all(L[i][r0]==ZERO for i in range(7))
            allowed={(3,7),(3,8),(4,7),(4,8),(7,7),(7,8),(8,8)}
            assert all(row[r0]==ZERO for ij,row in Q.items() if ij not in allowed)
            rows.append([add(L[7][r0],mul(h,L[8][r0])),
                         add(Q[3,7][r0],mul(h,Q[3,8][r0])),
                         add(Q[4,7][r0],mul(h,Q[4,8][r0])),
                         add(add(Q[7,7][r0],mul(h,Q[7,8][r0])),mul(mul(h,h),Q[8,8][r0]))])
        lam=mul(rows[1][1],inv(rows[0][1]))
        residual=[sub(a,mul(lam,b)) for a,b in zip(rows[1],rows[0])]
        assert residual[0]!=ZERO and residual[1:]==[ZERO]*3
        exclusions.append({'slope_y8_over_y7':h,'row_multiplier':lam,
                           'nonzero_constant_in_E6_minus_multiplier_E5_div_y7':residual[0]})
    # Thus E=0 forces y7=y8=0, globally on geometric points.
    for r0 in (0,5,6,7,8):
        assert C[r0]==ZERO and all(L[i][r0]==ZERO for i in range(7))
        assert all(row[r0]==ZERO for ij,row in Q.items() if max(ij)<7)
    assert C[3]==C[4]==ZERO and L[5][3]!=ZERO
    assert all(L[i][3]==L[i][4]==ZERO for i in range(5))
    assert all(row[3]==row[4]==ZERO for ij,row in Q.items() if max(ij)<7)
    assert L[5][4]==mul(elt(2),L[5][3]) and L[6][4]==mul(elt(2),L[6][3])
    slope=neg(mul(inv(L[5][3]),L[6][3]))
    mixed=[]
    for r0 in (1,2):
        mixed.append([*[add(mul(slope,Q[i,5][r0]),Q[i,6][r0]) for i in (1,2)],
            add(add(mul(mul(slope,slope),Q[5,5][r0]),mul(slope,Q[5,6][r0])),Q[6,6][r0])])
    dm=[row[:2] for row in mixed]; dm_inv=inv2(dm)
    # Exact coefficient dictionaries after y7=y8=0 and y5=slope*y6.
    reduced=[]
    for r0 in (1,2):
        poly={():C[r0]}
        def insert(m,c0): poly[m]=add(poly.get(m,ZERO),c0)
        for i in range(7):insert((6 if i==5 else i,),mul(L[i][r0],slope if i==5 else ONE))
        for (i,j),row in Q.items():
            if max(i,j)<7:
                fac=power(slope,int(i==5)+int(j==5))
                insert(tuple(sorted(6 if v==5 else v for v in (i,j))),mul(fac,row[r0]))
        poly={m:c0 for m,c0 in poly.items() if c0!=ZERO}
        allowed={(),(3,),(4,),(3,3),(3,4),(4,4),(1,6),(2,6),(6,6)}
        assert poly.keys() <= allowed
        assert poly.get((1,6),ZERO)==mixed[len(reduced)][0]
        assert poly.get((2,6),ZERO)==mixed[len(reduced)][1]
        assert poly.get((6,6),ZERO)==mixed[len(reduced)][2]
        reduced.append([{'monomial':m,'coefficient':c0} for m,c0 in sorted(poly.items())])
    # A checked affine line through the known point, crossing into y6!=0.
    line=mv(dm_inv,[neg(row[2]) for row in mixed])
    vy=[ZERO,line[0],line[1],ZERO,ZERO,slope,ONE,ZERO,ZERO]
    # Coefficient check for E(ystar+s*vy)=0, degree<=2; not point interpolation.
    assert mv(jac(ystar),vy)==[ZERO]*9
    assert [total(mul(row[r0],mul(vy[i],vy[j])) for (i,j),row in Q.items()) for r0 in range(9)]==[ZERO]*9
    point_y=[add(x,z) for x,z in zip(ystar,vy)]
    point_x=[power(x,125) for x in point_y]
    assert evaluate(point_y)==[ZERO]*9
    # Boundary s=0: the earlier exact resultant supplies all four simple pairs.
    prior=json.loads(germ.read_text())
    top_open=[[add(mul(slope,Q[5,i][r0]),Q[6,i][r0]) for i in (7,8)] for r0 in (7,8)]
    assert det2(top_open)!=ZERO
    open_minor=mul(mul(det2(dm),L[5][3]),det2(top_open))
    boundary_minors=[]
    for pair in prior['all_four_geometric_reduced_slice_points']:
        yp=[ZERO]*9;yp[3]=elt(pair['a']);yp[4]=elt(pair['b'])
        assert evaluate(yp)==[ZERO]*9
        jp=jac(yp)
        dm34=det2([[jp[r0][i] for i in (3,4)] for r0 in (1,2)])
        dm78=det2([[jp[r0][i] for i in (7,8)] for r0 in (5,6)])
        assert dm34!=ZERO and dm78!=ZERO and rank(jp)==5
        boundary_minors.append({'a':yp[3],'b':yp[4],'det_E1E2_y3y4':dm34,'det_E5E6_y7y8':dm78})
    return {'status':'PASS', 'original_third_digit_identical':True,'original_fourth_digit_identical':True,
      'original_rho4_identical':True,'origin_shift_gamma':[[0]*4 for _ in range(9)],
      'constant_in_original_reference':c['constant_at_reconstructed_reference'],
      'relative_operator_B':B,'normalized_separating_row':sep,
      'normal_reference_vector':normal['rho5_coordinates'],
      'separating_row_verified':True,'B_equals_old_Jacobian_at_star':True,
      'equality_scope':'Entrywise finite-field identity at star only; uniform geometric Jacobian identity remains to be proved.',
      'top_parameter_exclusions':exclusions,'all_geometric_fourth_zeros_have_y7_y8_zero':True,
      'y5_over_y6':slope,'reduced_equations':reduced,
      'mixed_matrix_y1y2':dm,'mixed_matrix_inverse':dm_inv,'mixed_determinant':det2(dm),
      'quadratic_s_coefficients':[row[2] for row in mixed],
      'open_chart':'s=y6!=0, a=y3,b=y4,y0 free; (y1,y2)=-Dmix^-1*((F(a,b),G(a,b))/s+s*c); y5=r*s,y7=y8=0',
      'boundary_chart':'s=0: four exact (a,b) roots from prior resultant; y0,y1,y2 arbitrary',
      'boundary_four_roots':prior['all_four_geometric_reduced_slice_points'],
      'Jacobian_rank_on_all_geometric_W4_points':5,
      'Jacobian_rank_proof':'On s!=0 use rows1,2,3,7,8 / cols1,2,5,7,8; determinant is open_minor_coefficient*s^4. On s=0 use the four boundary minors and pivot E3_y5. All other derivative rows lie in the same five-dimensional row space, since E4-2E3 and E0,E5,E6,E7,E8 have only top-coordinate derivatives on S.',
      'open_minor_coefficient':open_minor,'open_top_matrix':top_open,'open_top_determinant':det2(top_open),
      'boundary_Jacobian_minors':boundary_minors,
      'line_y_direction':vy,'line_x_direction':[power(x,125) for x in vy],
      'line_formula':'y=ystar+s*line_y_direction; x=xstar+z*line_x_direction with s=z^5',
      'checked_open_point_x':point_x,
      'input_sha256':{str(p0):sha(p0) for p0 in [w4/'point_and_fourth_digit.json',w4/'work/receipts/universal2100.json',w5/'reconstruction/fifth_locus_certificate.json']},
      'scope':'Exact original-origin and coefficient checks. Complete W4 geometric-point locus reduction. No W5 claim outside fixed star; no scheme smoothness in x; no global common-cover claim.'}

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('w4',type=Path);p.add_argument('w5',type=Path)
    p.add_argument('--germ',type=Path,default=Path('Research/computations/rank25_w4_germ_and_next_checks.json'))
    p.add_argument('--output',type=Path,required=True)
    a=p.parse_args();out=run(a.w4,a.w5,a.germ)
    a.output.write_text(json.dumps(out,indent=2)+'\n')
    print('PASS: original fourth digit identical; separating row; B=Jacobian at star.')
    print('PASS: all W4 geometric points reduced to explicit open four-parameter chart and four boundary charts.')
    print('Dmix determinant:',out['mixed_determinant'])
