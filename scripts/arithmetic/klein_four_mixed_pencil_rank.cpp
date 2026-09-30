// Abstract mixed-node ranks on the two-dimensional c=15+2d words.
#define KLEIN_FOUR_PENCIL_BOUNDARY_NO_MAIN
#include "klein_four_pencil_boundary_all.cpp"
int main(int argc,char**argv){try{
 int dmin=argc>1?std::stoi(argv[1]):1,dmax=argc>2?std::stoi(argv[2]):5;
 if(dmin<1||dmax>6||dmin>dmax)throw std::runtime_error("range");
 init();D={4,6,23,9,5,23,8,1};F7 z{};z[1]=1;F7 one{};one[0]=1;
 std::array<F7,29>zs{};zs[0]=one;for(int i=1;i<29;i++)zs[i]=mul(zs[i-1],z);
 for(int d=dmin;d<=dmax;d++){
  int N=14-2*d,m=d-1;Mask comb=(Mask(1)<<(N-1))-1,limit=Mask(1)<<28;
  uint64_t visited=0,reps=0,covered=0,nodes=0,pairs=0,triple=0,zero=0,maxsame=0;
  while(comb<limit){Mask mask=(comb<<1)|1;visited++;Mask x=comb&-comb,y=comb+x;comb=(((comb^y)>>2)/x)|y;
   if(!canonical(mask))continue;reps++;covered+=orbit_normalized(mask);
   std::array<std::array<int,29>,15>es{};es[0][0]=1;int used=0;Mask bits=mask;
   while(bits){int a=__builtin_ctz(bits);bits&=bits-1;used++;
    for(int j=used;j>=1;j--)for(int k=0;k<29;k++)es[j][(k+a)%29]=(es[j][(k+a)%29]+es[j-1][k])%5;
   }
   std::array<F7,15>hs{};for(int i=0;i<=N;i++)hs[i]=scale7(red(es[i]),i%2?4:1);
   auto h=[&](int i){return i>=0&&i<=N?hs[i]:F7{};};
   std::vector<std::vector<F7>>mat(m,std::vector<F7>(d+1));for(int i=0;i<m;i++)for(int j=0;j<=d;j++)mat[i][j]=h(8-2*d+i+j);
   std::vector<int>piv;int f0=-1,f1=-1;F7 den{};
   for(int a=0;a<=d&&den==F7{};a++)for(int b=a+1;b<=d&&den==F7{};b++){
    std::vector<int>p;for(int j=0;j<=d;j++)if(j!=a&&j!=b)p.push_back(j);
    std::vector<std::vector<F7>>block(m,std::vector<F7>(m));for(int i=0;i<m;i++)for(int j=0;j<m;j++)block[i][j]=mat[i][p[j]];
    F7 dd=det(block);if(dd!=F7{}){den=dd;piv=p;f0=a;f1=b;}
   }
   if(den==F7{})throw std::runtime_error("kernel rank");
   std::array<std::vector<F7>,2>basis,qs;
   for(int k=0;k<2;k++){
    int free=k?f1:f0;basis[k].assign(d+1,F7{});basis[k][free]=den;
    for(int col=0;col<m;col++){
     std::vector<std::vector<F7>>block(m,std::vector<F7>(m));for(int i=0;i<m;i++)for(int j=0;j<m;j++)block[i][j]=mat[i][j==col?free:piv[j]];
     basis[k][piv[col]]=scale7(det(block),4);
    }
    for(int i=0;i<m;i++){F7 s{};for(int j=0;j<=d;j++)s=add7(s,mul(mat[i][j],basis[k][j]));if(s!=F7{})throw std::runtime_error("kernel identity");}
    qs[k].assign(8-d,F7{});for(int r=0;r<=7-d;r++)for(int j=0;j<=d;j++)qs[k][r]=add7(qs[k][r],mul(basis[k][j],h(7-2*d-r+j)));
   }
   auto eval=[&](const std::vector<F7>&p,const F7&a){F7 v{};for(auto i=p.rbegin();i!=p.rend();++i)v=add7(mul(v,a),*i);return v;};
   std::vector<int>previous_nodes;std::vector<std::array<F7,2>>previous;bits=mask;
   while(bits){int a=__builtin_ctz(bits);bits&=bits-1;nodes++;F7 jd{};
    for(int j=0;j<N;j++)jd=add7(jd,scale7(mul(hs[j],zs[((N-j-1)*a)%29]),(N-j)%5));
    std::array<F7,2>row;
    for(int k=0;k<2;k++)row[k]=sub7(scale7(mul(zs[28*a%29],eval(qs[k],zs[a])),3),mul(mul(zs[22*a%29],eval(basis[k],zs[a])),jd));
    if(row[0]==F7{}&&row[1]==F7{}){zero++;throw std::runtime_error("zero mixed row");}
    int same=1;
    for(size_t i=0;i<previous.size();i++)if(mul(row[0],previous[i][1])==mul(row[1],previous[i][0])){
     pairs++;same++;std::cout<<"COLLISION d="<<d<<" J_mask="<<mask<<" nodes="<<previous_nodes[i]<<','<<a<<'\n';
    }
    maxsame=std::max<uint64_t>(maxsame,same);if(same>=3)triple++;
    previous_nodes.push_back(a);previous.push_back(row);
   }
  }
  std::cout<<"TOTAL d="<<d<<" normalized_subsets="<<visited<<" representatives="<<reps<<" covered="<<covered<<" nodes="<<nodes<<" pair_collisions="<<pairs<<" max_same_direction="<<maxsame<<" triple_collisions="<<triple<<" zero_rows="<<zero<<std::endl;
  if(visited!=covered)throw std::runtime_error("coverage");
 }
 return 0;
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
