// Continue from the already constructed residual. Frobenius makes the
// final factor supported at0,25,50, so only nine A^13 coefficients and
// three final tails are needed. This avoids156 large dense products.
#define ROOT9_RANK 12
#define ROOT9_FAST_RAT_NORMALIZE
#define ROOT9_THREAD_RATIONAL
#define ROOT9_MARKED_NO_MAIN
#include <omp.h>
#include "root9_marked_function_field_20260929.cpp"
#include "root9_fourier_20260929.hpp"
MR readmr(const ptree&row){MR x;int i=0;for(auto&[k,r]:row)x.c[i++]=ratrow(r);assert(i==12);return x;}
int main(int argc,char**argv){try{
 if(argc!=4)throw std::runtime_error("usage model.json residual.json output-prefix");F::init();FastK::init();fourier_setup();
 ptree model,rr;boost::property_tree::read_json(argv[1],model);boost::property_tree::read_json(argv[2],rr);
 std::array<FP,5>poles;int i=0;for(auto&[k,r]:model.get_child("poles"))poles[i++]=frow(r);assert(i==5);Rat::setup(FP(),poles);
 std::array<Rat,12>mod;i=0;for(auto&[k,r]:model.get_child("J_monic_H")){if(i<12)mod[i]=ratrow(r);else assert(ratrow(r)==Rat(1));i++;}MR::setup(mod);
 std::vector<MR>a(74);i=0;for(auto&[key,r]:rr.get_child("coefficients")){if(i>=67)a[140-i]=readmr(r);i++;}assert(i==141);
 auto start=std::chrono::steady_clock::now();auto a2=convolution156(a,a,74);stats("sparse_a2",a2);auto a3=convolution156(a2,a,74);stats("sparse_a3",a3);
 std::vector<MR>f5(15),f25(3);
 #pragma omp parallel for schedule(dynamic,1)
 for(int j=0;j<15;j++)f5[j]=a2[j].pow(5);
 for(int j=0;j<3;j++)f25[j]=a2[j].pow(25);
 std::array<int,9>indices{21,22,23,46,47,48,71,72,73};std::vector<MR>b(9);
 #pragma omp parallel for schedule(dynamic,1)
 for(int k=0;k<9;k++){
  int n=indices[k];for(int j=0;5*j<=n;j++)b[k]+=a3[n-5*j]*f5[j];b[k].normalize();
  #pragma omp critical
  std::cout<<"A13_COEFFICIENT "<<n<<std::endl;
 }
 std::ofstream checkpoint(std::string(argv[3])+".a13_selected.json");checkpoint<<"{\"indices\":[21,22,23,46,47,48,71,72,73],\"coefficients\":[";
 for(int j=0;j<9;j++){if(j)checkpoint<<',';save_mr(checkpoint,b[j]);}checkpoint<<"]}\n";checkpoint.close();
 std::vector<MR>tails(3);
 #pragma omp parallel for schedule(dynamic,1)
 for(int k=0;k<3;k++){tails[k]=b[6+k]*f25[0]+b[3+k]*f25[1]+b[k]*f25[2];tails[k].normalize();}
 stats("sparse_final_tails",tails);std::ofstream out(std::string(argv[3])+".tails.json");out<<"{\"raw_exponent\":63,\"scope\":\"Exact tails71..73; full-rank12 curve model, no parameter sampling\",\"tails\":[";
 for(int j=0;j<3;j++){if(j)out<<',';save_mr(out,tails[j]);}out<<"]}\n";
 std::cout<<"SPARSE_TAILS_COMPLETE seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<std::endl;
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
