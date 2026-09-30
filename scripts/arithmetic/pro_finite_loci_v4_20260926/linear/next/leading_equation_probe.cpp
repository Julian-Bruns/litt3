#include "../src/residual.hpp"
#include "io_dft.hpp"
#include "theta9.hpp"
int main(int argc,char** argv){try{
 input::init();F q=F::code(argc>1?std::stoi(argv[1]):64426),mu=F::code(argc>2?std::stoi(argv[2]):1);int NS=78;
 std::vector<Poly> ap(NS);for(auto &p:ap)p.c.resize(73);
 for(int h=0;h<73;h++){
  auto rows=read_rows("global/r9/N_H_"+std::to_string(h)+".bin",181,987);
  for(int m=0;m<NS;m++){
   F a;for(int j=180;j>=0;j--){F z;for(int l=6;l>=0;l--)z=z*mu+rows[j][l*141+140-m];a=a*q+z;}ap[m].c[h]=a;
  }
 }
 for(auto &p:ap)p.trim();Poly th=theta9(q);
 std::cout<<"q="<<q<<" mu="<<mu<<" theta degree="<<th.deg()<<"\n";
 for(int m=0;m<20;m++){auto a=ap[m];int hv=0,tv=0;while(a&&a[0]==F()){a=a.shift(-1);hv++;}while(a&&!(a%th)){a=a.exactdiv(th);tv++;}std::cout<<"A"<<m<<": H-val="<<hv<<" theta-val="<<tv<<" remaining degree="<<a.deg()<<"\n";}
 const int n=1248;F root=F::code(kfield::primitive).pow(kfield::N/n),H(1);Rows vals(n,std::vector<F>(7));
 for(int ih=0;ih<n;ih++){
  std::vector<F> a(NS);for(int m=0;m<NS;m++)a[m]=ap[m].eval(H);
  Poly A(a);auto a2=(A*A).trunc(NS),a3=(A*a2).trunc(NS);auto a10=frobenius_poly(a2,5).trunc(NS),a50=frobenius_poly(a2,25).trunc(NS);auto C=((a3*a10).trunc(NS)*a50).trunc(NS);
  for(int m=71;m<NS;m++)vals[ih][m-71]=C[m]/H.pow(567-3*m);H*=root;
 }
 auto coeff=dft(vals,root.inv());F inv=F(n).inv();
 for(int m=71;m<NS;m++){
  Poly p;p.c.resize(n);for(int j=0;j<n;j++)p.c[j]=coeff[j][m-71]*inv;p.trim();int hv=0,tv=0;int dg=p.deg();
  if(dg>756+6*m)throw std::runtime_error("degree/alias bound failed");
  while(p&&p[0]==F()){p=p.shift(-1);hv++;}while(p&&!(p%th)){p=p.exactdiv(th);tv++;}
  std::cout<<"E"<<m<<": original H-val="<<567-3*m+hv<<" theta-val="<<tv<<" remaining degree="<<p.deg()<<" (before division="<<dg<<") derivative gcd="<<gcd(p,p.deriv()).deg()<<"\n";
  std::ofstream f("next/evidence/probe_E"+std::to_string(m)+"_q"+std::to_string(q.v)+"_mu"+std::to_string(mu.v)+".json");f<<"{\"q\":"<<q<<",\"mu\":"<<mu<<",\"coefficient_index\":"<<m<<",\"H_valuation\":"<<567-3*m+hv<<",\"Theta_valuation\":"<<tv<<",\"reduced_H_coefficients\":";write_vector(f,p.c);f<<",\"scope\":\"specialized diagnostic, not a geometric exclusion\"}\n";
 }
 return 0;
}catch(std::exception& e){std::cerr<<"ERROR: "<<e.what()<<"\n";return 1;}}
