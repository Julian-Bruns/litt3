#define main eliminate_main
#include "eliminate.cpp"
#undef main
#include "jets.hpp"
#include <omp.h>
#include <bit>
static_assert(sizeof(F)==4&&std::endian::native==std::endian::little);
std::array<FP,5> read_certificate(const std::string&path){
 std::ifstream f(path,std::ios::binary);if(!f)throw std::runtime_error("missing global certificate");char magic[8];uint32_t version,count;f.read(magic,8);f.read(reinterpret_cast<char*>(&version),4);f.read(reinterpret_cast<char*>(&count),4);assert(std::string(magic,8)=="CMP140C1"&&version==1&&count==5);
 std::array<FP,5>rows;for(auto&p:rows){uint64_t n;f.read(reinterpret_cast<char*>(&n),8);assert(n>0&&n<3000000);p.c.resize(n);f.read(reinterpret_cast<char*>(p.c.data()),n*sizeof(F));assert(f&&p.c.back());for(F v:p.c)assert(v.v<F::N);}assert(f.peek()==EOF);return rows;
}
int main(int argc,char**argv){try{assert(argc==2);std::string root=argv[1];F::init();FastK::init();omp_set_num_threads(2);auto ts=std::chrono::steady_clock::now();auto r=read_certificate(root+"/data/global_unit_certificate.bin");auto meta=read(root+"/data/global_unit_certificate.json"),bounds=read(root+"/data/projection_bounds.json"),fibres=read(root+"/data/fibre_certificates.json");
 int idx=0;for(auto&[k,z]:meta.get_child("degrees"))assert(r[idx++].deg()==z.get_value<int>());assert(idx==5&&r[4]==FP(1));auto units=licensed_units(root);std::array<FP,2>red{r[0],r[1]};int nf=0;
 for(auto&[k,z]:meta.get_child("unit_factors")){FP f=poly(z.get_child("polynomial"));assert(std::find(units.begin(),units.end(),f)!=units.end());int pair=0;for(auto&[s,e]:z.get_child("orders")){int n=e.get_value<int>(),p=1;assert(n>=0);while(n){for(int d=0;d<n%5;d++){auto[q,rem]=frobenius_divide(red[pair],f,p);assert(!rem);red[pair]=std::move(q);}n/=5;p*=5;}pair++;}assert(pair==2);nf++;}
 idx=0;for(auto&[k,z]:meta.get_child("reduced_degrees"))assert(red[idx++].deg()==z.get_value<int>());assert(idx==2);
 FP left,right;
 #pragma omp parallel sections
 {
 #pragma omp section
 left=r[2]*red[0];
 #pragma omp section
 right=r[3]*red[1];
 }
 assert(left+right==FP(1));std::cout<<"{\"global_polynomial_Bezout\":\"PASS\",\"licensed_factor_exact_divisions\":"<<nf<<",\"G\":[1]}"<<std::endl;
 // Independent archived source fibres check the projection normalization.
 jet_order=1;using J=Jet<F>;
 for(unsigned q0:{1,2}){F q(q0),expected(1);int ns=0;for(auto&[k,z]:fibres)if(z.get<unsigned>("q")==q0){FP f=poly(z.get_child("C71")),g=poly(z.get_child("C72"));std::vector<J>a,b;for(F v:f.c)a.emplace_back(v);for(F v:g.c)b.emplace_back(v);expected*=resultant_jet(Poly<J>(a),Poly<J>(b),53,54).c[0];ns++;}assert(ns==2);
  for(auto&[k,z]:bounds.get_child("places")){FP f=poly(z.get_child("modulus"));int v=z.get_child("norm_resultant_valuation_bounds").begin()->second.get_value<int>();assert(v<=0);expected*=f.eval(q).pow(-v);}assert(r[0].eval(q)==expected&&expected);std::cout<<"{\"source_fibre_projection_check_q\":"<<q0<<",\"both_sheets\":\"PASS\"}"<<std::endl;
 }
 std::cout<<"{\"global_unit_certificate\":\"PASS\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-ts).count()<<"}"<<std::endl;return 0;
 }catch(std::exception&e){std::cerr<<"ERROR "<<e.what()<<std::endl;return 1;}}
