#include "residual.hpp"
int main(){try{input::init();for(int ir=0;ir<10;ir++){
 auto c=cramer(reconstruct(F::code(input::roots[ir])));F H=F::code(31),w=F::code(101);auto s=evaluate_source(c,H,w);if(w.pow(3)==F::code(input::qr[ir]))throw std::runtime_error("sample at removed coefficient boundary");F f6=numeric_F6(s);if(!f6)throw std::runtime_error("sample F6 zero");
 auto begin=std::chrono::steady_clock::now();auto R=residual(s,F::code(c.r));
 {
  auto orig=universal_quadratic(F(3)*s.g[0],F(2)*s.g[1],s.g[2],s.g[3],Curve(input::Q),Curve::mon(0,1)*P.pow(3)*input::t.pow(3),input::x-Poly(F::code(c.r)));
  Curve g2=s.g[0].divide_y(2),g3=(s.g[1]-F(3)*s.g[0]*input::B0).divide_y(3);
  Curve g4=(s.g[2]-F(2)*s.g[1]*input::B0+F(3)*s.g[0]*input::B0.pow(2)).divide_y(4);
  Curve g5=(s.g[3]-s.g[2]*input::B0+s.g[1]*input::B0.pow(2)-s.g[0]*input::B0.pow(3)).divide_y(5);
  Curve qb=Curve::mon(0,1)*(input::Q-input::B0.pow(5)).exactdiv(P.pow(2));
  auto bar=universal_quadratic(F(3)*g2,F(2)*g3,g4,g5,qb,Curve(input::t.pow(3)),input::x-Poly(F::code(c.r)));
  Curve y40=Curve::mon(0,1)*P.pow(13);
  for(int j=0;j<3;j++)if(orig[j]!=bar[j]*y40)throw std::runtime_error("unbarred/barred fixed-resultant identity");
 }double tr=std::chrono::duration<double>(std::chrono::steady_clock::now()-begin).count();
 if(R.c.size()!=7||R.c[0].deg()!=140)throw std::runtime_error("residual degree");
 F lead=(F(3)*(H*w).pow(3)*input::eps.pow(8)*f6).pow(3);
 if(R.c[0][140]!=lead)throw std::runtime_error("residual leading coefficient");
 for(size_t j=1;j<R.c.size();j++)if(R.c[j].deg()>=140)throw std::runtime_error("lambda-dependent leading coefficient");
 std::cout<<"r="<<c.r<<" residual degrees in x by lambda=";for(auto a:R.c)std::cout<<a.deg()<<",";std::cout<<" construction seconds="<<tr<<std::endl;
 begin=std::chrono::steady_clock::now();auto eq=complete_square_equations(R);double ts=std::chrono::duration<double>(std::chrono::steady_clock::now()-begin).count();
 auto [gg,aa,bb]=xgcd(eq[0],eq[1]);if(aa*eq[0]+bb*eq[1]!=gg)throw std::runtime_error("Bezout check");
 Poly g;for(auto a:eq)g=gcd(g,a);
 std::cout<<"  all 70 square equations generated; degrees=";for(int i=0;i<8;i++)std::cout<<eq[i].deg()<<",";std::cout<<" gcd_first2_degree="<<gg.deg()<<" gcd_all70_degree="<<g.deg()<<" circuit seconds="<<ts<<std::endl;
 std::ofstream out("evidence/sample_"+std::to_string(c.r)+".json");out<<"{\"r\":"<<c.r<<",\"H\":"<<H<<",\"w\":"<<w<<",\"q\":"<<w.pow(3)<<",\"F6\":"<<f6<<",\"R_lambda_rows\":[";
 for(size_t j=0;j<R.c.size();j++){if(j)out<<",";write_vector(out,R.c[j].c);}out<<"],\"G_point\":";write_source(out,s);out<<",\"square_equations_lambda\":[";for(size_t j=0;j<eq.size();j++){if(j)out<<",";write_vector(out,eq[j].c);}out<<"],\"first2_gcd\":";write_vector(out,gg.c);out<<",\"first2_bezout\":[";write_vector(out,aa.c);out<<",";write_vector(out,bb.c);out<<"],\"all70_gcd\":";write_vector(out,g.c);out<<"}\n";
 }}catch(const std::exception& e){std::cerr<<"FAIL "<<e.what()<<"\n";return 1;}}
