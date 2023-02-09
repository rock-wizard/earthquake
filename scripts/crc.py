class CRC:

    def __init__(self):
        self.cdw = ''

    def xor(self, a, b):
        result = []
        for i in range(1, len(b)):
            if a[i] == b[i]:
                result.append('0')
            else:
                result.append('1')

        return ''.join(result)

    def crc(self, message, key):
        pick = len(key)

        tmp = message[:pick]

        while pick < len(message):
            if tmp[0] == '1':
                tmp = self.xor(key, tmp) + message[pick]
            else:
                tmp = self.xor('0' * pick, tmp) + message[pick]

            pick += 1

        if tmp[0] == "1":
            tmp = self.xor(key, tmp)
        else:
            tmp = self.xor('0' * pick, tmp)

        checkword = tmp
        return checkword

    def encodedData(self, data, key):
        l_key = len(key)
        # append_data = data + '0' * (l_key - 1)
        remainder = self.crc(data, key)
        codeword = data[:-len(key)+1] + remainder
        self.cdw += codeword
        print("Remainder: ", remainder)
        print("Data: ", codeword)

    def reciverSide(self, data, key):
        r = self.crc(data, key)
        size = len(key) - 1
        print(r)
        if r == size * '0':
            print("No Error")
        else:
            print("Error")

# data is the original data + n * '0'
data = '1011100100000'
# key is generator which the length is n + 1
key = '11001'
c = CRC()
c.encodedData(data, key)
print('---------------')

data = "1011100101001"
key = "11001"
c.reciverSide(data, key)
print('---------------')
print(c.cdw)
