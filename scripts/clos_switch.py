import math


def clos_stage_3(m, n):
    print("In the clos_stage_3, m = {}, n = {}".format(m, n))
    left_number = m * n * (2 * n - 1)
    middle_number = (2 * n - 1) * m * m
    total = (2 * m * n * (2 * n - 1)) + ((2 * n - 1) * m * m)
    print("left or right side number : ",left_number)
    print("middle number: ", middle_number)
    print("total number:", total)
    print("*"*20)
    return total

def clos_stage_5(m, n):
    left1 = m * n * (2 * n - 1)
    right1 = left1
    # The middle 3 stages
    N = m
    new_m = math.sqrt(2 * N)
    new_n = math.sqrt(N / 2)
    new_m = 20
    new_n = 9
    print("Thew new m is: ", new_m)
    print("The new n is: ", new_n)
    left2 = new_m * new_n * (2 * new_n - 1)
    right2 = left2
    new_middle = (2 * new_n - 1) * new_m * new_m
    middle_3_n = left2 + right2 + new_middle
    print("The new middle number is: ", middle_3_n, "(**It doesn't multiple (2n-1)**)")
    total_n = left1 + right1 + middle_3_n * (2 * n - 1)
    print("The left1 and right 1 is: ", left1)
    print("total number is: ", total_n)
    print("*"*20)

def optimum_percentage(N, m, n):
    crossbar_num = N * N
    clos3 = clos_stage_3(m, n)
    print("optimum percentage: ", clos3 / crossbar_num)

if __name__ == '__main__':
    # If we know the input size, but we don't know the m, n
    N = 2888
    # #  Optimal three stage clos switch
    #m = math.sqrt(2 * N)
    #n = math.sqrt(N / 2)
    # n = input number, m is the number of switch in stage 1
    # print("m = ", m)
    # print("n = ", n)
    m = 60
    n = 42
    # clos_stage_3(m, n)
    # optimum_percentage(N, m, n)
    clos_stage_3(m, n)

