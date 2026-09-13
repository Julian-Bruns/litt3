// Independent exhaustive (3^4,4^3,4^3) branch-cycle census, degree 12.
// Compile: c++ -std=c++17 -O2 verify_triangle344_monodromy.cpp -o /tmp/triangle344
// Abstract monodromy ONLY. The geometric use is proved separately.
#include <array>
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <iostream>
#include <map>
#include <stdexcept>
#include <unordered_set>
#include <vector>

using P=std::array<unsigned char,12>;
using U=std::uint64_t;
P id(){P p{}; for(int i=0;i<12;++i)p[i]=i; return p;}
P mul(const P&a,const P&b){P p{};for(int i=0;i<12;++i)p[i]=a[b[i]];return p;}
P inv(const P&a){P p{};for(int i=0;i<12;++i)p[a[i]]=i;return p;}
U code(const P&p){U z=0;for(int i=0;i<12;++i)z|=U(p[i])<<(4*i);return z;}
P decode(U z){P p{};for(int i=0;i<12;++i)p[i]=(z>>(4*i))&15;return p;}
void need(bool x,const char*s){if(!x)throw std::runtime_error(s);}
bool uniform4(const P&p){
    unsigned seen=0;
    for(int i=0;i<12;++i)if(!(seen&(1u<<i))){
        int j=i,n=0;do{seen|=1u<<j;++n;j=p[j];}while(j!=i);
        if(n!=4)return false;
    }return true;
}
bool transitive(const P&a,const P&b){
    unsigned seen=1;std::vector<int> q{0};
    for(std::size_t i=0;i<q.size();++i)
        for(int j:{int(a[q[i]]),int(b[q[i]])})
            if(!(seen&(1u<<j))){seen|=1u<<j;q.push_back(j);}
    return seen==4095;
}
std::size_t group_order(const P&a,const P&b){
    std::unordered_set<U> seen{code(id())};std::vector<P> q{id()};
    for(std::size_t i=0;i<q.size();++i)for(const P&h:{a,b}){
        auto z=mul(h,q[i]);if(seen.insert(code(z)).second)q.push_back(z);
    }return seen.size();
}
unsigned image_mask(unsigned mask,const P&p){
    unsigned z=0;for(int i=0;i<12;++i)if(mask&(1u<<i))z|=1u<<p[i];return z;
}
int block_cycle_count(const std::vector<unsigned>&blocks,const P&p){
    std::vector<int> perm;
    for(unsigned B:blocks){
        auto it=std::find(blocks.begin(),blocks.end(),image_mask(B,p));
        need(it!=blocks.end(),"block system is not preserved");
        perm.push_back(int(it-blocks.begin()));
    }
    unsigned seen=0;int count=0;
    for(int i=0;i<int(blocks.size());++i)if(!(seen&(1u<<i))){
        ++count;int j=i;do{seen|=1u<<j;j=perm[j];}while(j!=i);
    }
    return count;
}
// A size-two block system is an ACTUAL intermediate degree-two cover.
// It is elliptic exactly when the three quotient permutations have
// altogether six cycles (Riemann--Hurwitz for the degree-six quotient).
std::vector<unsigned> elliptic_pair_blocks(const P&a,const P&b){
    for(int partner=1;partner<12;++partner){
        std::vector<unsigned> blocks{1u|(1u<<partner)};bool ok=true;
        for(std::size_t i=0;i<blocks.size()&&ok;++i)for(const P&p:{a,b}){
            unsigned z=image_mask(blocks[i],p);
            if(std::find(blocks.begin(),blocks.end(),z)!=blocks.end())continue;
            if(std::any_of(blocks.begin(),blocks.end(),[z](unsigned B){return bool(B&z);})){
                ok=false;break;
            }
            blocks.push_back(z);
        }
        if(!ok||blocks.size()!=6)continue;
        int count=block_cycle_count(blocks,a)+block_cycle_count(blocks,b)
                 +block_cycle_count(blocks,inv(mul(a,b)));
        if(count==6)return blocks;
    }
    return {};
}
void enumerate(P&b,unsigned used,const P&a,std::uint64_t&total,
               std::unordered_set<U>&solutions){
    if(used==4095){
        ++total;
        if(uniform4(mul(a,b))&&transitive(a,b))solutions.insert(code(b));
        return;
    }
    int i=0;while(used&(1u<<i))++i;
    unsigned u=used|(1u<<i);
    // Put the smallest unused letter first: every disjoint 4-cycle
    // decomposition is visited exactly once, with all 3! orientations.
    for(int j=0;j<12;++j)if(!(u&(1u<<j)))
    for(int k=0;k<12;++k)if(k!=j&&!(u&(1u<<k)))
    for(int l=0;l<12;++l)if(l!=j&&l!=k&&!(u&(1u<<l))){
        b[i]=j;b[j]=k;b[k]=l;b[l]=i;
        enumerate(b,u|(1u<<j)|(1u<<k)|(1u<<l),a,total,solutions);
    }
}
int main(){
    auto start=std::chrono::steady_clock::now();
    P a=id(),b=id();for(int i=0;i<12;++i)a[i]=3*(i/3)+(i+1)%3;
    std::unordered_set<U> unseen;std::uint64_t total=0;
    enumerate(b,0,a,total,unseen);
    need(total==1247400,"incomplete 4^3 enumeration");
    auto good=unseen.size();need(good==11178,"unexpected transitive count");
    std::vector<P> central;
    for(int block=0;block<4;++block){
        P p=id();for(int j=0;j<3;++j)p[3*block+j]=3*block+(j+1)%3;
        central.push_back(p);
    }
    for(int block=0;block<3;++block){
        P p=id();for(int j=0;j<3;++j)std::swap(p[3*block+j],p[3*(block+1)+j]);
        central.push_back(p);
    }
    for(const auto&h:central)need(mul(a,h)==mul(h,a),"centralizer generator");
    // These generate C3 wr S4, the full centralizer of a, of order 1944.
    std::map<std::pair<std::size_t,std::size_t>,int> hist;
    std::size_t classes=0,elliptic576=0;
    while(!unseen.empty()){
        auto seed=*std::min_element(unseen.begin(),unseen.end());
        std::unordered_set<U> orbit{seed};std::vector<U> q{seed};
        for(std::size_t i=0;i<q.size();++i)for(const auto&h:central){
            U z=code(mul(mul(h,decode(q[i])),inv(h)));
            if(orbit.insert(z).second)q.push_back(z);
        }
        for(U z:orbit)need(unseen.erase(z)==1,"orbit escaped remaining solutions");
        need(1944%orbit.size()==0,"orbit-stabilizer failed");
        const P rep=decode(seed);
        auto order=group_order(a,rep),deck=1944/orbit.size();
        if(order==576){
            auto blocks=elliptic_pair_blocks(a,rep);
            need(!blocks.empty(),"order576 cover lacks its degree-two elliptic quotient");
            ++elliptic576;
            std::cout<<"Elliptic quotient certificate b=[";
            for(int i=0;i<12;++i)std::cout<<(i?",":"")<<int(rep[i])+1;
            std::cout<<"] pair_blocks=";
            for(unsigned B:blocks){
                std::cout<<"{";bool first=true;
                for(int i=0;i<12;++i)if(B&(1u<<i)){
                    std::cout<<(first?"":",")<<i+1;first=false;
                }
                std::cout<<"}";
            }
            std::cout<<" quotient_genus=1\n";
        }
        ++hist[{order,deck}];++classes;
    }
    std::map<std::pair<std::size_t,std::size_t>,int> expected{
        {{12,12},1},{{24,2},1},{{36,6},1},{{96,2},1},
        {{576,2},3},{{1320,1},1},{{15552,1},2}};
    need(hist==expected,"group histogram differs from independent GAP result");
    need(elliptic576==3,"not all three order576 elliptic quotients checked");
    std::cout<<"4^3 permutations: "<<total<<"\nTransitive valid pairs: "<<good
             <<"\nConjugacy classes: "<<classes<<"\n";
    for(auto [key,count]:hist)
        std::cout<<"group_order="<<key.first<<" deck="<<key.second<<" classes="<<count<<"\n";
    std::cout<<"PASS complete census AND all three degree-two elliptic quotients\nseconds="
             <<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"\n";
}
