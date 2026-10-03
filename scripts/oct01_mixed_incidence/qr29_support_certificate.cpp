// Exact extended quinary QR-code support certificate, using PSL2(29).
// Source preparation only until a bounded one-core run is authorized.
// All arithmetic for ranks is over F5. No mixed incidence is decided.
#include <algorithm>
#include <array>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <numeric>
#include <stdexcept>
#include <unordered_set>
#include <unordered_map>
#include <vector>

using Mask=std::uint32_t;
constexpr Mask ALL=(Mask(1)<<29)-1;
std::array<int,30> necklace{};
std::array<int,29> chi{},inv29{};
std::vector<int> squares;
std::unordered_set<Mask> affine;
std::uint64_t necklaces_count=0;

int mod29(int x){x%=29;return x<0?x+29:x;}
int mod5(int x){x%=5;return x<0?x+5:x;}
std::vector<int> points(Mask s){
    std::vector<int> out;
    while(s){int j=__builtin_ctz(s);out.push_back(j);s&=s-1;}
    return out;
}
Mask canonical(Mask s){
    Mask best=ALL;
    auto pp=points(s);
    for(int a:squares){
        Mask v=0;for(int j:pp)v|=Mask(1)<<((a*j)%29);
        for(int b=0;b<29;b++){
            best=std::min(best,v);
            v=((v<<1)&ALL)|(v>>28);
        }
    }
    return best;
}
void generate(int t,int p,int ones){
    if(ones>10 || ones+30-t<10)return;
    if(t==30){
        if(29%p==0 && ones==10){
            Mask s=0;for(int j=1;j<=29;j++)if(necklace[j])s|=Mask(1)<<(j-1);
            affine.insert(canonical(s));necklaces_count++;
        }
        return;
    }
    necklace[t]=necklace[t-p];generate(t+1,p,ones+necklace[t]);
    for(int j=necklace[t-p]+1;j<=1;j++){necklace[t]=j;generate(t+1,t,ones+j);}
}
struct DSU{
    std::vector<int> p;
    explicit DSU(int n):p(n){std::iota(p.begin(),p.end(),0);}
    int find(int x){while(p[x]!=x){p[x]=p[p[x]];x=p[x];}return x;}
    void join(int a,int b){a=find(a);b=find(b);if(a!=b)p[std::max(a,b)]=std::min(a,b);}
};

std::array<std::array<int,30>,30> parity{};
std::vector<int> pivot_rows(Mask s){
    auto col=points(s);col.push_back(29);
    if(col.size()!=11)throw std::runtime_error("not an11-support");
    std::array<std::array<int,11>,30> rows{};
    std::array<int,30> labels{};std::iota(labels.begin(),labels.end(),0);
    for(int i=0;i<30;i++)for(int j=0;j<11;j++)rows[i][j]=parity[i][col[j]];
    std::vector<int> selected;int rank=0;
    const int inv5[]={0,1,3,2,4};
    for(int j=0;j<11;j++){
        int k=rank;while(k<30 && rows[k][j]==0)k++;
        if(k==30)throw std::runtime_error("DEPENDENT11-SUPPORT");
        std::swap(rows[k],rows[rank]);std::swap(labels[k],labels[rank]);
        selected.push_back(labels[rank]);
        int scale=inv5[rows[rank][j]];
        for(int l=j;l<11;l++)rows[rank][l]=mod5(rows[rank][l]*scale);
        for(int i=rank+1;i<30;i++){
            int q=rows[i][j];
            for(int l=j;l<11;l++)rows[i][l]=mod5(rows[i][l]-q*rows[rank][l]);
        }
        rank++;
    }
    return selected;
}

int main(int argc,char**argv){try{
    if(argc!=2)throw std::runtime_error("usage: qr29_support_certificate certificate.csv");
    for(int j=1;j<29;j++)chi[j]=-1;
    for(int j=1;j<29;j++)chi[j*j%29]=1;
    for(int j=1;j<29;j++){
        if(chi[j]==1)squares.push_back(j);
        for(int k=1;k<29;k++)if(j*k%29==1)inv29[j]=k;
    }
    for(int i=0;i<30;i++)for(int j=0;j<30;j++){
        int q=i==j?0:(i==29||j==29?1:chi[mod29(i-j)]);
        parity[i][j]=mod5(q+(i==j?2:0));
    }
    // Verify P^2=4I literally, independent of the rank certificate.
    for(int i=0;i<30;i++)for(int j=0;j<30;j++){
        int sum=0;
        for(int k=0;k<30;k++){
            int a=mod5(parity[i][k]-(i==k?2:0));
            int b=mod5(parity[k][j]-(k==j?2:0));sum+=a*b;
        }
        if(mod5(sum)!=(i==j?4:0))throw std::runtime_error("conference square");
    }
    generate(1,1,0);
    if(necklaces_count!=690690 || affine.size()!=49478)throw std::runtime_error("affine coverage count");
    std::vector<Mask> reps(affine.begin(),affine.end());std::sort(reps.begin(),reps.end());
    std::unordered_map<Mask,int> index;
    for(int i=0;i<(int)reps.size();i++)index[reps[i]]=i;
    DSU dsu(reps.size());std::uint64_t edges=0;
    for(int i=0;i<(int)reps.size();i++){
        auto pp=points(reps[i]);
        for(int p:pp){
            Mask result=1; // infinity maps to zero; p maps to infinity.
            for(int j:pp)if(j!=p)result|=Mask(1)<<mod29(-inv29[mod29(j-p)]);
            Mask can=canonical(result);auto it=index.find(can);
            if(it==index.end())throw std::runtime_error("missing orbit edge");
            dsu.join(i,it->second);edges++;
        }
    }
    std::unordered_map<int,std::vector<int>> groups;
    for(int i=0;i<(int)reps.size();i++)groups[dsu.find(i)].push_back(i);
    if(groups.size()!=4628 || edges!=494780)throw std::runtime_error("PSL coverage count");
    std::vector<int> roots;for(auto&g:groups)roots.push_back(g.first);std::sort(roots.begin(),roots.end());
    std::ofstream out(argv[1]);if(!out)throw std::runtime_error("certificate output");
    out<<"finite_mask,affine_classes,pivot_rows\n";
    int free=0,reflection=0;
    for(int root:roots){
        auto piv=pivot_rows(reps[root]);int n=groups[root].size();
        if(n==11)free++;else if(n==6)reflection++;else throw std::runtime_error("unexpected stabilizer");
        out<<reps[root]<<","<<n<<",";
        for(int j=0;j<11;j++)out<<(j?" ":"")<<piv[j];out<<"\n";
    }
    if(free!=4342 || reflection!=286)throw std::runtime_error("stabilizer count");
    out.close();
    std::cout<<"{\"status\":\"PASS\",\"binary_necklaces\":"<<necklaces_count
      <<",\"affine_support_orbits\":"<<reps.size()<<",\"PSL_support_orbits\":"<<groups.size()
      <<",\"orbit_edges\":"<<edges<<",\"free_support_orbits\":"<<free
      <<",\"involution_support_orbits\":"<<reflection
      <<",\"independent_column_count\":11,\"extended_minimum_distance_lower_bound\":12"
      <<",\"scope\":\"exact finite extended QR-code support check only; no mixed incidence decision\"}\n";
    return 0;
}catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
