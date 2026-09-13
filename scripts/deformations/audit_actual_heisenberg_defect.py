#!/usr/bin/env sage-python
"""Independent finite replay for the first actual Heisenberg Hodge rank.

No producer modules are imported. Base arithmetic is a nested pair of
Sage quadratic quotient rings. Torsor products accumulate ordinary
polynomial terms before reduction. Rank uses actual group elements and
PARI dense finite-field linear algebra, not augmentation sparse pivots.
"""
import argparse
from collections import defaultdict
from functools import lru_cache
from hashlib import sha256
from itertools import product
from math import comb
from pathlib import Path
import json
import time

from sage.all import GF, LaurentPolynomialRing, PolynomialRing, matrix, vector


class IndependentBase:
    def __init__(self, k, alpha, raw):
        self.k = k
        self.L = LaurentPolynomialRing(k, 'u')
        self.u = self.L.gen()
        dec = lambda co: sum((k(c)*alpha**i for i,c in enumerate(co)), k(0))
        self.R = self.L([dec(co) for co in raw['R']])
        self.A = self.L([dec(co) for co in raw['A']])
        u = self.u
        self.F = u*(u-1)*(u-2)*(u-3)*(u-alpha)
        P = PolynomialRing(k, 't')
        sq, rem = P(self.F).quo_rem(P(self.R))
        assert not rem
        self.S = self.L(sq)
        assert P(self.R).is_squarefree() and P(self.S).is_squarefree()
        assert P(self.R).gcd(P(self.S)) == 1
        K = PolynomialRing(self.L, 'kappa_symbol')
        self.K = K.quotient(K.gen()**2-self.R, names='kap')
        E = PolynomialRing(self.K, 'ell_symbol')
        self.B = E.quotient(E.gen()**2-self.S, names='ell')
        self.kap, self.ell = self.B(self.K.gen()), self.B.gen()
        self.components = (self.B(1), self.kap, self.ell, self.kap*self.ell)
        self.basis = ((3,-1),(3,-2),(3,-3),(2,-1),(1,-1),(2,-2))
        self.obasis = ((3,-1),(3,-2),(2,-1))
        self.poles = (0, int(P(self.R).degree()), int(P(self.S).degree()), 5)

    def mono(self, i, e):
        return self.components[i]*self.B(self.u**e)

    def coordinates(self, value):
        lifted = self.B(value).lift()
        return [self.L(lifted[j].lift()[i]) for j in range(2) for i in range(2)]

    def split(self, value, tangent=True):
        coords = self.coordinates(value)
        basis = self.basis if tangent else self.obasis
        cutoff = -2 if tangent else 0
        co = [coords[i][e] for i,e in basis]
        affine, infinite = self.B(0), self.B(0)
        for i,poly in enumerate(coords):
            for e,c in poly.dict().items():
                term = self.mono(i, int(e))*c
                if e >= 0:
                    affine += term
                elif 2*e+self.poles[i] <= cutoff:
                    infinite += term
        rebuilt = affine+infinite
        for (i,e), c in zip(basis,co):
            rebuilt += self.mono(i,e)*c
        assert rebuilt == value
        return co, affine, infinite


