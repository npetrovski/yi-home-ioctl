CC=arm-hisiv300-linux-gcc
USER_CFLAGS=-march=armv5te -mcpu=arm926ej-s -I/opt/hisi-linux/x86-arm/arm-hisiv300-linux/target/usr/include -L/opt/hisi-linux/x86-arm/arm-hisiv300-linux/target/usr/lib
USER_LDFLAGS=
AR=arm-hisiv300-linux-ar
RANLIB=arm-hisiv300-linux-ranlib
STRIP=arm-hisiv300-linux-strip
CFLAGS = -Wall -I./src

TARGET = ioctl

SRC_DIR   = src
DIST_DIR   = dist

.PHONY: clean remove

SOURCES  := $(wildcard $(SRC_DIR)/*.c)
INCLUDES := $(wildcard $(SRC_DIR)/*.h)
OBJECTS  := $(SOURCES:$(SRC_DIR)/%.c=$(DIST_DIR)/%.o)
rm       = rm -f

$(DIST_DIR)/$(TARGET): $(OBJECTS)
	$(CC) $(LFLAGS) $(OBJECTS) -o $@
	$(STRIP) $(DIST_DIR)/$(TARGET)
	@echo "Linking complete!"

$(OBJECTS): $(DIST_DIR)/%.o : $(SRC_DIR)/%.c
	@mkdir -p $(DIST_DIR)
	$(CC) $(CFLAGS) -c $< -o $@
	@echo "Compiled "$<" successfully!"

clean:
	@$(rm) $(OBJECTS)
	@echo "Cleanup complete!"


remove: clean
	@$(rm) $(DIST_DIR)/$(TARGET)
	@echo "Executable removed!"
