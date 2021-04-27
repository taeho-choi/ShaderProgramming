#version 450

in vec3 a_Position;
in vec3 a_Velocity;
in float a_EmitTime;
in float a_LifeTime;
in float a_P;
in float a_A;
in float a_RandValue;
in vec4 a_Color;

uniform float u_Time;
uniform vec3 u_ExForce;

//const vec3 c_Gravity = vec3(0.f, -1.f, 0.f);
const vec3 c_Gravity = vec3(0.f, -0.8f, 0.f);
const float PI = 3.14f;
const mat3 c_NV = mat3(0, -1 , 0, 1, 0, 0, 0, 0, 0);

out vec4 v_Color;

void main()
{
	float newTime = u_Time - a_EmitTime;

	//vec3 newPos = a_Position;
	vec3 newPos;
	newPos.x = (a_Position.x + cos(a_RandValue * 2 * PI)) / 1.1;
	newPos.y = (a_Position.y + sin(a_RandValue * 2 * PI)) / 1.1;

	vec4 color = vec4(0);

	if(newTime < 0.f)
	{
		newPos = vec3(10000, 10000, 10000);
	}
	else
	{
		newTime = mod(newTime, a_LifeTime);
		//newPos = newPos + vec3(newTime, 0, 0);
		//newPos.y = newPos.y + sin(newTime * PI * 2 * a_P) * a_A * newTime * 2.f;

		vec3 newAcc = c_Gravity + u_ExForce;
		vec3 currVel = a_Velocity + newTime * newAcc;
		vec3 normalV = normalize(currVel * c_NV);
		newPos = newPos + a_Velocity * newTime + 0.5f * newAcc * newTime * newTime;
		newPos = newPos + normalV * a_A * sin(newTime * 2 * PI * a_P);

		float intensity = 1.0f - newTime / a_LifeTime;
		color = a_Color * intensity;
	}

	gl_Position = vec4(newPos, 1); //OpenGL 고유의 출력값
	
	if(mod(newTime, 0.00001f) == 0.f)
	{
		v_Color = vec4(1, 1, 1, 1);
	}
	else
	{
		v_Color = color;
	}
}
