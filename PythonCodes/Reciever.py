import serial

# Configure UART port
uart_port = serial.Serial('COM10', 230400)  # Change COM10 to your UART port and baud rate accordingly

# Function to send pixel data through UART
def send_pixel(pixel):
    uart_port.write(bytes([pixel]))  # Convert pixel to a byte and send it

# Send specific pixel values
send_pixel(7)


# Close UART port
uart_port.close()
