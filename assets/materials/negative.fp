uniform lowp sampler2D texture_sampler;
uniform lowp vec4 tint;
uniform mediump float time; // Pass a time-based variable to the shader

varying mediump vec2 var_texcoord0;

// Function to create the negative color effect
lowp vec4 negativeColor(lowp vec4 color) {
    return vec4(1.0 - color.rgb, color.a);
}

void main() {
    // Get the original sprite color
    lowp vec4 spriteColor = texture2D(texture_sampler, var_texcoord0.xy);

    // Generate the negative color
    lowp vec4 negative = negativeColor(spriteColor);

    // Output the negative color multiplied by tint
    gl_FragColor = negative;
}