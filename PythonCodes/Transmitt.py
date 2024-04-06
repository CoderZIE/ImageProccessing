import serial

# Define the COM port and baudrate
COM_PORT = 'COM10'
BAUD_RATE = 230400  # Adjust according to your device settings

# Create a serial object
ser = serial.Serial(COM_PORT, BAUD_RATE)

try:
    # Set timeout to 5 seconds
    ser.timeout = 5
    
    # Read data from the COM port
    data = ser.read(1)  # Read only 1 byte
    
    if data:
        # Convert byte to integer
        received_value = int.from_bytes(data, byteorder='big')
        
        # Process the received data
        print("Received:", received_value)
        
        # Check if the received value is between 0 and 255
        if 0 <= received_value <= 255:
            print("Valid value received.")
        else:
            print("Invalid value received.")
            ser.close()  # Close the serial port

    else:
        print("No data received within the timeout period.")

except serial.SerialException as e:
    print("Serial Exception:", e)

finally:
    # Close the serial port if it's still open
    if ser.is_open:
        ser.close()
