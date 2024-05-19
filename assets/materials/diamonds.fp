uniform lowp sampler2D texture_sampler;
uniform lowp vec4 tint;
uniform mediump float time; // Pass a time-based variable to the shader

varying mediump vec2 var_texcoord0;

// Function to create a diamond reflection effect
lowp vec4 diamond(mediump vec2 uv) {
    mediump float frequency = 15.0; // Adjust frequency for the diamond pattern
    mediump float diagonal1 = abs(sin((uv.x + uv.y) * frequency));
    mediump float diagonal2 = abs(sin((uv.x - uv.y) * frequency));
    mediump float pattern = 1.1 - (diagonal1 * diagonal2); // Use inverted product for light lines and glossy effect
    return vec4(vec3(pattern), pattern * .08 + 0.35); // Adjust alpha to make diamonds glossy and transparent
}

void main() {
    // Get the original sprite color
    lowp vec4 spriteColor = texture2D(texture_sampler, var_texcoord0.xy);

    // Generate the diamond reflection color
    lowp vec4 diamondColor = diamond(var_texcoord0.xy);

    // Blend the diamond reflection color with the sprite color using alpha for semi-transparency
    mediump float alpha = 0.95; // Adjust alpha for desired transparency
    gl_FragColor = mix(spriteColor, diamondColor, diamondColor.a) * alpha;
}
