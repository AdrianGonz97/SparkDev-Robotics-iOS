//--------------------------------------------------------------------
//PROJECT:  SPARKDEV ROBOTICS
//CODE: THIS CODE IS THE LOGIC BETWEEN THE MOBILE AND THE ROBOT
//DATE LAST MODIFIED: FEBRUARY 4TH, 2020.
//--------------------------------------------------------------------


//Initialize global variables
char data = 0;

void setup() 
{
  Serial.begin(115200);  //initial the Serial

  //Set pin mode. NB This may change
  pinMode(13, OUTPUT);
  pinMode(7, OUTPUT);
}//end setup()


void loop() 
{
  if (Serial.available())  
  {
    data = Serial.read();
    
    Serial.println(data);//send what has been received
    
    Serial.println();   //print line feed character

    if(data == 'a') //Move forward
    {
      //Motor function would be called here
      digitalWrite(13, HIGH);
      digitalWrite(7, LOW);
    }//end if forward

    if (data == 'b')//Turn left
    {
      //Motor function would be called here
      
    }//end if left turn
    
    if(data == 'c') // Move backwards
    {
      //Motor function would be called here
      digitalWrite(13, HIGH);
      digitalWrite(8, LOW);
    }//end if backwards

    if (data == 'd') //Turn Right
    {
      //Motor function would be called here
      
    }//end if right turn

    else //Stop
    {
      //Motor function would be called here
      
    }//end else
    
  }//end if available
  
}//end void loop
