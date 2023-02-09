import math

def getPbByP(p, L):
    _p = 1.0 - p
    _p_pow = math.pow(_p, 1/L)
    pb = 1.0 - _p_pow
    return pb

def getPByPb(pb, L):
    return 1.0 - math.pow((1.0 - pb), L)

if __name__ == "__main__":
    p = 0.00282912
    L = 3000
    pb = getPbByP(p, L)
    print(pb)
    
    header = 150
    optimal_L = math.pow(150.0/pb, 1/2)
    print(optimal_L)
