import math

def slepian_stage3(n, r):
    left = n * n * r
    middle = r * r * n
    total = 2 * left + middle
    print("Left or right number: ", left)
    print("Middle number: ", middle)
    print("Total number: ", total)
    print("*"*20)
    return total


def optimum_percentage(N, n, r):
    crossbar_num = N * N
    slepian3 = slepian_stage3(n, r)
    print("optimum percentage: ", slepian3 / crossbar_num)

def recursive_2by2(N):
    #    k = log2(N) - 1  (There are k stages to the center stage)
    # 	total_stage_num = 2log2(N)-1
    # 	C(n) = 4Nlog2(N) - 2N (There are 2N crosspoints per stage)
    print("recursive 2 * 2")
    k = math.log(N, 2) - 1
    print("After log, k = ", k)
    k = math.ceil(k)
    print("New k = ", k)
    N = math.pow(2, k + 1)
    print("New N = ", N)
    total_stage_num = 2 * k + 1
    total_num = 2 * N * total_stage_num
    print("total stage number: ", total_stage_num)
    print("total number: ", total_num)
    print("*"*20)

def recursive_3by3(N):
    # 	k = log3(N) - 1  (There are k stages to the center stage)
    # 	total_stage_number = 2log3(N)-1
    # 	C(n) = 6Nlog3(N) -  3N (There are 3N crosspoints per stage)
    print("recursive 3 * 3")
    k = math.log(N, 3) - 1
    print("After log, k = ", k)
    k = math.ceil(k)
    print("New k = ", k)
    N = math.pow(3, k + 1)
    print("New N = ", N)
    total_stage_num = 2 * k + 1
    total_num = 3 * N * total_stage_num
    print("total stage number: ", total_stage_num)
    print("total number: ", total_num)
    print("*"*20)

def recursive_5by5(N):
    # 	k = log5(N) - 1  (There are k stages to the center stage)
    # 	total_stage_number = 2log5(N) - 1
    # 	C(n) = 5Nlog5(N) - 5N (There are 5N crosspoints per stage)
    print("recursive 5 * 5")
    k = math.log(N, 5) - 1
    print("After log, k = ", k)
    k = math.ceil(k)
    print("New k = ", k)
    N = math.pow(5, k + 1)
    print("New N = ", N)
    total_stage_num = 2 * k + 1
    total_num = 5 * N * total_stage_num
    print("total stage number: ", total_stage_num)
    print("total number: ", total_num)
    print("*"*20)

def recursive_any_to_any(N, size):
    print("recursive {} * {}".format(size, size))
    k = math.log(N, size) - 1
    print("After log, k = ", k)
    k = math.ceil(k)
    print("New k = ", k)
    N = math.pow(size, k + 1)
    print("New N = ", N)
    total_stage_num = 2 * k + 1
    total_num = size * N * total_stage_num
    print("total stage number: ", total_stage_num)
    print("total number: ", total_num)
    print("*" * 20)

if __name__ == '__main__':
    N = 761378
    r = math.sqrt(2 * N)
    n = math.sqrt(N / 2)
    # print("r = ", r)
    # print("n = ", n)
    # r = 76
    # n = 38
    #slepian_stage3(n, r)
    # optimum_percentage(N, n, r)
    # recursive_5by5(N)
    recursive_any_to_any(16000, 7)
