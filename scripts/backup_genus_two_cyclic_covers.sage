#!/usr/bin/env sage
"""Bounded exact Cartier tests for the backup curve's cyclic3/6 covers.

Use the COMPLETE40-point cubic-torsion norm algebra, not a sampled field.
For z^3=v-A and eta=du/v the two extra holomorphic forms are z*eta
and U*eta/z. Cartier of A*du vanishes because deg(A)<=3. Thus both
Cartier arrows are nonzero iff [u^14]((F+A^2)*F^2) is nonzero.
Optional six-torsion translates reuse each of the15 branch-pair classes.
The script reports a bad locus if found; it never assumes ordinarity.
"""
import argparse
import itertools
import json
import time
from pathlib import Path
from cysignals.alarm import alarm,cancel_alarm


def run(include_six,seconds,output):
    started=time.monotonic();root=Path(__file__).resolve().parents[1]
    data=json.loads((root/'Research/computations/backup_genus_two_torsion.json').read_text())
    k=GF(125,name='a',modulus=PolynomialRing(GF(5),'x')([1,1,0,1]));a=k.gen()
    R=PolynomialRing(k,'l');l=R.gen()
    decode=lambda cs:sum((k(v)*a**j for j,v in enumerate(cs)),k.zero())
    aspoly=lambda cs:R([decode(c) for c in cs])
    q=aspoly(data['separator_coefficients']);A=R.quotient(q,names='lam');lam=A.gen()
    inv=lambda c:A(A(c).lift().inverse_mod(q))
    S=PolynomialRing(A,'u');u=S.gen()
    F=u*(u-1)*(u-2)*(u-3)*(u-a)
    r=A(aspoly(data['r_coefficients']));s=A(aspoly(data['s_coefficients']))
    U=u**2+r*u+s
    B=S([A(aspoly(cs)) for cs in data['B_coefficients_as_polynomials_in_lambda']])
    assert B**2-lam*F==U**3
    encode=lambda f:[[int(v) for v in c.polynomial().list()] for c in R(f).list()]
    def check(poly,denominator_U):
        coefficients=[(poly*F**2)[5*j+4] for j in range(3)]
        gamma=coefficients[2]
        assert coefficients==[gamma*denominator_U[j]**5 for j in range(3)]
        gcd,s0,t0=q.xgcd(gamma.lift())
        assert s0*q+t0*gamma.lift()==gcd
        return {'Cartier_scalar_fifth_power':encode(gamma.lift()),
                'bad_norm_locus_degree':int(gcd.degree()),'bad_norm_locus':encode(gcd),
                'bezout_q_multiplier':encode(s0),'bezout_scalar_multiplier':encode(t0)}
    out={'status':'cyclic cover Cartier calculation in progress',
         'field_modulus':[1,1,0,1],
         'cyclic3':check(2*F+inv(lam)*U**3,U),'cyclic6_translates':[]}
    assert q.degree()==40
    out['cyclic3']['total_connected_covers']=40
    out['cyclic3']['all_ordinary']=out['cyclic3']['bad_norm_locus_degree']==0
    target=Path(output);target.parent.mkdir(parents=True,exist_ok=True)
    def checkpoint():
        out['elapsed_seconds']=time.monotonic()-started
        temp=Path(str(target)+'.tmp');temp.write_text(json.dumps(out,indent=1,default=int)+'\n');temp.replace(target)
    def mul(x,y):return (x[0]*y[0]+lam*F*x[1]*y[1],x[0]*y[1]+x[1]*y[0])
    def power(x,n):
        ans=(S.one(),S.zero())
        while n:
            if n%2:ans=mul(ans,x)
            x=mul(x,x);n//=2
        return ans
    try:
        alarm(seconds)
        if include_six:
            branches=[k(0),k(1),k(2),k(3),a]
            V=B%U
            for size in [1,2]:
              for subset in itertools.combinations(branches,int(size)):
                E=prod(u-b for b in subset);H=E%U;h0,h1=H[0],H[1]
                determinant=h0*(h0-r*h1)+s*h1**2
                w0=((h0-r*h1)*V[0]+s*h1*V[1])*inv(determinant)
                w1=(-h1*V[0]+h0*V[1])*inv(determinant)
                W=E*(w0+w1*u)
                assert (W-B)%U==0 and W%E==0
                newU,rem=(F-inv(lam)*W**2).quo_rem(U*E)
                assert not rem and newU.degree()==2
                newU*=inv(newU[2])
                numerator=mul(power((-W,S.one()),6),power((B,S.one()),2))
                denominator=U**6*E**3
                components=[]
                for part in numerator:
                    quotient,rem=part.quo_rem(denominator)
                    assert not rem;components.append(inv(lam)**2*quotient)
                even,odd=components
                assert even.degree()==6 and odd.degree()<=3
                norm=even**2-lam*F*odd**2
                inv(norm[12]);assert norm==norm[12]*newU**6
                row=check(even,newU)
                row['two_torsion_branch_subset']=[[int(v) for v in b.polynomial().list()] for b in subset]
                out['cyclic6_translates'].append(row);checkpoint()
                print('six-torsion translate',len(out['cyclic6_translates']),
                      'bad degree',row['bad_norm_locus_degree'],'seconds',time.monotonic()-started,flush=True)
            assert len(out['cyclic6_translates'])==15
            doubles=json.loads((root/'Research/computations/backup_genus_two_double_covers.json').read_text())
            assert len(doubles['covers'])==15 and all(row['etale_double_cover_ordinary'] for row in doubles['covers'])
            out['cyclic6_total_exact_order6_connected_covers']=600
            out['cyclic6_bad_primitive_character_pairs']=sum(row['bad_norm_locus_degree'] for row in out['cyclic6_translates'])
            out['all_cyclic6_covers_ordinary']=(out['cyclic3']['all_ordinary'] and out['cyclic6_bad_primitive_character_pairs']==0)
        out['status']='complete exact finite cyclic-cover Cartier test; author computation'
    except (AlarmInterrupt,KeyboardInterrupt) as exc:
        out['status']='bounded cyclic-cover test incomplete';out['interruption']=type(exc).__name__
    finally:
        cancel_alarm();checkpoint()
    print(json.dumps({'output':str(target),'status':out['status'],
                      'cyclic3_bad':out['cyclic3']['bad_norm_locus_degree'],
                      'six_translates_completed':len(out['cyclic6_translates']),
                      'elapsed_seconds':out['elapsed_seconds']},indent=1,default=int),flush=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--include-six',action='store_true')
    parser.add_argument('--seconds',type=int,default=60)
    parser.add_argument('--output',required=True)
    args=parser.parse_args();run(args.include_six,args.seconds,args.output)
