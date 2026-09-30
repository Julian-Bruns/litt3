// Full audit of regenerated ratio streams. No division or batch inversion is used
// in the record audit: every record is checked by cross multiplication.
// The arithmetic kernel is shared with the producer; verify_moments.py also
// checks selected records using independent, direct Python polynomial arithmetic.
#define main unused_moment_generation_main
#include "search_moments.cpp"
#undef main
#include <iomanip>
#include <sstream>
static uint32_t read_le_word(ifstream& f) {
 unsigned char b[4];if(!f.read(reinterpret_cast<char*>(b),4))throw runtime_error("short record");
 return uint32_t(b[0])|(uint32_t(b[1])<<8)|(uint32_t(b[2])<<16)|(uint32_t(b[3])<<24);
}
int main(int argc,char**argv){try{
 string prefix,profile,out;int chunks=16;
 for(int i=1;i<argc;i++){string a=argv[i];if(a=="--prefix"&&i+1<argc)prefix=argv[++i];else if(a=="--profile"&&i+1<argc)profile=argv[++i];else if(a=="--output"&&i+1<argc)out=argv[++i];else if(a=="--chunks"&&i+1<argc)chunks=stoi(argv[++i]);else throw runtime_error("Usage: --prefix PREFIX --profile one2|two1|two2 --output JSON");}
 if(prefix.empty()||out.empty()||(profile!="one2"&&profile!="two1"&&profile!="two2"))throw runtime_error("missing or invalid arguments");
 initialize();E z;z.a[1]=1;array<E,29>zp;zp[0]=one();for(int i=1;i<29;i++)zp[i]=mul(zp[i-1],z);
 int d=profile=="two2"?2:1;E em,cm,kappa;
 if(profile=="one2"){em=cm=scalar(2);kappa=one();}
 else{em=add(one(),zp[(29-2*d)%29]);cm=add(one(),zp[(6*d)%29]);kappa=zp[(58-8*d)%29];}
 em=scale(em,22);cm=scale(cm,22);
 uint32_t c=22+25*7+625*9+15625*23,e=1+25*3+625*8+15625*15;
 array<E,116>C,F;
 for(int i=0;i<4;i++){for(int j=0;j<29;j++){C[29*i+j]=scale(zp[5*j%29],c);F[29*i+j]=scale(zp[8*j%29],e);}c=pow8(c,25);e=pow8(e,25);}
 static E cp[116][116],ep[116][116];for(int i=0;i<116;i++)for(int j=i;j<116;j++){cp[i][j]=add(C[i],C[j]);ep[i][j]=add(F[i],F[j]);}
 uint64_t counts[2]={0,0};
 for(int side=0;side<2;side++){
  vector<uint64_t> seen((uint64_t(1)<<28)/64,0);
  for(int h=0;h<chunks;h++){
   ostringstream name;name<<prefix<<'.'<<setw(2)<<setfill('0')<<h<<".json."<<(side?"right":"left")<<".keys";
   ifstream f(name.str(),ios::binary);if(!f)throw runtime_error("missing key stream");
   while(f.peek()!=EOF){
    E key;for(auto&x:key.a){x=read_le_word(f);if(x>=390625)throw runtime_error("noncanonical field coefficient");}
    uint32_t code=read_le_word(f);if(code>=(1u<<28))throw runtime_error("out-of-range label code");
    int i=code&127,j=(code>>7)&127,k=(code>>14)&127,l=(code>>21)&127;
    if(i>j||j>k||k>l||l>=116)throw runtime_error("invalid endpoint quartet");
    uint64_t bit=uint64_t(1)<<(code%64);if(seen[code/64]&bit)throw runtime_error("duplicate quartet");seen[code/64]|=bit;
    E a=sub(add(ep[i][j],ep[k][l]),em),b=sub(add(cp[i][j],cp[k][l]),cm);
    if(a.zero()||b.zero())throw runtime_error("unexpected zero vector component in these profiles");
    E lhs=mul(key,side?a:b),rhs=side?mul(kappa,b):a;
    if(!(lhs==rhs))throw runtime_error("ratio identity failed");
    ++counts[side];
   }
   cout<<"AUDIT "<<profile<<" side="<<side<<" chunk="<<h<<" records="<<counts[side]<<endl;
  }
  if(counts[side]!=7940751)throw runtime_error("endpoint coverage incomplete");
 }
 cout<<"PASS "<<profile<<": 15881502 exact ratio identities; every quartet occurs once in each stream\n";
 ofstream f(out);if(!f)throw runtime_error("output error");f<<"{\n  \"profile\": \""<<profile<<"\",\n  \"left_unique_valid_quartets\": "<<counts[0]<<",\n  \"right_unique_valid_quartets\": "<<counts[1]<<",\n  \"record_identities_checked\": "<<counts[0]+counts[1]<<",\n  \"all_record_identities_passed\": true,\n  \"zero_components_found\": 0,\n  \"division_used_in_record_checks\": false,\n  \"arithmetic_kernel_shared_with_producer\": true\n}\n";
}catch(const exception&e){cerr<<"ERROR: "<<e.what()<<'\n';return 1;}}
