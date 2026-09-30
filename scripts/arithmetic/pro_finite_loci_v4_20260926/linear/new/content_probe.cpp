// Executed compression diagnostic, NOT a square-locus test.
// The gcd of a subset of H,mu,x coefficient polynomials in q gives an
// upper bound for the q-only content of the entire global residual.
#define main unused_interpolation_main
#include "global_interpolate.cpp"
#undef main
Poly gcdp(Poly a,Poly b){while(b){auto r=a.divrem(b).second;a=b;b=r;}return a?a*a.c.back().inv():a;}
int main(int argc,char**argv){try{
 if(argc!=3)throw std::runtime_error("usage: content_probe ROOT_CODE GENERATED_DIR");
 input::init();int rr=std::stoi(argv[1]);if(std::find(input::roots.begin(),input::roots.end(),rr)==input::roots.end())throw std::runtime_error("unknown root code");
 fs::path dir=argv[2];Poly g;int used=0;
 for(int h=0;h<=72;h++){
  auto rows=read_rows(dir/("N_H_"+std::to_string(h)+".bin"),181,NC);
  for(int col=0;col<NC;col++){
   std::vector<F>a;for(auto&row:rows)a.push_back(row[col]);Poly p(a);
   if(p){g=gcdp(g,p);used++;}
   if(g.deg()==0)break;
  }
  if(g.deg()==0)break;
 }
 std::cout<<"r="<<rr<<" q_content_gcd_degree="<<g.deg()<<" nonzero_coefficient_polynomials_used="<<used<<" gcd_coefficients=";
 for(auto c:g.c)std::cout<<c<<",";
 std::cout<<" No square test or ratio exclusion.\n";
 return 0;
 }catch(std::exception&e){std::cerr<<"ERROR: "<<e.what()<<"\n";return 1;}}
