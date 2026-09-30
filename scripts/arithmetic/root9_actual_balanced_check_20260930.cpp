// Focused check of newly reconstructed root-nine trace coefficients.
// Compares the global balanced equations against fresh infinity residues.
#include "root9_actual_trace_residues_20260930.hpp"
#include <array>
#include <fstream>
using namespace exact;
struct Term {int h,q;F c;};
using Coeff=std::vector<Term>;
F psi_value(F H,F q){
 F a=eval(Poly{350365,93449},q),b=eval(Poly{90885,339126,362701,194731,371097,144818},q);
 F c=eval(Poly{56518,278019,104390,351083,235630,246647,217983},q);
 F e=eval(Poly{324104,260238,219737,136154,199269,240524,27757,108951,319279},q);
 return add(add(mul(a,mul(power(H,3),power(q,2))),mul(b,mul(power(H,2),q))),add(mul(c,H),e));
}
F signed_power(F a,int n){return n<0?inv(power(a,-n)):power(a,n);}
int main(int argc,char**argv){try{
 if(argc!=5)throw std::runtime_error("usage: check FIELD SOURCE BALANCED_TEXT DENOMINATOR_TEXT");
 loadfield(argv[1]);root9trace::load(argv[2]);infinitytrace::CAP=200;
 std::ifstream in(argv[3]);int nr,nt;in>>nr>>nt;std::vector<std::vector<Coeff>> rows(nr);
 std::vector<F> cv(390625);for(int i=1;i<390625;i++)cv[i]=add(i%5,mul(25,cv[i/5]));
 for(auto&row:rows){int n;in>>n;row.resize(n);for(auto&cc:row){int m;in>>m;cc.resize(m);for(auto&t:cc){int code;in>>t.h>>t.q>>code;t.c=cv.at(code);}}}
 std::ifstream den(argv[4]);std::vector<std::array<int,4>> ds(nr);for(auto&d:ds)for(auto&n:d)den>>n;
 if(!in||!den)throw std::runtime_error("incomplete balanced input");
 int checks=0;
 for(auto[H,w]:std::vector<std::pair<F,F>>{{30101,1107},{32003,1301}}){
  F q=power(w,3),ps=psi_value(H,q),D=eval(Poly{189890,9731},q);
  if(!H||!q||!ps||!D)throw std::runtime_error("selected off-grid point is not in chart");
  auto pp=root9residue::profiles(mul(H,w),w,{{0,0},{1,0},{2,0},{3,0}},1);
  F change=mul(power(H,3),inv(mul(power(q,7),mul(power(ps,3),power(D,3)))));
  for(int j=0;j<nr;j++){
   F common=mul(signed_power(H,ds[j][0]),mul(signed_power(q,ds[j][1]),mul(signed_power(ps,ds[j][2]),signed_power(D,ds[j][3]))));
   for(int n=0;n<int(rows[j].size());n++){
    F got=0;for(auto&t:rows[j][n])got=add(got,mul(t.c,mul(power(H,t.h),power(q,t.q))));
    F want=mul(pp[j].coef(n),mul(power(w,n+1),mul(power(change,n),common)));
    if(got!=want){std::cerr<<H<<' '<<w<<' '<<j<<' '<<n<<' '<<got<<' '<<want<<'\n';throw std::runtime_error("balanced residue mismatch");}
    checks++;
   }
  }
 }
 std::cout<<"{\"status\":\"pass\",\"fresh_off_grid_points\":2,\"coefficient_checks\":"<<checks<<",\"comparison\":\"compressed balanced equations versus new residue expansions\"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
