// Divide out exact powers of specified chart lines. The dividend remains
// unchanged unless every polynomial coefficient has zero remainder.
#include "degree140_trace_engine_20260929.hpp"
#include <fstream>
#include <array>
using namespace exact;
int main(int argc,char**argv){try{
 if(argc<6)throw std::runtime_error("usage: strip FIELD INPUT nh nq OUTPUT [H|q native_root]...");
 loadfield(argv[1]);int nh=std::stoi(argv[3]),nq=std::stoi(argv[4]);std::vector<F>a(size_t(nh)*nq);
 {std::ifstream f(argv[2],std::ios::binary);f.read((char*)a.data(),4*a.size());if(!f)throw std::runtime_error("truncated bivariate input");}
 std::vector<std::array<int,3>> removed;
 for(int k=6;k<argc;k+=2){if(k+1==argc)throw std::runtime_error("missing root");bool axis=std::string(argv[k])=="q";F root=std::stoi(argv[k+1]);int n=axis?nq:nh,other=axis?nh:nq;
  auto at=[&](int i,int j)->F&{return axis?a[size_t(j)*nq+i]:a[size_t(i)*nq+j];};
  int upper=n;
  // Determine an upper bound from one nonzero coefficient polynomial.
  for(int j=other-1;j>=0;j--){Poly p(n);for(int i=0;i<n;i++)p[i]=at(i,j);p.trim();if(p.empty())continue;
   upper=0;while(p.deg()>0){Poly qq(p.deg());F carry=p.back();qq.back()=carry;for(int i=p.deg()-1;i>=1;i--){carry=add(p[i],mul(root,carry));qq[i-1]=carry;}F rem=add(p[0],mul(root,carry));if(rem)break;p=std::move(qq);p.trim();upper++;}break;
  }
  int power=0;std::vector<F>next(a.size());
  while(power<upper){bool exact=true;std::fill(next.begin(),next.end(),0);
   for(int j=0;j<other&&exact;j++){
    F carry=at(n-1,j);for(int i=n-2;i>=0;i--){size_t idx=axis?size_t(j)*nq+i:size_t(i)*nq+j;next[idx]=carry;carry=add(at(i,j),mul(root,carry));}if(carry)exact=false;
   }
   if(!exact)break;a.swap(next);power++;
  }
  removed.push_back({int(axis),int(root),power});std::cerr<<(axis?'q':'H')<<' '<<root<<" power "<<power<<'\n';
 }
 int dh=-1,dq=-1;size_t terms=0;for(int h=0;h<nh;h++)for(int q=0;q<nq;q++)if(a[size_t(h)*nq+q]){dh=std::max(dh,h);dq=std::max(dq,q);terms++;}
 std::string out=argv[5];{std::ofstream f(out+".bin",std::ios::binary);for(int h=0;h<=dh;h++)f.write((char*)&a[size_t(h)*nq],4*(dq+1));}
 std::ofstream js(out+".json");js<<"{\"grid\":["<<dh+1<<','<<dq+1<<"],\"degrees\":["<<dh<<','<<dq<<"],\"terms\":"<<terms<<",\"exact_line_divisions\":[";
 for(size_t i=0;i<removed.size();i++){if(i)js<<',';js<<"{\"axis\":\""<<(removed[i][0]?'q':'H')<<"\",\"root\":"<<removed[i][1]<<",\"power\":"<<removed[i][2]<<'}';}js<<"]}\n";
 std::cerr<<"remaining degrees "<<dh<<','<<dq<<" terms "<<terms<<'\n';
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
