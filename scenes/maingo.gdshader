shader_type canvas_item;

uniform vec2 focus_uv = vec2(0.5, 0.5); // Normalized screen center
uniform float radius = 0.25;
uniform float softness = 0.2;
uniform float darkness_alpha = 0.7;

void fragment() {
    float dist = distance(UV, focus_uv);
    float vignette = 1.0 - smoothstep(radius, radius + softness, dist);
    float alpha = vignette * darkness_alpha;

    COLOR = vec4(0.0, 0.0, 0.0, alpha);
}
