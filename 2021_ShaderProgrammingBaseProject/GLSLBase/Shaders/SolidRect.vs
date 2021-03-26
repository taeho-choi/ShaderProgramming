#version 450

in vec3 a_Position;
in vec3 a_Position1;

uniform float u_Scale;

void main()
{
	gl_Position = vec4(a_Position * u_Scale, 1); //OpenGL 고유의 출력값
}
