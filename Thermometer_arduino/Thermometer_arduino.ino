#include <Adafruit_MLX90614.h>                     // Allow you to refer the Adafruit MLX library
#include <Wire.h>                                  // Allow you to communicate with I2C
int trig = 2;                                      // Trig Pin connected to digital pin 2
int echo = 3;                                      // Echo Pin connected to digital pin 3
int led = 10;                                      // LED Pin connected to digital pin 10

Adafruit_MLX90614 mlx = Adafruit_MLX90614();       // Adafruit MLX library
 
void setup(){                                      // Put your setup code here to run once.
  Serial.begin(9600);                              // Sets the data rate in bits per second (baud) for serial data tranmission.
  pinMode(trig, OUTPUT);                           // Sets up a pin for use as a digital input
  pinMode(echo,INPUT);
  pinMode(led,OUTPUT);
  mlx.begin();
}

void loop(){                                       // Put your main code here for repeatedly run program.
  while(Serial.available()>0){
    uint8_t byteFromSerial = Serial.read();        // trying to read bytes from the serial input, concatenate them into a string, and print the string back to the serial monitor.
    uint8_t buff[100] = {byteFromSerial};
    String str = (char*)buff;
    Serial.print(str);
  }

  long duration, distance;                         // Read a pulse (either High or Low) on a pin
  digitalWrite(trig,LOW);
  delay(10);
  digitalWrite(trig,HIGH);
  delay(10);
  digitalWrite(trig,LOW);
  duration = pulseIn(echo,HIGH);                   // if value is HIGH, pulseIn() waits for the pin to HIGH, starts timing
  distance = (duration/2)/29.1;

  if (distance >= 100){                            // Define LED function to detect distance between users
    digitalWrite(led,HIGH);
    delay(1000);
  }
  else {
    digitalWrite(led,LOW);
  }

  Serial.print(mlx.readObjectTempC());            // Display the user temperature
  Serial.println();
  delay(1000);
}
