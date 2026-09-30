"""Build exact acceleration libraries before parallel certificate replay."""
from fast_arithmetic import library
if __name__=='__main__':
 for name in ['finite_norm','finite_norm_image','endpoint_tower','endpoint_global','endpoint_tail_recurrence','endpoint_factorization']:
  library(name);print('EXACT BACKEND READY',name,flush=True)
