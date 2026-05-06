/*
 * ssan.c
 * Sanitize a stream with vis(1)
 * By J. Stuart McMurray
 * Created 20260506
 * Last Modified 20260506
 */

#include <err.h>
#include <stdlib.h>
#include <unistd.h>
#include <vis.h>

#define BUFLEN 1024

int
main(void)
{
        char in[BUFLEN], out[(4 * BUFLEN ) + 1];
        ssize_t nr, nw;
        ssize_t bsz, off;
        /* Read a chunk. */
        while (-1 != (nr = read(STDIN_FILENO, in, sizeof(in))) && nr != 0) {
                /* Sanitize. */
                bsz = strvisx(out, in, (size_t)nr, 0);
                /* Write the entire chunk. */
                for (off = 0; off < bsz; off += nw) {
                        if (0 == (nw = write(STDOUT_FILENO,out + off,
                                                        bsz - off)) ||
                                        -1 == nw)
                                err(10, "write");
                }
        }
        if (0 != nr)
                err(11, "read");

        return 0;
}
