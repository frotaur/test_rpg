shader_type canvas_item;

uniform vec4 mod_color : source_color= vec4(0.5,0.5,0.,1.);

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);

    // Check if the pixel is within 5 pixels of any border
    float border = 5.0;
    bool isBorder = UV.x < border || UV.x > 1.0 - border || UV.y < border || UV.y > 1.0 - border;

    if (isBorder) {
        // Apply mod_color for non-border pixels
        COLOR = vec4(mod_color.rgb, tex_color.a);
    } else {
        // Keep original color for border pixels
        COLOR = tex_color;
    }
}
