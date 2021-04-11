#version 450

in vec3 a_Position;
in vec3 a_Velocity;
in float a_EmitTime;

uniform float u_Time;
const vec3 c_Gravity = vec3(0.f, -0.005f, 0.f);

void main()
{
	float newTime = u_Time - a_EmitTime;
	vec3 newPos = a_Position;

	if(newTime < 0.f)
	{
		newPos = vec3(10000, 10000, 10000);
	}
	else
	{
		newPos = a_Position + a_Velocity * newTime + 0.5f * c_Gravity * newTime * newTime;
	}

	gl_Position = vec4(newPos, 1); //OpenGL 고유의 출력값
}
