#!/usr/bin/env sage-python
"""Independent central-Frobenius transport and two additional Hodge ranks.

Uses only the previous auditor's independent nested quadratic algebra;
no producer module is imported. Central transport is reconstructed from
three-dimensional frames, with every local Lang comparison replayed.
"""
import argparse
from collections import Counter, defaultdict
from hashlib import sha256
from itertools import product
from math import comb
from pathlib import Path
import json
import time

from sage.all import GF, PolynomialRing, matrix, vector
from audit_actual_heisenberg_defect import IndependentBase, IndependentTorsor


ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT/'Research/computations'
EXTERNAL = ROOT.parent/'litt3-computation-data/heisenberg125-census-20260911'


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',required=True)
    args = ap.parse_args()
    start = time.monotonic()
    result = {'status':'running','inputs':{},'orbit_checks':[],'rank_checks':[],
              'field_transports':[]}

    def read(path):
        raw = path.read_bytes()
        result['inputs'][str(path)] = sha256(raw).hexdigest()
        return json.loads(raw)

    def save(stage):
        result['seconds'] = time.monotonic()-start
        Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
        print(json.dumps({'stage':stage,'seconds':result['seconds']}),flush=True)

    source = read(DATA/'backup_bad_double_cyclic_directions.json')
    p = GF(5)
    P = PolynomialRing(p,'t')
    k = GF(5**12,name='b',modulus=P(source['coefficient_field_modulus']))
    decode = lambda co:k(list(co))
    alpha = decode(source['alpha_embedding'])
    assert alpha**3+alpha+1 == 0

    # Symbolic group-homomorphism identity for the full quadratic correction.
    S = PolynomialRing(p,names=('a','b','c','d','x','y','z','X','Y','Z'))
    a,b,c,d,x,y,z,X,Y,Z = S.gens()
    determinant = a*d-b*c
    q = lambda xx,yy:a*c*xx**2/2+b*d*yy**2/2+b*c*xx*yy
    assert determinant*(z+Z+x*Y)+q(x+X,y+Y) == (
        determinant*z+q(x,y)+determinant*Z+q(X,Y)+(a*x+b*y)*(c*X+d*Y))
    result['symbolic_UT3_automorphism_identity'] = True

    records_by_case = {}
    for caseid in (0,2):
        case = source['cases'][caseid]
        expected = read(DATA/('heisenberg125_frobenius_case%d.json'%caseid))
        raw = read(DATA/('backup_bad_double_jet_%d.json'%caseid))
        base = IndependentBase(k,alpha,raw)
        B = base.B
        assert all(co**125 == co for poly in (base.R,base.S,base.A) for co in poly.coefficients())
        fixed = matrix(k,[[decode(co) for co in row] for row in case['as_basis']],
                       implementation='generic').transpose()
        sigma = matrix(p,3,3,(fixed.inverse()*fixed.apply_map(lambda co:co**125)).list())
        assert sigma.is_invertible() and sigma**4 == 1
        assert [list(map(int,row)) for row in sigma] == expected['sigma_as']

        def cocycle(v):
            co = fixed*vector(k,v)
            return sum((base.mono(*key)*a for key,a in zip(base.obasis,co)),B(0))

        def coefficient_sigma(value):
            return sum((base.components[i]*B(base.L({int(e):co**125 for e,co in poly.dict().items()}))
                        for i,poly in enumerate(base.coordinates(value))),B(0))

        records = []
        for i,plane in enumerate(case['planes']):
            v1,v2 = [vector(p,v) for v in plane['coefficient_basis']]
            complement = next(vector(p,[int(i==j) for i in range(3)]) for j in range(3)
                              if matrix(p,[v1,v2,[int(i==j) for i in range(3)]]).rank()==3)
            frame = matrix(p,[v1,v2,complement]).transpose()
            chars = [cocycle(v) for v in (v1,v2,complement)]
            local = [base.split(chi**5-chi,False) for chi in chars]
            assert all(not any(co) for co,uu,oo in local)
            # ell -> -ell fixes components 1,kappa, negates ell,v.
            assert all(not any(base.coordinates(chi)[:2]) for chi in chars)
            f1,f2 = local[0][1],local[1][1]
            g1,g2 = -local[0][2],-local[1][2]
            cross = -chars[0]**5*f2+g1*chars[1]
            assert not any(base.coordinates(cross)[2:])
            co,uu,oo = base.split(cross,False)
            assert not any(co)
            saved_primitive = expected['planes'][i]['kappa']
            assert all(not part for part in saved_primitive)
            assert list(map(int,complement)) == expected['planes'][i]['complement']
            records.append({'frame':frame,'characters':chars,'local':local,
                            'cross':cross,'f':(f1,f2,-uu),'g':(g1,g2,oo)})

        def local_cover(record,central):
            co,uu,oo = base.split(record['cross']+central*(record['characters'][2]**5-
                                                         record['characters'][2]),False)
            assert not any(co)
            return record['f'][:2]+(-uu,),record['g'][:2]+(oo,)

        permutation = {}
        witness_map = {tuple(w['source']):w for w in expected['witnesses']}
        for i,old in enumerate(records):
            transformed = sigma*old['frame']
            candidates = []
            for j,target in enumerate(records):
                change = target['frame'].inverse()*transformed
                if change[2,0] == change[2,1] == 0:
                    candidates.append((j,target,change))
            assert len(candidates) == 1
            j,target,change = candidates[0]
            linear = change[:2,:2]
            plane_det = linear.det()
            quotient_scalar = change[2,2]
            assert plane_det and quotient_scalar
            assert plane_det*quotient_scalar == sigma.det()*old['frame'].det()/target['frame'].det()
            M = linear.transpose()
            a,b,c,d = [k(v) for v in M.list()]
            det = k(plane_det)
            quad = lambda xx,yy:a*c*xx**2/2+b*d*yy**2/2+b*c*xx*yy
            chi1,chi2,chi3 = target['characters']
            qchi = quad(chi1,chi2)
            assert not any(base.coordinates(qchi)[2:]) and not any(base.split(qchi,False)[0])
            assert coefficient_sigma(old['characters'][0]) == a*chi1+b*chi2
            assert coefficient_sigma(old['characters'][1]) == c*chi1+d*chi2
            for central in range(5):
                new = int(p(central)*quotient_scalar/plane_det)
                permutation[5*i+central] = 5*j+new
                w = witness_map[(i,central)]
                assert w['target'] == [j,new]
                assert w['abelian_change'] == [list(map(int,row)) for row in M]
                old_f,old_g = local_cover(old,central)
                new_f,new_g = local_cover(target,new)
                old_kappa = central*old['characters'][2]
                new_kappa = new*chi3
                delta = coefficient_sigma(old_kappa)-det*new_kappa-qchi
                delta_u = coefficient_sigma(old_f[2])-det*new_f[2]-quad(*new_f[:2])
                delta_o = coefficient_sigma(old_g[2])-det*new_g[2]-quad(*new_g[:2])
                # Both complete central AS equations, after the UT3 automorphism.
                assert delta**5-delta == delta_o-delta_u
                original_delta = coefficient_sigma(old_kappa)-qchi
                coordinates = fixed.inverse()*vector(k,base.split(original_delta,False)[0])
                assert all(t**5 == t for t in coordinates)
                assert list(map(int,coordinates)) == w['central_difference']
                residual = vector(p,coordinates)-plane_det*p(new)*target['frame'].column(2)
                repair = target['frame'].inverse()*residual
                assert repair[2] == 0
                assert list(map(int,repair[:2])) == w['plane_repair']
                scalar_boundary = delta-repair[0]*chi1-repair[1]*chi2
                assert not any(base.split(scalar_boundary,False)[0])
        assert sorted(permutation.values()) == list(range(155))
        fixed_counts = []
        current = list(range(155))
        for power in range(4):
            fixed_counts.append(sum(current[i] == i for i in range(155)))
            current = [permutation[t] for t in current]
        assert current == list(range(155))
        assert fixed_counts == ([155,7,35,7] if caseid==0 else [155,3,7,3])
        unseen = set(range(155))
        orbits = []
        while unseen:
            first = min(unseen)
            cycle,current = [],first
            while current not in cycle:
                cycle.append(current)
                unseen.remove(current)
                current = permutation[current]
            assert current == first
            orbits.append([[i//5,i%5] for i in cycle])
        assert orbits == expected['orbits']
        assert sum(fixed_counts)//4 == len(orbits) == expected['orbit_count']
        result['orbit_checks'].append({'case':caseid,'cover_labels':155,
            'complete_local_comparisons':155,'zero_Lang_primitives':31,
            'orbits':len(orbits),'length_histogram':dict(Counter(map(len,orbits))),
            'Burnside_fixed_counts':fixed_counts,'sigma_as':[list(map(int,row)) for row in sigma]})
        records_by_case[caseid] = base,records
        save('all_central_transports_case%d_PASS'%caseid)

    def field_compare(smallpath,largepath):
        small,large = read(smallpath),read(largepath)
        K = GF(5**60,name='c',modulus=P(large['field_modulus']))
        Q = PolynomialRing(K,'t')
        roots = Q(small['field_modulus']).roots(multiplicities=False)
        assert len(roots)==12
        def value(co,r):
            ans = K(0)
            for x in reversed(co):
                ans = ans*r+K(x)
            return ans
        alpha_roots = [r for r in roots if value(small['alpha'],r) == K(large['alpha'])]
        assert len(alpha_roots)==4
        raw_pairs = [(small['alpha'],large['alpha'])]
        for key in ('chi1','chi2','kappa'):
            for aa,bb in zip(small['gluing'][key],large['gluing'][key]):
                assert set(aa)==set(bb)
                raw_pairs.extend((co,bb[e]) for e,co in aa.items())
        for name in ('affine_rhs','infinity_rhs'):
            for aa,bb in zip(small[name],large[name]):
                for A,B in zip(aa,bb):
                    assert set(A)==set(B)
                    raw_pairs.extend((co,B[e]) for e,co in A.items())
        embeddings = [r for r in alpha_roots if all(value(a,r)==K(b) for a,b in raw_pairs)]
        assert embeddings
        chosen = embeddings[0]
        large_columns = {r['column']:r for r in large['columns']}
        for row in small['columns']:
            target = large_columns[row['column']]
            assert row['monomial']==target['monomial']
            assert set(row['entries'])==set(target['entries'])
            raw_pairs.extend((co,target['entries'][i]) for i,co in row['entries'].items())
        assert all(value(a,chosen)==K(b) for a,b in raw_pairs)
        for key in ('case','plane','central','as_plane_coefficients','central_complement'):
            assert small[key]==large[key]
        result['field_transports'].append({'small':str(smallpath),'large':str(largepath),
            'columns':len(small['columns']),'coefficients':len(raw_pairs),
            'embedding_method':'roots of the actual degree12 modulus in the saved degree60 field'})
        save('independent_field_transport_PASS')

    for kind in ('hodge','deck'):
        field_compare(DATA/('heisenberg125_%s_case0_plane1_k12.json'%kind),
                      DATA/('heisenberg125_%s_case0_plane1.json'%kind))

    order = sorted(product(range(5),repeat=3),key=lambda a:(sum(a)+a[2],a))
    position = {v:i for i,v in enumerate(order)}
    for caseid,plane in ((0,1),(2,0)):
        if caseid==0:
            paths = [DATA/('heisenberg125_%s_case0_plane1_k12.json'%kind) for kind in ('hodge','deck')]
        else:
            paths = [EXTERNAL/'case2'/('plane00_central0_%s.json'%kind) for kind in ('hodge','deck')]
        hodge,deck = [read(path) for path in paths]
        for key in ('case','plane','central','field_modulus','alpha','gluing','affine_rhs','infinity_rhs'):
            assert hodge[key]==deck[key]
        assert deck['case']==caseid and deck['plane']==plane and deck['central']==0
        assert deck['field_modulus']==source['coefficient_field_modulus']
        base,records = records_by_case[caseid]
        rec = records[plane]
        def decode_base(raw):
            return sum((base.components[i]*base.B(base.L({int(e):decode(co) for e,co in aa.items()}))
                        for i,aa in enumerate(raw)),base.B(0))
        gluing = [decode_base(deck['gluing'][name]) for name in ('chi1','chi2','kappa')]
        rhs = list(map(decode_base,deck['affine_rhs']))
        opposite = list(map(decode_base,deck['infinity_rhs']))
        assert gluing==rec['characters'][:2]+[base.B(0)]
        assert tuple(rhs)==rec['f'] and tuple(opposite)==rec['g']
        u=base.u
        S0=u*(u-1)*(u-2)*(u-3)
        if caseid==0:
            assert base.R==u*(u-3)
            assert base.A==(S0*(u-alpha)**2)[4]*S0
        else:
            assert base.R==u*(u-2)
            R0=u-alpha
            polynomial=R0*S0**2
            Hasse=sum((k(comb(i,6))*polynomial[i]*u**(i-6) for i in range(6,10)),base.L(0))
            h=3*alpha
            assert (R0.derivative()*S0+2*R0*S0.derivative())(h)==0
            assert base.A==Hasse(h)*R0*(u-h)**2
        torsor = IndependentTorsor(base,rhs,gluing)
        parsed = lambda rows:{r['column']:{int(i):decode(co) for i,co in r['entries'].items()} for r in rows}
        hcols,psicols = parsed(deck['columns']),parsed(hodge['columns'])
        assert set(hcols)==set(range(750)) and set(psicols)==set(range(744,750))
        operators=[]
        for axis in (0,2):
            cols=[]
            for monomial in order:
                for b in range(6):
                    col={}
                    for i in range(monomial[axis]+1):
                        lower=list(monomial);lower[axis]=i
                        col[6*position[tuple(lower)]+b]=k(comb(monomial[axis],i))
                    cols.append(col)
            operators.append(cols)
        g,c = operators
        h = [hcols[i] for i in range(750)]
        def act(operator,v):
            out=defaultdict(lambda:k(0))
            for j,a in v.items():
                for i,b in operator[j].items():out[i]+=a*b
            return {i:a for i,a in out.items() if a}
        for j in range(750):
            v={j:k(1)}
            assert act(g,act(h,v))==act(c,act(h,act(g,v)))
            vv=v
            for _ in range(5):vv=act(h,vv)
            assert vv==v
        orbitcols=[]
        for j in range(744,750):
            vc=psicols[j]
            for _ in range(5):
                vh=vc
                for _ in range(5):
                    vg=vh
                    for _ in range(5):orbitcols.append(vg);vg=act(g,vg)
                    vh=act(h,vh)
                vc=act(c,vc)
        full=matrix(k,750,750,{(i,j):a for j,col in enumerate(orbitcols) for i,a in col.items()},
                    sparse=False,implementation='generic')
        rank=int(full.__pari__().matrank())
        assert rank==721
        entry={'case':caseid,'plane':plane,'central':0,'rank':rank,'defect':750-rank,
               'all750_deck_relations':True,'hodge_columns':[],'deck_spotchecks':[]}
        result['rank_checks'].append(entry)
        save('independent_PARI_rank_case%d_plane%d_PASS'%(caseid,plane))
        image=torsor.image('frob',(4,4,4))
        for column in range(744,750):
            leading=base.B(base.A)*base.mono(*base.basis[column%6])**5
            actual=torsor.reduce_h1(torsor.scale(image,leading))
            assert actual==psicols[column],(caseid,column)
            entry['hodge_columns'].append(column)
            save('independent_Hodge_case%d_column%d_PASS'%(caseid,column))
        for column in range(738,750):
            value=torsor.scale(torsor.image('deck',order[column//6]),base.mono(*base.basis[column%6]))
            assert torsor.reduce_h1(value)==hcols[column]
            entry['deck_spotchecks'].append(column)
        save('independent_cover_case%d_plane%d_PASS'%(caseid,plane))
    result['status']='PASS'
    save('complete')


if __name__=='__main__':
    main()
