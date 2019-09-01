CC=arm-hisiv300-linux-gcc
USER_CFLAGS=-march=armv5te -mcpu=arm926ej-s -I/opt/hisi-linux/x86-arm/arm-hisiv300-linux/target/usr/include -L/opt/hisi-linux/x86-arm/arm-hisiv300-linux/target/usr/lib
USER_LDFLAGS=
AR=arm-hisiv300-linux-ar
RANLIB=arm-hisiv300-linux-ranlib
STRIP=arm-hisiv300-linux-strip
CFLAGS = -Wall -I./src

TARGET = ioctl

SRCDIR   = src
OBJDIR   = dist
BINDIR   = dist

SOURCES  := $(wildcard $(SRCDIR)/*.c)
INCLUDES := $(wildcard $(SRCDIR)/*.h)
OBJECTS  := $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
rm       = rm -f

$(BINDIR)/$(TARGET): $(OBJECTS)
	$(CC) $(LFLAGS) $(OBJECTS) -o $@
	$(STRIP) $(BINDIR)/$(TARGET)
	@echo "Linking complete!"

$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@
	@echo "Compiled "$<" successfully!"

.PHONY: clean
clean:
	@$(rm) $(OBJECTS)
	@echo "Cleanup complete!"

.PHONY: remove
remove: clean
	@$(rm) $(BINDIR)/$(TARGET)
	@echo "Executable removed!"
