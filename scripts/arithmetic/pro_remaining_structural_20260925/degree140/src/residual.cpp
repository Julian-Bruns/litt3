#include "fast.hpp"
using namespace exact;
// Fixed-degree resultant Res_Z(F_lambda,d), from the exact quadratic identity
// proved in REPORT.md. Returns lambda coefficients of degrees 0,1,2.
std::array<Curve,3> rescoeff(const Curve&H2,const Curve&H3,const Curve&H4,const Curve&H5,const Poly&Q,const Poly&t,const Poly&v){
 Curve a=cscale(H2,3),b=cscale(H3,2),c=H4;
 Curve a2=cpow(a,2),a3=cmul(a2,a),a5=cfrob5(a),a7=cmul(a5,a2),a10=cmul(a5,a5);
 Curve b2=cpow(b,2),b3=cmul(b2,b),b4=cmul(b2,b2),b5=cfrob5(b),b10=cmul(b5,b5);
 Curve c2=cpow(c,2),c3=cmul(c2,c),c4=cmul(c2,c2),c5=cfrob5(c);
 Curve delta=cadd(b2,cmul(a,c)),delta4=cpow(delta,4);
 Curve Tb=csub(cscale(cxmul(a5,Q),2),b5);
 Curve Hb=csub(cadd(cscale(cmul(a2,H5),2),b3),cmul(cmul(a,b),c));
 Curve R=cadd(csub(cxmul(a5,ppow(Q,2)),cxmul(b5,Q)),c5);
 Curve S=cadd(cadd(csub(cadd(cmul(a2,cpow(H5,2)),cmul(b3,H5)),cmul(cmul(cmul(a,b),c),H5)),cscale(cmul(b2,c2),2)),cmul(a,c3));
 Curve K=cadd(cadd(cadd(cadd(cmul(b4,c2),cscale(cmul(cmul(a,b2),c3),4)),cmul(a2,c4)),cscale(cmul(b5,H5),3)),cscale(cxmul(cmul(a3,Hb),Q),2));
 Curve L=cadd(cpow(Tb,2),cfrob5(delta));
 Curve q0={Poly{},ppow(t,3)*ppow(baseP,3),Poly{}};
 Curve s0=cmul(a3,cadd(cadd(cmul(R,S),cscale(cmul(csub(cmul(Tb,Hb),delta4),q0),3)),cmul(a7,cpow(q0,2))));
 Curve s1=cscale(cxmul(cadd(cmul(R,K),cmul(q0,L)),v),3);
 Curve s2=cxmul(cpow(R,2),ppow(v,2));
 return {s0,s1,s2};
}
Poly readpoly(std::istream&i){int n;i>>n;Poly p(n);for(auto&x:p)i>>x;p.trim();return p;}
int main(int argc,char**argv){try{
 if(argc!=4){std::cerr<<"usage residual FIELD_DATA INPUT.txt OUTPUT.json\n";return 2;}
 loadfield(argv[1]);std::ifstream f(argv[2]);if(!f)throw std::runtime_error("missing input");
 baseP=readpoly(f);Poly Q=readpoly(f),t=readpoly(f),v=readpoly(f);std::array<Curve,4>H;
 for(auto&h:H)for(auto&p:h)p=readpoly(f);
 auto rs=rescoeff(H[0],H[1],H[2],H[3],Q,t,v);auto N=normBi(rs);Poly den=ppow(baseP,40)*ppow(t,15)*ppow(v,3);
 std::ofstream o(argv[3]);o<<"{\"lambda_coefficients\":[";
 for(size_t j=0;j<N.size();j++){
  // The independent x-degree bound is 594 < 1024. Divide each coefficient
  // of the formal parameter separately, never across Kronecker blocks.
  Poly quotient;const int stride=1024;
  for(int block=0;block*stride<=N[j].deg();block++){
   int start=block*stride,end=std::min((block+1)*stride,(int)N[j].size());
   Poly pp(std::vector<F>(N[j].begin()+start,N[j].begin()+end));pp.trim();
   auto qr=divmod(pp,den);
   if(!qr.second.empty())throw std::runtime_error("nonpolynomial residual in lambda/parameter block");
   if(!qr.first.empty()){quotient.resize(start+qr.first.size());for(size_t i=0;i<qr.first.size();i++)quotient[start+i]=qr.first[i];}
  }
  quotient.trim();if(j)o<<',';jsonpoly(o,quotient);std::cerr<<"lambda^"<<j<<" encoded residual degree "<<quotient.deg()<<'\n';
 }
 o<<"],\"resultant_coefficients\":[";
 for(int j=0;j<3;j++){if(j)o<<',';o<<'[';for(int k=0;k<3;k++){if(k)o<<',';jsonpoly(o,rs[j][k]);}o<<']';}o<<"]}\n";
 return 0;
 }catch(const std::exception&e){std::cerr<<"ERROR "<<e.what()<<'\n';return 1;}}
