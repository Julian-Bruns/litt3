// Complete transitive permutation tables for a uniform triangle profile.
// Generalization of the retained (2,3,m) first-encounter enumerator.
// Columns: a,a^{-1},b,b^{-1}. Usage: N A B C OUTPUT.jsonl
// Each finished table is canonically rooted at its least BFS code.
#include <algorithm>
#include <array>
#include <bitset>
#include <cassert>
#include <chrono>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>
using namespace std;
constexpr int MAXN=84;
constexpr int inverse_column[4]={1,0,3,2};
struct Table {
  int n=1;
  int8_t t[MAXN][4];
  bitset<MAXN> bigger;
  Table(){for(auto &row:t) fill(begin(row),end(row),-1);}
};
int bound;
uint64_t nodes=0,leaves=0;
vector<vector<int>> relations,forbidden;
ofstream output;
chrono::steady_clock::time_point started;

bool assign_edge(Table &s,int x,int g,int y,bool &changed){
  int h=inverse_column[g];
  if(x==y || (s.t[x][g]>=0 && s.t[x][g]!=y)
     || (s.t[y][h]>=0 && s.t[y][h]!=x)) return false;
  if(s.t[x][g]<0){s.t[x][g]=y;s.t[y][h]=x;changed=true;}
  return true;
}
bool propagate(Table &s){
  bool changed;
  do{
    changed=false;
    for(int x=0;x<s.n;x++){
      for(const auto &word:relations){
        int l=0,r=int(word.size())-1,p=x,q=x;
        while(l<=r && s.t[p][word[l]]>=0) p=s.t[p][word[l++]];
        if(l>r){if(p!=q)return false;continue;}
        while(r>=l && s.t[q][inverse_column[word[r]]]>=0)
          q=s.t[q][inverse_column[word[r--]]];
        if(l>r){if(p!=q)return false;}
        else if(l==r && !assign_edge(s,p,word[l],q,changed)) return false;
      }
      for(const auto &word:forbidden){
        int p=x;bool complete=true;
        for(int g:word){if(s.t[p][g]<0){complete=false;break;}p=s.t[p][g];}
        if(complete && p==x)return false;
      }
    }
  }while(changed);
  return true;
}
bool canonical(Table &s){
  for(int root=1;root<s.n;root++){
    if(s.bigger.test(root))continue;
    int nu[MAXN],mu[MAXN];fill(nu,nu+s.n,-1);fill(mu,mu+s.n,-1);
    mu[0]=root;nu[root]=0;int last=0;bool stop=false;
    for(int x=0;x<s.n&&!stop;x++){
      assert(mu[x]>=0);
      for(int g=0;g<4;g++){
        int v=s.t[x][g],w=s.t[mu[x]][g];
        if(v<0||w<0){stop=true;break;}
        if(nu[w]<0){nu[w]=++last;mu[last]=w;}
        if(nu[w]<v)return false;
        if(nu[w]>v){s.bigger.set(root);stop=true;break;}
      }
    }
  }
  return true;
}
void visit(Table s){
  ++nodes;
  if(nodes%1000000==0)
    cerr<<"nodes="<<nodes<<" classes="<<leaves<<" seconds="
        <<chrono::duration<double>(chrono::steady_clock::now()-started).count()<<"\n";
  if(!propagate(s)||!canonical(s))return;
  int x=-1,g=-1;
  for(int i=0;i<s.n&&x<0;i++)for(int j=0;j<4;j++)if(s.t[i][j]<0){x=i;g=j;break;}
  if(x<0){
    if(s.n!=bound)return;
    ++leaves;output<<"[";
    for(int i=0;i<s.n;i++){
      if(i)output<<",";
      output<<"["<<int(s.t[i][0])<<","<<int(s.t[i][1])<<","
            <<int(s.t[i][2])<<","<<int(s.t[i][3])<<"]";
    }
    output<<"]\n";output.flush();return;
  }
  for(int y=0;y<s.n;y++)if(y!=x&&s.t[y][inverse_column[g]]<0){
    Table d=s;bool changed=false;
    if(assign_edge(d,x,g,y,changed))visit(d);
  }
  if(s.n<bound){Table d=s;int y=d.n++;bool changed=false;
    if(assign_edge(d,x,g,y,changed))visit(d);
  }
}
void add_period(vector<int> seed,int period){
  vector<int> full;
  for(int i=0;i<period;i++)full.insert(full.end(),seed.begin(),seed.end());
  relations.push_back(full);
  int remainder=period;
  for(int p=2;p<=remainder;p++)if(remainder%p==0){
    forbidden.emplace_back(full.begin(),full.begin()+seed.size()*(period/p));
    while(remainder%p==0)remainder/=p;
  }
}
int main(int argc,char **argv){
  if(argc!=6){cerr<<"Usage: N A B C OUTPUT.jsonl\n";return 2;}
  int a,b,c;
  try{bound=stoi(argv[1]);a=stoi(argv[2]);b=stoi(argv[3]);c=stoi(argv[4]);}
  catch(const exception&){return 2;}
  if(bound<1||bound>MAXN||min({a,b,c})<2||bound%a||bound%b||bound%c)return 2;
  add_period({0},a);add_period({1},a);
  add_period({2},b);add_period({3},b);
  add_period({0,2},c);add_period({2,0},c);
  add_period({3,1},c);add_period({1,3},c);
  output.open(argv[5]);if(!output)return 1;
  started=chrono::steady_clock::now();visit(Table{});
  cout<<"nodes="<<nodes<<" classes="<<leaves<<" seconds="
      <<chrono::duration<double>(chrono::steady_clock::now()-started).count()<<"\n";
}
