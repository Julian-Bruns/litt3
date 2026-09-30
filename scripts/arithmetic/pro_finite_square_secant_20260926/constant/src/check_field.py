from exact import *
import platform,subprocess

def run():
 factors=[2,3,13,313]
 cert={'field_size':QFIELD,'field_generator_code':GENERATOR,'generator_order':ORDER,'prime_divisors_of_order':factors,'proper_power_residues':{str(p):power(alpha,ORDER//p) for p in factors},'full_power':power(alpha,ORDER),'prime_field_minimal_polynomial_ascending':[2,2,4,2,0,0,1,0,1]}
 assert GENERATOR==alpha==25
 assert cert['full_power']==1 and all(c!=1 for c in cert['proper_power_residues'].values())
 assert len(set(EXP[:ORDER]))==ORDER and 0 not in EXP[:ORDER]
 assert peval([5,2,6,7,1],alpha)==0
 assert peval(cert['prime_field_minimal_polynomial_ascending'],alpha)==0
 assert peval(A,alpha)==0 and pmul(pscale([neg(alpha),1],13),t)==A
 assert peval(A1,QEX)==0 and QEX!=1 and peval(A0,QEX)!=0
 assert EPS and ETA and CD and PSISCALE
 (ROOT/'evidence/field_certificate.json').write_text(json.dumps(cert,indent=2)+'\n')
 print(json.dumps(cert,sort_keys=True))

if __name__=='__main__':run()
