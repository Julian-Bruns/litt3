#!/usr/bin/env sage
"""Two explicit cyclic cubic etale-cover tests, using only small exact matrices.

The base atlas points are verified in all original saved equations before
pullback by actual curve automorphisms. No atlas solver, torsion census,
production input, or genus-nine coefficient field is used.
"""
import argparse
import hashlib
import itertools
import json
import signal
import time
from pathlib import Path


def run(output, max_seconds):
    started = time.monotonic()
    signal.signal(signal.SIGALRM, lambda *_: (_ for _ in ()).throw(TimeoutError('Bound reached')))
    signal.alarm(int(max_seconds))
    root = Path(__file__).resolve().parents[1]
    source = root/'Research/computations/genus_two_intrinsic_tensor.json'
    solution_source = root/'Research/computations/genus_two_intrinsic_solutions.json'
    data = json.loads(source.read_text())
    saved = json.loads(solution_source.read_text())
    k0 = GF(25, name='a', modulus=PolynomialRing(GF(5), 'z')([2,4,1]))
    k = GF(5**6, name='q')
    ZZ = PolynomialRing(k, 'z'); zz = ZZ.gen()
    a = ZZ([2,4,1]).roots(multiplicities=False)[0]
    emb = lambda c: sum((k(cc)*a**i for i,cc in enumerate(k0(c).polynomial().list())), k.zero())
    get = lambda s: k(sage_eval(s, locals={'a':a}))
    R = PolynomialRing(k, 't'); t = R.gen(); K = R.fraction_field()
    t = K(t); F = t**6+3
    zero = (K.zero(), K.zero())
    one = (K.one(), K.zero())
    add = lambda v,w: tuple(f+g for f,g in zip(v,w))
    scale = lambda c,v: tuple(c*f for f in v)
    sub = lambda v,w: add(v, scale(-1,w))
    def mul(v,w): return (v[0]*w[0]+F*v[1]*w[1], v[0]*w[1]+v[1]*w[0])
    def power(v,n):
        ans = one
        for _ in range(int(n)): ans = mul(ans,v)
        return ans
    def delta(v): return (F*v[1].derivative()+3*t**5*v[1], v[0].derivative())
    def columns(images):
        denominator = lcm([c.denominator() for v in images for c in v])
        polys = [[R(denominator*c) for c in v] for v in images]
        degree = max([c.degree() for v in polys for c in v]+[0])
        return matrix(k, [[v[j][i] for v in polys] for j in range(2) for i in range(int(degree)+1)])
    def lincomb(coeff, vectors):
        return tuple(sum((c*v[j] for c,v in zip(coeff,vectors)), K.zero()) for j in range(2))
    def op_L(P,v,j=0,d=None):
        shift = K.zero() if j==0 else j*d/t
        deriv = lambda w: add(delta(w),scale(shift,w))
        return sub(deriv(deriv(v)),scale(P,v))
    def compose(v,phi,multiplier):
        evaluate = lambda f: f.numerator()(phi)/f.denominator()(phi)
        return (evaluate(v[0]),evaluate(v[1])*multiplier)
    beta = get(data['beta'])
    odd_z = 1/(t-beta)
    odd_w_multiplier = odd_z**3
    def odd_pair(parts):
        return (K(sage_eval(parts[0],locals={'a':a,'z':odd_z})),
                K(sage_eval(parts[1],locals={'a':a,'z':odd_z}))*odd_w_multiplier)
    f1,f2 = odd_pair(data['f1']),odd_pair(data['f2'])
    mons = data['p_monomial_basis']
    p_basis = []
    for row in data['p_basis_affine_component_blocks']:
        parts = []
        for component in range(2):
            ans = zero
            for c,(i,j) in zip(row[component*len(mons):(component+1)*len(mons)],mons):
                mon = (odd_z**i,K.zero()) if j==0 else (K.zero(),odd_z**i*odd_w_multiplier)
                ans = add(ans,scale(get(c),mon))
            parts.append(ans)
        p_basis.append(parts)
    I = matrix(k,[[get(c) for c in row] for row in data['I']])
    ell = matrix(k,[[get(c) for c in row] for row in data['ell']])
    tensor = [matrix(k,[[get(data['tensor_plus_Jinverse_alpha5_p'][i][j][h])
                        for j in range(4)] for h in range(12)]) for i in range(4)]
    polynomial = ZZ(sage_eval(saved['projective_degree11_polynomial'],locals={'a':a,'z':zz}))
    cube_rhs = ZZ(sage_eval(saved['normalization_lambda_cubed'],locals={'a':a,'z':zz}))
    atlas_u = []
    atlas_points = []
    original_count = 0
    for zvalue in polynomial.roots(multiplicities=False):
        lambdas = (zz**3-cube_rhs(zvalue)).roots(multiplicities=False)
        assert len(lambdas)==3
        c = 1/((a+1)*zvalue**10+(-a+2)*zvalue**5+2*a)
        for lam in lambdas:
            ps = lam**(-4)*c*((-2*a+2)*zvalue**5-a-1)
            pt = -lam**(-4)*c*(zvalue**5+a+2)
            bx,by = lam*zvalue,lam
            p = vector(k,[-(2*a+1)*pt,a*ps-pt,ps,pt])
            b = vector(k,[-(2*a+1)*bx+(2*a+2)*by,-(2*a+1)*bx+(2*a+1)*by,bx,by])
            bf = vector(k,[cc**5 for cc in b])
            assert I*b+sum((p[i]*(tensor[i]*bf) for i in range(4)),vector(k,12))==0
            assert p*ell*b==1
            original_count += 1
            if lam!=lambdas[0]: continue
            components = [lincomb(p,[basis[j] for basis in p_basis]) for j in range(2)]
            u = scale((-(t-beta))**7,
                      sub(mul(f1,power(components[1],5)),mul(f2,power(components[0],5))))
            assert op_L(3*t**4+t,u)==zero
            assert all(c.denominator().degree()==0 for c in u)
            assert u[0].numerator().degree()<=7 and u[1].numerator().degree()<=4
            atlas_u.append(u)
            atlas_points.append({'projective_root':str(zvalue),'normalizing_cube_root':str(lam),
                                 'p':[str(c) for c in p],'b':[str(c) for c in b]})
    assert original_count==33 and len(atlas_u)==11
    print('All33 original atlases checked;11 scalar directions transported',round(time.monotonic()-started,2),flush=True)

    branch = [emb(c) for c in k0 if c**6==2]
    def triple_matrix(xs):
        u,v,w = xs
        return matrix(k,[[v-w,-u*(v-w)],[v-u,-w*(v-u)]])
    base = triple_matrix(branch[:3])
    automorphisms = {}
    for triple in itertools.permutations(branch,int(3)):
        mat = triple_matrix(triple).inverse()*base
        aa,bb,cc,dd = mat.list()
        assert all(cc*q+dd!=0 for q in branch)
        assert {(aa*q+bb)/(cc*q+dd) for q in branch}==set(branch)
        phi = (aa*t+bb)/(cc*t+dd)
        multiplier = (phi**6+3)*(cc*t+dd)**6/F
        assert multiplier.numerator().degree()==multiplier.denominator().degree()==0 and multiplier, str(multiplier)
        multiplier_scalar = multiplier.numerator()[0]/multiplier.denominator()[0]
        coefficient = (phi.derivative()**2*(4*phi**4/(phi**6+3)**2+phi/(phi**6+3))-4*t**4/F**2)*F
        pol = R(coefficient)
        tup = tuple(pol[i] for i in range(3))
        if tup in automorphisms: continue
        square_root = (zz**2-multiplier_scalar).roots(multiplicities=False)[0]
        lift_multiplier = square_root/(cc*t+dd)**3
        differential_factor = phi.derivative()/lift_multiplier
        assert (differential_factor/(cc*t+dd)).numerator().degree()==0
        transformed = [scale(differential_factor**7,compose(u,phi,lift_multiplier)) for u in atlas_u]
        P = 3*t**4+pol
        assert all(op_L(P,u)==zero for u in transformed)
        assert all(c.denominator().degree()==0 for u in transformed for c in u)
        automorphisms[tup] = (P,transformed,[str(c) for c in mat.list()],str(square_root))
        if len(automorphisms)==5: break
    assert len(automorphisms)==5
    d = (zz**2-3).roots(multiplicities=False)[0]
    print('All five actual automorphism-translated oper classes loaded',round(time.monotonic()-started,2),flush=True)
    report = {'scope':'Two explicit cubic etale covers; actual atlas pullbacks; no genus-nine or production claim.',
              'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
              'solution_source_sha256':hashlib.sha256(solution_source.read_bytes()).hexdigest(),
              'field_modulus':str(k.modulus()),'a':str(a),'d':str(d),
              'covers':['zeta^3=(v-d)/t^3','zeta^3=(v-d)*(v-t^3)/t^3'],
              'all33_original_equations_verified':True,'cases':[]}
    def inverse(v):
        return scale(1/(v[0]**2-F*v[1]**2),(v[0],-v[1]))
    for cover_index in range(2):
      lam_pair = (-d/t**3,1/t**3)
      if cover_index==1: lam_pair=mul(lam_pair,(-t**3,K.one()))
      logderivative = d/t+(4*t**2 if cover_index==1 else 0)
      assert delta(lam_pair)==scale(3*logderivative,lam_pair)
      for tup,(P,us,mat,square_root) in automorphisms.items():
        for j in [1,-1]:
            dj = j*d
            h = (dj/t,1/t)
            def basis(n):
                if cover_index==1:
                    hh0 = (j*t**3+dj,K.one())
                    return [(t**i,K.zero()) for i in range(1,n)]+[
                        scale(t**i,hh0) for i in range(n-1)]+[scale(1/t,hh0)]
                return [(t**i,K.zero()) for i in range(1,n+1)]+[
                    (dj*t**i,t**i) for i in range(n-2)]+[h]
            shift = j*logderivative
            deriv = lambda w: add(delta(w),scale(shift,w))
            LL = lambda w: sub(deriv(deriv(w)),scale(P,w))
            def kernel(n):
                raw = basis(n)
                return [lincomb(row,raw) for row in columns([LL(v) for v in raw]).right_kernel().basis()]
            h0v = len(kernel(2))
            if h0v:
                report['cases'].append({'cover_index':int(cover_index),'oper':[str(c) for c in tup],
                    'character_exponent':int(j),'h0_V_twist':int(h0v),
                    'scope':'Nonacyclic pullback; not a robustness counterexample.'})
                print('cover',cover_index,'nonacyclic oper',tuple(str(c) for c in tup),'character',j,flush=True)
                continue
            su = kernel(7); target = kernel(12)
            assert len(su)==4 and len(target)==8
            hh = [LL(v) for v in basis(2)]
            assert columns(hh).rank()==3
            # The product identity below verifies the relevant Q action directly.
            if cover_index==0:
                trace = scale(1/t,power((dj,K.one()),2))
            else:
                r_inverse = (-j*t**2-dj/t,1/t)
                trace = mul(power(inverse(lam_pair) if j==1 else lam_pair,2),power(r_inverse,5))
            assert deriv(trace)==zero
            character_cases = []
            for uindex,u in enumerate(us):
                action = [sub(scale(2,mul(hh0,delta(u))),mul(deriv(hh0),u)) for hh0 in hh]
                for g,value in zip(basis(2),action):
                    product = mul(u,g)
                    qvalue = add(add(deriv(deriv(deriv(product))),scale(P,deriv(product))),scale(3,mul(delta((P,K.zero())),product)))
                    assert value==scale(-1,qvalue)
                action.append(mul(trace,u))
                assert columns(action).rank()==4
                assert all(LL(v)==zero for v in action)
                assert columns(target+action+su+[scale(t**5,v) for v in su]).rank()==8
                # Coefficient-space ranks are exact; no quotient basis/inverse is needed.
                ranks = []
                for parameter in range(5):
                    ss = (1+k(parameter)*t**5)
                    ranks.append(int(columns(action+[scale(ss,v) for v in su]).rank()))
                assert all(4<=r<=8 for r in ranks)
                # Each determinant is degree at most4 in parameter; five distinct
                # evaluations certify identical vanishing, not just a rank sample.
                generic_extra = bool(max(ranks)<8)
                character_cases.append({'atlas_direction':uindex,'five_full_ranks':ranks,
                                        'generic_extra_radical':generic_extra})
            report['cases'].append({'cover_index':int(cover_index),'oper':[str(c) for c in tup],'automorphism_matrix':mat,
                'automorphism_square_root':square_root,'character_exponent':int(j),
                'h0_V_twist':0,'h0_E_twist':4,'h0_Eomega_twist':8,
                'atlas_directions':character_cases})
            print('cover',cover_index,'oper',tuple(str(c) for c in tup),'character',j,
                  'extra directions',sum(c['generic_extra_radical'] for c in character_cases),
                  round(time.monotonic()-started,2),flush=True)
    paired = {}
    for case in report['cases']:
        if case['h0_V_twist']: continue
        key = (case['cover_index'],tuple(case['oper']))
        paired.setdefault(key,{})[case['character_exponent']]=case
    report['single_member_higher_corank_count'] = 0
    for (cover_index,oper),pair in paired.items():
        assert set(pair)=={-1,1}
        for positive,negative in zip(pair[1]['atlas_directions'],pair[-1]['atlas_directions']):
            assert positive['five_full_ranks']==negative['five_full_ranks']
            for parameter,rank in enumerate(positive['five_full_ranks']):
                if rank==8: continue
                report['single_member_higher_corank_count'] += 1
                preferred = (cover_index==1 and oper==('0','1','0'))
                old_preferred = report.get('single_member_witness',{}).get('preferred_original_oper',False)
                if 'single_member_witness' not in report or (preferred and not old_preferred):
                    uindex=positive['atlas_direction']
                    value=next(value for key,value in automorphisms.items() if tuple(str(c) for c in key)==oper)
                    report['single_member_witness'] = {'cover_index':cover_index,'oper':oper,
                        'atlas_direction':uindex,'parameter':parameter,'canonical_section':'(1+parameter*t)*dt/v',
                        'preferred_original_oper':preferred,'original_atlas_point':atlas_points[uindex],
                        'automorphism_matrix':value[2],'automorphism_square_root':value[3],
                        'base_U':[str(c) for c in value[1][uindex]],
                        'character_ranks':[rank,rank],'upstairs_single_corank':2+2*(8-rank),
                        'upstairs_normal_corank':2}
    report['elapsed_seconds'] = time.monotonic()-started
    report['status'] = 'complete'
    output = Path(output); output.parent.mkdir(parents=True,exist_ok=True)
    output.write_text(json.dumps(report,indent=2,default=int)+'\n')
    signal.alarm(0)
    print('COMPLETE',report['elapsed_seconds'],flush=True)


if __name__=='__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',required=True)
    parser.add_argument('--max-seconds',type=int,default=180)
    args=parser.parse_args();run(args.output,args.max_seconds)
