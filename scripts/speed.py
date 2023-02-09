
def go_back_n():
    len_frame = 21080
    p_bit_err = 0.00000035
    a = 10.4
    p = 0
    q = 0
    if p_bit_err != 0:
        p = p_bit_err * len_frame
    
    r = 1 - (1 - p) * (1 - q)
    
    
    
    