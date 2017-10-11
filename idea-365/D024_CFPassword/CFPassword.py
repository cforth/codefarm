import random


LOW_LEVEL = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']

MEDIUM_LEVEL = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
                'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
                'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
                'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
                '1', '2', '3', '4', '5', '6', '7', '8', '9', '0']

HIGH_LEVEL = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
              'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
              'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
              'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
              '!', '@', '#', '$', '%', '^', '&', '*', '-', '_', '=',
              '+', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', ' ']


def generate_password(length, level=LOW_LEVEL):
    return ''.join([random.choice(level) for i in range(0, length)])


if __name__ == '__main__':
    print(generate_password(8))
    print(generate_password(16, MEDIUM_LEVEL))
    print(generate_password(64, HIGH_LEVEL))
