/*
  Projeto Radar com Arduino + Processing
    Código para carregar no Arduino.
  Link do Projeto
 */
#include <Ultrasonic.h>                                // biblioteca do sensor ultrasonico
#include <Servo.h>                                     // biblioteca do servo

#define TRIGGER_PIN  12                                // declara o TRIGGER_PIN do sensor no pino 12
#define ECHO_PIN     13                                // declara o ECHO_PIN do sensor no pino 13

Ultrasonic ultrasonic(TRIGGER_PIN, ECHO_PIN);          // cria uma variavel do tipo Ultrasonic
Servo myservo;                                         // cria uma variavel do tipo Servo

int pos = 15;                                          // inicia o servo na posicao 15
int distance;

void setup() {
  Serial.begin(9600);                                  // inicia o monitor serial
  myservo.attach(11);                                   // declara o servo no pino 9
}

void loop() {
  for(pos=15; pos<=165; pos++){                        // cria um contador de 15 a 165 com a variavel pos
    myservo.write(pos);                                // envia para o servo o valor do contador que tambem esta representando sua posicao
    delay(150);
    long microsec = ultrasonic.timing();               // faz o calculo da distancia em cm e atribui a variavel distance
    distance = ultrasonic.convert(microsec, Ultrasonic::CM);

    Serial.print(pos);                                 // imprime os valores no monitor serial
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
  }

  for(pos=165; pos>=15; pos--){                         // cria um contador de 165 a 15 com a variavel pos
    myservo.write(pos);                                 // envia para o servo o valor do contador que tambem esta representando sua posicao
    delay(150);
    long microsec = ultrasonic.timing();                // faz o calculo da distancia em cm e atribui a variavel distance
    distance = ultrasonic.convert(microsec, Ultrasonic::CM);

    Serial.print(pos);                                  // imprime os valores no monitor serial
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
  }
}