class IndependentTorsor:
    def __init__(self, base, rhs, gluing):
        self.base, self.B = base, base.B
        self.zero, self.one = self.B(0), self.B(1)
        self.order = sorted(product(range(5),repeat=3),key=lambda a:(sum(a)+a[2],a))
        self.pos = {key:i for i,key in enumerate(self.order)}
        self.units = [self.atom(tuple(int(i==j) for i in range(3))) for j in range(3)]
        x,y,z = self.units
        self.relations = [self.add(x,self.scalar(rhs[0])),
                          self.add(y,self.scalar(rhs[1])),
                          self.add(self.add(z,self.scale(y,rhs[0])),self.scalar(rhs[2]))]
        chi1,chi2,primitive = gluing
        self.transition = [self.add(x,self.scalar(-chi1)),
                           self.add(y,self.scalar(-chi2)),
                           self.add(self.add(z,self.scale(y,-chi1)),self.scalar(primitive))]
        self.deck = [x,self.add(y,self.scalar(1)),self.add(z,x)]

    def scalar(self, value):
        value = self.B(value)
        return {(0,0,0):value} if value else {}

    def atom(self, key):
        return {key:self.one}

    def add(self, left, right):
        ans = dict(left)
        for key,c in right.items():
            ans[key] = ans.get(key,self.zero)+c
            if not ans[key]:
                del ans[key]
        return ans

    def scale(self, value, factor):
        return {key:d for key,c in value.items() if (d:=c*factor)}

    @lru_cache(maxsize=None)
    def normal_monomial(self, key):
        for j in range(3):
            if key[j] >= 5:
                smaller = list(key)
                smaller[j] -= 5
                out = {}
                for increment,c in self.relations[j].items():
                    newkey = tuple(a+b for a,b in zip(smaller,increment))
                    out = self.add(out,self.scale(self.normal_monomial(newkey),c))
                return out
        return self.atom(key)

    def mul(self, left, right):
        unreduced = {}
        for key,c in left.items():
            for other,d in right.items():
                exponent = tuple(a+b for a,b in zip(key,other))
                unreduced[exponent] = unreduced.get(exponent,self.zero)+c*d
        out = {}
        for key,c in unreduced.items():
            if c:
                out = self.add(out,self.scale(self.normal_monomial(key),c))
        return out

    def power(self, value, exponent):
        out = self.scalar(1)
        for _ in range(exponent):
            out = self.mul(out,value)
        return out

    @lru_cache(maxsize=None)
    def image(self, kind, key):
        images = {'glue':self.transition,'frob':self.relations,'deck':self.deck}[kind]
        out = self.scalar(1)
        for value,e in zip(images,key):
            out = self.mul(out,self.power(value,e))
        return out

    def reduce_h1(self, value):
        rem, result = dict(value), {}
        while rem:
            key = max(rem,key=lambda a:self.pos[a])
            co,affine,tail = self.base.split(rem.pop(key))
            for j,c in enumerate(co):
                if c:
                    result[6*self.pos[key]+j] = c
            if tail:
                transition = self.image('glue',key)
                assert transition.get(key) == self.one
                correction = {a:-c*tail for a,c in transition.items() if a != key}
                assert all(self.pos[a] < self.pos[key] for a in correction)
                rem = self.add(rem,correction)
        return result


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',required=True)
    ap.add_argument('--hodge-columns',type=int,default=6)
    args = ap.parse_args()
    begin = time.monotonic()
    root = Path(__file__).resolve().parents[2]
    data = root/'Research/computations'
    deckpath = data/'heisenberg125_deck_full_case0_plane0.json'
    hodgepath = data/'heisenberg125_pilot_high.json'
    deck,hodge = [json.loads(p.read_text()) for p in (deckpath,hodgepath)]
    for key in ('case','plane','central','field_modulus','alpha','gluing','affine_rhs','infinity_rhs'):
        assert deck[key] == hodge[key]
    assert (deck['case'],deck['plane'],deck['central']) == (0,0,0)
    P = PolynomialRing(GF(5),'t')
    k = GF(5**60,name='c',modulus=P(deck['field_modulus']))
    dec = lambda co:k(list(co))
    alpha = dec(deck['alpha'])
    assert alpha**3+alpha+1 == 0
    order = sorted(product(range(5),repeat=3),key=lambda a:(sum(a)+a[2],a))
    position = {key:i for i,key in enumerate(order)}
    columns = lambda record:{r['column']:{int(i):dec(co) for i,co in r['entries'].items()}
                            for r in record['columns']}
    hs, psis = columns(deck), columns(hodge)
    assert set(hs) == set(range(750))
    result = {'status':'running','input_sha256':{
        str(p.relative_to(root)):sha256(p.read_bytes()).hexdigest() for p in (deckpath,hodgepath)},
        'hodge_columns_replayed':[], 'deck_columns_replayed':[]}

    def checkpoint(stage):
        result['seconds'] = time.monotonic()-begin
        Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
        print(json.dumps({'stage':stage,'seconds':result['seconds']}),flush=True)

    def shifted_generator(axis):
        ans = []
        for key in order:
            for j in range(6):
                out = {}
                for d in range(key[axis]+1):
                    lower = list(key)
                    lower[axis] = d
                    out[6*position[tuple(lower)]+j] = k(comb(key[axis],d))
                ans.append(out)
        return ans

    operators = [shifted_generator(0),[hs[i] for i in range(750)],shifted_generator(2)]

    def act(operator, v):
        out = defaultdict(lambda:k(0))
        for j,a in v.items():
            for i,b in operator[j].items():
                out[i] += a*b
        return {i:a for i,a in out.items() if a}

    # Build the entire image using g^a h^b c^d, not augmentation monomials.
    group_columns = []
    top = 6*position[(4,4,4)]
    for seed in range(6):
        central_image = psis[top+seed]
        for d in range(5):
            h_image = central_image
            for b in range(5):
                g_image = h_image
                for a in range(5):
                    group_columns.append(g_image)
                    g_image = act(operators[0],g_image)
                h_image = act(operators[1],h_image)
            central_image = act(operators[2],central_image)
    M = matrix(k,750,750,{(i,j):a for j,col in enumerate(group_columns) for i,a in col.items()},
               implementation='generic',sparse=False)
    rank = int(M.__pari__().matrank())
    assert rank == 713
    result['independent_group_element_PARI_rank'] = rank
    result['defect'] = 750-rank
    checkpoint('independent_full_rank_PASS')

    raw = json.loads((data/'backup_bad_double_jet_0.json').read_text())
    assert (raw['source_index'],raw['twist_index'],raw['kind']) == (4,7,'branch')
    base = IndependentBase(k,alpha,raw)
    u = base.u
    assert base.R == u*(u-3)
    S0 = u*(u-1)*(u-2)*(u-3)
    assert base.A == (S0*(u-alpha)**2)[4]*S0

    def decode_base(encoded):
        return sum((base.components[i]*base.B(sum((dec(co)*u**int(e) for e,co in part.items()),
                    base.L(0))) for i,part in enumerate(encoded)),base.B(0))

    gluing = [decode_base(deck['gluing'][name]) for name in ('chi1','chi2','kappa')]
    rhs = list(map(decode_base,deck['affine_rhs']))
    opposite = list(map(decode_base,deck['infinity_rhs']))
    chi1,chi2,primitive = gluing
    for chi,f,g in zip(gluing[:2],rhs[:2],opposite[:2]):
        assert chi**5-chi == f-g
        assert not any(base.split(chi**5-chi,tangent=False)[0])
    cross = -chi1**5*rhs[1]+opposite[0]*chi2
    assert rhs[2]+primitive**5-primitive+cross == opposite[2]
    assert matrix(k,[base.split(chi,False)[0] for chi in gluing[:2]],
                  implementation='generic').rank() == 2
    for f in rhs:
        assert base.split(f,tangent=False)[1] == f
    for g in opposite:
        assert not any(base.split(g,tangent=False)[0])
        assert all(2*e+base.poles[i] <= 0 for i,poly in enumerate(base.coordinates(g))
                   for e in poly.dict())
    result['nested_quadratic_affine_Lang_identity'] = True
    torsor = IndependentTorsor(base,rhs,gluing)
    xO,yO,zO = torsor.transition
    # Verify all three defining equations after the complete coordinate change.
    for value,f in zip((xO,yO),opposite[:2]):
        assert torsor.add(torsor.power(value,5),torsor.scale(value,-base.B(1))) == torsor.scalar(f)
    lhs = torsor.add(torsor.power(zO,5),torsor.scale(zO,-base.B(1)))
    assert lhs == torsor.add(torsor.scale(yO,opposite[0]),torsor.scalar(opposite[2]))
    result['both_chart_equations_in_independent_torsor_algebra'] = True
    checkpoint('nested_Lang_and_chart_PASS')

    # Top normal-basis norm is exact before taking cohomology.
    omega = torsor.atom((4,4,4))
    norm = omega
    for axis in (2,1,0):
        total = {}
        for t in range(5):
            images = list(torsor.units)
            if axis == 1:
                images[1] = torsor.add(images[1],torsor.scalar(t))
                images[2] = torsor.add(images[2],torsor.scale(images[0],base.B(t)))
            else:
                images[axis] = torsor.add(images[axis],torsor.scalar(t))
            shifted = {}
            for key,co in norm.items():
                val = torsor.scalar(co)
                for image,e in zip(images,key):
                    val = torsor.mul(val,torsor.power(image,e))
                shifted = torsor.add(shifted,val)
            total = torsor.add(total,shifted)
        norm = total
    assert norm == torsor.scalar(-1)
    result['exact_top_monomial_norm'] = -1
    checkpoint('independent_norm_PASS')

    for col in range(top,top+args.hodge_columns):
        bi = base.mono(*base.basis[col%6])
        leading = base.B(base.A)*bi**5
        value = torsor.scale(torsor.image('frob',(4,4,4)),leading)
        actual = torsor.reduce_h1(value)
        assert actual == psis[col],('Hodge',col)
        result['hodge_columns_replayed'].append(col)
        checkpoint('independent_Hodge_%d_PASS'%col)

    for col in (0,24,108,300,500,738,739,740,741,742,743,744,745,746,747,748,749):
        key = order[col//6]
        cochain = torsor.scale(torsor.image('deck',key),base.mono(*base.basis[col%6]))
        actual = torsor.reduce_h1(cochain)
        assert actual == hs[col],('deck',col)
        result['deck_columns_replayed'].append(col)
    checkpoint('independent_selected_deck_PASS')

    # Independently verify every recorded plane and every AS fixed basis.
    directions = json.loads((data/'backup_bad_double_cyclic_directions.json').read_text())
    small = GF(5**12,name='b',modulus=P(directions['coefficient_field_modulus']))
    da = lambda co:small(list(co))
    aa = da(directions['alpha_embedding'])
    assert aa**3+aa+1 == 0
    for case in directions['cases']:
        rawi = json.loads((data/('backup_bad_double_jet_%d.json'%case['case'])).read_text())
        bb = IndependentBase(small,aa,rawi)
        fixed = [vector(small,list(map(da,row))) for row in case['as_basis']]
        ff = matrix(small,3,3,lambda i,j:bb.split(bb.mono(*bb.obasis[j])**5,False)[0][i],
                    implementation='generic')
        assert ff.det() and matrix(small,fixed,implementation='generic').rank() == 3
        for v in fixed:
            assert ff*vector(small,[a**5 for a in v]) == v
        planes = set()
        for plane in case['planes']:
            mat = matrix(GF(5),plane['coefficient_basis'])
            assert mat.rank() == 2
            key = tuple(tuple(int(x) for x in row) for row in mat.echelon_form())
            planes.add(key)
            comp = next(vector(GF(5),[int(i==j) for i in range(3)]) for j in range(3)
                        if matrix(GF(5),list(mat)+[[int(i==j) for i in range(3)]]).rank()==3)
            assert len({tuple(int(x) for x in t*comp) for t in range(5)}) == 5
        assert len(planes) == 31
    result['all_12_AS_fixed_bases_and_372_planes'] = True
    for p in [data/'backup_bad_double_cyclic_directions.json'] + [
            data/('backup_bad_double_jet_%d.json'%i) for i in range(12)]:
        result['input_sha256'][str(p.relative_to(root))] = sha256(p.read_bytes()).hexdigest()
    result['status'] = 'PASS'
    checkpoint('complete')


if __name__ == '__main__':
    main()
