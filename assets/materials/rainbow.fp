uniform lowp sampler2D texture_sampler;
uniform lowp vec4 tint;
uniform mediump float time; // Pass a time-based variable to the shader

varying mediump vec2 var_texcoord0;

// Function to create a shifting rainbow color
lowp vec4 rainbowColor(mediump vec2 uv, mediump float time) {
    mediump float angle = atan(uv.y - 0.5, uv.x - 0.5) + radians(90.0);
    mediump float distance = length(uv - vec2(0.5, 0.5));
    mediump float frequency = 3.14159265 * 12.0;
    mediump float phase = time * 0.7; // Use time to shift the phase of the color
    mediump float red = cos(frequency * distance + phase + 0.0) * 0.5 + 0.5;
    mediump float green = cos(frequency * distance + phase + 2.0) * 0.5 + 0.5;
    mediump float blue = cos(frequency * distance + phase + 4.0) * 0.5 + 0.5;
    return vec4(red, green, blue, 1.0);
}

void main() {
    // Get the original sprite color
    lowp vec4 spriteColor = texture2D(texture_sampler, var_texcoord0.xy);

    // Generate the shifting rainbow color
    lowp vec4 rainbow = rainbowColor(var_texcoord0.xy, time);

    // Blend the rainbow color with the sprite color using alpha for semi-transparency
    mediump float alpha = 0.5; // Adjust alpha for desired transparency
    gl_FragColor = mix(spriteColor, rainbow, alpha);
}

