uniform lowp sampler2D texture_sampler;
uniform lowp vec4 tint;
uniform mediump float time; // Pass a time-based variable to the shader

varying mediump vec2 var_texcoord0;

// Function to create a diamond reflection effect
lowp vec4 diamond(mediump vec2 uv) {
    mediump float frequency = 30.0; // Adjust frequency for the diamond pattern
    mediump float reflectionX = abs(sin(uv.x * frequency));
    mediump float reflectionY = abs(sin(uv.y * frequency));
    mediump float reflection = reflectionX * reflectionY;
    return vec4(vec3(reflection), 1.0);
}

void main() {
    // Get the original sprite color
    lowp vec4 spriteColor = texture2D(texture_sampler, var_texcoord0.xy);

    // Generate the diamond reflection color
    lowp vec4 diamond = diamond(var_texcoord0.xy);

    // Blend the diamond reflection color with the sprite color using alpha for semi-transparency
    mediump float alpha = 0.77; // Adjust alpha for desired transparency
    gl_FragColor = mix(spriteColor, diamond, alpha) * alpha;
}