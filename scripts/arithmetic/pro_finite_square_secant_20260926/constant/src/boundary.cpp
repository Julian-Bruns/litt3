// Reuse the exact sparse arithmetic and resultant; no full residual norm is needed.
#define main expansion_driver_main
#include "expand.cpp"
#undef main

void jsonpoly(std::ostream&o,const Poly&p){o<<"[";for(size_t i=0;i<p.size();i++){if(i)o<<",";o<<"["<<Qexp(p[i].m)<<","<<X(p[i].m)<<","<<p[i].c<<"]";}o<<"]";}
Poly pick_mu(const Poly&p,int mu){Poly r;for(auto&t:p){if(M(t.m)!=mu)throw std::runtime_error("unexpected boundary character/scale term");if(H(t.m))throw std::runtime_error("unexpected H exponent");r.push_back({t.m-SM*mu,t.c});}return r;}
void verify_lc(const Poly&p,int deg,int q,E c){if(bounds(p).x!=deg)throw std::runtime_error("wrong x-degree");Poly a;for(auto&t:p)if(X(t.m)==deg)a.push_back(t);if(a.size()!=1||a[0].m!=key(deg,0,0,q)||a[0].c!=c)throw std::runtime_error("leading coefficient mismatch");}
int main(int argc,char**argv){try{
 if(argc!=2)throw std::runtime_error("usage: boundary ROOT");std::string root=argv[1];ff::init();
 std::ifstream input(root+"/evidence/normalized_sources.dat");std::array<Curve,6>src;
 for(int k=0;k<6;k++){int n;input>>n;for(int i=0;i<n;i++){int h,q,y,x;E c;input>>h>>q>>y>>x>>c;if(h>1)throw std::runtime_error("source not affine H");if((k<4&&h==1)||(k>=4&&h==0))src[k][y].push_back({key(x,0,0,q),c});}for(auto&p:src[k])std::sort(p.begin(),p.end(),[](auto&a,auto&b){return a.m<b.m;});}
 E pc[]={11,22,18,5,19,20,15,16,9,22,1};for(int i=0;i<11;i++)if(pc[i])Ppoly.push_back({i,pc[i]});Dpoly=shift(Ppoly,-SQ);
 Curve r=critical(cscale(src[0],3),cscale(src[1],2),src[2],src[3],src[4],Curve{});
 Poly C0=pick_mu(r[0],1),C1=pick_mu(r[1],2),C2=pick_mu(r[2],0);
 verify_lc(C0,52,7,30692);verify_lc(C1,46,7,12);verify_lc(C2,48,8,22593);
 Poly td=powp(shift(src[5][0],-3*SQ),5);std::vector<E>dv(bounds(td).x+1,0);for(auto&t:td)dv[X(t.m)]=t.c;
 Poly AA=shift(exact_div_x(times(powp(C2,3),powp(Ppoly,2)),dv),-17*SQ);
 Poly BB=exact_div_x(minus(shift(powp(C0,3),-15*SQ),scale(shift(times(times(times(C0,C1),C2),Ppoly),-16*SQ),3)),dv);
 Poly CC=shift(exact_div_x(times(powp(C1,3),Ppoly),dv),-16*SQ);
 verify_lc(AA,119,7,53870);verify_lc(BB,111,6,292517);verify_lc(CC,103,5,4);
 stats("A(H^36)",AA);stats("B(H^33 mu^3)",BB);stats("C(H^30 mu^6)",CC);
 std::ofstream o(root+"/evidence/infinity_boundary.json");o<<"{\"status\":\"exact polynomial identities checked\",\"monomial_format\":[\"q exponent\",\"x exponent\",\"K code\"],\"total_H_mu_degree\":36,\"mu_degree_bound\":6,\"C0\":";jsonpoly(o,C0);o<<",\"C1\":";jsonpoly(o,C1);o<<",\"C2\":";jsonpoly(o,C2);o<<",\"A\":";jsonpoly(o,AA);o<<",\"B\":";jsonpoly(o,BB);o<<",\"C\":";jsonpoly(o,CC);o<<",\"degrees\":[119,111,103],\"leading_terms\":[[7,119,53870],[6,111,292517],[5,103,4]]}\n";
 std::cout<<"PASS: all three leading coefficients are monomials in nonzero q; no exceptional q was inverted."<<std::endl;
 }catch(const std::exception&e){std::cerr<<"ERROR: "<<e.what()<<std::endl;return 1;}return 0;}
