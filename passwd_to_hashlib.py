import hashlib
import sys

salt = "fbc1993a5b1af39e648afe807482bea4"


if __name__ == "__main__":
    password = hashlib.sha512()
    origenpd = sys.argv[1]
    password.update((origenpd+ salt).encode('utf-8') )
    print(password.hexdigest())
