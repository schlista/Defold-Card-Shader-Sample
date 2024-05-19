uniform lowp sampler2D texture_sampler;

uniform lowp vec4 tint;

uniform mediump vec4 timex; // Pass a time-based variable to the shader

varying mediump vec2 var_texcoord0;

// Function to create a shifting rainbow color
lowp vec4 rainbowColor(mediump vec2 uv, mediump vec4 timex, mediump float frequency) {
    mediump float angle = atan(uv.y - 0.5, uv.x - 0.5) + radians(90.0);
    mediump float distance = length(uv - vec2(0.5, 0.5));
    mediump float phase = timex.x * 0.7; // Use time to shift the phase of the color

    mediump float red = cos(frequency * distance + phase + 0.0) * 0.5 + 0.5;
    mediump float green = cos(frequency * distance + phase + 2.0) * 0.5 + 0.5;
    mediump float blue = cos(frequency * distance + phase + 4.0) * 0.5 + 0.5;

    return vec4(red, green, blue, 1.0);
}

void main() {
    // Calculate the oscillating frequency
    mediump float oscillatingFrequency = 30.0 * (0.85 + 0.15 * sin(timex.x)); // 0.65 + 0.15 * sin(time) oscillates between 0.5 and 0.8

    // Get the original sprite color
    lowp vec4 spriteColor = texture2D(texture_sampler, var_texcoord0.xy);

    // Generate the shifting rainbow color with the oscillating frequency
    lowp vec4 rainbow = rainbowColor(var_texcoord0.xy, timex, oscillatingFrequency);

    // Blend the rainbow color with the sprite color using alpha for semi-transparency
    mediump float alpha = 0.7; // Adjust alpha for desired transparency
    gl_FragColor = mix(spriteColor, rainbow, alpha);
}