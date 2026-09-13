#!/usr/bin/env sage-python
"""Independent checks of the actual 15 resolvent models; no producer imports.

Recompute elliptic multiplication by rational group-law additions instead of
Sage's multiplication-by-five routine, and check the original map, flat twist,
potential and both complete Hodge blocks. No W4 scalar is computed here.
"""
import argparse
import hashlib
import json
from pathlib import Path
import time

from sage.all import GF, Integers, LaurentSeriesRing, PolynomialRing, matrix, prod


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--models', required=True)
    ap.add_argument('--census', help='Optional completed actual W4 first-stage outputs to audit independently')
    ap.add_argument('--output', default='Research/computations/dihedral5_family_model_independent_audit.json')
    args = ap.parse_args(); start = time.monotonic()
    directory = Path(args.models)
    primepoly = PolynomialRing(GF(5), 'T'); tt = primepoly.gen()
    k = GF(625, 't', modulus=tt**4+4*tt**3+tt**2+4*tt+3); t = k.gen()
    pol = PolynomialRing(k, 's'); s = pol.gen(); rat = pol.fraction_field()
    roots = [k(0), k(1), k(2), k(3), t]
    F = prod(s-r for r in roots)
    PC = 2*s**3+(2*t+3)*s**2+(3*t**2+3)*s+2*t**3+4*t**2+4*t+4
    h0, mu = 4*t+3, 4+4*t
    enc = lambda c: [int(k(c).polynomial()[i]) for i in range(4)]
    penc = lambda p: [enc(c) for c in pol(p)]
    decode = lambda a: pol([k(c) for c in a])
    base2 = PolynomialRing(Integers(25), 'T')
    O2 = base2.quotient(base2([3,4,1,4,1]), 'T'); T2 = O2.gen()
    sig = T2**5
    for _ in range(3): sig -= (sig**4+4*sig**3+sig**2+4*sig+3)/(4*sig**3+12*sig**2+2*sig+4)
    lift = lambda a: sum(O2(int(k(a).polynomial()[i]))*T2**i for i in range(4))
    siglift = lambda a: sum(O2(int(k(a).polynomial()[i]))*sig**i for i in range(4))
    mixpol = PolynomialRing(O2, 's'); sm = mixpol.gen()
    vseries = LaurentSeriesRing(k, 'v', default_prec=200); vv = vseries.gen()
    def infinity(r):
        num, den = r.numerator(),r.denominator()
        return (vv**(den.degree()-num.degree())*vseries(list(reversed(num.list())))/vseries(list(reversed(den.list())))).add_bigoh(150)

    def multiplication_five(cubic):
        """Pairs (x(s),v(s)) represent (x(s),y*v(s)), y²=cubic(s)."""
        a2, a4 = cubic[2], cubic[1]
        def add(P, Q, same=False):
            xp, vp = P; xq, vq = Q
            if same:
                slope = (3*xp*xp+2*a2*xp+a4)/(2*vp*cubic)
            else:
                slope = (vq-vp)/(xq-xp)
            xr = slope*slope*cubic-a2-xp-xq
            vr = -vp+slope*(xp-xr)
            assert vr*vr*cubic == cubic(xr)
            return xr, vr
        P = (rat(s), rat(1))
        P2 = add(P, P, True); P3 = add(P2, P)
        return add(P3, P2)

    def collapse_variable(f):
        def one(p):
            assert all(i % 5 == 0 for i in p.dict()), ('non-Frobenius exponent', p)
            return pol({i//5: c for i,c in p.dict().items()})
        return one(f.numerator())/one(f.denominator())

    rows = []
    for path in sorted(directory.glob('pair_*.json')):
        data = json.loads(path.read_text()); i,j = data['branch_pair']
        R = prod(s-roots[a] for a in [i,j] if a<5); S = F//R
        assert R == decode(data['resolvent_polynomial'])
        if S.degree()==3:
            cubic = S; b = None; A = None
        else:
            change = data['elliptic_change']; b = k(change['branch'])
            assert b in roots and R(b)!=0 and S(b)==0
            quartic_transformed = pol(s**4*S(b+1/s))
            A = quartic_transformed[3]
            assert A == k(change['scale']) and A!=0
            cubic = s**3+quartic_transformed[2]*s**2+A*quartic_transformed[1]*s+A**2*quartic_transformed[0]
            assert cubic(A/(s-b)) == A**2*S/(s-b)**4
        x5, y5factor = multiplication_five(cubic)
        qV = collapse_variable(x5)
        yV = collapse_variable(y5factor/cubic**2)
        source_elliptic = pol([c**5 for c in cubic])
        assert source_elliptic.gcd(source_elliptic.derivative())==1
        assert cubic(qV) == yV*yV*source_elliptic
        assert max(qV.numerator().degree(), qV.denominator().degree())==5 and qV.derivative()!=0
        if b is None:
            q_expected = qV; ellfac = yV
        else:
            q_expected = rat(b+A/qV)
            ellfac = (q_expected-b)**2*yV/A
        assert S(q_expected) == ellfac**2*source_elliptic
        q = decode(data['numerator'])/decode(data['denominator'])
        assert q == q_expected, 'Verschiebung model mismatch'
        assert max(q.numerator().degree(),q.denominator().degree())==5 and q.derivative()!=0
        G = decode(data['hyperelliptic_polynomial'])
        yfac = decode(data['y_multiplier']['numerator'])/decode(data['y_multiplier']['denominator'])
        eta = decode(data['eta_multiplier']['numerator'])/decode(data['eta_multiplier']['denominator'])
        assert G.degree()==13 and G.gcd(G.derivative())==1
        assert yfac*yfac*G == F(q)
        assert eta*yfac == q.derivative()
        # Together with degree5 and genera6->2, separability proves etaleness
        # by the nonnegative different term in Riemann--Hurwitz.
        assert 2*6-2 == 5*(2*2-2)
        AT = decode(data['hodge_multiplier']); PT = decode(data['potential'])
        assert AT == eta**4*(q-t)*(q-h0)**2/mu
        assert PT == eta**2*PC(q) - (G*eta.derivative(2)+G.derivative()*eta.derivative()/2)/(2*eta)+3*G*eta.derivative()**2/(4*eta**2)
        assert PT.degree() <= 10
        L = decode(data['double_polynomial']); K = decode(data['double_section'])
        B = decode(data['double_derivative']); muT = k(data['mu'])
        SC, rem = G.quo_rem(L); assert rem==0
        assert L.gcd(SC)==1 and L.gcd(L.derivative())==1
        assert L*K*K/muT == AT
        assert B == L*K.derivative()+L.derivative()*K/2
        assert SC*B.derivative()+SC.derivative()*B/2 == PT*K
        assert (L*K*K).gcd(SC*B*B)==1
        # Explicit square-class witness: pullback of the ORIGINAL flat double.
        twist_ratio = (q-t)/L
        twist_unit = mu/muT
        twist_square = K/(eta**2*(q-h0))
        assert twist_ratio == twist_unit*twist_square**2
        assert twist_unit != 0  # has a square root in the geometric constant field
        # Independent coefficient-by-coefficient action on 11+4 tangent basis.
        blocks=[]
        for n, mult in [(11,AT*G**2),(4,AT)]:
            blocks.append(matrix(k,n,n,lambda row,col: mult[5*(col+1)-(row+1)] if 5*(col+1)>=row+1 else 0))
        full = matrix.block_diagonal(blocks)
        stored = matrix(k,[[k(c) for c in row] for row in data['hodge_matrix']])
        assert full==stored
        ranks=[15]; it=matrix.identity(k,15)
        for r in range(8):
            it=it*full.apply_map(lambda c:c**(5**r)); ranks.append(it.rank())
        assert ranks==data['semilinear_ranks']
        if data['neutral']:
            ker=matrix(k,11,1,[k(c)**5 for c in data['kernel']])
            dual=matrix(k,1,11,[k(c) for c in data['obstruction_dual']])
            assert blocks[0]*ker==0 and dual*blocks[0]==0
            assert blocks[0].rank()==10 and blocks[1].rank()==4
            assert ranks==[15,14,13,12,11,10,9,9,9]
        # Full first-Frobenius injection: positive and negative parity blocks,
        # not merely the 11-coordinate subspace used for a particular repair.
        frob_plus=matrix(k,31,11,lambda row,col: (G**2)[5*(col+1)-(row+1)] if 5*(col+1)>=row+1 else 0)
        frob_minus=matrix(k,24,4,lambda row,col: 1 if row+1==5*(col+1) else 0)
        assert frob_plus.rank()+frob_minus.rank()==15
        row=dict(label=data['label'],neutral=data['neutral'],double_degree=int(L.degree()),
                 actual_Verschiebung_and_original_map=True,original_flat_double_squareclass=True,
                 full_first_Frobenius_rank=15,hodge_rank=int(full.rank()),
                 model_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                 squareclass_constant=enc(twist_unit))
        if args.census and data['neutral']:
            first_path=Path(args.census)/data['label']/'genus6_first_stage.json'
            first=json.loads(first_path.read_text())
            gm=mixpol([lift(a) for a in G]); gs=mixpol([siglift(a) for a in G])
            eraw=gs(sm**5)-gm**5; ecoeff=[]
            for a in eraw:
                aa=[int(a.lift()[i]) for i in range(4)]
                assert all(x%5==0 for x in aa)
                ecoeff.append(k([x//5 for x in aa]))
            E=pol(ecoeff)
            afrob=(-E*(G.derivative()**5).inverse_mod(G**3)).mod(G**3)
            bfrob, rem=(E+G.derivative()**5*afrob).quo_rem(2*G**3); assert rem==0
            zeta, rem=(s**4+afrob.derivative()).quo_rem(G**2); assert rem==0
            common,pbez,qbez=(L*K*K).xgcd(SC*B*B)
            assert common==1
            # At infinity a_O has order20-deg(A_T), while b_O has
            # order30-(13-deg(L)+2deg(B)).  These decide the unit chart.
            a_order=20-AT.degree(); b_order=30-(13-L.degree()+2*B.degree())
            assert min(a_order,b_order)==0
            if b_order==0: op_rat=L*K*pbez/(G*B); chart='b'
            else: op_rat=-B*qbez/(L*K); chart='a'
            ref_rat=2*(s**5*bfrob-afrob*G**2)/(2*G-s*G.derivative())**5
            xi_rat=sum(k(cc)*s**(6*ex)*G**(-(ex+1)//2)
                       for cc,ex in zip(first['xi_coefficients'],first['xi_exponents']))
            target=rat(muT*op_rat-ref_rat-G**2*xi_rat**5)
            expansion=infinity(target)
            assert all(expansion[j]==0 for j in range(1,32)), 'First marking extension class mismatch'
            Qu=pol(sum(expansion[j]*s**(-j) for j in range(int(expansion.valuation()),1)))
            aa=L*K*K; bb=SC*B*B; abY=G*K*B
            beta=-PT*aa*pbez*qbez-abY*pbez*qbez.derivative()+bb*pbez*qbez+abY*qbez*pbez.derivative()-aa*pbez*pbez+PT*bb*qbez*qbez
            assert muT*beta-(G*Qu.derivative()+G.derivative()*Qu/2)+zeta==0
            assert k(first['mu'])==muT
            row.update(entire_first_marking_and_flat_comparison=True,formal_oper_chart=chart,
                       formal_a_order=int(a_order),formal_b_order=int(b_order),
                       first_stage_sha256=hashlib.sha256(first_path.read_bytes()).hexdigest(),
                       first_affine_comparison=penc(Qu),first_bezout_p=penc(pbez),first_bezout_q=penc(qbez))
        rows.append(row); print(json.dumps(row),flush=True)
    assert len(rows)==15 and sum(r['neutral'] for r in rows)==14
    output=dict(status='PASS independent actual models, original twists, complete Hodge and first-Frobenius matrices',
                producer_code_imported=False,rows=rows,seconds=time.monotonic()-start,
                source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                scope='15 characteristic-five covers; no independent full W4 replay or original common-cover conclusion')
    Path(args.output).write_text(json.dumps(output,indent=2)+'\n')


if __name__=='__main__': main()
