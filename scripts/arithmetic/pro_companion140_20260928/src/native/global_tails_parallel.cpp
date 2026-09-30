#define main companion_main
#include "companion.cpp"
#undef main
#include <omp.h>
int main(int argc,char**argv){
 try{
  assert(argc==5);init(argv[1]);setup_rational();std::string input=argv[2],output=argv[3];int threads=std::stoi(argv[4]);omp_set_num_threads(threads);
  FastK::init();for(int k=0;k<5;k++)Rat::fpow(k,k==4?400:1200);Rat::frozen_powers=true;
  auto data=readjson(input);std::vector<Poly<Rat>>a;for(auto&[s,v]:data.get_child("normalized_reciprocal_T0_to_T73"))a.push_back(ratpoly(v));assert(a.size()==74&&a[0]==Poly<Rat>(1));
  auto start=std::chrono::steady_clock::now();std::vector<Poly<Rat>>a2(74),a3(74),ta(74);
  std::cout<<"{\"parallel_tail_threads\":"<<threads<<"}"<<std::endl;
  #pragma omp parallel for schedule(dynamic,1)
  for(int n=0;n<74;n++){
   for(int i=0;i<=n/2;i++){auto p=a[i]*a[n-i];if(2*i!=n)p=p.scale(Rat(2));a2[n]+=p;}normalize_poly(a2[n]);
   if(n%10==0){
    #pragma omp critical
    std::cout<<"{\"global_a2_completed_index\":"<<n<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
   }
  }
  {std::ofstream o(output+".a2.json");json(o,a2);o<<'\n';}
  #pragma omp parallel for schedule(dynamic,1)
  for(int n=0;n<74;n++)if(n%5>=1&&n%5<=3){
   for(int i=0;i<=n;i++)a3[n]+=a2[i]*a[n-i];normalize_poly(a3[n]);
   if(n%10==3){
    #pragma omp critical
    std::cout<<"{\"global_a3_completed_index\":"<<n<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
   }
  }
  {std::ofstream o(output+".a3.json");json(o,a3);o<<'\n';}
  std::vector<Poly<Rat>>f5,f25;for(int i=0;i<=14;i++)f5.push_back(a2[i].fifth());for(int i=0;i<=2;i++)f25.push_back(a2[i].fifth().fifth());
  #pragma omp parallel for schedule(dynamic,1)
  for(int n=71;n<=73;n++){
   for(int j=0;25*j<=n;j++)for(int i=0;5*i+25*j<=n;i++)ta[n]+=(a3[n-25*j-5*i]*f5[i])*f25[j];normalize_poly(ta[n]);assert(ta[n].deg()<=3*n/4);
   int ma=-1,mb=-1;std::array<int,5>md{};for(auto&v:ta[n].c){ma=std::max(ma,v.a.deg());mb=std::max(mb,v.b.deg());for(int k=0;k<5;k++)md[k]=std::max(md[k],v.den[k]);}
   #pragma omp critical
   {std::cout<<"{\"global_tail\":"<<n<<",\"mu_degree\":"<<ta[n].deg()<<",\"max_q_a_b_degrees\":["<<ma<<','<<mb<<"],\"den\":[";for(int k=0;k<5;k++){if(k)std::cout<<',';std::cout<<md[k];}std::cout<<"],\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;}
  }
  auto expected=readjson("data/sample_tails.json");F q0(SAMPLE.get<unsigned>("q")),x0(SAMPLE.get<unsigned>("xi"));
  for(int n=71;n<=73;n++){auto ep=frow(expected.get_child("C"+std::to_string(n)));for(int j=0;j<=54;j++)assert(ta[n][j].eval(q0,x0)==ep[j]);}
  std::ofstream o(output);o<<"{\"poles\":[";for(int k=0;k<5;k++){if(k)o<<',';json(o,Rat::factors[k]);}o<<"],\"C71\":";json(o,ta[71]);o<<",\"C72\":";json(o,ta[72]);o<<",\"C73\":";json(o,ta[73]);o<<"}\n";
  std::cout<<"{\"global_tail_model\":\"PASS\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
 }catch(std::exception&e){std::cerr<<"ERROR "<<e.what()<<std::endl;return 1;}
}
