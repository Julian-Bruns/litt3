// Checks the stored algebraic identities directly, without recomputing
// the resultant or the Euclidean/Krylov construction of the certificates.
#define main quotient_generator_main
#include "quotient.cpp"
#undef main
YPoly readypoly(istream&in){int n;in>>n;YPoly a(n+1);for(Poly&p:a)p=readpoly(in);ytrim(a);return a;}
Poly ordinary_power(Poly a,int n){Poly z={1};while(n){if(n&1)z=mul(z,a);a=mul(a,a);n>>=1;}return z;}
int main(int argc,char**argv){try{
 if(argc!=2){throw runtime_error("usage: check_certificates DATA_DIRECTORY");}init();string d=argv[1];
 ifstream inp(d+"/signature_polys.txt"),clean(d+"/signature_clean.txt"),raw(d+"/signature_resultant.txt"),partner(d+"/signature_partner.txt"),bez(d+"/signature_partner.txt.bezout"),subfield(d+"/scalar_subfield_certificate.txt");
 if(!inp||!clean||!raw||!partner||!bez||!subfield)throw runtime_error("missing certificate file");
 Poly Jn=readpoly(inp),Jd=readpoly(inp),Kn=readpoly(inp),Kd=readpoly(inp),N=readpoly(clean),Res=readpoly(raw);
 Poly P={11,22,18,5,19,20,15,16,9,22,1},A={1,21,14,22,13},Ap=derivative(A),bad=mul(mul(P,A),Ap);
 assert(N.size()==313&&N.back()==1&&gcd(N,derivative(N))==Poly{1}&&gcd(N,bad)==Poly{1});
 Poly fact=mul(mul(ordinary_power(monic(A),9),ordinary_power(P,39)),ordinary_power(monic(Ap),64));
 assert(mul(fact,N)==monic(Res));cout<<"resultant factorization and saturation identity: PASS\n";
 modpoly=N;Poly phi=readpoly(partner),r=readpoly(partner),M=readpoly(partner),psi=readpoly(partner),x={0,1};
 YPoly p=pairpoly(Jn,Jd),q=pairpoly(Kn,Kd),s=readypoly(bez),t=readypoly(bez);
 assert(yadd(ymul(s,p),ymul(t,q))==YPoly({neg(phi),Poly{1}}));
 assert(yeval(p,phi).empty()&&yeval(q,phi).empty());
 assert(eval(phi,phi)==x);inverse(sub(phi,x));inverse(eval(bad,phi));
 cout<<"linear-gcd Bezout identity; partner substitution; no diagonal/boundary: PASS\n";
 Poly expected_r=mm(mm(power(mm(eval(P,phi),inverse(P)),26),power(mm(eval(Ap,phi),inverse(Ap)),39)),power(mm(A,inverse(eval(A,phi))),87));
 assert(r==expected_r&&mm(r,eval(r,phi))==Poly{1});
 assert(eval(psi,r)==x);assert(M.size()==313&&M.back()==1&&gcd(M,derivative(M))==Poly{1});assert(eval(M,r).empty());
 inverse(sub(r,Poly{1}));inverse(add(r,Poly{1}));
 cout<<"scalar formula; inverse primitive element; degree-312 annihilator: PASS\n";
 modpoly=M;Poly rem=readpoly(subfield),inv=readpoly(subfield),z=x;
 for(int i=0;i<56;i++){z=power(z,5);}assert(rem==sub(z,x)&&mm(rem,inv)==Poly{1});
 cout<<"finite-subfield exclusion unit identity: PASS\n";return 0;
 }catch(const exception&e){cerr<<"ERROR: "<<e.what()<<'\n';return 1;}}
