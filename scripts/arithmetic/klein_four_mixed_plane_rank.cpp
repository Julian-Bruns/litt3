// Mixed-node lines in the three-dimensional c=14+2d word spaces.
#define KLEIN_FOUR_TWO_ENDPOINT_NO_MAIN
#include "klein_four_two_endpoint_planes.cpp"
#include <unordered_map>
std::vector<std::vector<F7>> nullspace(std::vector<std::vector<F7>>a,int cols){
 std::vector<int>piv;int row=0;
 for(int j=0;j<cols&&row<int(a.size());j++){
  int p=row;while(p<int(a.size())&&!nz(a[p][j]))p++;if(p==int(a.size()))continue;
  std::swap(a[p],a[row]);F7 inv=inverse7(a[row][j]);for(auto&v:a[row])v=mul(v,inv);
  for(int i=0;i<int(a.size());i++)if(i!=row){F7 c=a[i][j];for(int k=0;k<cols;k++)a[i][k]=minus7(a[i][k],mul(c,a[row][k]));}
  piv.push_back(j);row++;
 }
 if(row!=int(a.size()))throw std::runtime_error("unexpected kernel rank");
 std::vector<std::vector<F7>>b;
 for(int j=0;j<cols;j++)if(std::find(piv.begin(),piv.end(),j)==piv.end()){
  std::vector<F7>v(cols);v[j][0]=1;for(int i=0;i<row;i++)v[piv[i]]=scalar7(a[i][j],4);b.push_back(v);
 }
 return b;
}
int main(int argc,char**argv){try{
 int dmin=argc>1?std::stoi(argv[1]):0,dmax=argc>2?std::stoi(argv[2]):5;
 if(dmin<0||dmax>6||dmin>dmax)throw std::runtime_error("range");
 init();for(int i=1;i<25;i++)for(int j=1;j<25;j++)if(mul25[i][j]==1)inv25[i]=j;
 D={4,6,23,9,5,23,8,1};F7 z{};z[1]=1;F7 one{};one[0]=1;
 std::array<F7,29>zs{};zs[0]=one;for(int i=1;i<29;i++)zs[i]=mul(zs[i-1],z);
 for(int d=dmin;d<=dmax;d++){
  int N=15-2*d,m=std::max(0,d-2);Mask comb=(Mask(1)<<(N-1))-1,limit=Mask(1)<<28;
  uint64_t visited=0,reps=0,covered=0,nodes=0,triples=0,quads=0,maxline=0;
  while(comb<limit){Mask mask=(comb<<1)|1;visited++;Mask x=comb&-comb,y=comb+x;comb=(((comb^y)>>2)/x)|y;
   if(!canonical(mask))continue;reps++;covered+=orbit_normalized(mask);
   std::array<std::array<int,29>,16>es{};es[0][0]=1;int used=0;Mask bits=mask;
   while(bits){int a=__builtin_ctz(bits);bits&=bits-1;used++;
    for(int j=used;j>=1;j--)for(int k=0;k<29;k++)es[j][(k+a)%29]=(es[j][(k+a)%29]+es[j-1][k])%5;
   }
   std::array<F7,16>hs{};for(int i=0;i<=N;i++)hs[i]=scalar7(red(es[i]),i%2?4:1);
   auto h=[&](int i){return i>=0&&i<=N?hs[i]:F7{};};
   std::vector<std::vector<F7>>mat(m,std::vector<F7>(d+1));for(int i=0;i<m;i++)for(int j=0;j<=d;j++)mat[i][j]=h(9-2*d+i+j);
   auto ts=nullspace(mat,d+1);std::vector<std::vector<F7>>qs;
   for(auto&t:ts){std::vector<F7>q(9-d);for(int k=0;k<=8-d;k++)for(int j=0;j<=d;j++)q[k]=plus7(q[k],mul(t[j],h(8-2*d-k+j)));qs.push_back(q);}
   if(ts.size()+std::max(0,2-d)!=3)throw std::runtime_error("word space not three dimensional");
   auto eval=[&](const std::vector<F7>&p,const F7&a){F7 v{};for(auto i=p.rbegin();i!=p.rend();++i)v=plus7(mul(v,a),*i);return v;};
   std::vector<int>aa;std::vector<Vec>rows;bits=mask;
   while(bits){int a=__builtin_ctz(bits);bits&=bits-1;nodes++;F7 jd{};
    for(int j=0;j<N;j++)jd=plus7(jd,scalar7(mul(hs[j],zs[((N-j-1)*a)%29]),(N-j)%5));
    Vec row{};int pos=0;
    for(int l=0;l<std::max(0,2-d);l++)row[pos++]=scalar7(zs[(28+l)*a%29],4);
    for(size_t k=0;k<ts.size();k++)row[pos++]=minus7(scalar7(mul(zs[28*a%29],eval(qs[k],zs[a])),3),mul(mul(zs[22*a%29],eval(ts[k],zs[a])),jd));
    aa.push_back(a);rows.push_back(row);
   }
   std::unordered_map<std::string,Mask>lines;
   for(size_t i=0;i<rows.size();i++)for(size_t j=i+1;j<rows.size();j++){
    Vec n=cross(rows[i],rows[j]);if(!nz3(n))throw std::runtime_error("dependent pair");
    int p=0;while(!nz(n[p]))p++;F7 inv=inverse7(n[p]);std::string key;
    for(auto&v:n){v=mul(v,inv);for(int a:v)key.push_back(char(a));}
    lines[key]|=(Mask(1)<<aa[i])|(Mask(1)<<aa[j]);
   }
   for(auto&line:lines){int count=__builtin_popcount(line.second);maxline=std::max<uint64_t>(maxline,count);
    if(count==3){triples++;if(triples<=3)std::cout<<"TRIPLE_SAMPLE d="<<d<<" J_mask="<<mask<<" nodes_mask="<<line.second<<'\n';}
    if(count>=4){quads++;std::cout<<"HIGH_LINE d="<<d<<" J_mask="<<mask<<" nodes_mask="<<line.second<<" count="<<count<<'\n';}
   }
  }
  std::cout<<"TOTAL d="<<d<<" normalized_subsets="<<visited<<" representatives="<<reps<<" covered="<<covered<<" nodes="<<nodes<<" triple_lines="<<triples<<" high_lines="<<quads<<" max_line="<<maxline<<std::endl;
  if(visited!=covered)throw std::runtime_error("coverage");
 }
 return 0;
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
