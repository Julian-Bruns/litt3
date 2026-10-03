// New bounded diagnostic: is the C/U bilinear ratio of norm one?
#define main retained_boundary_scan_main
#include "wg_coefficient_boundary_scan.cpp"
#undef main
int main(int argc,char**argv){try{
 if(argc!=3)throw std::runtime_error("usage: wg_norm_diagnostic field supports");
 load(argv[1]);std::ifstream in(argv[2]);int n,ns;
 std::uint64_t total=0,count=0;std::cout<<"{\"samples\":[";
 while(in>>n>>ns){auto pats=patterns(n);for(int si=0;si<ns;si++){
 std::array<int,6>S{};for(int j=0;j<n;j++)in>>S[j];
 for(auto ep:pats){for(auto&p:ep)for(int&j:p)j=S[j];
 auto C=row(ep,0),U=row(ep,1);K left=mul(C[1],U[3]),right=mul(C[2],U[2]);
 if(left.zero()||right.zero())throw std::runtime_error("zero source unit");
 if(norm(left)==norm(right)){if(count<12){if(count)std::cout<<",";endpoint_json(ep);}count++;}total++;
 }}}
 std::cout<<"],\"sources\":"<<total<<",\"norm_one_ratio_sources\":"<<count
 <<",\"scope\":\"diagnostic only; no open-incidence decision\"}\n";
 return 0;
 }catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
