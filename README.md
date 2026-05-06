Stream Sanitizer
================
Wraps [`strvisx(3)`][https://man.openbsd.org/strvisx.3] to sanitize untrusted
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
    
Building on Linux
-----------------
Probably requires libbsd?
