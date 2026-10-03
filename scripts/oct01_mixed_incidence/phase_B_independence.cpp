// NEW diagnostic for B-linear independence, distinct from supplied F5 input.
#include "projective_core.hpp"
using namespace proj;
static int plusB(int a,int b){return (a%5+b%5)%5+5*((a/5+b/5)%5);}
static int timesB(int a,int b){return ((a%5)*(b%5)+3*(a/5)*(b/5))%5+5*(((a%5)*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);}
static int negativeB(int a){return (5-a%5)%5+5*((5-a/5)%5);}
int main(int argc,char**argv){try{if(argc!=3)throw std::runtime_error("field and supports required");auto input=load(argv[1]);std::array<std::array<int,7>,29>cols;for(int j=0;j<29;j++){auto c=oldcode(roots[j],input);for(int i=0;i<7;i++){cols[j][i]=c%25;c/=25;}}
 std::ifstream in(argv[2]);int n,ns;bool comma=false;std::cout<<"{\"sectors\":[";while(in>>n>>ns){int bad=0,balanced_bad=0;std::vector<int> first;int first_rank=-1;for(int s=0;s<ns;s++){std::vector<int>S(n);for(int&j:S)in>>j;
 for(int augmented=0;augmented<2;augmented++){int rows=7+augmented;int A[8][6]{};for(int i=0;i<7;i++)for(int j=0;j<n;j++)A[i][j]=cols[S[j]][i];if(augmented)for(int j=0;j<n;j++)A[7][j]=1;int r=0;for(int j=0;j<n;j++){int p=r;while(p<rows&&!A[p][j])p++;if(p==rows)continue;for(int k=0;k<n;k++)std::swap(A[p][k],A[r][k]);int inv=1;while(timesB(inv,A[r][j])!=1)inv++;for(int k=j;k<n;k++)A[r][k]=timesB(inv,A[r][k]);for(int i=r+1;i<rows;i++){int c=A[i][j];for(int k=j;k<n;k++)A[i][k]=plusB(A[i][k],negativeB(timesB(c,A[r][k])));}r++;}if(r<n){if(augmented)balanced_bad++;else{bad++;if(first.empty()){first=S;first_rank=r;}}}}}
 if(comma)std::cout<<",";comma=true;std::cout<<"{\"support\":"<<n<<",\"canonical_supports\":"<<ns<<",\"B_dependent_supports\":"<<bad<<",\"balanced_B_dependent_supports\":"<<balanced_bad<<",\"first_rank\":"<<first_rank<<",\"first_support\":[";for(size_t i=0;i<first.size();i++){if(i)std::cout<<",";std::cout<<first[i];}std::cout<<"]}";}
 std::cout<<"],\"scope\":\"NEW B independence diagnostic; supplied nine-column F5 independence unchanged\"}\n";return 0;
 }catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
