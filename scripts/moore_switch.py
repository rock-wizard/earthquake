def moore_switch(n):
    left_number = 2 * n * 3 * n / 2
    middle_number = 2 * 2 * 3 * n / 2
    total = left_number * 2 + middle_number
    print("left or right stage number: ", left_number)
    print("middle number:", middle_number)
    print("total number: ", total)
    print("*"*20)
    return total

def optimum_percentage(n):
    N = 2 * n
    crossbar_num = N * N
    moore = moore_switch(n)
    print("optimum percentage: ", moore / crossbar_num)

if __name__ == '__main__':
    n = 1440
    moore_switch(n)
    optimum_percentage(n)