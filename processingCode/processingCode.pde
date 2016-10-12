import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;
Serial myPort;
String data = null;
String ang = null;
String dist = null;
String objStatus = null;
String disStatus = null;
int index = 0;
int angulo = 0;
int distance = 0;
int angulo1 = 0;

void setup() {
  size(1920, 1080);
  surface.setResizable(true);
  smooth();
  myPort = new Serial(this,"COM3", 9600);
  myPort.bufferUntil('.');                                              //define um byte específico para o buffer antes de chamar serialEvent () 
} 

void draw() { 
    // cria um retangulo sem borda 'noStroke()' e preenchido de cor preta e opacidade 9 'fill(0,9)'
  noStroke();
  fill(0,9); 
  rect(0, 0, width, height*0.92);
  println(angulo + " " + distance);
  
  drawLine();
  drawObject();
  drawText();
  drawRadar();
 }

void serialEvent (Serial myPort) {                             //função para leitura serial
  data = myPort.readStringUntil('.');                          //le ate a string ate o '.'
  data = data.substring(0,data.length()-1);                    //cria uma substring que retorna uma nova com o que está escrito entre os parâmetros, isso é feito para retirar o '.' da string
  
  index = data.indexOf(",");                                   //retorna o indice da posição da ',' será utilizado como parâmetro na hora de dividir a string data em duas novas strings
  ang= data.substring(0, index);                               //cria uma string que retorna o valor antes da virgula da string original, o valor estava entre o indice 0 e o index que no caso era a virgula
  dist= data.substring(index+1, data.length());                //cria uma string que retorna o valor depois da virgula da string original, o valor estava entre o index que no caso era a virgula e o ultimo indice
  
  angulo = 180 - int(ang);                                     //transforma a string em uma variavel inteiro
  distance = int(dist);                                        //transforma a string em uma variavel inteiro
  angulo1 = 180 - angulo;                                      //ajusta o valor do angulo para ser escrito
}

void drawLine() {
  pushMatrix();                                                // salva o atual sistema de coordenadas
  translate(width/2,height*0.92);                              // define as cordenadas descritas como origem das figuras            
  strokeWeight(7);                                             // tamanho da borda
  stroke(0,255,0);                                             // cor da borda
  line(0,0,-width*0.425*cos(radians(angulo)),-width*0.425*sin(radians(angulo)));
  popMatrix();                                                 // restaura o sistema de coordenadas anterior
}

void drawObject() {
  pushMatrix();                                               // salva o atual sistema de coordenadas
  if(distance<50) {                                           // calculo das coordenadas de onde comeca e termina a linha do objeto
    translate(width/2,height*0.92);                           // define as cordenadas descritas como origem das figuras            
    strokeWeight(7);                                          // tamanho da borda
    stroke(255,0,0);                                          // cor da borda
    line(-distance*cos(radians(angulo))*11.8,-distance*sin(radians(angulo))*11.8,-width*0.425*cos(radians(angulo)),-width*0.425*sin(radians(angulo)));
  }
  popMatrix(); 
}

void drawRadar() {
  pushMatrix();                                               // salva o atual sistema de coordenadas
  translate(width/2,height*0.92);                             // define as cordenadas descritas como origem das figuras
  noFill();                                                   // figuras sem preenchimento            
  strokeWeight(2);                                            // tamanho da borda
  stroke(255,255);                                            // cor da borda
  
          // desenho das figuras, arcos e linhas
  arc(0,0,(width*0.85),(width*0.85),PI,TWO_PI);
  arc(0,0,(width*0.68),(width*0.68),PI,TWO_PI);
  arc(0,0,(width*0.51),(width*0.51),PI,TWO_PI);
  arc(0,0,(width*0.34),(width*0.34),PI,TWO_PI);
  arc(0,0,(width*0.17),(width*0.17),PI,TWO_PI);
   
  line(-width/2,0,width,0);
  line(0,0,0,((-width*0.85)/2));
  line(0,0,((-width*0.85)/2)*cos(radians(15)),((-width*0.85)/2)*sin(radians(15)));
  line(0,0,((-width*0.85)/2)*cos(radians(40)),((-width*0.85)/2)*sin(radians(40)));
  line(0,0,((-width*0.85)/2)*cos(radians(65)),((-width*0.85)/2)*sin(radians(65)));
  line(0,0,((-width*0.85)/2)*cos(radians(90)),((-width*0.85)/2)*sin(radians(90)));
  line(0,0,((-width*0.85)/2)*cos(radians(115)),((-width*0.85)/2)*sin(radians(115)));
  line(0,0,((-width*0.85)/2)*cos(radians(140)),((-width*0.85)/2)*sin(radians(140)));
  line(0,0,((-width*0.85)/2)*cos(radians(165)),((-width*0.85)/2)*sin(radians(165)));
  popMatrix();    // restaura o sistema de coordenadas anterior
}

void drawText() {
  if(distance>50) {                                           // atribui um dos dois estados abaixo as variaveis dependendo da distancia
    objStatus = "Out of Range";
    disStatus = " ";
  }
  else {
    objStatus = "In Range";
    disStatus = distance + "cm";
  }
  
  pushMatrix();    
      // desenha a area para escrever o texto
  fill(0,0,0); 
  noStroke();
  rect(0, height*0.92, width, height);
  fill(0,255,0);
  
  textSize(15);
  text("10cm",width*0.42,height*0.91);
  text("20cm",width*0.335,height*0.91);
  text("30cm",width*0.25,height*0.91);
  text("40cm",width*0.165,height*0.91);
  text("50cm",width*0.08,height*0.91);  
  
  textSize(30);
  text("Objeto: " + objStatus, width*0.07, height*0.98);
  text("Ângulo: " + angulo1 +"°", width*0.44, height*0.98);
  text("Distância: " + disStatus, width*0.78, height*0.98);
 
  popMatrix();
}