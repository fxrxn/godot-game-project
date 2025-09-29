shader_type canvas_item;

uniform float intensity : hint_range(0.0, 5.0) = 0.0;
uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
    vec2 uv = SCREEN_UV;

    // Chromatic offset distance
    float offset = intensity / 500.0;

    // Sample individual RGB channels at slightly different positions
    float r = texture(screen_texture, uv + vec2(offset, 0.0)).r;
    float g = texture(screen_texture, uv).g;
    float b = texture(screen_texture, uv - vec2(offset, 0.0)).b;

    COLOR = vec4(r, g, b, 1.0);
}
