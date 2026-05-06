Stream Sanitizer
================
Wraps [`strvisx(3)`](https://man.openbsd.org/strvisx.3) to sanitize untrusted
input for display on a fancypants terminal which might interpret escape
sequences unsafely, originally for displaying honeypot output in real time.

Quickstart
----------
1.  Grab this repo
    ```sh
    git clone https://github.com/magisterquis/ssan.git && cd ssan
    ```
2.  Build `ssan`
    -   OpenBSD
        ```sh
        make
        ```
    -   macOS
        ```sh
        cc -O2 -Wno-deprecated-declarations -o ./ssan ./ssan.c
        ```
3.  Worry less about output
    ```sh
    dangerousthing | ./ssan
    ```

Why not [vis(1)](https://man.openbsd.org/vis.1)?
------------------------------------------------
It has a one-character read buffer and a line-oriented output buffer, which
works out to the output buffer being one character behind the input stream.
When that one character is a newline, the line-buffered output line isn't
printed.  With a long-running stream, works out to always being one line
behind.

Building on Linux
-----------------
Probably requires libbsd?
