/* Exact batched NF adapter for compact_msolve_basis.c output.
 * Build against the retained patched msolve 0.10.1 source with
 * -DNEOGB_SOURCE='"/absolute/path/src/neogb/gb.c"'. No GB computation.
 * Usage: executable PREFIX VARIABLE OUTPUT_PREFIX [batch<=250] [threads]
 * Output per checkpoint: native little-endian uint64 keys, then separate
 * uint8 rows in input standard order; only missing multiplication products.
 * Input rows are LM=sum(rewrite[j]*standard[j]), characteristic five.
 */
#include <stdint.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include NEOGB_SOURCE
static void fail(const char*s){fprintf(stderr,"compact_nf: %s\n",s);exit(2);}
static void *alloc(size_t n){void*p=calloc(n,1);if(!p)fail("allocation");return p;}
static char *name(const char*p,const char*s){char*r=alloc(strlen(p)+strlen(s)+1);strcpy(r,p);strcat(r,s);return r;}
static void *mapfile(const char*p,size_t*n){int fd=open(p,O_RDONLY);struct stat st;if(fd<0||fstat(fd,&st))fail(p);*n=st.st_size;void*r=mmap(NULL,*n,PROT_READ,MAP_PRIVATE,fd,0);close(fd);if(r==MAP_FAILED)fail("mmap");return r;}
static hi_t keyhash(uint64_t k,ht_t*h){exp_t e[h->evl];memset(e,0,sizeof(e));for(int i=0;i<h->nv;i++){e[i+1]=(k>>(4*i))&15;e[0]+=e[i+1];}if(h->eld+2>=h->esz)enlarge_hash_table(h);return insert_in_hash_table(e,h);}
static uint64_t hashkey(hi_t id,ht_t*h){uint64_t k=0;for(int i=0;i<h->nv;i++){if(h->ev[id][i+1]>15)fail("exponent exceeds nibble");k|=(uint64_t)h->ev[id][i+1]<<(4*i);}return k;}
static void row(bs_t*b,size_t i,size_t n,hi_t lead){b->hm[i]=alloc((n+OFFSET)*sizeof(hm_t));b->cf_8[i]=alloc(n);hm_t*r=b->hm[i];r[LENGTH]=n;r[PRELOOP]=n%UNROLL;r[COEFFS]=i;r[OFFSET]=lead;r[DEG]=b->ht->hd[lead].deg;b->cf_8[i][0]=1;}
static void save(const char*p,void*data,size_t bytes){char*tmp=name(p,".partial");FILE*f=fopen(tmp,"wx");if(!f)fail("checkpoint exists");if(fwrite(data,1,bytes,f)!=bytes||fflush(f)||fsync(fileno(f))||fclose(f))fail("checkpoint write");if(rename(tmp,p))fail("checkpoint rename");free(tmp);}
int main(int argc,char**argv){
 if(argc<4)fail("PREFIX VARIABLE OUTPUT_PREFIX [BATCH] [THREADS]");int var=atoi(argv[2]),batch=argc>4?atoi(argv[4]):64,threads=argc>5?atoi(argv[5]):8;if(var<0||var>=15||batch<1||batch>250)fail("arguments");
 size_t sb,lb,rb;uint64_t*std=mapfile(name(argv[1],".standard.u64"),&sb),*lm=mapfile(name(argv[1],".lm.u64"),&lb);uint8_t*rw=mapfile(name(argv[1],".u8"),&rb);size_t d=sb/8,ng=lb/8;if(sb%8||lb%8||rb!=d*ng)fail("input shape");
 bs_t*bs=NULL;ht_t*ht=NULL;md_t*md=NULL;int32_t lens[]={1},exps[15]={1},cfs[]={1};if(initialize_gba_input_data(&bs,&ht,&md,lens,exps,cfs,5,0,0,15,1,0,17,threads,250,0,2,0,1,0,0,2)!=1)fail("initializer");
 free_basis_elements(bs);check_enlarge_basis(bs,ng,md);hi_t*sh=alloc(d*sizeof(hi_t)),*lh=alloc(ng*sizeof(hi_t));for(size_t j=0;j<d;j++)sh[j]=keyhash(std[j],ht);for(size_t i=0;i<ng;i++)lh[i]=keyhash(lm[i],ht);calculate_divmask(ht);
 for(size_t i=0;i<ng;i++){const uint8_t*r=rw+i*d;size_t n=1;for(size_t j=0;j<d;j++)n+=r[j]!=0;row(bs,i,n,lh[i]);size_t t=1;for(size_t j=d;j-->0;)if(r[j]){if(r[j]>4)fail("coefficient");bs->hm[i][OFFSET+t]=sh[j];bs->cf_8[i][t++]=5-r[j];}bs->lmps[i]=i;bs->lm[i]=ht->hd[lh[i]].sdm;bs->ld++;}bs->lml=bs->ld;md->trace_level=NO_TRACER;
 uint64_t*targets=alloc(d*8);size_t nt=0;for(size_t j=0;j<d;j++){if(((std[j]>>(4*var))&15)==15)fail("product overflow");uint64_t k=std[j]+(UINT64_C(1)<<(4*var));int known=0;for(size_t t=0;t<d&&!known;t++)known=std[t]==k;for(size_t t=0;t<ng&&!known;t++)known=lm[t]==k;if(!known)targets[nt++]=k;}
 fprintf(stderr,"loaded %zu basis rows; %zu standards; %zu missing products\n",ng,d,nt);fflush(stderr);
 for(size_t start=0;start<nt;start+=batch){size_t n=nt-start;if(n>(size_t)batch)n=batch;char suffix[100];snprintf(suffix,sizeof(suffix),".%06zu.u8",start);char*out=name(argv[3],suffix);snprintf(suffix,sizeof(suffix),".%06zu.keys.u64",start);char*kp=name(argv[3],suffix);struct stat st;if(!stat(out,&st)){if((size_t)st.st_size!=n*d)fail("bad completed checkpoint");fprintf(stderr,"skip completed %zu\n",start);continue;}
  bs_t*tbr=initialize_basis(md,ht);check_enlarge_basis(tbr,n,md);for(size_t j=0;j<n;j++){row(tbr,j,1,keyhash(targets[start+j],ht));tbr->ld++;}tbr->lml=tbr->ld;exp_t mul[ht->evl];memset(mul,0,sizeof(mul));int32_t err=0;fprintf(stderr,"batch %zu..%zu starting\n",start,start+n);fflush(stderr);core_nf(tbr,md,mul,bs,&err);if(err||tbr->ld!=n)fail("NF count/error");
  int32_t*index=alloc(ht->eld*sizeof(int32_t));for(size_t j=0;j<d;j++)index[sh[j]]=j+1;uint8_t*res=alloc(n*d);for(size_t j=0;j<n;j++){hm_t*r=tbr->hm[j];if(!r)continue;for(size_t t=0;t<r[LENGTH];t++){hi_t h=r[OFFSET+t];if(h>=ht->eld||!index[h]){fprintf(stderr,"nonstandard output key %llu\n",(unsigned long long)hashkey(h,ht));fail("NF not supported on standards");}res[j*d+index[h]-1]=tbr->cf_8[r[COEFFS]][t];}}
  save(kp,targets+start,n*8);save(out,res,n*d);free(index);free(res);free_basis_without_hash_table(&tbr);fprintf(stderr,"checkpoint %zu/%zu saved\n",start+n,nt);fflush(stderr);
 }
 return 0;
}
