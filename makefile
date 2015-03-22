DEVICE = atmega168
MCU    = atmega168
F_CPU  = 8000000
TARGET = slave

CC      = avr-gcc 
OBJCOPY = avr-objcopy 

INCLUDES = -I./ -I/usr/lib/avr/include 
CFLAGS   = -std=c99 -g -Wall -mmcu=$(MCU) -DF_CPU=$(F_CPU) $(INCLUDES) -Os 
LDFLAGS  = -Wl,-gc-sections -Wl,-relax 

OBJECT_FILES = main.o I2CSlave.o

all: $(TARGET).hex size

size:
	@if [ -f $(TARGET).obj ]; then avr-size -C --mcu=$(MCU) $(TARGET).obj; fi

clean: 
	rm -rf *.o *.hex *.obj

%.hex: %.obj 
	$(OBJCOPY) -R .eeprom -O ihex $< $@ 

%.obj: $(OBJECT_FILES)
	$(CC) $(CFLAGS) $(OBJECT_FILES) $(LDFLAGS) -o $@ 
