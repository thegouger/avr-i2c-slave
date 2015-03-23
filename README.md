# AVR I2C Slave Library

This library provides interrupt-based I2C slave functionality for Atmel 8-bit microcontrollers equipped with a TWI peripheral. 

It is somewhat based on an existing library found here: https://github.com/devthrash/I2C-slave-lib

Files
-----
* `I2CSlave.c` -- Implements init/stop, and interrupt-based receive and request logic
* `I2CSlave.h` -- Function prototypes and a convience method for transmitting data

Usage
-----
**Provide callbacks for receiving and handling requests in your application code.**
eg:
```c
void I2C_received(uint8_t data);
void I2C_requested();

I2C_setCallbacks(I2C_received, I2C_requested);
```

The library calls the received callback *for each byte* the master transmits to the slave.
The library calls the requested callback *for each byte* the master attempts to read from the slave.

**Init the I2C slave with the slave address**
```c
I2C_init(I2C_ADDRESS);
```

**Transmitting data to the master when requested**
```c
I2C_transmitByte(data);
```

Example
-------

The example in `main.c` implements a sample application in which the slave can receive a byte, 
and then will echo the byte when requested.

To compile:
`make`
