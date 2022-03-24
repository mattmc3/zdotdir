#!/usr/bin/env python

from pathlib import Path
import argparse
import base64
import hashlib
import hmac
import os
import struct
import time
import toml
import traceback


def get_hotp_token(key, intervals):
    msg = struct.pack(">Q", intervals)
    h = hmac.new(key, msg, hashlib.sha1).digest()
    o = h[19] & 15
    h = (struct.unpack(">I", h[o : o + 4])[0] & 0x7FFFFFFF) % 1000000
    return h


def get_totp_token(key):
    return get_hotp_token(key, int(time.time()) // 30)


def byte_secret(secret):
    secret = secret.replace(" ", "")
    missing_padding = len(secret) % 8
    if missing_padding != 0:
        secret += "=" * (8 - missing_padding)
    return base64.b32decode(secret, casefold=True)


def get_traceback(e):
    lines = traceback.format_exception(type(e), e, e.__traceback__)
    return ''.join(lines)


def main():
    parser = argparse.ArgumentParser(
        prog="mfa",
        description="Produce token for multi-factor authentication",
    )
    parser.add_argument(
        "secret",
        nargs=1,
        help="The MFA secret key",
    )
    args = parser.parse_args()


	data_home = Path(os.environ.get("XDG_DATA_HOME", os.path.expanduser("~/.local/share")))
	secrets = toml.load(Path(data_home / secrets / "mfa.toml"))


    try:
        key = byte_secret(args.secret[0])
        result = str(get_totp_token(key)).zfill(6)
        print(result)
    except Exception as e:
        print("mfa: Secret key is invalid.")
        print(get_traceback(e))


if __name__ == "__main__":
    main()
