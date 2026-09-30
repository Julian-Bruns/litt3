// Focused comparison of the new function-field model with the full source.
#define ROOT9_MARKED_NO_MAIN
#include "root9_marked_function_field_20260929.cpp"

template<class T>T eval_rat_json(const ptree&r,T q,const std::vector<FP>&poles){T z=at(frow(r.get_child("a")),q),den=1;assert(!frow(r.get_child("b")));int j=0;for(auto&[k,v]:r.get_child("den"))den*=at(poles[j++],q).pow(v.get_value<int>());return z/den;}
int main(int argc,char**argv){try{
 if(argc<5)throw std::runtime_error("usage source-root marked-curve residual tails");init(argv[1]);ptree d,r,t;boost::property_tree::read_json(argv[2],d);boost::property_tree::read_json(argv[3],r);boost::property_tree::read_json(argv[4],t);std::vector<FP>poles;for(auto&[k,v]:r.get_child("poles"))poles.push_back(frow(v));
 for(F q0:{F(2),F(3),F(25)}){
  std::vector<F>m;for(auto&[k,v]:d.get_child("J_monic_H"))m.push_back(frow(v.get_child("numerator")).eval(q0)/frow(v.get_child("denominator")).eval(q0));E::setmod(FP(m));E H(FP(std::vector<F>{0,1})),q(q0),u=H*q;
  E mu=-at(frow(d.get_child("A_H")),H)/at(frow(d.get_child("B_H")),H);auto full=actual_residual(q,u,false);Poly<E>value;E pow=1;for(auto&f:full){value+=f.scale(pow);pow*=mu;}
  int i=0;bool ok=true;for(auto&[k,row]:r.get_child("coefficients")){if(i>=67){E z;int j=0;for(auto&[k,c]:row)z+=eval_rat_json(c,q,poles)*H.pow(j++);if(z!=value[i]){std::cout<<"MISMATCH q="<<q0.v<<" x="<<i<<" expected=";json(std::cout,value[i]);std::cout<<" actual=";json(std::cout,z);std::cout<<std::endl;ok=false;}}i++;}assert(i==141);if(!ok)return 4;
  const int N=74;std::vector<Poly<E>>a(N);for(int k=0;k<N;k++)a[k]=Poly<E>(value[140-k]);auto a2=sermul(a,a,N),a3=sermul(a2,a,N);auto a63=sermul(sermul(a3,serfrob(a2,5,N),N),serfrob(a2,25,N),N);
  int n=71;for(auto&[k,row]:t.get_child("tails")){E z;int j=0;for(auto&[k,c]:row)z+=eval_rat_json(c,q,poles)*H.pow(j++);assert(a63[n++]==Poly<E>(z));}
  std::cout<<"{\"q_code\":"<<q0.v<<",\"full_source_coefficients_checked\":74,\"raw_tails_checked\":3,\"all_six_H_sheets\":true,\"status\":\"PASS\"}"<<std::endl;
 }
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
