//--------------------------------------------------------------------
//PROJECT:  SPARKDEV ROBOTICS
//CODE: THIS CODE IS THE LOGIC TO RUN THE MOTORS
//DATE LAST MODIFIED: FEBRUARY 4TH, 2020.
//--------------------------------------------------------------------

#include <AFMotor.h>

//Initialize variables
AF_DCMotor motorR(2); //right motor
AF_DCMotor motorL(3); //left motor
char data = 0;

void setup()
{
  //Set initial speed of the motor & stop
  motorR.setSpeed(250);
  motorL.setSpeed(250);
  motorR.run(RELEASE);
  motorL.run(RELEASE);
}//end void setup

//FUNCTIONS FOR MOTOR MOVEMENTS

void Forward()
{
   motorR.run(FORWARD);
   motorL.run(FORWARD);
}//end forward()

void Backward()
{
  motorR.run(BACKWARD);
  motorL.run(BACKWARD);
}//end backward()

void leftTurn()
{
 motorR.run(FORWARD);
  motorL.run(BACKWARD);
}//end ledtTurn()

void rightTurn()
{
  motorR.run(BACKWARD);
  motorL.run(FORWARD);
}//end rightTurn()

void stopMotors()
{
   motorR.run(RELEASE);
   motorL.run(RELEASE);
}//end stopMotors()

void serialControl(){
    if(Serial.available() > 0)
  {
    data = Serial.read();
    Serial.println(data);


    switch(data){

    case 'a':
    Forward();
    break;
    
    case'c':
    Backward();
    break;
      
    case'd':
    leftTurn();
    break;
    
    case'b':
    rightTurn();
    break;

    case 'e':
   stopMotors();
    break;
    
    default:
   
    break;
    }

  }
}
