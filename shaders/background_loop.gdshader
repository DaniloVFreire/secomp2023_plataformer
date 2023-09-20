shader_type canvas_item;
const float move_speed = 0.1;
void fragment() {
	vec2 pos = UV;
	pos.y = pos.y + TIME * move_speed;
	COLOR = texture(TEXTURE, pos);
}
