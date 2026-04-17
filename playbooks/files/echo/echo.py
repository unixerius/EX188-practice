#!/usr/bin/env python3
# udp_echo_server.py - Basic UDP echo server
# Original by Nawaz Dhandala, copied from:
# https://oneuptime.com/blog/post/2026-03-20-build-udp-echo-server-python/view

import socket
import sys

HOST = '0.0.0.0'   # Listen on all interfaces
PORT = 5000         # UDP port

def main():
    # Create UDP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    # Allow address reuse (useful during development)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

    sock.bind((HOST, PORT))
    print(f"UDP echo server listening on {HOST}:{PORT}")

    while True:
        try:
            # recvfrom returns (data, (address, port))
            data, addr = sock.recvfrom(65535)  # Max UDP payload
            print(f"Received {len(data)} bytes from {addr[0]}:{addr[1]}")

            # Echo the data back to the sender
            sent = sock.sendto(data, addr)
            print(f"Echoed {sent} bytes back to {addr[0]}:{addr[1]}")

        except KeyboardInterrupt:
            print("\nShutting down")
            break

    sock.close()

if __name__ == '__main__':
    main()
