// Focused controls for the transferred on-X pole-gap circuit.
#define ROOT9_RANK 12
#define ROOT9_FAST_RAT_NORMALIZE
#define ROOT9_THREAD_RATIONAL
#define ROOT9_MARKED_NO_MAIN
#include <omp.h>
#include "root9_marked_function_field_20260929.cpp"
#include "root9_curve_square_gaps_20260929.hpp"
int main(int argc,char**argv){try{
 if(argc!=3)throw std::runtime_error("usage source-root output-directory");init(argv[1]);FastK::init();
 Rat::setup(FP(0),{FP(std::vector<F>{0,1}),FP(std::vector<F>{1,1}),FP(std::vector<F>{2,1}),FP(std::vector<F>{3,1}),FP(std::vector<F>{4,1})});
 std::array<Rat,12>mod{};MR::setup(mod);
 for(F q0:{F(1),F(2),F(25)}){
  MR q(q0);Curve<MR>::PQ=basepoly<MR>(PP).scale(q.inverse());Curve<MR>s;
  for(int j=0;j<3;j++){int bound=(70-10*j)/3;for(int i=0;i<=bound;i++)s.c[j].c.push_back(MR(F(10+7*i+31*j)));}
  auto square=s*s;std::string pref=std::string(argv[2])+"/square_"+std::to_string(q0.v);
  curve_square_gaps(square,q,pref);ptree saved;boost::property_tree::read_json(pref+".curve_gaps.json",saved);
  for(auto&[k,row]:saved.get_child("rows"))for(auto&[k,c]:row)assert(!ratrow(c));
  square.c[0].c[29]+=MR(1);pref+="_negative";curve_square_gaps(square,q,pref);
  boost::property_tree::read_json(pref+".curve_gaps.json",saved);bool nonzero=false;for(auto&[k,c]:saved.get_child("rows").begin()->second)if(ratrow(c))nonzero=true;assert(nonzero);
  std::cout<<"KNOWN_SQUARE_AND_FIRST_GAP_CONTROL_PASS q="<<q0.v<<std::endl;
 }
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
