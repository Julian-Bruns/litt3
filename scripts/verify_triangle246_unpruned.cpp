// Independent UNPRUNED first-encounter census for (2^12,4^6,6^4).
// No partial-cycle tests, group database, or saved representative list.
// c++ -std=c++17 -O2 scripts/verify_triangle246_unpruned.cpp -o /tmp/triangle246
// Emits JSON; verify_triangle246_monodromy.py --native /tmp/triangle246
// compares EVERY canonical representative, not merely the count.
#include <algorithm>
#include <array>
#include <chrono>
#include <cstdint>
#include <iostream>
#include <set>
#include <stdexcept>

constexpr int N=24;
using P=std::array<int,N>;
P a;
std::set<P> representatives;
std::uint64_t nodes=0, completed=0, rooted=0;
int b(int i){return 4*(i/4)+(i+1)%4;}
void need(bool x){if(!x)throw std::runtime_error("census assertion");}

P rooted_code(int root){
    P old{}, label{}, out{};label.fill(-1);int used=0;
    auto add=[&](int j){for(int k=0;k<4;++k){
        need(label[j]<0);old[used]=j;label[j]=used++;j=b(j);
    }};
    add(root);
    for(int i=0;i<used;++i){
        int j=a[old[i]];if(label[j]<0)add(j);out[i]=label[j];
    }
    need(used==N);return out;
}

void dfs(int used){
    ++nodes;int i=0;while(i<N&&a[i]>=0)++i;
    if(i==N){
        ++completed;unsigned seen=0;
        for(int v=0;v<N;++v)if(!(seen&(1u<<v))){
            int j=v,len=0;do{seen|=1u<<j;++len;j=b(a[j]);}while(j!=v);
            if(len!=6)return;
        }
        ++rooted;P code=rooted_code(0);
        for(int v=1;v<N;++v)code=std::min(code,rooted_code(v));
        representatives.insert(code);return;
    }
    // An exhausted component cannot reconnect; connected maps only.
    if(i>=used)return;
    for(int j=i+1;j<used;++j)if(a[j]<0){
        a[i]=j;a[j]=i;dfs(used);a[i]=a[j]=-1;
    }
    if(used<N){
        a[i]=used;a[used]=i;dfs(used+4);a[i]=a[used]=-1;
    }
}

int main(){
    const auto start=std::chrono::steady_clock::now();a.fill(-1);dfs(4);
    need(rooted==339&&representatives.size()==40);
    std::cout<<"{\"nodes\":"<<nodes<<",\"completed\":"<<completed
             <<",\"rooted\":"<<rooted<<",\"representatives\":[";
    bool first=true;for(const P&p:representatives){
        std::cout<<(first?"":",")<<"[";first=false;
        for(int i=0;i<N;++i)std::cout<<(i?",":"")<<p[i];std::cout<<"]";
    }
    std::cout<<"],\"seconds\":"
      <<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()
      <<"}\n";
}
