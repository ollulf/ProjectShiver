shader_type canvas_item;

uniform float amplitude;
uniform float frequency;
uniform float speed;

void vertex() {
	vec4 world_pos = MODEL_MATRIX * vec4(0.0,0.0,0.0,1.0);
    
	float y_strength = 1.0 - UV.y;
	
	float wobble = y_strength * sin(world_pos.x * frequency + (TIME * speed)) * amplitude;
    VERTEX += vec2(10.0,0) * wobble;
}

