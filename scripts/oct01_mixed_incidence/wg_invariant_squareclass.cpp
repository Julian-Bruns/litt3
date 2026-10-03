// Bounded conceptual check: does the new minor have a uniform square-class?
#define main retained_boundary_scan_main
#include "wg_coefficient_boundary_scan.cpp"
#undef main
int main(int argc,char**argv){try{if(argc!=3)throw std::runtime_error("usage: squareclass field supports");load(argv[1]);std::ifstream in(argv[2]);int n,ns;std::uint64_t total=0,counts[3][2]={{0,0},{0,0},{0,0}};bool comma=false;std::cout<<"{\"sectors\":[";
 while(in>>n>>ns){auto pats=patterns(n);std::uint64_t local[3][2]={{0,0},{0,0},{0,0}};for(int si=0;si<ns;si++){std::array<int,6>S{};for(int j=0;j<n;j++)in>>S[j];for(auto temp:pats){Ep ep=temp;for(auto&p:ep)for(int&j:p)j=S[j];auto C=row(ep,0),U=row(ep,1);K left=mul(C[1],U[3]),right=mul(C[2],U[2]);int nl=norm(left),nr=norm(right);if(nl==LZERO||nr==LZERO)throw std::runtime_error("full source coordinate vanished");int parity=(nl+nr)%2;int category=2;for(int i=0;i<4;i++)for(int j=i+1;j<4;j++)if(ep[i]==ep[j])category=j-i==2?0:1;local[category][parity]++;counts[category][parity]++;total++;}}
 if(comma)std::cout<<",";comma=true;std::cout<<"{\"support\":"<<n<<",\"square_nonsquare_by_opposite_adjacent_fourdistinct\":[";for(int k=0;k<3;k++){if(k)std::cout<<",";std::cout<<"["<<local[k][0]<<","<<local[k][1]<<"]";}std::cout<<"]}";}
 std::cout<<"],\"sources\":"<<total<<",\"square_nonsquare_by_opposite_adjacent_fourdistinct\":[";for(int k=0;k<3;k++){if(k)std::cout<<",";std::cout<<"["<<counts[k][0]<<","<<counts[k][1]<<"]";}std::cout<<"],\"scope\":\"square-class diagnostic only; no extra exclusion\"}\n";
 }catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
