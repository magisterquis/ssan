# Makefile
# Build ssan
# By J. Stuart McMurray
# Created 20260506
# Last Modified 20260506

COPTS = -Wall --pedantic -Wextra -Werror
NOMAN = noman
PROG  = ssan

test: ssan
	prove

.include <bsd.prog.mk>
